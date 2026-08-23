Scriptname ddUnequipHandlerScript extends ReferenceAlias
{Compile-time stub for the Equipping Overhaul key handler alias script.

Equipping Overhaul (DragonDude1029) is not redistributable and is not part of this repository, but
_Camp_TentSystem.EO_TurnOff() calls its OnKeyDown handler directly to toggle the geared-up state,
so the compiler needs a header that declares it. OnKeyDown is the SKSE Form event; nothing else
about the real script is described. Never shipped - see pscompile.py.}

Event OnKeyDown(int KeyCode)
EndEvent
