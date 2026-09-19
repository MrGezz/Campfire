Scriptname _Seed_ShrineBlessing extends ActiveMagicEffect  

import camputil
import seedUtil

Spell Property _Seed_BlessedSpell auto
Spell Property _Seed_CureDiseasePotionSpell_Original auto
Spell Property WerewolfImmunity auto
GlobalVariable property _Seed_Setting_ShrinesCure auto
Message property CureDiseaseMsg auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if !IsPlayerUndead() && !akTarget.HasSpell(WerewolfImmunity)
		if _Seed_Setting_ShrinesCure.getValueInt() == 2
			akTarget.DispelSpell(_Seed_BlessedSpell)
			Utility.Wait(1.0)
			_Seed_BlessedSpell.Cast(akTarget)
			;debug.notification("You are now Blessed. You are immune to all diseases for 12 hours.")
		else
			_Seed_CureDiseasePotionSpell_Original.Cast(akTarget)
			GetDiseaseSystem().clearDiseases()
			CureDiseaseMsg.Show()
		endif
	endif
EndEvent