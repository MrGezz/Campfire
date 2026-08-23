scriptname _Seed_PlayerEatMonitor extends ReferenceAlias

import CommonArrayHelper
import SeedUtil
import _SeedInternal


Keyword property VendorItemFood auto
Keyword property VendorItemFoodRaw auto
GlobalVariable property _Seed_Setting_DiminishingFoodReturns auto
GlobalVariable property _Seed_RestoreHungerMinorAmount auto
GlobalVariable property _Seed_RestoreHungerMajorAmount auto
GlobalVariable property _Seed_RestoreHungerSuperiorAmount auto
GlobalVariable property _Seed_RestoreHungerMassiveAmount auto
GlobalVariable property _Seed_Setting_DisplayTutorials auto
GlobalVariable property _Seed_HelpDone_Variety auto
FormList property _Seed_Food_RestoreHungerMinor auto
FormList property _Seed_Food_RestoreHungerMajor auto
FormList property _Seed_Food_RestoreHungerSuperior auto
FormList property _Seed_Food_RestoreHungerMassive auto
FormList property _Seed_RecentlyEatenFood auto
Message property _Seed_Help_Variety auto

; Eating and drinking animations (Last Seed 0.2). Vanilla idle records only - no FNIS, no
; behavior files - which is what iNeed does with the same four idles and what Frostfall does
; for hand warming. The forms are looked up instead of bound as properties so that no
; Creation Kit pass is needed to attach them; every one is a Skyrim.esm or LastSeed.esp
; record and the IDs were read from those plugins.
float property CONSUME_ANIMATION_SECONDS = 7.0 autoReadOnly hidden

bool animation_playing = false
bool animation_forms_resolved = false
GlobalVariable _Seed_Setting_Animation
GlobalVariable _Seed_Setting_FollowerAnimation
Idle IdleEatingStandingStart
Idle IdleDrinkingStandingStart
Idle ChairEatingStart
Idle ChairDrinkingStart
Idle IdleStop_Loose
Actor[] animating_followers

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
    Potion theFood = akBaseObject as Potion
    if theFood && (akBaseObject.HasKeyword(VendorItemFood) || akBaseObject.HasKeyword(VendorItemFoodRaw))
   		SeedDebug(0, "Object WAS food.")

   		int foodType = GetFoodType(theFood)
   		if (foodType == 18 || foodType == 19)
   			; Alcoholic and non-alcoholic drinks: no hunger to restore, but still a drink.
   			PlayConsumeAnimation(true)
   			return
   		endif

   		float amountToRestore
   		if _Seed_Food_RestoreHungerMinor.HasForm(akBaseObject)
   			amountToRestore = _Seed_RestoreHungerMinorAmount.GetValue()
   		elseif _Seed_Food_RestoreHungerMajor.HasForm(akBaseObject)
   			amountToRestore = _Seed_RestoreHungerMajorAmount.GetValue()
   		elseif _Seed_Food_RestoreHungerSuperior.HasForm(akBaseObject)
   			amountToRestore = _Seed_RestoreHungerSuperiorAmount.GetValue()
   		elseif _Seed_Food_RestoreHungerMassive.HasForm(akBaseObject)
   			amountToRestore = _Seed_RestoreHungerMassiveAmount.GetValue()
   		else
   			; Allow player to identify food
   		endif

   		if !(foodType == 15)
   			if _Seed_RecentlyEatenFood.HasForm(theFood)
   				SeedDebug(0, "This food was recently eaten.")
   				amountToRestore *= 0.5
   				ShowTutorial_Variety()
   			else
   				SeedDebug(0, "This food was not recently eaten or is soup.")
   				_Seed_RecentlyEatenFood.AddForm(theFood)
   			endif
   		endif

   		SeedDebug(1, "Restoring " + amountToRestore + " hunger.")
   		RestorePlayerHunger(amountToRestore)
   		; Milk (17) is drunk; everything else that restores hunger is eaten.
   		PlayConsumeAnimation(foodType == 17)
    else
    	SeedDebug(0, "Object was not food. Reason: Was Potion " + akBaseObject as Potion + ", HasKeyword(VendorItemFood || VendorItemFoodRaw) " + (akBaseObject.HasKeyword(VendorItemFood) || akBaseObject.HasKeyword(VendorItemFoodRaw)))
    endif
EndEvent

; #ANIMATION=======================================================================================

function ResolveAnimationForms()
	; Skyrim.esm idle records. IdleEatingStandingStart / IdleDrinkingStandingStart are the
	; standing eat and drink loops; ChairEatingStart / ChairDrinkingStart are their seated
	; furniture versions, which play out and return on their own; IdleStop_Loose ends a
	; standing loop (the same record Frostfall uses to end hand warming).
	IdleEatingStandingStart = Game.GetFormFromFile(0x00064100, "Skyrim.esm") as Idle
	IdleDrinkingStandingStart = Game.GetFormFromFile(0x000640FC, "Skyrim.esm") as Idle
	ChairEatingStart = Game.GetFormFromFile(0x00065D06, "Skyrim.esm") as Idle
	ChairDrinkingStart = Game.GetFormFromFile(0x00065D07, "Skyrim.esm") as Idle
	IdleStop_Loose = Game.GetFormFromFile(0x0010D9EE, "Skyrim.esm") as Idle
	; LastSeed.esp globals added in 0.2 (2 = on, 1 = off, like every other _Seed_Setting_).
	_Seed_Setting_Animation = Game.GetFormFromFile(0x0001082E, "LastSeed.esp") as GlobalVariable
	_Seed_Setting_FollowerAnimation = Game.GetFormFromFile(0x0001082F, "LastSeed.esp") as GlobalVariable
	animation_forms_resolved = true
endFunction

bool function CanAnimate(Actor akActor)
	; Never during combat or with a weapon out - Requiem fights are not the place for an
	; eating animation - and never while sneaking, riding, swimming, in a kill move, or dead.
	return !akActor.IsInCombat() && !akActor.IsWeaponDrawn() && !akActor.IsSneaking() && !akActor.IsOnMount() && !akActor.IsSwimming() && !akActor.IsInKillMove() && !akActor.IsDead()
endFunction

function PlayConsumeAnimation(bool abDrink)
	if !animation_forms_resolved
		ResolveAnimationForms()
	endif
	if !_Seed_Setting_Animation || _Seed_Setting_Animation.GetValueInt() != 2 || animation_playing || !IdleStop_Loose
		return
	endif
	Actor player = GetActorReference()
	if !CanAnimate(player)
		return
	endif
	animation_playing = true

	; Food is usually equipped from the inventory menu. Wait() does not return until the
	; menu has closed, so the idle starts in the game world, not behind the menu.
	Utility.Wait(0.1)
	if !CanAnimate(player)
		animation_playing = false
		return
	endif

	Idle standing_idle = IdleEatingStandingStart
	Idle chair_idle = ChairEatingStart
	if abDrink
		standing_idle = IdleDrinkingStandingStart
		chair_idle = ChairDrinkingStart
	endif

	int sit_state = player.GetSitState()
	if sit_state == 3
		; Seated in furniture: the chair idle plays out and returns on its own.
		player.PlayIdle(chair_idle)
		PlayFollowerAnimations(standing_idle)
		Utility.Wait(CONSUME_ANIMATION_SECONDS)
		StopFollowerAnimations()
	elseif sit_state == 0
		bool was_first_person = player.GetAnimationVariableBool("IsFirstPerson")
		if was_first_person
			Game.ForceThirdPerson()
			Utility.Wait(0.5)
		endif
		if player.PlayIdle(standing_idle)
			PlayFollowerAnimations(standing_idle)
			Utility.Wait(CONSUME_ANIMATION_SECONDS)
			StopIdle(player)
			StopFollowerAnimations()
		endif
		if was_first_person
			Utility.Wait(1.0)
			Game.ForceFirstPerson()
		endif
	endif
	; Sit states 1, 2 and 4 are getting into or out of furniture: leave the actor alone.

	animation_playing = false
endFunction

function StopIdle(Actor akActor)
	; PlayIdle can fail while another animation is still finishing; retry as Frostfall does.
	int attempts = 0
	while attempts < 3 && !akActor.PlayIdle(IdleStop_Loose)
		Utility.Wait(1.0)
		attempts += 1
	endWhile
endFunction

function PlayFollowerAnimations(Idle akIdle)
	; Followers eat and drink when the player does - Campfire tracks up to three.
	animating_followers = new Actor[3]
	if !_Seed_Setting_FollowerAnimation || _Seed_Setting_FollowerAnimation.GetValueInt() != 2
		return
	endif
	int i = 1
	while i <= 3
		Actor follower = CampUtil.GetTrackedFollower(i)
		if follower && follower.Is3DLoaded() && follower.GetSitState() == 0 && CanAnimate(follower)
			if follower.PlayIdle(akIdle)
				animating_followers[i - 1] = follower
			endif
		endif
		i += 1
	endWhile
endFunction

function StopFollowerAnimations()
	int i = 0
	while i < animating_followers.Length
		if animating_followers[i]
			animating_followers[i].PlayIdle(IdleStop_Loose)
			animating_followers[i] = None
		endif
		i += 1
	endWhile
endFunction

function ShowTutorial_Variety()
    if _Seed_Setting_DisplayTutorials.GetValueInt() == 2 && _Seed_HelpDone_Variety.GetValueInt() == 1
        _Seed_Help_Variety.Show()
        _Seed_HelpDone_Variety.SetValue(2)
    endif
endFunction