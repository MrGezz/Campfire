scriptname _Seed_Compatibility extends ReferenceAlias
; REFERENCED IN:
;_Seed_MainQuest "Last Seed Main Quest" [QUST:07000D72]


import debug
import utility
import CampUtil
import SeedUtil
import _SeedInternal

Quest Property _seed_MainQuest auto

GlobalVariable property _Seed_FoodListsSet auto
GlobalVariable property _Seed_Setting_ProgressiveDiseases auto
GlobalVariable property _Seed_ProgressiveDiseasesEnabled auto
GlobalVariable property _Seed_Setting_AlternateDeathSystem auto

GlobalVariable property _Seed_ProvisionsAddPortions auto
GlobalVariable property _Seed_CACO_Loaded auto
ObjectReference property _Seed_ProvisionsContainerRef Auto

int property SKSE_MIN_VERSION = 10703 autoReadOnly
int property CAMPFIRE_MIN_VERSION = 11100 autoReadOnly

GlobalVariable property _Seed_PreviousVersion auto
GlobalVariable property _Seed_LastSeedVersion auto
GlobalVariable property _Camp_IsSpecialEdition auto
GlobalVariable property _Seed_FocusOnMenu auto
GlobalVariable property _Seed_Setting_DiseasePotionsCure auto
GlobalVariable property _Seed_SettingVampireMonitoring auto
GlobalVariable Property _Seed_Setting_ManualMeterConfig auto
GlobalVariable Property _Seed_Setting_SpoilageEnable auto
GlobalVariable Property _Seed_Setting_SpoilageTemperature auto
GlobalVariable Property _Seed_Setting_FollowersConsumeFood auto
GlobalVariable Property _Seed_Setting_isBetterVampiresLoaded auto

GlobalVariable property _Seed_Setting_VitalityMeterDisplayMode auto
GlobalVariable property _Seed_Setting_HungerMeterDisplayMode auto
GlobalVariable property _Seed_Setting_SystemEnabled_FollowerNeeds auto
GlobalVariable property LastSeedRunning auto
GlobalVariable property LastSeedStartupFinished auto
GlobalVariable property LastSeedRunning_KWCheck auto
GlobalVariable property _Seed_Setting_SpoilRate_IceWraithTeeth auto

GlobalVariable property _Seed_CarriageRode auto

GlobalVariable Property _Seed_Setting_RefreshSystemsOnLoad auto 
GlobalVariable property _Seed_LoadingChecksum auto												  

Spell property _Seed_IntensityPlayerSpell auto
Spell property _Seed_Intensity auto
Spell property _Seed_CheckNeedsSpell auto
Spell property _Seed_OpenProvisionsSpell auto
Spell property _Seed_AutoEat auto
Spell property _Seed_AutoDrink auto
Spell property _Seed_ExamineFood auto
Spell property _Seed_DrinkFromStreamSpell auto
Spell property _Seed_ConfigMenu auto

Potion property _Seed_TestFood auto

LeveledItem Property LItemApothecaryPotionCureHMS75 Auto
LeveledItem Property LItemPotionCureHMS Auto
Formlist Property _Seed_Potion_CureList Auto

Formlist Property _Seed_OblivionLocations Auto
Formlist Property _Seed_OblivionCells Auto
Formlist Property _Seed_OblivionAreas Auto

message property _Seed_HunterbornSoupsWarning auto
message property _Seed_CACOWarning auto

perk property _Seed_Activators auto

string CONFIG_PATH = "../LastSeedData/"
bool datastore_update_required = false

;#PROPERTIES=====================================================================================================================
actor property PlayerRef auto
ReferenceAlias property PlayerAlias auto

bool property isSKYUILoaded auto hidden						; SkyUI 4.1+
bool property isSKSELoaded auto hidden						; SKSE 1.7.3+
bool property isFrostfallLoaded auto hidden					; Frostfall
bool property isBathingInSkyrimLoaded auto hidden			; Bathing in Skyrim
bool property isCACOLoaded auto hidden						; Complete Alchemy and Cooking Overhaul
bool property isDiseasedLoaded auto hidden					; Diseased
bool property isKeepItCleanLoaded auto hidden				; Keep it Clean
bool property isDirtAndBloodLoaded auto hidden				; Dirt and Blood
bool property isBrumaLoaded auto hidden						; Beyond Skyrim - Bruma
bool property isRequiemLoaded auto hidden					; Requiem - The Roleplaying Overhaul
bool property isHunterbornLoaded auto hidden				; Hunterborn
bool property isHunterbornSoupsLoaded auto hidden			; Hunterborn - Soups and Stews
bool property isApothecaryLoaded auto hidden				; Apothecary - An Alchemy Overhaul 
bool property isCRFLoaded auto hidden						; Cutting Room Floor
bool property isCCFishingLoaded auto hidden					; Creation Club - Fishing
bool property isUSSEPLoaded auto hidden						; Unofficial Skyrim Special Edition Patch / Unofficial Skyrim Legendary Edition Patch
bool property isBetterVampiresLoaded auto hidden			; Better Vampires
bool property isWintersunLoaded auto hidden					; Wintersun - Faiths of Skyrim
bool property isFoodExpandedLoaded auto hidden				; Skyrim Food Expanded
bool property isFoodExpandedLoadedFr auto hidden			; Skyrim Food Expanded
bool property isCookingExpandedLoaded auto hidden			; Cooking Expanded
bool property isShadowOfSkyrimLoaded auto hidden			; Shadow of Skyrim - Nemesis and Alternative Death System
bool property isCCTheCauseLoaded auto hidden				; Creation Club - The Cause
bool property isPO3Loaded auto hidden							; powerofthree's Papyrus Extender
bool property isSkyrimVR auto hidden							; Skyrim VR
bool property isWarmDrinksLoaded auto hidden				; Warm Drinks
bool property isProjectAhoLoaded auto hidden				; Project AHO
bool property isInterestingNPCsLoaded auto hidden			; Interesting NPCs
bool property isImmersiveEncountersLoaded auto hidden		; Immersive World Encounters
bool property isWyrmstoothLoaded auto hidden				; Wyrmstooth
bool property isFalskaarLoaded auto hidden					; Falskaar
bool property isNordicCookingLoaded auto hidden				; Nordic Cooking
bool property isMealtimeLoaded auto hidden					; Mealtime
bool property isSAFOLoaded auto hidden						; Skyrim Alchemy and Food Overhaul															 
bool property isFrozenNorthLoaded auto hidden				; The Frozen North														 
;bool property isADERLoaded auto hidden						; Alcohol Drunk Effects Redone														 

Formlist property _Seed_PortionsToProvisionsList auto 


int property isFirstSessionLoad = -1 auto hidden

;#Spellbooks===================================================================

;#Scrolls======================================================================

;#Campfire Skill System============================================================
Activator property _Seed_PerkNodeController_Provisioning auto

;#Misc=============================================================================
Message property _Seed_CriticalError_SKSE auto
Message property _Seed_CriticalError_Campfire auto

;#Upgrade Flags====================================================================

;#Release Notes====================================================================

;/
Event onInit()
	registerForInventoryMenu()
endEvent
/;

Event OnPlayerLoadGame()
	_Seed_LoadingChecksum.setValue(RandomFloat(0.0, 999.0))														
	if LastSeedRunning.getValue() as int == 2
		isFirstSessionLoad = isfirstSessionLoad_Int()
		if isFirstSessionLoad != 1 
			if _Seed_Setting_RefreshSystemsOnLoad.GetValue() == 2
				refreshSystems()
			endIf

			if(LastSeedStartupFinished.getValue() != 2)
				LastSeedStartupFinished.setValue(2)
			endif

			RunUpdate()
			RunCompatibility()
			checkMods()
			_Seed_CarriageRode.setValue(1)
		endif
		; RegisterForKeysOnLoad()
		; RegisterForControlsOnLoad()
		RegisterForEventsOnLoad()
	
		; Notify that we are finished loading up.
		SendEvent_LastSeedLoaded()
	endif
endEvent

Function RunUpdate()
	float currentVersion = _Seed_LastSeedVersion.GetValue()
	float latestVersion = 4.6
	;Fix Version Number
	if currentVersion == 100.0
		_Seed_LastSeedVersion.SetValue(1.0)
	endif
	
	;Update 1.1 - Restart Spoilage System
	if currentVersion <= 1.0
		GetSpoilageSystem().StopSystem()
		Utility.wait(1)
		GetSpoilageSystem().StartSystem()
	endif
	
	;Update 1.3 - Update Meters
	if currentVersion < 1.3
		If _Seed_Setting_HungerMeterDisplayMode.getValueInt() == 5
			_Seed_Setting_HungerMeterDisplayMode.setValueInt(0)
		Endif
		if _Seed_Setting_SpoilageEnable.getValueInt() != 2
			GetSpoilageSystem().StopSystem()
		endif
	Endif  

	;Update 2.0
	if currentVersion < 2.0 
		; Disable Old Temperature Tracking
		_Seed_Setting_SpoilageTemperature.setValue(1)

		; Enable New Spoilage Temperature Tracking
		if _Seed_Setting_SpoilageEnable.getValueInt() == 2
			GetSpoilageSystem().OnUpdateGameTime()
		endif
		
		; Enable Party Needs
		;/
		if _Seed_Setting_SystemEnabled_FollowerNeeds.GetValue() as int == 2
			_Seed_Setting_SystemEnabled_FollowerNeeds.setValue(3)
			GetFollowerSystem().stopSystem()
			GetFollowerSystem().StartPartySystem()
		endif
		/;
	Endif
	
	;Update 2.0 - Enable food magic effects for followers if CACO is enabled
	;/
	if currentVersion < 2.2 
		if isCACOLoaded
			_Seed_Setting_FollowersConsumeFood.setValue(2)
		endif
	Endif
	/;
	
	;Update 2.4 - Set foodlists as being processed
	if currentVersion < 2.4 
		_Seed_FoodListsSet.setValue(2)
	Endif
	
	;Update 3.0
	if currentVersion < 3.0
		; Start Skill Tree
		getSkillTreeHandler().StartSystem()
		playerRef.removeSpell(_Seed_Intensity)
		
		; Added waterskins to backpack
		getFoodDatastoreHandler().addCampfireWaterskinsAll()
		getFoodDatastoreHandler().addCACOInjectedRecords()
		
		; Fix CACO Compatability
		setCACOGlobals()
		
		; Update Jail Time in AttributeSystems
		getHungerSystem().updateJailTime()
		getThirstSystem().updateJailTime()
		getFatigueSystem().updateJailTime()
		getVitalitySystem().updateJailTime()
		getPartyHungerSystem().updateJailTime()
		getPartyThirstSystem().updateJailTime()
		GetFollowerSystem().getHungerSystem(1).updateJailTime()
		GetFollowerSystem().getHungerSystem(2).updateJailTime()
		GetFollowerSystem().getHungerSystem(3).updateJailTime()
		GetFollowerSystem().getThirstSystem(1).updateJailTime()
		GetFollowerSystem().getThirstSystem(2).updateJailTime()
		GetFollowerSystem().getThirstSystem(3).updateJailTime()
		
		;Enable Inventory Filters for Spoilage System
		getSpoilageSystem().setAllInventoryEventFilters()
		
		;Remove Individual Follower Needs
		if _Seed_Setting_SystemEnabled_FollowerNeeds.GetValue() as int == 2
			GetFollowerSystem().stopSystem()
			GetFollowerSystem().StartPartySystem()
		ElseIf _Seed_Setting_SystemEnabled_FollowerNeeds.GetValue() as int == 3 
			_Seed_Setting_SystemEnabled_FollowerNeeds.setValue(2)
			GetPartyHungerSystem().RemoveAllAttributeSpells()
			GetPartyThirstSystem().RemoveAllAttributeSpells()
			
		endif
		
		;Set Global Variable for Multi-Part Food
		LastSeedRunning_KWCheck.setValue(2)
	Endif

	;Update 3.2 - Increase Spoilage Rate for ICe Wraith Teeth
	if currentVersion < 3.2
		_Seed_Setting_SpoilRate_IceWraithTeeth.setValue(120.000000)
	endif
	
	;Update 3.4 - Update Better Vampires Setting
	if currentVersion < 3.4
		if isBetterVampiresLoaded
			_Seed_SettingVampireMonitoring.SetValue(2)
		endif
	endif
	
	;Update 3.5 - Add Better Vampires and CACO Blood Potions, re-add CC Fishing and Requiem Food
	if currentVersion < 3.5
		GetFoodDatastoreHandler().resetFormlistBloodPotions()
		if isBetterVampiresLoaded
			GetFoodDatastoreHandler().addBetterVampiresBloodPotions(false)
		endif
		if isCACOLoaded
			GetFoodDatastoreHandler().addCACOBloodPotions()
		endif
		
		isCCFishingLoaded = false
		isRequiemLoaded = false
	endif
	
	;Update 3.7 - Add River Water
	if currentVersion < 3.7
		GetFoodDatastoreHandler().addRiverWater()
		PlayerRef.AddSpell(_Seed_DrinkFromStreamSpell, false)
	endif
	
	;Update 4.0
	if currentVersion < 4.0
		;Activate MCM
		LastSeedStartupFinished.setValue(2)
		
		; Start New Systems
		GetVendorStockSystem().StartSystem()
		GetRescueSystem().StartSystem()
		
		GetVitalitySystem().update_4_0()
		GetFoodDatastoreHandler().update_4_0()		
		if(isCACOLoaded)
			GetFoodDatastoreHandler().initialiseWaterBottles_CACO()
			GetFoodDatastoreHandler().update_4_0_CACO()
		endif
		if(isBrumaLoaded)
			GetFoodDatastoreHandler().initialiseWaterBottles_Bruma()
		endif
		if(isApothecaryLoaded)
			GetFoodDatastoreHandler().initialiseWaterBottles_Apothecary()
		endif
		if(isRequiemLoaded)
			GetFoodDatastoreHandler().initialiseWaterBottles_Requiem()
		endif
		if(isCRFLoaded)
			GetFoodDatastoreHandler().initialiseWaterBottles_CRF()
		endif
		if(isCCFishingLoaded)
			GetFoodDatastoreHandler().initialiseWaterBottles_CCFishing()
		endif
		if(isHunterbornLoaded)
			GetFoodDatastoreHandler().update_4_0_Hunterborn()
			GetFoodDatastoreHandler().initialiseWaterBottles_Hunterborn()
		endif
	endif
	
	;Update 4.0 Beta
	if(currentVersion < 4.000001)
		GetRescueSystem().update_4_0()
		getDiseaseHitMonitor().start()
		if(_Seed_Setting_ProgressiveDiseases.getValue() == 2)
			_Seed_ProgressiveDiseasesEnabled.setValue(2)
		endif
		getFoodDatastoreHandler().update_4_0_micro()
		if(isCACOLoaded)
			getFoodDatastoreHandler().initialiseMultiPartFood_CACO()
		endif
	endif
	
	if currentVersion < 4.2
		if isCookingExpandedLoaded
			GetFoodDatastoreHandler().AddCookingExpanded(false)
		endif
	Endif
	
	if currentVersion < 4.3
		getFoodDataStoreHandler().update_4_3()
		GetFollowerSystem().suspendNeeds(1, none)
		GetFollowerSystem().suspendNeeds(2, none)
		GetFollowerSystem().suspendNeeds(3, none)
		
		PlayerRef.AddPerk(_Seed_Activators)
	Endif
	
	if currentVersion < 4.4
		getPartyThirstSystem().update_4_4()
	Endif
	
	if currentVersion < 4.6
		StartInnMeals(false)
		getFoodDataStoreHandler().update_4_6()
	Endif
			
	; Update the previous version value with the current version
	if  currentVersion < latestVersion
		_Seed_LastSeedVersion.SetValue(latestVersion)
	endif
endFunction

function ErrorSKSE(int version)
	trace("[LastSeed][Warning] Detected SKSE version " + ((version as float) / 10000) + ". Expected " + ((SKSE_MIN_VERSION as float) / 10000) + " or newer. Using Fallback Mode.")
	_Seed_CriticalError_SKSE.Show(((version as float) / 10000), ((SKSE_MIN_VERSION as float) / 10000))
endFunction

function FatalErrorCampfire(float version)
	float version_formatted = ((version as float) / 10000)
	float min_version_formatted = ((CAMPFIRE_MIN_VERSION as float) / 10000)
	trace("[LastSeed][ERROR] Detected Campfire version " + version_formatted + ", out of date! Expected " + min_version_formatted + " or newer.")
	while true
		_Seed_CriticalError_Campfire.Show(version_formatted, min_version_formatted)
		utility.wait(3.0)
	endWhile
endFunction

function RunCompatibility()
	trace("[LastSeed]======================================================================================================")
	trace("[LastSeed]                    Last Seed is now performing start-up and compatibility checks.                    ")
	trace("[LastSeed]     Papyrus warnings related to missing files may follow. These are NORMAL and should be ignored.    ")
	trace("[LastSeed]======================================================================================================")
	
	;if _Camp_IsSpecialEdition.GetValueInt() != 2
	if isSpecialEdition() == false
		bool skse_loaded = SKSE.GetVersion()
		if skse_loaded
			int skse_version = (SKSE.GetVersion() * 10000) + (SKSE.GetVersionMinor() * 100) + SKSE.GetVersionBeta()
			if skse_version < SKSE_MIN_VERSION
				isSKSELoaded = false
				ErrorSKSE(skse_version)
			else
				isSKSELoaded = true
				trace("[LastSeed] Detected SKSE version " + ((skse_version as float) / 10000) + " (expected " + ((SKSE_MIN_VERSION as float) / 10000) + " or newer, success!)")
			endif
		else
			isSKSELoaded = false
			ErrorSKSE(0)
		endif
	else
		; IcZ (SE 1.7.104): 5.3 only checked SKSE on Legendary Edition, so on Special Edition
		; isSKSELoaded stayed false and every @NOFALLBACK mod event (settings profile load on startup,
		; meter preset) was silently skipped. SKSE64 reports major version 2.
		isSKSELoaded = SKSE.GetVersion() >= 2
		if isSKSELoaded
			trace("[LastSeed] Detected SKSE64 " + SKSE.GetVersion() + "." + SKSE.GetVersionMinor() + "." + SKSE.GetVersionBeta() + ".")
		else
			ErrorSKSE(0)
		endif
	endif

	VanillaGameLoadUp()

	; Verify that the food datastore has been populated.
	CheckDatastore()

	float campfire_version = CampUtil.GetCampfireVersion()
	if campfire_version < CAMPFIRE_MIN_VERSION
		FatalErrorCampfire(campfire_version)
	else
		trace("[LastSeed] Detected Campfire version " + campfire_version + " (expected " + CAMPFIRE_MIN_VERSION + " or newer, success!)")
	endif
	
		
	;Restart Translation Handler
	GetTranslationHandler().stop()
	wait(0.1)
	GetTranslationHandler().start()
	
	;Check SkyUI Loaded (either name, whatever _Camp_IsSpecialEdition says)
	isSKYUILoaded = IsPluginLoaded(0x01000814, "SkyUI_SE.esp") || IsPluginLoaded(0x01000814, "SkyUI.esp")
		
	trace("[LastSeed]======================================================================================================")
	trace("[LastSeed]                      Last Seed start-up and compatibility checks complete.   		                ")
	trace("[LastSeed]======================================================================================================")
	
	; RegisterForControlsOnLoad()
	RegisterForEventsOnLoad()
	RegisterForMenusOnLoad()
	;AddStartupSpells()
	if isSKYUILoaded
		PlayerRef.RemoveSpell(_Seed_ConfigMenu)
	else
		PlayerRef.AddSpell(_Seed_ConfigMenu, false)
	endif
	; RegisterCampfireSkill()

	; Load a meter preset for the user's display aspect ratio
	If _Seed_Setting_ManualMeterConfig.getValueInt() == 2
		SendEvent_SKSE_ApplyMeterPreset(2)
	Endif
	
	if isSKYUILoaded
		SendEvent_SKSE_LoadProfileOnStartup()
	endif
endFunction

function checkMods(bool forceSetFoodProperties = false)
	; Check Skyrim VR
	bool lastSkyrimVRCheck = isSkyrimVR
	isSkyrimVR = IsPluginLoaded(0x00000BD7, "SkyrimVR.esm")	
	if isSkyrimVR && lastSkyrimVRCheck == false
		_Seed_SettingVampireMonitoring.SetValue(2)
		getMonsterHandler().startMonitoring()
	endif
	
	;CHECK FROSTFALL
	bool lastFrostfallCheck = isFrostfallLoaded
	isFrostfallLoaded = IsPluginLoaded(0x00064AF8, "Frostfall.esp")
	if isFrostfallLoaded && lastFrostfallCheck == false
		GetFoodDatastoreHandler().AddFrostfall(false)
	endif
	
	;CHECK BATHING IN SKYRIM
	isBathingInSkyrimLoaded = IsPluginLoaded(0x000279ED, "Bathing in Skyrim - Main.esp")
	
	;CHECK KEEP IT CLEAN
	isKeepItCleanLoaded = IsPluginLoaded(0x00183DFC, "Keep It Clean.esp")
	
	; DIRT AND BLOOD
	isDirtAndBloodLoaded = IsPluginLoaded(0x00000824, "Dirt and Blood - Dynamic Visuals.esp")
		
	;CHECK DISEASED IN SKYRIM
	isDiseasedLoaded = IsPluginLoaded(0x0000288A, "Diseased.esp")
	
	;CHEKC MEALS IN INNS
	;StartInnMeals(true)
	
	;CHECK CACO
	bool lastCACOCheck = isCACOLoaded
	bool thisCACOCheck = IsPluginLoaded(0x000A2A3F, "Complete Alchemy & Cooking Overhaul.esp")
	if thisCACOCheck
		_Seed_CACO_Loaded.SetValue(2)
	else
		_Seed_CACO_Loaded.SetValue(1)
	endif
	if thisCACOCheck == true && lastCACOCheck == false
		if _Seed_CACOWarning.show() == 1
			isCACOLoaded = true
			GetFoodDatastoreHandler().addCACO(false)
			setCACOGlobals()
		endif
	endif
	
	;CHECK Beyond Skyrim - Bruma
	bool lastBrumaCheck = isBrumaLoaded
	isBrumaLoaded = IsPluginLoaded(0x00001961, "BSHeartland.esm")
	if isBrumaLoaded && lastBrumaCheck == false
		GetFoodDatastoreHandler().AddBruma(false)
	endif
	
	;CHECK Requiem
	bool lastRequiemCheck = isRequiemLoaded
	isRequiemLoaded = IsPluginLoaded(0x002F389E, "Requiem.esp")
	if isRequiemLoaded && lastRequiemCheck == false
		GetFoodDatastoreHandler().AddRequiem(false)
	endif
	
	;CHECK Hunterborn
	bool lastHunterbornCheck = isHunterbornLoaded
	isHunterbornLoaded = IsPluginLoaded(0x00003367, "Hunterborn.esp")
	if isHunterbornLoaded && lastHunterbornCheck == false
		GetFoodDatastoreHandler().AddHunterborn(false)
	endif
	
	;CHECK Apothecary
	bool lastApothecaryCheck = isApothecaryLoaded
	isApothecaryLoaded = IsPluginLoaded(0x000752ED, "ApothecaryFood.esp")
	if isApothecaryLoaded && lastApothecaryCheck == false
		GetFoodDatastoreHandler().addApothecary(false)
	endif
	
	;CHECK Cutting Room Floor
	bool lastCRFCheck = isCRFLoaded
	isCRFLoaded = IsPluginLoaded(0x000368FD, "Cutting Room Floor.esp")
	if isCRFLoaded && lastCRFCheck == false
		GetFoodDatastoreHandler().addCRF(false)
	endif
	
	;CHECK Fishing
	bool LastCCFishingCheck = isCCFishingLoaded
	isCCFishingLoaded = IsPluginLoaded(0x000008BF, "ccBGSSSE001-Fish.esm")	; ccBGSSSE001_DLCDetectionQuest [QUST:0x000008BF]
	if isCCFishingLoaded && LastCCFishingCheck == false
		GetFoodDatastoreHandler().addCCFishing(false)
	endif
	
	;CHECK Better Vampires
	bool LastBetterVampiresCheck = isBetterVampiresLoaded
	isBetterVampiresLoaded = IsPluginLoaded(0x0003E7D3, "Better Vampires.esp")	; BetterVampiresInitializationQuest [QUST:0x0003E7D3]
	if isBetterVampiresLoaded && !LastBetterVampiresCheck
		_Seed_Setting_isBetterVampiresLoaded.setValue(2)
		_Seed_SettingVampireMonitoring.SetValue(2)
		GetFoodDatastoreHandler().addBetterVampiresBloodPotions(false)
	elseif !isBetterVampiresLoaded && LastBetterVampiresCheck
		_Seed_Setting_isBetterVampiresLoaded.setValue(1)
	endif
	
	;CHECK Unnoficial Patches
	string USSEP_ESP = "Unofficial Skyrim Special Edition Patch.esp"
	if !isSpecialEdition()
		USSEP_ESP = "Unofficial Skyrim Legendary Edition Patch.esp"
	endif
	bool LastUSSEPCheck = isUSSEPLoaded
	isUSSEPLoaded = IsPluginLoaded(0x00001891, USSEP_ESP)	; USKPChangeLocation17 [QUST:0x00001891]
	if isUSSEPLoaded && LastUSSEPCheck == false
		GetFoodDatastoreHandler().addUSSEP(false)
	endif
	
	;CHECK Wintersun
	bool lastWintersunCheck = isWintersunLoaded
	isWintersunLoaded = IsPluginLoaded(0x00005901, "Wintersun - Faiths of Skyrim.esp")	; WSN_TrackerQuest_Quest [QUST:0x00005901]
	if isWintersunLoaded && lastWintersunCheck == false
		GetFoodDatastoreHandler().addWintersun(false)
	endif
	
	;CHECK Skyrim Food Expanded
	bool lastFoodExpandedCheck = isFoodExpandedLoaded
	isFoodExpandedLoaded = IsPluginLoaded(0x00000D61, "Ana_Skyrim Food Expanded - EN.esp")	; FoodFishSoup "Fish soup" [ALCH:0x00000D61]
	if isFoodExpandedLoaded && lastFoodExpandedCheck == false
		GetFoodDatastoreHandler().AddFoodExpanded(false)
	endif
	if !(isFoodExpandedLoaded)
		bool lastFoodExpandedCheckFr = isFoodExpandedLoadedFr
		isFoodExpandedLoadedFr = IsPluginLoaded(0x00000D61, "Ana_Skyrim Food Expanded.esp")	; FoodFishSoup "Fish soup" [ALCH:0x00000D61]
		if isFoodExpandedLoaded && lastFoodExpandedCheck == false
			GetFoodDatastoreHandler().AddFoodExpanded(false)
		endif
	endif
	
	; CHECK Cooking Expanded
	bool lastCookingExpandedCheck = isCookingExpandedLoaded
	isCookingExpandedLoaded = IsPluginLoaded(0x000066A9, "CookingExpanded.esp")	; CEModSupportQuest [QUST:0x000066A9]
	if isCookingExpandedLoaded && lastCookingExpandedCheck == false
		GetFoodDatastoreHandler().AddCookingExpanded(false)
	endif
	
	;CHECK Shadow of Skyrim
	bool lastShadowOfSkyrimCheck = isShadowOfSkyrimLoaded
	isShadowOfSkyrimLoaded = IsPluginLoaded(0x0000080A, "Shadow of Skyrim.esp")    ; _ShadowOfSkyrimQuest "Nemesis and Respawn Manager" [QUST:0x0000080A]
	if isShadowOfSkyrimLoaded && lastShadowOfSkyrimCheck == false
		_Seed_Setting_AlternateDeathSystem.setValue(2)
	EndIf
	
	; CHECK Creation Club - The Cause								  
	bool lastCCTheCauseCheck = isCCTheCauseLoaded
	isCCTheCauseLoaded = IsPluginLoaded(0x0006BFC1, "ccbgssse067-daedinv.esm")	; ccBGSSSE067_Quest "The Cause" [QUST:0606BFC1]
	if isCCTheCauseLoaded && lastCCTheCauseCheck == false
		Location DeadlandsLocation = Game.GetFormFromFile(0x00033F39, "ccbgssse067-daedinv.esm") as Location	;ccBGSSSE067_DeadlandsLocation "Deadlands" [LCTN:05033F39]
		if(DeadlandsLocation)
			_Seed_OblivionLocations.AddForm(DeadlandsLocation)
		endif
	endif
		
	; Check powerofthree's Papyrus Extender
	If GetSKSELoaded()
		int rand = 0
		rand = PO3_SKSEFunctions.GenerateRandomInt(1, 2)
		isPO3Loaded = rand > 0
	Endif
	
	;CHECK Warn Drinks
	bool lastWarmDrinksCheck = isWarmDrinksLoaded 
	isWarmDrinksLoaded = IsPluginLoaded(0x0000FB0A, "Warm Drinks.esp")
	if isWarmDrinksLoaded == true && lastWarmDrinksCheck == false
		GetFoodDatastoreHandler().AddWarmDrinks(false)
	endif
	
	;CHECK Project AHO
	bool lastProjectAhoCheck = isProjectAhoLoaded 
	isProjectAhoLoaded = IsPluginLoaded(0x007A10E5, "Dwarfsphere.esp")	; ProjectAHOEpisode01 "Project AHO" [QUST:0x007A10E5]
	if isProjectAhoLoaded == true && lastProjectAhoCheck == false
		GetFoodDatastoreHandler().AddProjectAho(false)
	endif
	
	;CHECK Interesting NPCs
	bool lastInterstingNPCsCheck = isInterestingNPCsLoaded 
	isInterestingNPCsLoaded = IsPluginLoaded(0x000012FA, "3DNPC.esp")	;DialogueRongeir "Rongeir Ice-Eye" [QUST:0x000012FA]
	if isInterestingNPCsLoaded == true && lastInterstingNPCsCheck == false
		GetFoodDatastoreHandler().AddInterestingNPCs(false)
	endif
	
	;CHECK Immersive Encounters
	bool lastImmersiveEncountersCheck = isImmersiveEncountersLoaded 
	isImmersiveEncountersLoaded = IsPluginLoaded(0x0000FB0A, "Immersive Encounters.esp")	;WE_SetteWanderer01Forest "Wanderer Encounter - Forest" [QUST:0x0000FB0A]
	if isImmersiveEncountersLoaded == true && lastImmersiveEncountersCheck == false
		GetFoodDatastoreHandler().AddImmersiveEncounters(false)
	endif
	
	;CHECK Wyrmstooth
	bool lastWyrmstoothCheck = isWyrmstoothLoaded 
	isWyrmstoothLoaded = IsPluginLoaded(0x00022528, "Wyrmstooth.esp")	;WTDragonHunt "Wyrmstooth" [QUST:02022528]
	if isWyrmstoothLoaded == true && lastWyrmstoothCheck == false
		GetFoodDatastoreHandler().AddWyrmstooth(false)
	endif
	
	;CHECK Falskaar
	bool lastFalskaarCheck = isFalskaarLoaded 
	isFalskaarLoaded = IsPluginLoaded(0x00022334, "Falskaar.esm")	;FalskaarUniqueDialogue "Falskaar Unique Dialogue" [QUST:01022334]
	if isFalskaarLoaded == true && lastFalskaarCheck == false
		GetFoodDatastoreHandler().AddFalskaar(false)
	endif

	;CHECK NORDIC COOKING
	bool lastNordicCookingCheck = isNordicCookingLoaded 
	isNordicCookingLoaded = IsPluginLoaded(0x00000D62, "NordicCooking.esp")
	if isNordicCookingLoaded == true && lastNordicCookingCheck == false
		GetFoodDatastoreHandler().AddNordicCooking(false)
	endif
	
	;CHECK MEALTIME
	bool lastMealtimeCheck = isMealtimeLoaded 
	isMealtimeLoaded = IsPluginLoaded(0x0006FEB3, "mealtimeyum.esp")
	if isMealtimeLoaded == true && lastMealtimeCheck == false
		GetFoodDatastoreHandler().AddMealtime(false)
	endif

	;CHECK SKYRIM ALCHEMY AND FOOD OVERHAUL
	bool lastSAFOCheck = isSAFOLoaded 
	isSAFOLoaded = IsPluginLoaded(0x00000806, "SAFO.esp")
	if isSAFOLoaded == true && lastSAFOCheck == false
		GetFoodDatastoreHandler().AddSAFO(false)
	endif
	
	;CHECK FROZEN NORTH
	isFrozenNorthLoaded = IsPluginLoaded(0x00000828, "TheFrozenNorth.esp")	;_CNM_ColdQuest [QUST:0x00000828]


	; Reset portions to provisions list
	_Seed_PortionsToProvisionsList.Revert()

	;Update Food Properties
	if isfirstSessionLoad == 2 || forceSetFoodProperties
		getFoodMaintenanceHandler().setFoodProperties()
	endif
endFunction


int function isfirstSessionLoad_Int()
	if GetSKSELoaded() 
		If(_Seed_TestFood.GetGoldValue() == 1)
			_Seed_TestFood.SetGoldValue(2)
			return 2
		else
			return 1
		endif
	endif
	return -1
endFunction

Function refreshSystems()
	SeedDebug(1, "[Compatability]: Refreshing Systems.")
	if(!PlayerRef)
		PlayerRef = Game.GetPlayer()
	endif
	GetMainSystem().PlayerAlias.ForceRefTo(PlayerRef)
	GetHungerSystem().refreshSystem()
	GetThirstSystem().refreshSystem()
	GetPartyHungerSystem().refreshSystem()
	GetPartyThirstSystem().refreshSystem()
	GetFatigueSystem().refreshSystem()
	GetVitalitySystem().refreshSystem()
	GetAlcoholSystem().RefreshSystem()
	GetSkoomaSystem().RefreshSystem()
	GetSpoilageSystem().RefreshSystem()
	GetVendorStockSystem().RefreshSystem()
	if(_Seed_SettingVampireMonitoring.GetValue() == 2)
		getMonsterHandler().startMonitoring()
	endIf
EndFunction

function StartInnMeals(bool startup)
	if IsPluginLoaded(0x00000807, "Last Seed - Inn Meals.esp")
		Quest _MM_DialogHandlerQuest = (Game.GetFormFromFile(0x00000807, "Last Seed - Inn Meals.esp") as Quest)
		if startup
			if !_MM_DialogHandlerQuest.IsRunning()
				_MM_DialogHandlerQuest.Start()
			endif
		else
			if _MM_DialogHandlerQuest.IsRunning()
				_MM_DialogHandlerQuest.Stop()
			endif
		endif
	endif
endFunction

function VanillaGameLoadUp()
	; TBD
endFunction

function RegisterForControlsOnLoad()
	; TBD
endFunction

function RegisterForMenusOnLoad()
	if GetSKSELoaded()
		RegisterForMenu("Crafting Menu")
		RegisterForMenu("Dialogue Menu")
		SeedDebug(0, "[Compatibility]Registered for menus")
	endif
endFunction

function RegisterForEventsOnLoad()
	GetHungerSystem().RegisterForEvents()
	GetThirstSystem().RegisterForEvents()
	GetFatigueSystem().RegisterForEvents()
	GetVitalityMeterHandler().RegisterForEvents()
	GetHungerMeterHandler().RegisterForEvents()
	GetThirstMeterHandler().RegisterForEvents()
	GetFatigueMeterHandler().RegisterForEvents()
endFunction

;DEPRECIATED - See  _Seed_Main::AddAllSpells
function AddStartupSpells()
	PlayerRef.AddSpell(_Seed_CheckNeedsSpell, false)
	PlayerRef.AddSpell(_Seed_OpenProvisionsSpell, false)
	PlayerRef.AddSpell(_Seed_AutoEat, false)
	PlayerRef.AddSpell(_Seed_AutoDrink, false)
	PlayerRef.AddSpell(_Seed_ExamineFood, false)
	PlayerRef.AddSpell(_Seed_DrinkFromStreamSpell, false)
endFunction

function SendEvent_LastSeedLoaded()
	FallbackEventEmitter emitter = GetEventEmitter_LastSeedLoaded()
	int handle = emitter.Create("LastSeed_Loaded")
	if handle
		emitter.Send(handle)
	endif
endFunction

function RegisterCampfireSkill()
	GlobalVariable CampfireAPIVersion = Game.GetFormFromFile(0x03F1BE, "Campfire.esm") as GlobalVariable
	if CampfireAPIVersion && CampfireAPIVersion.GetValueInt() >= 4
		bool b = CampUtil.RegisterPerkTree(_Seed_PerkNodeController_Provisioning, "LastSeed.esp")
	else
		debug.trace("[Campfire] ERROR: Unable to register Campfire Skill System for LastSeed.esp. Campfire was not found or the version loaded is not compatible. Expected CampUtil API 4 or higher, got " + CampfireAPIVersion.GetValueInt())
	endif
endFunction

function CheckDatastore()
	SeedDebug(3, "Implement datastore sanity checking not yet implemented.")
	; @TODO
endFunction

; IcZ (SE 1.7.104): always resolved through GetFormFromFile. Game.GetModByName() returns 255 for
; light (ESL-flagged) plugins on Special Edition, which reported them as missing - and with SKSE now
; detected on SE that branch would run for every check. The FormID path is the one 5.3 already took
; on SE, so detection results do not change.
bool function IsPluginLoaded(int iFormID, string sPluginName)
	bool b = Game.GetFormFromFile(iFormID, sPluginName)
	if b
		debug.trace("[LastSeed] Loaded: " + sPluginName)
		return true
	endif
	return false
endFunction

;@NOFALLBACK
function SendEvent_SKSE_LoadProfileOnStartup()
	if isSKSELoaded
		int handle = ModEvent.Create("LastSeed_LoadProfileOnStartup")
		if handle
			ModEvent.Send(handle)
		endif
	endif
endFunction

;@NOFALLBACK
function SendEvent_SKSE_ApplyMeterPreset(int aiValue)
	if isSKSELoaded
		int handle = ModEvent.Create("LastSeed_ApplyMeterPreset")
		if handle
			ModEvent.PushInt(handle, aiValue)
			ModEvent.Send(handle)
		endif
	endif
endFunction

Event OnMenuOpen(String MenuName)
	SeedDebug(0, "[_Seed_Main] Menu Opened. MenuName = " + MenuName)

	;FOCUS
	If (MenuName == "Crafting Menu") || (MenuName == "Dialogue Menu")
		_Seed_FocusOnMenu.SetValue(2)
	EndIf
EndEvent
Event OnMenuClose(String MenuName)

	;FOCUS
	If (MenuName == "Crafting Menu") || (MenuName == "Dialogue Menu")
		_Seed_FocusOnMenu.SetValue(1)
	EndIf
EndEvent


;/-----------------
DEPRECIATED METHODS
-----------------/;
bool function isfirstSessionLoad()
	if (GetSKSELoaded() && _Seed_TestFood.GetGoldValue() == 1)
			_Seed_TestFood.SetGoldValue(2)
			return true
	endif
	return false
endFunction


;LEGACY METHOD: Change the Cure Potions Lists
Function SetPotionLeveledLists(Bool addPotions = True)
	GetVendorStockSystem().SetPotionLeveledLists(addPotions)
EndFunction
									  
function setCACOGlobals()
	setExternalGlobal(0x004E3D11, "Complete Alchemy & Cooking Overhaul.esp", 0)	; CACO_WellActivatorEnabled [GLOB:0x004E3D11]
	setExternalGlobal(0x002CADF4, "Complete Alchemy & Cooking Overhaul.esp", 0)	; CACO_AlcoholDrunkVisuals [GLOB:0x002CADF4]
	setExternalGlobal(0x002CADF3, "Complete Alchemy & Cooking Overhaul.esp", 0)	; CACO_AlcoholDrunkAnimations [GLOB:0x002CADF3]
	setExternalGlobal(0x005D217E, "Complete Alchemy & Cooking Overhaul.esp", 0)	; CACO_SleepChangesEnabled [GLOB:0x005D217E]
	setExternalGlobal(0x004DEBED, "Complete Alchemy & Cooking Overhaul.esp", 0)	; CACO_OptionCraftFreeWater [GLOB:0x004DEBED]
	;_Seed_Setting_FollowersConsumeFood.setValue(2)
endFunction

function setExternalGlobal(int aiFormID, String espName, float value)
	GlobalVariable theGlobal = Game.GetFormFromFile(aiFormID, espName) as GlobalVariable
	if theGlobal
		theGlobal.setValue(value)
	endif
endFunction

Int Function GetPlayerExposureLevelFrozenNorth()
	Spell warm = Game.GetFormFromFile(0x00000832, "TheFrozenNorth.esp") as Spell	
	If warm && PlayerRef.HasSpell(warm)
		Return 1
	endif
	
	Spell chilly = Game.GetFormFromFile(0x00000826, "TheFrozenNorth.esp") as Spell 
	if chilly && PlayerRef.HasSpell(chilly)
		return 3
	endif
	
	Spell cold = Game.GetFormFromFile(0x00000802, "TheFrozenNorth.esp") as Spell 
	if cold && PlayerRef.HasSpell(cold)
		return  4
	endif
	
	Spell freezing = Game.GetFormFromFile(0x00000803, "TheFrozenNorth.esp") as Spell 
	if freezing && PlayerRef.HasSpell(freezing)
		return  5
	endif
	
	Return 2
endFunction


;/
VAMPIRE SCRIPTS: SSE ONLY
/;
Event OnVampireFeed(Actor akTarget)
	if isSpecialEdition() && _Seed_SettingVampireMonitoring.GetValueInt() != 2
		VampireFeed()
	endif
endEvent