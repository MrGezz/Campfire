scriptname _Seed_Main extends Quest
;/
REFERENCED IN: 
_Seed_MainQuest "Last Seed Main Quest" [QUST:07000D72] \ Scripts
/;

import CampUtil
import SeedUtil
import _SeedInternal

Actor property PlayerRef auto
Activator property _Seed_PerkNodeController_Provisioning auto
ReferenceAlias property PlayerAlias auto
GlobalVariable property LastSeedRunning auto
GlobalVariable property LastSeedStartupFinished auto
GlobalVariable property LastSeedRunning_KWCheck auto
GlobalVariable property _Seed_QuickstartEnabled auto
GlobalVariable property _Seed_ProvisionsAddPortions auto
GlobalVariable property _Seed_SettingVampireMonitoring auto
GlobalVariable property _Seed_Setting_DiseasePotionsCure auto
GlobalVariable property _Seed_SettingAdditionalDiseases auto
Message property _Seed_StartSleepMsg auto
Message property _Seed_StartingUpMsg auto
Message property _Seed_StartingUpDoneMsg auto
Message property _Seed_FirstStartup_1 auto
Message property _Seed_FirstStartup_2 auto
Message property _Seed_FirstStartup_3 auto
Message property _Seed_FirstStartup_3SE auto
Message property _Seed_Stopping_Begin auto
Message property _Seed_Stopping_End auto
Quest property _Seed_TrackingQuest auto
Spell property _Seed_IntensityPlayerSpell auto
Spell property _Seed_CheckNeedsSpell auto
Spell property _Seed_OpenProvisionsSpell auto
Spell property _Seed_AutoEat auto
Spell property _Seed_AutoDrink auto
Spell property _Seed_ExamineFood auto
Spell property _Seed_DrinkFromStreamSpell auto

Potion Property _Seed_WaterskinEmpty Auto

perk property _Seed_Activators auto

bool started_via_sleep = false
bool isSKYUILoaded = false

Event OnInit()
	isSKYUILoaded = Game.GetFormFromFile(0x01000814, "SkyUI_SE.esp")
	if(isSKYUILoaded == false)
		isSKYUILoaded = Game.GetFormFromFile(0x01000814, "SkyUI.esp")
	endif
	StartUp()
endEvent

function preStart()
	RegisterForSleep()
endFunction

function preStop()
	UnRegisterForSleep()
endFunction

function StartUp()
	; Kicks things off for the player
	if _Seed_TrackingQuest.GetStage() == 0
		if isSKYUILoaded
			_Seed_TrackingQuest.SetStage(10)
		else
			_Seed_TrackingQuest.SetStage(15)
			RegisterForSleep()
		endif
	endif
	
	if _Seed_QuickstartEnabled.GetValueInt() == 2
		SeedDebug(2, "Performing debug start up...")
		Utility.Wait(5)
		OnSleepStop(false)
	endif
endFunction

Event OnSleepStop(bool abInterrupted)
	if abInterrupted
		return
	endif

	; Don't allow the player to start the mod at inopportune times
	; (cart ride at beginning, etc)
	if !Game.IsFightingControlsEnabled()
		return
	endif

	int i = _Seed_StartSleepMsg.Show()
	if i == 0
		started_via_sleep = true
		LastSeedRunning.SetValueInt(2)
		LastSeedRunning_KWCheck.SetValueInt(2)
		StartLastSeed()
	endif
EndEvent

Event StartLastSeed(bool abBypassStartupMessage = false)
	debug.trace("[LastSeed] Starting Last Seed...")
	;_Seed_StartingUpMsg.Show()
	ShowStartupMessages(1, abBypassStartupMessage)
	if !self.IsRunning()
		self.Start()
	endif
	PlayerAlias.ForceRefTo(Game.GetPlayer())
	;_Seed_TrackingQuest.SetStage(20)
	Utility.Wait(2.0)
	ShowStartupMessages(2)
	StartAllSystems()
	SeedUtil.GetCompatibilitySystem().RunCompatibility()
	SeedUtil.GetCompatibilitySystem().SendEvent_LastSeedLoaded()
	; Apply initial vitality condition.
    GetVitalitySystem().ChangeAttributeOverTime()
	debug.trace("[LastSeed] Last Seed is now running.")
	UnregisterForSleep()
	
	;Add Spells
	AddAllSpells()
	
	;ADD WATERSKIN
	;/
	if PlayerRef.GetItemCount(_Seed_WaterskinEmpty) == 0
		PlayerRef.AddItem(_Seed_WaterskinEmpty, 1)
	endif
	/;
	
	ShowStartupMessages(3)
	_Seed_TrackingQuest.SetStage(20)
	LastSeedStartupFinished.setValue(2)
	
	SeedUtil.GetCompatibilitySystem().checkMods(true)
endEvent

Event StopLastSeed()
	debug.trace("[LastSeed] Stopping Last Seed...")
	_Seed_Stopping_Begin.Show()
	
	;if self.IsRunning()
	;	self.Stop()
	;endif
	PlayerAlias.Clear()
	StopAllSystems()
	RemoveAllISMs()
	RemoveAllMeters()
	RemoveAllSpells()
	UnregisterCampfireSkill()
	LastSeedRunning.SetValueInt(1)
	LastSeedStartupFinished.SetValueInt(1)
	LastSeedRunning_KWCheck.SetValueInt(1)
	Utility.wait(5)
	_Seed_Stopping_End.Show()
	debug.trace("[LastSeed] Last Seed shut down successfully.")
endEvent

function StartAllSystems()
	GetDialogHandler().StartSystem()
	getSkillTreeHandler().StartSystem()
	GetFoodDatastoreHandler().StartSystem()
	GetVendorStockSystem().StartSystem()
	if GetHungerSystem().attributeEnabled.getValue() == 2
		GetHungerSystem().StartSystem()
	endif
	if GetThirstSystem().attributeEnabled.getValue() == 2
		GetThirstSystem().StartSystem()
	endif
	if GetFatigueSystem().attributeEnabled.getValue() == 2
		GetFatigueSystem().StartSystem()
	endif
	if GetVitalitySystem().attributeEnabled.getValue() == 2
		GetVitalitySystem().StartSystem()
	endif
	GetDiseaseSystem().startSystem()
	GetSpoilageSystem().startSystem()
	if getFollowerSystem().attributeEnabled.getValue() > 1
		getFollowerSystem().StartSystem()
	endif
	
	GetRescueSystem().StartSystem()
	
	if !isSpecialEdition()
		getMonsterHandler().startMonitoring()
		_Seed_SettingVampireMonitoring.setValue(2)
	endif
	
	SeedUtil.GetVendorStockSystem().setPotionLeveledListsFromSetting()
	
	if _Seed_SettingAdditionalDiseases.getValue() == 2
		getDiseaseHitMonitor().start()
	endif
	
	;TODO: Finish this
	;SeedUtil.GetDiseaseHitMonitor().start()
endFunction

function StopAllSystems()
	if isSpecialEdition()
		int handle = ModEvent.Create("LastSeed_ModStopping")
		if (handle)
			ModEvent.Send(handle)
		endIf
	endif	
	
	getSkillTreeHandler().StopSystem()
	GetVendorStockSystem().StopSystem()
	GetSpoilageSystem().StopSystem()
	GetDialogHandler().StopSystem()
	GetFoodDatastoreHandler().StopSystem()
	GetHungerSystem().StopSystem()
	GetThirstSystem().StopSystem()
	GetFatigueSystem().StopSystem()
	GetVitalitySystem().StopSystem()
	GetAlcoholSystem().StopSystem()
	getFollowerSystem().StopSystem()
	getMonsterHandler().stopMonitoring()
	GetRescueSystem().StopSystem()
	
	GetConsumeManager().StopSystem()
	GetConsumeManagerFollowers().StopSystem()
	GetConsumeManagerParty().StopSystem()
	getDiseaseHitMonitor().stop()
	
	if _Seed_Setting_DiseasePotionsCure.getValue() == 2
		SeedUtil.GetVendorStockSystem().SetPotionLeveledLists(false)
	endif
endFunction

function RemoveAllISMs()
	GetHungerSystem().RemoveAllISMs()
	GetThirstSystem().RemoveAllISMs()
	GetFatigueSystem().RemoveAllISMs()
	GetVitalitySystem().RemoveAllISMs()
endFunction

function ShowStartupMessages(int stage, bool abBypassStartupMessage = true)
	;/
	if _Seed_TrackingQuest.GetStage() == 20
		return
	endif
	/;
	if stage == 1 && !(abBypassStartupMessage || _Seed_TrackingQuest.GetStage() == 20)
		_Seed_FirstStartup_1.Show()
	elseif stage == 2
		;_Seed_FirstStartup_2.Show()
		_Seed_StartingUpMsg.Show()
	elseif stage == 3
		;_Seed_FirstStartup_2.Show()
		_Seed_StartingUpDoneMsg.Show()
		if isSKYUILoaded
			_Seed_FirstStartup_3.Show()
		else
			_Seed_FirstStartup_3SE.Show()
		endif
	endif
endFunction

function UnregisterCampfireSkill()
	GlobalVariable CampfireAPIVersion = Game.GetFormFromFile(0x03F1BE, "Campfire.esm") as GlobalVariable
	if CampfireAPIVersion && CampfireAPIVersion.GetValueInt() >= 4
		bool b = CampUtil.UnregisterPerkTree(_Seed_PerkNodeController_Provisioning, "LastSeed.esp")
	else
		debug.trace("[Campfire] ERROR: Unable to register Campfire Skill System for LastSeed.esp. Campfire was not found or the version loaded is not compatible. Expected CampUtil API 4 or higher, got " + CampfireAPIVersion.GetValueInt())
	endif
endFunction

function RemoveAllMeters()
	if GetSKSELoaded()
		SendEvent_LastSeedRemoveVitalityMeter()
		SendEvent_LastSeedRemoveHungerMeter()
		SendEvent_LastSeedRemoveThirstMeter()
		SendEvent_LastSeedRemoveFatigueMeter()
	endif
endFunction

function RemoveAllSpells()
	PlayerRef.RemovePerk(_Seed_Activators)

	PlayerRef.RemoveSpell(_Seed_CheckNeedsSpell)
	PlayerRef.RemoveSpell(_Seed_OpenProvisionsSpell)
	PlayerRef.RemoveSpell(_Seed_AutoEat)
	PlayerRef.RemoveSpell(_Seed_AutoDrink)
	PlayerRef.RemoveSpell(_Seed_ExamineFood)
	PlayerRef.RemoveSpell(_Seed_DrinkFromStreamSpell)
endFunction

function AddAllSpells()
	PlayerRef.AddPerk(_Seed_Activators)

	PlayerRef.AddSpell(_Seed_CheckNeedsSpell, false)
	PlayerRef.AddSpell(_Seed_OpenProvisionsSpell, false)
	PlayerRef.AddSpell(_Seed_AutoEat, false)
	PlayerRef.AddSpell(_Seed_AutoDrink, false)
	PlayerRef.AddSpell(_Seed_ExamineFood, false)
	PlayerRef.AddSpell(_Seed_DrinkFromStreamSpell, false)
endFunction

;@NOFALLBACK
function SendEvent_LastSeedRemoveVitalityMeter()
	int handle = ModEvent.Create("LastSeed_RemoveVitalityMeter")
    if handle
        ModEvent.Send(handle)
    endif
endFunction

;@NOFALLBACK
function SendEvent_LastSeedRemoveHungerMeter()
	int handle = ModEvent.Create("LastSeed_RemoveHungerMeter")
    if handle
        ModEvent.Send(handle)
    endif
endFunction

;@NOFALLBACK
function SendEvent_LastSeedRemoveThirstMeter()
	int handle = ModEvent.Create("LastSeed_RemoveThirstMeter")
    if handle
        ModEvent.Send(handle)
    endif
endFunction

;@NOFALLBACK
function SendEvent_LastSeedRemoveFatigueMeter()
	int handle = ModEvent.Create("LastSeed_RemoveFatigueMeter")
    if handle
        ModEvent.Send(handle)
    endif
endFunction