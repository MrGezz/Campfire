scriptname _Seed_CannibalFeed extends activemagiceffect
;/
REFERENCED IN: _Seed_CannibalFeed "Cannibal Feed" [MGEF:061E1431]
/;

import SeedUtil

Event OnEffectStart(Actor akTarget, Actor akCaster)
    GetMonsterHandler().CannibalFeed(akTarget, akCaster)
endEvent