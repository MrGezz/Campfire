Scriptname _Camp_FollowerRegistration extends ActiveMagicEffect  

import _CampInternal
import SeedUtil

Quest property _Camp_FollowerQuest auto
Quest property _Camp_MainQuest auto

Race property DogCompanionRace auto
Race property HorseRace auto							
Faction property PlayerPotentialAnimalFaction auto
Faction property DogFaction auto

ReferenceAlias property Follower1 auto
ReferenceAlias property Follower2 auto
ReferenceAlias property Follower3 auto
ReferenceAlias property Animal auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	; Dont Register Horses as Companions
	if akTarget.GetRace() == HorseRace
		return
	endif
	
	;Don't Register Reanimated NPCs as Companions
	if SeedUtil.GetCompatibilitySystem().isPO3Loaded && po3_SKSEFunctions.GetActorState(akTarget) == 4
		return
	endif 
	
	if akTarget.GetRace() == DogCompanionRace || akTarget.IsInFaction(PlayerPotentialAnimalFaction) || akTarget.IsInFaction(DogFaction)
        CampDebug(1, "Registering animal: " + self)
        RegisterAnimal(akTarget)
    else
        CampDebug(1, "Registering follower:" + self)
        RegisterFollower(akTarget)
    endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)	
	if akTarget.GetRace() == DogCompanionRace || akTarget.IsInFaction(PlayerPotentialAnimalFaction) || akTarget.IsInFaction(DogFaction)
        CampDebug(1, "Unregistering animal: " + self)
        UnregisterAnimal(akTarget)
    else
        CampDebug(1, "Unregistering follower: " + self)
        UnregisterFollower(akTarget)
    endif
EndEvent

function RegisterFollower(Actor akActor)
    ;Allow unregistration to happen first.
    utility.wait(2)

									 
								  
		
	  
	

    ;Is this follower already registered?
    Actor first_actor_ref = Follower1.GetActorRef()
    Actor second_actor_ref = Follower2.GetActorRef()
    Actor third_actor_ref = Follower3.GetActorRef()
    if first_actor_ref == akActor
        return
    elseif second_actor_ref == akActor
        return
    elseif third_actor_ref == akActor
        return
    endif

    ;Register this follower in the first available alias
    if !first_actor_ref
        Follower1.ForceRefTo(akActor)
		;GetFollowerSystem().unSuspendNeeds(1, akActor)
        (_Camp_MainQuest as _Camp_ConditionValues).Follower1Registered = true		
    elseif !second_actor_ref
        Follower2.ForceRefTo(akActor)
		;GetFollowerSystem().unSuspendNeeds(2, akActor)
        (_Camp_MainQuest as _Camp_ConditionValues).Follower2Registered = true
    elseif !third_actor_ref
        Follower3.ForceRefTo(akActor)
		;GetFollowerSystem().unSuspendNeeds(3, akActor)
        (_Camp_MainQuest as _Camp_ConditionValues).Follower3Registered = true
        CampDebug(1, "[Campfire] Tried to register " + akActor + " as Follower, but aliases were full.")
    endif
endFunction

function RegisterAnimal(Actor akAnimal)
    ;Allow unregistration to happen first.
    utility.wait(2)

    ;Is this animal already registered?
    Actor first_animal_ref = Animal.GetActorRef()
    if first_animal_ref == akAnimal
        return
    endif

    ;Register this animal in the first available alias
    if !first_animal_ref
        Animal.ForceRefTo(akAnimal)
        (_Camp_MainQuest as _Camp_ConditionValues).AnimalRegistered = true
    endif
endFunction

function UnregisterFollower(Actor akActor)
    if Follower1.GetActorRef() == akActor
		GetSpoilageSystem().stopSpoilage(5)		
		;GetFollowerSystem().SuspendNeeds(1, akActor)
        Follower1.Clear()
        (_Camp_MainQuest as _Camp_ConditionValues).Follower1Registered = false
    elseif Follower2.GetActorRef() == akActor
		GetSpoilageSystem().stopSpoilage(6)	
		;GetFollowerSystem().SuspendNeeds(2, akActor)
		Follower2.Clear()
        (_Camp_MainQuest as _Camp_ConditionValues).Follower2Registered = false
    elseif Follower3.GetActorRef() == akActor
		GetSpoilageSystem().stopSpoilage(7)	
		;GetFollowerSystem().SuspendNeeds(3, akActor)
		Follower3.Clear()
        (_Camp_MainQuest as _Camp_ConditionValues).Follower3Registered = false
    endif
endFunction

function UnregisterAnimal(Actor akAnimal)
    if Animal.GetActorRef() == akAnimal
		GetSpoilageSystem().stopSpoilage(9)	
        Animal.Clear()
        (_Camp_MainQuest as _Camp_ConditionValues).AnimalRegistered = false
    endif
endFunction

;/TODO: REMOVE THIS
function startNeeds(int followerIndex, Actor akActor)
	if GetMonsterHandler().IsVampireRace(akActor) == false
		if seedUtil.getHungerSystem().isRunning()
			GetFollowerSystem().getHungerSystem(followerIndex).StartSystem()
		endif
		if seedUtil.getThirstSystem().isRunning()
			GetFollowerSystem().getThirstSystem(followerIndex).StartSystem()
		endif
	endif
endFunction

function stopNeeds(int followerIndex)
	GetFollowerSystem().getHungerSystem(followerIndex).StopSystem()
	GetFollowerSystem().getThirstSystem(followerIndex).StopSystem()
endFunction
/;