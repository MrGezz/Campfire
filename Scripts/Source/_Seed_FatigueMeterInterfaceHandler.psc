scriptname _Seed_FatigueMeterInterfaceHandler extends CommonMeterInterfaceHandler

import CampUtil

function RegisterForEvents()
	if !GetSKSELoaded()
		return
	endif

	RegisterForModEvent("LastSeed_ForceFatigueMeterDisplay", "ForceMeterDisplay")
	RegisterForModEvent("LastSeed_RemoveFatigueMeter", "RemoveMeter")
	RegisterForModEvent("LastSeed_UpdateFatigueMeter", "UpdateMeterDelegate")
	RegisterForModEvent("LastSeed_CheckMeterRequirements", "CheckMeterRequirements")
endFunction