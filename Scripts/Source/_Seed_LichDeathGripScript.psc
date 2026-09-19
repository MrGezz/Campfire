scriptName _Seed_LichDeathGripScript extends activemagiceffect

import SeedUtil

Actor property PlayerRef auto hidden

Actor target
Float DamageValue
float totalRestored

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;Set initial values
	target = akTarget
	damageValue = playerRef.GetBaseActorValue("Health") / 15
	totalRestored = 0
	
	; Start Consuming Life
	ConsumeLife()
	RegisterForSingleUpdate(1)
endEvent

Event OnUpdate()
	ConsumeLife()
	RegisterForSingleUpdate(1)
EndEvent

Function ConsumeLife()
	totalRestored = totalRestored + 4
	target.DamageActorValue("Health", DamageValue)
	
	;Delete
	debug.notification("TOTAL RESTORED: " + totalRestored)
EndFunction

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	UnRegisterForUpdate()
	SeedUtil.RestorePlayerHunger(totalRestored)
	SeedUtil.RestorePlayerThirst(totalRestored)
endEvent


;/TODO: Delete this
Function OnEffectStart(Actor akTarget, Actor akCaster)
	SeedUtil.RestorePlayerHunger(4.0)
	SeedUtil.RestorePlayerThirst(4.0)
	RegisterForSingleUpdate(1)
endFunction

Event OnUpdate()	
	SeedUtil.RestorePlayerHunger(8.0)
	SeedUtil.RestorePlayerThirst(8.0)
	RegisterForSingleUpdate(1)
EndEvent
/;