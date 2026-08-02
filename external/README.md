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
| `Scripts/JsonUtil.pex`, `Scripts/StorageUtil.pex` | Compiled PapyrusUtil scripts. |
| `Scripts/Source/JsonUtil.psc`, `Scripts/Source/StorageUtil.psc` | PapyrusUtil sources. |
| `SKSE/Plugins/<plugin>.dll` | The SKSE plugin itself, named below. |

The SKSE plugin is named differently per runtime, because the 64-bit release renamed it:

| Runtime | SKSE build | Plugin file |
| --- | --- | --- |
| Legendary Edition | SKSE 1.7.3+ | `external/Skyrim/SKSE/Plugins/StorageUtil.dll` |
| Special Edition | SKSE64 2.0.20+ | `external/SkyrimSE/SKSE/Plugins/PapyrusUtil.dll` |

## Missing binary

`external/SkyrimSE/SKSE/Plugins/PapyrusUtil.dll` is **not** currently in the repository.
Until it is added, `Campfire_BuildRelease.py` stops with a message naming the missing
file when building for Special Edition. Drop the `PapyrusUtil.dll` from a PapyrusUtil SE
release into that path to unblock an SE build; `.gitignore` now whitelists the name so it
can be committed alongside the Legendary Edition `StorageUtil.dll`.

Frostfall does not ship PapyrusUtil of its own — it relies on the copy Campfire installs,
and only needs the matching `Archive.exe` to pack its BSA.
