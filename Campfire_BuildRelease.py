import os
import shutil

import buildcommon
from buildcommon import (
    BUILD_ROOT,
    GAME_SKSE_PLUGIN,
    copy_file,
    copy_manifest,
    externals_path,
    make_release_zip,
    project_path,
    prompt_game,
    prompt_version,
    reset_directory,
    run_archiver,
)

print(" ")
print("==============================")
print("|  Campfire Release Builder  |")
print("|            .(              |")
print("|           /%/\\             |")
print("|          (%(%))            |")
print("|         .-'..`-.           |")
print("|         `-'.'`-'           |")
print("==============================")
print(" ")

version = prompt_version()
game = prompt_game()

# Stage the BSA contents.
print("Creating temp directories...")
tempdir = reset_directory(os.path.join(BUILD_ROOT, "tmp"))
datadir = os.path.join(tempdir, "Data")

print("Copying project files...")
copy_manifest(project_path("CampfireArchiveManifest.txt"), buildcommon.PROJECT_DIR, datadir)

# The external dependencies differ per runtime and overwrite the project copies.
print("Copying external dependencies...")
copy_manifest(project_path("CampfireArchiveManifestExternal.txt"), externals_path(game), datadir)

# Build the release directory.
dirname = os.path.join(BUILD_ROOT, "Campfire " + version + " Release")
print("Creating build directory...")
reset_directory(dirname)

# Generate BSA archive.
print("Generating BSA archive...")
copy_file(externals_path(game, "Archive.exe"), os.path.join(tempdir, "Archive.exe"))
copy_file(project_path("CampfireArchiveBuilder.txt"), os.path.join(tempdir, "CampfireArchiveBuilder.txt"))
copy_file(project_path("CampfireArchiveManifest.txt"), os.path.join(tempdir, "CampfireArchiveManifest.txt"))

run_archiver(tempdir, "CampfireArchiveBuilder.txt", "CampfireArchiveLog.txt")

# Copy files - Mod
copy_file(project_path("Campfire.esm"), os.path.join(dirname, "Campfire.esm"))
copy_file(os.path.join(tempdir, "Campfire.bsa"), os.path.join(dirname, "Campfire.bsa"))
copy_file(
    project_path("SKSE", "Plugins", "CampfireData", "READ_THIS_PLEASE_AND_DO_NOT_DELETE.txt"),
    os.path.join(dirname, "SKSE", "Plugins", "CampfireData", "READ_THIS_PLEASE_AND_DO_NOT_DELETE.txt"),
)

skse_plugin = GAME_SKSE_PLUGIN[game]
copy_file(
    externals_path(game, "SKSE", "Plugins", skse_plugin),
    os.path.join(dirname, "SKSE", "Plugins", skse_plugin),
)

for readme in ("Campfire_readme.txt", "Campfire_license.txt", "Campfire_changelog.txt"):
    copy_file(project_path("readmes", readme), os.path.join(dirname, "readmes", readme))

# Clean Up
print("Removing temp files...")
shutil.rmtree(tempdir)

# Create release zip
make_release_zip(dirname, "Campfire_" + version.replace(".", "_") + "_Release")
print("Done!")
