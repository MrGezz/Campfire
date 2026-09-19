scriptname _Seed_AnimationHandler extends Quest

import campUtil
import seedUtil
import _SeedInternal

GlobalVariable property _Seed_Setting_AnimateFollowers auto
GlobalVariable property _Seed_Setting_AnimatePlayer auto
GlobalVariable property _Seed_Setting_AnimatePlayer_FirstPerson auto
GlobalVariable property _Seed_Setting_AnimatePickup auto

Idle Property IdlePickup_Ground Auto
Idle Property IdleStop_Loose Auto
Idle Property ChairEatingStart Auto
Idle Property idleEatingStandingStart Auto
Idle Property ChairDrinkingStart Auto
Idle Property idleDrinkingStandingStart Auto

bool property playerAnimated = false auto hidden
bool property Follower1Animated = false auto hidden
bool property Follower2Animated = false auto hidden
bool property Follower3Animated = false auto hidden

actor property PlayerRef auto

bool function ActorCanAnimate(Actor target)
	if !target
		return false
	endif
	
	;Check Global Variables
	if target == playerRef
		if _Seed_Setting_AnimatePlayer.getValueInt() != 2
			return false
		playerRef.GetAnimationVariableInt("i1stPerson") == 1 && _Seed_Setting_AnimatePlayer_FirstPerson.getValueInt() != 2
			return false
		endif
	elseif _Seed_Setting_AnimateFollowers.getValueInt() != 2
		return false
	endif
	
	; Check Animation Conditions
	if target.IsInCombat()
		return false
	elseif target.IsWeaponDrawn()
		return false
	elseif GetSKSELoaded() && target.IsSwimming()
		return false
	elseif target.IsOnMount()
		return false
	elseif target.GetSleepState() != 0
		return false
	elseif GetMonsterHandler().IsActorTransformed(target)
		return false
	endif
	
	; Return true if all conditons met
	return true
endFunction

function stopAnimation(Actor target, int index)
	SeedDebug(0, "[AnimationManager] Stopping Animation: " + index)
	setAnimated(index, false)
	target.PlayIdle(IdleStop_Loose)	
endFunction

function pickupAnimation(int Index)
	if(_Seed_Setting_AnimatePickup.GetValueInt() == 2)
		if !getAnimated(index)
			Actor target = getActor(index)
			if ActorCanAnimate(target)
				stopAnimation(target, index)
				setAnimated(index, true)
				SeedDebug(0, "[AnimationManager] Playing Pickup Animation")
				target.PlayIdle(IdlePickup_Ground)
				Utility.Wait(3.0)
				if getAnimated(index)
					stopAnimation(target, index)
				endif
			endif
		endif
	endif
endFunction

function eatAnimation(int Index)
	if !getAnimated(index)
		Actor target = getActor(index)
		if ActorCanAnimate(target)
			stopAnimation(target, index)
			setAnimated(index, true)
			SeedDebug(0, "[AnimationManager] Playing Eat Animation")
			If target.GetSitState() == 0
				;Debug.SendAnimationEvent(target, "idleEatingStandingStart")
				target.PlayIdle(idleEatingStandingStart)
				Utility.Wait(7.0)
			ElseIf target.GetSitState() == 3
				Debug.SendAnimationEvent(target, "ChairEatingStart")
				;target.PlayIdle(ChairEatingStart)
				Utility.Wait(7.0)
			endif
			if getAnimated(index)
				stopAnimation(target, index)
			endif
		endif
	endIf
endFunction

function drinkAnimation(int Index)
	if !getAnimated(index)
		Actor target = getActor(index)
		if ActorCanAnimate(target)
			stopAnimation(target, index)
			setAnimated(index, true)
			SeedDebug(0, "[AnimationManager] Playing Drink Animation")
			If target.GetSitState() == 0
				target.PlayIdle(idleDrinkingStandingStart)
				Utility.Wait(7.0)
			ElseIf target.GetSitState() == 3
				target.PlayIdle(ChairDrinkingStart)
				Utility.Wait(7.0)
			endif
			if getAnimated(index)
				stopAnimation(target, index)
			endif
		endif
	endif
endFunction



Actor Function getActor(int index)
	if index == 0
		return PlayerRef
	else
		return GetTrackedFollower(index)
	endif
EndFunction


bool function getAnimated(int index)
	if index == 0
		return playerAnimated
	elseif index == 1
		return Follower1Animated
	elseif index == 2
		return Follower2Animated
	elseif index == 3
		return Follower3Animated
	endif
endFunction

bool function setAnimated(int index, bool value)
	if index == 0
		playerAnimated = value
		if GetSKSELoaded()
			Int moveKey = Input.GetMappedKey("Move")
			Int ActivateKey = Input.GetMappedKey("Activate")
			Int forwardKey = Input.GetMappedKey("Forward")
			Int BackKey = Input.GetMappedKey("Back")
			Int StrafeLeftKey = Input.GetMappedKey("Strafe Left")
			Int StrafeRightKey = Input.GetMappedKey("Strafe Right")
			Int JumpKey = Input.GetMappedKey("Jump")
			Int SneakKey = Input.GetMappedKey("Sneak")
			if value
				Utility.Wait(0.5)
				RegisterForKey(moveKey)
				RegisterForKey(ActivateKey)
				RegisterForKey(forwardKey)
				RegisterForKey(BackKey)
				RegisterForKey(StrafeLeftKey)
				RegisterForKey(StrafeRightKey)
				RegisterForKey(JumpKey)
				RegisterForKey(SneakKey)
			else
				UnregisterForKey(moveKey)
				UnregisterForKey(ActivateKey)
				UnregisterForKey(forwardKey)
				UnregisterForKey(BackKey)
				UnregisterForKey(StrafeLeftKey)
				UnregisterForKey(StrafeRightKey)
				UnregisterForKey(JumpKey)
				UnregisterForKey(SneakKey)
			endif
		endif
	elseif index == 1
		Follower1Animated = value
	elseif index == 2
		Follower2Animated = value
	elseif index == 3
		Follower3Animated = value
	endif
endFunction

Event OnKeyDown(Int KeyCode)
	SeedDebug(0, "[AnimationManager] Stopping Animation because of keypress")
	stopAnimation(playerRef, 0)
EndEvent