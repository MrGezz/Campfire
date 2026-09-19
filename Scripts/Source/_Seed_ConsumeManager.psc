Scriptname _Seed_ConsumeManager extends Quest  
;/
REFERENCED IN:
_Seed_ConsumeManagerQuest
/;
import Utility
import SeedUtil
import CampUtil
import _SeedInternal

GlobalVariable property _Seed_Setting_DiminishingFoodReturns auto
GlobalVariable property _Seed_Setting_AutoConsume auto
GlobalVariable property _Seed_Setting_AnimateFollowers auto
GlobalVariable property _Seed_Setting_AnimatePlayer auto
GlobalVariable property _Seed_Setting_AnimatePlayer_FirstPerson auto
GlobalVariable property _Seed_Setting_NeedsSFX auto
GlobalVariable property _Seed_Setting_FoodPortioning auto

GlobalVariable property _Seed_Setting_Notifications auto
GlobalVariable property _Seed_Setting_Notifications_Followers auto
   											    
   												 
GlobalVariable property _Seed_Setting_VampireBehavior auto
GlobalVariable property _Seed_Setting_FollowersConsumeFood auto
GlobalVariable property _Seed_SettingPlayerIsLich auto

Idle Property IdlePickup_Ground Auto
Idle Property IdleStop_Loose Auto
Idle Property ChairEatingStart Auto
Idle Property idleEatingStandingStart Auto
Idle Property ChairDrinkingStart Auto
Idle Property idleDrinkingStandingStart Auto

;FOOD LISTS
FormList property _Seed_SmallGameRaw auto
FormList property _Seed_MeatRaw auto
FormList property _Seed_FishRaw auto
FormList property _Seed_SeafoodRaw auto
FormList property _Seed_SmallGameCooked auto
FormList property _Seed_FishCooked auto
FormList property _Seed_SeafoodCooked auto
FormList property _Seed_MeatCooked auto
FormList property _Seed_Vegetables auto
FormList property _Seed_Fruit auto
FormList property _Seed_Cheese auto
FormList property _Seed_Bread auto
FormList property _Seed_CheeseBowls auto
FormList property _Seed_Pastries auto
FormList property _Seed_Treats auto
FormList property _Seed_Stews auto
FormList property _Seed_Preserved auto

FormList property _Seed_AutoEatenPlayer auto
FormList property _Seed_AutoDrankPlayer auto
ObjectReference property _Seed_ProvisionsContainerRef Auto

FormList property _Seed_DrinkNonAlcoholic auto
FormList property _Seed_DrinkAlcoholic auto
FormList property _Seed_DrinkWater auto
FormList property _Seed_DrinkMilk auto
FormList property _Seed_DrinkAlcoholicAle auto
FormList property _Seed_DrinkAlcoholicWine auto
FormList property _Seed_DrinkAlcoholicSpirit auto

FormList property _Seed_PortionsToProvisionsList auto
FormList property _Seed_BloodPotions auto

Potion Property _Seed_WaterSkin3Clean Auto
Potion Property FoodChicken Auto
Potion Property _Seed_ProvisionsLockedToken Auto

actor property PlayerRef auto
float property waitTime = 1.0 auto hidden
int property unlockAttempts = 0 auto hidden

GlobalVariable property _Seed_ProvisionContainerLocked auto
GlobalVariable property _Seed_ForceAddFoodToProvisions_CACO auto

Message property _Seed_ConsumeNoDrinkMsg auto
Message property _Seed_ConsumeNoFoodMsg auto


bool property isUpdating = false auto hidden
bool property finishingUpdate = false auto hidden

;Player Eating and Drinking Checks
bool property playerAutoEating = false auto hidden
bool property playerAutoDrinking = false auto hidden
bool property playerEating = false auto hidden
bool property playerDrinking = false auto hidden

;Follower Eating and Drinking Checks
bool property Follower1AutoEating = false auto hidden
bool property Follower2AutoEating = false auto hidden
bool property Follower3AutoEating = false auto hidden
bool property Follower1Autodrinking = false auto hidden
bool property Follower2Autodrinking = false auto hidden
bool property Follower3Autodrinking = false auto hidden

bool property hungerSoundQueued = false auto hidden
bool property thirstSoundQueued = false auto hidden
bool property fatigueSoundQueued = false auto hidden

bool property EatAnimationQueued = false auto hidden
bool property DrinkAnimationQueued = false auto hidden

bool property enqueueEatAnimationFollower1 = false auto hidden
bool property enqueueEatAnimationFollower2 = false auto hidden
bool property enqueueEatAnimationFollower3 = false auto hidden
bool property enqueueDrinkAnimationFollower1 = false auto hidden
bool property enqueueDrinkAnimationFollower2 = false auto hidden
bool property enqueueDrinkAnimationFollower3 = false auto hidden

bool property PlayerAutoFeeding = false auto hidden
bool property PlayerFeeding = false auto hidden
bool property Follower1AutoFeeding = false auto hidden
bool property Follower2AutoFeeding = false auto hidden
bool property Follower3AutoFeeding = false auto hidden
Potion property DLC1BloodPotion auto	;DLC1BloodPotion "Potion of Blood" [ALCH:02018EF3] 
Potion property _Seed_IceWraithTeeth auto
MiscObject property _Seed_PerishedFood auto

; Display Message Checks
Message property hungerMessage = none auto hidden
Message property ThirstMessage = none auto hidden
Message property AlcoholMessage = none auto hidden


String property follower1HungerMessage = "" auto hidden
String property follower1ThirstMessage = "" auto hidden
String property follower2HungerMessage = "" auto hidden
String property follower2ThirstMessage = "" auto hidden
String property follower3HungerMessage = "" auto hidden
String property follower3ThirstMessage = "" auto hidden

;SOUNDS
Sound property hungerSound = none auto hidden
Sound property ThirstSound = none auto hidden
Sound property FatigueSound = none auto hidden

FormList property _Seed_ForceFoodPortioning auto

keyword property VendorItemFoodMultiPart auto

event onUpdate()
    startAutoConsuming()
endEvent
; Player Hanger Message
Function EnqueuePlayerHungerMessage(Message msg)
    hungerMessage = msg
    startUpdating()
endFunction
; Player Thirst Message
Function EnqueuePlayerThirstMessage(Message msg)
    ThirstMessage = msg
    startUpdating()
endFunction

; Player Alcohol Message
Function EnqueuePlayerAlcoholMessage(Message msg)
    AlcoholMessage = msg
    startUpdating()
endFunction



; Player Hunger Sound
Function EnqueuePlayerHungerSound(sound snd)
    if snd || hungerSoundQueued
		SeedDebug(0, "[ConsumeManager] Enqueuing Hunger Sound")
		hungerSoundQueued = true
		hungerSound = snd
		startUpdating()
	endif
endFunction
; Player Thirst Sound
Function EnqueuePlayerThirstSound(sound snd)
    if snd || thirstSoundQueued
		SeedDebug(0, "[ConsumeManager] Enqueuing Thirst Sound")
		thirstSoundQueued = true
		ThirstSound = snd
		startUpdating()
	endif
endFunction
; Player Fatigue Sound
Function EnqueuePlayerFatigueSound(sound snd)
	if snd || fatigueSoundQueued
		SeedDebug(0, "[ConsumeManager] Enqueuing Fatigue Sound")
		fatigueSoundQueued = true
		FatigueSound = snd
		startUpdating()
	endif
endFunction

Function EnqueueFollowerHungerMessage(String msg, int followerIndex)
    if followerIndex == 1
   	 follower1HungerMessage = msg
    elseif followerIndex == 2
   	 follower2HungerMessage = msg
    elseif followerIndex == 3
   	 follower3HungerMessage = msg
    endif
    startUpdating()
endFunction
Function EnqueueFollowerThirstMessage(String msg, int followerIndex)
    if followerIndex == 1
   	 follower1ThirstMessage = msg
    elseif followerIndex == 2
   	 follower2ThirstMessage = msg
    elseif followerIndex == 3
   	 follower3ThirstMessage = msg
    endif
    startUpdating()
endFunction

;ANIMATIONS
function enqueuePlayerEatAnimation()
	if !PlayerEating && !PlayerAutoEating && !PlayerDrinking && !PlayerAutoDrinking
		GetAnimationHandler().eatAnimation(0)
	else
		EatAnimationQueued = true
	endif
endFunction

function enqueuePlayerDrinkAnimation()
	if !PlayerEating && !PlayerAutoEating && !PlayerDrinking && !PlayerAutoDrinking
		GetAnimationHandler().DrinkAnimation(0)
	else
		DrinkAnimationQueued = true
	endif
endFunction

function PlayerEatSpell()
	if getHungerSystem().isRunning()
		if(_Seed_SettingPlayerIsLich.getValue() == 2)
			return
		endif
		SeedDebug(0, "[ConsumeManager] Starting player eat spell.")
		if getMonsterHandler().isVampireRace(PlayerRef) && GetMonsterHandler().getVampireSettings(false, true, true)			
			PlayerFeeding = true
			PlayerEating = false
		else
			PlayerEating = true
			PlayerFeeding = false
			_Seed_ForceAddFoodToProvisions_CACO.setValue(2)
		endif
		startUpdating()
	endif
endFunction

function PlayerDrinkSpell()
	if(_Seed_SettingPlayerIsLich.getValue() == 2)
		return
	endif
    if getThirstSystem().isRunning()
		if getMonsterHandler().isVampireRace(PlayerRef) && GetMonsterHandler().getVampireSettings(false, true, true)
			PlayerFeeding = true
			PlayerDrinking = false
		else
			PlayerDrinking = true
			PlayerFeeding = false
			_Seed_ForceAddFoodToProvisions_CACO.setValue(2)
		endif
		startUpdating()
	endif
endFunction

function Player_AutoEat(int limit = 0)
	if(_Seed_SettingPlayerIsLich.getValue() == 2)
		return
	endif    
	if getHungerSystem().isRunning() && _Seed_Setting_AutoConsume.GetValue() == 2 && GetPlayerHungerLevel() > limit
	; SpoilFood()
		if getMonsterHandler().isVampireRace(PlayerRef) && GetMonsterHandler().getVampireSettings(false, true, true)
			PlayerAutoFeeding = true
			PlayerAutoEating = false
		else
			PlayerAutoEating = true
			PlayerAutoFeeding = false
		endif
   	startUpdating()
    endif
endFunction

function Player_AutoDrink(int limit = 0)
	if(_Seed_SettingPlayerIsLich.getValue() == 2)
		return
	endif
    if getThirstSystem().isRunning() && _Seed_Setting_AutoConsume.GetValue() == 2  && GetPlayerThirstLevel() > limit
		if getMonsterHandler().isVampireRace(PlayerRef) && GetMonsterHandler().getVampireSettings(false, true, true)
			PlayerAutoFeeding = true
			PlayerAutoDrinking = false
		else
			PlayerAutoDrinking = true
			PlayerAutoFeeding = false
		endif
   	 startUpdating()
    endif
endFunction

function NPC_AutoEat(int aiIndex, int limit = 0)
    if GetFollowerSystem().GetHungerSystem(aiIndex).IsSystemRunning() && GetFollowerSystem().GetHungerSystem(aiIndex).attributeLevelGlobal.getValueInt() > limit	
		if getMonsterHandler().isVampireRace(GetTrackedFollower(aiIndex)) && GetMonsterHandler().getVampireSettingsBasic(false, true, true)
			if aiIndex == 1
				Follower1AutoFeeding = true
				Follower1AutoEating = false
			elseif aiIndex == 2
				Follower2AutoFeeding = true
				Follower2AutoEating = false
			elseif aiIndex == 3
				Follower3AutoFeeding = true;
				Follower3AutoEating = false
			endif
		else
			if aiIndex == 1
				Follower1AutoEating = true
				Follower1AutoFeeding = false
			elseif aiIndex == 2
				Follower2AutoEating = true
				Follower2AutoFeeding = false
			elseif aiIndex == 3
				Follower3AutoEating = true
				Follower3AutoFeeding = false
			endif
		endif
		startUpdating()
    endif
endFunction

function NPC_AutoDrink(int aiIndex, int limit = 0)
    if GetFollowerSystem().GetThirstSystem(aiIndex).IsSystemRunning() && GetFollowerSystem().GetThirstSystem(aiIndex).attributeLevelGlobal.getValueInt() > limit
		if getMonsterHandler().isVampireRace(GetTrackedFollower(aiIndex)) && GetMonsterHandler().getVampireSettingsBasic(false, true, true)
			if aiIndex == 1
				Follower1AutoFeeding = true
				Follower1AutoDrinking = false
			elseif aiIndex == 2
				Follower2AutoFeeding = true
				Follower2AutoDrinking = false
			elseif aiIndex == 3
				Follower3AutoFeeding = true;
				Follower3AutoDrinking = false
			endif
		else
			if aiIndex == 1
				Follower1AutoDrinking = true
				Follower1AutoFeeding = false
			elseif aiIndex == 2
				Follower2AutoDrinking = true
				Follower2AutoFeeding = false
			elseif aiIndex == 3
				Follower3AutoDrinking = true
				Follower3AutoFeeding = false
			endif
		endif
		startUpdating()
	endif
endFunction

function startUpdating()
	if(!isUpdating)
		isUpdating = true
		;startAutoConsuming()
		If PlayerEating || PlayerDrinking || PlayerFeeding
			registerForSingleUpdate(0.1)
		else
			registerForSingleUpdate(1.0)
		endif		
    endif
endFunction

function startAutoConsuming()
	;Override
endFunction
;DEPRECIATED - SEE _Seed_ConsumeManagerPlayer AND _Seed_ConsumeManagerFollower
;/
function startAutoConsuming()

	; Player Eat and Drink Spells
    PlayerEating()
    PlayerDrinking()
	
	;Auto-Eating
	Player_AutoEating()
    NPC_AutoEating(1, Follower1AutoEating)
    NPC_AutoEating(2, Follower2AutoEating)
    NPC_AutoEating(3, Follower3AutoEating)

    
    ;Auto-Drinking
    Player_AutoDrinking()
    NPC_AutoDrinking(1, Follower1AutoDrinking)
    NPC_AutoDrinking(2, Follower2AutoDrinking)
    NPC_AutoDrinking(3, Follower3AutoDrinking)
	

    
    if playerAutoEating || playerAutoDrinking || playerEating || playerDrinking; || ((hungerSoundQueued || thirstSoundQueued || fatigueSoundQueued) && _Seed_Setting_NeedsSFX.getValue() != 2) || EatAnimationQueued || DrinkAnimationQueued
		registerForSingleUpdate(1.0)
		SeedDebug(0, "[ConsumeManager] still auto-consuming...")
    else
		finishingUpdate = true
		isUpdating = false
		SeedDebug(0, "[ConsumeManager] Stopping auto-consuming")
   	
		; PLAY SOUNDS
		If _Seed_Setting_NeedsSFX.getValue() == 2
			PlaySounds()
		endif
		
		; Show Player Messages & Animations
		if hungerMessage != none
			hungerMessage.show()
			hungerMessage = none
			SeedDebug(0, "[ConsumeManager] END: Enqueuing Hunger Message")
		endif
		if ThirstMessage != none
			ThirstMessage.show()
			ThirstMessage = none
			SeedDebug(0, "[ConsumeManager] END: Enqueuing Thirst Message")
		endif
		if AlcoholMessage != none
			AlcoholMessage.show()
			AlcoholMessage = none    
		Endif
		
		if EatAnimationQueued
			SeedDebug(0, "[ConsumeManager] END: Playing Eat Animation")
			GetAnimationHandler().eatAnimation(0)
		elseif DrinkAnimationQueued
			SeedDebug(0, "[ConsumeManager] END: Playing Drink Animation")
			GetAnimationHandler().DrinkAnimation(0)
		endif
		EatAnimationQueued = false
		DrinkAnimationQueued = false
		finishingUpdate = false
    endif
endFunction
/;
Function PlaySounds()
	If hungerSoundQueued
		if HungerSound
			 SeedDebug(0, "[ConsumeManager] playing hunger sound.")
			HungerSound.PlayAndWait(playerRef)
		endif
		HungerSound = none
		hungerSoundQueued = false
		 SeedDebug(0, "[ConsumeManager] unqueing hunger sound..")
	endif
	If thirstSoundQueued
		if ThirstSound
			SeedDebug(0, "[ConsumeManager] playing thirst sound.")
			ThirstSound.PlayAndWait(playerRef)
		endif
		ThirstSound = none
		thirstSoundQueued = false
		 SeedDebug(0, "[ConsumeManager] unqueing thirst sound.")
	endif
	If fatigueSoundQueued
		if FatigueSound
			SeedDebug(0, "[ConsumeManager] playing fatigue sound.")
			FatigueSound.PlayAndWait(playerRef)
		endif
		FatigueSound = none
		fatigueSoundQueued = false
		SeedDebug(0, "[ConsumeManager] unqueing fatigue sound.")
	endif
endFunction

Form Function fetchBloodPotion(Actor Target)    
    if !lockContainer()
   	 return _Seed_ProvisionsLockedToken
    endif
    form result = none
	potion thePotion = none
	Int iIndex = _Seed_BloodPotions.GetSize() ; Indices are offset by 1 relative to size
	While iIndex
		iIndex -= 1
		thePotion = _Seed_BloodPotions.GetAt(iIndex) as potion
		If thePotion && _Seed_ProvisionsContainerRef.GetItemCount(thePotion) > 0
			_Seed_ProvisionsContainerRef.RemoveItem(thePotion, 1, true)
			result = thePotion
			iIndex = 0
		endif
	EndWhile
    unlockContainer()
    return result
EndFunction

function Player_AutoFeeding()
    if playerAutoFeeding
		if _Seed_Setting_AutoConsume.GetValue() == 2
			potion theFood = fetchBloodPotion(PlayerRef) as potion
			if theFood != _Seed_ProvisionsLockedToken
				if theFood != none										
					;Eat food
					PlayerRef.EquipItem(theFood, false, true)
					SeedDebug(0, "[ConsumeManager] Fetched Player Food: " + theFood)
					;Show Message
					if getSKSELoaded()
						Debug.Notification(GetTranslationHandler().You + GetTranslationHandler().DrankSome + theFood.getName())
					endif
				else
					_Seed_ConsumeNoDrinkMsg.Show()
				endif
				playerAutoFeeding = false
			endif
		else
			playerAutoFeeding = false
		endif
    endif    
endFunction

function Player_Feeding()
    if playerFeeding
		potion theFood = fetchBloodPotion(PlayerRef) as potion		
		if theFood != _Seed_ProvisionsLockedToken
			if theFood != none										
				;Eat food
				PlayerRef.EquipItem(theFood, false, true)
				SeedDebug(0, "[ConsumeManager] Fetched Player Food: " + theFood)
				;Show Message
				if getSKSELoaded()
					Debug.Notification(GetTranslationHandler().You + GetTranslationHandler().DrankSome + theFood.getName())
				endif
			else
				_Seed_ConsumeNoDrinkMsg.Show()
			endif
			playerFeeding = false
		endif
    endif    
endFunction

function NPC_AutoFeeding(int aiIndex, bool FollowerAutoEating)
    _Seed_hungerSystem hungerSystem = GetFollowerSystem().GetHungerSystem(aiIndex)
	Actor target = hungerSystem.getActor()
	if FollowerAutoEating				
		form theFood = fetchBloodPotion(Target)
		if theFood != _Seed_ProvisionsLockedToken
			if theFood != none
				Target.RemoveItem(theFood)
				GetFollowerSystem().restoreHunger(120.0, aiIndex)
				GetFollowerSystem().restoreThirst(120.0, aiIndex)
				
				;Show Message
				_Seed_Setting_Notifications_Followers.GetValueInt() == 2
				SeedDebug(0, "[ConsumeManager] showing NPC feeding message")
				string followerName
				if GetSKSELoaded()
					followerName = target.GetActorBase().GetName()
					Debug.Notification(followerName + GetTranslationHandler().DrankSome + theFood.getName())
				endIf
				
			endif
			; Stop Feeding
			if aiIndex == 1
				Follower1AutoFeeding = false;
			elseif aiIndex == 2
				Follower1AutoFeeding = false;
			elseif aiIndex == 3
				Follower1AutoFeeding = false;
			endif
		endif
	endif
endFunction

int[] function getRandomList(int limit)
	; Step 1
	int N = 10;
	int[] array = CreateIntArray(limit)
	
	; Step 2
	int i = limit
	While i > 0
			i -= 1
		array[i] = i				
	EndWhile
	
	; Step 3
	i = limit
	int min = 0
	int max = limit - 1
	While i > 0
		i -= 1
		int randIndex = Utility.RandomInt(min, max)
		int tmp = array[i]
		array[i] = array[randIndex]
		array[randIndex] = tmp
	EndWhile
	return array
endFunction

bool function isDrink(form currentItem, bool drinkAlcohol = true)
	return _Seed_DrinkNonAlcoholic.hasForm(currentItem) || _Seed_DrinkMilk.hasForm(currentItem) || (drinkAlcohol && _Seed_DrinkAlcoholic.hasForm(currentItem))
endFunction

bool function isEdible(form currentItem)
	return !_Seed_BloodPotions.HasForm(currentItem) && currentItem != _Seed_IceWraithTeeth && currentItem != _Seed_PerishedFood
endFunction

form Function fetchFood_SKSE(Actor Target, FormList recentlyEatenFood)
	if !lockContainer()
		return _Seed_ProvisionsLockedToken
	endif
	if _Seed_Setting_DiminishingFoodReturns.getValueInt() != 2
		recentlyEatenFood = none
	endif
	Int iFormIndex = _Seed_ProvisionsContainerRef.GetNumItems()
	int[] randomList = getRandomList(iFormIndex)
	While iFormIndex > 0
		iFormIndex -= 1
		Form currentItem = _Seed_ProvisionsContainerRef.GetNthForm(randomList[iFormIndex])
		If isEdible(currentItem) && !isDrink(currentItem) && getDiseaseChance(currentItem, Target) <= 0 && !(recentlyEatenFood && recentlyEatenFood.HasForm(currentItem))
			unlockContainer()
			_Seed_ProvisionsContainerRef.RemoveItem(currentItem, 1, true, Target)
			return currentItem
		EndIf
	EndWhile
	unlockContainer()
    return none
EndFunction

form Function fetchDrink_SKSE(Actor Target, bool drinkAlcohol)
    if !lockContainer()
		return _Seed_ProvisionsLockedToken
    endif
	Int iFormIndex = _Seed_ProvisionsContainerRef.GetNumItems()
	int[] randomList = getRandomList(iFormIndex)
	While iFormIndex > 0
		iFormIndex -= 1
		Form currentItem = _Seed_ProvisionsContainerRef.GetNthForm(randomList[iFormIndex])
		If isEdible(currentItem) && isDrink(currentItem, drinkAlcohol) && getDiseaseChance(currentItem, Target) <= 0
			unlockContainer()
			_Seed_ProvisionsContainerRef.RemoveItem(currentItem, 1, true, Target)
			return currentItem
		EndIf
	EndWhile
	unlockContainer()
    return none
endFunction

function PlayerEating()
	if PlayerEating
		SeedDebug(0, "[ConsumeManager] Eating food.")
		bool SKSELoaded = GetSKSELoaded()
		potion theFood = _Seed_ProvisionsLockedToken
		if SKSELoaded
			theFood = fetchFood_SKSE(PlayerRef, GethungerSystem().recentlyEatenFood) as potion
		else
			theFood = fetchFood(PlayerRef, GethungerSystem().recentlyEatenFood) as potion
		endif
		; Display message of what was eaten
		if theFood != _Seed_ProvisionsLockedToken
			if theFood != none
				if SKSELoaded
					String foodName = theFood.getName()
					Debug.Notification(GetTranslationHandler().You + GetTranslationHandler().AteSome + foodName + ".")
				endif
				;Add To Provisions Portions List
				if GetFoodDatastoreHandler().GetMultiPartFoodResult_Array(theFood)
					_Seed_PortionsToProvisionsList.AddForm(theFood)
				endif
				
				PlayerRef.EquipItem(theFood, false, true)   	 
				; Display message if failed to find food to eat
			else
				_Seed_ConsumeNoFoodMsg.Show()
			endif
			PlayerEating = false
		endif
	endif
endFunction


Function PlayerDrinking()
    if PlayerDrinking
		bool SKSELoaded = GetSKSELoaded()
		potion theDrink = _Seed_ProvisionsLockedToken
		if SKSELoaded
			theDrink = fetchDrink_SKSE(PlayerRef, true) as potion
		else
			theDrink = fetchDrink(PlayerRef, true) as potion
		endif 
		if theDrink != _Seed_ProvisionsLockedToken
			if theDrink != none
				if SKSELoaded
					String drinkName = theDrink.getName()
					if(_Seed_DrinkWater.find(theDrink) != -1)
						drinkName = GetTranslationHandler().SomeWater
					endif
					Debug.Notification(GetTranslationHandler().You + GetTranslationHandler().DrankSome + drinkName + ".")
				endif
				;Add To Provisions Portions List
				if GetFoodDatastoreHandler().GetMultiPartFoodResult_Array(theDrink)
					_Seed_PortionsToProvisionsList.AddForm(theDrink)
				endif
			 
				PlayerRef.EquipItem(theDrink, false, true)
   			 
			; Display message if failed to find beverage
			else
				_Seed_ConsumeNoDrinkMsg.Show()
			endif
			PlayerDrinking = false
		endif
    endif
endFunction

function Player_AutoEating()
    if playerAutoEating
		if GetPlayerHungerLevel() > 0 && _Seed_Setting_AutoConsume.GetValue() == 2
			SeedDebug(0, "[ConsPartyEatAnimationumeManager] player is hungry.")
			potion theFood = _Seed_ProvisionsLockedToken
			if getSKSELoaded()
				theFood = fetchFood_SKSE(PlayerRef, GethungerSystem().recentlyEatenFood) as potion
			else
				theFood = fetchFood(PlayerRef, GethungerSystem().recentlyEatenFood) as potion
			endif
			if theFood != _Seed_ProvisionsLockedToken
				if theFood != none
					if _Seed_AutoEatenPlayer.Find(theFood) == -1
						_Seed_AutoEatenPlayer.addForm(theFood)
					endif
					;Add To Provisions List
					if GetFoodDatastoreHandler().GetMultiPartFoodResult_Array(theFood)
						_Seed_PortionsToProvisionsList.AddForm(theFood)
					endif
					
					;Eat food
					PlayerRef.EquipItem(theFood, false, true)
					SeedDebug(0, "[ConsumeManager] Fetched Player Food: " + theFood)
				else
					playerAutoEating = false
					SeedDebug(0, "[ConsumeManager] Finished Player Auto-eating: not satisfied")
				endif
			endif
		else
			SeedDebug(0, "[ConsumeManager] Finished Player Auto-eating: Satisfied")
			playerAutoEating = false
		endif
    endif
    
    ;Show Message
    if !playerAutoEating && _Seed_AutoEatenPlayer.GetSize() > 0
   	 SeedDebug(0, "[ConsumeManager] showing player eaten message")
   	 String EatenFood = getConsumedMessage(_Seed_AutoEatenPlayer)
   	 if(EatenFood != "")
		Debug.Notification(GetTranslationHandler().You + GetTranslationHandler().AteSome + EatenFood)   	 
	endif    
   	 _Seed_AutoEatenPlayer.Revert()   	 
    endif
    
endFunction

function Player_AutoDrinking()
    if playerAutoDrinking
   	 if GetPlayerThirstLevel() > 0 && _Seed_Setting_AutoConsume.GetValue() == 2
		bool SKSELoaded = GetSKSELoaded()
   		 SeedDebug(0, "[ConsumeManager] player is thirsty.")
   		 bool drinkAlcohol = GetPlayerAlcoholLevel() < 1
   		 SeedDebug(0, "[ConsumeManager] player is Sober: " + drinkAlcohol)
		potion theDrink = _Seed_ProvisionsLockedToken
		if SKSELoaded
			theDrink = fetchDrink_SKSE(PlayerRef, drinkAlcohol) as potion
		else
			theDrink = fetchDrink(PlayerRef, drinkAlcohol) as potion
		endif
		if theDrink != _Seed_ProvisionsLockedToken
   			 if theDrink != none    
   				 if _Seed_AutoDrankPlayer.Find(theDrink) == -1
   					if _Seed_DrinkWater.find(theDrink) == -1
						_Seed_AutoDrankPlayer.addForm(theDrink)
					elseif _Seed_AutoDrankPlayer.Find(_Seed_Waterskin3Clean) == -1
						_Seed_AutoDrankPlayer.addForm(_Seed_Waterskin3Clean)	
   					endIf
   				 endIf
				;Add To Provisions Portions List
				if GetFoodDatastoreHandler().GetMultiPartFoodResult_Array(theDrink)
					_Seed_PortionsToProvisionsList.AddForm(theDrink)
				endif
				 
   				 ;Drink Beverage
   				 PlayerRef.EquipItem(theDrink, false, true)
   				 SeedDebug(0, "[ConsumeManager] Fetched Player drink: " + theDrink)
   			 else
   				 playerAutoDrinking = false
   				 SeedDebug(0, "[ConsumeManager] Finished Player Auto-drinking: Not satisfied")
   			 endIf
   		 endIf
   	 else
   		 SeedDebug(0, "[ConsumeManager] Finished Player Auto-drinking: Not satisfied")
   		 playerAutoDrinking = false
   	 endIf
    endIf
    
    ;Show Message
    if !playerAutoDrinking && _Seed_AutoDrankPlayer.GetSize() > 0
   	 SeedDebug(0, "[ConsumeManager] showing player drank message")
   	 String drankBeverages = getConsumedMessage(_Seed_AutoDrankPlayer)
   	 if(drankBeverages != "")
		 Debug.Notification(GetTranslationHandler().You + GetTranslationHandler().DrankSome + drankBeverages)
   	 endif
   	 ;Revert list for next time
   	 _Seed_AutoDrankPlayer.Revert()   	 
    endif
endFunction


function NPC_AutoEating(int aiIndex, bool FollowerAutoEating)
    _Seed_hungerSystem hungerSystem = GetFollowerSystem().GetHungerSystem(aiIndex)
	Actor target = hungerSystem.getActor()
	bool SKSELoaded = GetSKSELoaded()
	if FollowerAutoEating
		if hungerSystem.attributeLevelGlobal.getValueInt() > 0
			SeedDebug(0, "[ConsumeManager] NPC is hungry : " + hungerSystem.getActor())
			
			form theFood = _Seed_ProvisionsLockedToken
			if SKSELoaded
				theFood = fetchFood_SKSE(Target, hungerSystem.recentlyEatenFood)
			else
				theFood = fetchFood(Target, hungerSystem.recentlyEatenFood)
			endif
			
			if theFood != _Seed_ProvisionsLockedToken
				if theFood != none
					;Eat food
					if hungerSystem.AutoEatenFood.Find(theFood) == -1
						hungerSystem.AutoEatenFood.addForm(theFood)
					endif
					if _Seed_Setting_FollowersConsumeFood.getValueInt() == 2 || (theFood.hasKeyword(VendorItemFoodMultiPart) && GetFoodDatastoreHandler().GetMultiPartFoodResult_Array(theFood as potion) == none)
						Target.EquipItem(theFood, false, true)
					else
						Target.RemoveItem(theFood)
					endif
					processMultiPartFood(theFood as potion)
					hungerSystem.recentlyEatenFood.AddForm(theFood)
					getFollowerSystem().eatAndDrink(theFood, aiIndex)
					
					; Flag to animate
					if aiIndex == 1
						enqueueEatAnimationFollower1 = true;
					elseif aiIndex == 2
						enqueueEatAnimationFollower2 = true;
					elseif aiIndex == 3
						enqueueEatAnimationFollower3 = true;
					endif
					
				else
					if aiIndex == 1
						Follower1AutoEating = false;
					elseif aiIndex == 2
						Follower2AutoEating = false;
					elseif aiIndex == 3
						Follower3AutoEating = false;
					endif
					SeedDebug(0, "[ConsumeManager] Finished NPC " + aiIndex + " Auto-eating: not satisfied")
				endif
			endif
		else
			if aiIndex == 1
				Follower1AutoEating = false;
			elseif aiIndex == 2
				Follower2AutoEating = false;
			elseif aiIndex == 3
				Follower3AutoEating = false;
			endif
			SeedDebug(0, "[ConsumeManager] Finished NPC " + aiIndex + " Auto-eating: satisfied")
		endif
    endif
    
    ;Show Message
    if !FollowerAutoEating && hungerSystem.AutoEatenFood.GetSize() > 0 && _Seed_Setting_Notifications_Followers.GetValueInt() == 2
   	 SeedDebug(0, "[ConsumeManager] showing NPC eaten message")
   	 String EatenFood = getConsumedMessage(hungerSystem.AutoEatenFood)
   	 if(EatenFood != "")
   		 string followerName
   		 if SKSELoaded
   			 followerName = target.GetActorBase().GetName()
   		 else
   			 followerName = getFollowerName(aiIndex)
   		 endIf
   		 Debug.Notification(followerName + GetTranslationHandler().AteSome + EatenFood)
   	 endif    
   	 ;Revert list for next time
	 hungerSystem.AutoEatenFood.Revert()
    endif
endFunction

Function processMultiPartFood(Potion theFood)
	Potion multiPart = GetFoodDatastoreHandler().GetMultiPartFoodResult_Array(theFood)
	if multiPart
		int aiCount  = GetFoodDatastoreHandler().GetMultiPartFoodQuantity_Array(theFood)
		SeedDebug(0, "[_Seed_ConsumeManager] Found Multi-Part food - " + theFood + " -> " + multiPart + " x " + aiCount)
		bool abSilent  = false
		if multiPart == theFood && aiCount == 1
			abSilent  = true
		endif
		SeedDebug(0, "[_Seed_ConsumeManager] Adding Portions to provisions Container")
		_Seed_ProvisionsContainerRef.AddItem(multiPart, aiCount, abSilent)
	else
		SeedDebug(0, "[_Seed_ConsumeManager] Found non-multiPart Food " + theFood)
	endif
endFunction

function NPC_AutoDrinking(int aiIndex, bool FollowerAutoDrinking)
	_Seed_ThirstSystem thirstSystem = GetFollowerSystem().getThirstSystem(aiIndex)
	Actor target = thirstSystem.getActor()
	bool SKSELoaded = getSKSELoaded()
	if FollowerAutoDrinking 
		if thirstSystem.attributeLevelGlobal.getValueInt() > 0
			SeedDebug(0, "[ConsumeManager] NPC is thirsty : " + thirstSystem.getActor())
			bool drinkAlcohol = (thirstSystem as _Seed_ThirstSystem_Follower).isSober()
			
			form theDrink = _Seed_ProvisionsLockedToken
			if SKSELoaded
				theDrink = fetchDrink_SKSE(Target, drinkAlcohol)
			else
				theDrink = fetchDrink(Target, drinkAlcohol)
			endif
			
			if theDrink != _Seed_ProvisionsLockedToken
				if theDrink != none
					;Add item to auto-eaten list
					if thirstSystem.AutoDrank.Find(theDrink) == -1
						if _Seed_DrinkWater.find(theDrink) == -1 
							thirstSystem.AutoDrank.addForm(theDrink)						
						elseif thirstSystem.AutoDrank.Find(_Seed_Waterskin3Clean) == -1
							thirstSystem.AutoDrank.addForm(_Seed_Waterskin3Clean)
						endif
					endif
					
					;Drink Beverage
					if _Seed_Setting_FollowersConsumeFood.getValueInt() == 2 || (theDrink.hasKeyword(VendorItemFoodMultiPart) && GetFoodDatastoreHandler().GetMultiPartFoodResult_Array(theDrink as potion) == none)
						Target.EquipItem(theDrink, false, true)
					else
						Target.RemoveItem(theDrink)
					endif
					
					processMultiPartFood(theDrink as potion)					
					getFollowerSystem().eatAndDrink(theDrink, aiIndex)   

					; Flag to animate
					if aiIndex == 1
						enqueueDrinkAnimationFollower1 = true;
					elseif aiIndex == 2
						enqueueDrinkAnimationFollower2 = true;
					elseif aiIndex == 3
						enqueueDrinkAnimationFollower3 = true;
					endif					
				else
					if aiIndex == 1
						Follower1AutoDrinking = false;
					elseif aiIndex == 2
						Follower1AutoDrinking = false;
					elseif aiIndex == 3
						Follower1AutoDrinking = false;
					endif
					SeedDebug(0, "[ConsumeManager] Finished NPC " + aiIndex + " Auto-drinking: not satisfied")
				endif
			endif
		else
			if aiIndex == 1
				Follower1AutoDrinking = false;
			elseif aiIndex == 2
				Follower1AutoDrinking = false;
			elseif aiIndex == 3
				Follower1AutoDrinking = false;
			endif
			SeedDebug(0, "[ConsumeManager] Finished NPC " + aiIndex + " Auto-drinking: satisfied")
		endif
    endif
    
    ;Show Message
    if !Follower1AutoDrinking && thirstSystem.AutoDrank.GetSize() > 0 && _Seed_Setting_Notifications_Followers.GetValueInt() == 2
   	 SeedDebug(0, "[ConsumeManager] showing NPC eaten message")
   	 String drankItems = getConsumedMessage(thirstSystem.AutoDrank)
   	 if(drankItems != "")
   		 string followerName
   		 if SKSELoaded
   			 followerName = target.GetActorBase().GetName()
   		 else
   			 followerName = getFollowerName(aiIndex)
   		 endIf
   		 Debug.Notification(followerName + GetTranslationHandler().DrankSome + drankItems)
   	 endif    
   	 ;Revert list for next time
   	 thirstSystem.AutoDrank.Revert()   	 
    endif
endFunction

bool function lockContainer()
    if !_Seed_ProvisionContainerLocked.getValue() || unlockAttempts > 10
   	 _Seed_ProvisionContainerLocked.setValue(1)
   	 unlockAttempts = 0
   	 SeedDebug(0, "[ConsumeManager] Locking container")
   	 return true
    endif
    unlockAttempts = unlockAttempts + 1
    SeedDebug(0, "[ConsumeManager] Waiting for container to unlock")
    return false
endFunction

function unlockContainer()
    SeedDebug(0, "[ConsumeManager] Unlocking container")
    _Seed_ProvisionContainerLocked.setValue(0)
endFunction

Form Function fetchFood(Actor Target, FormList recentlyEatenFood)

	if _Seed_Setting_DiminishingFoodReturns.getValueInt() != 2
		recentlyEatenFood = none
	endif
	
    SeedDebug(0, "[ConsumeManager] fetchFood.")
    
    if !lockContainer()
   	 return _Seed_ProvisionsLockedToken
    endif
    
    ;Find and eat food
    form result = none
	
	; If target can eat raw food, fetch raw food	
	if getDiseaseChance(FoodChicken, Target) <= 0
		result =  fetchFromList(Target, _Seed_SmallGameRaw, recentlyEatenFood, false)
		If result == none
			result = fetchFromList(Target, _Seed_SeafoodRaw, recentlyEatenFood, false)
		EndIf
		If result == none
			result = fetchFromList(Target, _Seed_FishRaw, recentlyEatenFood, false)
		EndIf
		If result == none
			result = fetchFromList(Target, _Seed_MeatRaw, recentlyEatenFood, false)
		EndIf
	endif

	
	; Fetch Cooked Food
	If result == none
		result = fetchFromList(Target, _Seed_SmallGameCooked, recentlyEatenFood, false)
	EndIf
	If result == none
		result = fetchFromList(Target, _Seed_FishCooked, recentlyEatenFood, false)
	EndIf
	If result == none
		result = fetchFromList(Target, _Seed_SeafoodCooked, recentlyEatenFood, false)
	EndIf
	If result == none
		result = fetchFromList(Target, _Seed_MeatCooked, recentlyEatenFood, false)
	EndIf
	If result == none
		result = fetchFromList(Target, _Seed_Vegetables, recentlyEatenFood, false)
	EndIf
	If result == none
		result = fetchFromList(Target, _Seed_Fruit, recentlyEatenFood, false)
	EndIf
	If result == none
		result = fetchFromList(Target, _Seed_Cheese, recentlyEatenFood, false)
	EndIf
	If result == none
		result = fetchFromList(Target, _Seed_Bread, recentlyEatenFood, false)
	EndIf
	If result == none
		result = fetchFromList(Target, _Seed_CheeseBowls, recentlyEatenFood, false)
	EndIf
	If result == none
		result = fetchFromList(Target, _Seed_Pastries, recentlyEatenFood, false)
	EndIf
	If result == none
		result = fetchFromList(Target, _Seed_Treats, recentlyEatenFood, false)
	EndIf
	If result == none
		result = fetchFromList(Target, _Seed_Stews, recentlyEatenFood, false)
	EndIf
	If result == none
		result = fetchFromList(Target, _Seed_Preserved, recentlyEatenFood)
	EndIf
	
    unlockContainer()
    return result
EndFunction


Form Function fetchDrink(Actor Target, bool drinkAlcohol)
    if !lockContainer()
   	 return _Seed_ProvisionsLockedToken
    endif
    SeedDebug(0, "[ConsumeManager] fetchDrink.")
    ;Find and drink beverage
    Form result = none
    result =  fetchFromList(Target, _Seed_DrinkNonAlcoholic, none)
    ;endIf
    If  result == none
   	 result = fetchFromList(Target, _Seed_DrinkMilk, none)
    EndIf
    if drinkAlcohol
   	 If  result == none
   		 result = fetchFromList(Target, _Seed_DrinkAlcoholicAle, none)
   	 EndIf
   	 If result == none
   		 result = fetchFromList(Target, _Seed_DrinkAlcoholicWine, none)
   	 EndIf
   	 If result == none
   		 result = fetchFromList(Target, _Seed_DrinkAlcoholicSpirit, none)
   	 EndIf
	 If result == none
   		 result = fetchFromList(Target, _Seed_Stews, none)
   	 EndIf
    endif
    unlockContainer()
    return result
EndFunction

Form Function fetchFromList(Actor Target, FormList myFormList, FormList recentlyEatenFood, bool includePreserved = true)
    Int i = 0
    Int ListSize = myFormList.GetSize() as Int
   	 While i <= ListSize
   		 Form CurrentItem = myFormList.GetAt(i)
   		 If CurrentItem && _Seed_ProvisionsContainerRef.GetItemCount(CurrentItem) > 0
   		 ;TODO: Check if diminishing returns is enabled
   			 If (!recentlyEatenFood || !recentlyEatenFood.HasForm(currentItem)) && getDiseaseChance(CurrentItem, Target) <= 0 && (includePreserved || _Seed_Preserved.Find(currentItem) == -1)
   				 _Seed_ProvisionsContainerRef.RemoveItem(currentItem, 1, true, Target)
   				 return CurrentItem
   			 EndIf
   		 EndIf
   		 i += 1
   	 EndWhile
    Return none
EndFunction

String function getFollowerName(int aIndex)
    if aIndex == 3
   	 return GetTranslationHandler().FollowerThird
    elseif aIndex == 2
   	 return GetTranslationHandler().FollowerSecond
    else    
   	 return GetTranslationHandler().FollowerFirst
    endif
endFunction

String function getConsumedMessage(formList list)
    String consumedText = ""
    if GetSKSELoaded()
   	 Int listIndex = list.GetSize()
   	 int listIndexTop = list.GetSize() - 1
   	 While listIndex
   		 listIndex -= 1
   		 Potion item = list.GetAt(listIndex) As Potion;
   		 String itemName
   		 if(_Seed_DrinkWater.find(item) != -1)
   			 itemName = "water"
   		 else
   			 itemName = item.getName()
   		 endif
   		 if listIndexTop != listIndex
   			 If listIndex == 0
   				 consumedText = consumedText + " and "
   			 Else
   				 consumedText = consumedText + ", "
   			 EndIf
   		 endif
   		 
   		 consumedText = consumedText + itemName
   		 
   		 If listIndex == 0
   			 consumedText = consumedText + "."
   		 endif
   	 EndWhile
    endif
    return consumedText
endFunction

bool function ActorCanAnimate(Actor target)
	;Check Global Variables
	if target == playerRef
		if _Seed_Setting_AnimatePlayer.getValueInt() != 2
			return false
		playerRef.GetAnimationVariableInt("i1stPerson") == 1 && _Seed_Setting_AnimatePlayer_FirstPerson.getValueInt() != 2
			return false
		endif
	elseif _Seed_Setting_AnimateFollowers.getValueInt() != 2
		return false
	endif
	
	; Check Animation Conditions
	if target.IsInCombat()
		return false
	elseif target.IsWeaponDrawn()
		return false
	elseif GetSKSELoaded() && target.IsSwimming()
		return false
	elseif target.IsOnMount()
		return false
	elseif target.GetSleepState() != 0
		return false
	;elseif target.GetSitState() != 0
	;	return false
	elseif GetMonsterHandler().IsActorTransformed(target)
		return false
	endif
	
	; Return true if all conditons met
	return true
endFunction

; Not Currently Used
Function SpoilFood()
	;/
	int handle = ModEvent.Create("LastSeed_AutoEating")
    if (handle)
        ModEvent.Send(handle)
    endIf
	/;
EndFunction

function stopSystem()
	; Override
endFunction