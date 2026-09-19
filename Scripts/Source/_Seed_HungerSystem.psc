scriptname _Seed_HungerSystem extends _Seed_AttributeSystem

import CampUtil 
import _SeedInternal
import SeedUtil

Spell property HungerSpell1 auto
Spell property HungerSpell2 auto
Spell property HungerSpell3 auto
Spell property HungerSpell4 auto
Spell property HungerSpell5 auto
Spell property HungerSpell6 auto

Message property HungerMessage1 auto
Message property HungerMessage2 auto
Message property HungerMessage3 auto
Message property HungerMessage4 auto
Message property HungerMessage5 auto
Message property HungerMessage6 auto

Sound property HungerSound3 auto
Sound property HungerSound4 auto
Sound property HungerSound5 auto
Sound property HungerSound6 auto

ImageSpaceModifier property HungerISM5 auto
ImageSpaceModifier property HungerISM6 auto

Quest property _Seed_HungerMeterQuest auto

FormList property recentlyEatenFood auto
FormList property AutoEatenFood auto

float REGEN_HUNGER_RATE = 0.50
float lastHealth = 0.0

GlobalVariable property _Seed_Setting_AutoConsume auto
GlobalVariable property _Seed_Setting_Notifications_Followers auto
GlobalVariable property _Seed_Setting_HungerMeterDisplayMode auto
GlobalVariable property _Seed_Setting_NeedsAffectedByRegeneration auto
GlobalVariable property _Seed_DiseaseNeedsMulti_StomachRot auto

function StartUp()
    debugSystemName = "Hunger"
    meterUpdateEvent = "LastSeed_UpdateHungerMeter"
    meterForceEvent = "LastSeed_ForceHungerMeterDisplay"

    ; Initialize arrays
    attributeSpells = new Spell[6]
    attributeMessages = new Message[6]
    attributeSoundsM = new Sound[6]
    attributeSoundsF = new Sound[6]
    attributeISMs = new ImageSpaceModifier[6]

    ; Populate arrays
    attributeSpells[0] = HungerSpell1
    attributeSpells[1] = HungerSpell2
    attributeSpells[2] = HungerSpell3
    attributeSpells[3] = HungerSpell4
    attributeSpells[4] = HungerSpell5
    attributeSpells[5] = HungerSpell6

    attributeMessages[0] = HungerMessage1
    attributeMessages[1] = HungerMessage2
    attributeMessages[2] = HungerMessage3
    attributeMessages[3] = HungerMessage4
    attributeMessages[4] = HungerMessage5
    attributeMessages[5] = HungerMessage6


    attributeSoundsM[2] = HungerSound3
    attributeSoundsM[3] = HungerSound4
    attributeSoundsM[4] = HungerSound5
    attributeSoundsM[5] = HungerSound6   
	
	attributeSoundsF[2] = HungerSound3
    attributeSoundsF[3] = HungerSound4
    attributeSoundsF[4] = HungerSound5
    attributeSoundsF[5] = HungerSound6

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
	return GetTranslationHandler().GetFollowerHungerMessage(i)
endFunction

; @override
function ApplyAttributeLevel(int level, bool isIncreasing, bool forceMeter = false, bool flashMeter = false, int rumbleLevel = 0, bool lowerIsWorse = false, bool bypassVitalityTargetUpdate = false)	
	; Apply Level
	parent.ApplyAttributeLevel(level, isIncreasing, forceMeter, flashMeter, rumbleLevel, lowerIsWorse, bypassVitalityTargetUpdate)
	
	; AutoEat
	if isIncreasing && level > 1
		if(isPlayer())
			GetConsumeManager().Player_AutoEat()
		else
			;GetConsumeManager().NPC_AutoEat(self)
			GetConsumeManagerFollowers().NPC_AutoEat(followerIndex)
		endif
	; Increase Experience
	elseif level == 0		
		GetSkillTreeHandler().progressExperience()
	endif
endFunction

function ChangeAttributeOverTime(bool suspendWhileSleeping = false, bool forceUpdate = false)
	parent.ChangeAttributeOverTime(suspendWhileSleeping, forceUpdate)
	
	; Every update, clear the recently eaten food list.
	recentlyEatenFood.Revert()
	SeedDebug(0, "Cleared the recently eaten food list.")
endFunction

;
; Actions
;

; Impact the player's hunger if the player is regenerating health.
Event OnUpdate()
    if self.IsRunning() && _Seed_Setting_NeedsAffectedByRegeneration.getValueInt() == 2
		bool regenerating = false
		float thisHealth = lastHealth
		if getActor()
			thisHealth = getActor().GetActorValue("Health")
			if thisHealth > lastHealth
				regenerating = true
			endif
		endif
	
		if regenerating
			updateAttributeRegenerating(REGEN_HUNGER_RATE, _Seed_Setting_HungerMeterDisplayMode)
			RegisterForSingleUpdate(2)
		else
			RegisterForSingleUpdate(5)
		endif
		lastHealth = thisHealth
	endIf
EndEvent

function showAttributeMessage(int level)
	if isPlayer()
		if _Seed_Setting_Notifications.GetValueInt() == 2
			if _Seed_Setting_AutoConsume.GetValue() == 2
				GetConsumeManager().EnqueuePlayerHungerMessage(attributeMessages[level])
			else
				SeedDebug(0, "[" + debugSystemName + "]: Showing message.")
				attributeMessages[level].Show()
			endif
		endif
	elseif getFollowerMessage(level)
		if _Seed_Setting_Notifications_Followers.GetValueInt() == 2
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
			endIf		
			;Debug.Notification(name + followerMessages[level])
			GetConsumeManagerFollowers().EnqueueFollowerHungerMessage(name + getFollowerMessage(level), followerIndex)
		endif
	endIf
endFunction

;@Override Function
function enqueueSound(sound thisSound)
	GetConsumeManager().EnqueuePlayerHungerSound(thisSound)
endFunction

;@Override Function
float function GetAttributeMulti()
	float result = 1
	result = result + _Seed_DiseaseNeedsMulti_StomachRot.getValue()
	result = result * attributeRateMultiGlobal.getValue()
	
	result = result * getCarriageRideMulti()
	
	SeedDebug(1, "[" + debugSystemName + "]: Attribute Multiplier: " + result)
	return result
endFunction