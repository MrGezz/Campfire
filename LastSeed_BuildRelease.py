import os
import shutil

import buildcommon
from buildcommon import (
    BUILD_ROOT,
    copy_file,
    copy_manifest,
    externals_path,
    make_release_zip,
    optimize_staged_meshes,
    resave_form44,
    project_path,
    prompt_game,
    prompt_version,
    reset_directory,
    run_archiver,
)

print(" ")
print("===============================")
print("|  Last Seed Release Builder  |")
print("===============================")
print(" ")

version = prompt_version()
game = prompt_game()

# Stage the BSA contents.
print("Creating temp directories...")
tempdir = reset_directory(os.path.join(BUILD_ROOT, "tmp"))
datadir = os.path.join(tempdir, "Data")

print("Copying project files...")
copy_manifest(project_path("LastSeedArchiveManifest.txt"), buildcommon.PROJECT_DIR, datadir)

# meshes/ is kept in Legendary Edition format; the staged copies are converted instead.
optimize_staged_meshes(game, datadir)

# Like Frostfall, Last Seed does not ship PapyrusUtil itself; it uses the copy installed by
# Campfire. Only the archiver differs between runtimes.

# Build the release directory.
dirname = os.path.join(BUILD_ROOT, "Last Seed " + version + " Release")
print("Creating build directory...")
reset_directory(dirname)

# Generate BSA archive.
print("Generating BSA archive...")
copy_file(externals_path(game, "Archive.exe"), os.path.join(tempdir, "Archive.exe"))
copy_file(project_path("LastSeedArchiveBuilder.txt"), os.path.join(tempdir, "LastSeedArchiveBuilder.txt"))
copy_file(project_path("LastSeedArchiveManifest.txt"), os.path.join(tempdir, "LastSeedArchiveManifest.txt"))

run_archiver(tempdir, "LastSeedArchiveBuilder.txt", "LastSeedArchiveLog.txt")

# Copy files - Mod
lastseed_esp = os.path.join(dirname, "LastSeed.esp")
copy_file(project_path("LastSeed.esp"), lastseed_esp)
resave_form44(game, lastseed_esp)
copy_file(os.path.join(tempdir, "LastSeed.bsa"), os.path.join(dirname, "LastSeed.bsa"))
copy_file(
    project_path("SKSE", "Plugins", "LastSeedData", "READ_THIS_PLEASE_AND_DO_NOT_DELETE.txt"),
    os.path.join(dirname, "SKSE", "Plugins", "LastSeedData", "READ_THIS_PLEASE_AND_DO_NOT_DELETE.txt"),
)

for readme in ("LastSeed_readme.txt", "LastSeed_license.txt", "LastSeed_changelog.txt"):
    copy_file(project_path("readmes", readme), os.path.join(dirname, "readmes", readme))

# Create release zip
make_release_zip(dirname, "LastSeed_" + version.replace(".", "_") + "_Release")

# Clean Up
print("Removing temp files...")
shutil.rmtree(tempdir)

print("Done!")
