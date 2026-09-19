Scriptname _Seed_FortifyAttributeScript extends ActiveMagicEffect

float property restore_amount auto
{The amount to increase the player's attribute by when this effect starts.}

float property penalty_amount auto
{The amount to decrease the player's attribute by when this effect wears off.}

_Seed_AttributeSystem Property AttributeSystem auto
{Attribute to modify.}

Event OnEffectStart(Actor akTarget, Actor akCaster)
	AttributeSystem.ModAttribute(restore_amount * -1)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	AttributeSystem.ModAttribute(penalty_amount)
endEvent