# External dependencies

Campfire ships PapyrusUtil (by exiledviper / Meh321) so that its data store works out of
the box. PapyrusUtil is built separately for each Skyrim runtime, so a copy of it lives
here per game and the release builders pick the matching set.

    external/Skyrim/      Skyrim Legendary Edition (32-bit)
    external/SkyrimSE/    Skyrim Special Edition (64-bit)

Each directory holds:

| Path | Notes |
| --- | --- |
| `Archive.exe` | The BSA packer from that game's Creation Kit. LE and SE BSAs are not interchangeable. |
| `nifopt.exe` | Special Edition only. Converts the staged meshes to Special Edition format during the build. Built from `NifOptCLI/`; see the repository README. |
| `Scripts/JsonUtil.pex`, `Scripts/StorageUtil.pex` | Compiled PapyrusUtil scripts. |
| `Scripts/Source/JsonUtil.psc`, `Scripts/Source/StorageUtil.psc` | PapyrusUtil sources. |
| `SKSE/Plugins/<plugin>.dll` | The SKSE plugin itself, named below. |

The SKSE plugin is named differently per runtime, because the 64-bit release renamed it:

| Runtime | SKSE build | Plugin file |
| --- | --- | --- |
| Legendary Edition | SKSE 1.7.3+ | `external/Skyrim/SKSE/Plugins/StorageUtil.dll` |
| Special Edition | SKSE64 2.0.20+ | `external/SkyrimSE/SKSE/Plugins/PapyrusUtil.dll` |

## The Special Edition set is PapyrusUtil 4.7 (our 1.7.99 build)

`external/SkyrimSE/` holds `PapyrusUtil.dll` **4.7**, built 2026-08-23 from
`..\..\PapyrusUtil` (eeveelo's fork of Ashal's source, patched for 1.7.99: format-5 Address
Library reader, `compatibleVersions = { 1.7.99 }`, skse64 2.3.0 — see that README for the
recipe), plus `JsonUtil.pex`, `StorageUtil.pex` and the matching `.psc` sources, which are
unchanged since 4.6 (the script API did not move between 4.5, 4.6 and 4.7; only
`PapyrusUtil.GetVersion()` returns 47 now).

PapyrusUtil's DLL is built against one game executable. 4.7 is for **Skyrim SE 1.7.99 with
SKSE64 2.3.0** and the official `versionlib-1-7-99-0.bin`; SKSE refuses it on anything else.
It was verified loading on 1.7.99 (`PapyrusUtilDev.log`: "Loaded database for SkyrimSE.exe
version 1.7.99.0", hooks and functions registered, main menu reached) but not yet exercised
through Campfire's MCM or a save/load cycle — do that before a release. The previous 4.6 DLL
(Nexus, 18 January 2024, pinned to 1.6.1170) is gone from this folder; players still on
1.6.1170 take 4.6 from Nexus, players on 1.5.97 need 3.9 — nothing in the scripts changes.
The DLL shipped inside a Campfire release is the one thing in it that goes stale with game
patches, and PapyrusUtil's own page warns players not to let Campfire overwrite a newer install.

`external/SkyrimSE/Scripts/Source/` also carries `MiscUtil.psc`, `PapyrusUtil.psc`,
`ActorUtil.psc` and `ObjectUtil.psc` from the same release. They are headers for
`pscompile.py` — `JsonUtil.psc` calls `MiscUtil.FileExists`, so the compiler needs it — and are
not in any manifest, so the release still ships only the two scripts Campfire has always
shipped.

Frostfall and Last Seed do not ship PapyrusUtil of their own — they rely on the copy Campfire
installs, and only need the matching `Archive.exe` to pack their BSAs.

## Compile-only stubs

`external/headers/` holds stub `.psc` headers for third-party scripts that Campfire's
compatibility code binds to but which cannot be redistributed — currently the two Equipping
Overhaul scripts `_Camp_TentSystem.EO_TurnOff()` reads. Each declares only the members
Campfire uses, with the types the committed `_Camp_TentSystem.pex` was compiled against. They
are on `pscompile.py`'s import path and are never shipped.
