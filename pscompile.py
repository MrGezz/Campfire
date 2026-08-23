"""Compile Papyrus scripts in this checkout with the Special Edition toolchain.

    python pscompile.py <ScriptName> [<ScriptName> ...]
        compile Scripts\\Source\\<ScriptName>.psc into Scripts\\<ScriptName>.pex
    python pscompile.py --stale
        compile every script whose source is newer than its .pex, or edited since its last commit
    python pscompile.py --check
        list those scripts without compiling anything

One .pex serves both runtimes. The Papyrus bytecode format did not change between Legendary
and Special Edition, and the scripts guard every SKSE64-only call behind the runtime detection
in the *_Compatibility scripts, so the compiler is pointed at the Special Edition headers -
SKSE64, SkyUI and PapyrusUtil SE - and the result ships in both BSAs.

Header search order (first match wins):

    external\\SkyrimSE\\Scripts\\Source   PapyrusUtil SE; has to beat the Legendary Edition
                                          copies that Scripts\\Source carries
    Scripts\\Source                       this checkout, CheskoPapyrusShared included
    external\\headers                     compile-only stubs for third-party scripts that
                                          cannot be redistributed (Equipping Overhaul)
    <Lilac>\\Scripts\\Source              Lilac, for the *_test scripts
    .papyrus\\skse64                      SKSE64 headers, rebuilt on every run from
                                          <skse64>\\scripts\\vanilla + modified, the same way
                                          skse64\\scripts\\build.py does it
    <SkyUI-Community>\\source\\scripts    SkyUI SDK
    <game>\\Data\\Source\\Scripts         the vanilla sources the Creation Kit unpacks

SkyUI-Community is looked for next to this checkout; the other reference checkouts default
to the workspace two levels above it.

Environment overrides:
    SKYRIMSE_PATH    game folder (shared with ckstage.py)
    SKSE64_SCRIPTS   the skse64\\scripts directory holding vanilla\\ and modified\\
    SKYUI_SCRIPTS    a directory holding SKI_*.psc
    LILAC_SCRIPTS    a directory holding Lilac.psc
"""

import os
import shutil
import subprocess
import sys
from typing import NoReturn

PROJECT_DIR = os.path.dirname(os.path.abspath(__file__))
WORKSPACE_DIR = os.path.dirname(os.path.dirname(PROJECT_DIR))

DEFAULT_GAME_PATH = r"D:\SteamLibrary\steamapps\common\Skyrim Special Edition"
GAME_PATH = os.environ.get("SKYRIMSE_PATH", DEFAULT_GAME_PATH)

SKSE64_SCRIPTS = os.environ.get("SKSE64_SCRIPTS", os.path.join(WORKSPACE_DIR, "skse64", "scripts"))
# SkyUI-Community is the SkyUI the MCM panels bind to. The older skyui checkout at the
# workspace root is SkyUI 5.1's SDK and predates AddInputOption / SetInputDialogStartText,
# which the config panels use.
SKYUI_SCRIPTS = os.environ.get(
    "SKYUI_SCRIPTS",
    os.path.join(os.path.dirname(PROJECT_DIR), "SkyUI-Community", "source", "scripts"),
)
LILAC_SCRIPTS = os.environ.get("LILAC_SCRIPTS", os.path.join(WORKSPACE_DIR, "Lilac", "Scripts", "Source"))

SOURCE_DIR = os.path.join(PROJECT_DIR, "Scripts", "Source")
OUTPUT_DIR = os.path.join(PROJECT_DIR, "Scripts")
PAPYRUSUTIL_SE_DIR = os.path.join(PROJECT_DIR, "external", "SkyrimSE", "Scripts", "Source")
# Compile-time stubs for third-party scripts the compatibility code binds to (Equipping
# Overhaul) that are not redistributable. Never shipped; see the headers themselves.
STUB_HEADERS_DIR = os.path.join(PROJECT_DIR, "external", "headers")
MERGED_SKSE_DIR = os.path.join(PROJECT_DIR, ".papyrus", "skse64")

FLAGS_FILE = "TESV_Papyrus_Flags.flg"

# Sources that are known not to compile. --check reports them separately instead of as
# stale, so they do not hide real drift.
KNOWN_UNBUILDABLE = {
    "_Frost_HarvestTreeBranchGenerator": "casts to a _Camp_BranchTreeHarvestNodeController that exists "
    "in neither Campfire nor Frostfall; the committed .pex carries the same cast, so rebuilding it "
    "would change nothing - a Frostfall 3.x issue that predates this repository's SE work",
    "_de_epmonitor_1_6": "Frostfall 2.x; the _DE_ scripts reference _DE_SKI_MeterWidget and other "
    "sources that are not in this checkout, ship in no manifest, and are left alone (see README)",
}


def fail(message) -> NoReturn:
    sys.stderr.write("\nERROR: " + message + "\n")
    sys.exit(1)


def compiler_path():
    path = os.path.join(GAME_PATH, "Papyrus Compiler", "PapyrusCompiler.exe")
    if not os.path.isfile(path):
        fail("PapyrusCompiler.exe not found at %s\nSet SKYRIMSE_PATH to the game folder." % path)
    return path


def vanilla_scripts_dir():
    """The vanilla script sources.

    The Special Edition Creation Kit unpacks Data\\Scripts.zip to Data\\Source\\Scripts; the
    Legendary Edition layout was Data\\Scripts\\Source.
    """
    for candidate in (
        os.path.join(GAME_PATH, "Data", "Source", "Scripts"),
        os.path.join(GAME_PATH, "Data", "Scripts", "Source"),
    ):
        if os.path.isfile(os.path.join(candidate, "Game.psc")):
            return candidate
    fail(
        "No vanilla script sources under %s.\n"
        "    Unpack Data\\Scripts.zip with the Creation Kit (Data\\Source\\Scripts)." % GAME_PATH
    )


def merge_skse_headers():
    """Build complete SKSE64 headers from the skse64 checkout.

    skse64\\scripts\\modified\\*.psc hold only the functions SKSE adds, without a Scriptname
    line; skse64\\scripts\\build.py appends each to its vanilla\\ counterpart before
    compiling. The same merge is done here so that the canonical checkout is what the
    compiler sees, rather than a copy of the headers taken from an installed SKSE release.
    """
    vanilla = os.path.join(SKSE64_SCRIPTS, "vanilla")
    modified = os.path.join(SKSE64_SCRIPTS, "modified")
    if not os.path.isdir(modified):
        fail(
            "SKSE64 script sources not found at %s.\n"
            "    Set SKSE64_SCRIPTS to the skse64\\scripts directory." % SKSE64_SCRIPTS
        )

    if os.path.isdir(MERGED_SKSE_DIR):
        shutil.rmtree(MERGED_SKSE_DIR)
    os.makedirs(MERGED_SKSE_DIR)

    merged = set()
    for name in os.listdir(modified):
        if not name.lower().endswith(".psc"):
            continue
        with open(os.path.join(modified, name), "rb") as source:
            additions = source.read()
        vanilla_path = os.path.join(vanilla, name)
        with open(os.path.join(MERGED_SKSE_DIR, name), "wb") as destination:
            if os.path.isfile(vanilla_path):
                with open(vanilla_path, "rb") as source:
                    destination.write(source.read())
                destination.write(b"\r\n\r\n; SKSE64 additions\r\n")
            destination.write(additions)
        merged.add(name.lower())

    if os.path.isdir(vanilla):
        for name in os.listdir(vanilla):
            if name.lower().endswith(".psc") and name.lower() not in merged:
                shutil.copyfile(os.path.join(vanilla, name), os.path.join(MERGED_SKSE_DIR, name))

    return len(merged)


def import_dirs():
    for label, path, probe in (
        ("PapyrusUtil SE", PAPYRUSUTIL_SE_DIR, "StorageUtil.psc"),
        ("Lilac", LILAC_SCRIPTS, "Lilac.psc"),
        ("SkyUI", SKYUI_SCRIPTS, "SKI_ConfigBase.psc"),
    ):
        if not os.path.isfile(os.path.join(path, probe)):
            fail("%s headers not found: %s is missing from %s" % (label, probe, path))

    merge_skse_headers()
    return [
        PAPYRUSUTIL_SE_DIR,
        SOURCE_DIR,
        STUB_HEADERS_DIR,
        LILAC_SCRIPTS,
        MERGED_SKSE_DIR,
        SKYUI_SCRIPTS,
        vanilla_scripts_dir(),
    ]


def flags_path(dirs):
    for directory in reversed(dirs):
        candidate = os.path.join(directory, FLAGS_FILE)
        if os.path.isfile(candidate):
            return candidate
    candidate = os.path.join(SKSE64_SCRIPTS, "vanilla", FLAGS_FILE)
    if os.path.isfile(candidate):
        return candidate
    fail("%s not found in any header directory." % FLAGS_FILE)


def compile_scripts(names):
    compiler = compiler_path()
    dirs = import_dirs()
    flags = flags_path(dirs)

    print("Headers:")
    for directory in dirs:
        print("    " + directory)
    print()

    failed = []
    for name in names:
        source = os.path.join(SOURCE_DIR, name + ".psc")
        if not os.path.isfile(source):
            print("[MISSING] %s" % source)
            failed.append(name)
            continue

        print("=" * 70)
        print(name)
        print("=" * 70)
        # The compiler resolves referenced scripts from the working directory before it
        # consults the import list, so it must not be run from Scripts\Source: the
        # Legendary Edition JsonUtil.psc there would beat the PapyrusUtil SE header. The
        # checkout root holds no .psc, and the script itself is found through the import
        # list.
        result = subprocess.call(
            [
                compiler,
                name + ".psc",
                "-f=" + flags,
                "-i=" + ";".join(dirs),
                "-o=" + OUTPUT_DIR,
            ],
            cwd=PROJECT_DIR,
        )
        if result != 0 or not os.path.isfile(os.path.join(OUTPUT_DIR, name + ".pex")):
            failed.append(name)
            print("[FAILED] %s\n" % name)
        else:
            print("[OK] Scripts\\%s.pex\n" % name)

    print("%d compiled, %d failed." % (len(names) - len(failed), len(failed)))
    if failed:
        print("Failed: " + ", ".join(failed))
    return 0 if not failed else 1


# --- staleness -----------------------------------------------------------------------------


def git(*args):
    try:
        completed = subprocess.run(
            ["git"] + list(args), cwd=PROJECT_DIR, capture_output=True, text=True
        )
    except OSError:
        return None
    if completed.returncode != 0:
        return None
    return completed.stdout.strip()


def git_commit_time(relative):
    output = git("log", "-1", "--format=%ct", "--", relative)
    return int(output) if output else None


def git_dirty(relative):
    return bool(git("status", "--porcelain", "--", relative))


def stale_scripts():
    """Scripts whose .psc is newer than their .pex.

    Judged by git where possible - commit times survive a fresh clone, file mtimes do not.
    An uncommitted .psc with a committed .pex is stale outright; once either side is
    uncommitted the commit times say nothing and the pair is judged by mtime, so a script
    compiled but not yet committed is not reported.
    Sources with no .pex at all are listed separately: some are deliberately left
    uncompiled, so they are never built without being named.
    """
    stale = []
    never = []
    use_git = git("rev-parse", "--is-inside-work-tree") == "true"

    for filename in sorted(os.listdir(SOURCE_DIR)):
        if not filename.lower().endswith(".psc"):
            continue
        name = filename[:-4]
        if name in KNOWN_UNBUILDABLE:
            continue
        psc = os.path.join("Scripts", "Source", filename)
        pex = os.path.join("Scripts", name + ".pex")
        pex_path = os.path.join(PROJECT_DIR, pex)

        if not os.path.isfile(pex_path):
            never.append(name)
            continue

        if use_git:
            psc_dirty = git_dirty(psc)
            pex_dirty = git_dirty(pex)
            if psc_dirty and not pex_dirty:
                stale.append(name)
                continue
            if not psc_dirty and not pex_dirty:
                psc_time = git_commit_time(psc)
                pex_time = git_commit_time(pex)
                if psc_time is not None and pex_time is not None:
                    if psc_time > pex_time:
                        stale.append(name)
                    continue
            # Either side is uncommitted: the commit times say nothing, so fall through to mtime.

        if os.path.getmtime(os.path.join(SOURCE_DIR, filename)) > os.path.getmtime(pex_path):
            stale.append(name)

    return stale, never


def report(stale, never):
    print("Stale (.psc newer than .pex): %d" % len(stale))
    for name in stale:
        print("    " + name)
    print("Never compiled (no .pex; compile by name if they are meant to ship): %d" % len(never))
    for name in never:
        print("    " + name)
    print("Known not to compile: %d" % len(KNOWN_UNBUILDABLE))
    for name, reason in KNOWN_UNBUILDABLE.items():
        print("    %s - %s" % (name, reason))


def main():
    args = sys.argv[1:]
    if not args:
        print(__doc__)
        return 2

    if args == ["--check"]:
        report(*stale_scripts())
        return 0

    if args == ["--stale"]:
        stale, never = stale_scripts()
        report(stale, never)
        print()
        if not stale:
            print("Nothing to compile.")
            return 0
        return compile_scripts(stale)

    if any(arg.startswith("-") for arg in args):
        print(__doc__)
        return 2

    return compile_scripts([name[:-4] if name.lower().endswith(".psc") else name for name in args])


if __name__ == "__main__":
    sys.exit(main())
