Scriptname _Seed_ProvisionsContainer extends ObjectReference
;/
REFERENCED IN: 
_Seed_ProvisionsContainerRef
(In Seed_SpoilSystemUtilityCell)
/;
import CampUtil
import SeedUtil
import _SeedInternal

Keyword property VendorItemFood auto
Keyword property VendorItemFoodRaw auto

GlobalVariable property _Seed_Provisions_CurrentWeight auto
GlobalVariable property _Seed_Provisions_WeightPerPerson auto
GlobalVariable property _Seed_Provisions_TotalWeight auto
GlobalVariable property _Seed_Classifying_Food auto ; NO LONGER USED
GlobalVariable property _Seed_ProvisionsAddPortions auto


string property debugSystemName = "ProvisionContainer" auto hidden

Actor property PlayerRef auto

Message property _Seed_ProvisionsOnlyFoodMsg auto

float property oldInventoryWeight auto hidden
float property newInventoryWeight auto hidden

bool property provisionsContainerOpened = false auto hidden

Event OnActivate(ObjectReference akActionRef)
	opening()
	Utility.Wait(0.1)
	closing()
endEvent

function opening()
	if GetSKSELoaded()
		int handle = ModEvent.Create("LastSeed_ProvisionsOpened")
		if (handle)
			ModEvent.Send(handle)
		endIf		
	endif
	
	SeedDebug(1, "[" + debugSystemName + "]: Opening Provisions.")
	_Seed_ProvisionsAddPortions.SetValue(2)
	
	provisionsContainerOpened = true
	
	;Set total weight
	float totalWeight = _Seed_Provisions_WeightPerPerson.getValue() * (getTrackedPartyCount() + 1)
	_Seed_Provisions_TotalWeight.SetValue(totalWeight)
	
	;Reset weight if provisions container is empty
	if self.GetItemCount(VendorItemFood) <= 0 && self.GetItemCount(VendorItemFoodRaw) <= 0 
		_Seed_Provisions_CurrentWeight.setValue(0)
		SeedDebug(0, "[" + debugSystemName + "]: Resetting Provisions Weight.")
	; Set current weight if SKSE is installed
	elseif GetSKSELoaded()
		_Seed_Provisions_CurrentWeight.setValue(self.GetTotalItemWeight())
	endif
	;get current player inventory weight if SKSE Not installed
	if !GetSKSELoaded()			
		oldInventoryWeight = PlayerRef.GetActorValue("InventoryWeight")
	endif
	SeedDebug(0, "[" + debugSystemName + "]: Provision Weight " + displayWeight())
	Debug.Notification(GetTranslationHandler().ProvisionsWeight + displayWeight())
endFunction

function closing()

	provisionsContainerOpened = false
	_Seed_ProvisionsAddPortions.SetValue(1)
	
	Debug.Notification(GetTranslationHandler().ProvisionsWeight + displayWeight())
	
	;Auto-Eat
	GetConsumeManager().Player_AutoEat(1)
	GetConsumeManager().Player_AutoDrink(1)
	
	GetConsumeManagerParty().AutoEat(1)
	GetConsumeManagerParty().AutoDrink(1)
	
	int i = 1
	while i <= 3
		if CampUtil.GetTrackedFollower(i) != none
			GetConsumeManagerFollowers().NPC_AutoEat(i, 1)
			GetConsumeManagerFollowers().NPC_AutoDrink(i, 1)
		endif
	i += 1
	endwhile
endFUnction


Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	;Only allow food
	if !IsKnownFood(akBaseItem, true, false)
		;Classify unknown food
		if isFood(akBaseItem) && !IsKnownFood(akBaseItem, true, true)
			Self.RemoveItem(akBaseItem, aiItemCount, true, PlayerRef)
			GetCustomiseFoodHandler().classifyFood(akBaseItem as Potion)
		elseif provisionsContainerOpened
			Self.RemoveItem(akBaseItem, aiItemCount, true, PlayerRef)
			_Seed_ProvisionsOnlyFoodMsg.Show()
		else
			Self.RemoveItem(akBaseItem, aiItemCount, false, PlayerRef)
		endif
	else
		float newWeight = 0
		if GetSKSELoaded()
			newWeight  = self.GetTotalItemWeight()
			SeedDebug(0, "[" + debugSystemName + "]: Getting provision weight (SKSE): " + newWeight)
		else 
			newInventoryWeight = PlayerRef.GetActorValue("InventoryWeight")
			newWeight = _Seed_Provisions_CurrentWeight.getValue() + (oldInventoryWeight - newInventoryWeight)
			SeedDebug(0, "[" + debugSystemName + "]: Getting provision weight (Non-SKSE): " + newWeight)
		endif
		if(newWeight > _Seed_Provisions_TotalWeight.getValue())
			Self.RemoveItem(akBaseItem, aiItemCount, True, PlayerRef)
			Debug.Notification(GetTranslationHandler().ProvisionsOverweight + "(" + displayWeight() + ").")
		else
			_Seed_Provisions_CurrentWeight.setValue(newWeight)
			if !GetSKSELoaded()
				oldInventoryWeight = newInventoryWeight
			endIf
		endIf
	endif
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	if containerHasItems()
		float newWeight = 0
		if GetSKSELoaded()
			newWeight  = self.GetTotalItemWeight()
			SeedDebug(0, "[" + debugSystemName + "]: Getting provision weight (SKSE): " + newWeight)
		else 
			newInventoryWeight = PlayerRef.GetActorValue("InventoryWeight")
			newWeight = _Seed_Provisions_CurrentWeight.getValue() - (newInventoryWeight - oldInventoryWeight)
			SeedDebug(0, "[" + debugSystemName + "]: Getting provision weight (Non-SKSE): " + newWeight)
		endif

		_Seed_Provisions_CurrentWeight.setValue(newWeight)
		if !GetSKSELoaded()
			oldInventoryWeight = newInventoryWeight
		endIf
	else
		_Seed_Provisions_CurrentWeight.setValue(0)
		SeedDebug(1, "[" + debugSystemName + "]: Resetting Inventory weight")
	endif
EndEvent

bool function containerHasItems()
	int i = 17
	while i
		formList foodList = GetFoodDatastoreHandler().getFoodList(i)
		if self.GetItemCount(foodList)
			SeedDebug(1, "[" + debugSystemName + "]: Container has items.")
			return true
		endif
		i = i - 1
	endWhile
	SeedDebug(1, "[" + debugSystemName + "]: Container is empty.")
	return false
endFunction

string function displayWeight()
	return "" + Round(_Seed_Provisions_CurrentWeight.getValue(), 1) + "/" + Round(_Seed_Provisions_TotalWeight.getValue(), 0)
endFunction

string Function Round(float number, int precision)
    string result = number as int
    number -= number as int
    if precision > 0
        result += "."
    endif
    while precision > 0
        number *= 10
        precision -= 1
        if precision == 0
            number += 0.5
        endif
        result += number as int
        number -= number as int
    endwhile
    return result
EndFunction
