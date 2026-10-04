# Frostfall SkyUI51AddOn - not installed in the SE build (2026-09-05)

`Frostfall_BuildRelease.py` produces `SkyUI51AddOn/` alongside the main package:
`Interface/bartermenu.swf`, `containermenu.swf`, `craftingmenu.swf`, `inventorymenu.swf`,
`Interface/skyui/bottombar.swf`, `itemcard.swf`, plus `interface_package_version.json`
(`installed_package_version 6`, `skyui_required_version 1026`).

Those are SkyUI **5.1** menus with Frostfall's exposure widgets compiled in. SkyUI SE 5.2
ships its own, different builds of the same files (`containermenu.swf` 71,288 bytes in
`SkyUI_SE.bsa` vs 63,512 in the addon). Installing the addon would replace SE menus with LE
ones. Only the main `Frostfall/` package is staged as `Frostfall 3.4.1 SE`.

Per CLAUDE.md the MCM/menu surface Campfire and Frostfall bind to is
`Project Improvement/SkyUI-Community`; the exposure widgets belong there as a first-party
integration. Open design item, together with Frostfall vs Requiem balance and Frostfall vs
Wet and Cold exposure overlap.

Also fixed today: the builder's `skyui_<lang>.txt` copy loop is Legendary-Edition-only
(SkyUI SE loads `frostfall_<lang>.txt` itself); it is now `copy_optional_file`, so the SE
build no longer aborts on a missing `skyui_czech.txt`.
