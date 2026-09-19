;/NOT CURRENTLY USED/;
Scriptname _Seed_FoodPortions extends activemagiceffect  

import _SeedInternal

ObjectReference property _Seed_ProvisionsContainerRef Auto
GlobalVariable property _Seed_ProvisionsAddPortions auto

;/
REFERENCED IN: 
_Seed_FoodPortionsWaterskin3 "Drink Waterskin, Full" [MGEF:07012887] \ Scripts
_Seed_FoodPortionsWaterskin2 "Drink Waterskin, Mostly Full" [MGEF:07012888] \ Scripts
_Seed_FoodPortionsWaterskin1 "Drink Waterskin, Nearly Empty" [MGEF:07012891] \ Scripts
/;
Potion Property FoodItem  Auto  
Int Property Count  Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	SeedDebug(0, "[_Seed_FoodPortions] ProvisionsAddPortions: " + _Seed_ProvisionsAddPortions.GetValueInt())
	if _Seed_ProvisionsAddPortions.GetValueInt() == 2
		SeedDebug(0, "[_Seed_FoodPortions] Adding Portions to provisions Container")
		_Seed_ProvisionsContainerRef.AddItem(FoodItem, Count)
	else
		SeedDebug(0, "[_Seed_FoodPortions] Adding Portions to Player")
		akTarget.AddItem(FoodItem, Count)
	endif
EndEvent
