"""Cross-check a release manifest against the files actually in the project directory.

Usage:
    python manifestcheck.py <manifest file> <mod name> [filename prefixes to ignore...]
"""

import os
import sys

from buildcommon import normalize, project_path, read_manifest


def parse_manifest(manifest_file):
    """Report manifest entries that have no matching file in the project directory."""
    all_files_present = True
    for entry in read_manifest(manifest_file):
        if not os.path.isfile(project_path(entry)):
            print("    " + entry + " was not found in the project directory.")
            all_files_present = False

    if all_files_present:
        print("    OK - All files in manifest found.")


def parse_dir(dir_to_check, manifest_text, ignored_prefixes):
    """Report files in a project directory that the manifest does not list."""
    full_path = project_path(dir_to_check)
    if not os.path.isdir(full_path):
        print("    OK - Skipping " + dir_to_check)
        return

    all_files_present = True
    for name in sorted(os.listdir(full_path)):
        if not os.path.isfile(os.path.join(full_path, name)):
            continue
        if name in manifest_text:
            continue
        if any(name.startswith(prefix) for prefix in ignored_prefixes):
            continue

        print("    WARN - " + dir_to_check + ": " + name + " found in project directory, but not in manifest file!")
        all_files_present = False

    if all_files_present:
        print("    OK - " + dir_to_check)


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return 1

    manifest_file = project_path(normalize(sys.argv[1]))
    mod_name = sys.argv[2]
    ignored_prefixes = sys.argv[3:]

    if not os.path.isfile(manifest_file):
        print("Manifest not found: " + manifest_file)
        return 1

    with open(manifest_file) as manifest:
        manifest_text = manifest.read()

    print("===============================================================")
    print("  Checking " + mod_name + " project files...")
    print("===============================================================")
    print("  Parsing manifest...")
    parse_manifest(manifest_file)
    print("  Parsing project directories...")

    directories = [
        "readmes",
        os.path.join("Interface", mod_name),
        os.path.join("Interface", "exported", "widgets", mod_name),
        os.path.join("Interface", "Translations"),
        os.path.join("meshes", mod_name),
        os.path.join("textures", mod_name),
        "Scripts",
        os.path.join("Scripts", "Source"),
        "SEQ",
        os.path.join("sound", "fx", mod_name),
    ]
    for directory in directories:
        parse_dir(directory, manifest_text, ignored_prefixes)

    return 0


if __name__ == "__main__":
    sys.exit(main())
