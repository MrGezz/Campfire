scriptname _Seed_DiseaseNeedsMulti extends activemagiceffect

globalVariable property needsMulti auto
float property multiAmount auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	needsMulti.setValue(multiAmount)
endEvent


Event OnEffectFinish(Actor akTarget, Actor akCaster)
	needsMulti.setValue(0)
endEvent