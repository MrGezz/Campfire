scriptname _Seed_ThirstSystem_Follower extends _Seed_ThirstSystem

import CampUtil
import _SeedInternal
import Utility

float property update_interval = 0.5 auto hidden
float property last_update_time auto hidden

int DRINKTYPE_ALE = 1
int DRINKTYPE_WINE = 2
int DRINKTYPE_LIQUOR = 3
float ALE_AMOUNT = 6.0
float WINE_AMOUNT = 16.0
float LIQUOR_AMOUNT = 26.0
float AMOUNT_VARIANCE = 5.0
float SOBER_RATE = 5.0
float DRUNK_LEVEL = 10.0

float alcoholLevel

; Overrides _Seed_AttributeSystem
bool function isPlayer()
	return false
endFunction

function StartUp()
	parent.startup()
	alcoholLevel = 0
endFunction

bool function isSober()
	bool result = alcoholLevel < DRUNK_LEVEL
	SeedDebug(0, "[" + debugSystemName + "] Checking if NPC " + followerIndex + " is sober: " + result + " (" + alcoholLevel +"/"+ DRUNK_LEVEL + ")")
	return alcoholLevel < DRUNK_LEVEL
endfunction

function AlcoholConsumed(int drinktype)
	if alcoholLevel <= 0
		last_update_time = GetCurrentGameTime() * 24.0
	endif

    float variance = (RandomFloat(0.0, AMOUNT_VARIANCE) - (AMOUNT_VARIANCE / 2)) ; +/- half of Variance (random)

    if drinktype == DRINKTYPE_ALE
		alcoholLevel = alcoholLevel + ALE_AMOUNT + variance
    elseif drinktype == DRINKTYPE_WINE
        alcoholLevel = alcoholLevel + ALE_AMOUNT + variance
    elseif drinktype == DRINKTYPE_LIQUOR
        alcoholLevel = alcoholLevel + ALE_AMOUNT + variance
    endif
endFunction

;TODO: set last_update_time to current time if alcohol level was previously zero
Event OnUpdateGameTime()
    parent.onUpdateGameTime()
	if alcoholLevel > 0
		float this_time = GetCurrentGameTime() * 24.0
		int cycles = Math.Floor((this_time - last_update_time) * 2)
		float drunk_decrease = (SOBER_RATE * cycles)
		SeedDebug(0, "[" + debugSystemName + "]: Decreasing Drunk by: " + drunk_decrease)
		DecreaseDrunk(drunk_decrease)
		SeedDebug(0, "[" + debugSystemName + "]: Current Drunk: " + alcoholLevel )
		last_update_time = this_time
	endif
EndEvent

function DecreaseDrunk(float amount)
	SeedDebug(0, "[" + debugSystemName + "]: DecreaseDrunk()")
    if alcoholLevel - amount <= 0
        alcoholLevel = 0
    else
        alcoholLevel = alcoholLevel - amount
    endif
endFunction
