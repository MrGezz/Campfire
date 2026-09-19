scriptname _Seed_DrinkFromStreamNoWater extends activemagiceffect

import SeedUtil

Event OnEffectStart(Actor akTarget, Actor akCaster)
	GetWaterHandler().fillAllWaterskinsOrDrink_startNoWater()
endEvent

;DEPRECIATED - Moved to _Seed_WaterHandler
Potion Property _Seed_RiverWater auto
Message Property _Seed_CantDrinkSeaWater auto
Message Property _Seed_WaterskinsNoWaterMsg auto
Actor Property PlayerRef auto
function drinkRiverWater()
    PlayerRef.addItem(_Seed_RiverWater, 1, true)
    PlayerRef.equipItem(_Seed_RiverWater, 1, true)
endFunction