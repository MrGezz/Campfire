This repository is home to development of all of the Skyrim Survival mods by Chesko.

![Campfire](http://i.imgur.com/P0CxWke.png)
![Frostfall](http://i.imgur.com/OdLeSuh.png)

## Building

    python Campfire_BuildRelease.py
    python Frostfall_BuildRelease.py

Each builder asks for a version and a runtime (`C` for Legendary Edition, `SE` for Special
Edition), packs the BSA with that runtime's `Archive.exe`, and writes a release directory
and zip next to the checkout. `external/README.md` covers the per-runtime dependencies.

### Files this checkout is missing

`CampfireArchiveManifest.txt` lists 14 files that are not here, so `Campfire_BuildRelease.py`
stops before packing on either runtime. `.gitignore` already whitelists all of them, so
they are tracked as soon as they are dropped in. Run `_Camp_ManifestCheck.bat` for the
current list.

| Files | Source |
| --- | --- |
| `Scripts/CommonArrayHelper.pex`, `CommonHelperFunctions.pex`, `CommonMeterInterfaceHandler.pex`, `Common_SKI_MeterWidget.pex`, `FallbackEventEmitter.pex`, `FallbackEventHandler.pex`, `FallbackEventReceiverActiveMagicEffect.pex`, `FallbackEventReceiverAlias.pex`, `FallbackEventReceiverForm.pex` | [CheskoPapyrusShared](https://github.com/chesko256/CheskoPapyrusShared) (MIT). That repository ships compiled `.pex` for six of the nine; `CommonHelperFunctions`, `CommonMeterInterfaceHandler` and `Common_SKI_MeterWidget` are source only and have to be compiled. |
| `Scripts/C00JorrvaskrFightAthisScript.pex`, `C00JorrvaskrFightNjadaScript.pex` and their `.psc` | The Brawl Bug Patch set, the rest of which is already here. |
| `meshes/mps/mpsguideparticles.nif` | Ships in the Campfire BSA; not committed. |

`Frostfall_BuildRelease.py` is not blocked — `_Frost_ManifestCheck.bat` passes.

## Special Edition

The Papyrus and build tooling in this repository target both runtimes from one source
tree. Special Edition loads Legendary Edition plugins and meshes without complaining, so
an unconverted release builds cleanly and only fails in game, later, on somebody else's
save.

**Meshes are converted by the build.** `meshes/` stays in Legendary Edition format so one
source tree still builds both runtimes; answering `SE` converts the *staged* copies just
before they are packed into the BSA. That is `nifopt.exe`, a headless build of the SSE NIF
Optimizer pipeline — nifly's `NifFile::OptimizeFor` plus the optimizer's skinning cleanup,
with the wxWidgets GUI left out. Source and build script are in `NifOptCLI/`, next to the
`nifly` and `SSE-NIF-Optimizer` checkouts; the built binary lives at
`external/SkyrimSE/nifopt.exe`. It can also be run by hand:

    external\SkyrimSE\nifopt.exe meshes --dry-run

**Plugins are not**, because nothing but the Creation Kit can convert them. `ssecheck.py`
checks for that, and the builders refuse to build for Special Edition until it passes:

    python ssecheck.py

| Check | Fix |
| --- | --- |
| `Campfire.esm`, `Campfire.esp`, `Frostfall.esp`, `LastSeed.esp` still carry the Legendary Edition TES4 header (1.70 / form version 43) | Resave each in the **Special Edition Creation Kit**, which writes 1.71 / 44. `Campfire.esm` and `Frostfall.esp` each contain one `NAVM` record; `LastSeed.esp` has none. Legendary Edition navmesh data is the part of a resave that actually matters, so the exposure here is one navmesh per plugin rather than a worldspace. |
| `Campfire.esm` does not have the ESM flag set on its TES4 record | Set it in the Creation Kit. Skyrim loads a `.esm` in the master block on the extension alone, so this works in game, but the Creation Kit and xEdit go by the flag — and `Frostfall.esp` and `LastSeed.esp` both master it. Confirm in SSEEdit before changing it, in case it is deliberate: `Campfire.esm` and `Campfire.esp` are byte for byte identical, which suggests the `.esm` is a renamed `.esp`. |

`_Camp_IsSpecialEdition` is **not** on that list any more. It has to read 1 on Legendary
Edition and 2 on Special Edition, which one shared plugin cannot do, so the Special Edition
builder stamps 2.0 into the copy in the release directory — four bytes in one `GLOB`
record, no offsets moved. Same reasoning as the meshes: the source tree stays dual-runtime.

### Doing the resave

The Creation Kit only sees plugins in the game's own Data folder, and it silently drops
script properties whose `.pex` it cannot resolve — so the compiled scripts have to go in
beside them. `ckstage.py` handles both directions:

    python ckstage.py stage      # plugins + Scripts\*.pex -> game Data folder
    #   ... resave each plugin in the Creation Kit ...
    python ckstage.py collect    # verified copy back into the checkout
    python ckstage.py unstage    # remove exactly what stage put there

Resave `Campfire.esm` first — `Frostfall.esp` and `LastSeed.esp` both master it. `collect`
runs `plugindiff.py` per plugin and refuses to copy anything back that lost records or
script data:

    python plugindiff.py <original>\Frostfall.esp Frostfall.esp

264 records in `Campfire.esm` carry script (`VMAD`) data and all of it has to survive.
Deployment is otherwise MO2's job; this is a temporary authoring staging area, which is
why `unstage` removes exactly what `stage` wrote and restores anything it displaced.

The Creation Kit's command line (`-OptimizeMasterFile`, `-TagifyMasterfile`, `-ConvertToESL`,
`-GenerateSEQ`, …) has no plain "resave", and the switches that do rewrite a plugin all
change it in ways these mods cannot take — `-ConvertToESL` renumbers FormIDs, which every
`Game.GetFormFromFile` call in the Papyrus depends on. The resave is a GUI operation.

Running `ssecheck.py` standalone also reports meshes still in Legendary Edition format.
That is informational — the build converts them — and is there to audit the source tree.

Not covered by any of this, and still worth doing before a Special Edition release:

- Textures are `DXT3`/`DXT5`. Special Edition reads them, but `BC7` is the format it is
  tuned for; converting is optional and purely a quality/size decision. SSE NIF Optimizer's
  texture scan is not part of `nifopt.exe`.
- `Interface/*.swf` and the widget `.swf` files under `Interface/exported/widgets/` are
  built against SkyUI 5.1. The compatibility scripts already look up `SkyUI_SE.esp`
  alongside `SkyUI.esp`; the SkyUI 5.1 Add-On menu replacements have not been rebuilt
  against SkyUI SE and should be verified before shipping that installer option.
- `Scripts/Source/_DE_*.psc` are the Frostfall 2.x scripts. They are still compiled into
  `Scripts/` but appear in no archive manifest, so nothing ships them; their SKSE and
  SkyUI detection is Legendary Edition only and was left alone.
- Last Seed has no archive manifest, no release builder and no readmes, so it cannot be
  packaged from this repository yet.
