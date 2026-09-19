Scriptname _Seed_DiseaseCureEffectSpecialised extends activemagiceffect

Spell Property Disease Auto
Spell Property DiseaseTrap Auto

String property diseaseName auto

import SeedUtil

Event OnEffectStart(Actor akTarget, Actor akCaster)
    akTarget.RemoveSpell(Disease)
	if DiseaseTrap
		akTarget.RemoveSpell(DiseaseTrap)
	endif
	debug.notification(GetTranslationHandler().DiseaseCured + GetTranslationHandler().GetDiseaseName(diseaseName))
EndEvent