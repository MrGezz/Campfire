scriptname _Seed_InCombatEffectScript extends ActiveMagicEffect

GlobalVariable _Seed_PlayerInCombat auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	_Seed_PlayerInCombat.setValue(2)
EndEvent


Event OnEffectFinish(Actor akTarget, Actor akCaster)
	_Seed_PlayerInCombat.setValue(1)
EndEvent
