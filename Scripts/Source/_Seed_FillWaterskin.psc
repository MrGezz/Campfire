Scriptname _Seed_FillWaterskin extends activemagiceffect 

import SeedUtil
 
;/
REFERENCED IN: 
_Seed_RefillWaterskin "Refill Empty Waterskin" [MGEF:07012889] \ Scripts
/;

globalvariable property _Seed_Setting_DiseaseChanceDirtyWater auto

Potion Property BottleClean Auto
Potion Property BottleDirty Auto
Potion Property BottleSea Auto
Actor property PlayerRef auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	GetWaterHandler().refillWaterskinDangerousWater(akTarget, BottleDirty, BottleClean, BottleSea)
EndEvent
