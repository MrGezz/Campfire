Scriptname _Seed_ContainerSpoilScript extends ObjectReference  ;Conditional

import _SeedInternal

GlobalVariable property LastSeedRunning auto
_Seed_ContainerSpoilHandler property _Seed_ContainerSpoilHandlerQuest auto

float nextUpdateTime = 0.000001
float updateInterval = 10.0
bool notSpoiled = true

;Event OnActivate(ObjectReference akActionRef)
Event OnCellLoad()
	SeedDebug(0, "[ContainerSpoilHandler] Opening Food Container")

	if(notSpoiled)
		_Seed_ContainerSpoilHandlerQuest.spoilContainer(Self, true)
		notSpoiled = false
	endif
endEvent

bool function CheckResetTime()
	float currentTime = Utility.GetCurrentGameTime()
	if currentTime  >= nextUpdateTime
		nextUpdateTime = currentTime + updateInterval
		return true
	endif
	return false
endFunction