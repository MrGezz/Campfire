Scriptname _Seed_ConsumeDrink extends activemagiceffect

import SeedUtil

Event OnEffectStart(Actor akTarget, Actor akCaster)
	GetConsumeManager().PlayerDrinkSpell()
EndEvent
