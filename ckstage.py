"""Stage this checkout into the Special Edition game folder for Creation Kit work, and
take it back out again.

The Creation Kit only sees plugins in the game's own Data folder, and it silently drops
script properties whose .pex it cannot resolve - so the compiled scripts have to go in
alongside the plugins, not just the plugins. Deployment is otherwise MO2's job; this is
strictly a temporary authoring staging area, which is why "unstage" removes exactly what
"stage" put there and nothing else.

    python ckstage.py stage      copy plugins + Scripts\\*.pex into the game Data folder
    python ckstage.py collect    copy the resaved plugins back into this checkout
    python ckstage.py unstage    delete everything stage put there

`collect` refuses to overwrite anything until plugindiff.py says no records or script data
were lost.

Set SKYRIMSE_PATH to override the game folder.
"""

import os
import shutil
import subprocess
import sys

PROJECT_DIR = os.path.dirname(os.path.abspath(__file__))

DEFAULT_GAME_PATH = r"D:\SteamLibrary\steamapps\common\Skyrim Special Edition"
GAME_PATH = os.environ.get("SKYRIMSE_PATH", DEFAULT_GAME_PATH)
DATA_DIR = os.path.join(GAME_PATH, "Data")

PLUGINS = ("Campfire.esm", "Campfire.esp", "Frostfall.esp", "LastSeed.esp")

# Written by stage, read by unstage, so unstage can never touch a file it did not create.
MANIFEST = os.path.join(PROJECT_DIR, ".ckstage_manifest")


def staged_paths():
    paths = list(PLUGINS)
    script_dir = os.path.join(PROJECT_DIR, "Scripts")
    for name in sorted(os.listdir(script_dir)):
        if name.lower().endswith(".pex"):
            paths.append(os.path.join("Scripts", name))
    return paths


def stage():
    if not os.path.isdir(DATA_DIR):
        sys.exit("Game Data folder not found: %s\nSet SKYRIMSE_PATH." % DATA_DIR)

    # Each manifest line records whether the file was already installed, so unstage can
    # delete what it introduced and put back what it displaced, without guessing.
    written = []
    for relative in staged_paths():
        source = os.path.join(PROJECT_DIR, relative)
        destination = os.path.join(DATA_DIR, relative)
        if not os.path.isfile(source):
            continue

        backup = destination + ".ckstage-backup"
        preexisting = os.path.isfile(destination)
        if preexisting and not os.path.isfile(backup):
            shutil.copyfile(destination, backup)

        os.makedirs(os.path.dirname(destination), exist_ok=True)
        shutil.copyfile(source, destination)
        written.append((preexisting, relative))

    with open(MANIFEST, "w") as manifest:
        manifest.write("\n".join("%d\t%s" % entry for entry in written))

    print("Staged %d file(s) into %s" % (len(written), DATA_DIR))
    print("Open each plugin in the Creation Kit, set it as the active file, and save.")
    print("Then: python ckstage.py collect")


def collect():
    ok = True
    for name in PLUGINS:
        staged = os.path.join(DATA_DIR, name)
        current = os.path.join(PROJECT_DIR, name)
        if not os.path.isfile(staged):
            print("[SKIP] %s is not staged." % name)
            continue

        print("=" * 70)
        print(name)
        print("=" * 70)
        result = subprocess.call([sys.executable, os.path.join(PROJECT_DIR, "plugindiff.py"), current, staged])
        if result != 0:
            print("[REFUSED] %s was not copied back; see the problems above.\n" % name)
            ok = False
            continue

        shutil.copyfile(staged, current)
        print("[OK] %s copied back into the checkout.\n" % name)

    return 0 if ok else 1


def unstage():
    if not os.path.isfile(MANIFEST):
        sys.exit("No staging manifest at %s - nothing to remove." % MANIFEST)

    with open(MANIFEST) as manifest:
        entries = [line.rstrip("\n").split("\t", 1) for line in manifest if line.strip()]

    removed = 0
    restored = 0
    for preexisting, relative in entries:
        path = os.path.join(DATA_DIR, relative)
        backup = path + ".ckstage-backup"
        if preexisting == "1":
            if os.path.isfile(backup):
                shutil.move(backup, path)
                restored += 1
            continue

        if os.path.isfile(backup):
            os.remove(backup)
        if os.path.isfile(path):
            os.remove(path)
            removed += 1

    script_dir = os.path.join(DATA_DIR, "Scripts")
    if os.path.isdir(script_dir) and not os.listdir(script_dir):
        os.rmdir(script_dir)

    os.remove(MANIFEST)
    print("Removed %d staged file(s) from %s" % (removed, DATA_DIR))
    if restored:
        print("Restored %d file(s) that were already installed there." % restored)


def main():
    actions = {"stage": stage, "collect": collect, "unstage": unstage}
    if len(sys.argv) != 2 or sys.argv[1] not in actions:
        print(__doc__)
        return 2
    return actions[sys.argv[1]]() or 0


if __name__ == "__main__":
    sys.exit(main())
