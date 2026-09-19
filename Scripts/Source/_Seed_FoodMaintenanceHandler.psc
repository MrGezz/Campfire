scriptname _Seed_FoodMaintenanceHandler extends Quest
{ This script handles the updating of food data on load. }

import CampUtil
import SeedUtil
import StringUtil
import Utility

globalvariable property _Seed_Setting_FoodPriceMulti auto
GlobalVariable property _Seed_Setting_FoodWeightMulti auto
GlobalVariable property _Seed_Setting_AddNames auto
GlobalVariable property _Seed_LoadingChecksum auto

FormList property _Seed_Food_RestoreHungerMinor auto
FormList property _Seed_Food_RestoreHungerMajor auto
FormList property _Seed_Food_RestoreHungerSuperior auto
FormList property _Seed_Food_RestoreHungerMassive auto
FormList property _Seed_Food_RestoreHungerMinorBASE auto
FormList property _Seed_Food_RestoreHungerMajorBASE auto
FormList property _Seed_Food_RestoreHungerSuperiorBASE auto
FormList property _Seed_Food_RestoreHungerMassiveBASE auto

FormList property _Seed_DrinkAlcoholicAle auto
FormList property _Seed_DrinkAlcoholicWine auto
FormList property _Seed_DrinkAlcoholicSpirit auto
FormList property _Seed_DrinkAlcoholicAleBASE auto
FormList property _Seed_DrinkAlcoholicWineBASE auto
FormList property _Seed_DrinkAlcoholicSpiritBASE auto

FormList property _Seed_DrinkSkoomaWeak auto
FormList property _Seed_DrinkSkoomaStrong auto
FormList property _Seed_DrinkSkoomaWeakBASE auto
FormList property _Seed_DrinkSkoomaStrongBASE auto

FormList property _Seed_DrinkWater auto

FormList property _Seed_Bread auto
FormList property _Seed_MeatRaw auto
FormList property _Seed_MeatCooked auto
FormList property _Seed_SmallGameRaw auto
FormList property _Seed_SmallGameCooked auto
FormList property _Seed_FishRaw auto
FormList property _Seed_FishCooked auto
FormList property _Seed_SeafoodRaw auto
FormList property _Seed_SeafoodCooked auto
FormList property _Seed_Vegetables auto
FormList property _Seed_Fruit auto
FormList property _Seed_Cheese auto
FormList property _Seed_Treats auto
FormList property _Seed_Pastries auto
FormList property _Seed_Stews auto
FormList property _Seed_CheeseBowls auto
FormList property _Seed_DrinkMilk auto
FormList property _Seed_DrinkAlcoholic auto
FormList property _Seed_DrinkNonAlcoholic auto
FormList property _Seed_Preserved auto
FormList property _Seed_SaltedFood auto
FormList property _Seed_NotFood auto
FormList property _Seed_SystemFoods auto
FormList property _Seed_FoodMiscObjects auto

Formlist Property _Seed_Bread_MaintenancePrice auto
Formlist Property _Seed_MeatRaw_MaintenancePrice auto
Formlist Property _Seed_MeatCooked_MaintenancePrice auto
Formlist Property _Seed_SmallGameRaw_MaintenancePrice auto
Formlist Property _Seed_SmallGameCooked_MaintenancePrice auto
Formlist Property _Seed_FishRaw_MaintenancePrice auto
Formlist Property _Seed_FishCooked_MaintenancePrice auto
Formlist Property _Seed_SeafoodRaw_MaintenancePrice auto
Formlist Property _Seed_SeafoodCooked_MaintenancePrice auto
Formlist Property _Seed_Vegetables_MaintenancePrice auto
Formlist Property _Seed_Fruit_MaintenancePrice auto
Formlist Property _Seed_Cheese_MaintenancePrice auto
Formlist Property _Seed_Treats_MaintenancePrice auto
Formlist Property _Seed_Pastries_MaintenancePrice auto
Formlist Property _Seed_Stews_MaintenancePrice auto
Formlist Property _Seed_CheeseBowls_MaintenancePrice auto
Formlist Property _Seed_DrinkMilk_MaintenancePrice auto
Formlist Property _Seed_DrinkAlcoholic_MaintenancePrice auto
Formlist Property _Seed_DrinkNonAlcoholic_MaintenancePrice auto
Formlist Property _Seed_FoodMiscObjects_MaintenancePrice auto

Formlist Property _Seed_Bread_MaintenanceWeight auto
Formlist Property _Seed_MeatRaw_MaintenanceWeight auto
Formlist Property _Seed_MeatCooked_MaintenanceWeight auto
Formlist Property _Seed_SmallGameRaw_MaintenanceWeight auto
Formlist Property _Seed_SmallGameCooked_MaintenanceWeight auto
Formlist Property _Seed_FishRaw_MaintenanceWeight auto
Formlist Property _Seed_FishCooked_MaintenanceWeight auto
Formlist Property _Seed_SeafoodRaw_MaintenanceWeight auto
Formlist Property _Seed_SeafoodCooked_MaintenanceWeight auto
Formlist Property _Seed_Vegetables_MaintenanceWeight auto
Formlist Property _Seed_Fruit_MaintenanceWeight auto
Formlist Property _Seed_Cheese_MaintenanceWeight auto
Formlist Property _Seed_Treats_MaintenanceWeight auto
Formlist Property _Seed_Pastries_MaintenanceWeight auto
Formlist Property _Seed_Stews_MaintenanceWeight auto
Formlist Property _Seed_CheeseBowls_MaintenanceWeight auto
Formlist Property _Seed_DrinkMilk_MaintenanceWeight auto
Formlist Property _Seed_DrinkAlcoholic_MaintenanceWeight auto
Formlist Property _Seed_DrinkNonAlcoholic_MaintenanceWeight auto
Formlist Property _Seed_FoodMiscObjects_MaintenanceWeight auto

FormList Property _Seed_Food_RestoreHungerMinor_MaintenanceName auto
FormList Property _Seed_Food_RestoreHungerMajor_MaintenanceName auto
FormList Property _Seed_Food_RestoreHungerSuperior_MaintenanceName auto
FormList Property _Seed_Food_RestoreHungerMassive_MaintenanceName auto
FormList Property _Seed_DrinkNonAlcoholic_MaintenanceName auto
FormList Property  _Seed_DrinkMilk_MaintenanceName auto
FormList Property _Seed_Stews_MaintenanceName auto
FormList Property _Seed_DrinkAlcoholicAle_MaintenanceName auto
FormList Property _Seed_DrinkAlcoholicWine_MaintenanceName auto
FormList Property _Seed_DrinkAlcoholicSpirit_MaintenanceName auto
FormList Property _Seed_MeatRaw_MaintenanceName auto
FormList Property _Seed_SmallGameRaw_MaintenanceName auto
FormList Property _Seed_FishRaw_MaintenanceName auto
FormList Property _Seed_SeafoodRaw_MaintenanceName auto
FormList Property _Seed_Preserved_MaintenanceName auto
FormList Property _Seed_SaltedFood_MaintenanceName auto
FormList Property _Seed_DrinkSkoomaWeak_MaintenanceName auto
FormList Property _Seed_DrinkSkoomaStrong_MaintenanceName auto

Potion property _Seed_TestFood auto			; Food for weight and price check on load

function setFoodProperties()
	if GetSKSELoaded()
		float checksum = _Seed_LoadingChecksum.getValue()
		if _Seed_Setting_AddNames.getValue() == 3 && SeedUtil.GetCompatibilitySystem().isPO3Loaded && isSpecialEdition()
			if AddMagicEffectToFormListWithTest(_Seed_Food_RestoreHungerMinor, 0, checksum) == true
				return
			endif
			if AddMagicEffectToFormListWithTest(_Seed_Food_RestoreHungerMajor, 1, checksum) == true
				return
			endif
			if AddMagicEffectToFormListWithTest(_Seed_Food_RestoreHungerSuperior, 2, checksum) == true
				return
			endif
			if AddMagicEffectToFormListWithTest(_Seed_Food_RestoreHungerMassive, 3, checksum) == true
				return
			endif
			
			; Add Drinks
			if AddMagicEffectToFormListWithTest(_Seed_DrinkNonAlcoholic, 7, checksum, true) == true
				return
			endif
			if AddMagicEffectToFormListWithTest(_Seed_DrinkMilk, 7, checksum) == true
				return
			endif
			if AddMagicEffectToFormListWithTest(_Seed_DrinkAlcoholicAle, 7, checksum) == true
				return
			endif
			if AddMagicEffectToFormListWithTest(_Seed_DrinkAlcoholicWine, 7, checksum) == true
				return
			endif
			if AddMagicEffectToFormListWithTest(_Seed_DrinkAlcoholicSpirit, 7, checksum) == true
				return
			endif
			if AddMagicEffectToFormListWithTest(_Seed_Stews, 7, checksum) == true
				return
			endif
			
			; Add Alcohol			
			if AddMagicEffectToFormListWithTest(_Seed_DrinkAlcoholicAle, 4, checksum) == true
				return
			endif
			if AddMagicEffectToFormListWithTest(_Seed_DrinkAlcoholicWine, 5, checksum) == true
				return
			endif
			if AddMagicEffectToFormListWithTest(_Seed_DrinkAlcoholicSpirit, 6, checksum) == true
				return
			endif
			
			; Add Raw Food
			if AddMagicEffectToFormListWithTest(_Seed_MeatRaw, 8, checksum) == true
				return
			endif
			if AddMagicEffectToFormListWithTest(_Seed_SmallGameRaw, 8, checksum) == true
				return
			endif
			if AddMagicEffectToFormListWithTest(_Seed_FishRaw, 8, checksum) == true
				return
			endif
			if AddMagicEffectToFormListWithTest(_Seed_SeafoodRaw, 8, checksum) == true
				return
			endif
			
			; Add Preserved Food
			if AddMagicEffectToFormListWithTest(_Seed_Preserved, 9, checksum) == true
				return
			endif
			if AddMagicEffectToFormListWithTest(_Seed_SaltedFood, 10, checksum) == true
				return
			endif
			
			; Add Skooma
			if AddMagicEffectToFormListWithTest(_Seed_DrinkSkoomaWeak, 11, checksum) == true
				return
			endif
			if AddMagicEffectToFormListWithTest(_Seed_DrinkSkoomaStrong, 12, checksum) == true
				return
			endif		
		elseif _Seed_Setting_AddNames.getValue() == 2
			if AddNameTypeWithCheck(_Seed_Food_RestoreHungerMinor, GetTranslationHandler().foodLight, checksum)== true
				return
			endif
			if AddNameTypeWithCheck(_Seed_Food_RestoreHungerMajor, GetTranslationHandler().foodMedium, checksum)== true
				return
			endif
			if AddNameTypeWithCheck(_Seed_Food_RestoreHungerSuperior, GetTranslationHandler().foodFilling, checksum)== true
				return
			endif
			if AddNameTypeWithCheck(_Seed_Food_RestoreHungerMassive, GetTranslationHandler().foodHearty, checksum)== true
				return
			endif
			
			if AddNameTypeWithCheck(_Seed_DrinkAlcoholicAle, GetTranslationHandler().drinkWeak, checksum)== true
				return
			endif
			if AddNameTypeWithCheck(_Seed_DrinkAlcoholicWine, GetTranslationHandler().drinkModerate, checksum)== true
				return
			endif
			if AddNameTypeWithCheck(_Seed_DrinkAlcoholicSpirit, GetTranslationHandler().drinkStrong, checksum)== true
				return
			endif
	
			if AddNameTypeWithCheck(_Seed_DrinkSkoomaWeak, GetTranslationHandler().drinkWeak, checksum)== true
				return
			endif
			if AddNameTypeWithCheck(_Seed_DrinkSkoomaStrong, GetTranslationHandler().drinkStrong, checksum)== true
				return
			endif
		endif
		
		if _Seed_Setting_FoodPriceMulti.getValue() != 1.0
			if setFoodPriceWithCheck(_Seed_Bread, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_MeatRaw, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_MeatCooked, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_SmallGameRaw, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_SmallGameCooked, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_FishRaw, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_FishCooked, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_SeafoodRaw, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_SeafoodCooked, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_Vegetables, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_Fruit, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_Cheese, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_Treats, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_Pastries, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_Stews, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_CheeseBowls, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_DrinkMilk, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_DrinkAlcoholic, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_DrinkNonAlcoholic, checksum)== true
				return
			endif
			if setFoodPriceWithCheck(_Seed_FoodMiscObjects, checksum)== true
				return
			endif
			;/
			setFoodPrice(_Seed_Bread, _Seed_Bread_MaintenancePrice)
			setFoodPrice(_Seed_MeatRaw, _Seed_MeatRaw_MaintenancePrice)
			setFoodPrice(_Seed_MeatCooked, _Seed_MeatCooked_MaintenancePrice)
			setFoodPrice(_Seed_SmallGameRaw, _Seed_SmallGameRaw_MaintenancePrice)
			setFoodPrice(_Seed_SmallGameCooked, _Seed_SmallGameCooked_MaintenancePrice)
			setFoodPrice(_Seed_FishRaw, _Seed_FishRaw_MaintenancePrice)
			setFoodPrice(_Seed_FishCooked, _Seed_FishCooked_MaintenancePrice)
			setFoodPrice(_Seed_SeafoodRaw, _Seed_SeafoodRaw_MaintenancePrice)
			setFoodPrice(_Seed_SeafoodCooked, _Seed_SeafoodCooked_MaintenancePrice)
			setFoodPrice(_Seed_Vegetables, _Seed_Vegetables_MaintenancePrice)
			setFoodPrice(_Seed_Fruit, _Seed_Fruit_MaintenancePrice)
			setFoodPrice(_Seed_Cheese, _Seed_Cheese_MaintenancePrice)
			setFoodPrice(_Seed_Treats, _Seed_Treats_MaintenancePrice)
			setFoodPrice(_Seed_Pastries, _Seed_Pastries_MaintenancePrice)
			setFoodPrice(_Seed_Stews, _Seed_Stews_MaintenancePrice)
			setFoodPrice(_Seed_CheeseBowls, _Seed_CheeseBowls_MaintenancePrice)
			setFoodPrice(_Seed_DrinkMilk, _Seed_DrinkMilk_MaintenancePrice)
			setFoodPrice(_Seed_DrinkAlcoholic, _Seed_DrinkAlcoholic_MaintenancePrice)
			setFoodPrice(_Seed_DrinkNonAlcoholic, _Seed_DrinkNonAlcoholic_MaintenancePrice)
			setFoodPrice(_Seed_FoodMiscObjects, _Seed_FoodMiscObjects_MaintenancePrice)
			/;
		endif
		
		if _Seed_Setting_FoodWeightMulti.getValue() != 1.0
			if setFoodWeightWithCheck(_Seed_Bread, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_MeatRaw, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_MeatCooked, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_SmallGameRaw, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_SmallGameCooked, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_FishRaw, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_FishCooked, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_SeafoodRaw, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_SeafoodCooked, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_Vegetables, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_Fruit, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_Cheese, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_Treats, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_Pastries, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_Stews, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_CheeseBowls, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_DrinkMilk, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_DrinkAlcoholic, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_DrinkNonAlcoholic, checksum)== true
				return
			endif
			if setFoodWeightWithCheck(_Seed_FoodMiscObjects, checksum)== true
				return
			endif
			;/
			setFoodWeight(_Seed_Bread, _Seed_Bread_MaintenanceWeight)
			setFoodWeight(_Seed_MeatRaw, _Seed_MeatRaw_MaintenanceWeight)
			setFoodWeight(_Seed_MeatCooked, _Seed_MeatCooked_MaintenanceWeight)
			setFoodWeight(_Seed_SmallGameRaw, _Seed_SmallGameRaw_MaintenanceWeight)
			setFoodWeight(_Seed_SmallGameCooked, _Seed_SmallGameCooked_MaintenanceWeight)
			setFoodWeight(_Seed_FishRaw, _Seed_FishRaw_MaintenanceWeight)
			setFoodWeight(_Seed_FishCooked, _Seed_FishCooked_MaintenanceWeight)
			setFoodWeight(_Seed_SeafoodRaw, _Seed_SeafoodRaw_MaintenanceWeight)
			setFoodWeight(_Seed_SeafoodCooked, _Seed_SeafoodCooked_MaintenanceWeight)
			setFoodWeight(_Seed_Vegetables, _Seed_Vegetables_MaintenanceWeight)
			setFoodWeight(_Seed_Fruit, _Seed_Fruit_MaintenanceWeight)
			setFoodWeight(_Seed_Cheese, _Seed_Cheese_MaintenanceWeight)
			setFoodWeight(_Seed_Treats, _Seed_Treats_MaintenanceWeight)
			setFoodWeight(_Seed_Pastries, _Seed_Pastries_MaintenanceWeight)
			setFoodWeight(_Seed_Stews, _Seed_Stews_MaintenanceWeight)
			setFoodWeight(_Seed_CheeseBowls, _Seed_CheeseBowls_MaintenanceWeight)
			setFoodWeight(_Seed_DrinkMilk, _Seed_DrinkMilk_MaintenanceWeight)
			setFoodWeight(_Seed_DrinkAlcoholic, _Seed_DrinkAlcoholic_MaintenanceWeight)
			setFoodWeight(_Seed_DrinkNonAlcoholic, _Seed_DrinkNonAlcoholic_MaintenanceWeight)
			setFoodWeight(_Seed_FoodMiscObjects, _Seed_FoodMiscObjects_MaintenanceWeight)
			/;
		endif
				  
	endif
endFunction

bool Function AddMagicEffectToFormListWithTest(FormList FoodList, int index, float checksum, bool ignoreWater = false)	
	Int iIndex = FoodList.GetSize() as Int
	While iIndex > 0
		iIndex -= 1
		Potion theFood = FoodList.GetAt(iIndex) as Potion
		If theFood
			; Check for waterskins
			if ignoreWater && _Seed_DrinkWater.Find(theFood) != -1
				return false
			endif
			
			;Add effect if it hasn't already been added
			magicEffect[] foodEffects = TheFood.GetMagicEffects()
			magicEffect effectToAdd = _Seed_TestFood.GetNthEffectMagicEffect(index)
			PO3_SKSEFunctions.AddEffectItemToPotion(theFood, _Seed_TestFood, index)
			if(checkSum != _Seed_LoadingChecksum.GetValue())
				PO3_SKSEFunctions.RemoveEffectItemFromPotion(theFood, _Seed_TestFood, index)
				return true
			endif
		EndIf
	EndWhile
	return false
EndFunction


bool Function AddNameTypeWithCheck(FormList FoodList, String type, float checkSum)
	Int iIndex = FoodList.GetSize() as Int
	While iIndex > 0		
		iIndex -= 1
		Form theFood = FoodList.GetAt(iIndex)
		if theFood
			string oldName = theFood.GetName()
			string newName = oldName + type
			TheFood.SetName(newName)
			if(checkSum != _Seed_LoadingChecksum.GetValue())
				TheFood.SetName(oldName)
				return true
			endif
		endif
	EndWhile
	return false
EndFunction

bool function setFoodPriceWithCheck(FormList FoodList, float checkSum)
	Int iIndex = FoodList.GetSize() as Int
	While iIndex > 0
		iIndex -= 1
		Form theFood = FoodList.GetAt(iIndex)
		if(theFood)
			int oldValue = theFood.GetGoldValue()
			int newValue = (theFood.GetGoldValue() * _Seed_Setting_FoodPriceMulti.getValue()) as int
			theFood.SetGoldValue(newValue)
			if(checkSum != _Seed_LoadingChecksum.GetValue())
				theFood.SetGoldValue(oldValue)
				return true
			endif
		endif
	EndWhile
	return false
endFunction

bool function setFoodWeightWithCheck(FormList FoodList, float checkSum)
	Int iIndex = FoodList.GetSize() as Int
	While iIndex > 0
		iIndex -= 1
		Form theFood = FoodList.GetAt(iIndex)
		if (theFood)
			float oldWeight = theFood.GetWeight()
			float newWeight = theFood.GetWeight() *  _Seed_Setting_FoodWeightMulti.getValue()
			theFood.SetWeight(newWeight)
			if(checkSum != _Seed_LoadingChecksum.GetValue())
				theFood.SetWeight(oldWeight)
				return true
			endif
		endif
	EndWhile
	return false
endFunction



;/------------
LEGACY METHODS
------------/;



event onUpdate()
	resetFormLists()
endEvent

function resetFormLists()
	_Seed_Food_RestoreHungerMinor_MaintenanceName.Revert()
	_Seed_Food_RestoreHungerMajor_MaintenanceName.Revert()
	_Seed_Food_RestoreHungerSuperior_MaintenanceName.Revert()
	_Seed_Food_RestoreHungerMassive_MaintenanceName.Revert()
	_Seed_DrinkAlcoholicAle_MaintenanceName.Revert()
	_Seed_DrinkAlcoholicWine_MaintenanceName.Revert()
	_Seed_DrinkSkoomaWeak_MaintenanceName.Revert()
	_Seed_DrinkSkoomaStrong_MaintenanceName.Revert()

;/
	_Seed_DrinkNonAlcoholic_MaintenanceName.Revert()	
	_Seed_DrinkMilk_MaintenanceName.Revert()
	_Seed_Stews_MaintenanceName.Revert()
	_Seed_DrinkAlcoholicAle_MaintenanceName.Revert()
	_Seed_DrinkAlcoholicWine_MaintenanceName.Revert()
	_Seed_DrinkAlcoholicSpirit_MaintenanceName.Revert()
	_Seed_MeatRaw_MaintenanceName.Revert()
	_Seed_SmallGameRaw_MaintenanceName.Revert()
	_Seed_FishRaw_MaintenanceName.Revert()
	_Seed_SeafoodRaw_MaintenanceName.Revert()
	_Seed_Preserved_MaintenanceName.Revert()
	_Seed_SaltedFood_MaintenanceName.Revert()
/;
	
	
	_Seed_Bread_MaintenancePrice.Revert()
	_Seed_MeatRaw_MaintenancePrice.Revert()
	_Seed_MeatCooked_MaintenancePrice.Revert()
	_Seed_SmallGameRaw_MaintenancePrice.Revert()
	_Seed_SmallGameCooked_MaintenancePrice.Revert()
	_Seed_FishRaw_MaintenancePrice.Revert()
	_Seed_FishCooked_MaintenancePrice.Revert()
	_Seed_SeafoodRaw_MaintenancePrice.Revert()
	_Seed_SeafoodCooked_MaintenancePrice.Revert()
	_Seed_Vegetables_MaintenancePrice.Revert()
	_Seed_Fruit_MaintenancePrice.Revert()
	_Seed_Cheese_MaintenancePrice.Revert()
	_Seed_Treats_MaintenancePrice.Revert()
	_Seed_Pastries_MaintenancePrice.Revert()
	_Seed_Stews_MaintenancePrice.Revert()
	_Seed_CheeseBowls_MaintenancePrice.Revert()
	_Seed_DrinkMilk_MaintenancePrice.Revert()
	_Seed_DrinkAlcoholic_MaintenancePrice.Revert()
	_Seed_DrinkNonAlcoholic_MaintenancePrice.Revert()
	_Seed_FoodMiscObjects_MaintenancePrice.Revert()
	
	_Seed_Bread_MaintenanceWeight.Revert()
	_Seed_MeatRaw_MaintenanceWeight.Revert()
	_Seed_MeatCooked_MaintenanceWeight.Revert()
	_Seed_SmallGameRaw_MaintenanceWeight.Revert()
	_Seed_SmallGameCooked_MaintenanceWeight.Revert()
	_Seed_FishRaw_MaintenanceWeight.Revert()
	_Seed_FishCooked_MaintenanceWeight.Revert()
	_Seed_SeafoodRaw_MaintenanceWeight.Revert()
	_Seed_SeafoodCooked_MaintenanceWeight.Revert()
	_Seed_Vegetables_MaintenanceWeight.Revert()
	_Seed_Fruit_MaintenanceWeight.Revert()
	_Seed_Cheese_MaintenanceWeight.Revert()
	_Seed_Treats_MaintenanceWeight.Revert()
	_Seed_Pastries_MaintenanceWeight.Revert()
	_Seed_Stews_MaintenanceWeight.Revert()
	_Seed_CheeseBowls_MaintenanceWeight.Revert()
	_Seed_DrinkMilk_MaintenanceWeight.Revert()
	_Seed_DrinkAlcoholic_MaintenanceWeight.Revert()
	_Seed_DrinkNonAlcoholic_MaintenanceWeight.Revert()
	_Seed_FoodMiscObjects_MaintenanceWeight.Revert()
endFunction

function setFoodPrice(FormList FoodList, FormList maintenanceList)
	Int iIndex = FoodList.GetSize() as Int
	While iIndex > 0
		iIndex -= 1
		Form theFood = FoodList.GetAt(iIndex)
		int value = (theFood.GetGoldValue() * _Seed_Setting_FoodPriceMulti.getValue()) as int
		if(!maintenanceList.hasForm(theFood))
			maintenanceList.addForm(theFood)
			theFood.SetGoldValue(value)
		endif
	EndWhile
endFunction

function setFoodWeight(FormList FoodList, FormList maintenanceList)
	Int iIndex = FoodList.GetSize() as Int
	While iIndex > 0
		iIndex -= 1
		Form theFood = FoodList.GetAt(iIndex)
		if(!maintenanceList.hasForm(theFood))
			maintenanceList.addForm(theFood)
			theFood.SetWeight(theFood.GetWeight() *  _Seed_Setting_FoodWeightMulti.getValue())
		endif
	EndWhile
endFunction

Function AddMagicEffectToFormList(FormList FoodList, int index, FormList maintenanceList, bool ignoreWater = false)	
	Int iIndex = FoodList.GetSize() as Int
	While iIndex > 0
		iIndex -= 1
		Potion theFood = FoodList.GetAt(iIndex) as Potion
		If theFood
			AddMagicEffect(theFood, index, maintenanceList, ignoreWater)
		EndIf
	EndWhile
EndFunction

Function AddMagicEffect(potion theFood, int index, formlist maintenanceList, bool ignoreWater = false)	
	; Check for waterskins
	if ignoreWater && _Seed_DrinkWater.Find(theFood) != -1
		return
	endif
	
	;Add effect if it hasn't already been added
	magicEffect[] foodEffects = TheFood.GetMagicEffects()
	magicEffect effectToAdd = _Seed_TestFood.GetNthEffectMagicEffect(index)
	if foodEffects.RFind(effectToAdd) < 0 && !maintenanceList.hasForm(theFood)
		maintenanceList.addForm(theFood)
		PO3_SKSEFunctions.AddEffectItemToPotion(theFood, _Seed_TestFood, index)
	endif
EndFunction

Function AddNameType(FormList FoodList, String type, FormList maintenanceList)
	Int iIndex = FoodList.GetSize() as Int
	While iIndex > 0
		iIndex -= 1
		Form theFood = FoodList.GetAt(iIndex)
		string newName = theFood.GetName() + type
		If !maintenanceList.hasForm(theFood)
			maintenanceList.addForm(theFood)
			TheFood.SetName(newName)
		EndIf
	EndWhile
EndFunction
