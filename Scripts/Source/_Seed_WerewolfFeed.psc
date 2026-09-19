scriptname _Seed_WerewolfFeed extends activemagiceffect
;/
REFERENCED IN: 
_Seed_WerewolfFeed "Werewolf Feed" [MGEF:071D722D]
/;

import SeedUtil

Event OnEffectStart(Actor akTarget, Actor akCaster)
	GetMonsterHandler().WerewolfFeed()
endEvent