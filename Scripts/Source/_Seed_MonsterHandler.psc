scriptname _Seed_MonsterHandler extends Quest
import seedUtil
import _SeedInternal
import campUtil

GlobalVariable property _Seed_Setting_VampireBehavior auto
GlobalVariable property _Seed_RestoreHungerMinorAmount auto
GlobalVariable property _Seed_RestoreHungerMajorAmount auto
GlobalVariable property _Seed_RestoreHungerSuperiorAmount auto
GlobalVariable property _Seed_RestoreHungerMassiveAmount auto
GlobalVariable property _Seed_Setting_SystemEnabled_Thirst  auto
GlobalVariable property _Seed_Setting_isBetterVampiresLoaded  auto
GlobalVariable property _Seed_SettingPlayerIsLich  auto
GlobalVariable property _Seed_Setting_DiseaseChanceRawFood  auto
GlobalVariable property _Seed_Setting_SeranaDrinksBlood  auto

Race property OrcRaceVampire auto
Race property ArgonianRaceVampire auto
Race property BretonRaceVampire auto
Race property DarkElfRaceVampire auto
Race property HighELfRaceVampire auto
Race property ImperialRaceVampire auto
Race property KhajiitRaceVampire auto
Race property NordRaceVampire auto
Race property RedguardRaceVampire auto
Race property WoodElfRaceVampire auto

int property oldNecksBitten auto hidden

Spell property _Seed_LichDeathGrip auto
Spell property _Seed_AutoDrink auto
Spell property _Seed_AutoEat auto

Actor property PlayerRef auto
ActorBase property DLC1Serana auto

ImpactDataSet Property BloodSprayImpactSetRed Auto

;Start Monitoring for Vampire Bites
function startMonitoring()
	SeedDebug(1, "[MonsterHandler]: Starting Vampire bite monitoring")
	oldNecksBitten = Game.QueryStat("Necks Bitten")
	registerForSingleUpdate(4)
endFunction

;Stop Monitoring for Vampire Bites
function stopMonitoring()
	SeedDebug(1, "[MonsterHandler]: Stopping Vampire bite monitoring")
	UnregisterForUpdate()
endFunction

;On Vampire Bite, restore needs
Event onUpdate()
	Int newNecksBitten = Game.QueryStat("Necks Bitten")
	If newNecksBitten  != oldNecksBitten
		If newNecksBitten  > oldNecksBitten
			VampireFeed()
		endif
		oldNecksBitten = newNecksBitten
	EndIf
	registerForSingleUpdate(4)
endEvent

function VampireFeed()
	if getVampireSettings(false, true, true)
		RestorePlayerHunger(120.0)
		RestorePlayerThirst(120.0)
	endif
endfunction
 
 function WerewolfFeed()
	RestorePlayerHunger(_Seed_RestoreHungerMajorAmount.GetValue())
 endFunction
 
 function CannibalFeed(Actor akTarget, Actor akCaster)
	akTarget.PlayImpactEffect(BloodSprayImpactSetRed, "SkirtFBone01")
	akTarget.PlayImpactEffect(BloodSprayImpactSetRed, "SkirtFBone01")
	if(_Seed_SettingPlayerIsLich.getValue() != 2)
		if getVampireSettings(true, true, true)
			RestorePlayerHunger(_Seed_RestoreHungerMajorAmount.GetValue(), 41.0)
			RestorePlayerThirst(_Seed_RestoreHungerMajorAmount.GetValue(), 41.0)
		else
			RestorePlayerHunger(_Seed_RestoreHungerMajorAmount.GetValue())
			; Catch Disease
			if GetDiseaseSystem().cantEatRawFood(PlayerRef)
				int diseaseChance = _Seed_Setting_DiseaseChanceRawFood.getValue() as int
				applyRandomDisease(DiseaseChance)	
			endif
		endif
	endif
endFunction

bool function getVampireSettings(bool mortal = true, bool supernatural = true, bool immortal = true)	
	if IsPlayerUndead() || isVampireRace(PlayerRef)
		if (mortal && _Seed_Setting_VampireBehavior.getValueInt() == 1)
			;SeedDebug(0, "[Monster]: getVampireSettings = true (mortal)")
			return true
		elseif (supernatural && _Seed_Setting_VampireBehavior.getValueInt() == 2)
			;SeedDebug(0, "[Monster]: getVampireSettings = true (supernatural)")
			return true
		elseif  (immortal && _Seed_Setting_VampireBehavior.getValueInt() == 3)
			;SeedDebug(0, "[Monster]: getVampireSettings = true (immortal)")
			return true
		endif
	else
		;SeedDebug(0, "[Monster]: Player is not vampire")
	endif
	;SeedDebug(0, "[Monster]: getVampireSettings = false")
	return false
endFunction

bool function getVampireSettingsBasic(bool mortal = true, bool supernatural = true, bool immortal = true)	
	if (mortal && _Seed_Setting_VampireBehavior.getValueInt() == 1)
		;SeedDebug(0, "[Monster]: getVampireSettings = true (mortal)")
		return true
	elseif (supernatural && _Seed_Setting_VampireBehavior.getValueInt() == 2)
		;SeedDebug(0, "[Monster]: getVampireSettings = true (supernatural)")
		return true
	elseif  (immortal && _Seed_Setting_VampireBehavior.getValueInt() == 3)
		;SeedDebug(0, "[Monster]: getVampireSettings = true (immortal)")
		return true
	endif
	;SeedDebug(0, "[Monster]: getVampireSettings = false")
	return false
endFunction

bool function isVampireRace(Actor target)
	bool result = false
	if target != none
		ActorBase base = Target.GetActorBase()
		Race r = base.GetRace()
		If base == DLC1Serana 
			if _Seed_Setting_SeranaDrinksBlood.getValue() as int == 2
				result = true
			else
				result = false
			endif
		Else
			result = r == OrcRaceVampire || r == ArgonianRaceVampire || r == BretonRaceVampire || r == DarkElfRaceVampire || r == HighELfRaceVampire || r == ImperialRaceVampire || r == KhajiitRaceVampire || r == NordRaceVampire || r == RedguardRaceVampire || r == WoodElfRaceVampire
		endif
		if result
			SeedDebug(0, "[Monster]: Follower IS a Vampire: " + target + ", " + r)
		else
			SeedDebug(0, "[Monster]: Follower IS NOT Vampire: " + target + ", " + r)
		endif
	else
		SeedDebug(0, "[Monster]: isVampireRace: Follower not found")
	endif
	return result
endFunction

bool function IsActorTransformed(Actor person)
	CampfireAPI Campfire = campUtil.GetAPI()
	if Campfire == none
		RaiseCampAPIError()
		return false
	endif
	
	Race actorRace = person.GetRace()
	if actorRace.HasKeyword(Campfire.ImmuneParalysis)
		if actorRace.HasKeyword(Campfire.ActorTypeCreature)
			; Werewolf
			return true
		elseif actorRace.HasKeyword(Campfire.ActorTypeUndead) && !actorRace.HasKeyword(Campfire.ActorTypeNPC)
			; Vampire Lord
			return true
		else
			return false
		endif
	else
		return false
	endif
endFunction

bool function hasSomeVampireFollowers()
	if isVampireRace(GetTrackedFollower(1))
		return true
	elseif  isVampireRace(GetTrackedFollower(1))
		return true
	elseif isVampireRace(GetTrackedFollower(1))
		return true
	endif
	
	return false
endFunction

bool function hasAllVampireFollowers()
	Actor follower1 = GetTrackedFollower(1)
	Actor follower2 = GetTrackedFollower(2)
	Actor follower3 = GetTrackedFollower(3)
	if (!follower1 || isVampireRace(follower1)) && (!follower2 || isVampireRace(follower2)) && (!follower3 || isVampireRace(follower3)) && (follower1 || follower2 || follower3)
		return true
	endif
	return false
endFunction

Potion Function getStaleBloodPotion()
	Potion result = none
	If _Seed_Setting_isBetterVampiresLoaded.getValue() as int == 2
		result = Game.GetFormFromFile(0x0050AF47, "Better Vampires.esp") as Potion ;DLC1BloodPotion2 "Stale Blood Potion" [ALCH:0x0050AF47]
	endif
	return result
endFunction

function addLichSpell(bool addIt = true)
	if addIt
		playerRef.addSpell(_Seed_LichDeathGrip)		
		playerRef.removeSpell(_Seed_AutoEat)
		playerRef.removeSpell(_Seed_AutoDrink)
	else
		playerRef.removeSpell(_Seed_LichDeathGrip)
		playerRef.AddSpell(_Seed_AutoEat)
		playerRef.AddSpell(_Seed_AutoDrink)
	endif
endFunction