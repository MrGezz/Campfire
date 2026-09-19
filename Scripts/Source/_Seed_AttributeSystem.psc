scriptname _Seed_AttributeSystem extends _Seed_BaseSystem

import SeedUtil
import CampUtil
import _SeedInternal


Actor property PlayerRef auto

GlobalVariable property _Seed_Setting_VampireBehavior auto
GlobalVariable property _Seed_Setting_Notifications auto
GlobalVariable property _Seed_Setting_NeedsMeterDisplayMode auto
GlobalVariable property _Seed_Setting_NeedsSFX auto
GlobalVariable property _Seed_Setting_NeedsVFX auto
GlobalVariable property _Seed_Setting_NeedsForceFeedback auto
globalvariable property TimeScale auto

float property ATTR_MAX = 120.0 auto hidden
float property ATTR_LEVEL_5 = 100.0 auto hidden
float property ATTR_LEVEL_4 = 80.0 auto hidden
float property ATTR_LEVEL_3 = 60.0 auto hidden
float property ATTR_LEVEL_2 = 40.0 auto hidden
float property ATTR_LEVEL_1 = 20.0 auto hidden
float property ATTR_MIN = 0.0 auto hidden

GlobalVariable property attributeEnabled auto
GlobalVariable property attributeValueGlobal auto
GlobalVariable property attributeRateGlobal auto
GlobalVariable property attributeRateMultiGlobal auto
GlobalVariable property attributeLevelGlobal auto
GlobalVariable property _Seed_CarriageRode auto
bool property undeadImmunity = false auto

int property delayedAttributeIncreaseIntervals = 0 auto hidden
Spell[] property attributeSpells auto hidden
Message[] property attributeMessages auto hidden
Sound[] property attributeSoundsM auto hidden
Sound[] property attributeSoundsF auto hidden

ImageSpaceModifier[] property attributeISMs auto hidden
float property lastAttributeValue = 0.0 auto hidden
bool property wasSleeping = false auto hidden
string property meterUpdateEvent auto hidden
string property meterForceEvent auto hidden
string property debugSystemName auto hidden

float property lastUpdateTime = 0.0 auto hidden

Actor property oldActor auto hidden
Actor property currentActor auto hidden
int property followerIndex = 0 auto hidden

float property attributeRegeneratingDelayed = 0.0 auto hidden

int property lastKnownDaysJailed = 0 auto hidden

Actor function getActor()
	if !currentActor
		currentActor = PlayerRef
	endif
	return PlayerRef
endFunction

bool function hasActor()
	return getActor() != none
endFunction

bool function isPlayer()
	return true
endFunction

function StartSystem()
	;Check if this need is for player or follower
	oldActor = getActor()
	
	parent.StartSystem()

	; Turn on the Enabled global, if necessary
	if attributeEnabled.GetValueInt() != 2
		attributeEnabled.SetValueInt(2)
	endif
	
	RegisterForSleep()
	
	updateJailTime()
	
	SeedDebug(1, "[" + debugSystemName + "]: Started.")
endFunction

function StopSystem()
	RemoveAllAttributeSpells()
	RemoveAllISMs()
	lastUpdateTime = 0.0
	parent.StopSystem()
	SeedDebug(1, "[" + debugSystemName + "]: Stopped.")
endFunction

function Update()
	if attributeEnabled.GetValueInt() == 2 && (isPlayer() || hasActor())
		ChangeAttributeOverTime()
    endif
endFunction

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	wasSleeping = true
EndEvent

;/
function IncreaseAttribute(float amount, float target = -1.0)	
	float currentAttributeValue = attributeValueGlobal.GetValue()
	if currentAttributeValue + amount >= ATTR_MAX
		attributeValueGlobal.SetValue(ATTR_MAX)
	else
		attributeValueGlobal.SetValue(currentAttributeValue + amount)
	endif
	SendEvent_UpdateAttributeMeter()
    ApplyAttributeEffects()
endFunction

function DecreaseAttribute(float amount, float target = -1.0)
	float currentAttributeValue = attributeValueGlobal.GetValue()
	if currentAttributeValue - amount <= ATTR_MIN
		attributeValueGlobal.SetValue(ATTR_MIN)
	else
		attributeValueGlobal.SetValue(currentAttributeValue - amount)
	endif
	SendEvent_UpdateAttributeMeter()
    ApplyAttributeEffects()
endFunction
/;

float function getCarriageRideMulti()
	if((_Seed_CarriageRode.getValue() as int) == 2)
		return 0.5
	endif
	return 1
endFunction

bool function wasInJail()
	int daysJailed = game.QueryStat("Days Jailed")
	if daysJailed > lastKnownDaysJailed
		lastKnownDaysJailed = daysJailed
		return true
	endif
	return false
endFunction

bool function updateJailTime()
	lastKnownDaysJailed = game.QueryStat("Days Jailed")
endFunction

function IncreaseAttribute(float amount, float target = -1.0)
	if target == -1.0 || target > ATTR_MAX
        target = ATTR_MAX
    endif

    float currentAttributeValue = attributeValueGlobal.GetValue()

	; If attribute is currently above target, do nothing
	if currentAttributeValue >= target
		SeedDebug(0, "[" + debugSystemName + "]: Attribute already higher than target, not increasing further.")
    ; If increasing above target, only increase amount to match target
	elseif currentAttributeValue + amount >= target
        SeedDebug(0, "[" + debugSystemName + "]: Attribute + amount is higher than target, increasing to target " + target)
		attributeValueGlobal.SetValue(target)
    ; Increase amount normally
	else
		SeedDebug(0, "[" + debugSystemName + "]: Increasing Attribute :" + amount)
        attributeValueGlobal.SetValue(currentAttributeValue + amount)
    endif
    SendEvent_UpdateAttributeMeter()
    ApplyAttributeEffects()
endFunction

function DecreaseAttribute(float amount, float target = -1.0)
	if target == -1.0  || target < ATTR_MIN
        target = ATTR_MIN
    endif

    float currentAttributeValue = attributeValueGlobal.GetValue()
	
	; If attribute is currently below target, do nothing
	if currentAttributeValue <= target
		SeedDebug(0, "[" + debugSystemName + "]: Attribute already lower than target, not decreasing further.")
	elseif currentAttributeValue - amount <= target
        SeedDebug(0, "[" + debugSystemName + "]: Attribute + amount is lower than target, decreasing to target " + target)
		attributeValueGlobal.SetValue(target)
    ; Decrease amount normally
	else
		SeedDebug(0, "[" + debugSystemName + "]: Decreasing Attribute :" + amount)
        attributeValueGlobal.SetValue(currentAttributeValue - amount)
    endif
    SendEvent_UpdateAttributeMeter()
    ApplyAttributeEffects()
endFunction

function ModAttribute(float amount)
	float newAttributeValue = attributeValueGlobal.GetValue() + amount
	if newAttributeValue >= ATTR_MAX
		SeedDebug(0, "[" + debugSystemName + "]: Modding attribute: " + ATTR_MAX)
		attributeValueGlobal.SetValue(ATTR_MAX)
	elseif newAttributeValue <= ATTR_MIN
		SeedDebug(0, "[" + debugSystemName + "]: Modding attribute: " + ATTR_MIN)
		attributeValueGlobal.SetValue(ATTR_MIN)
	else
		SeedDebug(0, "[" + debugSystemName + "]: Modding attribute: " + newAttributeValue)
		attributeValueGlobal.SetValue(newAttributeValue)
	endif
    SendEvent_UpdateAttributeMeter()
    ApplyAttributeEffects()
endFunction

function SetAttribute(float value)
	if value >= ATTR_MAX
		SeedDebug(0, "[" + debugSystemName + "]: Setting attribute: " + ATTR_MAX)
		attributeValueGlobal.SetValue(ATTR_MAX)
	elseif value <= ATTR_MIN
		SeedDebug(0, "[" + debugSystemName + "]: Setting attribute: " + ATTR_MIN)
		attributeValueGlobal.SetValue(ATTR_MIN)
	else
		SeedDebug(0, "[" + debugSystemName + "]: Setting attribute: " + value)
		attributeValueGlobal.SetValue(value)
	endif
    SendEvent_UpdateAttributeMeter()
    ApplyAttributeEffects()
endFunction

float function GetAttributeMulti()
	return attributeRateMultiGlobal.getValue()
endFunction

function ChangeAttributeOverTimeIfFocussed(bool suspendWhileSleeping = false)
	If isPlayerFocused() && delayedAttributeIncreaseIntervals > 1
		ChangeAttributeOverTime(suspendWhileSleeping, true)
	endif
endFunction

function ChangeAttributeOverTime(bool suspendWhileSleeping = false, bool forceUpdate = false)
	SeedDebug(1, "[" + debugSystemName + "]: ChangeAttributeOverTime()")
	
	float thisTime = Utility.GetCurrentGameTime() * 24.0
	
	; Skip the first update.
	if lastUpdateTime == 0.0
		lastUpdateTime = thisTime
		return
	endif

	if suspendWhileSleeping && wasSleeping
		wasSleeping = false
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

	; Limit Update when in Jail
	float target = -1
	if wasInJail()
		target = ATTR_LEVEL_4
	endif							
	SeedDebug(1, "[" + debugSystemName + "]: Total attribute increase: " + attributeIncrease)
	IncreaseAttribute(attributeIncrease, target)
	lastUpdateTime = thisTime

	;RegisterForSingleUpdateGameTime(UpdateFrequencyGlobal.GetValue())
endFunction

function RunDelayedCycles()
	SeedDebug(0, "[" + debugSystemName + "] Running delayed cycles.")
	float thisRate = attributeRateGlobal.GetValue()
	int totalCycles = delayedAttributeIncreaseIntervals
	SeedDebug(1, "[" + debugSystemName + "]: Updating, " + totalCycles + " cycles (running delayed updates). Also updating " + attributeRegeneratingDelayed + " pts from regeneration")
	float attributeIncrease = (thisRate * totalCycles) + attributeRegeneratingDelayed
	SeedDebug(1, "[" + debugSystemName + "]: Total attribute increase: " + attributeIncrease)
	IncreaseAttribute(attributeIncrease)
	attributeRegeneratingDelayed = 0
	delayedAttributeIncreaseIntervals = 0
endFunction

;Used to update attribute when Health/Stamina/Magicka is Regenerating
function updateAttributeRegenerating(float rate, GlobalVariable meterDisplayMode)
	;Calculate attribute loss
	float amount = rate * GetAttributeMulti() * (TimeScale.getValue() / 20)
	if getActor().IsInCombat()
		amount = amount * 0.5
	endif
	;If focussed, delay update
	if IsPlayerFocused()
		attributeRegeneratingDelayed = attributeRegeneratingDelayed + amount
		SeedDebug(0, "[" + debugSystemName + "]: Delaying attribute update from regeneration. New delayed amount: " + attributeRegeneratingDelayed)
	;If not focussed, update immediately and display meter
	else
		IncreaseAttribute(amount)
	;if meterDisplayMode.getValueInt() >= 1 && meterDisplayMode.getValueInt() <= 3																			   
		SendEvent_ForceAttributeMeterDisplay()
	;endif	   
		SeedDebug(0, "[" + debugSystemName + "]: Updating attribute update from regeneration: " + amount)
	endif
endFunction

function ApplyAttributeEffects()
	if hasActor()
		float currentAttributeValue = attributeValueGlobal.GetValue()
	
		bool increasing = false
		if currentAttributeValue > lastAttributeValue
			increasing = true
		endif
	
		if !(IsUpToAndBetween(lastAttributeValue, ATTR_LEVEL_1, ATTR_MIN)) && (IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_1, ATTR_MIN))
			ApplyAttributeLevel(0, increasing)
		
		elseif !(IsUpToAndBetween(lastAttributeValue, ATTR_LEVEL_2, ATTR_LEVEL_1)) && (IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_2, ATTR_LEVEL_1))
			ApplyAttributeLevel(1, increasing)
		
		elseif !(IsUpToAndBetween(lastAttributeValue, ATTR_LEVEL_3, ATTR_LEVEL_2)) && (IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_3, ATTR_LEVEL_2))
			ApplyAttributeLevel(2, increasing)
		
		elseif !(IsUpToAndBetween(lastAttributeValue, ATTR_LEVEL_4, ATTR_LEVEL_3)) && (IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_4, ATTR_LEVEL_3))
			ApplyAttributeLevel(3, increasing)
		
		elseif !(IsUpToAndBetween(lastAttributeValue, ATTR_LEVEL_5, ATTR_LEVEL_4)) && (IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_5, ATTR_LEVEL_4))
			ApplyAttributeLevel(4, increasing, true, true, 1)
		
		elseif !(IsUpToAndBetween(lastAttributeValue, ATTR_MAX, ATTR_LEVEL_5)) && (IsUpToAndBetween(currentAttributeValue, ATTR_MAX, ATTR_LEVEL_5))
			ApplyAttributeLevel(5, increasing, true, true, 1)
		endif
	
		lastAttributeValue = currentAttributeValue
	endif
endFunction

function RemoveAllAttributeSpells()
	int i = 0
	while i < attributeSpells.Length
		if hasActor()
			getActor().RemoveSpell(attributeSpells[i])
		endif
		; Also remove spells from old actor
		if !isPlayer()
			if oldActor
				oldActor.RemoveSpell(attributeSpells[i])				
			endif
			oldActor = getActor()
		endif
		i += 1
	endWhile
endFunction

function RemoveAllISMs()
	if isPlayer()
		int i = 0
		while i < attributeISMs.Length
			if attributeISMs[i]
				attributeISMs[i].Remove()
			endif
			i += 1
		endWhile
	endif
endFunction

function enqueueSound(sound thisSound)
	;@Override Function
endFunction

function ApplyAttributeLevel(int level, bool isIncreasing, bool forceMeter = false, bool flashMeter = false, int rumbleLevel = 0, bool lowerIsWorse = false, bool bypassVitalityTargetUpdate = false)
	SeedDebug(0, "[" + debugSystemName + "] level " + level + ", isIncreasing " + isIncreasing + ", forceMeter " + forceMeter + ", rumbleLevel " + rumbleLevel)

	RemoveAllAttributeSpells()

	attributeLevelGlobal.SetValueInt(level)
	showAttributeMessage(level)

	Spell thisSpell = attributeSpells[level]
    getActor().AddSpell(thisSpell, false)
	
	if isPlayer()
		Sound thisSound
		if PlayerRef.GetActorBase().GetSex() == 1
			thisSound = attributeSoundsF[level]
		else
			thisSound = attributeSoundsM[level]
		endif
		
		ImageSpaceModifier thisISM = attributeISMs[level]
		
		if _Seed_Setting_NeedsSFX.GetValueInt() == 2 ;&& ((!lowerIsWorse && isIncreasing) || (lowerIsWorse && !isIncreasing))
			enqueueSound(thisSound)
		endif
	
		if _Seed_Setting_NeedsVFX.GetValueInt() == 2
			if thisISM
				SeedDebug(0, "[" + debugSystemName + "]: Applying crossfade ISM.")
				thisISM.ApplyCrossFade(4.0)
			else
				RemoveAllISMs()
			endif
		endif
	
		if forceMeter
			SeedDebug(0, "[" + debugSystemName + "]: Forcing meter display.")
			SendEvent_ForceAttributeMeterDisplay(flashMeter)
		endif
	
		if rumbleLevel > 0 && ((!lowerIsWorse && isIncreasing) || (lowerIsWorse && !isIncreasing))
			if rumbleLevel == 1
				SeedDebug(0, "[" + debugSystemName + "]: Playing rumble level 1.")
				Game.ShakeController(0.6, 0.2, 1.0)
			elseif rumbleLevel == 2
				SeedDebug(0, "[" + debugSystemName + "]: Playing rumble level 2.")
				Game.ShakeController(0.2, 0.4, 2.0)
			endif
		endif
	
		if !bypassVitalityTargetUpdate
			GetVitalitySystem().UpdateVitalityTarget()
		endif
	endif
endFunction

function showAttributeMessage(int level)
	if isPlayer()
		if _Seed_Setting_Notifications.GetValueInt() == 2
			SeedDebug(0, "[" + debugSystemName + "]: Showing message.")
			attributeMessages[level].Show()
		endif
	elseif getFollowerMessage(level)
		string name = "One of Your followers"
		if GetSKSELoaded()
			name = getActor().GetBaseObject().GetName()
		else
			if followerIndex == 3
				name = GetTranslationHandler().FollowerFirst
			elseif followerIndex == 2
				name = GetTranslationHandler().FollowerSecond
			elseif followerIndex == 1	
				name = GetTranslationHandler().FollowerThird
			endif
		endIf
		Debug.Notification(name + getFollowerMessage(level))
	endIf
endFunction

String Function getFollowerMessage(int i)
	return ""
endFunction

function DisplayCurrentStatus()
	SeedDebug(0, "[" + debugSystemName + "]: Displaying Current Status")
	float currentAttributeValue = attributeValueGlobal.GetValue()

	if IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_1, ATTR_MIN)
		showAttributeMessage(0)
		SeedDebug(0, "[" + debugSystemName + "]: Level 0")
    elseif IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_2, ATTR_LEVEL_1)
        showAttributeMessage(1)
		SeedDebug(0, "[" + debugSystemName + "]: Level 1")
    elseif IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_3, ATTR_LEVEL_2)
        showAttributeMessage(2)
		SeedDebug(0, "[" + debugSystemName + "]: Level 2")
    elseif IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_4, ATTR_LEVEL_3)
        showAttributeMessage(3)
		SeedDebug(0, "[" + debugSystemName + "]: Level 3")
    elseif IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_5, ATTR_LEVEL_4)
        showAttributeMessage(4)
		SeedDebug(0, "[" + debugSystemName + "]: Level 4")
    elseif IsUpToAndBetween(currentAttributeValue, ATTR_MAX, ATTR_LEVEL_5)
        showAttributeMessage(5)
		SeedDebug(0, "[" + debugSystemName + "]: Level 5")
    endif

    SendEvent_ForceAttributeMeterDisplay()
endFunction

function RegisterForEvents()
	; Extend
endFunction

;@NOFALLBACK
function SendEvent_UpdateAttributeMeter()
	if GetSKSELoaded() && IsPlayer() && _Seed_Setting_NeedsMeterDisplayMode.getValueInt() != 0
		int handle = ModEvent.Create(meterUpdateEvent)
		if handle
			ModEvent.Send(handle)
		endif
	endif
endFunction

;@NOFALLBACK
function SendEvent_ForceAttributeMeterDisplay(bool flash = false)	
if GetSKSELoaded() && IsPlayer() && _Seed_Setting_NeedsMeterDisplayMode.getValueInt() != 0
		int handle = ModEvent.Create(meterForceEvent)
		if handle
			ModEvent.PushBool(handle, flash)
			ModEvent.Send(handle)
		endif
	endif
endFunction

Function RefreshSystem()
	if(attributeEnabled.getValue() == 2)
		SeedDebug(1, "[" + debugSystemName + "]: Refreshing.")
		parent.RefreshSystem()
	endif
EndFunction