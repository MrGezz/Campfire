scriptname _Seed_ThirstSystem extends _Seed_AttributeSystem
;/
REFERENCED IN: 
_Seed_ThirstSystemQuest "Thirst System" [QUST:070029D5] \ Scripts
/;

import CampUtil 
import _SeedInternal
import SeedUtil

Spell property _Seed_ThirstSpell1 auto
Spell property _Seed_ThirstSpell2 auto
Spell property _Seed_ThirstSpell3 auto
Spell property _Seed_ThirstSpell4 auto
Spell property _Seed_ThirstSpell5 auto
Spell property _Seed_ThirstSpell6 auto

Message property _Seed_ThirstLevel1Msg auto
Message property _Seed_ThirstLevel2Msg auto
Message property _Seed_ThirstLevel3Msg auto
Message property _Seed_ThirstLevel4Msg auto
Message property _Seed_ThirstLevel5Msg auto
Message property _Seed_ThirstLevel6Msg auto

Sound property ThirstSound3_M auto
Sound property ThirstSound4_M auto
Sound property ThirstSound5_M auto
Sound property ThirstSound6_M auto
Sound property ThirstSound3_F auto
Sound property ThirstSound4_F auto
Sound property ThirstSound5_F auto
Sound property ThirstSound6_F auto

ImageSpaceModifier property ThirstISM5 auto
ImageSpaceModifier property ThirstISM6 auto

FormList property AutoDrank auto

Quest property _Seed_ThirstMeterQuest auto

GlobalVariable property _Seed_Setting_AutoConsume auto
GlobalVariable property _Seed_Setting_Notifications_Followers auto
GlobalVariable property _Seed_Setting_HungerMeterDisplayMode auto
GlobalVariable property _Seed_IsHungover auto
GlobalVariable property _Seed_Setting_NeedsAffectedByRegeneration auto
GlobalVariable property _Seed_DiseaseNeedsMulti_SwampFever auto

float REGEN_THIRST_RATE = 0.25
float lastStamina = 0.0

;
; Events
;
function StartUp()
    debugSystemName = "Thirst"
    meterUpdateEvent = "LastSeed_UpdateThirstMeter"
    meterForceEvent = "LastSeed_ForceThirstMeterDisplay"

    ; Initialize arrays
    attributeSpells = new Spell[6]
    attributeMessages = new Message[6]
    attributeSoundsM = new Sound[6]
    attributeSoundsF = new Sound[6]
    attributeISMs = new ImageSpaceModifier[6]
	;followerMessages = new String[6]

    ; Populate arrays
    attributeSpells[0] = _Seed_ThirstSpell1
    attributeSpells[1] = _Seed_ThirstSpell2
    attributeSpells[2] = _Seed_ThirstSpell3
    attributeSpells[3] = _Seed_ThirstSpell4
    attributeSpells[4] = _Seed_ThirstSpell5
    attributeSpells[5] = _Seed_ThirstSpell6

    attributeMessages[0] = _Seed_ThirstLevel1Msg
    attributeMessages[1] = _Seed_ThirstLevel2Msg
    attributeMessages[2] = _Seed_ThirstLevel3Msg
    attributeMessages[3] = _Seed_ThirstLevel4Msg
    attributeMessages[4] = _Seed_ThirstLevel5Msg
    attributeMessages[5] = _Seed_ThirstLevel6Msg

    attributeSoundsM[2] = ThirstSound3_M
    attributeSoundsM[3] = ThirstSound4_M
    attributeSoundsM[4] = ThirstSound5_M
    attributeSoundsM[5] = ThirstSound6_M
	
	attributeSoundsF[2] = ThirstSound3_F
    attributeSoundsF[3] = ThirstSound4_F
    attributeSoundsF[4] = ThirstSound5_F
    attributeSoundsF[5] = ThirstSound6_F
	
    RegisterForEvents()

    ; Apply initial condition.
    IncreaseAttribute(0.01)
endFunction


function RegisterForEvents()
    if !self.IsRunning()
        return
    endif

endFunction

; @override
String Function getFollowerMessage(int i)
	return GetTranslationHandler().GetFollowerThirstMessage(i)
endFunction

; @override
function ApplyAttributeLevel(int level, bool isIncreasing, bool forceMeter = false, bool flashMeter = false, int rumbleLevel = 0, bool lowerIsWorse = false, bool bypassVitalityTargetUpdate = false)
	; Apply Level
	parent.ApplyAttributeLevel(level, isIncreasing, forceMeter, flashMeter, rumbleLevel, lowerIsWorse, bypassVitalityTargetUpdate)
	
	; AutoDrink
	if isIncreasing && level > 1
		if(isPlayer())
			GetConsumeManager().Player_AutoDrink()
		else
			;GetConsumeManager().NPC_AutoDrink(self)
			GetConsumeManagerFollowers().NPC_AutoDrink(followerIndex)
		endif
	; Increase Experience
	elseif level == 0
		GetSkillTreeHandler().progressExperience()
	endif
endFunction

; Impact the player's thirst if the player is regenerating Stamina.
Event OnUpdate()
    if self.IsRunning() && _Seed_Setting_NeedsAffectedByRegeneration.getValueInt() == 2
		bool regenerating = false
		float thisStamina = lastStamina
		if getActor()
			thisStamina = getActor().GetActorValue("Stamina")
			if thisStamina > lastStamina
				regenerating = true
			endif
		endif
		if regenerating
			updateAttributeRegenerating(REGEN_THIRST_RATE, _Seed_Setting_HungerMeterDisplayMode)
			RegisterForSingleUpdate(2)
		else
			RegisterForSingleUpdate(5)
		endif
		lastStamina = thisStamina
	endif
EndEvent

function ChangeAttributeOverTime(bool suspendWhileSleeping = false, bool forceUpdate = false)
	parent.ChangeAttributeOverTime(suspendWhileSleeping, forceUpdate)
endFunction


function showAttributeMessage(int level)
	if isPlayer()
		if _Seed_Setting_Notifications.GetValueInt() == 2
			if _Seed_Setting_AutoConsume.GetValue() == 2
				GetConsumeManager().EnqueuePlayerThirstMessage(attributeMessages[level])
			else
				SeedDebug(0, "[" + debugSystemName + "]: Showing message.")
				attributeMessages[level].Show()
			endif
		endif
	elseif getFollowerMessage(level)
		if _Seed_Setting_Notifications_Followers.getValueInt() == 2
			string name = "One of Your followers"
			if GetSKSELoaded()
				name = getActor().GetBaseObject().GetName()
			else
				if followerIndex == 3
					name = "Your third follower"
				elseif followerIndex == 2
					name = "Your second follower"
				elseif followerIndex == 1	
					name = "Your first follower"
				endif
			endif
			;Debug.Notification(name + followerMessages[level])
			GetConsumeManagerFollowers().EnqueueFollowerThirstMessage(name + getFollowerMessage(level), followerIndex)
		endIf	
	endIf
endFunction

function StartSystem()
	parent.StartSystem()
endFunction

function StopSystem()
	parent.StopSystem()
endFunction

;@Override Function
function enqueueSound(sound thisSound)
	GetConsumeManager().EnqueuePlayerThirstSound(thisSound)
endFunction

;@Override Function
float function GetAttributeMulti()
	float result = 1
	
	;Swamp Fever Multiplier
	result = result + _Seed_DiseaseNeedsMulti_SwampFever.getValue()
	
	if _Seed_IsHungover.GetValue() == 2
		result = result + 0.25
	Endif
	
	result = result * attributeRateMultiGlobal.getValue()
	result = result * getCarriageRideMulti()
	
	SeedDebug(1, "[" + debugSystemName + "]: Attribute Multiplier: " + result)
	return result
EndFunction

