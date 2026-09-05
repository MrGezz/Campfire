This repository is home to development of all of the Skyrim Survival mods by Chesko.

![Campfire](http://i.imgur.com/P0CxWke.png)
![Frostfall](http://i.imgur.com/OdLeSuh.png)

## Building

    python Campfire_BuildRelease.py
    python Frostfall_BuildRelease.py

Each builder asks for a version and a runtime (`C` for Legendary Edition, `SE` for Special
Edition), packs the BSA with that runtime's `Archive.exe`, and writes a release directory
and zip next to the checkout. `external/README.md` covers the per-runtime dependencies.

    python LastSeed_BuildRelease.py

Last Seed builds the same way. It has no installer and no SkyUI add-on; the release is the
plugin, the BSA, the `LastSeedData` placeholder and the readmes.

`_Camp_ManifestCheck.bat`, `_Frost_ManifestCheck.bat` and `_Seed_ManifestCheck.bat` cross-check
each manifest against the checkout. All three find every file they list. The warnings they
still print are files in the checkout that no manifest ships — the `_Camp_FSBackpack*`
textures, the `_Frost_*_test` scripts and similar — and predate this work.

### Third-party scripts in this checkout

| Files | Source |
| --- | --- |
| `Scripts/Source/CommonArrayHelper.psc`, `CommonHelperFunctions.psc`, `CommonMeterInterfaceHandler.psc`, `Common_SKI_MeterWidget.psc`, `FallbackEvent*.psc` and their `.pex` | [CheskoPapyrusShared](https://github.com/chesko256/CheskoPapyrusShared) (MIT), compiled here with `pscompile.py`. `CommonArrayHelper.psc` carries one addition over upstream: Armor-typed `LinkedArrayAddArmor` / `LinkedArrayRemoveArmor` / `LinkedArrayHasArmor` / `LinkedArraySortArmor`. Papyrus arrays are not covariant, `_Frost_LegacyArmorDatastore` keeps its Frostfall 3.0 data in `Armor[]` quartets, and the Frostfall 3.4 release bytecode already calls these by name — the upstream repository only ever published the `Form[]` versions. |
| `Scripts/Source/C00JorrvaskrFightAthisScript.psc`, `C00JorrvaskrFightNjadaScript.psc` | Enai Siaion's Brawl Bugs Patch versions, the same edit as the other `C00*` scripts here: `OnHit` only ends the brawl for a weapon, hostile spell or scroll. Requiem ships the identical files. |
| `external/headers/ddUnequip*.psc` | Compile-only stubs for the two Equipping Overhaul scripts `_Camp_TentSystem.EO_TurnOff()` binds to. Equipping Overhaul is not redistributable; the stubs declare exactly the members Campfire reads, with the types `_Camp_TentSystem.pex` was compiled against, and are never shipped. |

`CampfireArchiveManifest.txt` no longer lists `meshes/mps/mpsguideparticles.nif`. Nothing
references it — no record in `Campfire.esm`, no script, no mesh — and it was never committed.

### Compiling scripts

`Scripts/*.pex` is what the game runs, and it has to be rebuilt whenever `Scripts/Source/*.psc`
changes. `pscompile.py` does that with the Special Edition toolchain:

    python pscompile.py --check            # which .psc are newer than their .pex
    python pscompile.py --stale            # rebuild those
    python pscompile.py _Frost_ClimateSystem _Camp_Compatibility

One `.pex` serves both runtimes — the bytecode format did not change between Legendary and
Special Edition, and the scripts guard every SKSE64-only call behind the runtime detection in
the `*_Compatibility` scripts — so the compiler is pointed at the Special Edition headers. It
finds them in the reference checkouts next to this one: `skse64` (the `vanilla` + `modified`
fragments are merged on every run, the way `skse64/scripts/build.py` does it), `Lilac`, and
`SkyUI-Community` (the SkyUI 5.1 SDK in `skyui/` predates `AddInputOption`, which the config
panels use). PapyrusUtil SE's headers come from `external/SkyrimSE/Scripts/Source`, which has to
win over the Legendary Edition copies in `Scripts/Source` — the compiler resolves referenced
scripts from its working directory before the import list, so `pscompile.py` never runs from
`Scripts/Source`. Paths are overridable through `SKYRIMSE_PATH`, `SKSE64_SCRIPTS`,
`SKYUI_SCRIPTS` and `LILAC_SCRIPTS`.

`--check` judges staleness by git commit time, so it survives a fresh clone. One source is
listed as known not to compile: `_Frost_HarvestTreeBranchGenerator.psc` casts to a
`_Camp_BranchTreeHarvestNodeController` that exists in neither Campfire nor Frostfall. Frostfall
ships it, but the committed `.pex` carries the same cast, so rebuilding would change nothing;
it is a Frostfall 3.x issue that predates the Special Edition work and is left alone.

The decompiled output of a rebuilt script differs from Chesko's committed bytecode only where
the source changed — `_Frost_ClimateSystem` by the `ws == Tamriel` guard that was in the source
but never in the `.pex`, `_Camp_ConditionValues` by the `IsSpecialEdition` property — which is
the check that the header set above is the right one.

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
- `0x00000BD7` for `SkyrimVR.esm` in the three `DetectGameRuntime` functions is still
  unverified; there is no Skyrim VR install here to read it from.

### Last Seed

Last Seed is the 2017 Prologue (0.1) plus the Special Edition work above, and can now be
packaged: `LastSeedArchiveManifest.txt`, `LastSeedArchiveBuilder.txt`,
`LastSeed_BuildRelease.py`, `_Seed_ManifestCheck.bat`, the three `readmes/LastSeed_*.txt` and
the `SKSE/Plugins/LastSeedData` placeholder are all new. So is
`Interface/Translations/lastseed_english.txt`: the MCM has always used `$LastSeed...` keys and
no translation file was ever committed, so every page showed raw keys. The 86 English strings
follow the Frostfall and Campfire files where the option is the same (profiles, meters) and
describe the option from the script where it is not.

Last Seed 0.2 also gains eating and drinking animations (`_Seed_PlayerEatMonitor.psc`) and a
working Effects & Notifications MCM page. They use four vanilla idle records —
`IdleEatingStandingStart`, `IdleDrinkingStandingStart`, `ChairEatingStart`, `ChairDrinkingStart`,
ended with `IdleStop_Loose` — which is exactly what iNeed does, without FNIS or any behaviour
file, wrapped in Frostfall's hand-warming conventions (third person while it plays, retry on
`PlayIdle`, followers through `CampUtil.GetTrackedFollower`). iNeed's own sounds were not
copied: the folder carries no licence. The two settings behind it, `_Seed_Setting_Animation`
and `_Seed_Setting_FollowerAnimation`, were added to `LastSeed.esp` with `pluginglob.py`
(clones an existing GLOB under a new EditorID and FormID; `plugindiff.py` confirms nothing else
changed) and are looked up by FormID from the scripts, so no Creation Kit pass was needed to
bind properties. `LastSeed.esp.before-pluginglob` is the pre-edit plugin and can be deleted
once the resave is done.

The manifest ships the 42 `_Seed*`/`SeedUtil`/`LastSeedAPI`/`QF__Seed_*` scripts that
`LastSeed.esp` and each other reference. Three sources with no `.pex` — `_Seed_ConsumableDatastore`,
`_Seed_SKI_StatusWidget`, `_Seed_SpoilSystem_old` — are referenced by nothing and are not shipped;
neither is `meshes/lastseed/_Seed_PerishedFood01_SE.nif`, a hand-converted copy of the mesh
the build converts anyway.

The provisioning skill tree is a stub and is no longer registered with Campfire.
`LastSeed.esp` carries the controller activator `_Seed_PerkNodeController_Provisioning`
(`04006B0E`) and the two globals `ProvisioningPerkPoints` / `ProvisioningPerkPointProgress`,
but no perk nodes, lines, position references or skill description message. The controller
still attaches `_Camp_PerkNodeControllerBehavior`, the Campfire-internal script name that
Campfire dropped on 2016-01-28 (commit `85bfbea`) for `CampPerkNodeControllerBehavior`, and
its 27 property values are the camping tree's (`_Camp_PN_Camping_1Resourceful`,
`CampingPerkPoints`, `_Camp_MainQuest` ...) under this plugin's own master index, where none of
them exist. Registered, that hands Campfire an empty tree that fails the first time it is
opened (`CampCampfire.ShowPerkDesc` casts the placed controller and calls
`required_skill_description.Show` on None). `_Seed_Compatibility.IsProvisioningSkillTreeImplemented()`
returns false and gates both `RegisterCampfireSkill` and `UnregisterCampfireSkill`; it is a
function rather than a property so the answer is never baked into a save. Building the tree
(nodes with `CampPerkNode`, lines, position references, a skill message, perks, and the
controller re-pointed at `CampPerkNodeControllerBehavior` with `PerkNode00`-style names) is
Last Seed completion work. Art of the Catch carries the same kind of stub, but nothing
references it, so it stays inert; see `ArtOfTheCatch/Scripts/README.md`.
