Scriptname _Seed_ConsumeEat extends activemagiceffect

import SeedUtil

Event OnEffectStart(Actor akTarget, Actor akCaster)
	GetConsumeManager().PlayerEatSpell()
EndEvent