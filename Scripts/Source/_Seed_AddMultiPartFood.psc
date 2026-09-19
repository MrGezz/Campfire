Scriptname _Seed_AddMultiPartFood extends ActiveMagicEffect

import Utility

Potion property foodWhole auto
Potion property foodPortion auto
Int property foodPortionCount auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	WaitMenuMode(3)
	SeedUtil.GetFoodDataStoreHandler().UpdateMultiPartFood_Keyword(foodWhole, foodPortion, foodPortionCount)
EndEvent