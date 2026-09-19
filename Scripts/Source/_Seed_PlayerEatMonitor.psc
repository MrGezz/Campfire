scriptname _Seed_PlayerEatMonitor extends ReferenceAlias
;/
REFERENCED IN: 
_Seed_MainQuest "Last Seed Main Quest" [QUST:07000D72] \ Aliases
/;
import CommonArrayHelper
import SeedUtil
import CampUtil
import FrostUtil
import _SeedInternal


Keyword property VendorItemFood auto
Keyword property VendorItemFoodRaw auto
GlobalVariable property LastSeedRunning auto
GlobalVariable property _Seed_Setting_DiminishingFoodReturns auto
GlobalVariable property _Seed_RestoreHungerMinorAmount auto
GlobalVariable property _Seed_RestoreHungerMajorAmount auto
GlobalVariable property _Seed_RestoreHungerSuperiorAmount auto
GlobalVariable property _Seed_RestoreHungerMassiveAmount auto
GlobalVariable property _Seed_RestoreThirstMajorAmount auto
GlobalVariable property _Seed_SaltIncreaseThirstAmount auto
GlobalVariable property _Seed_Setting_DisplayTutorials auto
GlobalVariable property _Seed_SettingVampireMonitoring auto
GlobalVariable property _Seed_SettingPlayerIsLich auto

GlobalVariable property _Seed_Setting_FoodPortioning auto

FormList property _Seed_Food_RestoreHungerMinor auto
FormList property _Seed_Food_RestoreHungerMajor auto
FormList property _Seed_Food_RestoreHungerSuperior auto
FormList property _Seed_Food_RestoreHungerMassive auto
FormList property _Seed_RecentlyEatenFood auto
FormList property _Seed_Salted auto
FormList property _Seed_ForceFoodPortioning auto

FormList property _Seed_DrinkAlcoholicAle auto
FormList property _Seed_DrinkAlcoholicWine auto
FormList property _Seed_DrinkAlcoholicSpirit auto
FormList property _Seed_DrinkSkoomaWeak auto
FormList property _Seed_DrinkSkoomaStrong auto

FormList property _Seed_PortionsToProvisionsList auto

FormList property _Seed_BloodPotions auto

Actor property PlayerRef auto

ObjectReference property _Seed_ProvisionsContainerRef Auto
GlobalVariable property _Seed_ProvisionsAddPortions auto

Potion property DLC1BloodPotion auto

; HELP MESSAGES
GlobalVariable property _Seed_HelpDone_Variety auto
GlobalVariable property _Seed_HelpDone_Food auto
GlobalVariable property _Seed_HelpDone_Alcohol auto
GlobalVariable property _Seed_HelpDone_SkoomaDrank auto
GlobalVariable property _Seed_HelpDone_Stew auto
GlobalVariable property _Seed_HelpDone_DangerousFood auto
Message property _Seed_Help_Variety auto
Message property _Seed_Help_Food auto
Message property _Seed_Help_Alcohol auto
Message property _Seed_Help_SkoomaDrank auto
Message property _Seed_Help_Stew auto
Message property _Seed_Help_DangerousFood auto

Potion property DLC1RedwaterDenSkooma auto

;/
FOODTYPE_BREAD             = 1 
FOODTYPE_MEAT_RAW          = 2 
FOODTYPE_MEAT_COOKED       = 3 
FOODTYPE_SMALLGAME_RAW     = 4 
FOODTYPE_SMALLGAME_COOKED  = 5 
FOODTYPE_FISH_RAW          = 6 
FOODTYPE_FISH_COOKED       = 7 
FOODTYPE_SEAFOOD_RAW       = 8 
FOODTYPE_SEAFOOD_COOKED    = 9 
FOODTYPE_VEGETABLE         = 10
FOODTYPE_FRUIT             = 11
FOODTYPE_CHEESE            = 12
FOODTYPE_TREAT             = 13
FOODTYPE_PASTRY            = 14
FOODTYPE_STEW              = 15
FOODTYPE_CHEESEBOWL        = 16
DRINKTYPE_MILK             = 17
DRINKTYPE_ALCOHOLIC        = 18
DRINKTYPE_NONALCOHOLIC     = 19
/;

;float  = 20


Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	if LastSeedRunning.GetValueInt() == 2
		;If blood potion, restore vampire needs
		if _Seed_BloodPotions.HasForm(akBaseObject) && getMonsterHandler().getVampireSettings(false, true, true)
			getMonsterHandler().vampireFeed()
		elseif IsFood(akBaseObject) 
			; Animate eating and drinking
			bool animateEat = false
			bool animateDrink = false
			
			;Check if food exists
			Potion theFood = akBaseObject as Potion
			if !IsKnownFood(theFood, false, true)
				GetCustomiseFoodHandler().classifyFood(theFood)
			endIf
						
			int foodType = GetFoodType(theFood)
			
			;Process Multi-Part Food
			Potion multiPart = GetFoodDatastoreHandler().GetMultiPartFoodResult_Array(theFood)
			if multiPart
				int aiCount  = GetFoodDatastoreHandler().GetMultiPartFoodQuantity_Array(theFood)
				SeedDebug(0, "[_Seed_PlayerEatMonitor] Found Multi-Part food - " + theFood + " -> " + multiPart + " x " + aiCount)
				bool abSilent  = false
				if multiPart == theFood && aiCount == 1
					abSilent  = true
				endif
				bool listHasFood = _Seed_PortionsToProvisionsList.Find(theFood) != -1
				if _Seed_ProvisionsAddPortions.GetValueInt() == 2 || listHasFood
					SeedDebug(0, "[_Seed_PlayerEatMonitor] Adding Portions to provisions Container")
					_Seed_ProvisionsContainerRef.AddItem(multiPart, aiCount, abSilent)
					if listHasFood
						_Seed_PortionsToProvisionsList.RemoveAddedForm(theFood)
					endif
				else
					SeedDebug(0, "[_Seed_PlayerEatMonitor] Adding Portions to Player")
					PlayerRef.AddItem(multiPart, aiCount, abSilent)
				endif
				
				; Add multi-part food to recently eaten food list
				if(addMultiPart)
					_Seed_RecentlyEatenFood.AddForm(multiPart)
				endif
			else
				SeedDebug(0, "[_Seed_PlayerEatMonitor] Found non-multiPart Food " + theFood)
			endif
			
			;Don't Restore Hunger and Thirst if Player is Lich
			if(_Seed_SettingPlayerIsLich.getValue() == 2)
				return
			endif
			
			float amountToRestore = GetFoodDatastoreHandler().getFoodRestoreAmount(theFood)
			;TODO: Delete this
			;/
			float amountToRestore = 0
			if _Seed_Food_RestoreHungerMinor.HasForm(akBaseObject)
				amountToRestore = _Seed_RestoreHungerMinorAmount.GetValue()
			elseif _Seed_Food_RestoreHungerMajor.HasForm(akBaseObject)
				amountToRestore = _Seed_RestoreHungerMajorAmount.GetValue()
			elseif _Seed_Food_RestoreHungerSuperior.HasForm(akBaseObject)
				amountToRestore = _Seed_RestoreHungerSuperiorAmount.GetValue()
			elseif _Seed_Food_RestoreHungerMassive.HasForm(akBaseObject)
				amountToRestore = _Seed_RestoreHungerMassiveAmount.GetValue()
			endif
			/;
			
			; Raw food gives disease
			float diseaseChance = getDiseaseChanceFloat(akBaseObject, PlayerRef)
			if diseaseChance > 0
				ShowTutorial_DangerousFood()
				catchRandomDisease(diseaseChance)
			endif
				
			; Apply alcohol effects
            if (foodType == 18) && GetMonsterHandler().getVampireSettings(false, false, true) == false
				if _Seed_DrinkAlcoholicAle.HasForm(akBaseObject)
					ShowTutorial_Alcohol()
					AlcoholConsumed(1)
					addStrongBrew(1)
				elseif _Seed_DrinkAlcoholicWine.HasForm(akBaseObject)
					ShowTutorial_Alcohol()
					AlcoholConsumed(2)
					addStrongBrew(2)
				elseif _Seed_DrinkAlcoholicSpirit.HasForm(akBaseObject)
					ShowTutorial_Alcohol()
					AlcoholConsumed(3)
					addStrongBrew(3)
				elseif _Seed_DrinkSkoomaWeak.HasForm(akBaseObject)
					ShowTutorial_Skooma()
					SkoomaConsumed(1)
				elseif _Seed_DrinkSkoomaStrong.HasForm(akBaseObject)
					ShowTutorial_Skooma()
					SkoomaConsumed(2)
				endif
				If akBaseObject == DLC1RedwaterDenSkooma
					GetSkoomaSystem().becomeAddicted()
				Endif
			endif
			
			; Restore Thirst
			if GetThirstSystem().isRunning() && GetMonsterHandler().getVampireSettings(false, true, true) == false
				if foodType == 15 || foodType == 17 || foodType == 19  || (foodType == 18 && !_Seed_DrinkSkoomaWeak.HasForm(akBaseObject) && !_Seed_DrinkSkoomaStrong.HasForm(akBaseObject))
					SeedDebug(0, "Restoring thirst")
					RestorePlayerThirst(_Seed_RestoreThirstMajorAmount.GetValue())
					if foodType != 15
						animateDrink = true
					endif
				endif
				; Salted Food Increases Thirst
				if _Seed_Salted.HasForm(akBaseObject)
					GetThirstSystem().IncreaseAttribute(amountToRestore / 4)
				endif
			endif
			
			
			
			
			; Eating food multiple times yields less results
			bool addMultiPart = false;
			if amountToRestore > 0 && GetHungerSystem().isRunning()
				if GetMonsterHandler().getVampireSettings(false, true, true) == false
					ShowTutorial_Food()
					if _Seed_Setting_DiminishingFoodReturns.getValueInt() == 2
						if _Seed_RecentlyEatenFood.HasForm(theFood)
							SeedDebug(0, "This food was recently eaten.")
							amountToRestore *= 0.5
							ShowTutorial_Variety()
						else
							SeedDebug(0, "This food was not recently eaten.")
							_Seed_RecentlyEatenFood.AddForm(theFood)
							;Also add multi-part food
							addMultiPart = true
						endif
					endif
					animateEat = true
					SeedDebug(1, "Restoring " + amountToRestore + " hunger.")
					RestorePlayerHunger(amountToRestore)
					;restoreExposure(amountToRestore / 2)
				;Restore some hunger if eating raw food as a vampire
                elseif GetMonsterHandler().getVampireSettings(true, true, false) && (foodType == 2 || foodType == 4)
					RestorePlayerHunger(amountToRestore, 41.0)
					RestorePlayerThirst(amountToRestore, 41.0)
				endif
			endif
			
			;Add Frostfall Effects
			if foodType == 15
				ShowTutorial_Stew()
				addHeartyMeal()
			endif
			

			
			; Play Animations
			if animateEat
				GetConsumeManager().enqueuePlayerEatAnimation()
			elseif animateDrink
				GetConsumeManager().enqueuePlayerDrinkAnimation()
			endif
		else
			SeedDebug(0, "Object was not food. Reason: Was Potion " + akBaseObject as Potion + ", HasKeyword(VendorItemFood || VendorItemFoodRaw) " + (akBaseObject.HasKeyword(VendorItemFood) || akBaseObject.HasKeyword(VendorItemFoodRaw)))
		endif	
	endif
EndEvent

; HELP FUNCTIONS
function ShowTutorial_Variety()
    if _Seed_Setting_DisplayTutorials.GetValueInt() == 2 && _Seed_HelpDone_Variety.GetValueInt() == 1
        _Seed_Help_Variety.Show()
        _Seed_HelpDone_Variety.SetValue(2)
    endif
endFunction
function ShowTutorial_Alcohol()
    if _Seed_Setting_DisplayTutorials.GetValueInt() == 2 && _Seed_HelpDone_Alcohol.GetValueInt() == 1
        _Seed_Help_Alcohol.Show()
        _Seed_HelpDone_Alcohol.SetValue(2)
    endif
endFunction
function ShowTutorial_Skooma()
    if _Seed_Setting_DisplayTutorials.GetValueInt() == 2 && _Seed_HelpDone_SkoomaDrank.GetValueInt() == 1
        _Seed_Help_SkoomaDrank.Show()
        _Seed_HelpDone_SkoomaDrank.SetValue(2)
    endif
endFunction
function ShowTutorial_Food()
    if _Seed_Setting_DisplayTutorials.GetValueInt() == 2 && _Seed_HelpDone_Food.GetValueInt() == 1
        _Seed_Help_Food.Show()
        _Seed_HelpDone_Food.SetValue(2)
    endif
endFunction
function ShowTutorial_Stew()
    if _Seed_Setting_DisplayTutorials.GetValueInt() == 2 && _Seed_HelpDone_Stew.GetValueInt() == 1
        _Seed_Help_Stew.Show()
        _Seed_HelpDone_Stew.SetValue(2)
    endif
endFunction
function ShowTutorial_DangerousFood()
    if _Seed_Setting_DisplayTutorials.GetValueInt() == 2 && _Seed_HelpDone_DangerousFood.GetValueInt() == 1
        _Seed_Help_DangerousFood.Show()
        _Seed_HelpDone_DangerousFood.SetValue(2)
    endif
endFunction

; Restore Exposure if frostfall is installed.
; NOT CURRENTLY USED
function restoreExposure(float amountToRestore)
    _Seed_Compatibility compatibility = SeedUtil.GetCompatibilitySystem()
    if !compatibility.isFrostfallLoaded
        return
    endif
	
	if IsPlayerNearFire()
		ModPlayerExposure(amountToRestore)
	endif
endFunction

function addHeartyMeal()
	_Seed_Compatibility compatibility = SeedUtil.GetCompatibilitySystem()
    if !compatibility.isFrostfallLoaded
		if GetPlayerExposureLevel() > 1
			potion heartyMeal = getHeartyMeal()
			if heartyMeal
				PlayerRef.AddItem(heartyMeal, 1, true)
				PlayerRef.EquipItem(heartyMeal, false, true)
				;TODO: Add Message
			endif
		endif
	endif
endFunction

function addStrongBrew(int strength)
	_Seed_Compatibility compatibility = SeedUtil.GetCompatibilitySystem()
    if !compatibility.isFrostfallLoaded
		if GetPlayerExposureLevel() > 1
			potion strongBrew
			if strength == 1
				strongBrew = getStrongBrew1()
			elseif strength == 2
				strongBrew = getStrongBrew2()
			elseif strength == 3
				strongBrew = getStrongBrew3()
			endif
		
			if strongBrew
				PlayerRef.AddItem(strongBrew, 1, true)
				PlayerRef.EquipItem(strongBrew, false, true)
				;TODO: Add Message
			endif
		endif
	endif
endFunction

; Checks if the current food is from Frostfall
bool Function isFrostfallFood(Potion theFood)
	SeedDebug(0, "[_Seed_PlayerEatMonitor] Checking if Frostfall Food: " + theFood)
	if theFood		
		if theFood == getHeartyMeal()
			return true
		elseif theFood == getStrongBrew1()
			return true
		elseif theFood == getStrongBrew2()
			return true
		elseif theFood == getStrongBrew3()
			return true
		endif
	endif
	return false	
endFunction

;METHODS FOR FETCHING FOOD FROM FROSTFALL
Potion function getHeartyMeal()
	return getFrostfallFood(0x00066B5F, "_Frost_FoodEffectPotion")
endFunction
Potion function getStrongBrew1()
	return getFrostfallFood(0x0001CEBD, "_Frost_DrinkEffectPotion1")
endFunction
Potion function getStrongBrew2()
	return getFrostfallFood(0x0001CEBF, "_Frost_DrinkEffectPotion2")
endFunction
Potion function getStrongBrew3()
	return getFrostfallFood(0x0001CEC1, "_Frost_DrinkEffectPotion3")
endFunction
Potion Function getFrostfallFood(int aiFormID, String foodName)
    ; Check if Frostfall is Enabled
	_Seed_Compatibility compatibility = SeedUtil.GetCompatibilitySystem()
    if !compatibility.isFrostfallLoaded
		SeedDebug(0, "[_Seed_PlayerEatMonitor] Frostfall is not loaded")
        return none
    endif
	;Get Potion, Check if it exists and return it
	potion result = Game.GetFormFromFile(aiFormID, "Frostfall.esp") as Potion
	if result == none
		SeedDebug(3, "[_Seed_PlayerEatMonitor] ERRROR: " + foodName + " not found in frostfall.esp")
	endif
	return result
endFunction