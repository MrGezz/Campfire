Scriptname _Seed_FillWaterskinNoWater extends activemagiceffect
;/
REFERENCED IN: 
_Seed_RefillWaterskinNoWater "Refill Empty Waterskin Waterfall" [MGEF:0701288A] \ Scripts
/;
import SeedUtil

Potion Property BottleEmpty Auto
Potion Property BottleFull Auto
Potion Property BottleClean Auto
Potion Property BottleSea Auto
Potion Property BottleSnow Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	GetWaterHandler().RefillWaterskin(akTarget, BottleEmpty, BottleFull, BottleClean, BottleSea, BottleSnow)
endEvent
