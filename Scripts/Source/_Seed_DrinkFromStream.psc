scriptname _Seed_DrinkFromStream extends activemagiceffect
;/
_Seed_DrinkFromStream "Drink from stream" [MGEF:0650665B]														 
/;

import SeedUtil

Potion Property _Seed_RiverWater auto
Actor Property PlayerRef auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    GetWaterHandler().fillAllWaterskinsOrDrink_start()
endEvent