Scriptname _Seed_ConsumeManagerPlayer extends _Seed_ConsumeManager

import _SeedInternal
import SeedUtil

float property waitTimePlayer = 0.1 auto hidden

function startAutoConsuming()	
	; Player Eat and Drink Spells
    PlayerEating()
    PlayerDrinking()
	
	;Auto-Eating
	Player_AutoEating()

    
    ;Auto-Drinking
    Player_AutoDrinking()
	
	;Auto-Feeding
	Player_Feeding()
	Player_AutoFeeding()
    
	if playerEating || playerDrinking || playerFeeding 
		registerForSingleUpdate(0.25)
		SeedDebug(0, "[ConsumeManager] still auto-consuming...")	
    elseif playerAutoEating || playerAutoDrinking || playerAutoFeeding; || ((hungerSoundQueued || thirstSoundQueued || fatigueSoundQueued) && _Seed_Setting_NeedsSFX.getValue() != 2)
		registerForSingleUpdate(1.0)
		SeedDebug(0, "[ConsumeManager] still auto-consuming...")
    else
		isUpdating = false
		SeedDebug(0, "[ConsumeManager] Stopping auto-consuming")
   	
		; PLAY SOUNDS
		If _Seed_Setting_NeedsSFX.getValue() == 2
			PlaySounds()
		endif
		
		; Show Player Messages & Animations
		if hungerMessage != none
			hungerMessage.show()
			hungerMessage = none
		endif
		if ThirstMessage != none
			ThirstMessage.show()
			ThirstMessage = none
		endif
		if AlcoholMessage != none
			AlcoholMessage.show()
			AlcoholMessage = none    
		Endif
		
		if EatAnimationQueued
			SeedDebug(0, "[ConsumeManager] END: Playing Eat Animation")
			GetAnimationHandler().eatAnimation(0)
		elseif DrinkAnimationQueued
			SeedDebug(0, "[ConsumeManager] END: Playing Drink Animation")
			GetAnimationHandler().DrinkAnimation(0)
		endif
		EatAnimationQueued = false
		DrinkAnimationQueued = false
		_Seed_AutoEatenPlayer.Revert()
		_Seed_AutoDrankPlayer.Revert()
    endif
endFunction


Function StopSystem()
	playerAutoEating = false
	PlayerAutoDrinking = false
	playerFeeding = false
	playerEating = false
	PlayerDrinking = false
	PlayerFeeding = false
	;parent.stopSystem()
EndFunction