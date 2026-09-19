scriptname _Seed_Disease extends activemagiceffect

import SeedUtil
import CampUtil
import _SeedInternal
import Utility

Actor property PlayerRef auto

string property debugSystemName = "disease" auto hidden

Spell property DiseaseBaseSpell auto

Spell Property DiseaseStage1 Auto
Spell Property DiseaseStage2 Auto
Spell Property DiseaseStage3 Auto
Spell Property DiseaseStage4 Auto
Spell Property DiseaseStage5 Auto


Keyword Property LocTypeDraugrCrypt Auto
Keyword Property LocTypeHagravenNest Auto
Keyword Property LocTypeAnimalDen Auto
Keyword Property LocTypeDragonPriestLair Auto
Keyword Property LocTypeShipwreck Auto
Keyword Property LocTypeSprigganGrove Auto
Keyword Property LocTypeFalmerHive Auto

Keyword Property LocTypeDungeon Auto
Keyword Property LocTypeCemetery Auto
Keyword Property LocTypeDragonLair Auto
Keyword Property LocTypeVampireLair Auto
Keyword Property LocTypeWerewolfLair Auto
Keyword Property LocTypeDwarvenAutomatons Auto

Keyword Property LocTypeGiantCamp Auto
Keyword Property LocTypeMine Auto
Keyword Property LocTypeFarm Auto
Keyword Property LocTypeJail Auto

Keyword Property LocTypeHouse Auto
Keyword Property LocTypeHabitation Auto
Keyword Property LocTypeInn Auto

Keyword Property LocTypePlayerHouse Auto
Keyword Property LocTypeTemple Auto

Perk Property RestedMarriagePerk Auto
Perk Property BYOHRestedAdoptionPerk Auto
Perk Property RestedPerk Auto
Perk Property RestedWellPerk Auto

int property PROGRESSION_TIME = 24 auto hidden
int property PROGRESSION_VARIANCE = 8 auto hidden

float property update_interval = 1.0 auto hidden

float property Timer auto hidden
float property DiseaseLastUpdateTimeStamp auto hidden
float property TimeGap auto hidden
int property currentStage auto hidden
int property currentProgress auto hidden
Spell[] property diseaseSpells auto hidden
bool property diseaseDelay = false auto hidden
bool property newDisease auto hidden


string property diseaseName auto

; TUTORIAL
globalVariable property _Seed_Setting_DisplayTutorials auto
globalVariable property _Seed_HelpDone_Disease auto
Message property _Seed_Help_Disease auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	; Only run on player
	if(playerRef == akTarget)
		Timer = 0.0
		DiseaseLastUpdateTimeStamp = Utility.GetCurrentGameTime()
		TimeGap = getUpdateTime()
		
		currentStage = 0
		currentProgress = 0
		newDisease = true
		
		; Populate arrays
		diseaseSpells = new Spell[5]
		diseaseSpells[0] = DiseaseStage1
		diseaseSpells[1] = DiseaseStage2
		diseaseSpells[2] = DiseaseStage3
		diseaseSpells[3] = DiseaseStage4
		diseaseSpells[4] = DiseaseStage5
		

		if !diseaseDelay
			modDisease(1)
			newDisease = false
		endif
		 
		RegisterForSingleUpdateGameTime(update_interval)
		; RegisterForSleep()	
		ShowTutorial()
	else
		SeedDebug(0, "[" + debugSystemName + "]: Removing disease - target not player.")
		playerRef.removeSpell(DiseaseBaseSpell)
	endif
EndEvent

Event OnUpdateGameTime()
	; calculate number of hours passed since last update
	float NumOfHours = (Utility.GetCurrentGameTime() - DiseaseLastUpdateTimeStamp) * 24
	Timer += NumOfHours
	DiseaseLastUpdateTimeStamp = Utility.GetCurrentGameTime()
	
	; Update disease periodically
	if Timer >= TimeGap
		Timer = 0.0
		TimeGap = getUpdateTime()
		SeedDebug(0, "[" + debugSystemName + "]: Updating disease")

		; Always progress disease on its first run, otherwise use normal progress chance
		if newDisease
			progressDisease(1)
			newDisease = false
			SeedDebug(0, "[" + debugSystemName + "]: New Disease")
		else
			; update current progress
			SeedDebug(0, "[" + debugSystemName + "]: Tracking disease progress:" + currentProgress)
			currentProgress += progressChance()
		endif
		progressDiseaseWithFocus()
		RegisterForSingleUpdateGameTime(update_interval)
	else
		progressDiseaseWithFocus()
		RegisterForSingleUpdateGameTime(update_interval)
	endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
		SeedDebug(0, "[" + debugSystemName + "]: finishing disease effect")
		removeDiseaseSpells()
endEvent

; progress disease if player is not focussed
function progressDiseaseWithFocus()
	if IsPlayerFocused() == false
		SeedDebug(0, "[" + debugSystemName + "]: Updating disease progress")
		progressDisease(currentProgress)
		currentProgress = 0
	endif
endFunction

; Progress disease to next stage if positive, previous stage if negative
function progressDisease(int progress)
	int newStage = currentStage + progress
	if newStage > diseaseSpells.Length
		newStage = diseaseSpells.Length
	endif
	if newStage != currentStage
		if newStage <= 0 && isPeryiteFollower()
			ModDisease(1)
		else
			modDisease(newStage)
			if newStage <= 0
				debug.notification(GetTranslationHandler().DiseaseCured + GetTranslationHandler().GetDiseaseName(diseaseName))
			else 
				debug.notification(GetTranslationHandler().DiseaseProgressed + GetTranslationHandler().GetDiseaseType(newStage) + GetTranslationHandler().GetDiseaseName(diseaseName))
			endif
		endif
	endif
endFunction

; Move disease to this stage. Negative stage will cure the disease
function modDisease(int stage)

	if stage != currentStage
		SeedDebug(0, "[" + debugSystemName + "]: Disease moving to stage " + stage)
		removeDiseaseSpells()

		; If still sick, add disease effect and update current stage. Otherwise remove cure disease
		if stage > 0
			playerRef.AddSpell(diseaseSpells[stage - 1], false)
			addCurrentDisease(diseaseSpells[stage - 1], stage) 
			currentStage = stage
		else
			playerRef.removeSpell(DiseaseBaseSpell)
		endif	 		
	endIf
endFunction

function removeDiseaseSpells()
	int i = 0
	while i < diseaseSpells.Length
		playerRef.RemoveSpell(diseaseSpells[i])
		removeCurrentDisease(diseaseSpells[i], i + 1)
		i += 1
	endWhile
endFunction


int function getUpdateTime()
	return PROGRESSION_TIME + RandomInt(PROGRESSION_VARIANCE*-1, PROGRESSION_VARIANCE)
endFunction

int function progressChance()
	If isPeryiteFollower()
		Return -1
	Endif

	int result = 0

	float x
	float y
	float diseaseInfectionRate = GetDiseaseInfectionRate()
	
	;The disease evolves or not?
	x = Utility.RandomFloat(0, 100)
	y = Utility.RandomFloat(0, 100)
	
	; Get fatigue level
	int fatigueLevel = GetPlayerFatigueLevel()
	float restedBonus = 0.1
	
	if playerRef.hasperk(RestedMarriagePerk)  || playerRef.hasperk(BYOHRestedAdoptionPerk)
		restedBonus = 2.0
	Elseif playerRef.hasperk(RestedWellPerk)
		restedBonus = 1.0
	Elseif playerRef.hasperk(RestedPerk)
		restedBonus = 0.5
	EndIf

	
	
	
	SeedDebug(0, "[" + debugSystemName + "]: Rested Bonus:" + restedBonus)
	float resistcheck = (playerRef.getav("DiseaseResist") + (((playerRef.getav("Health")*restedBonus/diseaseInfectionRate)*(100-playerRef.getav("DiseaseResist"))/100/(currentStage+diseaseInfectionRate))))
	SeedDebug(0, "[" + debugSystemName + "]: Resist Check:" + ResistCheck +  "/" + x + ": "  + (x < resistcheck ))
	SeedDebug(0, "[" + debugSystemName + "]: Stability Check:" + resistcheck +  "/" + y + ": "  + (y < resistcheck ))

	if x <= resistcheck
		result = -1
		SeedDebug(0, "[" + debugSystemName + "]: Passed resist check")
	Else
		SeedDebug(0, "[" + debugSystemName + "]: Failed resist check")
		If y <= resistcheck
			SeedDebug(0, "[" + debugSystemName + "]: Passed health check")
		Else
			result = 1
			SeedDebug(0, "[" + debugSystemName + "]: Failed health check")
		endif
	endif
	return result
endFunction

float Function GetDiseaseInfectionRate()
	float diseaseInfectionRate = 0
	int locationType = getLocationHazardLevel()
	if locationType == 6 ; Terrible
		diseaseInfectionRate = Utility.RandomFloat((playerRef.getav("Health")/10)+0.1,playerRef.getav("Health")/3)
	Elseif locationType == 5 ;Not Good
		diseaseInfectionRate = Utility.RandomFloat((playerRef.getav("Health")/20)+0.1,playerRef.getav("Health")/5)
	Elseif locationType == 4 ;Not comfortable
		SeedDebug(0, "[" + debugSystemName + "]: This is not a confortable place.")
		diseaseInfectionRate = Utility.RandomFloat((playerRef.getav("Health")/40)+0.1,playerRef.getav("Health")/10)
	Elseif locationType == 1 ;Best
		diseaseInfectionRate = Utility.RandomFloat(0.1,1)
	Elseif locationType == 2 ;Good
		diseaseInfectionRate = Utility.RandomFloat(0.1,2)
	Else ;Average
		diseaseInfectionRate = Utility.RandomFloat(1,playerRef.getav("Health")/20)
	EndIf

	return diseaseInfectionRate
EndFunction

function ShowTutorial()
    if _Seed_Setting_DisplayTutorials.GetValueInt() == 2 && _Seed_HelpDone_Disease.GetValueInt() == 1
        _Seed_Help_Disease.Show()
        _Seed_HelpDone_Disease.SetValue(2)
    endif
endFunction

Bool Function isPeryiteFollower()	
	if seedUtil.GetCompatibilitySystem().isWintersunLoaded		
		spell PeryiteFollower = Game.GetFormFromFile(0x000F8BE5, "Wintersun - Faiths of Skyrim.esp") as spell	; WSN_Daedra_Peryite_Boon1_Spell_Ab "Follower of Peryite" [SPEL:040F8BE5]
		If PeryiteFollower && PlayerRef.HasSpell(PeryiteFollower)
			Return true
		Endif
	Endif	
	Return False
EndFunction