scriptname _Seed_DiseaseManager extends quest

;/
REFERENCED IN: 
_Seed_DiseaseManagerQuest "Disease Manager" [QUST:0705F823]
/;

import Utility
import SeedUtil
import _SeedInternal

Actor property PlayerRef auto

Spell property TrapDiseaseSanguinareVampiris auto

Potion Property _Seed_CureDiseaseSetting auto
Keyword property ActorTypeCreature Auto

FormList Property _Seed_DiseaseSpellsBase Auto
FormList Property _Seed_DiseaseSpellsAll Auto

FormList Property _Seed_DiseaseSpellsCurrentMild Auto		; TODO: Add this
FormList Property _Seed_DiseaseSpellsCurrentModerate Auto	; TODO: Add this
FormList Property _Seed_DiseaseSpellsCurrentSevere Auto		; TODO: Add this
FormList Property _Seed_DiseaseSpellsCurrentCrippling Auto	; TODO: Add this
FormList Property _Seed_DiseaseSpellsCurrentDeadly Auto		; TODO: Add this

FormList property _Seed_DirtyWater auto
FormList property _Seed_SpoiledFoods auto

GlobalVariable Property _Seed_Setting_DiseaseType auto
GlobalVariable Property _Seed_SettingAdditionalDiseases auto

Armor Property DA11RingofNamira Auto
Perk Property DA11Cannibalism Auto

; Locations: Terrible
Keyword Property LocTypeDraugrCrypt Auto
Keyword Property LocTypeHagravenNest Auto
Keyword Property LocTypeAnimalDen Auto
Keyword Property LocTypeDragonPriestLair Auto
Keyword Property LocTypeShipwreck Auto
Keyword Property LocTypeSprigganGrove Auto
Keyword Property LocTypeFalmerHive Auto
; Locations: Bad
Keyword Property LocTypeDungeon Auto
Keyword Property LocTypeCemetery Auto
Keyword Property LocTypeDragonLair Auto
Keyword Property LocTypeVampireLair Auto
Keyword Property LocTypeWerewolfLair Auto
Keyword Property LocTypeDwarvenAutomatons Auto
; Locations: Not Comfortable
Keyword Property LocTypeGiantCamp Auto
Keyword Property LocTypeMine Auto
Keyword Property LocTypeFarm Auto
Keyword Property LocTypeJail Auto
; Locations: Good
Keyword Property LocTypeHouse Auto
Keyword Property LocTypeHabitation Auto
Keyword Property LocTypeInn Auto
Keyword Property LocTypeGuild Auto
FormList Property _Seed_SafeLocations Auto
; Locations: Best
Keyword Property LocTypePlayerHouse Auto
Keyword Property LocTypeTemple Auto


GlobalVariable Property _Seed_Setting_DiseaseChanceRawFood auto
GlobalVariable Property _Seed_Setting_DiseaseChanceDirtyWater auto
GlobalVariable Property _Seed_Setting_DiseaseChanceStaleFood auto
GlobalVariable Property _Seed_ProgressiveDiseasesEnabled auto



formList[] diseaseLists

function startSystem()
	_Seed_ProgressiveDiseasesEnabled.setValue(2)
	diseaseLists = new formList[5]
	diseaseLists[0] = _Seed_DiseaseSpellsCurrentMild
	diseaseLists[1] = _Seed_DiseaseSpellsCurrentModerate
	diseaseLists[2] = _Seed_DiseaseSpellsCurrentSevere
	diseaseLists[3] = _Seed_DiseaseSpellsCurrentCrippling
	diseaseLists[4] = _Seed_DiseaseSpellsCurrentDeadly
	
	;_Seed_Setting_DiseaseType.setValue(2)
endFunction

;Heal diseases on stop
function StopSystem()
	_Seed_ProgressiveDiseasesEnabled.setValue(1)
	clearDiseases()
endFunction

function clearDiseases()
	int i = 0
	while i < diseaseLists.Length
		diseaseLists[i].revert()
		i += 1
	endWhile
endFunction

; Add a disease to the list of diseases the player has
function addCurrentDisease(Spell disease, int stage)
	diseaseLists[stage - 1].AddForm(disease)
endFunction

; Remove a disease to the list of diseases the player has
function removeCurrentDisease(Spell disease, int stage)
	diseaseLists[stage - 1].RemoveAddedForm(disease)
endFunction

; Calculates disease effects on vitality
float function GetDiseaseTargetMod()
    float result = 0
	if _Seed_DiseaseSpellsCurrentDeadly.GetSize() > 0
		result = -130.0
	elseif _Seed_DiseaseSpellsCurrentCrippling.GetSize() > 0
		result = -110.0	
	elseif _Seed_DiseaseSpellsCurrentSevere.GetSize() > 0
		result = -80.0	
	elseif _Seed_DiseaseSpellsCurrentModerate.GetSize() > 0
		result = -50.0	
	elseif _Seed_DiseaseSpellsCurrentMild.GetSize() > 0
		result = -20.0
	endif
	return result
endFunction


; Apply a random disease to the player
Function applyRandomDisease(float DiseaseChance, bool includeVampirism = false)	
	; Check disease chance
	if randomFloat(0.0, 100.0) <= diseaseChance
		if(includeVampirism && randomInt(1,70) == 1)
			; Apply Vampirism (1:70 chance)
			PlayerRef.DoCombatSpellApply(TrapDiseaseSanguinareVampiris, PlayerRef)
		else
			; Apply Other Disease
			if(_Seed_SettingAdditionalDiseases.getValue() == 2)
				int i = Utility.RandomInt(0, _Seed_DiseaseSpellsAll.GetSize() - 1)	
				PlayerRef.DoCombatSpellApply(_Seed_DiseaseSpellsAll.GetAt(i) as Spell, PlayerRef)			
			else
				int i = Utility.RandomInt(0, _Seed_DiseaseSpellsBase.GetSize() - 1)	
				PlayerRef.DoCombatSpellApply(_Seed_DiseaseSpellsBase.GetAt(i) as Spell, PlayerRef)
			endif
		endif
	endIf
EndFunction


float Function getDiseaseChance(Form akBaseObject, Actor Target)
	Potion theFood = akBaseObject as Potion
    if !theFood
		return 0
	endIf
	
	int foodType = GetFoodType(theFood)
	
	;Raw Food
	if cantEatRawFood(Target) && (foodType == 2 || foodType == 4 || foodType == 6 || foodType == 8)
		return _Seed_Setting_DiseaseChanceRawFood.getValue()
	; Dirty Water
	elseif(_Seed_DirtyWater.HasForm(akBaseObject))
		return _Seed_Setting_DiseaseChanceDirtyWater.getValue()
	; Spoiled Food
	elseif(_Seed_SpoiledFoods.HasForm(akBaseObject))
		return _Seed_Setting_DiseaseChanceStaleFood.getValue()
	endif
	return 0
endFunction


;TODO: Move this into autoEat Method?
bool function cantEatRawFood(Actor Target)
	return !Target.IsEquipped(DA11RingofNamira) && !Target.HasPerk(DA11Cannibalism)
endFunction

;/
1: best
2: good
3: average
4: not confortable
5: Not Good
6: Terrible
/;
int Function getLocationHazardLevel(bool includeMarkedLocations = true)
	Location playerLocation = playerRef.GetCurrentLocation()
	if playerLocation != None
		if includeMarkedLocations && _Seed_SafeLocations.HasForm(playerLocation)
			SeedDebug(0, "[SeedInternal]: This is a good place to be.")
			return 2
		elseif (playerLocation.HasKeyword(LocTypeDraugrCrypt) || playerLocation.HasKeyword(LocTypeHagravenNest)  || playerLocation.HasKeyword(LocTypeAnimalDen)  || playerLocation.HasKeyword(LocTypeDragonPriestLair)  || playerLocation.HasKeyword(LocTypeShipwreck)  || playerLocation.HasKeyword(LocTypeSprigganGrove)  || playerLocation.HasKeyword(LocTypeFalmerHive) )
			SeedDebug(0, "[SeedInternal]: This is a terrible place to be.")
			return 6
		Elseif (playerLocation.HasKeyword(LocTypeDungeon) || playerLocation.HasKeyword(LocTypeCemetery) || playerLocation.HasKeyword(LocTypeDragonLair)  || playerLocation.HasKeyword(LocTypeVampireLair)  || playerLocation.HasKeyword(LocTypeWerewolfLair)  || playerLocation.HasKeyword(LocTypeDwarvenAutomatons)) 
			SeedDebug(0, "[SeedInternal]: This is not a good place to be.")
			return 5
		Elseif (playerLocation.HasKeyword(LocTypeGiantCamp) || playerLocation.HasKeyword(LocTypeMine) || playerLocation.HasKeyword(LocTypeFarm) || playerLocation.HasKeyword(LocTypeJail))
			SeedDebug(0, "[SeedInternal]: This is not a confortable place.")
			return 4
		Elseif (playerLocation.HasKeyword(LocTypeHouse) || playerLocation.HasKeyword(LocTypeHabitation) || playerLocation.HasKeyword(LocTypeInn)) || playerLocation.HasKeyword(LocTypeGuild)
			SeedDebug(0, "[SeedInternal]: This is a good place to be.")
			return 2
		Elseif (playerLocation.HasKeyword(LocTypePlayerHouse) || playerLocation.HasKeyword(LocTypeTemple))
			SeedDebug(0, "[SeedInternal]: This is the best place to be.")
			return 1
		EndIf
	EndIf
	SeedDebug(0, "[SeedInternal]: This is an average place to be.")
	return 3
EndFunction
