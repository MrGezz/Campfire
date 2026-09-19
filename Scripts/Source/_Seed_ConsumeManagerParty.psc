Scriptname _Seed_ConsumeManagerParty extends _Seed_ConsumeManager

import _SeedInternal
import seedUtil
import CampUtil
import Utility

GlobalVariable property _Seed_Setting_DiseaseChanceRawFood auto
GlobalVariable property _Seed_Setting_DiseaseChanceStaleFood auto
GlobalVariable property _Seed_Setting_DiseaseChanceDirtyWater auto

String property PartyHungerMessage = "" auto hidden
String property PartyThirstMessage = "" auto hidden

bool property partyAutoEating = false auto hidden
bool property partyAutoDrinking = false auto hidden
bool property partyAutoFeeding = false auto hidden

bool property enqueueEatAnimationParty = false auto hidden
bool property enqueueDrinkAnimationParty = false auto hidden

FormList property _Seed_AutoEatenParty auto
FormList property _Seed_AutoDrankParty auto

bool function getAutoEating()
	return partyAutoEating
endFunction

bool function getAutoDrinking()
	return partyAutoDrinking
endFunction

bool function getAutoFeeding()
	return partyAutoFeeding
endFunction

function AutoEat(int limit = 0)
	_Seed_MonsterHandler monster = GetMonsterHandler()
	bool notMortalVampires = monster.getVampireSettingsBasic(false, true, true)	
	
	if getPartyHungerSystem().isRunning() && GetPartyHungerLevel() > limit
		SpoilFood()
		
		if monster.hasAllVampireFollowers() && notMortalVampires
			partyAutoFeeding = true
		elseif monster.hasSomeVampireFollowers() && notMortalVampires
			if RandomInt(1, 2) == 2 && !partyAutoFeeding
				partyAutoEating = true
			elseif !partyAutoEating
				partyAutoFeeding = true
			endif
		else
			partyAutoEating = true
		endif
        
		startUpdating()
    endif
endFunction

function AutoDrink(int limit = 0)
    _Seed_MonsterHandler monster = GetMonsterHandler()
	bool notMortalVampires = monster.getVampireSettingsBasic(false, true, true)	
	if getPartyThirstSystem().isRunning() && GetPartyThirstLevel() > limit
		SpoilFood()
		if monster.hasAllVampireFollowers() && notMortalVampires
			partyAutoFeeding = true
		elseif monster.hasSomeVampireFollowers() && notMortalVampires
			if RandomInt(1, 2) == 2 && !partyAutoFeeding
				partyAutoDrinking = true
			elseif !partyAutoDrinking
				partyAutoFeeding = true
			endif
		else
			partyAutoDrinking = true
		endif
        startUpdating()
    endif
endFunction

Function EnqueuePartyHungerMessage(String msg)
    partyHungerMessage = msg
    startUpdating()
endFunction

Function EnqueuePartyThirstMessage(String msg)
    partyThirstMessage = msg
    startUpdating()
endFunction

function startAutoConsuming()
    Party_AutoFeeding()
    Party_AutoEating()
    Party_AutoDrinking()
        
    if partyAutoEating || partyAutoDrinking || PartyAutoFeeding
        registerForSingleUpdate(waitTime)
        SeedDebug(0, "[ConsumeManager] still auto-consuming...")
    else
        isUpdating = false
        SeedDebug(0, "[ConsumeManager] Stopping auto-consuming")
        
        ; Show Follower Messages & Animations
        if PartyHungerMessage != "" && _Seed_Setting_Notifications_Followers.getValue() as int == 2
            debug.notification(PartyHungerMessage)
        endif
		PartyEatAnimation()
    
        if PartyThirstMessage != "" && _Seed_Setting_Notifications_Followers.getValue() as int == 2
			debug.notification(PartyThirstMessage)
        endif
		PartyDrinkAnimation()
        PartyHungerMessage = ""
        PartyThirstMessage = ""
		_Seed_AutoEatenParty.Revert()
		_Seed_AutoDrankParty.Revert()
	Endif        
endFunction

Function PartyEatAnimation()
	if enqueueEatAnimationParty		
		GetAnimationHandler().eatAnimation(1)
		GetAnimationHandler().eatAnimation(2)
		GetAnimationHandler().eatAnimation(3)
	endif
	enqueueEatAnimationParty = false
EndFunction

Function PartyDrinkAnimation()
	if enqueueDrinkAnimationParty		
		GetAnimationHandler().drinkAnimation(1)
		GetAnimationHandler().drinkAnimation(2)
		GetAnimationHandler().drinkAnimation(3)
	endif
	enqueueDrinkAnimationParty = false	
EndFunction

function Party_AutoFeeding()
	if partyAutoFeeding
		form theFood = fetchBloodPotion_Party()
		if theFood != _Seed_ProvisionsLockedToken
			if theFood != none
				getPartyHungerSystem().DecreaseAttribute(120.0)
				getPartyThirstSystem().DecreaseAttribute(120.0)
				;Show Message
				SeedDebug(0, "[ConsumeManager] showing player eaten message")
				if getSKSELoaded()
					Debug.Notification(GetTranslationHandler().getPartyName() + GetTranslationHandler().DrankSome + theFood.getName())
				endif
			endif
			; Stop Feeding
			PartyAutoFeeding = false
		endif
	endif
endFunction

Form Function fetchBloodPotion_Party()    
    if !lockContainer()
   	 return _Seed_ProvisionsLockedToken
    endif
    form result = none
	Int iIndex = _Seed_BloodPotions.GetSize() ; Indices are offset by 1 relative to size
	potion thePotion = none
	While iIndex
		iIndex -= 1
		thePotion = _Seed_BloodPotions.GetAt(iIndex) as Potion
		If thePotion && _Seed_ProvisionsContainerRef.GetItemCount(thePotion) > 0
			_Seed_ProvisionsContainerRef.RemoveItem(thePotion, 1, true)
			result = thePotion
			iIndex = 0
		endif
	EndWhile	 
    unlockContainer()
    return result
EndFunction

function Party_AutoEating()
    if partyAutoEating
        if GetPartyHungerLevel() > 0
            SeedDebug(0, "[ConsumeManager] party is hungry.")
			potion theFood = _Seed_ProvisionsLockedToken
			if getSKSELoaded()
				theFood = fetchFoodParty_SKSE() as potion
			else
				theFood = fetchFoodParty() as potion
			endif
            if theFood != _Seed_ProvisionsLockedToken
                if theFood != none					
					; Add to eaten food list
					if _Seed_AutoEatenParty.Find(theFood) == -1
						_Seed_AutoEatenParty.addForm(theFood)
					endIf
					
					;Add To Provisions Portions List
					processMultiPartFood(theFood)
					getFollowerSystem().eatAndDrinkParty(theFood)
                    
                    SeedDebug(0, "[ConsumeManager] Fetched party Food: " + theFood)
					
					enqueueEatAnimationParty = true
                else
                    partyAutoEating = false
                    SeedDebug(0, "[ConsumeManager] Finished Party Auto-eating: not satisfied")
                endif
            endif
        else
            SeedDebug(0, "[ConsumeManager] Finished Party Auto-eating: Satisfied")
            partyAutoEating = false
        endif
    endif
	
	;Show Message
    if !partyAutoEating
		if _Seed_AutoEatenParty.GetSize() > 0 && _Seed_Setting_Notifications_Followers.GetValueInt() == 2
			SeedDebug(0, "[ConsumeManager] showing player eaten message")
			String EatenFood = getConsumedMessage(_Seed_AutoEatenParty)
			if(EatenFood != "")
				Debug.Notification(GetTranslationHandler().getPartyName() + GetTranslationHandler().AteSome + EatenFood)
			endif
			EatenFood = ""
		endif
		_Seed_AutoEatenParty.Revert()
    endif
endFunction

function Party_AutoDrinking()
    if partyAutoDrinking
   	 if GetPartyThirstLevel() > 0
   		 SeedDebug(0, "[ConsumeManager] party is thirsty.")
   		 bool drinkAlcohol = getPartyThirstSystem().isSober()
   		 SeedDebug(0, "[ConsumeManager] party is Sober: " + drinkAlcohol)
			potion theDrink = _Seed_ProvisionsLockedToken
			if getSKSELoaded()
				theDrink = fetchDrinkParty_SKSE(drinkAlcohol) as potion
			else
				theDrink = fetchDrinkParty(drinkAlcohol) as potion
			endif
			if theDrink != _Seed_ProvisionsLockedToken
   			 if theDrink != none    
   				 if _Seed_AutoDrankParty.Find(theDrink) == -1
   					if _Seed_DrinkWater.find(theDrink) == -1
						_Seed_AutoDrankParty.addForm(theDrink)
					elseif _Seed_AutoDrankParty.Find(_Seed_Waterskin3Clean) == -1
						_Seed_AutoDrankParty.addForm(_Seed_Waterskin3Clean)	
   					endIf
   				 endIf
				processMultiPartFood(theDrink)
				getFollowerSystem().eatAndDrinkParty(theDrink)
				 
   				 ;Drink Beverage
   				 SeedDebug(0, "[ConsumeManager] Fetched Party drink: " + theDrink)
				 enqueueDrinkAnimationParty = true
   			 else
   				 partyAutoDrinking = false
   				 SeedDebug(0, "[ConsumeManager] Finished Party Auto-drinking: Not satisfied")
   			 endIf
   		 endIf
   	 else
   		 SeedDebug(0, "[ConsumeManager] Finished Party Auto-drinking: Not satisfied")
   		 partyAutoDrinking = false
   	 endIf
	 
	;Show Message
    if !partyAutoDrinking
		if _Seed_AutoDrankParty.GetSize() > 0 && _Seed_Setting_Notifications_Followers.GetValueInt() == 2
			SeedDebug(0, "[ConsumeManager] showing player eaten message")
			String drankBeverages = getConsumedMessage(_Seed_AutoDrankParty)
			if(drankBeverages != "" && _Seed_Setting_Notifications_Followers.GetValueInt() == 2)
				Debug.Notification(GetTranslationHandler().getPartyName() + GetTranslationHandler().DrankSome + drankBeverages)
			endif
			drankBeverages = ""
		endif
		_Seed_AutoEatenParty.Revert()
    endif
	endif
endFunction
    


form Function fetchFoodParty_SKSE()
	if !lockContainer()
		return _Seed_ProvisionsLockedToken
	endif
	Int iFormIndex = _Seed_ProvisionsContainerRef.GetNumItems()
	int[] randomList = getRandomList(iFormIndex)
	While iFormIndex > 0
		iFormIndex -= 1
		Form currentItem = _Seed_ProvisionsContainerRef.GetNthForm(randomList[iFormIndex])
		If isEdible(currentItem) && !isDrink(currentItem) && getDiseaseChance(currentItem, GetRandomFollower()) <= 0
			if _Seed_Setting_FollowersConsumeFood.getValueInt() == 2 || (currentItem.hasKeyword(VendorItemFoodMultiPart) && GetFoodDatastoreHandler().GetMultiPartFoodResult_Array(currentItem as potion) == none)
				Actor Target = getRandomFollower()
				if target 
					_Seed_ProvisionsContainerRef.RemoveItem(currentItem, 1, true, Target)
					Target.EquipItem(currentItem, false, true)
				else
					_Seed_ProvisionsContainerRef.RemoveItem(currentItem, 1, true)
				endif
			else					
				_Seed_ProvisionsContainerRef.RemoveItem(currentItem, 1, true)
			endif
			unlockContainer()
			return currentItem
		EndIf
	EndWhile
	unlockContainer()
    return none
EndFunction

form Function fetchDrinkParty_SKSE(bool drinkAlcohol)
    if !lockContainer()
		return _Seed_ProvisionsLockedToken
    endif
	Int iFormIndex = _Seed_ProvisionsContainerRef.GetNumItems()
	int[] randomList = getRandomList(iFormIndex)
	While iFormIndex > 0
		iFormIndex -= 1
		Form currentItem = _Seed_ProvisionsContainerRef.GetNthForm(randomList[iFormIndex])
		If isEdible(currentItem) && isDrink(currentItem, drinkAlcohol) && getDiseaseChance(currentItem, getRandomFollower()) <= 0		
			if _Seed_Setting_FollowersConsumeFood.getValueInt() == 2 || (currentItem.hasKeyword(VendorItemFoodMultiPart) && GetFoodDatastoreHandler().GetMultiPartFoodResult_Array(currentItem as potion) == none)
				Actor Target = getRandomFollower()
				if target 
					_Seed_ProvisionsContainerRef.RemoveItem(currentItem, 1, true, Target)
					Target.EquipItem(currentItem, false, true)
				else
					_Seed_ProvisionsContainerRef.RemoveItem(currentItem, 1, true)
				endif
			else					
				_Seed_ProvisionsContainerRef.RemoveItem(currentItem, 1, true)
			endif
			unlockContainer()
			return currentItem
		EndIf
	EndWhile
	unlockContainer()
    return none
endFunction


Form Function fetchFoodParty()    
    SeedDebug(0, "[ConsumeManager] fetchFood.")
    
    if !lockContainer()
        return _Seed_ProvisionsLockedToken
    endif
    
    ;Find and eat food
    form result = none
    
    ; If target can eat raw food, fetch raw food
   
    if _Seed_Setting_DiseaseChanceRawFood.getValueInt() == 0
        result =  fetchFromListParty(_Seed_SmallGameRaw, false)
        If result == none
            result = fetchFromListParty(_Seed_SeafoodRaw, false)
        EndIf
        If result == none
            result = fetchFromListParty(_Seed_FishRaw, false)
        EndIf
        If result == none
            result = fetchFromListParty(_Seed_MeatRaw, false)
        EndIf
    endif

    
    ; Fetch Cooked Food
    If result == none
        result = fetchFromListParty(_Seed_SmallGameCooked, false)
    EndIf
    If result == none
        result = fetchFromListParty(_Seed_FishCooked, false)
    EndIf
    If result == none
        result = fetchFromListParty( _Seed_SeafoodCooked, false)
    EndIf
    If result == none
        result = fetchFromListParty(_Seed_MeatCooked, false)
    EndIf
    If result == none
        result = fetchFromListParty(_Seed_Vegetables, false)
    EndIf
    If result == none
        result = fetchFromListParty(_Seed_Fruit, false)
    EndIf
    If result == none
        result = fetchFromListParty(_Seed_Cheese, false)
    EndIf
    If result == none
        result = fetchFromListParty(_Seed_Bread, false)
    EndIf
    If result == none
        result = fetchFromListParty(_Seed_CheeseBowls, false)
    EndIf
    If result == none
        result = fetchFromListParty(_Seed_Pastries, false)
    EndIf
    If result == none
        result = fetchFromListParty(_Seed_Treats, false)
    EndIf
    If result == none
        result = fetchFromListParty(_Seed_Stews, false)
    EndIf
    If result == none
        result = fetchFromListParty(_Seed_Preserved, true)
    EndIf
    
    unlockContainer()
    return result
EndFunction

Form Function fetchDrinkParty(bool drinkAlcohol)
    if !lockContainer()
        return _Seed_ProvisionsLockedToken
    endif
    SeedDebug(0, "[ConsumeManager] fetchDrink.")
    ;Find and drink beverage
    Form result = none
    result =  fetchFromListParty(_Seed_DrinkNonAlcoholic, none)
    ;endIf
    If  result == none
        result = fetchFromListParty(_Seed_DrinkMilk, none)
    EndIf
    if drinkAlcohol
        If  result == none
            result = fetchFromListParty(_Seed_DrinkAlcoholicAle, none)
        EndIf
        If result == none
            result = fetchFromListParty(_Seed_DrinkAlcoholicWine, none)
        EndIf
        If result == none
            result = fetchFromListParty(_Seed_DrinkAlcoholicSpirit, none)
        EndIf
     If result == none
            result = fetchFromListParty(_Seed_Stews, none)
        EndIf
    endif
    unlockContainer()
    return result
EndFunction

Form Function fetchFromListParty(FormList myFormList, bool includePreserved = true)
    Int i = 0
    Int ListSize = myFormList.GetSize() as Int
        While i <= ListSize
            Form CurrentItem = myFormList.GetAt(i)
            If CurrentItem && _Seed_ProvisionsContainerRef.GetItemCount(CurrentItem) > 0
                If (getDiseaseChance(CurrentItem, PlayerRef) <= 0 && (includePreserved || _Seed_Preserved.Find(currentItem) == -1))
					if _Seed_Setting_FollowersConsumeFood.getValueInt() == 2 || (currentItem.hasKeyword(VendorItemFoodMultiPart) && GetFoodDatastoreHandler().GetMultiPartFoodResult_Array(currentItem as potion) == none)
						Actor Target = getRandomFollower()
						if target 
							_Seed_ProvisionsContainerRef.RemoveItem(currentItem, 1, true, Target)
							Target.EquipItem(currentItem, false, true)
						else
							_Seed_ProvisionsContainerRef.RemoveItem(currentItem, 1, true)
						endif
					else					
						_Seed_ProvisionsContainerRef.RemoveItem(currentItem, 1, true)
					endif
                    return CurrentItem
                EndIf
            EndIf
            i += 1
        EndWhile
    Return none
EndFunction

Actor function getRandomFollower()
	actor result = none
	int i = 10
	while i > 0
		i = i - 1
		result = GetTrackedFollower(RandomInt(1, 3))
		if result
			i = 0
		endif
	endwhile
	if(!result)
		result = GetTrackedFollower(1)	
	endif
	if(!result)
		result = GetTrackedFollower(2)	
	endif
	if(!result)
		result = GetTrackedFollower(3)	
	endif
	
	return result
endFunction

Function StopSystem()	
	PartyAutoEating = false
	PartyAutoDrinking = false
	PartyAutoFeeding = false
	;parent.stopSystem()
EndFunction

