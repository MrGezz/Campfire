scriptname _Seed_WaterHandler extends quest

import SeedUtil
import _SeedInternal
import CampUtil
import FrostUtil

;/
REFERENCED IN: 
_Seed_RefillWaterskinNoWater "Refill Empty Waterskin Waterfall" [MGEF:0701288A] \ Scripts
/;
Idle Property IdlePickup_Ground Auto
Potion Property _Seed_WaterskinEmpty Auto

Potion Property _Seed_Waterskin1 Auto
Potion Property _Seed_Waterskin2 Auto
Potion Property _Seed_Waterskin3 Auto

Potion Property _Seed_Waterskin1Clean Auto
Potion Property _Seed_Waterskin2Clean Auto
Potion Property _Seed_Waterskin3Clean Auto

Potion Property _Seed_WaterskinSea Auto
Potion Property _Seed_WaterskinSnow Auto

Potion Property _Seed_WaterBottleEmpty Auto
Potion Property _Seed_WaterBottle Auto
Potion Property _Seed_WaterBottleClean Auto
Potion Property _Seed_WaterBottleSea Auto
Potion Property _Seed_WaterBottleSnow Auto
Potion Property _Seed_RiverWater Auto

FormList Property _Seed_WaterfallList Auto
FormList Property _Seed_WaterActList Auto
FormList Property _Seed_SnowStatList Auto

Actor property PlayerRef Auto
ObjectReference property _Seed_ProvisionsContainerRef Auto
MiscObject property _Seed_WashWater auto

WorldSpace Property Tamriel Auto
WorldSpace Property DLC2SolstheimWorld Auto

ImpactDataSet property _Seed_CheckSnowImpactSet Auto
ImpactDataSet property _Seed_CheckWaterImpactSet Auto

Message Property _Seed_Dialog_NoWaterskinsMsg Auto
Message Property _Seed_DrinkOrFillMsg Auto

GlobalVariable property _Seed_Setting_DiseaseChanceDirtyWater auto

Sound property _Seed_ITMPotionUse auto

location property ClearpinePondLocation auto


; TUTORIAL
globalVariable property _Seed_Setting_DisplayTutorials Auto
globalVariable property _Seed_HelpDone_Waterskins Auto
globalVariable property _Seed_Setting_PO3WaterDetection Auto
Message property _Seed_Help_Waterskins Auto
Message property _Seed_WaterskinsNoWaterMsg Auto

Formlist property _Seed_OvercastWeatherList auto
Weather property DLC2AshStorm auto

Function refillWaterskinDangerousWater(Actor target, Potion BottleFull, Potion BottleClean, Potion BottleSea)
	if target != PlayerRef
		return
	endif
	
	if _Seed_Setting_DiseaseChanceDirtyWater.getValue() == 0
		BottleFull = BottleClean
	endif

	if isInSeawater(PlayerRef)
		PlayerRef.addItem(BottleSea, 1)
	else
		PlayerRef.addItem(BottleFull, 1)
	endif
	getAnimationHandler().pickupAnimation(0)
endFunction

Function refillWaterskin(Actor target, Potion BottleEmpty, Potion BottleFull, Potion BottleClean, Potion BottleSea, Potion BottleSnow)
	if target != PlayerRef
		return
	endif
	
	if _Seed_Setting_DiseaseChanceDirtyWater.getValue() == 0
		BottleFull = BottleClean
	endif
	
	; Fill from Water
	if isInWater(PlayerRef)
		if isInSeawater(PlayerRef)
			PlayerRef.addItem(BottleSea, 1)
		else
			PlayerRef.AddItem(BottleFull, 1)
		endif
		getAnimationHandler().pickupAnimation(0)
	;Fill From Snow
	elseIf isOnSnow(PlayerRef)
		PlayerRef.AddItem(BottleSnow, 1)
		getAnimationHandler().pickupAnimation(0)		
	;Fill From Shallow Water
	ElseIf isInShallowWater(PlayerRef)
		PlayerRef.AddItem(BottleFull, 1)
		getAnimationHandler().pickupAnimation(0)
	; Fill from rain
	ElseIf IsPlayerInRain()
		PlayerRef.AddItem(BottleClean, 1)
	; Fill From Waterfall
	elseif isAtWaterfall(PlayerRef)
		PlayerRef.AddItem(BottleFull, 1)		
	; Failed to fill waterskin
	else
		PlayerRef.AddItem(BottleEmpty, 1, true)
		_Seed_WaterskinsNoWaterMsg.Show()
		ShowTutorial_Waterskin()
	endif
EndFunction

bool function isAtWaterfall(Actor Target)
	return Game.FindClosestReferenceOfAnyTypeInListFromRef(_Seed_WaterfallList, Target, 256.0)
endFunction

bool function isInWater(Actor target)	
	bool SKSELoaded = GetSKSELoaded()
	
	;Check if Player is Swimming
	if(SKSELoaded && target.IsSwimming())
		return true
	endif
	
	; Check if PO3 Can detect if player is in water
	if SKSELoaded && SeedUtil.GetCompatibilitySystem().isPO3Loaded && PO3_SKSEfunctions.IsActorInWater(target)
		return true
	endif
	
	; Check CoDo's Water Detection
	ObjectReference ws = Game.FindClosestReferenceOfAnyTypeInListFromRef(_Seed_WaterActList, target, 512.0)
	if(ws && target.GetPositionZ() <= ws.GetPositionZ() + 128)
		return true
	endif
	
	;Check if player is below cell's water level
	if(SKSELoaded)
		Float WaterLevel = target.GetParentCell().GetWaterLevel()
		Int PosZ = target.GetPositionZ() as Int
		if PosZ < WaterLevel && PosZ > WaterLevel - 2000.0
			return true
		endif
	endif
	
	;Failed to detect water
	return false
endFunction

bool function IsPlayerInRain()    
    ; Check if Player is In a rainy enviroment
    int weather_class = GetWeatherClassificationActual(Weather.GetCurrentWeather())
    bool wet_conditions = false
    if weather_class == 2 && Weather.GetOutgoingWeather() == none && !IsRefInOblivion(PlayerRef) && !IsRefInInterior(PlayerRef)
		wet_conditions = true
    endif
    ; Check if player is in shelter
    if wet_conditions
		_Seed_Compatibility compatibility = SeedUtil.GetCompatibilitySystem()
		if !compatibility.isFrostfallLoaded
			return true
		else
			bool inside_tent = GetCurrentTent()
			bool taking_shelter = IsPlayerTakingShelter()
			if !inside_tent && !taking_shelter
				return true
			endif
		endif
	endif
    return false
endFunction 


bool function isOnSnow(Actor target)
	;return target.PlayImpactEffect(_Seed_CheckSnowImpactSet, "NPC L Calf [LClf]", 0, 0, -1, 128, false, false)
	return target.PlayImpactEffect(_Seed_CheckSnowImpactSet, "NPC L Calf [LClf]", 0, 0, -1, 128, false, false) || target.PlayImpactEffect(_Seed_CheckSnowImpactSet, "NPC R Calf [RClf]", 0, 0, -1, 128, false, false )
endFunction

bool function isInShallowWater(Actor target)
	;return target.PlayImpactEffect(_Seed_CheckWaterImpactSet, "NPC Head [Jaw]", 0, 0, -1, 128, false, false)
	return target.PlayImpactEffect(_Seed_CheckWaterImpactSet, "NPC L Calf [LClf]", 0, 0, -1, 128, false, false) || target.PlayImpactEffect(_Seed_CheckWaterImpactSet, "NPC R Calf [RClf]", 0, 0, -1, 128, false, false )
endFunction

bool Function isInSeawater(Actor target)
	Worldspace CurrentWorld = target.GetWorldSpace()	 
	; Check Tamriel
	if CurrentWorld == Tamriel
		; Get Coordinates
		float posX = target.GetPositionX()
		float posY = target.GetPositionY()
		
		; Check if at Clearpine Pond
		if PlayerRef.GetCurrentLocation() == ClearpinePondLocation
			Return False
		endif
		
		; Check Coordinates
		if posY > 104000.0
			Return True
		elseif posY > 86500.0 && PosX < -10800.0
			Return True
		elseif posY > 50250.0 && PosX > 109250.0
			Return True
		endif
	; Check Solstheim
	elseif CurrentWorld == DLC2SolstheimWorld
		; Get Coordinates
		float posX = target.GetPositionX()
		float posY = target.GetPositionY()
		
		; Check Coordinates
		if PosX < 31070.0
			Return True
		elseif posY < 24385.0
			Return True
		elseif posY > 79100.0
			Return True
		elseif PosX > 76350.0
			Return True	
		endif		
	endif
	return false
endFunction

function fillAllWaterskinsOrDrink_start()
	if isInSeawater(PlayerRef)
		fillAllWaterskins_Sea()
	else
		fillAllWaterskinsOrDrink(false)
	endif
endFunction

function fillAllWaterskinsOrDrink_startNoWater()
	if isInWater(PlayerRef)
		if isInSeawater(PlayerRef)
			fillAllWaterskins_Sea()
		else
			fillAllWaterskinsOrDrink(false)
		endif
	elseif IsPlayerInRain()
		fillAllWaterskinsOrDrink(true)
	elseif isOnSnow(PlayerRef)
		fillAllWaterskins_Snow()	
	ElseIf isInShallowWater(PlayerRef) || isAtWaterfall(PlayerRef)
		fillAllWaterskinsOrDrink(false)
	else
		_Seed_WaterskinsNoWaterMsg.Show()
	endif
endFunction

function fillAllWaterskinsOrDrink(bool cleanWater = true)
	if(_Seed_Setting_DiseaseChanceDirtyWater.getValue() == 0)
		cleanWater = true
	endif
	
	int iButton = _Seed_DrinkOrFillMsg.Show()
		; Drink
		if iButton == 1
			if cleanWater
				RestorePlayerThirst(120.0)
				RestorePartyThirst(120.0)
			else
				PlayerRef.addItem(_Seed_RiverWater, 1, true)
				PlayerRef.equipItem(_Seed_RiverWater, 1, true)
				RestorePartyThirst(20)
			endif
		; Refill
		elseIf iButton == 2
			fillAllWaterskins(cleanWater)
		endIf	
endFunction

;Fill all waterskins in Player Inventory and Provisions
bool function fillAllWaterskins(bool cleanWater = true)
	if(_Seed_Setting_DiseaseChanceDirtyWater.getValue() == 0)
		cleanWater = true
	endif
	
	;Count Dirty Water - Player
	Int WaterskinEmptyCount = playerRef.GetItemCount(_Seed_WaterskinEmpty) as Int
	Int Waterskin1Count = playerRef.GetItemCount(_Seed_Waterskin1) as Int 
	Int Waterskin2Count = playerRef.GetItemCount(_Seed_Waterskin2) as Int
	Int WaterBottleEmptyCount = playerRef.GetItemCount(_Seed_WaterBottleEmpty) as Int
	
	;Count Dirty Water - Provisions
	Int WaterskinEmptyCount_Provisions = _Seed_ProvisionsContainerRef.GetItemCount(_Seed_WaterskinEmpty) as Int
	Int Waterskin1Count_Provisions = _Seed_ProvisionsContainerRef.GetItemCount(_Seed_Waterskin1) as Int 
	Int Waterskin2Count_Provisions = _Seed_ProvisionsContainerRef.GetItemCount(_Seed_Waterskin2) as Int
	Int WaterBottleEmptyCount_Provisions = _Seed_ProvisionsContainerRef.GetItemCount(_Seed_WaterBottleEmpty) as Int	

	;Don't Count Clean Water by Default - Player
	Int Waterskin3Count = 0
	Int Waterskin1CleanCount = 0
	Int Waterskin2CleanCount = 0
	Int WaterBottleDirtyCount = 0
	
	;Don't Count Clean Water by Default - Provisions
	Int Waterskin3Count_Provisions = 0
	Int Waterskin1CleanCount_Provisions = 0
	Int Waterskin2CleanCount_Provisions = 0		
	Int WaterBottleDirtyCount_Provisions = 0
	
	if(cleanWater)	
		; Count Clean Water - Player
		Waterskin3Count = playerRef.GetItemCount(_Seed_Waterskin3) as Int
		Waterskin1CleanCount = playerRef.GetItemCount(_Seed_Waterskin1Clean) as Int
		Waterskin2CleanCount = playerRef.GetItemCount(_Seed_Waterskin2Clean) as Int
		WaterBottleDirtyCount = playerRef.GetItemCount(_Seed_WaterBottle) as Int
		
		; Count Clean Water - Provisions
		Waterskin3Count_Provisions = _Seed_ProvisionsContainerRef.GetItemCount(_Seed_Waterskin3) as Int
		Waterskin1CleanCount_Provisions = _Seed_ProvisionsContainerRef.GetItemCount(_Seed_Waterskin1Clean) as Int
		Waterskin2CleanCount_Provisions = _Seed_ProvisionsContainerRef.GetItemCount(_Seed_Waterskin2Clean) as Int
		WaterBottleDirtyCount_Provisions = _Seed_ProvisionsContainerRef.GetItemCount(_Seed_WaterBottle) as Int
	endif
	
	; Get Totals
	Int waterskinCount_Player = WaterskinEmptyCount + Waterskin1Count + Waterskin2Count + Waterskin3Count + Waterskin1CleanCount + Waterskin2CleanCount
	Int waterskinCount_Provisions = WaterskinEmptyCount_Provisions + Waterskin1Count_Provisions + Waterskin2Count_Provisions + Waterskin3Count_Provisions + Waterskin1CleanCount_Provisions + Waterskin2CleanCount_Provisions
	
	Int waterBottleCount_Player = WaterBottleDirtyCount + WaterBottleEmptyCount
	Int waterBottleCount_Provisions = WaterBottleDirtyCount_Provisions + WaterBottleEmptyCount_Provisions
	
	int waterskinCount = waterskinCount_Player + waterskinCount_Provisions
	int waterBottleCount = waterBottleCount_Player + waterBottleCount_Provisions
	
	; Check if Provisions Container needs to be locked
	bool shouldLockContainer = waterskinCount_Provisions > 0 || waterBottleCount_Provisions > 0
	
	; Fill Waterskins and Water Bottles
	If waterskinCount > 0 || waterBottleCount > 0	
		if(shouldLockContainer)
			GetConsumeManager().lockContainer()
		endif
		
		;Fill Waterskins
		If waterskinCount > 0
			playerRef.RemoveItem(_Seed_WaterskinEmpty, WaterskinEmptyCount, true)
			playerRef.RemoveItem(_Seed_Waterskin1, Waterskin1Count, true)
			playerRef.RemoveItem(_Seed_Waterskin2, Waterskin2Count, true)
			
			_Seed_ProvisionsContainerRef.RemoveItem(_Seed_WaterskinEmpty, WaterskinEmptyCount_Provisions, true)
			_Seed_ProvisionsContainerRef.RemoveItem(_Seed_Waterskin1, Waterskin1Count_Provisions, true)
			_Seed_ProvisionsContainerRef.RemoveItem(_Seed_Waterskin2, Waterskin2Count_Provisions, true)
			
			if(cleanWater)
				playerRef.RemoveItem(_Seed_Waterskin1Clean, Waterskin1CleanCount, true)
				playerRef.RemoveItem(_Seed_Waterskin2Clean, Waterskin2CleanCount, true)
				playerRef.RemoveItem(_Seed_Waterskin3, Waterskin3Count, true)
				
				_Seed_ProvisionsContainerRef.RemoveItem(_Seed_Waterskin1Clean, Waterskin1CleanCount_Provisions, true)
				_Seed_ProvisionsContainerRef.RemoveItem(_Seed_Waterskin2Clean, Waterskin2CleanCount_Provisions, true)
				_Seed_ProvisionsContainerRef.RemoveItem(_Seed_Waterskin3, Waterskin3Count_Provisions, true)				
				
				playerRef.AddItem(_Seed_Waterskin3Clean, waterskinCount)
			else
				playerRef.AddItem(_Seed_Waterskin3, waterskinCount)
			endif
		endif
		
		; Fill Water Bottles
		If waterBottleCount > 0
			playerRef.RemoveItem(_Seed_WaterBottleEmpty, WaterBottleEmptyCount, true)
			_Seed_ProvisionsContainerRef.RemoveItem(_Seed_WaterBottleEmpty, WaterBottleEmptyCount_Provisions, true)
			if(cleanWater)
				playerRef.RemoveItem(_Seed_WaterBottle, WaterBottleDirtyCount, true)
				_Seed_ProvisionsContainerRef.RemoveItem(_Seed_WaterBottle, WaterBottleDirtyCount_Provisions, true)
				playerRef.AddItem(_Seed_WaterBottleClean, waterBottleCount)
			else
				playerRef.AddItem(_Seed_WaterBottle, waterBottleCount)
			endif
		endif
		
		if(shouldLockContainer)
			GetConsumeManager().unlockContainer()
		endif
		return true
	else
		; Show message if no empty waterskins or bottles found
		_Seed_Dialog_NoWaterskinsMsg.Show()
	endif
	return false
endFunction

;Fill all waterskins in Player Inventory with seawater
function fillAllWaterskins_Sea()
	;Count Empty Waterskins and Bottles
	Int WaterskinEmptyCount = playerRef.GetItemCount(_Seed_WaterskinEmpty) as Int
	Int WaterBottleEmptyCount = playerRef.GetItemCount(_Seed_WaterBottleEmpty) as Int
	
	; Fill Waterskins and Water Bottles
	If WaterskinEmptyCount > 0 || WaterBottleEmptyCount > 0			
		;Fill Waterskins
		If WaterskinEmptyCount > 0
			playerRef.RemoveItem(_Seed_WaterskinEmpty, WaterskinEmptyCount, true)
			playerRef.AddItem(_Seed_WaterskinSea, WaterskinEmptyCount)
		endif
		
		; Fill Water Bottles
		If WaterBottleEmptyCount > 0
			playerRef.RemoveItem(_Seed_WaterBottleEmpty, WaterBottleEmptyCount, true)
			playerRef.AddItem(_Seed_WaterBottleSea, WaterBottleEmptyCount)
		endif
	else
		; Show message if no empty waterskins or bottles found
		_Seed_Dialog_NoWaterskinsMsg.Show()
	endif
endFunction

;Fill all waterskins in Player Inventory with Snow
function fillAllWaterskins_Snow()
	;Count Empty Waterskins and Bottles
	Int WaterskinEmptyCount = playerRef.GetItemCount(_Seed_WaterskinEmpty) as Int
	Int WaterBottleEmptyCount = playerRef.GetItemCount(_Seed_WaterBottleEmpty) as Int
	
	; Fill Waterskins and Water Bottles
	If WaterskinEmptyCount > 0 || WaterBottleEmptyCount > 0			
		;Fill Waterskins
		If WaterskinEmptyCount > 0
			playerRef.RemoveItem(_Seed_WaterskinEmpty, WaterskinEmptyCount, true)
			playerRef.AddItem(_Seed_WaterskinSnow, WaterskinEmptyCount)
		endif
		
		; Fill Water Bottles
		If WaterBottleEmptyCount > 0
			playerRef.RemoveItem(_Seed_WaterBottleEmpty, WaterBottleEmptyCount, true)
			playerRef.AddItem(_Seed_WaterBottleSnow, WaterBottleEmptyCount)
		endif
	else
		; Show message if no empty waterskins or bottles found
		_Seed_Dialog_NoWaterskinsMsg.Show()
	endif
endFunction


function ShowTutorial_Waterskin()
    if _Seed_Setting_DisplayTutorials.GetValueInt() == 2 && _Seed_HelpDone_Waterskins.GetValueInt() == 1
        _Seed_Help_Waterskins.Show()
        _Seed_HelpDone_Waterskins.SetValue(2)
    endif
endFunction

bool function getBathWater(Actor Target)
	if (Target.GetItemCount(_Seed_WashWater) >= 1)
		Target.removeItem(_Seed_WashWater, 1)
		return true
	endIf
	return false
endFunction


int function GetWeatherClassificationActual(Weather akWeather)
	if !akWeather
		return -1
	endif

	if _Seed_OvercastWeatherList.HasForm(akWeather)
		return 0
	endif

	int weather_class = akWeather.GetClassification()
	if weather_class == 3
		if akWeather ==DLC2AshStorm
			return 1
		else
			return 3
		endif
	else
		return weather_class
	endif
endFunction


