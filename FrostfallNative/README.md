# Frostfall.dll

The SKSE plugin behind Frostfall's HUD bars, its start-up logo, the settings page in SKSE Menu Framework and
three Papyrus natives (`FrostfallNative`: water depth at the player's feet, the makeshift camp's spot beside a
fire, the auto-start switch). Frostfall runs without it: every native call is guarded by
`FrostfallNative.IsInstalled()`, and the SkyUI meters, message boxes and MCM take over.

## Where it comes from

`src/` and `include/` are the plugin of CageTV's **Frostfall 2026** (MIT,
<https://github.com/CageTV/Frostfall-2026>, `plugin/` at commit `bfb34b9`), copied unchanged.
`include/SKSEMenuFramework.h` is SKSE Menu Framework's client header as that repository ships it.

## What differs from upstream: the build

Upstream builds with Ninja against the colorglass vcpkg registry, whose CommonLibSSE-NG 3.7.0 dates from 2023:
it decides the runtime on the minor version, takes 1.7.x for Skyrim SE and cannot read the dense (format 5)
Address Library that 1.7.99 introduced. This folder builds the same sources against alandtse's
CommonLibSSE-NG v9.1.0 (`a898f469`), which runs 1.7.x as AE, reads format 5 exactly and carries the structure
layouts 1.7.99 moved.

    powershell -NoProfile -ExecutionPolicy Bypass -File build-1.7.104.ps1

The script reads CommonLibSSE-NG and MinHook from local trees (its header says how to create them), builds
RelWithDebInfo into `D:\b\ffnative` and copies `Frostfall.dll` and `Frostfall.pdb` to the repository's
`SKSE\Plugins`, from where `Frostfall_BuildRelease.py` ships them.

The plugin addresses Frostfall.esp's globals by FormID (`src/GameIds.h`); the ids are those of the regular
plugin, which this repository ships. `-DFROSTFALL_ESL=ON` selects the compacted ids of upstream's ESL variant.

## Runtime requirements

SKSE Menu Framework 3 (Nexus 120352) for the bars, the logo and the settings page; without it the plugin logs
one warning and Frostfall uses its SkyUI meters. Settings are written to `Data\SKSE\Plugins\Frostfall.ini`.
