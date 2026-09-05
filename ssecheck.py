"""Verify that a checkout is in Skyrim Special Edition format before it is packaged.

Special Edition will happily load a Legendary Edition plugin or mesh, so an LE-format
release does not fail loudly - it fails in game, later, on somebody else's save. The two
conversions that have to happen outside this repository are easy to forget:

  * Plugins have to be resaved in the Special Edition Creation Kit. That rewrites the
    TES4 header version from 1.7 to 1.71 and the record form version from 0 to 43/44, and
    - (corrected 2026-09-05: header/form version are NOT LE markers; the check now reads
      the NAVM NVNM version, which is 12 in vanilla SSE and in these plugins already)
    - the reason it was believed to matter - rewriting NAVI/NAVM navmesh data into the SE
    layout. Campfire.esm and Frostfall.esp both carry a NAVI group.
  * Meshes have to be converted to the Special Edition NIF format. Special Edition NIFs
    are BSTriShape based and carry NIF user version 2 = 100; Legendary Edition NIFs carry
    83. The release builders do this to the staged copies with external/SkyrimSE/nifopt.exe
    so that meshes/ can stay in Legendary Edition format and one source tree still builds
    both runtimes, which is why mesh findings here are informational.

The plugin conversion cannot be done from a script, so this module checks that somebody
did it.

Run standalone to audit the checkout:

    python ssecheck.py

The release builders call check_special_edition_assets() and abort on any finding.
"""

import os
import struct
import sys
import zlib

PROJECT_DIR = os.path.dirname(os.path.abspath(__file__))

# TES4 HEDR version and record form version are INFORMATIONAL ONLY. They are not LE/SSE
# markers: measured 2026-09-05, Bethesda's own Dragonborn.esm is 169,776 form-43 records
# to 8,939 form-44, and the Creation Club plugin ccQDRSSE001-SurvivalMode.esl ships HEDR
# 1.70. The Special Edition Creation Kit writes 1.71 / 44, but a plugin that says 1.70 / 43
# is not thereby broken. The one plugin-level thing that can differ between the editions is
# navmesh, which is why the check below reads the NVNM version instead.
LE_HEADER_VERSION = 1.70
LE_FORM_VERSION = 43
SE_HEADER_VERSION = 1.71
SE_FORM_VERSION = 44
HEADER_VERSION_TOLERANCE = 0.001

# NAVM records carry an NVNM subrecord whose first uint32 is a version. Vanilla Special
# Edition Skyrim.esm / Dawnguard.esm / Dragonborn.esm all write 12, and so does every
# navmesh-carrying plugin in the working D:\Mosais build (BSHeartland, LotD, Requiem ...).
# A different value would be the only real reason to resave in the Creation Kit.
SE_NVNM_VERSION = 12

# How many individual mesh paths to print before collapsing the rest into a count. The
# whole meshes/ tree is normally converted in one pass, so the full list is just noise.
MESH_EXAMPLES = 5

# NIF header "user version 2". Legendary Edition meshes are 83, Special Edition 100.
LE_NIF_USER_VERSION_2 = 83
SE_NIF_USER_VERSION_2 = 100

# _Camp_IsSpecialEdition is the fallback signal the compatibility scripts read to identify
# the runtime when SKSE is not installed. The Special Edition build has to ship it set to
# 2; see Scripts/Source/_Camp_Compatibility.psc, DetectGameRuntime().
SPECIAL_EDITION_GLOBAL = "_Camp_IsSpecialEdition"
SPECIAL_EDITION_GLOBAL_VALUE = 2.0

PLUGINS = ("Campfire.esm", "Campfire.esp", "Frostfall.esp", "LastSeed.esp")
MESH_DIRS = ("meshes",)

_RECORD_HEADER = struct.Struct("<4sIIIIHH")
_GROUP_HEADER = struct.Struct("<4sI4sIHHHH")
_SUBRECORD_HEADER = struct.Struct("<4sH")

_COMPRESSED = 0x00040000
_FLAG_ESM = 0x00000001


class PluginError(Exception):
    """The plugin could not be parsed far enough to answer the question asked."""


def _read(path):
    with open(path, "rb") as plugin:
        return plugin.read()


def _subrecords(data):
    """Yield (signature, payload) for each subrecord in a record's data block."""
    offset = 0
    while offset + _SUBRECORD_HEADER.size <= len(data):
        signature, size = _SUBRECORD_HEADER.unpack_from(data, offset)
        offset += _SUBRECORD_HEADER.size
        yield signature, data[offset:offset + size]
        offset += size


def _record_data(raw, offset, header):
    """The data block of a record, decompressed if the record is compressed."""
    _signature, size, flags, _form_id, _vc, _form_version, _unknown = header
    start = offset + _RECORD_HEADER.size
    data = raw[start:start + size]
    if flags & _COMPRESSED:
        # A compressed record stores the uncompressed length in the first four bytes.
        data = zlib.decompress(data[4:])
    return data


def read_plugin_header(path):
    """Return (hedr_version, record_form_version) for a plugin's TES4 record."""
    raw = _read(path)
    if len(raw) < _RECORD_HEADER.size:
        raise PluginError("%s is too short to contain a TES4 record." % path)

    header = _RECORD_HEADER.unpack_from(raw, 0)
    if header[0] != b"TES4":
        raise PluginError("%s does not start with a TES4 record." % path)

    form_version = header[5]
    for signature, payload in _subrecords(_record_data(raw, 0, header)):
        if signature == b"HEDR":
            return struct.unpack_from("<f", payload, 0)[0], form_version

    raise PluginError("%s has a TES4 record with no HEDR subrecord." % path)


def read_globals(path):
    """Return {editor id: value} for every GLOB record in a plugin."""
    raw = _read(path)
    header = _RECORD_HEADER.unpack_from(raw, 0)
    offset = _RECORD_HEADER.size + header[1]

    globals_found = {}
    while offset + _GROUP_HEADER.size <= len(raw):
        group = _GROUP_HEADER.unpack_from(raw, offset)
        if group[0] != b"GRUP":
            raise PluginError("%s: expected a GRUP at offset %d." % (path, offset))

        group_size, label = group[1], group[2]
        if label == b"GLOB":
            end = offset + group_size
            cursor = offset + _GROUP_HEADER.size
            while cursor + _RECORD_HEADER.size <= end:
                record = _RECORD_HEADER.unpack_from(raw, cursor)
                if record[0] == b"GLOB":
                    editor_id, value = None, None
                    for signature, payload in _subrecords(_record_data(raw, cursor, record)):
                        if signature == b"EDID":
                            editor_id = payload.rstrip(b"\x00").decode("cp1252")
                        elif signature == b"FLTV":
                            value = struct.unpack_from("<f", payload, 0)[0]
                    if editor_id is not None:
                        globals_found[editor_id] = value
                cursor += _RECORD_HEADER.size + record[1]
            return globals_found

        offset += group_size

    return globals_found


def set_global_value(path, editor_id, value):
    """Set a GLOB record's value in place. Returns the previous value, or None.

    The value lives in a fixed-width FLTV subrecord, so this rewrites four bytes and
    changes nothing else about the plugin - no record sizes, no offsets, no form IDs.
    It is used on the copy the release builder has already staged, so that the source
    plugin can stay a single dual-runtime file.
    """
    raw = bytearray(open(path, "rb").read())
    header = _RECORD_HEADER.unpack_from(bytes(raw), 0)
    offset = _RECORD_HEADER.size + header[1]

    while offset + _GROUP_HEADER.size <= len(raw):
        group = _GROUP_HEADER.unpack_from(bytes(raw), offset)
        if group[0] != b"GRUP":
            raise PluginError("%s: expected a GRUP at offset %d." % (path, offset))

        group_size, label = group[1], group[2]
        if label == b"GLOB":
            end = offset + group_size
            cursor = offset + _GROUP_HEADER.size
            while cursor + _RECORD_HEADER.size <= end:
                record = _RECORD_HEADER.unpack_from(bytes(raw), cursor)
                if record[0] == b"GLOB" and not record[2] & _COMPRESSED:
                    data_start = cursor + _RECORD_HEADER.size
                    data = bytes(raw[data_start:data_start + record[1]])
                    name, fltv_at = None, None
                    position = 0
                    for signature, payload in _subrecords(data):
                        position += _SUBRECORD_HEADER.size
                        if signature == b"EDID":
                            name = payload.rstrip(b"\x00").decode("cp1252")
                        elif signature == b"FLTV":
                            fltv_at = data_start + position
                        position += len(payload)

                    if name == editor_id and fltv_at is not None:
                        previous = struct.unpack_from("<f", bytes(raw), fltv_at)[0]
                        struct.pack_into("<f", raw, fltv_at, value)
                        with open(path, "wb") as plugin:
                            plugin.write(raw)
                        return previous
                cursor += _RECORD_HEADER.size + record[1]
            break

        offset += group_size

    return None


def stamp_special_edition(path):
    """Mark a staged copy of Campfire as the Special Edition build."""
    return set_global_value(path, SPECIAL_EDITION_GLOBAL, SPECIAL_EDITION_GLOBAL_VALUE)


def read_nif_user_version_2(path):
    """Return the NIF header's "user version 2", or None if the file is not a NIF."""
    with open(path, "rb") as mesh:
        head = mesh.read(64)

    newline = head.find(b"\n")
    if newline == -1 or not head.startswith(b"Gamebryo") and not head.startswith(b"NetImmerse"):
        return None

    # version (4), endianness (1), user version (4), block count (4), user version 2 (4)
    offset = newline + 1
    if len(head) < offset + 17:
        return None
    return struct.unpack_from("<I", head, offset + 13)[0]


def _iter_meshes():
    for mesh_dir in MESH_DIRS:
        root = os.path.join(PROJECT_DIR, mesh_dir)
        if not os.path.isdir(root):
            continue
        for dirpath, _dirnames, filenames in os.walk(root):
            for filename in filenames:
                if filename.lower().endswith(".nif"):
                    yield os.path.join(dirpath, filename)


def _nvnm_versions(raw):
    """Counter of the NVNM version field across every NAVM record in a plugin."""
    versions = {}
    header = _RECORD_HEADER.unpack_from(raw, 0)
    stack = [(_RECORD_HEADER.size + header[1], len(raw))]
    while stack:
        offset, end = stack.pop()
        while offset + _RECORD_HEADER.size <= end:
            rec = _RECORD_HEADER.unpack_from(raw, offset)
            if rec[0] == b"GRUP":
                size = rec[1]
                if size < _RECORD_HEADER.size:
                    break
                stack.append((offset + size, end))
                stack.append((offset + _RECORD_HEADER.size, offset + size))
                break
            if rec[0] == b"NAVM":
                for signature, payload in _subrecords(_record_data(raw, offset, rec)):
                    if signature == b"NVNM" and len(payload) >= 4:
                        v = struct.unpack_from("<I", payload, 0)[0]
                        versions[v] = versions.get(v, 0) + 1
                        break
            offset += _RECORD_HEADER.size + rec[1]
    return versions


def find_legendary_edition_plugins():
    """Plugins whose navmesh is not in the Special Edition format.

    Header and form version are reported but never fail the check - they are not LE
    markers (see the note by SE_NVNM_VERSION). Only a NAVM whose NVNM version differs
    from vanilla Special Edition's is a real reason to resave in the Creation Kit.
    """
    stale = []
    for name in PLUGINS:
        path = os.path.join(PROJECT_DIR, name)
        if not os.path.isfile(path):
            continue
        version, form_version = read_plugin_header(path)
        versions = _nvnm_versions(_read(path))
        bad = {v: n for v, n in versions.items() if v != SE_NVNM_VERSION}
        if bad:
            stale.append(
                "%s: %d NAVM record(s) with NVNM version %s (Special Edition writes %d). "
                "Resave it in the Special Edition Creation Kit."
                % (name, sum(bad.values()), sorted(bad), SE_NVNM_VERSION)
            )
        else:
            print(
                "    %-14s HEDR %.2f, form %d, NAVM %d (NVNM %s) - fine; header/form "
                "version are informational, not LE markers."
                % (name, version, form_version, sum(versions.values()),
                   sorted(versions) if versions else "none")
            )
    return stale


def find_legendary_edition_meshes():
    """Meshes that still carry the Legendary Edition NIF user version.

    Reported as one finding plus a few examples rather than one finding per file; the
    whole tree is converted in a single SSE NIF Optimizer pass anyway.
    """
    stale = []
    for path in sorted(_iter_meshes()):
        user_version_2 = read_nif_user_version_2(path)
        if user_version_2 is not None and user_version_2 != SE_NIF_USER_VERSION_2:
            stale.append(os.path.relpath(path, PROJECT_DIR))

    if not stale:
        return []

    lines = [
        "%d mesh(es) carry NIF user version 2 = %d rather than %d. The release builders "
        "convert the staged copies, so this is informational; convert the source tree only "
        "if you are dropping Legendary Edition support "
        "(external\\SkyrimSE\\nifopt.exe meshes)."
        % (len(stale), LE_NIF_USER_VERSION_2, SE_NIF_USER_VERSION_2)
    ]
    lines.extend("        " + path for path in stale[:MESH_EXAMPLES])
    if len(stale) > MESH_EXAMPLES:
        lines.append("        ... and %d more" % (len(stale) - MESH_EXAMPLES))
    return ["\n".join(lines)]


def find_master_flag_problems():
    """Check that a plugin named .esm actually carries the ESM flag.

    Skyrim loads a .esm in the master block on the extension alone, so a plugin without
    the flag still works in game, but the Creation Kit and xEdit both go by the flag.
    Campfire.esm is mastered by Frostfall.esp and Last Seed, which is exactly the case
    where the two disagreeing matters.
    """
    problems = []
    for name in PLUGINS:
        path = os.path.join(PROJECT_DIR, name)
        if not os.path.isfile(path) or not name.lower().endswith(".esm"):
            continue

        with open(path, "rb") as plugin:
            flags = _RECORD_HEADER.unpack_from(plugin.read(_RECORD_HEADER.size), 0)[2]

        if not flags & _FLAG_ESM:
            problems.append(
                "%s: the ESM flag is not set on its TES4 record (flags 0x%08X). Set it in "
                "the Creation Kit, or confirm in SSEEdit that this is deliberate." % (name, flags)
            )
    return problems


def find_runtime_global_problems():
    """Check that _Camp_IsSpecialEdition is set for the Special Edition build."""
    problems = []
    path = os.path.join(PROJECT_DIR, "Campfire.esm")
    if not os.path.isfile(path):
        return problems

    value = read_globals(path).get(SPECIAL_EDITION_GLOBAL)
    if value is None:
        problems.append(
            "Campfire.esm: %s is missing. The compatibility scripts read it to identify "
            "the runtime when SKSE is not installed." % SPECIAL_EDITION_GLOBAL
        )
    elif abs(value - SPECIAL_EDITION_GLOBAL_VALUE) > HEADER_VERSION_TOLERANCE:
        problems.append(
            "Campfire.esm: %s is %.1f in the source tree. That is correct - the value has "
            "to differ per runtime, so the Special Edition builder stamps 2.0 into the "
            "staged copy. Informational only."
            % (SPECIAL_EDITION_GLOBAL, value)
        )
    return problems


def check_special_edition_plugins():
    """Problems the release builders cannot fix for you.

    Meshes and _Camp_IsSpecialEdition are deliberately not included: the builders convert
    the staged meshes with nifopt and stamp the global into the staged plugin, so the
    source tree stays in one dual-runtime state.
    """
    return find_legendary_edition_plugins() + find_master_flag_problems()


def check_special_edition_assets():
    """Every reason this checkout is not ready to ship as a Special Edition release."""
    return check_special_edition_plugins() + find_legendary_edition_meshes()


def main():
    problems = check_special_edition_assets()
    if not problems:
        print("Special Edition asset check passed.")
        return 0

    print(
        "Note: the release builders convert staged meshes with nifopt, so mesh findings "
        "below do not block a build.\n"
    )

    print("Special Edition asset check found %d problem(s):" % len(problems))
    for problem in problems:
        print("    " + problem)
    return 1


if __name__ == "__main__":
    sys.exit(main())
