scriptname _Seed_VampirismMessage extends ActiveMagicEffect

Message property _Seed_ContractedVampirism auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	_Seed_ContractedVampirism.Show()
endEvent

