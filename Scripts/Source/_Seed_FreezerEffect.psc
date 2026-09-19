Scriptname _Seed_FreezerEffect extends activemagiceffect

import seedUtil

; IcZ: 5.3 declared this without the Property keyword, so LastSeed.esp's binding on
; _Seed_IceWraithTeethEffect never reached it and Show() ran on None.
Message Property _Seed_IceWraithPowderMessage auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	GetSpoilageSystem().runDelayedUpdate()
	_Seed_IceWraithPowderMessage.show()
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	GetSpoilageSystem().runDelayedUpdate()
EndEvent

