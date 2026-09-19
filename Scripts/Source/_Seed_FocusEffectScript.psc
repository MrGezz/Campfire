scriptname _Seed_FocusEffectScript extends ActiveMagicEffect
{If the player is in a stressful situation, the player's needs 
should be suspended.}

import SeedUtil
import CampUtil
import _SeedInternal

GlobalVariable property _Seed_Setting_Focus auto
GlobalVariable property _Seed_IsPlayerFocused auto
GlobalVariable property _Seed_HelpDone_Focus auto
GlobalVariable property _Seed_Setting_DisplayTutorials auto

GlobalVariable property _Seed_Setting_FocusNotifications auto

Message property _Seed_FocusOnMsg auto
Message property _Seed_FocusOffMsg auto
Message property _Seed_Help_Focus auto
Message property _Seed_Help_FocusSKSE auto

; @TODO: Toggle focus off
Event OnEffectStart(Actor akTarget, Actor akCaster)
    bool wasFocused = _Seed_IsPlayerFocused.GetValueInt() == 2

	_Seed_IsPlayerFocused.SetValueInt(2)
    if !wasFocused
		if _Seed_Setting_FocusNotifications.GetValue() == 2
			_Seed_FocusOnMsg.Show()
		endif
        SeedDebug(0, "[Focus] Player is now focused.")
        ShowTutorial_Focus()
    endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	bool wasFocused = _Seed_IsPlayerFocused.GetValueInt() == 2

	_Seed_IsPlayerFocused.SetValueInt(1)
	if wasFocused
		if _Seed_Setting_FocusNotifications.GetValue() == 2
			_Seed_FocusOffMsg.Show()
		endif
		
        GetHungerSystem().RunDelayedCycles()
        GetThirstSystem().RunDelayedCycles()
        GetFatigueSystem().RunDelayedCycles()
        SeedDebug(0, "[Focus] Player no longer focused.")
    endif
	
	;SendModEvent("LastSeed_FocusFinished")
	int handle = ModEvent.Create("LastSeed_FocusFinished")
    if (handle)
        ModEvent.Send(handle)
    endIf
EndEvent

function ShowTutorial_Focus()
    if _Seed_Setting_DisplayTutorials.GetValueInt() == 2 && _Seed_HelpDone_Focus.GetValueInt() == 1
        if GetSKSELoaded()
			_Seed_Help_FocusSKSE.Show()
		else
			_Seed_Help_Focus.Show()
		endif
        _Seed_HelpDone_Focus.SetValue(2)
    endif
endFunction