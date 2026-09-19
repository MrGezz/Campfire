scriptname _Seed_HungoverThirstEffect extends activemagiceffect
;/
REFERENCED IN: TODO
/;

GlobalVariable property _Seed_IsHungover Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	_Seed_IsHungover.setValue(2)
endEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	_Seed_IsHungover.setValue(1)
endEvent