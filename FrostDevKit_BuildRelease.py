import os

from buildcommon import (
    BUILD_ROOT,
    copy_file,
    make_release_zip,
    project_path,
    prompt_version,
    read_manifest,
    reset_directory,
)

print(" ")
print("======================================")
print("| Frostfall Dev Kit Release Builder  |")
print("|                           _   _    |")
print("|                          ( \\_/ )   |")
print("|             _   _       __) _ (__  |")
print("|     _   _  ( \\_/ )  _  (__ (_) __) |")
print("|    ( \\_/ )__) _ (__( \\_/ )) _ (    |")
print("|   __) _ ((__ (_) __)) _ ((_/ \\_)   |")
print("|  (__ (_) __)) _ ((__ (_) __)       |")
print("|     ) _ (  (_/ \\_)  ) _ (          |")
print("|    (_/ \\_)         (_/ \\_)         |")
print("======================================")
print(" ")

version = prompt_version()

# Build the release directory.
dirname = os.path.join(BUILD_ROOT, "FrostDevKit " + version + " Release")
print("Creating build directory...")
reset_directory(dirname)

# Copy the project files. Entries tagged "externals " come from the dev kit's bundled
# copies of shared scripts rather than from the project directory.
print("Copying project files...")
EXTERNALS_TAG = "externals "
for entry in read_manifest(project_path("FrostDevKitArchiveManifest.txt")):
    if entry.startswith(EXTERNALS_TAG):
        relative = entry[len(EXTERNALS_TAG):]
        source = project_path("FrostDevKit", "RequiredExternals", relative)
    else:
        relative = entry
        source = project_path(relative)
    copy_file(source, os.path.join(dirname, relative))

# Create release zip
make_release_zip(dirname, "FrostDevKit_" + version.replace(".", "_") + "_Release")
print("Done!")
