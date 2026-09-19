scriptname _Seed_VitalitySystem extends _Seed_AttributeSystem
;/
REFERENCED IN: 
_Seed_VitalitySystemQuest "Vitality System" [QUST:07004FC2] \ Scripts
/;

import CampUtil
import SeedUtil
import FrostUtil
import _SeedInternal
import Math

GlobalVariable property _Seed_Setting_NoVitalityMode auto
GlobalVariable property _Seed_IsHungover Auto

Spell property VitalitySpell1 auto
Spell property VitalitySpell2 auto
Spell property VitalitySpell3 auto
Spell property VitalitySpell4 auto
Spell property VitalitySpell5 auto
Spell property VitalitySpell6 auto
Spell property VitalitySpell7 auto
Spell property VitalitySpell8 auto

Message property VitalityMessage1 auto
Message property VitalityMessage2 auto
Message property VitalityMessage3 auto
Message property VitalityMessage4 auto
Message property VitalityMessage5 auto
Message property VitalityMessage6 auto
Message property VitalityMessage7 auto
Message property VitalityMessage8 auto
Message property _Seed_VitalityDeath auto

ImageSpaceModifier property VitalityISM6 auto
ImageSpaceModifier property VitalityISM7 auto

GlobalVariable property _Seed_setting_VitalityExposureMulti auto
GlobalVariable property _Seed_setting_VitalityFatigueMulti auto
GlobalVariable property _Seed_setting_VitalityDiseaseMulti auto
GlobalVariable property _Seed_setting_VitalityThirstMulti auto
GlobalVariable property _Seed_setting_VitalityHungerMulti auto
GlobalVariable property _Seed_setting_VitalityAlcoholMulti auto
GlobalVariable property _Seed_setting_VitalitySkoomaMulti auto
GlobalVariable property _Seed_VitalityTarget auto
GlobalVariable property _Seed_SettingPlayerIsLich auto
GlobalVariable property _Seed_Setting_AlternateDeathSystem auto

Static property XMarker auto

float property ATTR_LEVEL_6 = 120.0 auto hidden
float property ATTR_LEVEL_7 = 140.0 auto hidden

float lastVitalityTarget = 0.0
float currentVitalityTarget = 0.0

int deathCounter = 0
int DEATH_COUNTER_MAX = 2

function StartUp()
    debugSystemName = "Vitality"
    meterUpdateEvent = "LastSeed_UpdateVitalityMeter"
    meterForceEvent = "LastSeed_ForceVitalityMeterDisplay"

    ; Initialize arrays
    attributeSpells = new Spell[8]
    attributeMessages = new Message[8]
    attributeSoundsM = new Sound[8]
    attributeSoundsF = new Sound[8]
    attributeISMs = new ImageSpaceModifier[8]

    ; Set new MAX value
    ATTR_MAX = 160.0

    ; Populate arrays
    attributeSpells[0] = VitalitySpell1
    attributeSpells[1] = VitalitySpell2
    attributeSpells[2] = VitalitySpell3
    attributeSpells[3] = VitalitySpell4
    attributeSpells[4] = VitalitySpell5
    attributeSpells[5] = VitalitySpell6
    attributeSpells[6] = VitalitySpell7
    attributeSpells[7] = VitalitySpell8

    attributeMessages[0] = VitalityMessage1
    attributeMessages[1] = VitalityMessage2
    attributeMessages[2] = VitalityMessage3
    attributeMessages[3] = VitalityMessage4
    attributeMessages[4] = VitalityMessage5
    attributeMessages[5] = VitalityMessage6
    attributeMessages[6] = VitalityMessage7
    attributeMessages[7] = VitalityMessage8

    attributeISMs[0] = VitalityISM7
    attributeISMs[1] = VitalityISM6
	
	updateJailTime()
endFunction

; Overrides _Seed_AttributeSystem
function ApplyAttributeEffects()
    float currentAttributeValue = attributeValueGlobal.GetValue()

    bool increasing = false
    if currentAttributeValue > lastAttributeValue
        increasing = true
    endif

    if !(IsUpToAndBetween(lastAttributeValue, ATTR_LEVEL_1, ATTR_MIN)) && (IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_1, ATTR_MIN))
        ApplyAttributeLevel(0, increasing, true, true, 2, lowerIsWorse = true, bypassVitalityTargetUpdate = true)
    
    elseif !(IsUpToAndBetween(lastAttributeValue, ATTR_LEVEL_2, ATTR_LEVEL_1)) && (IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_2, ATTR_LEVEL_1))
        ApplyAttributeLevel(1, increasing, true, true, 1, lowerIsWorse = true, bypassVitalityTargetUpdate = true)
    
    elseif !(IsUpToAndBetween(lastAttributeValue, ATTR_LEVEL_3, ATTR_LEVEL_2)) && (IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_3, ATTR_LEVEL_2))
        ApplyAttributeLevel(2, increasing, true, false, lowerIsWorse = true, bypassVitalityTargetUpdate = true)
    
    elseif !(IsUpToAndBetween(lastAttributeValue, ATTR_LEVEL_4, ATTR_LEVEL_3)) && (IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_4, ATTR_LEVEL_3))
        ApplyAttributeLevel(3, increasing, lowerIsWorse = true, bypassVitalityTargetUpdate = true)
    
    elseif !(IsUpToAndBetween(lastAttributeValue, ATTR_LEVEL_5, ATTR_LEVEL_4)) && (IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_5, ATTR_LEVEL_4))
        ApplyAttributeLevel(4, increasing, lowerIsWorse = true, bypassVitalityTargetUpdate = true)
    
    elseif !(IsUpToAndBetween(lastAttributeValue, ATTR_LEVEL_6, ATTR_LEVEL_5)) && (IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_6, ATTR_LEVEL_5))
        ApplyAttributeLevel(5, increasing, lowerIsWorse = true, bypassVitalityTargetUpdate = true)

    elseif !(IsUpToAndBetween(lastAttributeValue, ATTR_LEVEL_7, ATTR_LEVEL_6)) && (IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_7, ATTR_LEVEL_6))
        ApplyAttributeLevel(6, increasing, lowerIsWorse = true, bypassVitalityTargetUpdate = true)

    elseif !(IsUpToAndBetween(lastAttributeValue, ATTR_MAX, ATTR_LEVEL_7)) && (IsUpToAndBetween(currentAttributeValue, ATTR_MAX, ATTR_LEVEL_7))
        ApplyAttributeLevel(7, increasing, lowerIsWorse = true, bypassVitalityTargetUpdate = true)
    endif

    if isPlayer() && _Seed_Setting_NoVitalityMode.getValueInt() >= 2 && GetMonsterHandler().getVampireSettings(false, false, true) == false && _Seed_SettingPlayerIsLich.getValue() != 2 && currentAttributeValue <= ATTR_MIN
		; Show Meter
		SendEvent_ForceAttributeMeterDisplay(true)
		
        ; Increment Death Counter
		deathCounter = deathCounter + 1
		SeedDebug(0, "[" + debugSystemName + "]: Death Counter: " + deathCounter + "/" + DEATH_COUNTER_MAX)
		; Once death counter times out, kill player
		
		if deathCounter >= DEATH_COUNTER_MAX
			deathCounter = 0
			if _Seed_Setting_NoVitalityMode.getValueInt() == 2
				seedUtil.getRescueSystem().OnRescuePlayer(PlayerRef.IsSwimming())
			else
				KillPlayer()
			endif
		endif
	else
		; Reset death counter
		deathCounter = 0
    endif

    lastAttributeValue = currentAttributeValue
endFunction

function KillPlayer()	
	 SeedDebug(0, "[" + debugSystemName + "]: You have died.")
	_Seed_VitalityDeath.Show()
	Utility.Wait(3)
	if PlayerRef.IsOnMount()
		KnockPlayerOffHorse()
	endif
	;Final check before killing, in case player has changed the setting at last minute.
	if _Seed_Setting_NoVitalityMode.getValueInt() == 3
		If _Seed_Setting_AlternateDeathSystem.getValue() == 2
			PlayerRef.DamageActorValue("Health", (PlayerREF.GetActorValue("Health")))
			seedUtil.getRescueSystem().restoreAttributesAfterRescue()
		else
			PlayerRef.Kill()
		endif
	endif
endFunction

bool knocking_off_horse = false
function KnockPlayerOffHorse()
    knocking_off_horse = false
    RegisterForCameraState()
    ObjectReference heading = PlayerRef.PlaceAtMe(XMarker)
    float[] heading_pos = GetOffsets(PlayerRef, 500.0, 90.0)
    heading.MoveTo(PlayerRef, heading_pos[0], heading_pos[1])
    Utility.Wait(0.2)
    heading.PushActorAway(PlayerRef, 5.0)
    Utility.Wait(0.5)
    int i = 0
    while knocking_off_horse && i < 30
        Utility.Wait(0.5)
        i += 1
    endWhile
    UnregisterForCameraState()
    heading.Disable()
    heading.Delete()
endFunction

Event OnPlayerCameraState(int oldState, int newState)
    if newState == 11
        knocking_off_horse = true
    else
        knocking_off_horse = false
    endif
EndEvent

float[] function GetOffsets(Actor akSource, Float afDistance = 100.0, float afOffset = 0.0)
    Float A = akSource.GetAngleZ() + afOffset
    Float YDist = Sin(A)
    Float XDist = Cos(A)

    XDist *= afDistance
    YDist *= afDistance

    Float[] Offsets = New Float[2]
    Offsets[0] = YDist
    Offsets[1] = XDist
    Return Offsets
EndFunction

; Overrides _Seed_AttributeSystem
function ChangeAttributeOverTime(bool suspendWhileSleeping = false, bool forceUpdate = false)
    SeedDebug(1, "[" + debugSystemName + "]: ChangeAttributeOverTime()")

    ; Skip the first update.
    if lastUpdateTime == 0.0
        lastUpdateTime = Utility.GetCurrentGameTime() * 24.0
        return
    endif

    ; Wait for other needs to finish first.
    Utility.Wait(3)

    float thisTime = Utility.GetCurrentGameTime() * 24.0

    ; Don't process Vitality changes while the player is focused.
    if IsPlayerFocused() && !forceUpdate
        lastUpdateTime = thisTime
        return
    endif
	
	UpdateVitalityTarget()
	
    float currentAttributeValue = attributeValueGlobal.GetValue()
    float thisRate = attributeRateGlobal.GetValue()
    if wasSleeping
        thisRate *= 3.0
    endif



    int totalCycles = Math.Floor((thisTime - lastUpdateTime) * 2)
    if totalCycles < 1
        totalCycles = 1
    endif
    SeedDebug(1, "[" + debugSystemName + "]: Updating, " + totalCycles + " cycles.")

    ; To-do - Simulate the Vitality change that would occur as needs change over time (i.e. attributeChange should taper)
    float attributeChange = thisRate * totalCycles * attributeRateMultiGlobal.getValue()
    SeedDebug(1, "[" + debugSystemName + "]: Total attribute change: " + attributeChange)
	if currentAttributeValue < currentVitalityTarget
		; Limit increases when very healthy and sleeping, waiting or fast-travelling
		if totalCycles > 1 && currentAttributeValue >=  ATTR_LEVEL_6 - 2
            attributeChange = thisRate * attributeRateMultiGlobal.getValue()
        endif
        IncreaseAttribute(attributeChange, currentVitalityTarget)
    elseif currentAttributeValue > currentVitalityTarget
        if wasSleeping
            ; Don't decrease Vitality when sleeping.
        else
            DecreaseAttribute(attributeChange, currentVitalityTarget)
        endif
    endif

    lastVitalityTarget = currentVitalityTarget
	_Seed_VitalityTarget.setValue(currentVitalityTarget)
    lastUpdateTime = thisTime
    wasSleeping = false

    RegisterForSingleUpdateGameTime(UpdateFrequencyGlobal.GetValue())
endFunction



function UpdateVitalityTarget()
	float exposureTargetMod = GetExposureTargetMod() * _Seed_setting_VitalityExposureMulti.getValue()
	float fatigueTargetMod = GetFatigueTargetMod() * _Seed_setting_VitalityFatigueMulti.getValue()
	float diseaseTargetMod = GetDiseaseSystem().GetDiseaseTargetMod() * _Seed_setting_VitalityDiseaseMulti.getValue()
	float thirstTargetMod = GetThirstTargetMod() * _Seed_setting_VitalityThirstMulti.getValue()
	float hungerTargetMod = GetHungerTargetMod() * _Seed_setting_VitalityHungerMulti.getValue()
	float alcoholTargetMod = GetAlcoholTargetMod() * _Seed_setting_VitalityAlcoholMulti.getValue()
	float skoomaTargetMod = GetSkoomaTargetMod() * _Seed_setting_VitalitySkoomaMulti.getValue()
	float bathingTargetMod = GetBathingTargetMod()
	
	currentVitalityTarget = ATTR_MAX + exposureTargetMod + hungerTargetMod + thirstTargetMod  + fatigueTargetMod + diseaseTargetMod + alcoholTargetMod + skoomaTargetMod + bathingTargetMod
	
    ; Display the vitality meter in contextual mode if the
    ; vitality target changes dramatically.
    SeedDebug(1, "[" + debugSystemName + "]: Last target was " + lastVitalityTarget + ", new target is " + currentVitalityTarget)
    if abs(lastVitalityTarget - currentVitalityTarget) >= 20.0
        SendEvent_ForceAttributeMeterDisplay()
    endif

    ; Update the indicator
    SeedDebug(1, "[" + debugSystemName + "]: Setting target indicator to " + (currentVitalityTarget / 160.0))
    SendEvent_UpdateMeterIndicator(currentVitalityTarget / 160.0)
endFunction

;/
; Overrides _Seed_AttributeSystem
function IncreaseAttribute(float amount, float target = -1.0)
    if target == -1.0
        target = ATTR_MAX
    endif

    float currentAttributeValue = attributeValueGlobal.GetValue()
    ;Reset attribute if over maximum
	if currentAttributeValue + amount >= ATTR_MAX						   
		attributeValueGlobal.SetValue(ATTR_MAX)
	; If attribute is currently above target, do nothing
	elseif currentAttributeValue >= target
		SeedDebug(0, "[" + debugSystemName + "]: Attribute already higher than target, not increasing further.")
        return
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

; Overrides _Seed_AttributeSystem
function DecreaseAttribute(float amount, float target = -1.0)
    if target == -1.0
        target = ATTR_MIN
    endif

    float currentAttributeValue = attributeValueGlobal.GetValue()
	
	;Reset attribute if under minimum
	if currentAttributeValue - amount <= ATTR_MIN
		attributeValueGlobal.SetValue(ATTR_MIN)
	; If attribute is currently below target, do nothing
	elseif currentAttributeValue <= target
		SeedDebug(0, "[" + debugSystemName + "]: Attribute already lower than target, not decreasing further.")
		return
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
/;

float function GetHungerTargetMod()
	if GetHungerSystem().isRunning() == false
		return 0.0
	endif

    int hungerLevel = GetPlayerHungerLevel()
	float result = 0.0
    if hungerLevel <= 0
        result = 0.0
    elseif hungerLevel == 1
        result = -20.0
    elseif hungerLevel == 2
        result = -60.0
    elseif hungerLevel == 3
        result = -95.0
    elseif hungerLevel == 4
        result = -130.0
    elseif hungerLevel >= 5
        result = -160.0
    endif
	
	return result
endFunction

float function GetThirstTargetMod()
	if GetThirstSystem().isRunning() == false
		return 0.0
	endif
		
	int thirstLevel = GetPlayerThirstLevel()
	float result = 0.0
	
    if thirstLevel <= 0
        result = 0.0
    elseif thirstLevel == 1
        result = -20.0
    elseif thirstLevel == 2
        result = -60.0
    elseif thirstLevel == 3
        result = -95.0
    elseif thirstLevel == 4
        result = -130.0
    elseif thirstLevel >= 5
        result = -160.0
    endif
	
	return result
endFunction

float function GetFatigueTargetMod()
	if GetFatigueSystem().isRunning() == false
		return 0.0
	endif
	int fatigueLevel = GetPlayerfatigueLevel()
	float result = 0.0
	if fatigueLevel <= 0
		result = 0.0
	elseif fatigueLevel == 1
		result = -20.0
	elseif fatigueLevel == 2
		result = -60.0
	elseif fatigueLevel == 3
		result = -95.0
	elseif fatigueLevel == 4
		result = -130.0
	elseif fatigueLevel >= 5
		result = -160.0
	endif
	return result
endFunction


float function GetExposureTargetMod()
    _Seed_Compatibility compatibility = SeedUtil.GetCompatibilitySystem()
	
	int exposureLevel = -1
	
	if compatibility.isFrostfallLoaded
        exposureLevel = GetPlayerExposureLevel()
	elseif compatibility.isFrozenNorthLoaded
		exposureLevel = compatibility.GetPlayerExposureLevelFrozenNorth()
		If exposureLevel == 2
			ExposureLevel = 1
		Endif
	endif

    if exposureLevel <= 1
        return 0.0
    elseif exposureLevel == 2
        return -20.0
    elseif exposureLevel == 3
        return -50.0
    elseif exposureLevel == 4
        return -80.0
    elseif exposureLevel >= 5
        return -110.0
    endif
endFunction

float function GetAlcoholTargetMod()
    int alcoholLevel = GetPlayerAlcoholLevel()
	float result = 0.0
    if alcoholLevel == 3
        result = -20.0
    elseif alcoholLevel == 4
        result = -40.0
    endif
	if _Seed_IsHungover.GetValue() == 2
		result = result - 40
	endif
		
	return result
endFunction

float function GetSkoomaTargetMod()
    int skoomaLevel = GetPlayerSkoomaLevel()
	float result = 0.0
	if skoomaLevel == 2
        result = -20.0
    elseif skoomaLevel == 3
        result = -50.0
    elseif skoomaLevel == 4
        result = -80.0
    endif
	return result
endFunction

float function GetBathingTargetMod()
    _Seed_Compatibility compatibility = SeedUtil.GetCompatibilitySystem()
 	
	float result = 0.0
   
	;KEEP IT CLEAN
	if compatibility.isKeepItCleanLoaded
		MagicEffect SBAlchResistDisease = Game.GetFormFromFile(0x0005B831, "Keep It Clean.esp") as MagicEffect
		MagicEffect SBBathNotSoDirtyMGEF = Game.GetFormFromFile(0x000FBDBA, "Keep It Clean.esp") as MagicEffect
		MagicEffect SBAlchDamageSpeechCraftLookDirty = Game.GetFormFromFile(0x000FBDB6, "Keep It Clean.esp") as MagicEffect
		MagicEffect SBAlchDamageSpeechCraftLookVeryDirty = Game.GetFormFromFile(0x001564EE, "Keep It Clean.esp") as MagicEffect
		if SBAlchResistDisease && SBBathNotSoDirtyMGEF && SBAlchDamageSpeechCraftLookDirty && SBAlchDamageSpeechCraftLookVeryDirty
			if PlayerRef.HasMagicEffect(SBAlchResistDisease)
				result = 10.0
			elseif PlayerRef.HasMagicEffect(SBAlchDamageSpeechCraftLookDirty)
				result = -10.0
			elseif PlayerRef.HasMagicEffect(SBAlchDamageSpeechCraftLookVeryDirty)
				result = -20.0
			endif
		endif
		return result	
	;BATHING IN SKYRIM
	elseif compatibility.isBathingInSkyrimLoaded
		GlobalVariable mzinDirtinessThresholdTier1 = Game.GetFormFromFile(0x00000DAA, "Bathing in Skyrim - Main.esp") as GlobalVariable
		GlobalVariable mzinDirtinessThresholdTier2 = Game.GetFormFromFile(0x00000DAB, "Bathing in Skyrim - Main.esp") as GlobalVariable
		GlobalVariable mzinDirtinessThresholdTier3 = Game.GetFormFromFile(0x00000DAC, "Bathing in Skyrim - Main.esp") as GlobalVariable
		GlobalVariable mzinDirtinessPercentage = Game.GetFormFromFile(0x00000DA8, "Bathing in Skyrim - Main.esp") as GlobalVariable
		
		if mzinDirtinessThresholdTier1 && mzinDirtinessThresholdTier2 && mzinDirtinessThresholdTier3 && mzinDirtinessPercentage
			if mzinDirtinessPercentage.GetValue() <= mzinDirtinessThresholdTier1.GetValue()
				result = 10.0
			elseif mzinDirtinessPercentage.GetValue() > mzinDirtinessThresholdTier2.GetValue()
				result = -10.0
			elseif mzinDirtinessPercentage.GetValue() > mzinDirtinessThresholdTier3.GetValue()
				result = -20.0
			endif
		endif
	;DIRT AND BLOOD
	elseif compatibility.isDirtAndBloodLoaded
		MagicEffect Dirty_Effect_Clean = Game.GetFormFromFile(0x02000813, "Dirt and Blood - Dynamic Visuals.esp") as MagicEffect
		MagicEffect Dirty_Effect_Dirt3 = Game.GetFormFromFile(0x0200080F, "Dirt and Blood - Dynamic Visuals.esp") as MagicEffect
		MagicEffect Dirty_Effect_Dirt4 = Game.GetFormFromFile(0x0200083B, "Dirt and Blood - Dynamic Visuals.esp") as MagicEffect
		if Dirty_Effect_Clean && Dirty_Effect_Dirt3 && Dirty_Effect_Dirt4
			if PlayerRef.HasMagicEffect(Dirty_Effect_Clean)
				result = 10.0
			elseif PlayerRef.HasMagicEffect(Dirty_Effect_Dirt3)
				result = -10.0
			elseif PlayerRef.HasMagicEffect(Dirty_Effect_Dirt4)
				result = -20.0
			endif
		endif
	endif
	
	return result
endFunction

; Overrides _Seed_AttributeSystem
function DisplayCurrentStatus()
    float currentAttributeValue = attributeValueGlobal.GetValue()

    if IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_1, ATTR_MIN)
        attributeMessages[0].Show()
    
    elseif IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_2, ATTR_LEVEL_1)
        attributeMessages[1].Show()
    
    elseif IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_3, ATTR_LEVEL_2)
        attributeMessages[2].Show()
    
    elseif IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_4, ATTR_LEVEL_3)
        attributeMessages[3].Show()
    
    elseif IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_5, ATTR_LEVEL_4)
        attributeMessages[4].Show()
    
    elseif IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_6, ATTR_LEVEL_5)
        attributeMessages[5].Show()

    elseif IsUpToAndBetween(currentAttributeValue, ATTR_LEVEL_7, ATTR_LEVEL_6)
        attributeMessages[6].Show()

    elseif IsUpToAndBetween(currentAttributeValue, ATTR_MAX, ATTR_LEVEL_7)
        attributeMessages[7].Show()
    endif

    SendEvent_ForceAttributeMeterDisplay()
endFunction

function update_4_0()
	DEATH_COUNTER_MAX = 2
endFunction

;@NOFALLBACK
function SendEvent_UpdateMeterIndicator(float percent)
    if GetSKSELoaded()
        int handle = ModEvent.Create("LastSeed_UpdateVitalityMeterIndicator")
        if handle
            ModEvent.PushFloat(handle, percent)
            ModEvent.Send(handle)
        endif
    endif
endFunction

function SendEvent_OnRescuePlayer(bool in_water)
	FallbackEventEmitter emitter = seedUtil.GetEventEmitter_OnRescuePlayer()
	int handle = emitter.Create("Seed_OnRescuePlayer")
	if handle
		emitter.PushBool(handle, in_water)
		emitter.Send(handle)
	endif
endFunction