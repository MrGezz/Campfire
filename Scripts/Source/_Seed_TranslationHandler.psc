Scriptname _Seed_TranslationHandler extends Quest 
import CampUtil
import SeedUtil

;/
REFERENCED IN:
_Seed_TranslationHandlerQuest "DialogHandler" [QUST:062F2BA5]
/;

String property CurrentSelection auto
String property UnknownFoodstuff auto
String property ProvisionsWeight auto
String property ProvisionsOverweight auto
String property DiseaseContracted  auto
String property DiseaseCured  auto
String property DiseaseProgressed  auto

String property FollowerFirst  auto
String property FollowerSecond  auto
String property FollowerThird  auto
String property Party  auto
String property You  auto
String property AteSome  auto
String property DrankSome  auto
String property SomeWater  auto

String property Eating  auto
String property Drinking  auto
String property PartyEating  auto
String property PartyDrinking  auto

String property FollowerHungerMessage0 auto
String property FollowerHungerMessage1 auto
String property FollowerHungerMessage2 auto
String property FollowerHungerMessage3 auto
String property FollowerHungerMessage4 auto
String property FollowerHungerMessage5 auto

String property FollowerThirstMessage0 auto
String property FollowerThirstMessage1 auto
String property FollowerThirstMessage2 auto
String property FollowerThirstMessage3 auto
String property FollowerThirstMessage4 auto
String property FollowerThirstMessage5 auto

String property PartyHungerMessage0 auto
String property PartyHungerMessage1 auto
String property PartyHungerMessage2 auto
String property PartyHungerMessage3 auto
String property PartyHungerMessage4 auto
String property PartyHungerMessage5 auto

String property PartyThirstMessage0 auto
String property PartyThirstMessage1 auto
String property PartyThirstMessage2 auto
String property PartyThirstMessage3 auto
String property PartyThirstMessage4 auto
String property PartyThirstMessage5 auto

String property DiseaseAtaxia auto
String property DiseaseBoneBreakFever auto
String property DiseaseBrainRot auto
String property DiseaseDroops auto
String property DiseaseSanguinareVampiris auto
String property DiseaseRattles auto
String property DiseaseRockjoint auto
String property DiseaseWitbane auto
String property DiseaseAddiction auto
String property DiseaseBlackHeartBlight auto

String property DiseaseBrownRot auto
String property DiseaseStomachRot auto
String property DiseaseSwampFever auto
String property DiseaseGreenspore auto
String property DiseaseShakes auto
String property DiseaseCollywobbles auto
String property DiseaseFeebleLimb auto
String property DiseaseAstralVapors auto
String property DiseaseYellowTick auto
String property DiseaseTicklebritch auto
String property DiseaseWitlessPox auto
String property DiseaseTunnelCough auto
String property DiseaseWither auto
String property DiseaseChanthraxBlight auto
String property DiseaseHelljoint auto
String property DiseaseSerpiginousDementia auto
String property DiseaseBloodLung auto
String property DiseaseRotbone auto
String property DiseaseAshWoeBlight auto
String property DiseaseWitchwither auto
String property DiseaseRustChancre auto
String property DiseaseRedRage auto
String property DiseaseDampworm  auto
String property DiseaseScalonSunburn auto
String property DiseaseChills  auto
String property DiseaseAshchancre auto

String property DiseaseLevel1 auto
String property DiseaseLevel2 auto
String property DiseaseLevel3 auto
String property DiseaseLevel4 auto
String property DiseaseLevel5 auto

String property foodLight auto
String property foodMedium auto
String property foodFilling auto
String property foodHearty auto
String property drinkWeak auto
String property drinkModerate auto
String property drinkStrong auto



String function GetFollowerHungerMessage(int i) 
    if i == 0
        return FollowerHungerMessage0
    elseif i == 1
        return FollowerHungerMessage1
    elseif i == 2
        return FollowerHungerMessage2
    elseif i == 3
        return FollowerHungerMessage3
    elseif i == 4
        return FollowerHungerMessage4
    elseif i == 5
        return FollowerHungerMessage5
    endif
endFunction

String function GetFollowerThirstMessage(int i) 
    if i == 0
        return FollowerThirstMessage0
    elseif i == 1
        return FollowerThirstMessage1
    elseif i == 2
        return FollowerThirstMessage2
    elseif i == 3
        return FollowerThirstMessage3
    elseif i == 4
        return FollowerThirstMessage4
    elseif i == 5
        return FollowerThirstMessage5
    endif
endFunction

String function GetPartyHungerMessage(int i) 
    if i == 0
        return PartyHungerMessage0
    elseif i == 1
        return PartyHungerMessage1
    elseif i == 2
        return PartyHungerMessage2
    elseif i == 3
        return PartyHungerMessage3
    elseif i == 4
        return PartyHungerMessage4
    elseif i == 5
        return PartyHungerMessage5
    endif
endFunction

String function GetPartyThirstMessage(int i) 
    if i == 0
        return PartyThirstMessage0
    elseif i == 1
        return PartyThirstMessage1
    elseif i == 2
        return PartyThirstMessage2
    elseif i == 3
        return PartyThirstMessage3
    elseif i == 4
        return PartyThirstMessage4
    elseif i == 5
        return PartyThirstMessage5
    endif
endFunction


String function GetDiseaseName(string type) 
	if type == "DiseaseAtaxia"
		return DiseaseAtaxia   
	elseif type == "DiseaseBoneBreakFever"
		return DiseaseBoneBreakFever
	elseif type == "DiseaseBrainRot"
		return DiseaseBrainRot
	elseif type == "DiseaseDroops"
		return DiseaseDroops
	elseif type == "DiseaseSanguinareVampiris"
		return DiseaseSanguinareVampiris
	elseif type == "DiseaseRattles"
		return DiseaseRattles
	elseif type == "DiseaseRockjoint"
		return DiseaseRockjoint
	elseif type == "DiseaseWitbane"
		return DiseaseWitbane
	elseif type == "DiseaseAddiction"
		return DiseaseAddiction
	elseif type == "DiseaseBlackHeartBlight"
		return DiseaseBlackHeartBlight
	elseif type == "DiseaseBrownRot"
		return DiseaseBrownRot
	elseif type == "DiseaseStomachRot"
		return DiseaseStomachRot
	elseif type == "DiseaseSwampFever"
		return DiseaseSwampFever
	elseif type == "DiseaseGreenspore"
		return DiseaseGreenspore
	elseif type == "DiseaseShakes"
		return DiseaseShakes
	elseif type == "DiseaseCollywobbles"
		return DiseaseCollywobbles
	elseif type == "DiseaseFeebleLimb"
		return DiseaseFeebleLimb
	elseif type == "DiseaseAstralVapors"
		return DiseaseAstralVapors
	elseif type == "DiseaseYellowTick"
		return DiseaseYellowTick
	elseif type == "DiseaseTicklebritch"
		return DiseaseTicklebritch
	elseif type == "DiseaseWitlessPox"
		return DiseaseWitlessPox
	elseif type == "DiseaseTunnelCough"
		return DiseaseTunnelCough
	elseif type == "DiseaseWither"
		return DiseaseWither
	elseif type == "DiseaseChanthraxBlight"
		return DiseaseChanthraxBlight
	elseif type == "DiseaseHelljoint"
		return DiseaseHelljoint
	elseif type == "DiseaseSerpiginousDementia"
		return DiseaseSerpiginousDementia
	elseif type == "DiseaseBloodLung"
		return DiseaseBloodLung
	elseif type == "DiseaseRotbone"
		return DiseaseRotbone
	elseif type == "DiseaseAshWoeBlight"
		return DiseaseAshWoeBlight
	elseif type == "DiseaseWitchwither"
		return DiseaseWitchwither
	elseif type == "DiseaseRustChancre"
		return DiseaseRustChancre
	elseif type == "DiseaseRedRage"
		return DiseaseRedRage
	elseif type == "DiseaseDampworm"
		return DiseaseDampworm
	elseif type == "DiseaseScalonSunburn"
		return DiseaseScalonSunburn
	elseif type == "DiseaseChills"
		return DiseaseChills
	elseif type == "DiseaseAshchancre"
		return DiseaseAshchancre
	endif
endFunction

String function GetDiseaseType(string type) 
    if type == 1
		return DiseaseLevel1
	elseif type == 2
		return DiseaseLevel2	
	elseif type == 3
		return DiseaseLevel3
	elseif type == 4
		return DiseaseLevel4
	elseif type == 5
		return DiseaseLevel5
	endif
endFunction

string function getPartyName()
	string name = Party
	if GetSKSELoaded() && GetFollowerSystem().getPartyCount() == 1
		if getTrackedFollower(1)
			name = getTrackedFollower(1).GetBaseObject().GetName()
		elseif getTrackedFollower(2)
			name = getTrackedFollower(2).GetBaseObject().GetName()
		elseif getTrackedFollower(3)
			name = getTrackedFollower(3).GetBaseObject().GetName()
		endif
	endIf	
	return name
endFunction