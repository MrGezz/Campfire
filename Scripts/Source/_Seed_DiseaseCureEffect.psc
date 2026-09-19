scriptname _Seed_DiseaseCureEffect extends ActiveMagicEffect

import SeedUtil 

Event OnEffectStart(Actor akTarget, Actor akCaster)
	GetDiseaseSystem().clearDiseases()
EndEvent