scriptname _Seed_HungerSystem_Party extends _Seed_HungerSystem

import _SeedInternal
import seedUtil
import campUtil

; COMMON FUNCTIONS
Actor function getActor()
    return none
endFunction

;TODO: Replace this with SeedUtil
bool function hasActor()
	return true
endFunction

bool function isPlayer()
    return false
endFunction

;TODO: Move this to SeedUtil and Increase to 10
int function getMaxFollowers()
	return 3
endFunction


function RemoveAttributeSpells(Actor follower)
    int i = 0
    while i < attributeSpells.Length
            follower.RemoveSpell(attributeSpells[i])
        i += 1
    endWhile
endFunction


Function changeAttributeSpellForAll(Spell thisSpell = none)
Int i = 1
	while i <= getMaxFollowers()
		changeAttributeSpell(i, thisSpell)
		i += 1
	EndWhile
EndFunction

Function changeAttributeSpell(int i, Spell thisSpell = none)
	Actor follower = CampUtil.GetTrackedFollower(i)
	If follower
		RemoveAttributeSpells(follower)
		If thisSpell
			follower.AddSpell(thisSpell, false)
		Endif
	Endif
endFunction


Function applyNeedsToFollower(int index)
	float currentAttributeValue = attributeValueGlobal.GetValue()
	
	if IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_1, ATTR_MIN)
		changeAttributeSpell(index, attributeSpells[0])
	Elseif IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_2, ATTR_LEVEL_1)
		changeAttributeSpell(index, attributeSpells[1])
		
	elseif IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_3, ATTR_LEVEL_2)
		changeAttributeSpell(index, attributeSpells[2])
	
	elseif IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_4, ATTR_LEVEL_3)
		changeAttributeSpell(index, attributeSpells[3])
		
	elseif IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_5, ATTR_LEVEL_4)
		changeAttributeSpell(index, attributeSpells[4])
		
	IsUpToAndBetween(currentAttributeValue, ATTR_MAX, ATTR_LEVEL_5)
		changeAttributeSpell(index, attributeSpells[5])
	endif
endFunction

function ChangeAttributeOverTime(bool suspendWhileSleeping = false, bool forceUpdate = false)
	SeedDebug(1, "[" + debugSystemName + "]: ChangeAttributeOverTime()")
	; Skip the first update.
	if lastUpdateTime == 0.0
		lastUpdateTime = Utility.GetCurrentGameTime() * 24.0
		return
	endif

	float thisTime = Utility.GetCurrentGameTime() * 24.0

	if suspendWhileSleeping && wasSleeping
		wasSleeping = false
		lastUpdateTime = thisTime
		return
	endif
	
	; Don't Update when in Jail
	if wasInJail()
		lastUpdateTime = thisTime 
		return
	endif	

	float thisRate = attributeRateGlobal.GetValue() * GetAttributeMulti()

	int cycles = Math.Floor((thisTime - lastUpdateTime) * 2)
	if cycles < 1
		cycles = 1
	endif

	if IsPlayerFocused() && !forceUpdate
		delayedAttributeIncreaseIntervals += cycles
		SeedDebug(1, "[" + debugSystemName + "]: Player is focused. Delaying update. (" + delayedAttributeIncreaseIntervals + " updates delayed)")
		return
	endif

	int totalCycles = cycles + delayedAttributeIncreaseIntervals
	delayedAttributeIncreaseIntervals = 0
	SeedDebug(1, "[" + debugSystemName + "]: Updating, " + totalCycles + " cycles.")

	float attributeIncrease
	if !wasSleeping
		attributeIncrease = thisRate * totalCycles
	else
		wasSleeping = false
		attributeIncrease = (thisRate * totalCycles) / 4
	endif

	SeedDebug(1, "[" + debugSystemName + "]: Total attribute increase: " + attributeIncrease)
	
	; If there are no followers, decrease attribute to content level
	if getTrackedPartyCount() > 0
		IncreaseAttribute(attributeIncrease)
	else
		decreaseAttribute(attributeIncrease, ATTR_LEVEL_2)
	endif
	
	lastUpdateTime = thisTime

	;RegisterForSingleUpdateGameTime(UpdateFrequencyGlobal.GetValue())
endFunction




Event OnUpdate()
    ; Do nothing
EndEvent

function RemoveAllAttributeSpells()
	int i = 1
	While i <= getMaxFollowers()
		Actor follower = GetTrackedFollower(i)
		if follower 
			int j = 0
			while j < attributeSpells.Length
				follower.removeSpell(attributeSpells[j])
				j += 1
			endWhile
		Endif
		i += 1
	endwhile
endFunction


;UNIQUE FUNCTIONS
function ApplyAttributeLevel(int level, bool isIncreasing, bool forceMeter = false, bool flashMeter = false, int rumbleLevel = 0, bool lowerIsWorse = false, bool bypassVitalityTargetUpdate = false)
    SeedDebug(0, "[" + debugSystemName + "] level " + level + ", isIncreasing " + isIncreasing)

    attributeLevelGlobal.SetValueInt(level)


	showAttributeMessage(level)

    ; Spell thisSpell = attributeSpells[level]
    ; changeAttributeSpellForAll(thisSpell)

	; AutoEat
	if isIncreasing && level > 1
		GetConsumeManagerParty().AutoEat()
	endif
	
	;TODO: Finish THis?
	;/
		if !bypassMoraleTargetUpdate
			GetFollowerNeeds().GetMoraleSystem().UpdateVitalityTarget()
		endif
	/;
endFunction

function showAttributeMessage(int level)	
	if _Seed_Setting_Notifications_Followers.GetValueInt() == 2 && getTrackedPartyCount() > 0
		string name = ""
		if GetSKSELoaded() && getTrackedPartyCount() == 1
			if getTrackedFollower(1)
				name = getTrackedFollower(1).GetBaseObject().GetName()
			elseif getTrackedFollower(2)
				name = getTrackedFollower(2).GetBaseObject().GetName()
			elseif getTrackedFollower(3)
				name = getTrackedFollower(3).GetBaseObject().GetName()
			else
				name = GetTranslationHandler().Party
			endif
			GetConsumeManagerParty().EnqueuePartyHungerMessage(name + getFollowerMessage(level))
			return
		else
			name = GetTranslationHandler().Party
			GetConsumeManagerParty().EnqueuePartyHungerMessage(name + getPartyMessage(level))
			return
		endIf	
	endif
endFunction

; @override
String Function getPartyMessage(int i)
	return GetTranslationHandler().GetPartyHungerMessage(i)
endFunction

function StartUp()
	parent.startup()
    debugSystemName = "Party Hunger"
endFunction

;@Override Function
float function GetAttributeMulti()
	return attributeRateMultiGlobal.getValue() * getCarriageRideMulti()
endFunction