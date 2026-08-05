"""Compare two versions of a plugin at record level.

A Creation Kit resave is not a no-op. It can drop script properties it cannot resolve
(the .pex has to be in Data/Scripts for the CK to read them), renumber nothing but
rewrite everything, and quietly discard records it does not like. Before and after a
resave, this reports what actually changed:

  * record counts per signature
  * how many records carry a VMAD (script) subrecord, and how many bytes of it
  * TES4 header: version, form version, flags, masters

Usage:

    python plugindiff.py <before.esp> <after.esp>

Exit code is 1 if anything that should not change did.
"""

import os
import struct
import sys
from collections import Counter

import ssecheck as S


def _walk(raw, offset, end, records):
    while offset + S._RECORD_HEADER.size <= end:
        signature = raw[offset:offset + 4]
        if signature == b"GRUP":
            size, = struct.unpack_from("<I", raw, offset + 4)
            if size < S._GROUP_HEADER.size:
                return
            _walk(raw, offset + S._GROUP_HEADER.size, offset + size, records)
            offset += size
        else:
            header = S._RECORD_HEADER.unpack_from(raw, offset)
            records.append((signature, offset, header))
            offset += S._RECORD_HEADER.size + header[1]


def summarize(path):
    raw = open(path, "rb").read()
    tes4 = S._RECORD_HEADER.unpack_from(raw, 0)

    version, form_version = S.read_plugin_header(path)
    masters = [p.rstrip(b"\x00").decode("cp1252")
               for sig, p in S._subrecords(S._record_data(raw, 0, tes4)) if sig == b"MAST"]

    records = []
    _walk(raw, S._RECORD_HEADER.size + tes4[1], len(raw), records)

    counts = Counter()
    vmad_records = 0
    vmad_bytes = 0
    for signature, offset, header in records:
        counts[signature.decode("ascii", "replace")] += 1
        try:
            data = S._record_data(raw, offset, header)
        except Exception:
            continue
        for sub_sig, payload in S._subrecords(data):
            if sub_sig == b"VMAD":
                vmad_records += 1
                vmad_bytes += len(payload)

    return {
        "path": path,
        "size": len(raw),
        "hedr_version": version,
        "form_version": form_version,
        "flags": tes4[2],
        "masters": masters,
        "records": len(records),
        "counts": counts,
        "vmad_records": vmad_records,
        "vmad_bytes": vmad_bytes,
    }


def report(before, after):
    problems = []

    print("%-16s %-24s %-24s" % ("", os.path.basename(before["path"]), os.path.basename(after["path"])))
    print("%-16s %-24s %-24s" % ("size", before["size"], after["size"]))
    print("%-16s %-24s %-24s" % ("HEDR version", "%.2f" % before["hedr_version"], "%.2f" % after["hedr_version"]))
    print("%-16s %-24s %-24s" % ("form version", before["form_version"], after["form_version"]))
    print("%-16s %-24s %-24s" % ("flags", "0x%08X" % before["flags"], "0x%08X" % after["flags"]))
    print("%-16s %-24s %-24s" % ("records", before["records"], after["records"]))
    print("%-16s %-24s %-24s" % ("VMAD records", before["vmad_records"], after["vmad_records"]))
    print("%-16s %-24s %-24s" % ("VMAD bytes", before["vmad_bytes"], after["vmad_bytes"]))
    print("%-16s %-24s %-24s" % ("masters", ",".join(before["masters"]), ",".join(after["masters"])))

    if before["masters"] != after["masters"]:
        problems.append("The master list changed.")

    if after["vmad_records"] < before["vmad_records"]:
        problems.append(
            "%d record(s) lost their script data. The Creation Kit could not resolve the "
            "scripts; put the .pex files in Data/Scripts and redo the resave."
            % (before["vmad_records"] - after["vmad_records"])
        )

    signatures = sorted(set(before["counts"]) | set(after["counts"]))
    changed = [(s, before["counts"].get(s, 0), after["counts"].get(s, 0))
               for s in signatures if before["counts"].get(s, 0) != after["counts"].get(s, 0)]
    if changed:
        print("\nrecord counts that changed:")
        for signature, was, now in changed:
            print("    %-6s %5d -> %5d" % (signature, was, now))
            if now < was:
                problems.append("%d %s record(s) disappeared." % (was - now, signature))

    if after["form_version"] != S.SE_FORM_VERSION:
        problems.append("Form version is %d, expected %d." % (after["form_version"], S.SE_FORM_VERSION))

    print()
    if problems:
        print("PROBLEMS:")
        for problem in problems:
            print("    " + problem)
    else:
        print("No records or script data were lost.")
    return problems


def main():
    if len(sys.argv) != 3:
        print(__doc__)
        return 2
    return 1 if report(summarize(sys.argv[1]), summarize(sys.argv[2])) else 0


if __name__ == "__main__":
    sys.exit(main())
