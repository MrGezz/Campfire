Scriptname _Seed_ProvisionsOpen extends activemagiceffect  

ObjectReference property _Seed_ProvisionsContainerRef Auto
actor property PlayerRef auto

;Open Provision Container when Cast
Event OnEffectStart(Actor akTarget, Actor akCaster)
	_Seed_ProvisionsContainerRef.Activate(PlayerRef)
EndEvent


