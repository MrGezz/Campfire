Scriptname _Seed_CustomiseFoodHandler extends Quest
{Used to customise mod-added food.}

import seedUtil
import campUtil
import _SeedInternal

;/
FOODTYPE_BREAD			 = 1 
FOODTYPE_MEAT_RAW		  = 2 
FOODTYPE_MEAT_COOKED		= 3 
FOODTYPE_SMALLGAME_RAW	 = 4 
FOODTYPE_SMALLGAME_COOKED  = 5 
FOODTYPE_FISH_RAW		  = 6 
FOODTYPE_FISH_COOKED		= 7 
FOODTYPE_SEAFOOD_RAW		= 8 
FOODTYPE_SEAFOOD_COOKED	= 9 
FOODTYPE_VEGETABLE		 = 10
FOODTYPE_FRUIT			 = 11
FOODTYPE_CHEESE			= 12
FOODTYPE_TREAT			 = 13
FOODTYPE_PASTRY			= 14
FOODTYPE_STEW			  = 15
FOODTYPE_CHEESEBOWL		= 16
DRINKTYPE_MILK			 = 17
DRINKTYPE_ALCOHOLIC		= 18
DRINKTYPE_NONALCOHOLIC	 = 19
/;

message property _Seed_CustomiseFoodMsgStart auto				
message property _Seed_CustomiseFoodMsgCloseInventory auto				
message property _Seed_CustomiseFoodMsgStart_ReClassify auto				
message property _Seed_CustomiseFoodMsgType1 auto				
message property _Seed_CustomiseFoodMsgType2 auto				
message property _Seed_CustomiseFoodMsgType3 auto				
message property _Seed_CustomiseFoodMsgType4 auto				
message property _Seed_CustomiseFoodMsgType5 auto				
message property _Seed_CustomiseFoodMsgRestore auto				
message property _Seed_CustomiseFoodMsgAlcohol auto				
message property _Seed_CustomiseFoodMsgPreserved auto
message property _Seed_CustomiseFoodMsgClassify auto
message property _Seed_CustomiseFoodMsgHasPortions auto
message property _Seed_CustomiseFoodMsgHasPortionsInfo auto
message property _Seed_CustomiseFoodMsgHasPortionAmount auto
message property _Seed_ClassifyingFinished auto
message property _Seed_CustomiseFoodReloadGameMsg auto
globalVariable property _Seed_Classifying_Food auto ; NO LONGER USED
globalVariable property _Seed_CustomiseFoodContainerOpen auto 
GlobalVariable property _Seed_CustomiseFood_GettingPortions auto
GlobalVariable property _Seed_Setting_FoodPriceMulti auto
GlobalVariable property _Seed_Setting_FoodWeightMulti auto
GlobalVariable property _Seed_Setting_AddNames auto


ObjectReference property _Seed_CustomiseFoodContainerRef Auto
actor property PlayerRef auto



int property foodType auto hidden
int property alcoholAmount auto hidden
int property hungerRestoreAmount auto hidden
bool property isPreserved auto hidden
bool property isSalted auto hidden
bool property isFood auto hidden

potion property lastExaminedFood auto hidden

;/
keyword property _Seed_foodstuff_type_bread auto
keyword property _Seed_foodstuff_type_meat_raw auto
keyword property _Seed_foodstuff_type_meat_cooked auto
keyword property _Seed_foodstuff_type_smallgame_raw auto
keyword property _Seed_foodstuff_type_smallgame_cooked auto
keyword property _Seed_foodstuff_type_fish_raw auto
keyword property _Seed_foodstuff_type_fish_cooked auto
keyword property _Seed_foodstuff_type_seafood_raw auto
keyword property _Seed_foodstuff_type_seafood_cooked auto
keyword property _Seed_foodstuff_type_vegetable auto
keyword property _Seed_foodstuff_type_fruit auto
keyword property _Seed_foodstuff_type_cheese auto
keyword property _Seed_foodstuff_type_treat auto
keyword property _Seed_foodstuff_type_pastry_small auto
keyword property _Seed_foodstuff_type_pastry_large auto
keyword property _Seed_foodstuff_type_stew_simple auto
keyword property _Seed_foodstuff_type_stew_complex auto
keyword property _Seed_foodstuff_type_cheesebowl auto
keyword property _Seed_foodstuff_type_milk auto
keyword property _Seed_foodstuff_type_drinkNonAlcoholic auto

keyword property _Seed_foodstuff_type_drinkAlcoholic_weak auto
keyword property _Seed_foodstuff_type_drinkAlcoholic_moderate auto
keyword property _Seed_foodstuff_type_drinkAlcoholic_strong auto

keyword property _Seed_foodstuff_type_skooma_weak auto
keyword property _Seed_foodstuff_type_skooma_strong auto

keyword property _Seed_foodstuff_restoreHunger_light auto
keyword property _Seed_foodstuff_restoreHunger_medium auto
keyword property _Seed_foodstuff_restoreHunger_filling auto
keyword property _Seed_foodstuff_restoreHunger_hearty auto

keyword property _Seed_foodstuff_isPreserved_notSalted auto
keyword property _Seed_foodstuff_isPreserved_salted auto
/;

keyword property VendorItemFoodRaw auto
keyword property VendorItemFoodPreserved auto
keyword property VendorItemFoodMeat auto
keyword property VendorItemFoodMeatSmall auto
keyword property VendorItemFoodSeafood auto
keyword property VendorItemFoodFish auto
keyword property VendorItemFoodFruit auto
keyword property VendorItemFoodVegetable auto
keyword property VendorItemFoodCheese auto
keyword property VendorItemFoodCheeseBowl auto
keyword property VendorItemFoodBread auto
keyword property VendorItemFoodPastrySmall auto ; RENAME
keyword property VendorItemFoodTreat auto
keyword property VendorItemFoodStewSimple auto	;RENAME
keyword property VendorItemDrinkNonAlcohol auto
keyword property VendorItemDrinkMilk auto
keyword property VendorItemDrinkBloodPotion auto

keyword property VendorItemDrinkAlcoholWeak auto ; RENAME
keyword property VendorItemFoodPastryLarge auto
keyword property VendorItemFoodStewComplex auto


keyword property VendorItemFoodSalted auto
keyword property VendorItemDrinkAlcoholModerate auto
keyword property VendorItemDrinkAlcoholStrong auto
keyword property VendorItemDrinkSkoomaWeak auto
keyword property VendorItemDrinkSkoomaStrong auto
keyword property VendorItemFoodRestoreHungerLight auto
keyword property VendorItemFoodRestoreHungerMedium auto
keyword property VendorItemFoodRestoreHungerFilling auto
keyword property VendorItemFoodRestoreHungerHearty auto


formlist property _Seed_BloodPotions auto



bool function classifyFood(Potion theFood)
	return classify(theFood, false)
endFunction

bool function reClassifyFood(Potion theFood)
	return classify(theFood, true)
endFunction

bool function classify(Potion theFood, bool reclassify)
	GoToState("Processing")
	SeedDebug(1, "[CustomiseFoodHandler] Unknown food found: " + theFood)
	lastExaminedFood = theFood
	
	foodType = -1
	alcoholAmount = -1
	hungerRestoreAmount = -1
	isPreserved = false
	isSalted = false
	bool result = false
	bool hasKeywords = hasKeywords(theFood)
	if !reclassify
		if GetSKSELoaded() && !hasKeywords
			debug.notification(seedUtil.GetTranslationHandler().UnknownFoodstuff + theFood.getName())
		else
			SeedDebug(0, "[CustomiseFoodHandler] foodstuff: " + theFood)
		endif
	endif
	
	if !reclassify && hasKeywords
		classifyKeywords(theFood)
	else
		StartMenu(reclassify)
	endif
	
	SeedDebug(1, "[CustomiseFoodHandler] FOOD CLASSIFICATION RESULTS")
	SeedDebug(1, "[CustomiseFoodHandler] Food Type: " + foodType)
	SeedDebug(1, "[CustomiseFoodHandler] Alcohol Amount: " + alcoholAmount)
	SeedDebug(1, "[CustomiseFoodHandler] hunger Restore Amount: " + hungerRestoreAmount)
	SeedDebug(1, "[CustomiseFoodHandler] is preserved: " + isPreserved)
	SeedDebug(1, "[CustomiseFoodHandler] is salted: " + isSalted)

	if foodType != -1
		SeedDebug(0, "[CustomiseFoodHandler] Clearing alcohol Type")
		clearAlcoholAmount(theFood)
		SeedDebug(0, "[CustomiseFoodHandler] Clearing restore amount")
		clearFoodRestoreAmount(theFood)
		SeedDebug(0, "[CustomiseFoodHandler] Clearing food Type")
		clearFoodType(theFood)
		
		;NOT FOOD
		if foodType == 0
			SeedDebug(1, "[CustomiseFoodHandler] Setting item as not food")
			SetAsNotFood(theFood)
			SetAsNotBloodPotion(theFood)
		; BLOOD POTION
		elseif foodType == 20
			ClearFoodType(theFood)
			clearAlcoholAmount(theFood)
			clearFoodRestoreAmount(theFood)
			SetFoodPreserved(theFood, false)
			SetFoodSalted(theFood, false)
			SetAsBloodPotion(theFood)
		; FOOD
		else
			SetAsNotBloodPotion(theFood)
			result = true
			SetAsNotFood(theFood, false)
			SeedDebug(1, "[CustomiseFoodHandler] Setting Food Type: " + foodType)
			SetFoodType(theFood, foodType)
			if alcoholAmount != -1
				SeedDebug(1, "[CustomiseFoodHandler] Setting Alcohol Level: " + alcoholAmount)
				setAlcoholAmount(theFood, alcoholAmount)
			endif
			if hungerRestoreAmount != -1
				SeedDebug(0, "[CustomiseFoodHandler] Clearing Hunger restore ammount.")
				SeedDebug(1, "[CustomiseFoodHandler] Setting Hunger restore ammount: " + hungerRestoreAmount)
				setFoodRestoreAmount(theFood, hungerRestoreAmount)
			endif
			if isPreserved
				SeedDebug(0, "[CustomiseFoodHandler] setting as preserved")
				SetFoodPreserved(theFood)
			endif
			if isSalted
				SeedDebug(0, "[CustomiseFoodHandler] setting as salted")
				SetFoodSalted(theFood)
			endif
			
			if GetSKSELoaded() 
				if !reclassify
					; Set weight and gold
					theFood.SetGoldValue((theFood.GetGoldValue() * _Seed_Setting_FoodPriceMulti.getValue()) as int)
					theFood.SetWeight(theFood.GetWeight() *  _Seed_Setting_FoodWeightMulti.getValue())
					string foodNameDesc = ""
					;Set name
					if _Seed_Setting_AddNames.getValue() == 2
						;/
						if SeedUtil.GetCompatibilitySystem().isPO3Loaded && isSpecialEdition()
							;Add Hunger
							if hungerRestoreAmount == 1
								GetFoodDatastoreHandler().AddMagicEffect(TheFood, 0)
							elseif hungerRestoreAmount == 2
								GetFoodDatastoreHandler().AddMagicEffect(TheFood, 1)
							elseif hungerRestoreAmount == 3
								GetFoodDatastoreHandler().AddMagicEffect(TheFood, 2)
							elseif hungerRestoreAmount == 4
								GetFoodDatastoreHandler().AddMagicEffect(TheFood, 3)
							;Add Alcohol & Skooma
							elseif alcoholAmount == 1
								GetFoodDatastoreHandler().AddMagicEffect(TheFood, 4)
							elseif alcoholAmount == 2
								GetFoodDatastoreHandler().AddMagicEffect(TheFood, 5)
							elseif alcoholAmount == 3
								GetFoodDatastoreHandler().AddMagicEffect(TheFood, 6)
							elseif alcoholAmount == 4
								GetFoodDatastoreHandler().AddMagicEffect(TheFood, 11)
							elseif alcoholAmount == 5
								GetFoodDatastoreHandler().AddMagicEffect(TheFood, 12)
							endif
							
							;Add Skooma
							
							;Add Thirst
							if (foodType == 19)
								GetFoodDatastoreHandler().AddMagicEffect(TheFood, 7, true)
							elseif (foodType ==  17 || foodType == 15 || (foodType == 18 && alcoholAmount <= 3))
								GetFoodDatastoreHandler().AddMagicEffect(TheFood, 7)
							endif
							
							; Add Raw Food
							if (foodType ==  2 || foodType ==  4 || foodType ==  6 || foodType ==  8)
								GetFoodDatastoreHandler().AddMagicEffect(TheFood, 8)
							endif
							
							; Add Preserved and Salted
							if (isPreserved)
								GetFoodDatastoreHandler().AddMagicEffect(TheFood, 9)
							endif
							if (isSalted)
								GetFoodDatastoreHandler().AddMagicEffect(TheFood, 10)
							endif			
						else
						/;
							if hungerRestoreAmount == 1
								foodNameDesc = GetTranslationHandler().foodLight
							elseif hungerRestoreAmount == 2
								foodNameDesc = GetTranslationHandler().foodMedium
							elseif hungerRestoreAmount == 3
								foodNameDesc = GetTranslationHandler().foodFilling
							elseif hungerRestoreAmount == 4
								foodNameDesc = GetTranslationHandler().foodHearty
							elseif alcoholAmount == 1 || alcoholAmount == 4
								foodNameDesc = GetTranslationHandler().drinkWeak
							elseif alcoholAmount == 2
								foodNameDesc = GetTranslationHandler().drinkModerate
							elseif alcoholAmount == 3 || alcoholAmount == 5
								foodNameDesc = GetTranslationHandler().drinkStrong
							endif
							if foodNameDesc != ""
								string newName = theFood.GetName() + foodNameDesc
								TheFood.SetName(newName)
							endif
						;endif
					endif
				; Show message that some changes won't take effect until next reload
				elseif _Seed_Setting_AddNames.getValue() == 2 || _Seed_Setting_FoodWeightMulti.getValue() != 1 || _Seed_Setting_FoodPriceMulti.getValue() != 1
					_Seed_CustomiseFoodReloadGameMsg.show()
				endif
			endif
		endif
	endif
	GoToState("")
	return result
endFunction

bool function classifyKeywords(Potion theFood)
	if theFood.hasKeyword(VendorItemFoodBread)
		foodType = 1
		hungerRestoreAmount = 2
	elseif theFood.hasKeyword(VendorItemFoodMeat)
		if theFood.hasKeyword(VendorItemFoodRaw) 
			foodType = 2
			hungerRestoreAmount = 2
		else
			foodType = 3
			hungerRestoreAmount = 3
		endif
	elseif theFood.hasKeyword(VendorItemFoodMeatSmall)
		if theFood.hasKeyword(VendorItemFoodRaw) 
			foodType = 4
			hungerRestoreAmount = 1
		else
			foodType = 5
			hungerRestoreAmount = 2
		endif
	elseif theFood.hasKeyword(VendorItemFoodFish)
		if theFood.hasKeyword(VendorItemFoodRaw) 
			foodType = 6
			hungerRestoreAmount = 1
		else
			foodType = 7
			hungerRestoreAmount = 2
		endif
	elseif theFood.hasKeyword(VendorItemFoodSeafood)
		if theFood.hasKeyword(VendorItemFoodRaw) 
			foodType = 8
			hungerRestoreAmount = 1
		else
			foodType = 9
			hungerRestoreAmount = 2
		endif
	elseif theFood.hasKeyword(VendorItemFoodVegetable)
		foodType = 10
		hungerRestoreAmount = 1
	elseif theFood.hasKeyword(VendorItemFoodFruit)
		foodType = 11
		hungerRestoreAmount = 2
	elseif theFood.hasKeyword(VendorItemFoodCheese)
		foodType = 12
		hungerRestoreAmount = 1
	elseif theFood.hasKeyword(VendorItemFoodTreat)
		foodType = 13
		hungerRestoreAmount = 2
	elseif theFood.hasKeyword(VendorItemFoodPastrySmall)
		foodType = 14
		hungerRestoreAmount = 3
	elseif theFood.hasKeyword(VendorItemFoodPastryLarge)
		foodType = 14
		hungerRestoreAmount = 4
	elseif theFood.hasKeyword(VendorItemFoodStewSimple)
		foodType = 15
		hungerRestoreAmount = 3
	elseif theFood.hasKeyword(VendorItemFoodStewComplex)
		foodType = 15
		hungerRestoreAmount = 4
	elseif theFood.hasKeyword(VendorItemFoodCheeseBowl)
		foodType = 16
		hungerRestoreAmount = 3
	elseif theFood.hasKeyword(VendorItemDrinkMilk)
		foodType = 17
		hungerRestoreAmount = 1
	elseif theFood.hasKeyword(VendorItemDrinkNonAlcohol)
		foodType = 19
	
	;Alcohol and Skooma
	elseif theFood.hasKeyword(VendorItemDrinkAlcoholWeak)
		foodType = 18
		alcoholAmount = 1
	elseif theFood.hasKeyword(VendorItemDrinkAlcoholModerate)
		foodType = 18
		alcoholAmount = 2
	elseif theFood.hasKeyword(VendorItemDrinkAlcoholStrong)
		foodType = 18
		alcoholAmount = 3
	elseif theFood.hasKeyword(VendorItemDrinkSkoomaWeak)
		foodType = 18
		alcoholAmount = 4
	elseif theFood.hasKeyword(VendorItemDrinkSkoomaStrong)
		foodType = 18
		alcoholAmount = 4
	endif
	
	;Override Restore Amount
	if theFood.hasKeyword(VendorItemFoodRestoreHungerLight)
		hungerRestoreAmount = 1
	elseif theFood.hasKeyword(VendorItemFoodRestoreHungerMedium)
		hungerRestoreAmount = 2
	elseif theFood.hasKeyword(VendorItemFoodRestoreHungerFilling)
		hungerRestoreAmount = 3
	elseif theFood.hasKeyword(VendorItemFoodRestoreHungerHearty)
		hungerRestoreAmount = 4
	endif
	
	;Set Preserved
	if theFood.hasKeyword(VendorItemFoodPreserved)
		isPreserved = true
	elseif theFood.hasKeyword(VendorItemFoodSalted)
		isSalted = true
	endif
	
	;BLOOD POTIONS
	if theFood.hasKeyword(VendorItemDrinkBloodPotion)
		foodType = 20
		hungerRestoreAmount = -1
		alcoholAmount = -1
		isPreserved = false
		isSalted = false
	endif
endFunction

function SetAsBloodPotion(potion theFood)
	_Seed_BloodPotions.addForm(theFood)
endFunction

function SetAsNotBloodPotion(potion theFood)
	_Seed_BloodPotions.RemoveAddedForm(theFood)
endFunction

bool function hasKeywords(Potion theFood)
	return theFood.hasKeyword(VendorItemFoodBread) \
		|| theFood.hasKeyword(VendorItemFoodMeat) \
		|| theFood.hasKeyword(VendorItemFoodMeatSmall) \
		|| theFood.hasKeyword(VendorItemFoodFish) \
		|| theFood.hasKeyword(VendorItemFoodSeafood) \
		|| theFood.hasKeyword(VendorItemFoodVegetable) \
		|| theFood.hasKeyword(VendorItemFoodFruit) \
		|| theFood.hasKeyword(VendorItemFoodCheese) \
		|| theFood.hasKeyword(VendorItemFoodTreat) \
		|| theFood.hasKeyword(VendorItemFoodPastrySmall) \
		|| theFood.hasKeyword(VendorItemFoodPastryLarge) \
		|| theFood.hasKeyword(VendorItemFoodStewSimple) \
		|| theFood.hasKeyword(VendorItemFoodStewComplex) \
		|| theFood.hasKeyword(VendorItemFoodCheeseBowl) \
		|| theFood.hasKeyword(VendorItemDrinkMilk) \
		|| theFood.hasKeyword(VendorItemDrinkNonAlcohol) \
		|| theFood.hasKeyword(VendorItemDrinkAlcoholWeak) \
		|| theFood.hasKeyword(VendorItemDrinkAlcoholModerate) \
		|| theFood.hasKeyword(VendorItemDrinkAlcoholStrong) \
		|| theFood.hasKeyword(VendorItemDrinkSkoomaWeak) \
		|| theFood.hasKeyword(VendorItemDrinkSkoomaStrong)
endFunction

function StartMenu(bool reclassify)
	int ibutton = 1
	if(reclassify)
		ibutton = _Seed_CustomiseFoodMsgStart_ReClassify.show()
	else
		ibutton = _Seed_CustomiseFoodMsgStart.show()
	endif
	; Continue
	if ibutton == 0	 
	typeMenu1()
	;not food
	elseif ibutton == 2
		 foodType = 0
	endif
endFunction



function typeMenu1()	
	int ibutton = _Seed_CustomiseFoodMsgType1.show()
	; Bread
	if ibutton == 0
	foodType = 1
	restoreMenu()
	;Raw Large Game
	elseif ibutton == 1	 
		foodType = 2
		restoreMenu()
	;Cooked Large Game
	elseif ibutton == 2	
		foodType = 3
		restoreMenu()
	;Raw Small Game
	elseif ibutton == 3
		foodType = 4
		restoreMenu()
	;More
	elseif ibutton == 4
		 typeMenu2()
	endif
endFunction


function typeMenu2()
	int ibutton = _Seed_CustomiseFoodMsgType2.show()
		; Cooked Small Game
		if ibutton == 0
			foodType = 5
			restoreMenu()
		
		;Raw Fish
		elseif ibutton == 1
			foodType = 6
		restoreMenu()
		;Cooked Fish
		elseif ibutton == 2		
			foodType = 7
			restoreMenu()
		;Raw Seafood
		elseif ibutton == 3	
			foodType = 8
			restoreMenu()
		;More
		elseif ibutton == 4
			 typeMenu3()
		endif
endFunction


function typeMenu3()
	int ibutton = _Seed_CustomiseFoodMsgType3.show()
		; Cooked Seafood
		if ibutton == 0
			foodType = 9
			restoreMenu()
		;Vegitables
		elseif ibutton == 1
			foodType = 10
			restoreMenu()
		;Fruit
		elseif ibutton == 2
			foodType = 11
			restoreMenu()
		;Cheese
		elseif ibutton == 3
			foodType = 12
			restoreMenu()
		;More
		elseif ibutton == 4
			 typeMenu4()
		endif
endFunction

function typeMenu4()
	int ibutton = _Seed_CustomiseFoodMsgType4.show()
		; Sweets
		if ibutton == 0
			foodType = 13
			restoreMenu()
		;Pastry
		elseif ibutton == 1
			foodType = 14
			restoreMenu()
		;Stew
		elseif ibutton == 2
			foodType = 15
			restoreMenu()
		;Cheesebowl
		elseif ibutton == 3
			foodType = 16
			restoreMenu()
		;More
		elseif ibutton == 4
			 typeMenu5()
		endif
endFunction


function typeMenu5()
	int ibutton = _Seed_CustomiseFoodMsgType5.show()
		; Milk
		if ibutton == 0
			foodType = 17
			restoreMenu()
		;Alcoholic Beverage
		elseif ibutton == 1  
			foodType = 18
			alcoholMenu()
		;Non-Alcoholic Beverage
		elseif ibutton == 2
			foodType = 19
			getPortionsMenu()
		;More
		elseif ibutton == 3
			foodType = 20
			_Seed_ClassifyingFinished.show()
		elseif ibutton == 4
			typeMenu1()
		endif
endFunction

function restoreMenu()
	int ibutton = _Seed_CustomiseFoodMsgRestore.show()					
		;Minor
		if ibutton == 0
			hungerRestoreAmount = 1
			preservedMenu()
		;Major
		elseif ibutton == 1  
			hungerRestoreAmount = 2
			preservedMenu()
		;Superior
		elseif ibutton == 2
			hungerRestoreAmount = 3
			preservedMenu()
		;Massive
		elseif ibutton == 3	
			hungerRestoreAmount = 4
			preservedMenu()
		endif
endFunction

function alcoholMenu()
	int ibutton = _Seed_CustomiseFoodMsgAlcohol.show()
	;Ale
	if ibutton == 0
		alcoholAmount = 1
	;Wine
	elseif ibutton == 1  
		alcoholAmount = 2
	;Spirits
	elseif ibutton == 2
		alcoholAmount = 3
	;Weak Skooma
	elseif ibutton == 3
		alcoholAmount = 4
	;Strong Skooma
	elseif ibutton == 4
		alcoholAmount = 5
	endif
	getPortionsMenu()
endFunction

function preservedMenu()
	int ibutton = _Seed_CustomiseFoodMsgPreserved.show()					
		;Preserved
		if ibutton == 1
			isPreserved = true
		elseIf ibutton == 2
			isPreserved = true
			isSalted = true
		endif
		getPortionsMenu()
endFunction

function getPortionsMenu()
	int ibutton = _Seed_CustomiseFoodMsgHasPortions.show()
	if ibutton == 0
		SeedDebug(0, "[CustomiseFoodHandler] Getting food portions")
		_Seed_CustomiseFood_GettingPortions.setValue(2)
		
		; If inventory is open, wait for it to close before continuing
		if _Seed_CustomiseFoodContainerOpen.getValueInt() != 2
			_Seed_CustomiseFoodMsgCloseInventory.show()
			Utility.wait(1)
		else
			_Seed_CustomiseFoodMsgHasPortionsInfo.show()
		endif
		
		_Seed_CustomiseFoodContainerRef.Activate(PlayerRef)
	elseif _Seed_CustomiseFoodContainerOpen.getValueInt() != 2
		_Seed_ClassifyingFinished.show()
	endif
endFunction

function getPortionsAmountMenu(potion thePortion)
	int aiQuantity = _Seed_CustomiseFoodMsgHasPortionAmount.show() + 1
	SeedDebug(0, "[CustomiseFoodHandler] Adding food portions")
	 GetFoodDatastoreHandler().UpdateMultiPartFood_Array(lastExaminedFood, thePortion, aiQuantity)
endFunction


State Processing
bool function classify(Potion theFood, bool reclassify)
		return false
	EndFunction
endState