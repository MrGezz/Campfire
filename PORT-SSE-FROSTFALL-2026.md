# Frostfall 2026 merged into this port

Updated: 2026-10-03. Source: CageTV's **Frostfall 2026** 4.0.0 pre-release (MIT,
<https://github.com/CageTV/Frostfall-2026>, commit `bfb34b9`), an update layer over Chesko's Frostfall 3.4.1 SE.
Upstream ships it as a second mod that overrides the original; here it is part of the Frostfall this repository
builds, so one release folder holds both. Runtime target: Skyrim SE 1.7.104 / SKSE 2.3.1.

Credits: Chesko (Frostfall and Campfire, MIT), CageTV (Frostfall 2026, MIT; `readmes/Frostfall2026_readme.txt` lists
whom that layer credits). `readmes/Frostfall2026_license.txt` is the layer's licence text.

## What came in

| Part | Where it is here | Notes |
|---|---|---|
| Plugin | `Frostfall.esp` | upstream's `release-contents/Frostfall.esp`, taken whole (see "The plugin") |
| Scripts | `Scripts/Source/*.psc`, `Scripts/*.pex` | 80 of upstream's 87 sources byte for byte (line ends aside), 7 kept in this port's version (see "Scripts") |
| SKSE plugin | `FrostfallNative/` -> `SKSE/Plugins/Frostfall.dll` | upstream's sources unchanged, this repository's build (see its README) |
| HUD images | `Interface/frostfall/frostfall_logo.png`, `Interface/frostfall/icons/*.png` | read by `Frostfall.dll` by path, so they ship loose |
| Sounds | `sound/fx/frostfall/*.xwm` | shipped loose beside the `.wav` copies in the archive, as upstream does |
| Embers XD fires | `Frostfall_Embers_FLM.ini` | read by FormList Manipulator; inert without it or without Embers XD (neither is in the Mosais build) |

`Frostfall_BuildRelease.py` copies the loose files into `Frostfall <version> Release/Frostfall`; the three new scripts
(`FrostfallNative`, `_Frost_MakeshiftCamp`, `_Frost_MakeshiftCampTent`) are in `FrostfallArchiveManifest.txt`.
`CampCampfire` belongs to Campfire's archive, so a Frostfall change also needs `Campfire_BuildRelease.py`.

## The plugin

Chesko's `Frostfall.esp` in this repository was unchanged since his commit `2c55fd9`, so every difference between it
and upstream's file is upstream's. Compared subrecord by subrecord (289 of 1,174 records differ in bytes):

- 8 new records, `095001`-`095005`, `095010`-`095012`: the makeshift camp item, activators, lean-to static (the
  Creation Club Camping mesh, by reference), menu, two position markers, and the keyword `_Frost_isInsulatedTent`.
- Edits: `_Frost_ExposureMeterQuest` and `_Frost_WetnessMeterQuest` no longer flash or pin the SkyUI meters at the
  last thresholds (`threshold_should_flash`, `threshold_should_stay_on` all false); stage 20 of
  `_Frost_TrackingQuest` no longer carries the Complete Quest flag; the two bound-cloak effect descriptions lose
  "Unequip to dispel.".
- Everything else is what a Mutagen round trip writes: padding bytes zeroed (`MGEF DATA`, `BOOK DATA`, `EFSH DATA`,
  `CTDA`), an empty `SNDD` on 94 effects, `STAT DNAM` at 12 bytes, perk effects in priority order, region lists
  reordered, path case.

`resave_form44` in the builder accepts the file as is ("verified equivalent"). `RequiemLotDPatch/tools/scriptbindings.py`
on the new plugin against `Scripts/`: 0 bindings a script cannot take.

In the Mosais load order two plugins override Frostfall-owned records: `Requiem - Frostfall (Patch Central).esp`
(210 records) and the Reqtificator output (2 containers). None of them is a record upstream edited - the 11 that
differ in bytes differ in `CTDA` padding only - so no merge and no Reqtificator run follow from the swap; the full
scan after it has no new LOST row.

## Scripts

Seven sources differ from upstream's; each keeps what this port had before and already contains upstream's change:

- `_Frost_Compatibility`, `_Frost_SKSETypesDelegate`, `_Frost_SkyUIConfigPanelScript`: SKSE detection per runtime
  (`GetRequiredSKSEVersion`), `SkyUI_SE.esp` lookups with a missing-widget-manager guard, Survival Mode coexistence.
- `_Frost_ArmorProtectionDatastoreHandler`: light-plugin-safe datastore keys (upstream has these only in its ESL build).
- `_Frost_ExposureSystem`, `_Frost_Main`: the Survival Mode cold-state calls.
- `CampCampfire`: the two calls into `_Frost_MakeshiftCamp` run only when `Frostfall.esp` is loaded, because
  Campfire ships this script and has to work without Frostfall.

Every native call goes through `FrostfallNative`, whose functions are guarded by `IsInstalled()`: without the DLL
Frostfall uses its SkyUI meters, message boxes and manual start.

## Frostfall.dll

Built by `FrostfallNative/build-1.7.104.ps1` against alandtse CommonLibSSE-NG v9.1.0 (`a898f469`) instead of the
colorglass registry's 3.7.0 upstream pins, which takes runtime 1.7.x for Skyrim SE and cannot read the format-5
Address Library. `holescan.py` against the 1.7.104 library: 0 hole pairs linked (the plugin calls
`TES::GetLandHeight`, form lookups, the Papyrus VM and `UI`). SKSE's own compatibility rules: "loaded correctly"
(Address Library, no struct use). It needs SKSE Menu Framework 3 for the bars, the logo and the settings page.

## Not merged

- **Leather Tent add-on**: its lean-to is Tumbajamba's small hide tent mesh, modified with the permission that author
  gave upstream, so it stays out of this repository. In the Mosais build it is installed from upstream's
  `release-contents-leather-tent` as its own MO2 mod, directly below Frostfall. Its scripts are the two makeshift-camp
  scripts above.
- **No Gear Display Dupes** (upstream's replacement `_Camp_TentSystem`): it stops Campfire laying a copy of the
  player's gear beside the bedroll, because a pickup mod can take the copy, and opens Go To Bed's sleep menu when
  `Gotobed.esp` is present. Read and not taken: it removes Chesko's gear display for everyone, and the Mosais build
  has neither a mod that picks up world items on its own nor Go To Bed. The 26 changed lines are in upstream's
  `release-contents-no-gear-dupes` if either enters the build.
- **ESL variant**: renumbers Frostfall's 1,110 records and needs another author's ESL Campfire; FormIDs here stay
  Chesko's, which every patch in the build points at.

## Player-facing

New game recommended (upstream has not tested carrying a 3.4.1 save over). Frostfall starts on its own the first
time the player is outside; the HUD and auto-start settings are in SKSE Menu Framework's panel (Frostfall >
Overview / HUD), the rest stays in the MCM. Make Camp: wear a Creation Club Adventurer's Backpack with a bedroll,
light a campfire, activate it.
