scriptname _Seed_IntensityVitalityCheck extends ActiveMagicEffect

import SeedUtil

Message property _Seed_IntensityErrorNoVitality auto
Sound property MAGFail auto
Actor property PlayerRef auto
Spell property _Seed_Intensity auto
Keyword property _Seed_IntensityKeyword auto
GlobalVariable Property Provisioning_PerkRank_UnboundIntensity auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	float vitality = GetPlayerVitality()
	if !(vitality > 40 * (4 - Provisioning_PerkRank_UnboundIntensity.getValue()))
		_Seed_IntensityErrorNoVitality.Show()
		GetVitalitySystem().SendEvent_ForceAttributeMeterDisplay(true)
		int i = MAGFail.Play(PlayerRef)
	elseif PlayerRef.HasEffectKeyword(_Seed_IntensityKeyword)
		int i = MAGFail.Play(PlayerRef)
	else
		_Seed_Intensity.Cast(PlayerRef, PlayerRef)
	endif
EndEvent
