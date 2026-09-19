scriptname _Seed_ThirstMeterInterfaceHandler extends CommonMeterInterfaceHandler

import CampUtil

function RegisterForEvents()
	if !GetSKSELoaded()
		return
	endif

	RegisterForModEvent("LastSeed_ForceThirstMeterDisplay", "ForceMeterDisplay")
	RegisterForModEvent("LastSeed_RemoveThirstMeter", "RemoveMeter")
	RegisterForModEvent("LastSeed_UpdateThirstMeter", "UpdateMeterDelegate")
	RegisterForModEvent("LastSeed_CheckMeterRequirements", "CheckMeterRequirements")
endFunction