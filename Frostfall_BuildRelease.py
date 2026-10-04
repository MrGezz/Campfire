import os
import shutil

import buildcommon
from buildcommon import (
    BUILD_ROOT,
    copy_file,
    copy_manifest,
    copy_optional_file,
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
print("|  Frostfall Release Builder  |")
print("|             \\/              |")
print("|         _\\_\\/\\/_/_          |")
print("|          _\\_\\/_/_           |")
print("|         __/_/\\_\\__          |")
print("|          / /\\/\\ \\           |")
print("|             /\\              |")
print("===============================")
print(" ")

version = prompt_version()
game = prompt_game()

# Stage the BSA contents.
print("Creating temp directories...")
tempdir = reset_directory(os.path.join(BUILD_ROOT, "tmp"))
datadir = os.path.join(tempdir, "Data")

print("Copying project files...")
copy_manifest(project_path("FrostfallArchiveManifest.txt"), buildcommon.PROJECT_DIR, datadir)

# meshes/ is kept in Legendary Edition format; the staged copies are converted instead.
optimize_staged_meshes(game, datadir)

# Frostfall does not ship PapyrusUtil itself; it uses the copy installed by Campfire.
# Only the archiver differs between runtimes.

# Build the release directory.
dirname = os.path.join(BUILD_ROOT, "Frostfall " + version + " Release")
print("Creating build directory...")
reset_directory(dirname)

# Generate BSA archive.
print("Generating BSA archive...")
copy_file(externals_path(game, "Archive.exe"), os.path.join(tempdir, "Archive.exe"))
copy_file(project_path("FrostfallArchiveBuilder.txt"), os.path.join(tempdir, "FrostfallArchiveBuilder.txt"))
copy_file(project_path("FrostfallArchiveManifest.txt"), os.path.join(tempdir, "FrostfallArchiveManifest.txt"))

run_archiver(tempdir, "FrostfallArchiveBuilder.txt", "FrostfallArchiveLog.txt")

# Copy files - Mod
frostfall_esp = os.path.join(dirname, "Frostfall", "Frostfall.esp")
copy_file(project_path("Frostfall.esp"), frostfall_esp)
resave_form44(game, frostfall_esp)
copy_file(os.path.join(tempdir, "Frostfall.bsa"), os.path.join(dirname, "Frostfall", "Frostfall.bsa"))
copy_file(
    project_path("SKSE", "Plugins", "FrostfallData", "READ_THIS_PLEASE_AND_DO_NOT_DELETE.txt"),
    os.path.join(dirname, "Frostfall", "SKSE", "Plugins", "FrostfallData", "READ_THIS_PLEASE_AND_DO_NOT_DELETE.txt"),
)

for readme in (
    "Frostfall_readme.txt", "Frostfall_license.txt", "Frostfall_changelog.txt",
    "Frostfall2026_readme.txt", "Frostfall2026_license.txt",
):
    copy_file(project_path("readmes", readme), os.path.join(dirname, "Frostfall", "readmes", readme))

# Copy files - the Frostfall 2026 layer (CageTV, MIT), everything that is read from disk rather than
# from the archive:
#   Frostfall.dll           SKSE loads plugins from Data\SKSE\Plugins; built by FrostfallNative\build-1.7.104.ps1
#   logo and HUD icons      Frostfall.dll opens them by path (Data\Interface\frostfall\...)
#   the freezing sounds     shipped loose as .xwm beside the .wav copies in the archive, as upstream does
#   Frostfall_Embers_FLM    FormList Manipulator reads *_FLM.ini from Data; inert without it or without Embers XD
if game == "SE":
    loose = [("SKSE", "Plugins", "Frostfall.dll"), ("Frostfall_Embers_FLM.ini",), ("Interface", "frostfall", "frostfall_logo.png")]
    loose += [("Interface", "frostfall", "icons", name) for name in ("exposure.png", "temperature.png", "warmth.png", "wetness.png")]
    loose += [
        ("sound", "fx", "frostfall", name + ".xwm")
        for name in (
            "frostfall_female_freezing", "frostfall_female_freezing2death",
            "frostfall_male_freezing", "frostfall_male_freezing2death",
        )
    ]
    for parts in loose:
        copy_file(project_path(*parts), os.path.join(dirname, "Frostfall", *parts))
    # CrashLogger prints source lines from the PDB; it is built beside the DLL and not tracked
    copy_optional_file(
        project_path("SKSE", "Plugins", "Frostfall.pdb"),
        os.path.join(dirname, "Frostfall", "SKSE", "Plugins", "Frostfall.pdb"),
        "debug symbols for Frostfall.dll",
    )

# Copy files - add-on
addon = os.path.join(dirname, "SkyUI51AddOn")
copy_file(
    project_path("readmes", "Frostfall_SkyUI_AddOn_readme.txt"),
    os.path.join(addon, "readmes", "Frostfall_SkyUI_AddOn_readme.txt"),
)
copy_file(
    project_path("SKSE", "Plugins", "FrostfallData", "interface_package_version.json"),
    os.path.join(addon, "SKSE", "Plugins", "FrostfallData", "interface_package_version.json"),
)

for menu in ("bartermenu.swf", "containermenu.swf", "craftingmenu.swf", "inventorymenu.swf"):
    copy_file(project_path("Interface", menu), os.path.join(addon, "Interface", menu))

for widget in ("bottombar.swf", "itemcard.swf"):
    copy_file(project_path("Interface", "skyui", widget), os.path.join(addon, "Interface", "skyui", widget))

translations = (
    "czech", "english", "french", "german", "italian",
    "japanese", "polish", "russian", "spanish",
)
# Legendary Edition only. The addon overrides SkyUI's own skyui_<lang>.txt; SkyUI SE ships
# skyui_se_<lang>.txt instead and loads each mod's frostfall_<lang>.txt on its own, so the
# SE build has nothing to override and the repository carries no skyui_*.txt. Warn, do not
# stop - measured 2026-09-05 when the SE build aborted here on skyui_czech.txt.
for language in translations:
    name = "skyui_" + language + ".txt"
    copy_optional_file(
        project_path("Interface", "Translations", name),
        os.path.join(addon, "Interface", "Translations", name),
        "SkyUI translation addon (Legendary Edition only)",
    )

# Copy files - Installer
# The splash images are referenced by fomod/ModuleConfig.xml but are not committed here.
# A fomod without them still installs, so the build warns rather than stopping.
for splash in ("InstallSplash1.jpg", "InstallSplash2.jpg"):
    copy_optional_file(
        project_path("Installers", "Frostfall", splash),
        os.path.join(dirname, splash),
        "fomod installer image",
    )

for fomod_file in ("info.xml", "ModuleConfig.xml"):
    copy_file(
        project_path("Installers", "Frostfall", "fomod", fomod_file),
        os.path.join(dirname, "fomod", fomod_file),
    )

# Create release zip
make_release_zip(dirname, "Frostfall_" + version.replace(".", "_") + "_Release")

# Clean Up
print("Removing temp files...")
shutil.rmtree(tempdir)

print("Done!")
