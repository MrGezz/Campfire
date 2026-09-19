scriptname _Seed_AliasFoodMonitor extends ReferenceAlias
{ Tracks the food that goes into, and out of, a given alias for the purposes of tracking. }
;/
REFERENCED IN: Seed_SpoilSystemQuest - Aliases
/;

;import SeedUtil
import _SeedInternal
import campUtil

LastSeedAPI property LastSeed auto
ObjectReference property _Seed_TrackerAnchorRef auto
Activator property _Seed_PerishableFoodTracker auto
FormList property TrackingList auto
{ The formlist that tracks this container/actor alias. }
ObjectReference property _Seed_SpoiledFoodSystemContainerRef auto
bool property isActor = true auto
{ Default: true }

int property aliasId auto

GlobalVariable property _Seed_Setting_SpoilageEnable auto
GlobalVariable property _Seed_Setting_SpoilRate_IceWraithTeeth auto
Potion property _Seed_IceWraithTeeth auto
MiscObject property _Seed_IceWraithTeethOld auto

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
FormList property _Seed_Preserved auto
FormList property _Seed_SpoiledFoods auto

Potion property _Seed_Spoiled_Bread auto
Potion property _Seed_Spoiled_MeatRaw auto
Potion property _Seed_Spoiled_MeatCooked auto
Potion property _Seed_Spoiled_SmallGameRaw auto
Potion property _Seed_Spoiled_SmallGameCooked auto
Potion property _Seed_Spoiled_FishRaw auto
Potion property _Seed_Spoiled_FishCooked auto
Potion property _Seed_Spoiled_SeafoodRaw auto
Potion property _Seed_Spoiled_SeafoodCooked auto
Potion property _Seed_Spoiled_Vegetable auto
Potion property _Seed_Spoiled_Fruit auto
Potion property _Seed_Spoiled_Cheese auto
Potion property _Seed_Spoiled_Treat auto
Potion property _Seed_Spoiled_Pastry auto
Potion property _Seed_Spoiled_Stew auto
Potion property _Seed_Spoiled_CheeseBowl auto
Potion property _Seed_Spoiled_Milk auto
MiscObject property _Seed_PerishedFood auto

; Spoil Rates
GlobalVariable property _Seed_Setting_SpoilRate01_Bread auto
GlobalVariable property _Seed_Setting_SpoilRate02_RawMeat auto
GlobalVariable property _Seed_Setting_SpoilRate03_CookedMeat auto
GlobalVariable property _Seed_Setting_SpoilRate04_RawSmallGame auto
GlobalVariable property _Seed_Setting_SpoilRate05_CookedSmallGame auto
GlobalVariable property _Seed_Setting_SpoilRate06_RawFish auto
GlobalVariable property _Seed_Setting_SpoilRate07_CookedFish auto
GlobalVariable property _Seed_Setting_SpoilRate08_RawSeafood auto
GlobalVariable property _Seed_Setting_SpoilRate09_CookedSeafood auto
GlobalVariable property _Seed_Setting_SpoilRate10_Vegitables auto
GlobalVariable property _Seed_Setting_SpoilRate11_Fruit auto
GlobalVariable property _Seed_Setting_SpoilRate12_Cheese auto
GlobalVariable property _Seed_Setting_SpoilRate13_Treats auto
GlobalVariable property _Seed_Setting_SpoilRate14_Pastry auto
GlobalVariable property _Seed_Setting_SpoilRate15_Stew auto
GlobalVariable property _Seed_Setting_SpoilRate16_CheeseBowls auto
GlobalVariable property _Seed_Setting_SpoilRate17_Milk auto

Event OnInit()
	addInventoryEventFilters()
EndEvent

Function addInventoryEventFilters()	
	AddInventoryEventFilter(_Seed_Bread)
	AddInventoryEventFilter(_Seed_MeatRaw)
	AddInventoryEventFilter(_Seed_MeatCooked)
	AddInventoryEventFilter(_Seed_SmallGameRaw)
	AddInventoryEventFilter(_Seed_SmallGameCooked)
	AddInventoryEventFilter(_Seed_FishRaw)
	AddInventoryEventFilter(_Seed_FishCooked)
	AddInventoryEventFilter(_Seed_SeafoodRaw)
	AddInventoryEventFilter(_Seed_SeafoodCooked)
	AddInventoryEventFilter(_Seed_Vegetables)
	AddInventoryEventFilter(_Seed_Fruit)
	AddInventoryEventFilter(_Seed_Cheese)
	AddInventoryEventFilter(_Seed_Treats)
	AddInventoryEventFilter(_Seed_Pastries)
	AddInventoryEventFilter(_Seed_Stews)
	AddInventoryEventFilter(_Seed_CheeseBowls)
	AddInventoryEventFilter(_Seed_DrinkMilk)
	AddInventoryEventFilter(_Seed_IceWraithTeeth)
EndFunction

function stopSpoilage()	
	int i = TrackingList.GetSize()
	while i
		i = i - 1
		ObjectReference ref = TrackingList.GetAt(i) as ObjectReference
		if ref
			_Seed_PerishableFoodTrackerScript tracker = ref as _Seed_PerishableFoodTrackerScript
			tracker.deleteTracker()
		endif
	endWhile
	TrackingList.revert()
endFunction
													 
Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if _Seed_Setting_SpoilageEnable.getValueInt() == 2 && akBaseItem as Potion
		Potion food = akBaseItem as Potion
		
		int foodType = IdentifyFood(food)
		bool isPreserved = IsFoodPreserved(food)
		bool isIceWraithTeeth = food == _Seed_IceWraithTeeth
		if (foodType > 0 && !isPreserved) || isIceWraithTeeth
			Form spoiled = none
			int spoilDuration = -1
			if isIceWraithTeeth
				spoiled = _Seed_IceWraithTeethOld
				spoilDuration = _Seed_Setting_SpoilRate_IceWraithTeeth.getValue() as int
			else
				spoiled = GetSpoiledVersion(food, foodType)
				spoilDuration = GetFoodMaxPerishDurationByType(foodType)
			endif

			if !spoiled || spoilDuration == -1
				return
			endif

			ObjectReference ref = _Seed_TrackerAnchorRef.PlaceAtMe(_Seed_PerishableFoodTracker)
			_Seed_PerishableFoodTrackerScript tracker = ref as _Seed_PerishableFoodTrackerScript

			tracker.Food = akBaseItem
			tracker.SpoiledFood = spoiled
			tracker.Quantity = aiItemCount
			tracker.MaxPerishHours = spoilDuration
			tracker.MyTrackingList = TrackingList			
			if isActor
				tracker.TrackedContainer = self.GetActorRef()
			else
				tracker.TrackedContainer = self.GetRef()
			endif
			;REGISTER FOR UPDATES
			;/
			if GetSKSELoaded()
				if aliasId == 0 ;PLAYER
					tracker.startupPlayer()	
				elseif aliasId == 1 ;PROVISIONS
					tracker.startupProvisions()	
				else
					tracker.startupFollower()	
				endif
			else
				tracker.startupNonSKSE()
			endif
			/;
			tracker.startupNonSKSE()
			
			SeedDebug(0, "New tracker data >>>> Food: " + akBaseItem + ", Spoiled Food: " + spoiled + ", Count: " + aiItemCount + ", Max Perish Hours: " + spoilDuration + ", TrackedContainer: " + tracker.TrackedContainer)

			TrackingList.AddForm(tracker)
			SeedDebug(0, "Added " + tracker + " to the list " + TrackingList)
			SeedDebug(0, "State of the Food Tracking FormList is:")
			int j = 0
			while j < TrackingList.GetSize()
				SeedDebug(0, "    " + TrackingList.GetAt(j))
				j += 1
			endWhile
		endif
	endif
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	GoToState("Processing")
	SeedDebug(0, "_Seed_AliasFoodMonitor OnItemRemoved")
	if _Seed_Setting_SpoilageEnable.getValueInt() == 2 && akBaseItem as Potion
		SeedDebug(0, "_Seed_AliasFoodMonitor item was food.")
		if akDestContainer == _Seed_SpoiledFoodSystemContainerRef
			; This item was removed due to food spoilage. Allow the tracker to handle its own state.
			return
		endif
		
		int foodType = IdentifyFood(akBaseItem as Potion)
		bool isPreserved = IsFoodPreserved(akBaseItem as Potion)
		if foodType > 0 && !isPreserved
			int remaining = aiItemCount
			int i = TrackingList.GetSize() - 1
			while remaining > 0 && i >= 0
				ObjectReference ref = TrackingList.GetAt(i) as ObjectReference
				if ref
					_Seed_PerishableFoodTrackerScript tracker = ref as _Seed_PerishableFoodTrackerScript
					if tracker.Food == akBaseItem && tracker.Quantity > 0
						int amountRemoved = tracker.ReduceQuantity(remaining) ; remove the quantity (the function returns the number actually removed and deletes itself if necessary)
						remaining -= amountRemoved
					
						if remaining > 0
							SeedDebug(0, "Starting the tracker search over.")
							i = TrackingList.GetSize() - 1
						endif
					else
						SeedDebug(0, "Checking next value. Reason: Food = " + tracker.Food + ", Quantity = " + tracker.Quantity)
						i -= 1
					endif
				else
					SeedDebug(0, "Checking next value. Reason: ref was None")
					i -= 1
				endif
			endWhile

			SeedDebug(0, "Finished search. State of the Food Tracking FormList is:")
			int j = 0
			while j < TrackingList.GetSize()
				SeedDebug(0, "    " + TrackingList.GetAt(j))
				j += 1
			endWhile
		endif
	endif
	GoToState("")
EndEvent

;NOTE: This method is from FoodDataStoreHandler, copied here for performance
int function IdentifyFood(Potion food)
	
	if _Seed_Bread.HasForm(food)
		return 1
	elseif _Seed_MeatRaw.HasForm(food)
		return 2		
	elseif _Seed_MeatCooked.HasForm(food)
		return 3		
	elseif _Seed_SmallGameRaw.HasForm(food)
		return 4	
	elseif _Seed_SmallGameCooked.HasForm(food)
		return 5	
	elseif _Seed_FishRaw.HasForm(food)
		return 6
	elseif _Seed_FishCooked.HasForm(food)
		return 7
	elseif _Seed_SeafoodRaw.HasForm(food)
		return 8	
	elseif _Seed_SeafoodCooked.HasForm(food)
		return 9
	elseif _Seed_Vegetables.HasForm(food)
		return 10
	elseif _Seed_Fruit.HasForm(food)
		return 11
	elseif _Seed_Cheese.HasForm(food)
		return 12
	elseif _Seed_Treats.HasForm(food)
		return 13
	elseif _Seed_Pastries.HasForm(food)
		return 14		
	elseif _Seed_Stews.HasForm(food)
		return 15
	elseif _Seed_CheeseBowls.HasForm(food)
		return 16
	elseif _Seed_DrinkMilk.HasForm(food)
		return 17
	; DRINKS - CAN'T SPOIL
	;/
		elseif _Seed_DrinkAlcoholic.HasForm(food)
		return 18
	if _Seed_DrinkNonAlcoholic.HasForm(food)
		return 19
	/;
	
	; HUNTERBORN SOUPS AND STEWS
	elseIf seedUtil.GetCompatibilitySystem().isHunterbornSoupsLoaded
		keyword Soup = Game.GetFormFromFile(0x0028CD32, "Hunterborn - Soups and Stews.esp") as keyword				; _DS_KW_Food_Soup [KYWD:0x0028CD32]
		If food.HasKeyword(Soup)
			return 15
		endIf
	endif	
	
	;FAIL
	return 0
endFunction


;NOTE: This method is from FoodDataStoreHandler, copied here for performance
int function GetFoodMaxPerishDurationByType(int aiFoodType)
    if aiFoodType < 1 || aiFoodType > 17
        return -1
    endif

	; Bread
	if aiFoodType == 1
		return _Seed_Setting_SpoilRate01_Bread.getValueInt()
	; Raw meat
	elseif aiFoodType == 2
		return _Seed_Setting_SpoilRate02_RawMeat.getValueInt()
	; Cooked meat
	elseif aiFoodType == 3
		return _Seed_Setting_SpoilRate03_CookedMeat.getValueInt()
	; Raw Small Game
	elseif aiFoodType == 4
		return _Seed_Setting_SpoilRate04_RawSmallGame.getValueInt()
	; Cooked Small Game
	elseif aiFoodType == 5
		return _Seed_Setting_SpoilRate05_CookedSmallGame.getValueInt()
	; Raw Fish
	elseif aiFoodType == 6
		return _Seed_Setting_SpoilRate06_RawFish.getValueInt()
	; Cooked Fish
	elseif aiFoodType == 7
		return _Seed_Setting_SpoilRate07_CookedFish.getValueInt()
	; Raw Seafood
	elseif aiFoodType == 8
		return _Seed_Setting_SpoilRate08_RawSeafood.getValueInt()
	; Cooked Seafood
	elseif aiFoodType == 9
		return _Seed_Setting_SpoilRate09_CookedSeafood.getValueInt()
	; Vegitables
	elseif aiFoodType == 10
		return _Seed_Setting_SpoilRate10_Vegitables.getValueInt()
	; Fruit
	elseif aiFoodType == 11
		return _Seed_Setting_SpoilRate11_Fruit.getValueInt()
	; Cheese
	elseif aiFoodType == 12
		return _Seed_Setting_SpoilRate12_Cheese.getValueInt()
	; Treats
	elseif aiFoodType == 13
		return _Seed_Setting_SpoilRate13_Treats.getValueInt()
	; Pastry
	elseif aiFoodType == 14
		return _Seed_Setting_SpoilRate14_Pastry.getValueInt()
	; Stew
	elseif aiFoodType == 15
		return _Seed_Setting_SpoilRate15_Stew.getValueInt()
	; Cheese bowls
	elseif aiFoodType == 16
		return _Seed_Setting_SpoilRate16_CheeseBowls.getValueInt()
	; Milk
	elseif aiFoodType == 17
		return _Seed_Setting_SpoilRate17_Milk.getValueInt()
	endif
	
    return -1
endFunction

;NOTE: This method is from FoodDataStoreHandler, copied here for performance

bool function IsFoodPreserved(Potion food)
	if _Seed_Preserved.HasForm(food)
		return true
	else
		return false
	endif
endFunction

;NOTE: This method is from FoodDataStoreHandler, copied here for performance
Form function GetSpoiledVersion(Potion food, int foodType)	
	if _Seed_SpoiledFoods.HasForm(food)
		return _Seed_PerishedFood
	endif
	
	if foodType == 1
		return _Seed_Spoiled_Bread
	elseif foodType == 2
		return _Seed_Spoiled_MeatRaw
	elseif foodType == 3
		return _Seed_Spoiled_MeatCooked
	elseif foodType == 4
		return _Seed_Spoiled_SmallGameRaw
	elseif foodType == 5
		return _Seed_Spoiled_SmallGameCooked
	elseif foodType == 6
		return _Seed_Spoiled_FishRaw
	elseif foodType == 7
		return _Seed_Spoiled_FishCooked
	elseif foodType == 8
		return _Seed_Spoiled_SeafoodRaw
	elseif foodType == 9
		return _Seed_Spoiled_SeafoodCooked
	elseif foodType == 10
		return _Seed_Spoiled_Vegetable
	elseif foodType == 11
		return _Seed_Spoiled_Fruit
	elseif foodType == 12
		return _Seed_Spoiled_Cheese
	elseif foodType == 13
		return _Seed_Spoiled_Treat
	elseif foodType == 14
		return _Seed_Spoiled_Pastry
	elseif foodType == 15
		return _Seed_Spoiled_Stew
	elseif foodType == 16
		return _Seed_Spoiled_CheeseBowl
	elseif foodType == 17
		return _Seed_Spoiled_Milk
	endif
endFunction

State Processing
	Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
		GoToState("")
		SeedDebug(0, "_Seed_AliasFoodMonitor suppressing duplicate call.")
	EndEvent
endState