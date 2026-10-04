# Build Frostfall.dll for Skyrim SE 1.7.104 and put it, with its PDB, into the repository's SKSE\Plugins.
# Run from PowerShell, never Git Bash: MSYS rewrites /O2 and friends into Windows paths.
#
#   powershell -NoProfile -ExecutionPolicy Bypass -File build-1.7.104.ps1 [-Clean]
#
# CMakeLists.txt fetches alandtse CommonLibSSE-NG a898f469 (v9.1.0), and that CommonLib fetches MinHook v1.3.4 for its
# hde64 instruction-length decoder. Both are read from local trees, so nothing is downloaded:
#   D:\b\clib\ng-9.1.0       git clone --no-checkout <workspace>\CommonLibSSE-NG D:\b\clib\ng-9.1.0
#                            git -C D:\b\clib\ng-9.1.0 checkout a898f469851c464d05137bb74b069dd234897643
#   D:\b\clib\minhook-1.3.4  git clone --depth 1 --branch v1.3.4 https://github.com/TsudaKageyu/minhook.git D:\b\clib\minhook-1.3.4
# vcpkg comes from the VS install (manifest mode, builtin-baseline from vcpkg.json); binary dirs live on D:\b because
# vcpkg buildtrees overflow MAX_PATH under the source path.
param([switch]$Clean)
$ErrorActionPreference = "Stop"

$SRC   = $PSScriptRoot
$BIN   = "D:\b\ffnative"
$CLIB  = "D:\b\clib\ng-9.1.0"
$HDE   = "D:\b\clib\minhook-1.3.4"
$OUT   = Join-Path (Split-Path -Parent $SRC) "SKSE\Plugins"
$VCPKG = "C:\Program Files\Microsoft Visual Studio\18\Community\VC\vcpkg\scripts\buildsystems\vcpkg.cmake"
$PIN   = "a898f469851c464d05137bb74b069dd234897643"

if (-not (Test-Path "$CLIB\CMakeLists.txt")) { throw "CommonLibSSE-NG v9.1.0 is not at $CLIB (see the header of this script)" }
$head = (git -C $CLIB rev-parse HEAD).Trim()
if ($head -ne $PIN) { throw "$CLIB is at $head, not $PIN" }
$module = Get-Content "$CLIB\include\REL\Module.h" -Raw
if ($module -notmatch 'a_version\[1\] >= 6') { throw "$CLIB does not run 1.7.x as AE" }
if (-not (Select-String -Path "$CLIB\include\REL\IDDB.h" -Pattern "SSEv5" -Quiet)) { throw "$CLIB has no format-5 reader" }
if (-not (Test-Path "$HDE\src\hde\hde64.c")) { throw "MinHook v1.3.4 is not at $HDE (see the header of this script)" }

if ($Clean -and (Test-Path $BIN)) { Remove-Item $BIN -Recurse -Force }
$env:VCPKG_INSTALL_OPTIONS = "--allow-unsupported;--x-buildtrees-root=D:\b\vt-ffn"

cmake -S "$SRC" -B "$BIN" `
    -G "Visual Studio 18 2026" -T v145 -A x64 `
    "-DCMAKE_TOOLCHAIN_FILE=$VCPKG" `
    -DVCPKG_TARGET_TRIPLET=x64-windows-static-md `
    -DVCPKG_HOST_TRIPLET=x64-windows-static-md `
    -DVCPKG_MANIFEST_MODE=ON `
    "-DFETCHCONTENT_SOURCE_DIR_COMMONLIBSSE=$CLIB" `
    "-DFETCHCONTENT_SOURCE_DIR_HDE64=$HDE" `
    -DFETCHCONTENT_FULLY_DISCONNECTED=ON
if ($LASTEXITCODE -ne 0) { throw "configure failed ($LASTEXITCODE)" }

cmake --build "$BIN" --config RelWithDebInfo --target Frostfall --parallel -- /v:minimal /nologo
if ($LASTEXITCODE -ne 0) { throw "build failed ($LASTEXITCODE)" }

$dll = Get-ChildItem "$BIN" -Recurse -Filter "Frostfall.dll" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
if (-not $dll) { throw "no Frostfall.dll under $BIN" }
$text = [Text.Encoding]::ASCII.GetString([IO.File]::ReadAllBytes($dll.FullName))
if (-not $text.Contains('Address library file is truncated or its offset count is invalid')) { throw "$($dll.FullName) has no format-5 address-library reader" }
"format-5 reader present in $($dll.FullName)"

# The release builder ships the DLL and its PDB (CrashLogger prints source lines from it) from SKSE\Plugins
New-Item -ItemType Directory -Force $OUT | Out-Null
Copy-Item $dll.FullName "$OUT\" -Force
Copy-Item ($dll.FullName -replace '\.dll$', '.pdb') "$OUT\" -Force
Get-ChildItem $OUT -File | Where-Object { $_.Name -like 'Frostfall.*' } | ForEach-Object { "{0,-22} {1,10}  {2}" -f $_.Name, $_.Length, $_.LastWriteTime }
