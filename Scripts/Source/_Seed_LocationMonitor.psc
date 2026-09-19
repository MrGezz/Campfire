scriptname _Seed_LocationMonitor extends ReferenceAlias

import seedUtil

_Seed_ConditionValues property conditions auto

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	;Location Cleared
	if akNewLoc && akNewLoc.IsCleared()
		conditions.CurrentLocationCleared = true
	else
		conditions.CurrentLocationCleared = false
	endif
	
	if isInOblivion()
		Conditions.IsPlayerInOblivion = true
	else
		Conditions.IsPlayerInOblivion = false
	endif
endEvent
