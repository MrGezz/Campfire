scriptname _Seed_FocusEffectDungeonScript extends ActiveMagicEffect

GlobalVariable property _Seed_IsPlayerInDungeon auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    _Seed_IsPlayerInDungeon.SetValueInt(2)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	_Seed_IsPlayerInDungeon.SetValueInt(1)
EndEvent