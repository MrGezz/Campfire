scriptname _Seed_AlcoholSystem extends _Seed_AlcoholBaseSystem

import Utility
import SeedUtil

GlobalVariable property _Seed_Setting_AlcoholMulti_Ale auto
GlobalVariable property _Seed_Setting_AlcoholMulti_Wine auto
GlobalVariable property _Seed_Setting_AlcoholMulti_Spirits auto
GlobalVariable property _Seed_SettingPlayerIsLich auto



int DRINKTYPE_ALE = 1
int DRINKTYPE_WINE = 2
int DRINKTYPE_LIQUOR = 3


float ALE_AMOUNT = 12.0
float WINE_AMOUNT = 32.0
float LIQUOR_AMOUNT = 52.0
float AMOUNT_VARIANCE = 10.0


function AlcoholConsumed(int drinktype)
	if GetMonsterHandler().getVampireSettings(false, false, true) || _Seed_SettingPlayerIsLich.getValueInt() == 2
		return
	endif

	; Set debug name
	if debugSystemName == ""
		debugSystemName = "Alcohol"
	endif

    if SystemEnabled.getValueInt() == 2
		float variance = (RandomFloat(0.0, AMOUNT_VARIANCE) - (AMOUNT_VARIANCE / 2)) ; +/- half of Variance (random)
	
		float amount = 0
		
		if drinktype == DRINKTYPE_ALE
			amount = (ALE_AMOUNT + variance) * _Seed_Setting_AlcoholMulti_Ale.getValue()
		elseif drinktype == DRINKTYPE_WINE
			amount = (WINE_AMOUNT + variance) * _Seed_Setting_AlcoholMulti_Wine.getValue()
		elseif drinktype == DRINKTYPE_LIQUOR
			amount = (LIQUOR_AMOUNT + variance) * _Seed_Setting_AlcoholMulti_Spirits.getValue()
		endif
		
		; Reduce Drunk Amount for Vampires
		if GetMonsterHandler().getVampireSettings(false, true, false)
			amount = amount / 2
		endif
				
		IncreaseDrunk(amount)
		
		;if completelySober
			last_update_time = GetCurrentGameTime() * 24.0
			RegisterForSingleUpdateGameTime(update_interval)
			;completelySober = false;
		;endif				   
	endif
endFunction