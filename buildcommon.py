"""Shared helpers for the Skyrim Survival release builders.

The builders live in the project directory and write their output next to it, e.g.

    <parent>/Campfire/Campfire_BuildRelease.py   ->   <parent>/Campfire 1.13 Release/

Paths in the manifest files are written Windows-style (``Scripts\\Source\\Foo.psc``)
because that is what the Creation Kit's Archive.exe expects. They are normalised here
so the builders also run on Linux and macOS.
"""

import os
import shutil
import sys

# The directory holding the builder scripts, i.e. the project checkout.
PROJECT_DIR = os.path.dirname(os.path.abspath(__file__))

# Releases are built alongside the checkout, not inside it.
BUILD_ROOT = os.path.dirname(PROJECT_DIR)

# Which external dependency set to ship, keyed by the answer to the game prompt.
GAME_EXTERNALS = {
    "LE": os.path.join(PROJECT_DIR, "external", "Skyrim"),
    "SE": os.path.join(PROJECT_DIR, "external", "SkyrimSE"),
}

GAME_NAMES = {
    "LE": "Skyrim Legendary Edition",
    "SE": "Skyrim Special Edition",
}

# The SKSE plugin shipped with each runtime. PapyrusUtil is the 64-bit successor to
# StorageUtil and uses a different file name.
GAME_SKSE_PLUGIN = {
    "LE": "StorageUtil.dll",
    "SE": "PapyrusUtil.dll",
}


def fail(message):
    """Abort the build with a readable message instead of a traceback."""
    sys.stderr.write("\nERROR: " + message + "\n")
    sys.exit(1)


def prompt_version():
    version = input("Enter the release version: ").strip()
    if not version:
        fail("No release version entered.")
    return version


def prompt_game():
    """Ask which runtime to build for. Returns "LE" or "SE"."""
    answer = input("(C)lassic Skyrim or Skyrim (SE)? ").strip().upper()
    if answer in ("C", "LE", "CLASSIC"):
        answer = "LE"
    if answer not in GAME_EXTERNALS:
        fail("Unknown game type '%s'. Please enter C or SE." % answer)
    print("Generating %s build." % GAME_NAMES[answer])
    verify_runtime_assets(answer)
    return answer


def verify_runtime_assets(game):
    """Abort before staging anything if the checkout is not in this runtime's format.

    Special Edition loads Legendary Edition plugins and meshes, so an unconverted
    checkout builds cleanly and only fails in game, on somebody else's save. See
    ssecheck.py for what is checked and why.
    """
    if game != "SE":
        return

    import ssecheck

    problems = ssecheck.check_special_edition_plugins()
    if problems:
        fail(
            "This checkout is not in Special Edition format (%d problem(s)):\n    %s\n"
            "    Run 'python ssecheck.py' after converting to re-check."
            % (len(problems), "\n    ".join(problems))
        )


def optimize_staged_meshes(game, datadir):
    """Convert the staged meshes to Special Edition format in place.

    meshes/ is kept in Legendary Edition format so one source tree still builds both
    runtimes; the conversion happens on the copies under the staging directory, just
    before they are packed into the BSA.

    nifopt is a headless build of the SSE NIF Optimizer pipeline (nifly's
    NifFile::OptimizeFor plus the optimizer's skinning cleanup). Its source and build
    script are in NifOptCLI/, alongside the nifly and SSE-NIF-Optimizer checkouts.
    """
    if game != "SE":
        return

    meshes = os.path.join(datadir, "meshes")
    if not os.path.isdir(meshes):
        return

    optimizer = os.path.join(GAME_EXTERNALS[game], "nifopt.exe")
    if not os.path.isfile(optimizer):
        fail(
            "nifopt.exe is missing from %s.\n"
            "    It converts the staged meshes to Special Edition format. Build it with\n"
            "    NifOptCLI\\build.bat and copy the result next to Archive.exe."
            % os.path.dirname(optimizer)
        )

    import subprocess

    print("Converting staged meshes to Special Edition format...")
    try:
        result = subprocess.call([optimizer, meshes])
    except OSError as error:
        fail("Could not run %s: %s" % (optimizer, error))

    if result != 0:
        fail("nifopt failed with exit code %d; the staged meshes were not all converted." % result)


def stamp_runtime_plugin(game, path):
    """Mark a staged plugin as the Special Edition build.

    _Camp_IsSpecialEdition is the signal the compatibility scripts fall back to when SKSE
    is not installed and there is nothing else to read the runtime from. It has to be 2 on
    Special Edition and 1 on Legendary Edition, which a single shared plugin cannot be, so
    the value is stamped into the copy in the release directory rather than committed -
    the same approach as the meshes.
    """
    if game != "SE":
        return

    import ssecheck

    previous = ssecheck.stamp_special_edition(path)
    if previous is None:
        fail(
            "%s has no %s global. The compatibility scripts read it to identify the "
            "runtime when SKSE is not installed."
            % (os.path.basename(path), ssecheck.SPECIAL_EDITION_GLOBAL)
        )
    print(
        "Marked %s as the Special Edition build (%s: %g -> %g)."
        % (
            os.path.basename(path),
            ssecheck.SPECIAL_EDITION_GLOBAL,
            previous,
            ssecheck.SPECIAL_EDITION_GLOBAL_VALUE,
        )
    )


def resave_form44(game, path):
    """Stamp a staged Special Edition plugin to record form version 44, and prove it.

    Skyrim SE plugins are form 44. A Legendary Edition build is form 43 and must stay that
    way, so this is SE-only.

    This exists because the form-44 pass used to be a MANUAL step run against the deployed
    copies: on 2026-09-04 all 24 plugins in the build were stamped, and the 09-05 rebuild
    silently put Campfire, Frostfall and Last Seed back to form 43, because nothing in the
    build did it. MO2 then reported them as unconverted Legendary Edition plugins. Doing it
    here means a rebuild can no longer undo it.

    Form 43 -> 44 is a real layout change, not a label: WEAP CRDT is 16 bytes in LE and 24
    in SSE, so a header bump alone leaves a form-44 record carrying a form-43 field. That is
    why this re-serialises every record through Mutagen's SE definitions rather than editing
    the header, and why it then PROVES the result holds the same records with the same
    subrecord values before letting the build continue.

    Mutagen rewrites a few fields we do not want changed - a recomputed DIAL TIFC is the one
    that bites here - so a failed comparison is repaired by resavefix and re-checked, and the
    build stops if it still does not match.
    """
    if game != "SE":
        return

    import subprocess

    repo = os.path.join(BUILD_ROOT, "RequiemLotDPatch")
    resave = os.path.join(repo, "resave", "bin", "Debug", "net9.0", "resave.exe")
    tools = os.path.join(repo, "tools")
    fixer, checker = os.path.join(tools, "resavefix.py"), os.path.join(tools, "plugineq.py")

    for needed in (resave, fixer, checker):
        if not os.path.isfile(needed):
            fail(
                "%s is missing, so the form-44 pass cannot run and the release would ship a "
                "form-43 plugin. Build it with: dotnet build %s"
                % (needed, os.path.join(repo, "resave", "resave.csproj"))
            )

    name = os.path.basename(path)
    backup = path + ".bak43"

    def run(*cmd):
        return subprocess.run(cmd, capture_output=True, text=True)

    if run(resave, "--in-place", path).returncode != 0:
        fail("resave failed on %s." % name)

    check = run(sys.executable, checker, backup, path)
    if check.returncode != 0:
        repaired = path + ".fixed"
        if run(sys.executable, fixer, backup, path, repaired).returncode != 0:
            fail("resavefix failed on %s.\n%s" % (name, check.stdout))
        shutil.move(repaired, path)
        check = run(sys.executable, checker, backup, path)
        if check.returncode != 0:
            fail(
                "%s is not equivalent to the original after the form-44 pass. The release "
                "was NOT built.\n%s" % (name, check.stdout)
            )
        print("Repaired the fields Mutagen rewrote in %s." % name)

    # The backup lives in the staging directory and would otherwise ship inside the release.
    os.remove(backup)

    with open(path, "rb") as handle:
        handle.seek(20)
        version = int.from_bytes(handle.read(2), "little")
    if version != 44:
        fail("%s is form %d after the resave, expected 44." % (name, version))
    print("Stamped %s to record form version 44 (verified equivalent)." % name)


def require_skse_plugin(game):
    """The path to the SKSE plugin this runtime ships, or a readable failure.

    PapyrusUtil is not committed here, so a fresh checkout has the Special Edition
    scripts but not the DLL that goes with them.
    """
    plugin = os.path.join(GAME_EXTERNALS[game], "SKSE", "Plugins", GAME_SKSE_PLUGIN[game])
    if not os.path.isfile(plugin):
        fail(
            "%s is missing.\n"
            "    Campfire ships PapyrusUtil for the player; it is not committed here.\n"
            "    Download the %s build and drop the DLL at:\n"
            "        %s\n"
            "    See external/README.md." % (GAME_SKSE_PLUGIN[game], GAME_NAMES[game], plugin)
        )
    return plugin


def project_path(*parts):
    """A path inside the project checkout."""
    return os.path.join(PROJECT_DIR, *parts)


def externals_path(game, *parts):
    """A path inside the external dependency set for the given runtime."""
    return os.path.join(GAME_EXTERNALS[game], *parts)


def normalize(manifest_line):
    """Turn a Windows-style manifest path into one for the current platform."""
    return manifest_line.rstrip("\n").rstrip("\r").strip().replace("\\", os.sep).replace("/", os.sep)


def read_manifest(manifest_file):
    """Read a manifest, skipping blank lines and # comments."""
    if not os.path.isfile(manifest_file):
        fail("Manifest not found: %s" % manifest_file)

    entries = []
    with open(manifest_file) as manifest:
        for line in manifest:
            entry = normalize(line)
            if entry and not entry.startswith("#"):
                entries.append(entry)
    return entries


def copy_file(source, destination):
    """Copy a single file, creating the destination directory as needed."""
    if not os.path.isfile(source):
        fail("Required file is missing: %s" % source)

    destination_dir = os.path.dirname(destination)
    if destination_dir:
        os.makedirs(destination_dir, exist_ok=True)
    shutil.copyfile(source, destination)


def copy_optional_file(source, destination, purpose):
    """Copy a file if it is there, warn if it is not. Returns whether it was copied.

    For presentation assets - installer splash images and the like - that are not worth
    blocking a release over.
    """
    if not os.path.isfile(source):
        print("WARNING: %s is missing, skipping. (%s)" % (source, purpose))
        return False

    copy_file(source, destination)
    return True


def copy_manifest(manifest_file, source_dir, destination_dir):
    """Copy every file listed in a manifest from source_dir to destination_dir.

    Every missing file is reported at once, rather than stopping at the first, so a
    manifest that has drifted from the project directory can be fixed in one pass.
    """
    entries = read_manifest(manifest_file)
    missing = [e for e in entries if not os.path.isfile(os.path.join(source_dir, e))]
    if missing:
        fail(
            "%d file(s) listed in %s are missing from %s:\n    %s"
            % (len(missing), os.path.basename(manifest_file), source_dir, "\n    ".join(missing))
        )

    for entry in entries:
        copy_file(os.path.join(source_dir, entry), os.path.join(destination_dir, entry))


def run_archiver(tempdir, builder_file, log_file):
    """Run the Creation Kit's Archive.exe over a builder script to produce the BSA."""
    import subprocess

    archiver = os.path.join(tempdir, "Archive.exe")
    try:
        result = subprocess.call([archiver, "./" + builder_file], cwd=tempdir)
    except OSError as error:
        fail(
            "Could not run %s: %s\nArchive.exe is a Windows executable; BSA generation "
            "has to run on Windows (or under Wine)." % (archiver, error)
        )

    if result != 0:
        fail("Archive.exe failed with exit code %d. See %s." % (result, log_file))


def reset_directory(path):
    """Create an empty directory, discarding anything already there."""
    if os.path.isdir(path):
        shutil.rmtree(path)
    os.makedirs(path)
    return path


def make_release_zip(dirname, zip_basename):
    """Zip up a finished release directory and drop the archive inside it."""
    staged_zip = shutil.make_archive(os.path.join(BUILD_ROOT, zip_basename), "zip", root_dir=dirname)
    final_zip = os.path.join(dirname, zip_basename + ".zip")
    shutil.move(staged_zip, final_zip)
    print("Created " + final_zip)
    return final_zip
