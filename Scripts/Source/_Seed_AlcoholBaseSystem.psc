scriptname _Seed_AlcoholBaseSystem extends Quest

import Utility
import CampUtil
import SeedUtil
import _SeedInternal

GlobalVariable property _Seed_Setting_VitalitySystemEnabled auto
GlobalVariable property SystemEnabled auto
GlobalVariable property Attribute auto
GlobalVariable property Level auto
GlobalVariable property _Seed_Setting_Notifications auto
GlobalVariable property _Seed_Setting_NeedsVFX auto
GlobalVariable property GameHour auto
GlobalVariable property _Seed_Setting_AutoConsume auto
GlobalVariable property _Seed_Setting_AlcoholAltVisuals auto
GlobalVariable property attributeRateMultiGlobal auto

Spell property Spell1 auto          ; Relaxed
Spell property Spell2 auto          ; Tipsy
Spell property Spell3 auto          ; Drunk
Spell property Spell4 auto          ; Very Drunk (flag Disease)
Spell property Spell5 auto   		; Hung Over (after having passed out) (flag Disease)

Message property Level1Msg auto
Message property Level2Msg auto
Message property Level3Msg auto
Message property Level4Msg auto
Message property Level5Msg auto
Message property Level6Msg auto



ImageSpaceModifier property ISM2 auto
ImageSpaceModifier property ISM3 auto
ImageSpaceModifier property ISM4 auto
ImageSpaceModifier property ISM5 auto
ImageSpaceModifier property _Seed_BlackISM auto

;/TODO: Add this back in
Keyword property LocTypeInn auto

Location property KynesgroveBraidwoodInnLocation auto
Location property WindhelmCandlehearthHallLocation auto
Location property WindhelmNewGnisisCornerclubLocation auto
Location property FalkreathDeadMansDrinkLocation auto
Location property DragonBridgeFourShieldsTavernLocation auto
Location property SolitudeWinkingSkeeverLocation auto
Location property MorthalMoorsideInnLocation auto
Location property NightgateInnLocation auto
Location property DawnstarWindpeakInnLocation auto
Location property MarkarthSilverBloodInnLocation auto
Location property OldHroldanInnLocation auto
Location property RiftenBeeandBarbLocation auto
Location property IvarsteadVilemyrInnLocation auto
Location property RoriksteadFrostfruitInnLocation auto
Location property RiverwoodSleepingGiantInnLocation auto
Location property WhiterunBanneredMareLocation auto
Location property WhiterunDrunkenHuntsmanLocation auto
Location property WinterholdTheFrozenHearthLocation auto
/;

Faction Property CrimeFactionEastmarch Auto
Faction Property CrimeFactionFalkreath Auto
Faction Property CrimeFactionHaafingar Auto
Faction Property CrimeFactionHjaalmarch Auto
Faction Property CrimeFactionPale Auto
Faction Property CrimeFactionReach Auto
Faction Property CrimeFactionRift Auto
Faction Property CrimeFactionWhiterun Auto
Faction Property CrimeFactionWinterhold Auto
Faction Property DLC2CrimeRavenRockFaction Auto

ObjectReference Property AngasMillMapMarker auto
ObjectReference Property BlackBriarMeaderyLocationCenter auto
ObjectReference Property BraidwoodInnkeeperStandingSpotREF auto
ObjectReference Property CenterMakerStonehills auto
ObjectReference Property CenterMarkerBattlebornFarm auto
ObjectReference Property CenterMarkerHeartwoodMill auto
ObjectReference Property CenterMarkerMerryfairFarm auto
ObjectReference Property CWMission03InnMarkerDragonsBridgeFourShieldsTavern auto
ObjectReference Property CWMission03InnMarkerNightGateInn auto
ObjectReference Property CWMission03InnMarkerRoriksteadFrostfruitInn auto
ObjectReference Property DarkwaterCrossingLocationCenterMarkerREF auto
ObjectReference Property DawnstarMapMarkerREF auto
ObjectReference Property DBRecurringTargetMarkerRiften auto
ObjectReference Property DLC2PillarRRGuardAMarker auto
ObjectReference Property DLC2RR02VelethCenterMarker auto
ObjectReference Property DLC2RRDrovasCookMarker auto
ObjectReference Property DLC2SkaalVillageEdgeMarker auto
ObjectReference Property DLC2TelMithrynExteriorCenterMarker auto
ObjectReference Property DragonBridgeMapMarker auto
ObjectReference Property EdgeMarkerAngasMill auto
ObjectReference Property FalkreathInnSandboxMarker auto
ObjectReference Property FalkreathMapMarker auto
ObjectReference Property FalkreathShrineofArkayREF auto
ObjectReference Property HalfMoonMillMapMarker auto
ObjectReference Property HighHrothgarMapMarker auto
ObjectReference Property HillgrundsTombMapMarker auto
ObjectReference Property HlaaluFarmMapMarkerRef auto
ObjectReference Property IvarsteadMapMarker auto
ObjectReference Property KarthspireMapMarker auto
ObjectReference Property KynesgroveMapMarker auto
ObjectReference Property KynesgroveSteamscorchGullyCenterMarker auto
ObjectReference Property LurbukBardMarker auto
ObjectReference Property MarkarthHalloftheDeadCenterMarkerREF auto
ObjectReference Property MarkarthMapMarkerREF auto
ObjectReference Property MarkarthShrineofTalosCenterMarkerREF auto
ObjectReference Property MarkarthSilverFishInnLocationCenterMarkerREF auto
ObjectReference Property MarkarthStablesMapMarker auto
ObjectReference Property MarkarthTempleofDibellaLocationCenterMarkerREF auto
ObjectReference Property MarkarthWarrensLocationCenterMarkerREF auto
ObjectReference Property MorthalMapMarkerRef auto
ObjectReference Property MS04AvanchnzelMarker auto
ObjectReference Property MS10PirateSceneEMWaitressMARKER auto
ObjectReference Property MS11BloodTrailEnableMARKER auto
ObjectReference Property OldHroldanHangedManLocationCenterMarkerREF auto
ObjectReference Property RiftenBeeTalenWorkMarker auto
ObjectReference Property RiftenBeggersCampMarker auto
ObjectReference Property RiftenBunkhouseHaelgaBed auto
ObjectReference Property RiftenMapMarkerREF auto
ObjectReference Property RiftenStablesMapMarker auto
ObjectReference Property RiftenTempleWorshipMarker auto
ObjectReference Property RiverwoodMapMarker auto
ObjectReference Property RoriksteadMapMarker auto
ObjectReference Property SaarthalMapMarker auto
ObjectReference Property SarethiFarmMapMarker auto
ObjectReference Property ShorsStoneMapMarker auto
ObjectReference Property SolitudeMapmarkerRef auto
ObjectReference Property SolitudeStablesMapMarker auto
ObjectReference Property TG06EnthirArrivalMarker auto
ObjectReference Property UstengravMapMarker auto
ObjectReference Property VilemyrEatMarker01 auto
ObjectReference Property VolskyggeMapMarker auto
ObjectReference Property WhiterunDrunkenHuntsmanCenterMarker auto
ObjectReference Property WhiterunMapMarkerREF auto
ObjectReference Property WhiterunStablesMapMarker auto
ObjectReference Property WhiterunWatchtowerCenterMarker auto
ObjectReference Property WindhelmLocationCenterMarkerREF auto
ObjectReference Property WindhelmMapMarkerRef auto
ObjectReference Property WindhelmNewGnisisCornerclubCenterMarker auto
ObjectReference Property WindhelmPlayersHorseStart auto
ObjectReference Property WindhelmShrineofArkayREF auto
ObjectReference Property WinterholdMapMarker auto

globalVariable property _Seed_Settings_DrunkenShenanigans auto


Actor property PlayerRef auto

float property ATTRIBUTE_MAX = 120.0 autoReadOnly
float property ATTRIBUTE_MIN = 0.0 autoReadOnly
float SOBER_RATE = 5.0

String Property debugSystemName = "" auto hidden

float property update_interval = 0.5 auto hidden
float property last_update_time auto hidden
float last_drunk = 0.0
float last_hungover_time
bool property completelySober = true auto hidden
bool passingOut = false

function StopSystem()
	DecreaseDrunk(ATTRIBUTE_MAX)
	Game.EnablePlayerControls()
	self.UnregisterForUpdateGameTime()
endFunction



Event OnUpdateGameTime()
    float this_time = GetCurrentGameTime() * 24.0
    int cycles = Math.Floor((this_time - last_update_time) * 2)
	if cycles < 1
		cycles = 1
	endif
    float drunk_decrease = (SOBER_RATE * cycles)
	SeedDebug(0, "[" + debugSystemName + "]: Decreasing Drunk by: " + drunk_decrease)
    DecreaseDrunk(drunk_decrease)
	SeedDebug(0, "[" + debugSystemName + "]: Current Drunk: " + Attribute.GetValue() )
    last_update_time = this_time

    if Attribute.GetValue() > 0.0
        RegisterForSingleUpdateGameTime(update_interval)
	;else
		;completelySober = true;
    endif
EndEvent

function IncreaseDrunk(float amount)
    float newDrunkLevel = Attribute.GetValue() + amount
    if newDrunkLevel > ATTRIBUTE_MAX
        SeedDebug(0, "[" + debugSystemName + "]: Increasing drunk to: " + ATTRIBUTE_MAX)
		Attribute.SetValue(ATTRIBUTE_MAX)
    else
		SeedDebug(0, "[" + debugSystemName + "]: Increasing drunk to: " + newDrunkLevel)
        Attribute.SetValue(newDrunkLevel)
    endif
    ApplyDrunkEffects()
endFunction

function DecreaseDrunk(float amount)
    float newDrunkLevel = Attribute.GetValue() - (amount  * attributeRateMultiGlobal.getValue())
    if newDrunkLevel < ATTRIBUTE_MIN
		SeedDebug(0, "[" + debugSystemName + "]: Decreasing drunk to: " + ATTRIBUTE_MIN)
        Attribute.SetValue(ATTRIBUTE_MIN)
    else
		SeedDebug(0, "[" + debugSystemName + "]: Decreasing drunk to: " + newDrunkLevel)
        Attribute.SetValue(newDrunkLevel)
    endif
    ApplyDrunkEffects()
endFunction

function ModDrunk(float amount)
;TODO: Tidy this up
    float newDrunkLevel = Attribute.GetValue()  + amount
    if newDrunkLevel >= ATTRIBUTE_MAX
        Attribute.SetValue(ATTRIBUTE_MAX)
    elseif newDrunkLevel <= ATTRIBUTE_MIN
        Attribute.SetValue(ATTRIBUTE_MIN)
    else
		Attribute.SetValue(newDrunkLevel)
    endif
    ApplyDrunkEffects()
endFunction

function ApplyDrunkEffects()
    float drunk = Attribute.GetValue()
	bool increasing = false
    if drunk > last_drunk
        increasing = true
    endif
	
	SeedDebug(0, "[" + debugSystemName + "]: ApplyDrunkEffects(): drunk = " + drunk + ", last_drunk = " + last_drunk)
	

	if !(IsBetween(last_drunk, 20.0, -1.0)) && (IsBetween(drunk, 20.0, -1.0))
		Level.SetValue(0)
        ApplyDrunkLevel1()
    elseif !(IsBetween(last_drunk, 40.0, 20.0)) && (IsBetween(drunk, 40.0, 20.0))
		Level.SetValue(1)
        ApplyDrunkLevel2(increasing)
    elseif !(IsBetween(last_drunk, 60.0, 40.0)) && (IsBetween(drunk, 60.0, 40.0))
		Level.SetValue(2)
        ApplyDrunkLevel3(increasing)
    elseif !(IsBetween(last_drunk, 80.0, 60.0)) && (IsBetween(drunk, 80.0, 60.0))
		Level.SetValue(3)
        ApplyDrunkLevel4(increasing)
    elseif !(IsBetween(last_drunk, 100.0, 80.0)) && (IsBetween(drunk, 100.0, 80.0))
		Level.SetValue(4)
        ApplyDrunkLevel5(increasing)
    elseif !(last_drunk >= 100.0) && (drunk >= 100.0)
		if Level.getValue() < 4
			Level.SetValue(4)
			ApplyDrunkLevel5(increasing)		
		endif
        PassOut()
    endif
	
    last_drunk = drunk

    ; For Drinking Contest quest
    SendModEvent_PlayerDrinkAlcohol(Attribute.GetValue())
endFunction

function SendModEvent_PlayerDrinkAlcohol(float afDrunkAmount)
    int handle = ModEvent.Create("LastSeed_PlayerDrinkAlcohol")
    if (handle)
        ModEvent.PushFloat(handle, afDrunkAmount)
        ModEvent.Send(handle)
    endIf
EndFunction

function RemoveAllDrunkEffects()
    PlayerRef.RemoveSpell(Spell1)
    PlayerRef.RemoveSpell(Spell2)
    PlayerRef.RemoveSpell(Spell3)
    PlayerRef.RemoveSpell(Spell4)
endFunction

function showMessage(Message msg)
	if _Seed_Setting_Notifications.GetValueInt() == 2 && msg != none
		msg.show()
	endif
endFunction

function applyVFX(ImageSpaceModifier ISM, bool increasing)
    if _Seed_Setting_NeedsVFX.GetValueInt() == 2 && ISM != none
		ISM.ApplyCrossFade(4.0)
    elseif(increasing == false) && ISM == none
		ImageSpaceModifier.RemoveCrossFade(4.0)
	endif
endFunction

function ApplyDrunkLevel1()
	SeedDebug(0, "[" + debugSystemName + "]: Applying Drunk Level 1")
    RemoveAllDrunkEffects()
	showMessage(Level1Msg)

    ; clear SFX
    ; clear VFX
	ImageSpaceModifier.RemoveCrossFade(4.0)
endFunction	


function ApplyDrunkLevel2(bool increasing)
	SeedDebug(0, "[" + debugSystemName + "]: Applying Drunk Level 2")
    RemoveAllDrunkEffects()
    PlayerRef.AddSpell(Spell1, false)
	
	showMessage(Level2Msg)

	applyVFX(ISM2, increasing)
endFunction

function ApplyDrunkLevel3(bool increasing)
	SeedDebug(0, "[" + debugSystemName + "]: Applying Drunk Level 3")
    RemoveAllDrunkEffects()
    PlayerRef.AddSpell(Spell2, false)

	showMessage(Level3Msg)
    ; play drunk SFX
    applyVFX(ISM3, increasing)
endFunction

function ApplyDrunkLevel4(bool increasing)
	SeedDebug(0, "[" + debugSystemName + "]: Applying Drunk Level 4")
    RemoveAllDrunkEffects()
    PlayerRef.AddSpell(Spell3, false)
	showMessage(Level4Msg)

    ; play drunk SFX
    applyVFX(ISM4, increasing)
endFunction


function ApplyDrunkLevel5(bool increasing)
	SeedDebug(0, "[" + debugSystemName + "]: Applying Drunk Level 5")
    RemoveAllDrunkEffects()
    PlayerRef.AddSpell(Spell4, false)
	showMessage(Level5Msg)

    ; play drunk SFX
	applyVFX(ISM5, increasing)
endFunction

function PassOut()
	SeedDebug(0, "[" + debugSystemName + "]: Applying Drunk Level 6")
	if !passingOut
		passingOut = true
		Utility.Wait(10)
		FadeToBlackAndHold()		
		
		if(_Seed_Settings_DrunkenShenanigans.getValue() == 2 && !IsPlayerFocused())
			movePlayer()
		endif
		
		;Actor PlayerRef = Game.GetPlayer()
		
		; pass out
		;Game.DisablePlayerControls()
		Utility.Wait(3)
		PlayerRef.PushActorAway(PlayerRef, 0)
		PlayerRef.ApplyHavokImpulse(PlayerRef.GetAngleX(), PlayerRef.GetAngleY(), -0.5, 100)
		;_Seed_BlackISM.ApplyCrossFade(2.0)

		
		; Wait 6 hours and sober up
		Utility.Wait(3)
		GameHour.SetValue(GameHour.GetValue() + 6.0)

		; wake up
		;ImageSpaceModifier.RemoveCrossFade(4.0)
		FadeFromBlack()
		DecreaseDrunk(ATTRIBUTE_MAX)
		;Game.EnablePlayerControls()
		
		; Make Hungover
		if playerRef.hasSpell(Spell5)
			PlayerRef.removeSpell(Spell5)
		else
			showMessage(Level6Msg)
		endif
		PlayerRef.AddSpell(Spell5, false)
	
		;TODO: Get inn kickout script working.
		;if PlayerRef.GetCurrentLocation().HasKeyword(LocTypeInn)
			;KickPlayerOutOfInn()
		;endif
	passingOut = false
	endif
endFunction

; Fades the screen to black and holds it there.  Call FadeFromBlack() to reverse it.
Function FadeToBlackAndHold()
    ImageSpaceModifier FadeToBlackImod = Game.GetFormFromFile(0x0f756d, "Skyrim.esm")\
        as ImageSpaceModifier
    ImageSpaceModifier FadeToBlackHoldImod = Game.GetFormFromFile(0x0f756e, "Skyrim.esm")\
        as ImageSpaceModifier
    FadeToBlackImod.Apply()
    Utility.Wait(2)
    FadeToBlackImod.PopTo(FadeToBlackHoldImod)
EndFunction

; Fades the screen from black back to normal.  Reverses the effects of FadeToBlackAndHold().
Function FadeFromBlack()
    ImageSpaceModifier FadeToBlackHoldImod = Game.GetFormFromFile(0x0f756e, "Skyrim.esm")\
        as ImageSpaceModifier
    ImageSpaceModifier FadeToBlackBackImod = Game.GetFormFromFile(0x0f756f, "Skyrim.esm")\
        as ImageSpaceModifier
    Utility.Wait(2)
    FadeToBlackHoldImod.PopTo(FadeToBlackBackImod)
    FadeToBlackHoldImod.Remove()
EndFunction

bool function IsBetween(float fValue, float fUpperBound, float fLowerBound)
    if fValue <= fUpperBound && fValue > fLowerBound
        return true
    else
        return false
    endif
endFunction

;/
function KickPlayerOutOfInn()
    ;@TODO: Support Retching Netch
    if loc == KynesgroveBraidwoodInnLocation
    elseif loc == WindhelmCandlehearthHallLocation ; bed
    elseif loc == WindhelmNewGnisisCornerclubLocation ; bed
    elseif loc == FalkreathDeadMansDrinkLocation
    elseif loc == DragonBridgeFourShieldsTavernLocation
    elseif loc == SolitudeWinkingSkeeverLocation ; check OCS support
    elseif loc == MorthalMoorsideInnLocation ; bed
    elseif loc == NightgateInnLocation ; bed
    elseif loc == DawnstarWindpeakInnLocation ; bed
    elseif loc == MarkarthSilverBloodInnLocation ; check OCS support
    elseif loc == OldHroldanInnLocation
    elseif loc == RiftenBeeandBarbLocation ; check OCS support
    elseif loc == IvarsteadVilemyrInnLocation
    elseif loc == RoriksteadFrostfruitInnLocation
    elseif loc == RiverwoodSleepingGiantInnLocation
    elseif loc == WhiterunBanneredMareLocation ; check OCS support
    elseif loc == WhiterunDrunkenHuntsmanLocation ; check OCS support
    elseif loc == WinterholdTheFrozenHearthLocation ; bed
    endif
endFunction
/;

function DisplayCurrentStatus()
	if SystemEnabled.getValueInt() == 2
		float currentAttributeValue = Attribute.GetValue()
	
		;if IsBetween(currentAttributeValue, 10.0, -1.0)
		;	Level1Msg.show()
		;elseif IsBetween(currentAttributeValue, 30.0, 10.0)
		if IsBetween(currentAttributeValue, 40.0, 20.0)
			Level2Msg.show()
		elseif IsBetween(currentAttributeValue, 60.0, 40.0)
			Level3Msg.show()
		elseif IsBetween(currentAttributeValue, 80.0, 60.0)
			Level4Msg.show()
		elseif IsBetween(currentAttributeValue, 100.0, 80.0)
			Level5Msg.show()
		endif	
	endif
endFunction

Function RefreshSystem()
	if(Attribute.GetValue() > 0.0)
		SeedDebug(1, "[" + debugSystemName + "]: Refreshing.")
		last_update_time = GetCurrentGameTime() * 24.0
		RegisterForSingleUpdateGameTime(update_interval)
	endif
EndFunction


function movePlayer()
	int rand = RandomInt(1, 10)
	if rand == 1
		MoveToEastmarch()
	elseif rand == 2
		MoveToFalkreath()
	elseif rand == 3
		MoveToHaafingar()
	elseif rand == 4
		MoveToHjaalmarch()
	elseif rand == 5
		MoveToPale()
	elseif rand == 6
		MoveToReach()
	elseif rand == 7
		MoveToRift()
	elseif rand == 8
		MoveToWhiterun()
	elseif rand == 9
		MoveToWinterhold()
	elseif rand == 10
		MoveToSolstein()		
	endif
endFunction

function MoveToEastmarch()
	if trySendPlayerToJail(CrimeFactionEastmarch)
		return
	endif

	int rand = RandomInt(1, 11)
	if rand == 1	
		playerRef.MoveTo(WindhelmMapMarkerRef)
	elseif rand == 2
		playerRef.MoveTo(WindhelmLocationCenterMarkerREF)
	elseif rand == 3
		playerRef.MoveTo(WindhelmNewGnisisCornerclubCenterMarker)
	elseif rand == 4
		playerRef.MoveTo(WindhelmPlayersHorseStart)
	elseif rand == 5
		playerRef.MoveTo(WindhelmShrineofArkayREF)
	elseif rand == 6
		playerRef.MoveTo(HlaaluFarmMapMarkerRef)
	elseif rand == 7
		playerRef.MoveTo(KynesgroveMapMarker)
	elseif rand == 8
		playerRef.MoveTo(DarkwaterCrossingLocationCenterMarkerREF)
	elseif rand == 9
		playerRef.MoveTo(BraidwoodInnkeeperStandingSpotREF)
	elseif rand == 10
		playerRef.MoveTo(KynesgroveSteamscorchGullyCenterMarker)
	elseif rand == 11
		playerRef.MoveTo(MS11BloodTrailEnableMARKER)
	endIf
EndFunction

function MoveToFalkreath()
	if trySendPlayerToJail(CrimeFactionFalkreath)
		return
	endif

	int rand = RandomInt(1, 4)
	if rand == 1	
		playerRef.MoveTo(FalkreathMapMarker)
	elseif rand == 2	
		playerRef.MoveTo(HalfMoonMillMapMarker)
	elseif rand == 3	
		playerRef.MoveTo(FalkreathInnSandboxMarker)
	elseif rand == 4	
		playerRef.MoveTo(FalkreathShrineofArkayREF)
	endIf
EndFunction


function MoveToHaafingar()
	if trySendPlayerToJail(CrimeFactionHaafingar)
		return
	endif

	int rand = RandomInt(1, 5)
	if rand == 1	
		playerRef.MoveTo(SolitudeMapmarkerRef)
	elseif rand == 2	
		playerRef.MoveTo(DragonBridgeMapMarker)
	elseif rand == 3
		playerRef.MoveTo(SolitudeStablesMapMarker)
	elseif rand == 4
		playerRef.MoveTo(VolskyggeMapMarker)
	elseif rand == 5
		playerRef.MoveTo(CWMission03InnMarkerDragonsBridgeFourShieldsTavern)
	endIf
EndFunction

function MoveToHjaalmarch()
	if trySendPlayerToJail(CrimeFactionHjaalmarch)
		return
	endif

	int rand = RandomInt(1, 4)
	if rand == 1	
		playerRef.MoveTo(MorthalMapMarkerRef)
	elseif rand == 2	
		playerRef.MoveTo(CenterMakerStonehills)
	elseif rand == 3	
		playerRef.MoveTo(UstengravMapMarker)
	elseif rand == 4
		playerRef.MoveTo(LurbukBardMarker)
	endIf
EndFunction

function MoveToPale()
	if trySendPlayerToJail(CrimeFactionPale)
		return
	endif

	int rand = RandomInt(1, 5)
	if rand == 1	
		playerRef.MoveTo(DawnstarMapMarkerREF)
	elseif rand == 2	
		playerRef.MoveTo(AngasMillMapMarker)
	elseif rand == 3
		playerRef.MoveTo(EdgeMarkerAngasMill)
	elseif rand == 4
		playerRef.MoveTo(MS10PirateSceneEMWaitressMARKER)
	elseif rand == 5
		playerRef.MoveTo(CWMission03InnMarkerNightGateInn)
	endIf
EndFunction

function MoveToReach()
	if trySendPlayerToJail(CrimeFactionReach)
		return
	endif

	int rand = RandomInt(1, 8)
	if rand == 1	
		playerRef.MoveTo(MarkarthMapMarkerREF)
	elseif rand == 2
		playerRef.MoveTo(MarkarthShrineofTalosCenterMarkerREF)
	elseif rand == 3
		playerRef.MoveTo(MarkarthSilverFishInnLocationCenterMarkerREF)
	elseif rand == 4
		playerRef.MoveTo(MarkarthStablesMapMarker)
	elseif rand == 5
		playerRef.MoveTo(MarkarthTempleofDibellaLocationCenterMarkerREF)
	elseif rand == 6
		playerRef.MoveTo(MarkarthWarrensLocationCenterMarkerREF)
	elseif rand == 7
		playerRef.MoveTo(KarthspireMapMarker)
	elseif rand == 8
		playerRef.MoveTo(OldHroldanHangedManLocationCenterMarkerREF)
	endIf
EndFunction

function MoveToRift()
	if trySendPlayerToJail(CrimeFactionRift)
		return
	endif

	int rand = RandomInt(1, 15)
	if rand == 1	
		playerRef.MoveTo(RiftenMapMarkerREF)
	elseif rand == 2	
		playerRef.MoveTo(BlackBriarMeaderyLocationCenter)
	elseif rand == 3
		playerRef.MoveTo(CenterMarkerMerryfairFarm)
	elseif rand == 4
		playerRef.MoveTo(DBRecurringTargetMarkerRiften)
	elseif rand == 5
		playerRef.MoveTo(RiftenBeeTalenWorkMarker)
	elseif rand == 6
		playerRef.MoveTo(RiftenBeggersCampMarker)
	elseif rand == 7
		playerRef.MoveTo(RiftenBunkhouseHaelgaBed)
	elseif rand == 8
		playerRef.MoveTo(RiftenStablesMapMarker)
	elseif rand == 9
		playerRef.MoveTo(RiftenTempleWorshipMarker)
	elseif rand == 10
		playerRef.MoveTo(IvarsteadMapMarker)
	elseif rand == 11
		playerRef.MoveTo(MS04AvanchnzelMarker)
	elseif rand == 12
		playerRef.MoveTo(SarethiFarmMapMarker)
	elseif rand == 13
		playerRef.MoveTo(ShorsStoneMapMarker)
	elseif rand == 14
		playerRef.MoveTo(VilemyrEatMarker01)
	elseif rand == 15
		playerRef.MoveTo(CenterMarkerHeartwoodMill)
	endIf
EndFunction

function MoveToWhiterun()
	if trySendPlayerToJail(CrimeFactionWhiterun)
		return
	endif
	

	int rand = RandomInt(1, 10)
	if rand == 1	
		playerRef.MoveTo(WhiterunMapMarkerREF)
	elseif rand == 2	
		playerRef.MoveTo(HighHrothgarMapMarker)
	elseif rand == 3	
		playerRef.MoveTo(RiverwoodMapMarker)
	elseif rand == 4
		playerRef.MoveTo(CenterMarkerBattlebornFarm)
	elseif rand == 5
		playerRef.MoveTo(WhiterunStablesMapMarker)
	elseif rand == 6
		playerRef.MoveTo(WhiterunWatchtowerCenterMarker)
	elseif rand == 7
		playerRef.MoveTo(WhiterunDrunkenHuntsmanCenterMarker)
	elseif rand == 8
		playerRef.MoveTo(HillgrundsTombMapMarker)
	elseif rand == 9
		playerRef.MoveTo(RoriksteadMapMarker)
	elseif rand == 10
		playerRef.MoveTo(CWMission03InnMarkerRoriksteadFrostfruitInn)
	endIf
EndFunction

function MoveToWinterhold()
	if trySendPlayerToJail(CrimeFactionWinterhold)
		return
	endif

	int rand = RandomInt(1, 3)
	if rand == 1
		playerRef.MoveTo(WinterholdMapMarker)
	elseif rand == 2
		playerRef.MoveTo(SaarthalMapMarker)
	elseif rand == 3
		playerRef.MoveTo(TG06EnthirArrivalMarker)
	endif
endFunction

function MoveToSolstein()
	if trySendPlayerToJail(DLC2CrimeRavenRockFaction)
		return
	endif

	int rand = RandomInt(1, 5)
	if rand == 1
		playerRef.MoveTo(DLC2PillarRRGuardAMarker)
	elseif rand == 2
		playerRef.MoveTo(DLC2RR02VelethCenterMarker)
	elseif rand == 3
		playerRef.MoveTo(DLC2RRDrovasCookMarker)
	elseif rand == 4
		playerRef.MoveTo(DLC2SkaalVillageEdgeMarker)
	elseif rand == 5
		playerRef.MoveTo(DLC2TelMithrynExteriorCenterMarker)
	endif
EndFunction

bool function trySendPlayerToJail(Faction crimeFaction)
	if RandomInt(1, 10) == 1
		int amount = RandomInt(1, 100)
		crimeFaction.ModCrimeGold(amount)
		crimeFaction.SendPlayerToJail()
		return true
	endif
	
	return false
endFunction
