scriptname _Seed_FollowerNeedsSystem extends _Seed_BaseSystem

import _SeedInternal
import SeedUtil
import CampUtil

_Seed_HungerSystem_Follower1 property _Seed_HungerSystemQuest_Follower1 auto	;TODO: Add this
_Seed_HungerSystem_Follower2 property _Seed_HungerSystemQuest_Follower2 auto	;TODO: Add this
_Seed_HungerSystem_Follower3 property _Seed_HungerSystemQuest_Follower3 auto	;TODO: Add this
_Seed_ThirstSystem_Follower1 property _Seed_ThirstSystemQuest_Follower1 auto	;TODO: Add this
_Seed_ThirstSystem_Follower2 property _Seed_ThirstSystemQuest_Follower2 auto	;TODO: Add this
_Seed_ThirstSystem_Follower3 property _Seed_ThirstSystemQuest_Follower3 auto	;TODO: Add this

Keyword property VendorItemFood auto
Keyword property VendorItemFoodRaw auto
GlobalVariable property _Seed_Setting_DiminishingFoodReturns auto
GlobalVariable property _Seed_RestoreHungerMinorAmount auto
GlobalVariable property _Seed_RestoreHungerMajorAmount auto
GlobalVariable property _Seed_RestoreHungerSuperiorAmount auto
GlobalVariable property _Seed_RestoreHungerMassiveAmount auto
GlobalVariable property _Seed_RestoreThirstMajorAmount auto
GlobalVariable property _Seed_Setting_DisplayTutorials auto
GlobalVariable property _Seed_HelpDone_Variety auto
GlobalVariable property _Seed_Setting_SystemEnabled_FollowerNeeds auto

GlobalVariable property _Seed_SaltIncreaseThirstAmount auto
FormList property _Seed_Salted auto

FormList property _Seed_Food_RestoreHungerMinor auto
FormList property _Seed_Food_RestoreHungerMajor auto
FormList property _Seed_Food_RestoreHungerSuperior auto
FormList property _Seed_Food_RestoreHungerMassive auto
FormList property _Seed_RecentlyEatenFood auto

FormList property _Seed_DrinkAlcoholicAle auto
FormList property _Seed_DrinkAlcoholicWine auto
FormList property _Seed_DrinkAlcoholicSpirit auto

GlobalVariable property attributeEnabled auto
GlobalVariable property _Seed_Setting_PartyCount auto


function StartSystem()
	SeedDebug(1, "[FollowerNeeds]: Starting.")
;	parent.StartSystem()
	
	
	if _Seed_Setting_SystemEnabled_FollowerNeeds.getValueint() == 3
		startIndividualSystem()
	elseif _Seed_Setting_SystemEnabled_FollowerNeeds.getValueInt() == 2
		StartPartySystem()
	endif

	SeedDebug(1, "[FollowerNeeds]: Started.")
endFunction

function startIndividualSystem()
	if seedUtil.getHungerSystem().isRunning()
		StartHungerSystems()
	endif
	if seedUtil.getThirstSystem().isRunning()
		StartThirstSystems()
	endif
endFunction

function StartPartySystem()
	if seedUtil.getHungerSystem().isRunning()
		getPartyHungerSystem().startSystem()
	endif
	if seedUtil.getThirstSystem().isRunning()
		getPartyThirstSystem().startSystem()
	endif	
endFunction

function stopPartySystem()
	getPartyHungerSystem().stopSystem()
	getPartyThirstSystem().stopSystem()
endFunction

Function StartHungerSystems()
	SeedDebug(1, "[FollowerNeeds]: Starting.")
;	parent.StartSystem()

	
	;Start Needs
	int i = 1
	while i <= 3
		if CampUtil.GetTrackedFollower(i) != none
			SeedDebug(0, "[FollowerNeeds]: Starting Follower " + i)
			getHungerSystem(i).StartSystem()
		endif
		i = i+1
	endWhile
	
	SeedDebug(1, "[FollowerNeeds]: Started.")
endFunction

Function StartThirstSystems()
	SeedDebug(1, "[FollowerNeeds]: Starting.")
;	parent.StartSystem()

	;Start Needs
	int i = 1
	while i <= 3
		if CampUtil.GetTrackedFollower(i) != none
			SeedDebug(0, "[FollowerNeeds]: Starting Follower " + i)
			getThirstSystem(i).StartSystem()
		endif
		i = i+1
	endWhile
	
	SeedDebug(1, "[FollowerNeeds]: Started.")
endFunction





function StopSystem()
	SeedDebug(1, "[FollowerNeeds]: Stopping.")
	;Stop Needs
	StopHungerSystems()
	StopThirstSystems()
	stopPartySystem()
;	parent.StopSystem()
	SeedDebug(1, "[FollowerNeeds]: Stopped.")
endFunction

;TODO: Call this in ConfigHandler
function StopHungerSystems()
	int i = 1
	while i <= 3
		SeedDebug(0, "[FollowerNeeds]: Stopping Follower " + i)
		getHungerSystem(i).StopSystem()
		i = i+1
	endWhile
EndFunction

;TODO: Call this in ConfigHandler
function StopThirstSystems()
	int i = 1
	while i <= 3
		SeedDebug(0, "[FollowerNeeds]: Stopping Follower " + i)
		getThirstSystem(i).StopSystem()
				   
		i = i+1
	endWhile
EndFunction

function Update()
parent.StopSystem()
										  
		   

;/
				 
	int i = 1
	while i <= 3
		bool isVampire = GetMonsterHandler().isVampireRace(getThirstSystem(i).getActor())
		
		; THIRST
		if !seedUtil.getThirstSystem().isRunning() && getThirstSystem(i).IsSystemRunning()
			getThirstSystem(i).StopSystem()
			SeedDebug(0, "[FollowerNeeds]: Stopping Follower thirst system " + i +" on update - thirst system disabled.")
		elseif !getThirstSystem(i).hasActor() && getThirstSystem(i).IsSystemRunning()
			SeedDebug(0, "[FollowerNeeds]: Stopping Follower thirst system " + i +" on update - no follower.")
			getThirstSystem(i).StopSystem()
		elseIf getThirstSystem(i).IsSystemRunning() && isVampire
			getThirstSystem(i).StopSystem()
			SeedDebug(0, "[FollowerNeeds]: Stopping Follower thirst system " + i +" on update - follower is vampire.")
		elseif getThirstSystem(i).hasActor() && !getThirstSystem(i).IsSystemRunning() && seedUtil.getThirstSystem().isRunning() && isVampire == false
			SeedDebug(0, "[FollowerNeeds]: Starting Follower thirst system " + i +" on update.")
			getThirstSystem(i).StartSystem()			
		endIf
		
		; HUNGER
		if !seedUtil.getHungerSystem().isRunning() && getHungerSystem(i).IsSystemRunning()
			getHungerSystem(i).StopSystem()
			SeedDebug(0, "[FollowerNeeds]: Stopping Follower hunger system " + i +" on update - hunger system disabled.")
		elseif !getHungerSystem(i).hasActor() && getHungerSystem(i).IsSystemRunning()
			SeedDebug(0, "[FollowerNeeds]: Stopping Follower hunger system " + i +" on update - no follower.")
			getHungerSystem(i).StopSystem()
		elseIf isVampire && getHungerSystem(i).IsSystemRunning()
			getHungerSystem(i).StopSystem()
			SeedDebug(0, "[FollowerNeeds]: Stopping Follower hunger system " + i +" on update - follower is vampire.")	
		elseif getHungerSystem(i).hasActor() && !getHungerSystem(i).IsSystemRunning() && seedUtil.getHungerSystem().isRunning() && isVampire == false
			SeedDebug(0, "[FollowerNeeds]: Starting Follower hunger system " + i +" on update.")
			getHungerSystem(i).StartSystem()
		endIf
		
		i = i+1
	endWhile
/;
endFunction


_Seed_HungerSystem function getHungerSystem(int aiIndex)
	if aiIndex == 1
		return _Seed_HungerSystemQuest_Follower1
	elseif aiIndex == 2
		return _Seed_HungerSystemQuest_Follower2
	elseif aiIndex == 3
		return _Seed_HungerSystemQuest_Follower3
	else
		return None
	endif
endFunction


int function getHungerLevel(int aiIndex)
	if aiIndex == 1
		return _Seed_HungerSystemQuest_Follower1.attributeLevelGlobal.getValueInt()
	elseif aiIndex == 2
		return _Seed_HungerSystemQuest_Follower2.attributeLevelGlobal.getValueInt()
	elseif aiIndex == 3
		return _Seed_HungerSystemQuest_Follower3.attributeLevelGlobal.getValueInt()
	else
		return -1
	endif
endFunction

_Seed_ThirstSystem_Follower function getThirstSystem(int aiIndex)
	if aiIndex == 1
		return _Seed_ThirstSystemQuest_Follower1
	elseif aiIndex == 2
		return _Seed_ThirstSystemQuest_Follower2
	elseif aiIndex == 3
		return _Seed_ThirstSystemQuest_Follower3
	else
		return None
	endif
endFunction


int function getThirstLevel(int aiIndex)
	if aiIndex == 1
		return _Seed_ThirstSystemQuest_Follower1.attributeLevelGlobal.getValueInt()
	elseif aiIndex == 2
		return _Seed_ThirstSystemQuest_Follower2.attributeLevelGlobal.getValueInt()
	elseif aiIndex == 3
		return _Seed_ThirstSystemQuest_Follower3.attributeLevelGlobal.getValueInt()
	else
		return -1
	endif
endFunction

function restoreHunger(float afAmount, int aiIndex)
	getHungerSystem(aiIndex).DecreaseAttribute(afAmount)
endFunction

Function restoreThirst (float afAmount, int aiIndex)
	getThirstSystem(aiIndex).DecreaseAttribute(afAmount)
endFunction

Function drinkAlcohol (int type, int aiIndex)
	getThirstSystem(aiIndex).alcoholConsumed(type)
endFunction


Function eatAndDrink(Form akBaseObject, int aiIndex)
    Potion theFood = akBaseObject as Potion
    if theFood && (akBaseObject.HasKeyword(VendorItemFood) || akBaseObject.HasKeyword(VendorItemFoodRaw))
   		SeedDebug(0, "Object WAS food.")
		
   		int foodType = GetFoodType(theFood)
		
		;Restore thirst: Stew, milk or non-alcoholic beverage
   		if (foodType == 15 || foodType == 17 || foodType == 19)
		   	SeedDebug(0, "Restoring Follower " + aiIndex + " thirst - Non-alcoholic.")
			restoreThirst(_Seed_RestoreThirstMajorAmount.GetValue(), aiIndex)
		;Restore thirst: Alcoholic beverage
		elseif (foodType == 18)
		   	SeedDebug(0, "Restoring Follower " + aiIndex + " thirst - Alcoholic.")
			restoreThirst(_Seed_RestoreThirstMajorAmount.GetValue(), aiIndex)
			;Increase Alcohol Level
			if _Seed_DrinkAlcoholicAle.HasForm(akBaseObject)
				drinkAlcohol(1, aiIndex)			
			elseif _Seed_DrinkAlcoholicWine.HasForm(akBaseObject)
				drinkAlcohol(2, aiIndex)
			elseif _Seed_DrinkAlcoholicSpirit.HasForm(akBaseObject)
				drinkAlcohol(3, aiIndex)
			endif
		endif

		; Restore Hunger
		float amountToRestore = GetFoodDatastoreHandler().getFoodRestoreAmount(akBaseObject)
		;TODO: Remove this
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
				
		; Salted Food Increases Thirst
		if _Seed_Salted.HasForm(akBaseObject)
			getThirstSystem(aiIndex).IncreaseAttribute(amountToRestore / 4, aiIndex)
		endif
		
		; Eating food multiple times yields less results  
   		if !(foodType == 15 && amountToRestore < 0)
   			if getHungerSystem(aiIndex).RecentlyEatenFood.HasForm(theFood)
   				SeedDebug(0, "This food was recently eaten.")
   				amountToRestore *= 0.5
   			else
   				SeedDebug(0, "This food was not recently eaten or is soup.")
   				getHungerSystem(aiIndex).RecentlyEatenFood.AddForm(theFood)
   			endif
   		endif

   		SeedDebug(1, "Restoring Follower " + aiIndex + " hunger: " + amountToRestore)
   		restoreHunger(amountToRestore, aiIndex)
    else
    	SeedDebug(0, "Object was not food. Reason: Was Potion " + akBaseObject as Potion + ", HasKeyword(VendorItemFood || VendorItemFoodRaw) " + (akBaseObject.HasKeyword(VendorItemFood) || akBaseObject.HasKeyword(VendorItemFoodRaw)))
    endif
endFunction

Function eatAndDrinkParty(Form akBaseObject)
	if getPartyCount() > 0
		Potion theFood = akBaseObject as Potion
		if theFood && (akBaseObject.HasKeyword(VendorItemFood) || akBaseObject.HasKeyword(VendorItemFoodRaw))
			SeedDebug(0, "Object WAS food.")
			
			int foodType = GetFoodType(theFood)
			
			;Restore thirst: Stew, milk or non-alcoholic beverage
			if (foodType == 15 || foodType == 17 || foodType == 19)
				SeedDebug(0, "Restoring Party  thirst - Non-alcoholic.")
				getPartyThirstSystem().DecreaseAttribute(_Seed_RestoreThirstMajorAmount.GetValue() / getPartyCount())
			;Restore thirst: Alcoholic beverage
			elseif (foodType == 18)
				SeedDebug(0, "Restoring Party thirst - Alcoholic.")
				getPartyThirstSystem().DecreaseAttribute(_Seed_RestoreThirstMajorAmount.GetValue() / getPartyCount())
				;Increase Alcohol Level
				if _Seed_DrinkAlcoholicAle.HasForm(akBaseObject)
					getPartyThirstSystem().alcoholConsumed(1)				
				elseif _Seed_DrinkAlcoholicWine.HasForm(akBaseObject)
					getPartyThirstSystem().alcoholConsumed(2)				
				elseif _Seed_DrinkAlcoholicSpirit.HasForm(akBaseObject)
					getPartyThirstSystem().alcoholConsumed(3)
				endif
			endif
	
			; Restore Hunger
			float amountToRestore = GetFoodDatastoreHandler().getFoodRestoreAmount(akBaseObject)
			;TODO: Remve this
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
					
			; Salted Food Increases Thirst
			if _Seed_Salted.HasForm(akBaseObject)
				getPartyThirstSystem().IncreaseAttribute(amountToRestore / 4)
			endif
			
			; Eating food multiple times yields less results  
			;/
			if !(foodType == 15 && amountToRestore < 0)
				if getHungerSystem(aiIndex).RecentlyEatenFood.HasForm(theFood)
					SeedDebug(0, "This food was recently eaten.")
					amountToRestore *= 0.5
				else
					SeedDebug(0, "This food was not recently eaten or is soup.")
					getPartyHungerSystem.RecentlyEatenFood.AddForm(theFood)
				endif
			endif
			/;
	
			SeedDebug(1, "Restoring Party hunger: " + amountToRestore)
			getPartyHungerSystem().DecreaseAttribute(amountToRestore / getPartyCount())
		else
			SeedDebug(0, "Object was not food. Reason: Was Potion " + akBaseObject as Potion + ", HasKeyword(VendorItemFood || VendorItemFoodRaw) " + (akBaseObject.HasKeyword(VendorItemFood) || akBaseObject.HasKeyword(VendorItemFoodRaw)))
		endif
	endif
endFunction


function unSuspendNeeds(int followerIndex, Actor akActor)
	If _Seed_Setting_SystemEnabled_FollowerNeeds.getValueInt() == 3
		If followerIndex > 3
			return
		endif
        if seedUtil.getHungerSystem().isRunning()
            GetFollowerSystem().getHungerSystem(followerIndex).StartSystem()
        endif
        if seedUtil.getThirstSystem().isRunning()
            GetFollowerSystem().getThirstSystem(followerIndex).StartSystem()
        endif
    ;/
	elseIf _Seed_Setting_SystemEnabled_FollowerNeeds.getValueInt() == 2
        if seedUtil.getHungerSystem().isRunning()
			GetPartyHungerSystem().applyNeedsToFollower(followerIndex)
		endif
	/;
    endif
endFunction

function SuspendNeeds(int followerIndex, Actor akActor)
    If _Seed_Setting_SystemEnabled_FollowerNeeds.getValueInt() == 3
		If followerIndex > 3
			return
		endif
		getHungerSystem(followerIndex).StopSystem()
        getThirstSystem(followerIndex).StopSystem()
    ;/
	elseIf _Seed_Setting_SystemEnabled_FollowerNeeds.getValueInt() == 2
		GetPartyHungerSystem().changeAttributeSpellForAll()
		GetPartyThirstSystem().changeAttributeSpellForAll()
	/;
	endif
endFunction


int function getPartyCount()
	int override = _Seed_Setting_PartyCount.getValue() as int
	if(override != 0)
		return override
	else
		return GetTrackedFollowerCount()
	endif
endFunction
