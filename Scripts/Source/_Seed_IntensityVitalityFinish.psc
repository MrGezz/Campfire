scriptname _Seed_IntensityVitalityFinish extends ActiveMagicEffect

import SeedUtil

GlobalVariable Property Provisioning_PerkRank_UnboundIntensity auto

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	float decreaseAmount = 40.0 * (4.0 - Provisioning_PerkRank_UnboundIntensity.getValue())
	Utility.Wait(1)
	GetVitalitySystem().DecreaseAttribute(decreaseAmount)
EndEvent