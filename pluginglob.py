"""Add GlobalVariable (GLOB) records to a plugin by cloning an existing one.

    python pluginglob.py <plugin> --clone <EditorID> --add <NewEditorID>=<value> [--add ...] [--write]

The new records are copies of the cloned GLOB - same flags, same FNAM type, same group -
with a new EditorID, a new FormID (one past the highest FormID the plugin owns) and the
given value. They go at the end of the plugin's top-level GLOB group; the group size, the
TES4 record count and the next-object-id in HEDR are updated. Nothing else in the file
moves except the bytes after the GLOB group, which are shifted whole.

Without --write this only reports what it would do. Check the result with plugindiff.py:
the record count goes up by the number added and nothing else changes.

Why: the Creation Kit is the normal way to add a global, but it is a GUI, and a GLOB is
three subrecords. A CK resave afterwards keeps these records.
"""

import os
import struct
import sys

RECORD_HEADER = struct.Struct("<4sIIIIHH")
GROUP_HEADER = struct.Struct("<4sI4sIIHH")
SUB_HEADER = struct.Struct("<4sH")


def subrecords(data):
    off = 0
    while off + SUB_HEADER.size <= len(data):
        sig, size = SUB_HEADER.unpack_from(data, off)
        off += SUB_HEADER.size
        yield sig, off, size
        off += size


def find_top_groups(raw):
    tes4 = RECORD_HEADER.unpack_from(raw, 0)
    offset = RECORD_HEADER.size + tes4[1]
    groups = []
    while offset + GROUP_HEADER.size <= len(raw):
        sig, size, label, gtype, _, _, _ = GROUP_HEADER.unpack_from(raw, offset)
        if sig != b"GRUP":
            raise SystemExit("expected GRUP at 0x%X" % offset)
        groups.append((offset, size, label, gtype))
        offset += size
    return tes4, groups


def walk_records(raw, start, end, out):
    offset = start
    while offset + RECORD_HEADER.size <= end:
        sig = raw[offset:offset + 4]
        if sig == b"GRUP":
            size, = struct.unpack_from("<I", raw, offset + 4)
            walk_records(raw, offset + GROUP_HEADER.size, offset + size, out)
            offset += size
        else:
            header = RECORD_HEADER.unpack_from(raw, offset)
            out.append((offset, header))
            offset += RECORD_HEADER.size + header[1]


def main():
    args = sys.argv[1:]
    if not args:
        print(__doc__)
        return 2
    path = args[0]
    clone = None
    adds = []
    write = False
    i = 1
    while i < len(args):
        if args[i] == "--clone":
            clone = args[i + 1]; i += 2
        elif args[i] == "--add":
            name, value = args[i + 1].split("=", 1)
            adds.append((name, float(value))); i += 2
        elif args[i] == "--write":
            write = True; i += 1
        else:
            print(__doc__); return 2
    if not clone or not adds:
        print(__doc__)
        return 2

    raw = bytearray(open(path, "rb").read())
    tes4, groups = find_top_groups(raw)
    glob_group = next((g for g in groups if g[2] == b"GLOB"), None)
    if glob_group is None:
        raise SystemExit("no GLOB group in " + path)
    g_off, g_size, _, _ = glob_group

    # highest FormID the plugin itself owns
    records = []
    walk_records(raw, RECORD_HEADER.size + tes4[1], len(raw), records)
    masters = sum(1 for sig, off, size in subrecords(raw[RECORD_HEADER.size:RECORD_HEADER.size + tes4[1]]) if sig == b"MAST")
    own = [h[3] & 0xFFFFFF for off, h in records if (h[3] >> 24) == masters]
    next_id = max(own) + 1
    existing_edids = set()
    source = None
    for off, header in records:
        if header[0] != b"GLOB":
            continue
        data = raw[off + RECORD_HEADER.size:off + RECORD_HEADER.size + header[1]]
        for sig, soff, size in subrecords(data):
            if sig == b"EDID":
                edid = data[soff:soff + size].rstrip(b"\x00").decode("cp1252")
                existing_edids.add(edid)
                if edid == clone:
                    source = (off, header, bytes(data))
    if source is None:
        raise SystemExit("GLOB %s not found" % clone)
    for name, _ in adds:
        if name in existing_edids:
            raise SystemExit("%s already exists" % name)

    off, header, data = source
    print("cloning %s (%08X, flags %08X, %d bytes): %s" % (
        clone, header[3], header[2], len(data),
        " ".join("%s[%d]" % (sig.decode(), size) for sig, _, size in subrecords(data))))

    new_records = b""
    for name, value in adds:
        body = b""
        for sig, soff, size in subrecords(data):
            payload = data[soff:soff + size]
            if sig == b"EDID":
                payload = name.encode("cp1252") + b"\x00"
            elif sig == b"FLTV":
                payload = struct.pack("<f", value)
            body += SUB_HEADER.pack(sig, len(payload)) + payload
        formid = (masters << 24) | next_id
        new_header = RECORD_HEADER.pack(b"GLOB", len(body), header[2], formid, header[4], header[5], header[6])
        print("  + %s = %g as %08X" % (name, value, formid))
        new_records += new_header + body
        next_id += 1

    if not write:
        print("dry run; pass --write to apply")
        return 0

    insert_at = g_off + g_size
    raw[insert_at:insert_at] = new_records
    # GLOB group size
    struct.pack_into("<I", raw, g_off + 4, g_size + len(new_records))
    # HEDR: record count and next object id
    tes4_data_start = RECORD_HEADER.size
    for sig, soff, size in subrecords(raw[tes4_data_start:tes4_data_start + tes4[1]]):
        if sig == b"HEDR":
            version, count, nextobj = struct.unpack_from("<fII", raw, tes4_data_start + soff)
            struct.pack_into("<fII", raw, tes4_data_start + soff, version, count + len(adds), max(nextobj, next_id))
            print("HEDR records %d -> %d, next object id %08X -> %08X" % (count, count + len(adds), nextobj, max(nextobj, next_id)))
    backup = path + ".before-pluginglob"
    if not os.path.exists(backup):
        os.rename(path, backup)
    with open(path, "wb") as f:
        f.write(raw)
    print("written %s (backup at %s)" % (path, backup))
    return 0


if __name__ == "__main__":
    sys.exit(main())
