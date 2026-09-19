Scriptname _Seed_CureDiseasePotionEffect extends activemagiceffect 
Spell property _Seed_CureDiseasePotionSpell auto
Spell property _Seed_CureDiseasePotionSpell_Original auto
GlobalVariable property _Seed_Setting_DiseasePotionsCure auto
Message property CureDiseaseMsg auto

import _SeedInternal

Event OnEffectStart(Actor akTarget, Actor akCaster)	
	SeedDebug(0, "[Cure Diseas Potion]: Starting Effect")
	if _Seed_Setting_DiseasePotionsCure.getValueInt() != 1
		SeedDebug(0, "[Cure Diseas Potion]: Adding Disease Resistance")
		akTarget.DispelSpell(_Seed_CureDiseasePotionSpell)
		Utility.Wait(1.0)		
		_Seed_CureDiseasePotionSpell.Cast(akTarget)
	else
		SeedDebug(0, "[Cure Diseas Potion]: Curing Disease")
		_Seed_CureDiseasePotionSpell_Original.cast(akTarget)
		CureDiseaseMsg.Show()
	endif
EndEvent

