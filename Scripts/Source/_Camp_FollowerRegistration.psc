Scriptname _Camp_FollowerRegistration extends ActiveMagicEffect

import _CampInternal

Quest property _Camp_FollowerQuest auto
Quest property _Camp_MainQuest auto

Race property DogCompanionRace auto
; Filled by LastSeed.esp's override of _Camp_FollowerRegistrationEffect; None without Last Seed.
Race property HorseRace auto
Faction property PlayerPotentialAnimalFaction auto
Faction property DogFaction auto

ReferenceAlias property Follower1 auto
ReferenceAlias property Follower2 auto
ReferenceAlias property Follower3 auto
ReferenceAlias property Animal auto

; Last Seed support (2026-09-13). Last Seed 5.3 (Aytrus, after Chesko) shipped its own copy of this
; script to skip horses and reanimated corpses and to stop follower food spoilage on unregistration.
; A second copy would shadow Campfire's, so the hooks live here instead, guarded so Campfire keeps
; working without Last Seed or powerofthree's Papyrus Extender installed.
bool function IsLastSeedLoaded()
    return Game.GetFormFromFile(0x0000B162, "LastSeed.esp") != None	; LastSeedRunning
endFunction

bool function IsReanimated(Actor akTarget)
    if !IsLastSeedLoaded() || !SeedUtil.GetCompatibilitySystem().isPO3Loaded
        return false
    endif
    return PO3_SKSEFunctions.GetActorState(akTarget) == 4	; 4 = reanimated
endFunction

function StopFollowerSpoilage(int aiSlot)
    if IsLastSeedLoaded()
        SeedUtil.GetSpoilageSystem().stopSpoilage(aiSlot)
    endif
endFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
    ; Horses are not companions, and neither are reanimated corpses.
    if HorseRace && akTarget.GetRace() == HorseRace
        return
    endif
    if IsReanimated(akTarget)
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
        (_Camp_MainQuest as _Camp_ConditionValues).Follower1Registered = true
    elseif !second_actor_ref
        Follower2.ForceRefTo(akActor)
        (_Camp_MainQuest as _Camp_ConditionValues).Follower2Registered = true
    elseif !third_actor_ref
        Follower3.ForceRefTo(akActor)
        (_Camp_MainQuest as _Camp_ConditionValues).Follower3Registered = true
    else
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

; Last Seed's follower food containers are slots 5-7 (followers) and 9 (animal).
function UnregisterFollower(Actor akActor)
    if Follower1.GetActorRef() == akActor
        StopFollowerSpoilage(5)
        Follower1.Clear()
        (_Camp_MainQuest as _Camp_ConditionValues).Follower1Registered = false
    elseif Follower2.GetActorRef() == akActor
        StopFollowerSpoilage(6)
        Follower2.Clear()
        (_Camp_MainQuest as _Camp_ConditionValues).Follower2Registered = false
    elseif Follower3.GetActorRef() == akActor
        StopFollowerSpoilage(7)
        Follower3.Clear()
        (_Camp_MainQuest as _Camp_ConditionValues).Follower3Registered = false
    endif
endFunction

function UnregisterAnimal(Actor akAnimal)
    if Animal.GetActorRef() == akAnimal
        StopFollowerSpoilage(9)
        Animal.Clear()
        (_Camp_MainQuest as _Camp_ConditionValues).AnimalRegistered = false
    endif
endFunction
