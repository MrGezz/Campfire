scriptname _Seed_DiseaseAddiction extends _Seed_Disease

import SeedUtil
import _SeedInternal
import Utility

GlobalVariable property _Seed_AddictionResistance auto ; NO LONGER USED
GlobalVariable property _Seed_IsAddicted auto

; TUTORIAL
globalVariable property _Seed_HelpDone_Skooma auto
Message property _Seed_Help_Skooma auto

bool inRemission = false

Event OnEffectStart(Actor akTarget, Actor akCaster)
	debugSystemName = "Addiction"
	_Seed_IsAddicted.setValue(2)
	PROGRESSION_TIME = 36
	PROGRESSION_VARIANCE = 12
	parent.OnEffectStart(akTarget, akCaster)
endEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	_Seed_IsAddicted.setValue(1)
	parent.OnEffectFinish(akTarget, akCaster)
endEvent

Event OnUpdateGameTime()
	SeedDebug(0, "[" + debugSystemName + "]: Updating")
	
	; calculate number of hours passed since last update
	float NumOfHours = (Utility.GetCurrentGameTime() - DiseaseLastUpdateTimeStamp) * 24
	Timer += NumOfHours
	DiseaseLastUpdateTimeStamp = Utility.GetCurrentGameTime()
	
	; Update disease periodically
	if Timer >= TimeGap
		Timer = 0.0
		TimeGap = getUpdateTime()
		SeedDebug(0, "[" + debugSystemName + "]: Updating disease")
	
		;Only run if Player still has disease, otherwise remove all magic effects
		; Not sure if this check is needed, but it can't hurt to do it anyway
		if playerRef.hasSpell(DiseaseBaseSpell)			
			; Always progress disease on its first run, otherwise use normal progress chance
			if !inRemission
				progressDisease(1)
				SeedDebug(0, "[" + debugSystemName + "] Progressing :" + currentProgress)
			else
				progressDisease(-1)
				; update current progress
				SeedDebug(0, "[" + debugSystemName + "] Regressing :" + currentProgress)
			endif
			RegisterForSingleUpdateGameTime(update_interval)
		; If player no longer has base disease, cure this disease
		else
			SeedDebug(0, "[" + debugSystemName + "]: Dispelling diseaes - Player is no longer sick")
			playerRef.removeSpell(DiseaseBaseSpell)
		endif
	else
		RegisterForSingleUpdateGameTime(update_interval)
	endif
EndEvent

; Progress disease to next stage if positive, previous stage if negative
function progressDisease(int progress)
	parent.progressDisease(progress)
	if currentStage >= diseaseSpells.Length
		inRemission = true
	endif	
endFunction

;@override
function ShowTutorial()
    if _Seed_Setting_DisplayTutorials.GetValueInt() == 2 && _Seed_HelpDone_Skooma.GetValueInt() == 1
        _Seed_Help_Skooma.Show()
        _Seed_HelpDone_Skooma.SetValue(2)
    endif
endFunction