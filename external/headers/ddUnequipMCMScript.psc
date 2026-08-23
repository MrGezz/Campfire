Scriptname ddUnequipMCMScript extends SKI_ConfigBase
{Compile-time stub for the Equipping Overhaul MCM script.

Equipping Overhaul (DragonDude1029) is not redistributable and is not part of this repository, but
_Camp_TentSystem.EO_TurnOff() binds to its MCM script, so the compiler needs a header declaring the
members Campfire reads. Only those members are declared, with the types _Camp_TentSystem.pex was
compiled against (confirmed by decompiling it); nothing else about the real script is described.
Never shipped - see pscompile.py.}

int property keyGearedHotkey auto
bool property bTempGearedEnabled auto
