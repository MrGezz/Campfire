scriptname _Seed_PerishableFoodTrackerScript extends ObjectReference
;/
_Seed_PerishableFoodTracker [ACTI:06009BD0]
/;  

import Utility
import _SeedInternal
import campUtil

GlobalVariable property _Seed_Setting_SpoilageTemperature auto
GlobalVariable property _Seed_Setting_SpoilageEnable auto
GlobalVariable property _Seed_Setting_SpoilageRemove auto
GlobalVariable property LastSeedRunning auto
GlobalVariable property _Seed_SpoilTemperatureMulti auto

Form property Food auto hidden
Form property SpoiledFood auto hidden
int property Quantity auto hidden
float property CurrentPerishHours = 0.0 auto hidden
float property MaxPerishHours auto hidden
ObjectReference property TrackedContainer auto hidden
ObjectReference property _Seed_SpoiledFoodSystemContainerRef auto
FormList property MyTrackingList auto hidden

actor property playerRef auto

MiscObject property _Seed_PerishedFood auto								   

float lastGameTimeHoursPassed = 0.0


Event OnInit()
	lastGameTimeHoursPassed = GetCurrentGameTime() * 24.0
EndEvent

function startupNonSKSE()
	RegisterForSingleUpdateGameTime(1)
endFunction

Event OnUpdateGameTime()
	; Random back-off for load reduction
	registerForSingleUpdate(RandomFloat(0.0, 10.0))
EndEvent

Event onUpdate()
	updateSpoilage()
	; Update again on the next whole hour
	float updateNext = 1.0 - (CurrentPerishHours - (CurrentPerishHours as int))
	RegisterForSingleUpdateGameTime(updateNext)
endEvent

function updateSpoilage(bool backOff = false)
	; GoToState("Processing")
	; Random back-off for load reduction
	; if(backOff)
	; 	WaitMenuMode(RandomFloat(1.0, 3.0))
	; endif
	
	;Dont Spoil During Combat
	if(playerRef.isInCombat())
		return
	endif
	
	; Does the Food still exist? (Mod that adds this food
	; could have been uninstalled)
	if _Seed_Setting_SpoilageEnable.getValueInt() != 2 || LastSeedRunning.getValueInt() != 2 || !Food || CurrentPerishHours > 410
		DeleteTracker()
		return
	endif	
	AdvanceSpoilage()
	if CurrentPerishHours >= MaxPerishHours
		SpoilFood()
	endif
endFunction

function AdvanceSpoilage()
	float totalHoursPassed = GetCurrentGameTime() * 24.0
	float gameTimeHoursPassedSinceLastUpdate = (totalHoursPassed - lastGameTimeHoursPassed) * _Seed_SpoilTemperatureMulti.getValue()
	CurrentPerishHours += gameTimeHoursPassedSinceLastUpdate
	lastGameTimeHoursPassed = totalHoursPassed
endFunction

function SpoilFood()
	SeedDebug(0, "Spoiling food. Current data: ")
	SeedDebug(0, "    Tracker: " + self)
	SeedDebug(0, "    Food: " + Food)
	SeedDebug(0, "    SpoiledFood: " + SpoiledFood)
	SeedDebug(0, "    Quantity: " + Quantity)
	SeedDebug(0, "    CurrentPerishHours: " + CurrentPerishHours)
	SeedDebug(0, "    MaxPerishHours: " + MaxPerishHours)
	SeedDebug(0, "    TrackedContainer: " + TrackedContainer)
	if TrackedContainer && Food && SpoiledFood
		; Check there is actually food to spoil in container
		Int currentQuantity = TrackedContainer.getItemCount(Food)
		If currentQuantity == 0
			DeleteTracker()
			Return
		ElseIf currentQuantity < Quantity
			Quantity = currentQuantity
		Endif
	
		TrackedContainer.RemoveItem(Food, Quantity, true, _Seed_SpoiledFoodSystemContainerRef)
		if _Seed_Setting_SpoilageRemove.getValue() != 3 && !(_Seed_Setting_SpoilageRemove.getValue() == 2 && SpoiledFood == _Seed_PerishedFood)
			TrackedContainer.AddItem(SpoiledFood, Quantity, true)
		endif
		DeleteTracker()
	else
		if !TrackedContainer
			SeedDebug(2, "A perishable food tracker lost (or never knew) the container it was tracking.")
		endif
		if !Food
			SeedDebug(2, "A perishable food tracker lost (or never knew) the food it was tracking.")
		endif
		if !SpoiledFood
			SeedDebug(2, "A perishable food tracker lost (or never knew) the result food to grant the tracked container.")
		endif
		SeedDebug(2, "Deleting the tracker.")
		DeleteTracker()
	endif
endFunction

function DeleteTracker()
	GoToState("Deleting")
	SeedDebug(0, "Deleting food tracker " + self)
	TrackedContainer = None
	if MyTrackingList
		MyTrackingList.RemoveAddedForm(self)
		MyTrackingList = None
	endif
	UnregisterForUpdateGameTime()
	UnregisterForUpdate()
	;if GetSKSELoaded()
	;	UnregisterForAllMenus()
	;	UnRegisterForModEvent("LastSeed_AutoEating")
	;	UnRegisterForModEvent("LastSeed_ProvisionsOpened")
	;	UnRegisterForModEvent("LastSeed_SpoilageShutdown")
	;endif
	self.Disable()
	self.Delete()
endFunction



int function ReduceQuantity(int aiAmountRequested)
	; Returns the amount actually removed.
	
	if aiAmountRequested >= Quantity
		SeedDebug(0, "food tracker " + self + " had ReduceQuantity request for more than total quantity.")
		int amountRemoved = Quantity
		Quantity = 0

		; We have zeroed out the quantity of this container.
		DeleteTracker()

		return amountRemoved
	else
		SeedDebug(0, "food tracker " + self + " reducing quantity by " + aiAmountRequested)
		Quantity -= aiAmountRequested
		SeedDebug(0, "food tracker " + self + " quantity is now " + Quantity)
		return aiAmountRequested
	endif
endFunction


State Deleting
	function startupNonSKSE()
		; Do Nothing
	endFunction
	
	Event OnUpdateGameTime()
	; Do Nothing
	EndEvent
	
	Event onUpdate()
		; Do Nothing
	endEvent
	
	function updateSpoilage(bool backOff = false)
	; Do Nothing
	endFunction
	
	function AdvanceSpoilage()
		; Do Nothing
	endFunction
	
	function SpoilFood()
		; Do Nothing
	endFunction
	
	function DeleteTracker()
		; Do Nothing
	endFunction
	
	function DeleteTrackerAsync()
		; Do Nothing
	endFunction
	
	int function ReduceQuantity(int aiAmountRequested)
		; Do Nothing
	endFunction
EndState





; --------------
; LEGACY METHODS
; --------------
float function getTemperatureMulti()
	if _Seed_Setting_SpoilageTemperature.getValueInt() == 2	
		_Seed_Compatibility compatibility = SeedUtil.GetCompatibilitySystem()
		if compatibility.isFrostfallLoaded
			int temp = frostUtil.GetCurrentTemperature()
			if temp < 10
				return 0.5
			endif
		endif
	endif
	return 1
endFunction

function startupPlayer()
	; OLD
	; RegisterForMenu("ContainerMenu")
	; RegisterForMenu("BarterMenu")
	; RegisterForMenu("InventoryMenu")
	; RegisterForMenu("Crafting Menu")
	; RegisterForMenu("FavoritesMenu")
	; RegisterForMenu("GiftMenu")
	
	;REVERT TO NEW SYSTEM
	startupNonSKSE()
endFunction

function startupProvisions()
	; OLD
	; RegisterForModEvent("LastSeed_AutoEating", "autoEating")
	; RegisterForModEvent("LastSeed_ProvisionsOpened", "autoEating")
	
	;REVERT TO NEW SYSTEM
	startupNonSKSE()
endFunction

function startupFollower()
	; OLD
	; RegisterForMenu("ContainerMenu")
	; RegisterForMenu("BarterMenu")
	
	;REVERT TO NEW SYSTEM
	startupNonSKSE()
endFunction

Event OnMenuOpen(String MenuName)
	;OLD
	;updateSpoilage()
	
	;REVERT TO NEW SYSTEM
	UnRegisterForMenu("ContainerMenu")
	UnRegisterForMenu("BarterMenu")
	UnRegisterForMenu("InventoryMenu")
	UnRegisterForMenu("Crafting Menu")
	UnRegisterForMenu("FavoritesMenu")
	UnRegisterForMenu("GiftMenu")
	registerForSingleUpdate(RandomFloat(1.0, 3.0))
EndEvent

Event autoEating()
	;OLD
	;updateSpoilage()
	
	;REVERT TO NEW SYSTEM
	UnRegisterForModEvent("LastSeed_AutoEating")
	UnRegisterForModEvent("LastSeed_ProvisionsOpened")
	registerForSingleUpdate(RandomFloat(1.0, 3.0))
endEvent

Event onSpoilageFinish()
	WaitMenuMode(RandomFloat(1.0, 2.0))
	deleteTracker()
endEvent

State Processing
	Event OnBeginState()    
		float updateNext = 1.0 - (CurrentPerishHours - (CurrentPerishHours as int))
		RegisterForSingleUpdateGameTime(updateNext)
	EndEvent
	
	Event OnUpdateGameTime()
		GoToState("")
	EndEvent
	
	; Do not update spoilage while processing
	function updateSpoilage(bool backOff = false)
		return
	EndFunction
EndState

;NO LONGER USED
function DisableTracker()
	SeedDebug(0, "Disabling food tracker " + self)
	TrackedContainer = None
	if MyTrackingList
		MyTrackingList = None
	endif
	UnregisterForUpdateGameTime()
	
	;if GetSKSELoaded()
	;	UnregisterForAllMenus()
	;	UnRegisterForModEvent("LastSeed_AutoEating")
	;	UnRegisterForModEvent("LastSeed_ProvisionsOpened")
	;	UnRegisterForModEvent("LastSeed_SpoilageShutdown")
	;endif
	
	self.Disable()
endFunction

function DeleteTrackerAsync()
	GoToState("DeletingAsync")
endFunction
State DeletingAsync
	Event OnBeginState()
		RegisterForSingleUpdate(RandomInt(0,5))
	EndEvent
	
	Event OnUpdate()
		SeedDebug(0, "Deleting food tracker " + self)
		TrackedContainer = None
		if MyTrackingList
			MyTrackingList.RemoveAddedForm(self)
			MyTrackingList = None
		endif
		UnregisterForUpdateGameTime()
		;if GetSKSELoaded()
		;	UnregisterForAllMenus()
		;	UnRegisterForModEvent("LastSeed_AutoEating")
		;	UnRegisterForModEvent("LastSeed_ProvisionsOpened")
		;	UnRegisterForModEvent("LastSeed_SpoilageShutdown")
		;endif
		self.Disable()
		self.Delete()
	EndEvent
	
	;DO NOTHING
	Event OnUpdateGameTime()
		return
	EndEvent
	Function deleteTracker()
		return
	EndFunction
	function updateSpoilage(bool backOff = false)
		return
	endFunction
	function AdvanceSpoilage()
		return
	endFunction
	function SpoilFood()
		return
	endFunction
	int function ReduceQuantity(int aiAmountRequested)
		return 0
	endFunction
endState