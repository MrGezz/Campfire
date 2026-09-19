scriptname _Seed_CheckNeeds extends ActiveMagicEffect
;/
REFERENCED IN: 
_Seed_CheckNeedsSpell "Well Being" [SPEL:070102BF] \ Scripts
_Seed_CheckNeedsEffect \ Scripts TODO: Find the actual location
/;
import SeedUtil
import CampUtil

Actor property PlayerRef auto
GlobalVariable property _Seed_Setting_FrostfallNotifications auto

Message Property _Seed_DirtAndBlood_Blood1 auto
Message Property _Seed_DirtAndBlood_Blood2 auto
Message Property _Seed_DirtAndBlood_Blood3 auto
Message Property _Seed_DirtAndBlood_Blood4 auto
Message Property _Seed_DirtAndBlood_Clean auto
Message Property _Seed_DirtAndBlood_Dirt1 auto
Message Property _Seed_DirtAndBlood_Dirt2 auto
Message Property _Seed_DirtAndBlood_Dirt3 auto
Message Property _Seed_DirtAndBlood_Dirt4 auto

Message Property _Seed_FrozenNorthMsg1 auto
Message Property _Seed_FrozenNorthMsg2 auto
Message Property _Seed_FrozenNorthMsg3 auto
Message Property _Seed_FrozenNorthMsg4 auto
Message Property _Seed_FrozenNorthMsg5 auto


Event OnEffectStart(Actor akTarget, Actor akCaster)	
	Message dirtyMsg = none
	Message bloodyMsg = none
	if SeedUtil.GetCompatibilitySystem().isKeepItCleanLoaded
		dirtyMsg = getKeepItCleanMessage()
	elseif SeedUtil.GetCompatibilitySystem().isBathingInSkyrimLoaded
		dirtyMsg = getBathingInSkyrimMessage()
	elseif SeedUtil.GetCompatibilitySystem().isDirtAndBloodLoaded
		dirtyMsg = getDirtAndBloodMessage_dirty()
		bloodyMsg = getDirtAndBloodMessage_bloody()
	endif
	
	if _Seed_Setting_FrostfallNotifications.GetValueInt() == 2 && SeedUtil.GetCompatibilitySystem().isFrostfallLoaded
		Spell _Frost_Weathersense_Spell = Game.GetFormFromFile(0x00016215, "Frostfall.esp") as Spell
		if _Frost_Weathersense_Spell
			_Frost_Weathersense_Spell.cast(PlayerRef)
			utility.wait(1)
		endif
	elseif seedUtil.getCompatibilitySystem().isFrozenNorthLoaded
		showFrozenNorthMessage()	
	endif
	
	if dirtyMsg
		dirtyMsg.Show()
	endif
	if bloodyMsg
		bloodyMsg.Show()
	endif
	
	bool IsPlayerFocused = IsPlayerFocused()
	_Seed_HungerSystem hunger = GetHungerSystem()
	_Seed_ThirstSystem thirst = GetThirstSystem()
	_Seed_FatigueSystem fatigue = GetFatigueSystem()
	_Seed_VitalitySystem vitality = GetVitalitySystem()
	
	GetAlcoholSystem().DisplayCurrentStatus()
	if hunger.isRunning()
		;Hunger.ChangeAttributeOverTimeIfFocussed()
		hunger.DisplayCurrentStatus()
	endif
	if GetThirstSystem().isRunning()
		;thirst.ChangeAttributeOverTimeIfFocussed()
		thirst.DisplayCurrentStatus()
	endif
	if fatigue.isRunning()
		;fatigue.ChangeAttributeOverTimeIfFocussed(true)
		fatigue.DisplayCurrentStatus()
	endif
	if vitality.isRunning()
		vitality.DisplayCurrentStatus()
	endif
	
	
	;Follower Needs
	;/
	if(GetTrackedFollower(1))
		if GetFollowerSystem().getHungerSystem(1).isRunning()		
			GetFollowerSystem().getHungerSystem(1).DisplayCurrentStatus()
		endif
		if GetFollowerSystem().getThirstSystem(1).isRunning()
			GetFollowerSystem().getThirstSystem(1).DisplayCurrentStatus()
		endif
	endif
	if(GetTrackedFollower(2))
		if GetFollowerSystem().getHungerSystem(2).isRunning()
			GetFollowerSystem().getHungerSystem(2).DisplayCurrentStatus()
		endif
		if GetFollowerSystem().getThirstSystem(2).isRunning()
			GetFollowerSystem().getThirstSystem(2).DisplayCurrentStatus()
		endif
	endif
	if(GetTrackedFollower(3))
		if GetFollowerSystem().getHungerSystem(3).isRunning()
			GetFollowerSystem().getHungerSystem(3).DisplayCurrentStatus()
		endif
		if GetFollowerSystem().getThirstSystem(3).isRunning()
			GetFollowerSystem().getThirstSystem(3).DisplayCurrentStatus()
		endif	
	endif
	/;
	
	;Party Needs
	if getTrackedPartyCount() > 0
		_Seed_HungerSystem_Party HungerParty = getPartyHungerSystem()
		_Seed_ThirstSystem_Party ThirstParty = getPartyThirstSystem()
		if HungerParty.isRunning()
			if GetConsumeManagerParty().getAutoEating() || GetConsumeManagerParty().getAutoFeeding()
				ShowPartyEatingMessage()
			else
				HungerParty.ChangeAttributeOverTimeIfFocussed()
				HungerParty.DisplayCurrentStatus()
			endif
		endif
		if ThirstParty.isRunning()
			if GetConsumeManagerParty().getAutoDrinking() || GetConsumeManagerParty().getAutoFeeding()
				ShowPartyDrinkingMessage()
			else
				ThirstParty.ChangeAttributeOverTimeIfFocussed()
				ThirstParty.DisplayCurrentStatus()
			endif
		endif
	endif
EndEvent

string function ShowPartyEatingMessage()
	if GetSKSELoaded() && GetFollowerSystem().getPartyCount() == 1
		string name = ""
		if getTrackedFollower(1)
			name = getTrackedFollower(1).GetBaseObject().GetName()
		elseif getTrackedFollower(2)
			name = getTrackedFollower(2).GetBaseObject().GetName()
		elseif getTrackedFollower(3)
			name = getTrackedFollower(3).GetBaseObject().GetName()
		else
			debug.notification(GetTranslationHandler().Party + getTranslationHandler().PartyEating)
		endif
		debug.notification(name + getTranslationHandler().Eating)
	else
		debug.notification(GetTranslationHandler().Party + getTranslationHandler().PartyEating)
	endIf				
endFunction

string function ShowPartyDrinkingMessage()
	if GetSKSELoaded() && GetFollowerSystem().getPartyCount() == 1
		string name = ""
		if getTrackedFollower(1)
			name = getTrackedFollower(1).GetBaseObject().GetName()
		elseif getTrackedFollower(2)
			name = getTrackedFollower(2).GetBaseObject().GetName()
		elseif getTrackedFollower(3)
			name = getTrackedFollower(3).GetBaseObject().GetName()
		else
			debug.notification(GetTranslationHandler().Party + getTranslationHandler().PartyDrinking)
		endif
		debug.notification(name + getTranslationHandler().Drinking)
	else
		debug.notification(GetTranslationHandler().Party + getTranslationHandler().PartyDrinking)
	endIf				
endFunction

Message function getBathingInSkyrimMessage()
	GlobalVariable mzinDirtinessThresholdTier1 = Game.GetFormFromFile(0x00000DAA, "Bathing in Skyrim - Main.esp") as GlobalVariable
	GlobalVariable mzinDirtinessThresholdTier2 = Game.GetFormFromFile(0x00000DAB, "Bathing in Skyrim - Main.esp") as GlobalVariable
	GlobalVariable mzinDirtinessThresholdTier3 = Game.GetFormFromFile(0x00000DAC, "Bathing in Skyrim - Main.esp") as GlobalVariable
	GlobalVariable mzinDirtinessPercentage = Game.GetFormFromFile(0x00000DA8, "Bathing in Skyrim - Main.esp") as GlobalVariable
	
	
	if mzinDirtinessThresholdTier1 && mzinDirtinessThresholdTier2 && mzinDirtinessThresholdTier3 && mzinDirtinessPercentage
		if mzinDirtinessPercentage.GetValue() <= mzinDirtinessThresholdTier1.GetValue()
			return Game.GetFormFromFile(0x00000D9D, "Bathing in Skyrim - Main.esp") as Message ; mzinDirtyEnterTier0Message
		elseif mzinDirtinessPercentage.GetValue() > mzinDirtinessThresholdTier1.GetValue()
			return Game.GetFormFromFile(0x00000D9E, "Bathing in Skyrim - Main.esp") as Message ; mzinDirtyEnterTier1Message
		elseif mzinDirtinessPercentage.GetValue() > mzinDirtinessThresholdTier2.GetValue()
			return Game.GetFormFromFile(0x00000D9F, "Bathing in Skyrim - Main.esp") as Message ; mzinDirtyEnterTier2Message
		elseif mzinDirtinessPercentage.GetValue() > mzinDirtinessThresholdTier3.GetValue()
			return 	Game.GetFormFromFile(0x00000DA0, "Bathing in Skyrim - Main.esp") as Message ; mzinDirtyEnterTier3Message
		endif
	endif
endFunction

Message function getKeepItCleanMessage()
	Actor Player = game.getPlayer()
	
	MagicEffect SBBathNotSoDirtyMGEF = Game.GetFormFromFile(0x000FBDBA, "Keep It Clean.esp") as MagicEffect
	MagicEffect SBAlchDamageSpeechCraftLookDirty = Game.GetFormFromFile(0x000FBDB6, "Keep It Clean.esp") as MagicEffect
	MagicEffect SBAlchDamageSpeechCraftLookVeryDirty = Game.GetFormFromFile(0x001564EE, "Keep It Clean.esp") as MagicEffect
	
	Message SBBATHStatusNotSoDirtyMsg = Game.GetFormFromFile(0x001981FD, "Keep It Clean.esp") as Message
	Message SBBATHStatusDirtyMsg = Game.GetFormFromFile(0x001981FE, "Keep It Clean.esp") as Message
	Message SBBATHStatusVeryDirtyMsg = Game.GetFormFromFile(0x001981FF, "Keep It Clean.esp") as Message
	Message SBBATHStatusCleanMsg = Game.GetFormFromFile(0x001981FC, "Keep It Clean.esp") as Message
	
	if Player.HasMagicEffect(SBBathNotSoDirtyMGEF)
  		return SBBATHStatusNotSoDirtyMsg
	elseif Player.HasMagicEffect(SBAlchDamageSpeechCraftLookDirty)
		return SBBATHStatusDirtyMsg
	elseif Player.HasMagicEffect(SBAlchDamageSpeechCraftLookVeryDirty)
		return SBBATHStatusVeryDirtyMsg
	else
		return SBBATHStatusCleanMsg
	endIf
endFunction

Message function getDirtAndBloodMessage_dirty()
	Actor Player = game.getPlayer()
	MagicEffect Dirty_Effect_Clean = Game.GetFormFromFile(0x00000813, "Dirt and Blood - Dynamic Visuals.esp") as MagicEffect
	MagicEffect Dirty_Effect_Dirt1 = Game.GetFormFromFile(0x0000080D, "Dirt and Blood - Dynamic Visuals.esp") as MagicEffect
	MagicEffect Dirty_Effect_Dirt2 = Game.GetFormFromFile(0x0000080E, "Dirt and Blood - Dynamic Visuals.esp") as MagicEffect
	MagicEffect Dirty_Effect_Dirt3 = Game.GetFormFromFile(0x0000080F, "Dirt and Blood - Dynamic Visuals.esp") as MagicEffect
	MagicEffect Dirty_Effect_Dirt4 = Game.GetFormFromFile(0x0000083B, "Dirt and Blood - Dynamic Visuals.esp") as MagicEffect


	if Player.HasMagicEffect(Dirty_Effect_Clean)
  		return _Seed_DirtAndBlood_Clean
	elseif Player.HasMagicEffect(Dirty_Effect_Dirt1)
		return _Seed_DirtAndBlood_Dirt1
	elseif Player.HasMagicEffect(Dirty_Effect_Dirt2)
		return _Seed_DirtAndBlood_Dirt2
	elseif Player.HasMagicEffect(Dirty_Effect_Dirt3)
		return _Seed_DirtAndBlood_Dirt3
	elseif Player.HasMagicEffect(Dirty_Effect_Dirt4)
		return _Seed_DirtAndBlood_Dirt4
	Endif
	
	return none
endFunction

Message function getDirtAndBloodMessage_bloody()
	Actor Player = game.getPlayer()
	MagicEffect Dirty_Effect_Blood1 = Game.GetFormFromFile(0x00000810, "Dirt and Blood - Dynamic Visuals.esp") as MagicEffect
	MagicEffect Dirty_Effect_Blood2 = Game.GetFormFromFile(0x00000811, "Dirt and Blood - Dynamic Visuals.esp") as MagicEffect
	MagicEffect Dirty_Effect_Blood3 = Game.GetFormFromFile(0x00000812, "Dirt and Blood - Dynamic Visuals.esp") as MagicEffect
	MagicEffect Dirty_Effect_Blood4 = Game.GetFormFromFile(0x0000083A, "Dirt and Blood - Dynamic Visuals.esp") as MagicEffect

	if Player.HasMagicEffect(Dirty_Effect_Blood1)
		return _Seed_DirtAndBlood_Blood1
	elseif Player.HasMagicEffect(Dirty_Effect_Blood2)
		return _Seed_DirtAndBlood_Blood2
	elseif Player.HasMagicEffect(Dirty_Effect_Blood3)
		return _Seed_DirtAndBlood_Blood3
	elseif Player.HasMagicEffect(Dirty_Effect_Blood4)
		return _Seed_DirtAndBlood_Blood4
	endif
	
	return none
endFunction

Function showFrozenNorthMessage()
	int exposureLevel = seedUtil.getCompatibilitySystem().GetPlayerExposureLevelFrozenNorth()
	if(exposureLevel == 1)
		_Seed_FrozenNorthMsg1.show()
	elseif(exposureLevel == 2)
		_Seed_FrozenNorthMsg2.show()
	elseif(exposureLevel == 3)
		_Seed_FrozenNorthMsg3.show()
	elseif(exposureLevel == 4)
		_Seed_FrozenNorthMsg4.show()
	elseif(exposureLevel == 5)
		_Seed_FrozenNorthMsg5.show()
	endif
endFunction
