;NO LONGER USED
Scriptname _Seed_ContainerSpoilHandler extends Quest

import Utility
import CampUtil
import SeedUtil
import _SeedInternal

GlobalVariable property _Seed_Setting_ContainerSpoilageEnable auto
GlobalVariable property _Seed_Setting_ContainerSpoilageRate auto

ObjectReference property _Seed_ProvisionsContainerRef Auto

MiscObject property _Seed_PerishedFood auto

Form[] property oldItems auto hidden
int[] property  oldCount auto hidden
int property  oldSize auto hidden
Int property  oldArraySize auto hidden
Form[] property  newItems auto hidden
int[] property  newCount auto hidden
int property  newSize auto hidden

Function spoilContainer(ObjectReference thisContainer, bool resetTime)
	if _Seed_Setting_ContainerSpoilageEnable.getValue() == 2 && resetTime
		if GetSKSELoaded()
			spoilContainerSKSE_Basic(thisContainer)
			;spoilContainerSKSE_Array(thisContainer)
			;spoilContainerSKSE_Container(thisContainer)
		else
			spoilContainerNonSKSE(thisContainer)
		endif
	endif
endFunction


;NOT USED
function addOldArrayItem(Form kForm, int amount)
	;/
	int existingIndex = -1
	existingIndex = oldItems.Find(kForm)
	if existingIndex > 0
		SeedDebug(1, "[ContainerSpoilHandler] Adding existing amount to old array: " + kForm + ": " + amount + " Index: " + oldSize)
		oldCount[existingIndex] = oldCount[existingIndex] + amount
	else
	/;
		SeedDebug(1, "[ContainerSpoilHandler] Adding new amount to old array: " + kForm + ": " + amount + " Index: " + oldSize)
		olditems[oldSize] = kForm
		oldCount[oldSize] = amount
		oldSize += 1
	;endif
endFunction

function addNewArrayItem(Form kForm, int amount)
	int existingIndex = -1
	existingIndex = newItems.Find(kForm)
	if existingIndex > 0
		SeedDebug(1, "[ContainerSpoilHandler] Adding existing amount to new array: " + kForm + ": " + amount + " Index: " + newSize)
		newCount[existingIndex] = newCount[existingIndex] + amount
	else
		SeedDebug(1, "[ContainerSpoilHandler] Adding new amount to new array: " + kForm + ": " + amount + " Index: " + newSize)
		newItems[newSize] = kForm
		newCount[newSize] = amount
		newSize += 1
	endif
endFunction

Function spoilContainerSKSE_Array(ObjectReference thisContainer)	
	oldArraySize = thisContainer.GetNumItems()
	oldItems = new Form[50]
	oldCount = new int[50]
	oldSize = 0
	int iFormIndex = oldArraySize
	While iFormIndex > 0
		iFormIndex -= 1
		Form kForm = thisContainer.GetNthForm(iFormIndex)
		int amount = thisContainer.GetItemCount(kForm)
		
		;addOldArrayItem(kForm, amount)
		;SeedDebug(1, "[ContainerSpoilHandler] Adding new amount to old array: " + kForm + ": " + amount + " Index: " + oldSize)
		olditems[oldSize] = kForm
		oldCount[oldSize] = amount
		oldSize += 1
		thisContainer.removeItem(kForm, amount)
	endWhile
	;thisContainer.RemoveAllItems()
	
	newItems = new Form[50]
	newCount = new int[50]
	newSize = 0
	
	int oldIndex = 0
	While oldIndex < oldSize
		form kForm = oldItems[oldIndex]
		if IsFood(kForm)
			SeedDebug(0, "[ContainerSpoilHandler] Found food - " + kForm)

			Potion food = kForm as Potion
			int foodType = GetFoodDatastoreHandler().IdentifyFood(food)
			if foodType > 0
				spoilFoodItemSKSE_Array(food, foodType, iFormIndex)
			else
				addNewArrayItem(kForm, oldCount[oldIndex])
			endif
		else
			addNewArrayItem(kForm, oldCount[oldIndex])
		endif
		oldIndex += 1
	EndWhile
	
	int newIndex = 0
	While newIndex < newSize
		thisContainer.addItem(newItems[newIndex], newCount[newIndex])
		newIndex += 1
	endWhile
endFunction

;TODO: If I start using this again I need to add a dedicated container.
Function spoilContainerSKSE_Container(ObjectReference thisContainer)	
	
	MoveAll(thisContainer, _Seed_ProvisionsContainerRef)
	
	Int iFormIndex = _Seed_ProvisionsContainerRef.GetNumItems()
	SeedDebug(0, "[ContainerSpoilHandler] Found " + iFormIndex + " Items")
	While iFormIndex > 0
		iFormIndex -= 1
		Form kForm = _Seed_ProvisionsContainerRef.GetNthForm(iFormIndex)

		if IsFood(kForm)
			SeedDebug(0, "[ContainerSpoilHandler] Found food - " + kForm)

			Potion food = kForm as Potion
			int foodType = GetFoodDatastoreHandler().IdentifyFood(food)
			spoilFoodItem(food, _Seed_ProvisionsContainerRef, foodType)
		endif
	EndWhile
	
	MoveAll(_Seed_ProvisionsContainerRef, thisContainer)
	
	;/
	Int iFormIndex = thisContainer.GetNumItems()
	SeedDebug(0, "[ContainerSpoilHandler] Found " + iFormIndex + " Items")
	While iFormIndex > 0
		iFormIndex -= 1
		Form kForm = thisContainer.GetNthForm(iFormIndex)

		if IsFood(kForm)
			SeedDebug(0, "[ContainerSpoilHandler] Found food - " + kForm)

			Potion food = kForm as Potion
			int foodType = GetFoodDatastoreHandler().IdentifyFood(food)
			spoilFoodItem(food, thisContainer, foodType)
		endif
	EndWhile
	/;
endFunction

Function spoilContainerSKSE_Basic(ObjectReference thisContainer)	
	Int iFormIndex = thisContainer.GetNumItems()
	SeedDebug(0, "[ContainerSpoilHandler] Found " + iFormIndex + " Items")
	While iFormIndex > 0
		iFormIndex -= 1
		Form kForm = thisContainer.GetNthForm(iFormIndex)
		if IsFood(kForm)
			SeedDebug(0, "[ContainerSpoilHandler] Found food - " + kForm)
			Potion food = kForm as Potion
			int foodType = GetFoodDatastoreHandler().IdentifyFood(food)
			spoilFoodItem(food, thisContainer, foodType)
		endif
	EndWhile
endFunction


function MoveAll(ObjectReference from, ObjectReference to)
	Int iFormIndex = from.GetNumItems()
	While iFormIndex > 0
		iFormIndex -= 1
		Form kForm = from.GetNthForm(iFormIndex)
		int amount = from.GetItemCount(kForm)
		from.removeItem(kForm, amount)
		to.AddItem(kForm, amount)
	endWhile
endFunction

;/
function MoveAll(ObjectReference from, ObjectReference to)
	Int iFormIndex = from.GetNumItems()
	While iFormIndex > 0
		iFormIndex -= 1
		Form kForm = from.GetNthForm(iFormIndex)
		int amount = from.GetItemCount(kForm)
		from.removeItem(kForm, amount)
		to.AddItem(kForm, amount)
	endWhile
endFunction
;/
;/
FOODTYPE_BREAD				= 1 
FOODTYPE_MEAT_RAW			= 2 
FOODTYPE_MEAT_COOKED		= 3 
FOODTYPE_SMALLGAME_RAW		= 4 
FOODTYPE_SMALLGAME_COOKED	= 5 
FOODTYPE_FISH_RAW		  	= 6 
FOODTYPE_FISH_COOKED		= 7 
FOODTYPE_SEAFOOD_RAW		= 8 
FOODTYPE_SEAFOOD_COOKED		= 9 
FOODTYPE_VEGETABLE		 	= 10
FOODTYPE_FRUIT			 	= 11
FOODTYPE_CHEESE				= 12
FOODTYPE_TREAT			 	= 13
FOODTYPE_PASTRY				= 14
FOODTYPE_STEW			  	= 15
FOODTYPE_CHEESEBOWL			= 16
DRINKTYPE_MILK			 	= 17
DRINKTYPE_ALCOHOLIC			= 18
DRINKTYPE_NONALCOHOLIC	 	= 19
/;

function spoilContainerNonSKSE(ObjectReference thisContainer)
	;Food Commonly Found in Containers
	spoilContainerNonSKSE_FindFood(thisContainer, 10)
	spoilContainerNonSKSE_FindFood(thisContainer, 11)
	spoilContainerNonSKSE_FindFood(thisContainer, 6)
	spoilContainerNonSKSE_FindFood(thisContainer, 8)
	spoilContainerNonSKSE_FindFood(thisContainer, 2)
	spoilContainerNonSKSE_FindFood(thisContainer, 4)
	
	;Other Food
	spoilContainerNonSKSE_FindFood(thisContainer, 1)
	spoilContainerNonSKSE_FindFood(thisContainer, 3)
	spoilContainerNonSKSE_FindFood(thisContainer, 5)
	spoilContainerNonSKSE_FindFood(thisContainer, 7)
	spoilContainerNonSKSE_FindFood(thisContainer, 9)
	spoilContainerNonSKSE_FindFood(thisContainer, 12)
	spoilContainerNonSKSE_FindFood(thisContainer, 13)
	spoilContainerNonSKSE_FindFood(thisContainer, 14)
	spoilContainerNonSKSE_FindFood(thisContainer, 15)
	spoilContainerNonSKSE_FindFood(thisContainer, 16)
	spoilContainerNonSKSE_FindFood(thisContainer, 17)
endFunction

function spoilContainerNonSKSE_FindFood(ObjectReference thisContainer, int foodType)
	formList foodList = GetFoodDatastoreHandler().getFoodList(foodType)
	if 	thisContainer.GetItemCount(foodList)
		Int i = foodList.GetSize()
		While i >= 0
			i -= 1
			Potion food = foodList.GetAt(i) as Potion
			if thisContainer.GetItemCount(food)
				spoilFoodItem(food, thisContainer, foodType)
			endif
		endWhile
	endif
endFunction

function spoilFoodItem(Potion food, ObjectReference thisContainer, int foodType)
	bool isPreserved = GetFoodDatastoreHandler().IsFoodPreserved(food)
	if foodType > 0 && !isPreserved	
		int spoiledAmout = 0
		int perishedAmount = 0
		int totalAmount = thisContainer.GetItemCount(food)
		int i = totalAmount
		While i > 0
			i -= 1
			if Utility.RandomFloat(0, 100) <= _Seed_Setting_ContainerSpoilageRate.getValue()
				if(Utility.RandomFloat(0, 100) <= 25)
					perishedAmount += 1
				else
					spoiledAmout += 1
				endif
			endif
		endWhile
		
		if spoiledAmout
			Form spoiled = GetFoodDatastoreHandler().GetSpoiledVersion(food, foodType)
			thisContainer.removeItem(food, spoiledAmout)
			thisContainer.AddItem(spoiled, spoiledAmout)
			SeedDebug(1, "[ContainerSpoilHandler] replacing " + food + " with " + spoiled + " - " + spoiledAmout + "/" + totalAmount)
		endif
		if perishedAmount
			thisContainer.removeItem(food, spoiledAmout)
			thisContainer.AddItem(_Seed_PerishedFood, perishedAmount)
			SeedDebug(1, "[ContainerSpoilHandler] replacing " + food + " with PerishedFoood - " + perishedAmount + "/" + totalAmount)
		endif
	endif
endFunction


function spoilFoodItemSKSE_Array(Potion food, int foodType, int index)
	bool isPreserved = GetFoodDatastoreHandler().IsFoodPreserved(food)
	if foodType > 0 && !isPreserved	
		int spoiledAmout = 0
		int perishedAmount = 0
		int totalAmount = oldCount[index]
		int i = totalAmount
		While i > 0
			i -= 1
			float random = Utility.RandomFloat(0, 100)
			float spoilrate = _Seed_Setting_ContainerSpoilageRate.getValue()
			if random <= spoilrate
				if random <= (spoilrate / 3)
					perishedAmount += 1
				else
					spoiledAmout += 1
				endif
			endif
		endWhile
		
		if spoiledAmout
			Form spoiled = GetFoodDatastoreHandler().GetSpoiledVersion(food, foodType)
			addNewArrayItem(spoiled, spoiledAmout)
			SeedDebug(1, "[ContainerSpoilHandler] replacing " + food + " with " + spoiled + " - " + spoiledAmout + "/" + totalAmount)
		endif
		if perishedAmount
			addNewArrayItem(_Seed_PerishedFood, perishedAmount)
			SeedDebug(1, "[ContainerSpoilHandler] replacing " + food + " with PerishedFoood - " + perishedAmount + "/" + totalAmount)
		endif
		
		int goodAmount = totalAmount - spoiledAmout - perishedAmount
		if goodAmount
			addNewArrayItem(food, goodAmount)
		endif
		
	endif
endFunction