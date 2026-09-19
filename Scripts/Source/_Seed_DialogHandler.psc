;/
REFERENCED IN: _Seed_DialogHandlerQuest
/;

Scriptname _Seed_DialogHandler extends Quest  

import SeedUtil
import CampUtil
import _SeedInternal

Actor property PlayerRef auto

Potion Property _Seed_WaterskinEmpty Auto
Potion Property _Seed_Waterskin1 Auto
Potion Property _Seed_Waterskin2 Auto
Potion Property _Seed_Waterskin3 Auto
Potion Property _Seed_Waterskin1Clean Auto
Potion Property _Seed_Waterskin2Clean Auto
Potion Property _Seed_Waterskin3Clean Auto

Potion Property _Seed_WaterBottleEmpty Auto
Potion Property _Seed_WaterBottle Auto
Potion Property _Seed_WaterBottleClean Auto

Potion Property _Seed_CureDiseaseSetting Auto

MiscObject Property Gold001 Auto

Message property _Seed_Dialog_NoGoldMsg auto
Message property _Seed_Dialog_NoWaterskinsMsg auto
Message property _Seed_InnMealMsg auto

GlobalVariable property _Seed_InnMealCost auto
GlobalVariable property _Seed_SettingPlayerIsLich auto
GlobalVariable property _Seed_Setting_SystemEnabled_FollowerNeeds auto
GlobalVariable property _Seed_Setting_FoodPriceMulti auto

function StartSystem()
	SeedDebug(-1, "StartSystem " + self)
	if !self.IsRunning()
		;seedUtil.GetCompatibilitySystem().StartInnMeals(true)
		self.Start()
	endif
endFunction
function StopSystem()
	SeedDebug(-1, "StopSystem " + self)	
	if self.IsRunning()
		;seedUtil.GetCompatibilitySystem().StartInnMeals(false)
		self.Stop()
	endif
endFunction


Function PriestCure()
	PlayerRef.AddItem(_Seed_CureDiseaseSetting, 1, true)
	PlayerRef.EquipItem(_Seed_CureDiseaseSetting, false, true)
	GetDiseaseSystem().clearDiseases()
EndFunction


Function FillWaterskinInn(actor akSpeaker)
	if PlayerRef.GetItemCount(Gold001) >= 5
		if(GetWaterHandler().fillAllWaterskins())
			PlayerRef.RemoveItem(Gold001, 5)
		endif
	else
		_Seed_Dialog_NoGoldMsg.Show()
	endif
EndFunction

Function ServeInnMeal(actor akSpeaker)
	;Check if Player will eat meal
	int playerCount = 1
	if (GetMonsterHandler().getVampireSettings(false, true, true) || _Seed_SettingPlayerIsLich.GetValueInt() == 2)
		playerCount = 0
	endif
	
	; Get Number of Followers who will eat meal
	int followerCount = 0
	if _Seed_Setting_SystemEnabled_FollowerNeeds.GetValueInt() == 2
		followerCount = getTrackedPartyCount()
		
		Actor follower1 = GetTrackedFollower(1)
		Actor follower2 = GetTrackedFollower(2)
		Actor follower3 = GetTrackedFollower(3)
		if (follower1 && GetMonsterHandler().isVampireRace(follower1))
			followerCount = followerCount - 1
		endif
		if (follower2 && GetMonsterHandler().isVampireRace(follower2))
			followerCount = followerCount - 1
		endif
		if(follower3 && GetMonsterHandler().isVampireRace(follower3))
			followerCount = followerCount - 1
		endif
		
		if(followerCount < 0)
			followerCount = 0
		endif
	endif
		
	;Get total Meal Cost
	int mealCost = (_Seed_InnMealCost.getvalue() * _Seed_Setting_FoodPriceMulti.getValue()) as int
	int totalCount = playerCount + followerCount
	if(totalCount == 0)
		mealCost = mealCost * totalCount
	endif
		
	; Eat Meal
	if PlayerRef.GetItemCount(Gold001) >= mealCost
		PlayerRef.RemoveItem(Gold001, mealCost)
		_Seed_InnMealMsg.Show()
		if(playerCount != 0)
			if getHungerSystem().isRunning()
				GetHungerSystem().SetAttribute(0)
			endif
			if GetThirstSystem().isRunning()
				GetThirstSystem().SetAttribute(0)
			endif
		endif
		if(followerCount != 0)
			if GetPartyHungerSystem().isRunning()
				GetPartyHungerSystem().SetAttribute(0)
			endif
			if GetPartyThirstSystem().isRunning()
				GetPartyThirstSystem().SetAttribute(0)
			endif
		endif
	else
		_Seed_Dialog_NoGoldMsg.Show()
	endif
endFunction

