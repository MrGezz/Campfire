Scriptname _Seed_SkyUIConfigPanelScript extends SKI_ConfigBase

import _CampInternal
import SeedUtil
import CampUtil
import _SeedInternal


string CONFIG_PATH = "../LastSeedData/"

; External scripts
; TODO: Remove this? I think you can access through API now...
_Seed_Compatibility property Compatibility auto

Actor property PlayerRef auto

FormList property _Seed_Bread auto
FormList property _Seed_MeatRaw auto
FormList property _Seed_MeatCooked auto
FormList property _Seed_SmallGameRaw auto
FormList property _Seed_SmallGameCooked auto
FormList property _Seed_FishRaw auto
FormList property _Seed_FishCooked auto
FormList property _Seed_SeafoodRaw auto
FormList property _Seed_SeafoodCooked auto
FormList property _Seed_Vegetables auto
FormList property _Seed_Fruit auto
FormList property _Seed_Cheese auto
FormList property _Seed_Treats auto
FormList property _Seed_Pastries auto
FormList property _Seed_Stews auto
FormList property _Seed_CheeseBowls auto
FormList property _Seed_DrinkMilk auto
FormList property _Seed_DrinkAlcoholic auto
FormList property _Seed_DrinkNonAlcoholic auto
FormList property _Seed_Preserved auto
FormList property _Seed_SaltedFood auto
FormList property _Seed_NotFood auto
FormList property _Seed_BloodPotions auto

FormList property _Seed_Food_RestoreHungerMinor auto
FormList property _Seed_Food_RestoreHungerMajor auto
FormList property _Seed_Food_RestoreHungerSuperior auto
FormList property _Seed_Food_RestoreHungerMassive auto

FormList property _Seed_DrinkAlcoholicAle auto
FormList property _Seed_DrinkAlcoholicWine auto
FormList property _Seed_DrinkAlcoholicSpirit auto

FormList property _Seed_DrinkSkoomaWeak auto
FormList property _Seed_DrinkSkoomaStrong auto

FormList property _Seed_SystemFoods auto

GlobalVariable property ProvisioningPerkPointsTotal auto

GlobalVariable property _Seed_AttributeHunger auto
GlobalVariable property _Seed_AttributeHungerMax auto
GlobalVariable property _Seed_AttributeThirst auto
GlobalVariable property _Seed_AttributeThirstMax auto
GlobalVariable property _Seed_AttributeFatigue auto
GlobalVariable property _Seed_AttributeFatigueMax auto
GlobalVariable property _Seed_AttributeVitality auto
GlobalVariable property _Seed_AttributeVitalityMax auto
GlobalVariable property _Seed_AttributeDrunk auto
GlobalVariable property _Seed_AttributeSkooma auto

GlobalVariable property LastSeedRunning auto
GlobalVariable property LastSeedStartupFinished auto
GlobalVariable property LastSeedStartingUp auto
GlobalVariable property _Seed_Setting_Presets_Gameplay auto
GlobalVariable property _Seed_Setting_DiminishingFoodReturns auto
GlobalVariable property _Seed_Setting_AutoConsume auto
GlobalVariable property _Seed_ProvisionsAddPortions auto
GlobalVariable property _Seed_Setting_DisplayTutorials auto
GlobalVariable property _Seed_Setting_ResetTutorials auto
GlobalVariable property _Seed_Setting_NeedsAffectsRegeneration auto
GlobalVariable property _Seed_Setting_NeedsForceFeedback auto
GlobalVariable property _Seed_Setting_NeedsSFX auto
GlobalVariable property _Seed_Setting_NeedsVFX auto
GlobalVariable property _Seed_Setting_Notifications auto
GlobalVariable property _Seed_Setting_Notifications_Followers auto
GlobalVariable property _Seed_Setting_AnimatePlayer auto
GlobalVariable property _Seed_Setting_AnimatePlayer_FirstPerson auto
GlobalVariable property _Seed_Setting_AnimateFollowers auto
GlobalVariable property _Seed_Setting_AnimatePickup auto
GlobalVariable property _Seed_Setting_SystemEnabled_Fatigue auto
GlobalVariable property _Seed_Setting_SystemEnabled_Hunger auto
GlobalVariable property _Seed_Setting_SystemEnabled_Thirst auto
GlobalVariable property _Seed_Setting_SystemEnabled_Vitality auto
GlobalVariable property _Seed_Setting_SystemEnabled_FollowerNeeds auto
GlobalVariable property _Seed_Setting_PartyCount auto
GlobalVariable property _Seed_Setting_FollowersConsumeFood auto
GlobalVariable property _Seed_Setting_RateMulti_Hunger auto
GlobalVariable property _Seed_Setting_RateMulti_Thirst auto
GlobalVariable property _Seed_Setting_RateMulti_Fatigue auto
GlobalVariable property _Seed_Setting_RateMulti_Alcohol auto
GlobalVariable property _Seed_Setting_RateMulti_Skooma auto
GlobalVariable property _Seed_Setting_RateMulti_Vitality auto
GlobalVariable property _Seed_Setting_VampireBehavior auto
GlobalVariable property _Seed_Setting_SeranaDrinksBlood auto
GlobalVariable property _Seed_Setting_Focus auto
GlobalVariable property _Seed_Setting_FoodPortioning auto
GlobalVariable property _Seed_Setting_ThirstAffectsMovement auto
GlobalVariable property _Seed_Setting_NoVitalityMode auto
GlobalVariable property _Seed_Setting_FoodPriceMulti auto
GlobalVariable property _Seed_Setting_FoodWeightMulti auto
GlobalVariable property _Seed_Setting_AddNames auto
GlobalVariable property _Seed_Setting_ResetFoodLists auto
GlobalVariable property _Seed_SettingVampireMonitoring auto
GlobalVariable property _Seed_SettingPlayerIsLich auto
GlobalVariable property _Seed_Setting_AlternateDeathSystem auto
GlobalVariable property _Seed_Setting_RefreshSystemsOnLoad auto
GlobalVariable property _Seed_Setting_NeedsAffectedByRegeneration auto
GlobalVariable property _Seed_Setting_CannibalismEnabled auto
GlobalVariable property _Seed_Settings_EnableWaterBottles auto
GlobalVariable property _Seed_Settings_FocusInDungeons auto
GlobalVariable property _Seed_Settings_InnDialogWater auto
GlobalVariable property _Seed_Settings_InnDialogMeals auto
;ALCOHOL AND DISEASE
GlobalVariable property _Seed_Setting_AlcoholSystemEnabled auto
GlobalVariable property _Seed_Setting_SkoomaSystemEnabled auto
GlobalVariable property _Seed_Setting_AlcoholMulti_Ale auto
GlobalVariable property _Seed_Setting_AlcoholMulti_Wine auto
GlobalVariable property _Seed_Setting_AlcoholMulti_Spirits auto
GlobalVariable property _Seed_Setting_SkoomaMulti_Weak auto
GlobalVariable property _Seed_Setting_SkoomaMulti_Strong auto
GlobalVariable property _Seed_Setting_DrunkStumbling auto
GlobalVariable property _Seed_Setting_DiseaseType auto
GlobalVariable property _Seed_Setting_DiseaseChanceRawFood auto
GlobalVariable property _Seed_Setting_DiseaseChanceStaleFood auto
GlobalVariable property _Seed_Setting_DiseaseChanceDirtyWater auto
GlobalVariable property _Seed_Setting_DiseasePotionsCure auto
GlobalVariable property _Seed_Setting_ShrinesCure auto
GlobalVariable property _Seed_Setting_DiseasePriestsCure auto
GlobalVariable property _Seed_Setting_DirtyDiseases auto
GlobalVariable property _Seed_SettingAdditionalDiseases auto
GlobalVariable property _Seed_Settings_DrunkenShenanigans auto

;SPOILAGE
GlobalVariable property _Seed_Setting_SpoilageEnable auto
GlobalVariable property _Seed_Setting_ContainerSpoilageEnable auto
GlobalVariable property _Seed_Setting_ContainerSpoilageRate auto
GlobalVariable property _Seed_Setting_SpoilageRemove auto
GlobalVariable property _Seed_Setting_SpoilageTemperatureMulti auto
; Spoil Rates
GlobalVariable property _Seed_Setting_SpoilRate01_Bread auto
GlobalVariable property _Seed_Setting_SpoilRate02_RawMeat auto
GlobalVariable property _Seed_Setting_SpoilRate03_CookedMeat auto
GlobalVariable property _Seed_Setting_SpoilRate04_RawSmallGame auto
GlobalVariable property _Seed_Setting_SpoilRate05_CookedSmallGame auto
GlobalVariable property _Seed_Setting_SpoilRate06_RawFish auto
GlobalVariable property _Seed_Setting_SpoilRate07_CookedFish auto
GlobalVariable property _Seed_Setting_SpoilRate08_RawSeafood auto
GlobalVariable property _Seed_Setting_SpoilRate09_CookedSeafood auto
GlobalVariable property _Seed_Setting_SpoilRate10_Vegitables auto
GlobalVariable property _Seed_Setting_SpoilRate11_Fruit auto
GlobalVariable property _Seed_Setting_SpoilRate12_Cheese auto
GlobalVariable property _Seed_Setting_SpoilRate13_Treats auto
GlobalVariable property _Seed_Setting_SpoilRate14_Pastry auto
GlobalVariable property _Seed_Setting_SpoilRate15_Stew auto
GlobalVariable property _Seed_Setting_SpoilRate16_CheeseBowls auto
GlobalVariable property _Seed_Setting_SpoilRate17_Milk auto
GlobalVariable property _Seed_Setting_SpoilRate_IceWraithTeeth auto

GlobalVariable property _Seed_Provisions_WeightPerPerson auto
GlobalVariable property _Seed_Setting_LogLevel auto
GlobalVariable property _Seed_Setting_ForceStartMod auto

;Vitality Multipliers
GlobalVariable property _Seed_setting_VitalityExposureMulti auto
GlobalVariable property _Seed_setting_VitalityFatigueMulti auto
GlobalVariable property _Seed_setting_VitalityDiseaseMulti auto
GlobalVariable property _Seed_setting_VitalityThirstMulti auto
GlobalVariable property _Seed_setting_VitalityHungerMulti auto
GlobalVariable property _Seed_setting_VitalityAlcoholMulti auto
GlobalVariable property _Seed_setting_VitalitySkoomaMulti auto


GlobalVariable property _Seed_Setting_ManualMeterConfig  auto
GlobalVariable property _Seed_Setting_PO3WaterDetection  auto


GlobalVariable property _Seed_Setting_MeterScale  auto
GlobalVariable property _Seed_Setting_MeterScaleVitality  auto

GlobalVariable property _Seed_Setting_FoodListAdd  auto
GlobalVariable property _Seed_Setting_FoodListReclassify  auto



; Needs Meter Display Mode:
; Display...
; 0 = Always On
; 1 = On action, H/M/S, time, and status (contextual, most frequent)
; 2 = On action, H/M/S, and status change                           ; Default
; 3 = On H/M/S and status change
; 4 = On status change (contextual, least frequent)
; 5 = Always Off
GlobalVariable property _Seed_Setting_HungerMeterDisplayMode  auto

;4 = 4 seconds
GlobalVariable property _Seed_Setting_HungerMeterDisplayTime  auto

;100 fully visible
GlobalVariable property _Seed_Setting_MeterHungerOpacity  auto

; Vitality Meter Display Mode:
; Display...
; 0 = Always On
; 1 = Always On if < 100% (contextual, most frequent)
; 2 = With Needs meters and status change
; 3 = With Needs meters if Vitality < 100% and status change
; 4 = On status change (contextual, least frequent)                 ; Default
; 5 = Always Off (display warning message)
GlobalVariable property _Seed_Setting_VitalityMeterDisplayMode  auto
GlobalVariable property _Seed_Setting_VitalityMeterDisplayTime  auto
GlobalVariable property _Seed_Setting_MeterVitalityOpacity  auto

GlobalVariable property _Seed_Setting_MeterVitalityColor  auto
GlobalVariable property _Seed_Setting_MeterThirstColor  auto
GlobalVariable property _Seed_Setting_MeterHungerColor  auto
GlobalVariable property _Seed_Setting_MeterFatigueColor  auto

;METERS OLD
GlobalVariable property _Seed_Setting_MeterVitalityFillDirection auto
GlobalVariable property _Seed_Setting_MeterVitalityHAnchor auto
GlobalVariable property _Seed_Setting_MeterVitalityVAnchor auto
GlobalVariable property _Seed_Setting_MeterVitalityXPos auto
GlobalVariable property _Seed_Setting_MeterVitalityYPos auto
GlobalVariable property _Seed_Setting_MeterVitalityHeight auto
GlobalVariable property _Seed_Setting_MeterVitalityWidth auto

GlobalVariable property _Seed_Setting_MeterHungerFillDirection auto
GlobalVariable property _Seed_Setting_MeterHungerHAnchor auto
GlobalVariable property _Seed_Setting_MeterHungerVAnchor auto
GlobalVariable property _Seed_Setting_MeterHungerXPos auto
GlobalVariable property _Seed_Setting_MeterHungerYPos auto
GlobalVariable property _Seed_Setting_MeterHungerHeight auto
GlobalVariable property _Seed_Setting_MeterHungerWidth auto

GlobalVariable property _Seed_Setting_MeterThirstFillDirection auto
GlobalVariable property _Seed_Setting_MeterThirstHAnchor auto
GlobalVariable property _Seed_Setting_MeterThirstVAnchor auto
GlobalVariable property _Seed_Setting_MeterThirstXPos auto
GlobalVariable property _Seed_Setting_MeterThirstYPos auto
GlobalVariable property _Seed_Setting_MeterThirstHeight auto
GlobalVariable property _Seed_Setting_MeterThirstWidth auto

GlobalVariable property _Seed_Setting_MeterFatigueFillDirection auto
GlobalVariable property _Seed_Setting_MeterFatigueHAnchor auto
GlobalVariable property _Seed_Setting_MeterFatigueVAnchor auto
GlobalVariable property _Seed_Setting_MeterFatigueXPos auto
GlobalVariable property _Seed_Setting_MeterFatigueYPos auto
GlobalVariable property _Seed_Setting_MeterFatigueHeight auto
GlobalVariable property _Seed_Setting_MeterFatigueWidth auto




;GlobalVariable property _Seed_IsPlayerFocused auto

GlobalVariable property _Seed_Setting_CurrentProfile auto
GlobalVariable property _Seed_Setting_AutoSaveLoad auto

GlobalVariable property _Seed_HelpDone_Focus auto
GlobalVariable property _Seed_HelpDone_Variety auto

GlobalVariable property _Seed_Setting_FocusNotifications auto
GlobalVariable property _Seed_Setting_FrostfallNotifications auto

GlobalVariable property _Seed_Setting_SleepAffectedByNeeds auto
GlobalVariable property _Seed_Setting_SleepAffectedByLocation auto

;HOTKEYS
GlobalVariable property _Seed_HotkeyCheckNeeds auto
GlobalVariable property _Seed_HotkeyAutoEat auto
GlobalVariable property _Seed_HotkeyAutoDrink auto
GlobalVariable property _Seed_HotkeyProvisions auto
GlobalVariable property _Seed_HotkeyIntensity auto
GlobalVariable property _Seed_HotkeyExamineFood auto
GlobalVariable property _Seed_HotkeyDrinkFromStream auto

Spell property _Seed_CheckNeedsSpell auto
Spell property _Seed_AutoEat auto
Spell property _Seed_AutoDrink auto
Spell property _Seed_ProvisionsSpell auto
Spell property _Seed_IntensityPlayerSpell auto
Spell property _Seed_ExamineFood auto
Spell property _Seed_DrinkFromStreamSpell auto

Formlist property _Seed_SafeLocations auto

GlobalVariable property Provisioning_PerkRank_UnboundIntensity auto
Message property _Seed_SkillLockedMessage auto
Potion property _Seed_WaterBottleEmpty auto

_Seed_Meter property VitalityMeter auto
_Seed_Meter property HungerMeter auto
_Seed_Meter property ThirstMeter auto
_Seed_Meter property FatigueMeter auto
_Seed_VitalityMeterInterfaceHandler property VitalityMeterHandler auto
_Seed_HungerMeterInterfaceHandler property HungerMeterHandler auto
_Seed_ThirstMeterInterfaceHandler property ThirstMeterHandler auto
_Seed_FatigueMeterInterfaceHandler property FatigueMeterHandler auto
;TODO: Add this back in
; _Seed_ThirstMeterInterfaceHandler property ThirstMeterHandler auto

int Overview_RunStatusText_OID
int Overview_RunSubStatusText_OID

int FoodLists_ListMenu_OID
int FoodLists_ItemMenu_OID
int FoodLists_AddItem_OID
int FoodLists_ReclassifyItem_OID
int FoodLists_Edit_OID
int FoodLists_Edit_ListMenu_OID
int FoodLists_Edit_RestoreHunger_OID
int FoodLists_Edit_Alcohol_OID
int FoodLists_Edit_Preserved_OID
int FoodLists_Edit_Salted_OID
int FoodLists_Edit_Portions_OID
int FoodLists_Edit_PortionsListMenu_OID
int FoodLists_Edit_PortionsItemMenu_OID
int FoodLists_Edit_PortionsCount_OID

int Help_SettingEnableTutorials_OID
int Help_SettingsResetTutorials_OID
int Advanced_ResetFormLists_OID
int Advanced_PO3WaterDetection_OID
int Advanced_ForceStartMod_OID
int Advanced_VampireMonitoring_OID
int Advanced_ProvisionWeightPP_OID
int Advanced_LogLevel_OID

int Advanced_ProvisioningSkillRespec_OID
int Advanced_ProvisioningSkillRestore_OID
int Advanced_ProvisioningSkillRestoreSlider_OID

int SaveLoad_SelectProfile_OID
int SaveLoad_RenameProfile_OID
int SaveLoad_DefaultProfile_OID
int SaveLoad_ProfileHelp_OID
int SaveLoad_Enable_OID

int Overview_StartSystem_OID
int Overview_GameplayPreset_OID
int Overview_HungerStatusText_OID
int Overview_ThirstStatusText_OID
int Overview_FatigueStatusText_OID
int Overview_VitalityStatusText_OID
int Overview_AlcoholStatusText_OID
int Overview_SkoomaStatusText_OID
int Gameplay_VitalityEnabled_OID
int Gameplay_VitalityRate_OID
int Gameplay_VitalityHungerMulti_OID
int Gameplay_VitalityThirstMulti_OID
int Gameplay_VitalityFatigueMulti_OID
int Gameplay_VitalityDiseaseMulti_OID
int Gameplay_VitalityExposureMulti_OID
int Gameplay_HungerEnabled_OID
int Gameplay_HungerRate_OID
int Gameplay_ThirstEnabled_OID
int Gameplay_ThirstRate_OID
int Gameplay_FatigueEnabled_OID
int Gameplay_FatigueRate_OID
int Gameplay_AlcoholRate_OID
int Gameplay_SkoomaRate_OID
int Gameplay_NoVitalityMode_OID
int Gameplay_FocusEnabled_OID
int Gameplay_NeedsPauseDialogue_OID
int Gameplay_MovementPenalty_OID
int Gameplay_FoodNames_OID
int Gameplay_Cannibalism_OID
int Gameplay_EnableWaterBottles_OID
int Gameplay_EnableDungeonFocus_OID
int Gameplay_VampirismMode_OID
int Gameplay_Followers_OID
int Gameplay_FollowerPartyCount_OID
int Gameplay_FollowersConsumeFood_OID
int Gameplay_SeranaDrinksBlood_OID
int Advanced_PlayerIsLich_OID
int Advanced_RefreshSystemsOnLoad_OID
int Advanced_AlternativeDeathSystem_OID
int Gameplay_DiminishingFoodReturns_OID
int Gameplay_AutoConsume_OID
int Gameplay_NeedsAffectedByRegeneration_OID
int Gameplay_ProvisionsAddPortions_OID
int Gameplay_FoodWeightMulti_OID
int Gameplay_FoodPriceMulti_OID
int Gameplay_InnDialogWater_OID
int Gameplay_InnDialogMeals_OID

int Gameplay_SleepAffectedByNeeds_OID
int Gameplay_SleepAffectedByLocation_OID



int Gameplay_PortioningEnable_OID

int Alcohol_Enabled_OID
int Skooma_Enabled_OID
int Alcohol_Stumbling_OID
int Alcohol_Shenanigans_OID
int Alcohol_RateAle_OID
int Alcohol_RateWine_OID
int Alcohol_RateSpirits_OID
int Alcohol_RateSkoomaWeak_OID
int Alcohol_RateSkoomaStrong_OID

int Disease_Enabled_OID
int Disease_Additional_OID
int Disease_Dirty_OID
int Disease_ChanceRawFood_OID
int Disease_ChanceStaleFood_OID
int Disease_ChanceDirtyWater_OID
int Disease_PotionsCure_OID
int Disease_ShrinesCure_OID
int Disease_PriestsCure_OID

int Gameplay_SpoilageEnable_OID
int Gameplay_SpoilageRemove_OID
int Gameplay_SpoilageTemperature_OID
int Spoilage_ContainersEnabled_OID
int Spoilage_ContainersRate_OID
int Spoilage_Bread_OID
int Spoilage_MeatRaw_OID
int Spoilage_MeatCooked_OID
int Spoilage_SmallGameRaw_OID
int Spoilage_SmallGameCooked_OID
int Spoilage_FishRaw_OID
int Spoilage_FishCooked_OID
int Spoilage_SeafoodRaw_OID
int Spoilage_SeafoodCooked_OID
int Spoilage_Vegetables_OID
int Spoilage_Fruit_OID
int Spoilage_Cheese_OID
int Spoilage_Treats_OID
int Spoilage_Pastries_OID
int Spoilage_Stews_OID
int Spoilage_CheeseBowls_OID
int Spoilage_DrinkMilk_OID
int Spoilage_IceWraithTeeth_OID

int Interface_SoundEffects_OID
int Interface_FullScreenEffects_OID
int Interface_ForceFeedback_OID
int Interface_ConditionMessages_OID
int Interface_ConditionMessagesFollowers_OID
int Interface_FocusNotificatons_OID
int Interface_FrostfallNotificatons_OID
;ANIMATIONS
int Interface_Animation_OID
int Interface_AnimationFirstPerson_OID
int Interface_FollowerAnimation_OID
int Interface_AnimationPickup_OID


;METERS
int Meters_manualPosition_OID
int Meters_UIMeterDisplay_OID
int Meters_UIMeterOpacity_OID
int Meters_UIMeterDisplayTime_OID
int Meters_UIMeterDisplay_Vitality_OID
int Meters_UIMeterDisplayTime_Vitality_OID
int Meters_UIMeterOpacity_Vitality_OID
int Meters_UIMeterWidth_Vitality_OID
int Meters_UIMeterHeight_Vitality_OID

int Meters_UIMeterXPos_Hunger_OID
int Meters_UIMeterYPos_Hunger_OID
int Meters_UIMeterXPos_Thirst_OID
int Meters_UIMeterYPos_Thirst_OID
int Meters_UIMeterXPos_Fatigue_OID
int Meters_UIMeterYPos_Fatigue_OID
int Meters_UIMeterXPos_Vitality_OID
int Meters_UIMeterYPos_Vitality_OID

int Meters_UIMeterHAnchor_Hunger_OID
int Meters_UIMeterVAnchor_Hunger_OID
int Meters_UIMeterHAnchor_Thirst_OID
int Meters_UIMeterVAnchor_Thirst_OID
int Meters_UIMeterHAnchor_Fatigue_OID
int Meters_UIMeterVAnchor_Fatigue_OID
int Meters_UIMeterHAnchor_Vitality_OID
int Meters_UIMeterVAnchor_Vitality_OID

int Meters_UIMeterScale_OID
int Meters_UIMeterScaleVitality_OID

;METERS - OLD
int Meters_UIMeterXPos_OID
int Meters_UIMeterYPos_OID
int Meters_UIMeterHAnchor_OID
int Meters_UIMeterVAnchor_OID
int Meters_UIMeterWidth_OID
int Meters_UIMeterHeight_OID
int Meters_UIMeterLayout_OID
int Meters_UIMeterFillDirection_OID
int Meters_UIMeterFlipped_OID
int Meters_UIMeterColor_OID

;HOTKEYS
int Gameplay_CheckNeedsHotkey_OID

int Gameplay_AutoEatHotkey_OID
int Gameplay_AutoDrinkHotkey_OID
int Gameplay_ProvisionsHotkey_OID
int Gameplay_IntensityHotkey_OID
int Gameplay_ExamineFoodHotkey_OID
int Gameplay_DrinkFromStreamHotkey_OID

int Advanced_SafeLocation_OID



bool meterMenuOpened

string property debugSystemName auto hidden

bool must_exit = false
bool config_is_open = false

int initialSetting_Meters
int initialSetting_Meter_Vitality

int initialSetting_MeterOpacity
int initialSetting_MeterOpacity_Vitality

string[] FoodNamesList
string[] VampirismModeList
string[] SpoilageRemoveModeList
string[] followerModeList
string[] followerCountList
string[] DiseasePotionModeList
string[] PresetsGameplay
string[] LogLevel
string[] MeterModeList
string[] MeterModeList_Vitality
string[] ProfileList
string[] NoVitalityList

string[] FillDirectionList
string[] FillDirectionListLimited
string[] HorizontalAnchorList
string[] VerticalAnchorList

string[] _listMenu
FormList[] _listRef
string[] _listRefNames
string[] _listRefNamesPortions
string[] _fullListMenu
string[] _HungerMenu
string[] _AlcoholMenu
string[] _LocationText
FormList[] _fullListRef
int _selectedList = 0
int _selectedList_edit = 0
int restoreIndex = 0
int alcoholIndex = 0
int _selectedItem = 0
bool editFoodItem = false
Form selectedForm = none
Potion selectedPortion = none

int selectedListPortions
int selectedItemPortions
int portionCount

Event OnConfigInit()
	debugSystemName = "MCM"
	
	SeedDebug(0, "[" + debugSystemName + "]: Starting MCM ")
	loadArrays()
	SeedDebug(0, "[" + debugSystemName + "]: Finished Initiating MCM ")
endEvent

function loadArrays()
	Pages = new string[11]
	Pages[0] = "$LastSeedOverviewPage"
	Pages[1] = "$LastSeedGameplayPage"
	Pages[2] = "$LastSeedNeedsPage"
	Pages[3] = "$LastSeedVitalityPage"
	Pages[4] = "$LastSeedAlcoholDiseasePage"
	Pages[5] = "$LastSeedSpoilagePage"
	Pages[6] = "$LastSeedInterfacePage"
	Pages[7] = "$LastSeedMetersPage"
	Pages[8] = "$LastFoodListPage"
									 
	Pages[9] = "$LastSeedSaveLoadPage"
	; Pages[5] = "$LastSeedAdvancedPage"
	Pages[10] = "$LastSeedHelpPage"
	
	FillDirectionList = new string[3]
	FillDirectionList[0] = "$FrostfallLeft"
	FillDirectionList[1] = "$FrostfallRight"
	FillDirectionList[2] = "$FrostfallBoth"

	FillDirectionListLimited = new string[2]
	FillDirectionListLimited[0] = "$FrostfallLeft"
	FillDirectionListLimited[1] = "$FrostfallRight"

	HorizontalAnchorList = new string[3]
	HorizontalAnchorList[0] = "$FrostfallLeft"
	HorizontalAnchorList[1] = "$FrostfallRight"
	HorizontalAnchorList[2] = "$FrostfallCenter"

	VerticalAnchorList = new string[3]
	VerticalAnchorList[0] = "$FrostfallTop"
	VerticalAnchorList[1] = "$FrostfallBottom"
	VerticalAnchorList[2] = "$FrostfallCenter"
	
	VampirismModeList = new string[3]
	VampirismModeList[0] = "$LastSeedVampirismHuman"
	VampirismModeList[1] = "$LastSeedVampirismSuperhuman"
	VampirismModeList[2] = "$LastSeedVampirismImmortal"	
	
	
	if SeedUtil.GetCompatibilitySystem().isPO3Loaded && isSpecialEdition()
		FoodNamesList = new string[3]
		FoodNamesList[0] = "$LastSeedGameplaySettingFoodNamesNo"
		FoodNamesList[1] = "$LastSeedGameplaySettingFoodNamesAppend"
		FoodNamesList[2] = "$LastSeedGameplaySettingFoodNamesMagic"
	else
		FoodNamesList = new string[2]
		FoodNamesList[0] = "$LastSeedGameplaySettingFoodNamesNo"
		FoodNamesList[1] = "$LastSeedGameplaySettingFoodNamesYes"
	endif
	
	NoVitalityList = new string[3]
	NoVitalityList[0] = "$LastSeedNoVitalityNothing"
	NoVitalityList[1] = "$LastSeedNoVitalityRescue"
	NoVitalityList[2] = "$LastSeedNoVitalityDeath"
	
	SpoilageRemoveModeList = new string[3]
	SpoilageRemoveModeList[0] = "$LastSeedSpoilRemoveNone"
	SpoilageRemoveModeList[1] = "$LastSeedSpoilRemovePerished"
	SpoilageRemoveModeList[2] = "$LastSeedSpoilRemoveAll"
	
	followerModeList = new string[2]
	followerModeList[0] = "$LastSeedFollowerNeedsNone"
	followerModeList[1] = "$LastSeedFollowerNeedsEnabled"
	;/
	followerModeList = new string[3]
    followerModeList[0] = "$LastSeedFollowerNeedsNone"
    followerModeList[1] = "$LastSeedFollowerNeedsIndividual"
    followerModeList[2] = "$LastSeedFollowerNeedsParty"
	/;
	
	followerCountList = new string[11]
    followerCountList [0] = "$LastSeedPartyCountAuto"
    followerCountList [1] = "1"
    followerCountList [2] = "2"
    followerCountList [3] = "3"
    followerCountList [4] = "4"
    followerCountList [5] = "5"
    followerCountList [6] = "6"
    followerCountList [7] = "7"
    followerCountList [8] = "8"
    followerCountList [9] = "9"
    followerCountList [10] = "10"
	
	DiseasePotionModeList = new string[3]
	DiseasePotionModeList[0] = "$LastSeedDiseasePotionVanilla"
	DiseasePotionModeList[1] = "$LastSeedDiseasePotionSpecific"
	DiseasePotionModeList[2] = "$LastSeedDiseasePotionNone"
	
	PresetsGameplay = new string[3]
	PresetsGameplay[0] = "$LastSeedPresetsSelectEasy"
	PresetsGameplay[1] = "$LastSeedPresetsSelectMedium"
	PresetsGameplay[2] = "$LastSeedPresetsSelectHard"
	
	LogLevel = new string[5]
	LogLevel[0] = "$LastSeedLogLevelSystemPerformance"
	LogLevel[1] = "$LastSeedLogLevelDebug"
	LogLevel[2] = "$LastSeedLogLevelInfo"
	LogLevel[3] = "$LastSeedLogLevelWarning"
	LogLevel[4] = "$LastSeedLogLevelError"
	

	;MeterModeList = new string[2]
	;MeterModeList[0] = "$LastSeedInterfaceSettingMeterDisplayModeContextual"
	;MeterModeList[1] = "$LastSeedInterfaceSettingMeterDisplayModeNever"
	
	MeterModeList = new string[3]
	MeterModeList[0] = "$LastSeedInterfaceSettingMeterDisplayModeNever"
	MeterModeList[1] = "$LastSeedInterfaceSettingMeterDisplayModeAlways"
	MeterModeList[2] = "$LastSeedInterfaceSettingMeterDisplayModeContextual"

	;/TODO: REMOVE THIS
	MeterModeList[0] = "$LastSeedInterfaceSettingMeterDisplayModeAlways"
	MeterModeList[1] = "$LastSeedInterfaceSettingMeterDisplayModeContextual"
	MeterModeList[2] = "$LastSeedInterfaceSettingMeterDisplayModeNever"
	/;

	
	FILL_DIRECTIONS = new string[3]
	FILL_DIRECTIONS[0] = "Left"
	FILL_DIRECTIONS[1] = "Right"
	FILL_DIRECTIONS[2] = "Both"

	HORIZONTAL_ANCHORS = new string[3]
	HORIZONTAL_ANCHORS[0] = "Left"
	HORIZONTAL_ANCHORS[1] = "Right"
	HORIZONTAL_ANCHORS[2] = "Center"

	VERTICAL_ANCHORS = new string[3]
	VERTICAL_ANCHORS[0] = "Top"
	VERTICAL_ANCHORS[1] = "Bottom"
	VERTICAL_ANCHORS[2] = "Center"
	
	;/
	MeterModeList = new string[3]
	MeterModeList[0] = "$LastSeedInterfaceSettingMeterDisplayModeAlways"
	MeterModeList[1] = "$LastSeedInterfaceSettingMeterDisplayModeContextual"
	MeterModeList[2] = "$LastSeedInterfaceSettingMeterDisplayModeNever"
	/;
	;/
	MeterModeList[0] = "$LastSeedInterfaceSettingUIMeterDisplay0"
	MeterModeList[1] = "$LastSeedInterfaceSettingUIMeterDisplay2"
	MeterModeList[2] = "$LastSeedInterfaceSettingUIMeterDisplay4"
	MeterModeList[3] = "$LastSeedInterfaceSettingUIMeterDisplay5"
	/;
	
	;/
	MeterModeList_Vitality = new string[4]
	MeterModeList_Vitality[0] = "$LastSeedInterfaceSettingUIMeterDisplay_Vitality0"
	MeterModeList_Vitality[1] = "$LastSeedInterfaceSettingUIMeterDisplay_Vitality1"
	MeterModeList_Vitality[2] = "$LastSeedInterfaceSettingUIMeterDisplay_Vitality2"
	MeterModeList_Vitality[3] = "$LastSeedInterfaceSettingUIMeterDisplay_Vitality3"
	MeterModeList_Vitality[4] = "$LastSeedInterfaceSettingUIMeterDisplay_Vitality4"
	MeterModeList_Vitality[5] = "$LastSeedInterfaceSettingUIMeterDisplay_Vitality5"
	/;
	
	_listMenu = new string[21]
	_listRef = new FormList[21]
		
	_listMenu[0] = "$LastSeedGameplaySettingSpoilageRateBread"
	_listMenu[1] = "$LastSeedGameplaySettingSpoilageRateMeatRaw"
	_listMenu[2] = "$LastSeedGameplaySettingSpoilageRateMeatCooked"
	_listMenu[3] = "$LastSeedGameplaySettingSpoilageSmallGameRaw"
	_listMenu[4] = "$LastSeedGameplaySettingSpoilageSmallGameCooked"
	_listMenu[5] = "$LastSeedGameplaySettingSpoilageFishRaw"
	_listMenu[6] = "$LastSeedGameplaySettingSpoilageFishCooked"
	_listMenu[7] = "$LastSeedGameplaySettingSpoilageSeafoodRaw"
	_listMenu[8] = "$LastSeedGameplaySettingSpoilageSeafoodCooked"
	_listMenu[9] = "$LastSeedGameplaySettingSpoilageVegitables"
	_listMenu[10] = "$LastSeedGameplaySettingSpoilageFruit"
	_listMenu[11] = "$LastSeedGameplaySettingSpoilageCheese"
	_listMenu[12] = "$LastSeedGameplaySettingSpoilageTreats"
	_listMenu[13] = "$LastSeedGameplaySettingSpoilagePastry"
	_listMenu[14] = "$LastSeedGameplaySettingSpoilageStew"
	_listMenu[15] = "$LastSeedGameplaySettingSpoilageCheeseBowl"
	_listMenu[16] = "$LastSeedGameplaySettingSpoilageMilk"
	_listMenu[17] = "$LastSeedGameplaySettingSpoilageAlcohol"
	_listMenu[18] = "$LastSeedGameplaySettingSpoilageNonAlcohol"
	_listMenu[19] = "$LastSeedGameplaySettingSpoilageBloodPotions"
	_listMenu[20] = "$LastSeedGameplaySettingSpoilageNotFood"
		
	_listRef[0] = _Seed_Bread
	_listRef[1] = _Seed_MeatRaw
	_listRef[2] = _Seed_MeatCooked
	_listRef[3] = _Seed_SmallGameRaw
	_listRef[4] = _Seed_SmallGameCooked
	_listRef[5] = _Seed_FishRaw
	_listRef[6] = _Seed_FishCooked
	_listRef[7] = _Seed_SeafoodRaw
	_listRef[8] = _Seed_SeafoodCooked
	_listRef[9] =  _Seed_Vegetables
	_listRef[10] = _Seed_Fruit
	_listRef[11] = _Seed_Cheese
	_listRef[12] = _Seed_Treats
	_listRef[13] = _Seed_Pastries
	_listRef[14] = _Seed_Stews
	_listRef[15] = _Seed_CheeseBowls
	_listRef[16] = _Seed_DrinkMilk
	_listRef[17] = _Seed_DrinkAlcoholic
	_listRef[18] = _Seed_DrinkNonAlcoholic
	_listRef[19] = _Seed_BloodPotions
	_listRef[20] =_Seed_NotFood
	
	
	
	_fullListMenu = new string[33]
	_fullListRef = new FormList[33]
		
	_fullListMenu[0] = "$LastSeedGameplaySettingSpoilageRateBread"
	_fullListMenu[1] = "$LastSeedGameplaySettingSpoilageRateMeatRaw"
	_fullListMenu[2] = "$LastSeedGameplaySettingSpoilageRateMeatCooked"
	_fullListMenu[3] = "$LastSeedGameplaySettingSpoilageSmallGameRaw"
	_fullListMenu[4] = "$LastSeedGameplaySettingSpoilageSmallGameCooked"
	_fullListMenu[5] = "$LastSeedGameplaySettingSpoilageFishRaw"
	_fullListMenu[6] = "$LastSeedGameplaySettingSpoilageFishCooked"
	_fullListMenu[7] = "$LastSeedGameplaySettingSpoilageSeafoodRaw"
	_fullListMenu[8] = "$LastSeedGameplaySettingSpoilageSeafoodCooked"
	_fullListMenu[9] = "$LastSeedGameplaySettingSpoilageVegitablesSingle"
	_fullListMenu[10] = "$LastSeedGameplaySettingSpoilageFruit"
	_fullListMenu[11] = "$LastSeedGameplaySettingSpoilageCheese"
	_fullListMenu[12] = "$LastSeedGameplaySettingSpoilageTreatsSingle"
	_fullListMenu[13] = "$LastSeedGameplaySettingSpoilagePastrySingle"
	_fullListMenu[14] = "$LastSeedGameplaySettingSpoilageStew"
	_fullListMenu[15] = "$LastSeedGameplaySettingSpoilageCheeseBowlSingle"
	_fullListMenu[16] = "$LastSeedGameplaySettingSpoilageMilk"
	_fullListMenu[17] = "$LastSeedGameplaySettingSpoilageAlcohol"
	_fullListMenu[18] = "$LastSeedGameplaySettingSpoilageNonAlcoholSingle"
	_fullListMenu[19] = "$LastSeedGameplaySettingSpoilageBloodPotionsSingle"
	_fullListMenu[20] = "$LastSeedGameplaySettingSpoilageNotFood"
	
	_fullListMenu[21] = "$LastSeedGameplaySettingSpoilagePreserved"
	_fullListMenu[22] = "$LastSeedGameplaySettingSpoilageSalted"
	_fullListMenu[23] = "$LastSeedGameplaySettingSpoilageLight"
	_fullListMenu[24] = "$LastSeedGameplaySettingSpoilageMedium"	
	_fullListMenu[25] = "$LastSeedGameplaySettingSpoilageFilling"	
	_fullListMenu[26] = "$LastSeedGameplaySettingSpoilageHearty"	
	_fullListMenu[27] = "$LastSeedGameplaySettingSpoilageAlcoholWeak"	
	_fullListMenu[28] = "$LastSeedGameplaySettingSpoilageAlcoholModerate"	
	_fullListMenu[29] = "$LastSeedGameplaySettingSpoilageAlcoholStrong"		
	_fullListMenu[30] = "$LastSeedGameplaySettingSpoilageSkoomaWeak"		
	_fullListMenu[31] = "$LastSeedGameplaySettingSpoilageSkoomaStrong"	
	_fullListMenu[32] = "$LastSeedGameplaySettingSpoilageSystem"	
		
	_fullListRef[0] = _Seed_Bread
	_fullListRef[1] = _Seed_MeatRaw
	_fullListRef[2] = _Seed_MeatCooked
	_fullListRef[3] = _Seed_SmallGameRaw
	_fullListRef[4] = _Seed_SmallGameCooked
	_fullListRef[5] = _Seed_FishRaw
	_fullListRef[6] = _Seed_FishCooked
	_fullListRef[7] = _Seed_SeafoodRaw
	_fullListRef[8] = _Seed_SeafoodCooked
	_fullListRef[9] =  _Seed_Vegetables
	_fullListRef[10] = _Seed_Fruit
	_fullListRef[11] = _Seed_Cheese
	_fullListRef[12] = _Seed_Treats
	_fullListRef[13] = _Seed_Pastries
	_fullListRef[14] = _Seed_Stews
	_fullListRef[15] = _Seed_CheeseBowls
	_fullListRef[16] = _Seed_DrinkMilk
	_fullListRef[17] = _Seed_DrinkAlcoholic
	_fullListRef[18] = _Seed_DrinkNonAlcoholic
	_fullListRef[19] = _Seed_BloodPotions
	_fullListRef[20] =_Seed_NotFood	
	
	_fullListRef[21] =_Seed_Preserved	
	_fullListRef[22] =_Seed_SaltedFood	
	_fullListRef[23] =_Seed_Food_RestoreHungerMinor	
	_fullListRef[24] =_Seed_Food_RestoreHungerMajor	
	_fullListRef[25] =_Seed_Food_RestoreHungerSuperior	
	_fullListRef[26] =_Seed_Food_RestoreHungerMassive	
	_fullListRef[27] =_Seed_DrinkAlcoholicAle	
	_fullListRef[28] =_Seed_DrinkAlcoholicWine	
	_fullListRef[29] =_Seed_DrinkAlcoholicSpirit	
	_fullListRef[30] =_Seed_DrinkSkoomaWeak	
	_fullListRef[31] =_Seed_DrinkSkoomaStrong	
	_fullListRef[32] =_Seed_SystemFoods	
	
	
	_HungerMenu = new String[4]
	_HungerMenu[0] = "$LastSeedGameplaySettingSpoilageLight"
	_HungerMenu[1] = "$LastSeedGameplaySettingSpoilageMedium"	
	_HungerMenu[2] = "$LastSeedGameplaySettingSpoilageFilling"
	_HungerMenu[3] = "$LastSeedGameplaySettingSpoilageHearty"	
	
	_AlcoholMenu = new String[5]
	_AlcoholMenu[0] = "$LastSeedGameplaySettingSpoilageAlcoholWeak"
	_AlcoholMenu[1] = "$LastSeedGameplaySettingSpoilageAlcoholModerate"	
	_AlcoholMenu[2] = "$LastSeedGameplaySettingSpoilageAlcoholStrong"
	_AlcoholMenu[3] = "$LastSeedGameplaySettingSpoilageSkoomaWeak"	
	_AlcoholMenu[4] = "$LastSeedGameplaySettingSpoilageSkoomaStrong"	
	
	
	_LocationText = new String[6]
	_LocationText[0] = "$LastSeedLocationVerySafe"
	_LocationText[1] = "$LastSeedLocationSafe"
	_LocationText[2] = "$LastSeedLocationSomewhatSafe"
	_LocationText[3] = "$LastSeedLocationSomewhatUnsafe"
	_LocationText[4] = "$LastSeedLocationUnsafe"
	_LocationText[5] = "$LastSeedLocationVeryUnsafe"
endFunction

Event OnConfigOpen()
	if LastSeedRunning.GetValueInt() == 2 && LastSeedStartupFinished.GetValueInt() != 2
		must_exit = true
	else
		must_exit = false
	endif

	config_is_open = true
	meterMenuOpened = false
	loadArrays()
	GetConfigurationHandler().onStart()
	
	initialSetting_Meters = _Seed_Setting_HungerMeterDisplayMode.GetValueInt()	
	initialSetting_Meter_Vitality = _Seed_Setting_VitalityMeterDisplayMode.GetValueInt()
	initialSetting_MeterOpacity = _Seed_Setting_MeterHungerOpacity.getValueInt()
	initialSetting_MeterOpacity_Vitality = _Seed_Setting_MeterVitalityOpacity.getValueInt()
	
	_Seed_Setting_FoodListAdd.setValue(1)
	_Seed_Setting_FoodListReclassify.setValue(1)
	
	_selectedList = 0
	_selectedItem = 0
	selectedForm = none
	selectedPortion = none
	editFoodItem = false
	_selectedList_edit = 0
	restoreIndex = 0
	alcoholIndex = 0
	selectedListPortions = 0
	selectedItemPortions = 0
	portionCount = 0

EndEvent

Event OnConfigClose()
	UnregisterForAllModEvents()
	meter_being_configured = METER_BEING_CONFIGURED_NONE
	config_is_open = false
	
	ConfigureMeters()
	GetConfigurationHandler().onFinish()
	
	;Process Form List
	if selectedForm && ! _Seed_SystemFoods.hasForm(selectedForm)
		potion theFood = selectedForm as potion
		if(thefood)
			if(_Seed_Setting_FoodListAdd.getValue() as int) == 2 && theFood
				PlayerRef.addItem(theFood)
			endif
			
			if(_Seed_Setting_FoodListReclassify.getValue() as int) == 2 && theFood
				GetCustomiseFoodHandler().ReClassifyFood(theFood)
			endif
		endif
	endif
EndEvent

Function ConfigureMeters()
	if(meterMenuOpened)
		; UPDATE Meters
		int currentSettingMeters = _Seed_Setting_HungerMeterDisplayMode.getValueInt()
		if initialSetting_Meters != currentSettingMeters
			
			if currentSettingMeters == 1
				SeedDebug(0, "[" + debugSystemName + "]: Forcing Meter Display")
				;/
				_Seed_Setting_HungerMeterDisplayMode.setValue(1)
				;SendEvent_ForceHungerMeterDisplay()
				;SendEvent_ForceThirstMeterDisplay()
				;SendEvent_ForceFatigueMeterDisplay()
				HungerMeterHandler.ForceMeterDisplay()
				ThirstMeterHandler.ForceMeterDisplay()
				FatigueMeterHandler.ForceMeterDisplay()
				_Seed_Setting_HungerMeterDisplayMode.setValue(0)
				/;
				SendEvent_ForceHungerMeterDisplay()
				SendEvent_ForceThirstMeterDisplay()
				SendEvent_ForceFatigueMeterDisplay()
			elseif initialSetting_Meters == 1 || currentSettingMeters == 0
				SeedDebug(0, "[" + debugSystemName + "]: Hiding Meter Display")
				SendEvent_LastSeedRemoveHungerMeter()
				SendEvent_LastSeedRemoveThirstMeter()
				SendEvent_LastSeedRemoveFatigueMeter()
			endif
		endif
		int currentSettingMeter_Vitality = _Seed_Setting_VitalityMeterDisplayMode.getValueInt()
		if initialSetting_Meter_Vitality != currentSettingMeter_Vitality
			if currentSettingMeter_Vitality == 1
				SeedDebug(0, "[" + debugSystemName + "]: Forcing Vitality Meter Display")
				;_Seed_Setting_VitalityMeterDisplayMode.setValue(1)
				;VitalityMeterHandler.ForceMeterDisplay()
				;_Seed_Setting_VitalityMeterDisplayMode.setValue(0)
				SendEvent_ForceVitalityMeterDisplay()
			elseif initialSetting_Meter_Vitality == 1 || currentSettingMeter_Vitality == 0
				SeedDebug(0, "[" + debugSystemName + "]: Hiding Vitality Meter Display")
				SendEvent_LastSeedRemoveVitalityMeter()
			endif
		endif
	
		;METER OPACITY
		int currentSetting_MeterOpacity = _Seed_Setting_MeterHungerOpacity.getValueInt()
		if initialSetting_MeterOpacity != currentSetting_MeterOpacity 
			int curentDisplayMode = _Seed_Setting_HungerMeterDisplayMode.getValueInt()	
			if curentDisplayMode != 0
					_Seed_Setting_HungerMeterDisplayMode.setValue(1)
					HungerMeterHandler.ForceMeterDisplay()
					ThirstMeterHandler.ForceMeterDisplay()
					FatigueMeterHandler.ForceMeterDisplay()
					_Seed_Setting_HungerMeterDisplayMode.setValue(curentDisplayMode)	
			endif
		endif
		int currentSetting_MeterOpacity_Vitality = _Seed_Setting_MeterVitalityOpacity.getValueInt()
		if initialSetting_MeterOpacity_Vitality != currentSetting_MeterOpacity_Vitality 
			int currentDisplayMode = _Seed_Setting_VitalityMeterDisplayMode.getValueInt()
			if currentDisplayMode != 0
				_Seed_Setting_VitalityMeterDisplayMode.setValue(1)
				VitalityMeterHandler.ForceMeterDisplay()
				_Seed_Setting_VitalityMeterDisplayMode.setValue(currentDisplayMode)	
			endif
		endif
		
		; Update Meter Positions
		if(_seed_setting_manualMeterConfig.getValueInt() == 1)
			UpdateMeterConfiguration(0)
			UpdateMeterConfiguration(1)
			UpdateMeterConfiguration(2)
			UpdateMeterConfiguration(3)
		else
			ApplyMeterPreset(2)
		endif
	endIf
	
	meterMenuOpened = false
endFunction

int function GetVersion()
	return 1
endFunction

Event OnVersionUpdate(int a_version)
	; pass
EndEvent

function PageReset_Overview()
	SetCursorFillMode(TOP_TO_BOTTOM)

	AddHeaderOption("$LastSeedOverviewHeaderStatus")	
	if LastSeedRunning.GetValueInt() == 2
		if LastSeedStartupFinished.GetValueInt() == 2
			if !must_exit
				Overview_RunStatusText_OID = AddTextOption("$LastSeedOverviewCtrlStatus", "$LastSeedEnabled")
				;PRESETS
				AddEmptyOption()
				AddHeaderOption("$LastSeedOverviewHeaderPresets")
				if LastSeedRunning.GetValueInt() != 2 || must_exit
					AddTextOption("$LastSeedNotRunningError", "", OPTION_FLAG_DISABLED)
				else
					Overview_GameplayPreset_OID = AddMenuOption("$LastSeedPresetsSelect", PresetsGameplay[_Seed_Setting_Presets_Gameplay.GetValueInt() - 1])
				endif
				AddEmptyOption()
							
				AddHeaderOption("$LastSeedOverviewHeaderLocation")
				Location playerLocation = playerRef.GetCurrentLocation()
				int safetyLevel = seedUtil.GetDiseaseSystem().getLocationHazardLevel(false) - 1
				AddTextOption(_LocationText[safetyLevel], "")
				if playerLocation != None && safetyLevel > 1
					Advanced_SafeLocation_OID = AddToggleOption("$LastSeedAdvancedSettingSafeLocation", _Seed_SafeLocations.HasForm(playerLocation))
				Else 
					AddTextOption("$LastSeedAdvancedSettingSafeLocationNone", "")
				Endif
			else
				Overview_RunStatusText_OID = AddTextOption("$LastSeedOverviewCtrlStatus", "$LastSeedEnabled", OPTION_FLAG_DISABLED)
			endif
			Overview_RunSubStatusText_OID = AddTextOption("", "", OPTION_FLAG_DISABLED)
		else
			Overview_RunStatusText_OID = AddTextOption("$LastSeedOverviewCtrlStatus", "$LastSeedStartingUp", OPTION_FLAG_DISABLED)
			Overview_RunSubStatusText_OID = AddTextOption("", "", OPTION_FLAG_DISABLED)
		endif
	else
		if Game.IsFightingControlsEnabled()
			if !must_exit
				Overview_RunStatusText_OID = AddTextOption("$LastSeedOverviewCtrlStatus", "$LastSeedDisabled")
			else
				Overview_RunStatusText_OID = AddTextOption("$LastSeedOverviewCtrlStatus", "$LastSeedDisabled", OPTION_FLAG_DISABLED)
			endif
			Overview_RunSubStatusText_OID = AddTextOption("", "", OPTION_FLAG_DISABLED)
		else
			Overview_RunStatusText_OID = AddTextOption("$LastSeedOverviewCtrlStatus", "$LastSeedDisabled", OPTION_FLAG_DISABLED)
			Overview_RunSubStatusText_OID = AddTextOption("$LastSeedCantStart", "", OPTION_FLAG_DISABLED)
		endif
	endif
	
	;/
	; LAST SEED ENABLED
	Overview_StartSystem_OID = _Seed_AddToggleOption(LastSeedStartingUp, "$LastSeedOverviewEnabled")

	; LAST SEED STATUS
	if LastSeedRunning.GetValueInt() == 2
		Overview_RunStatusText_OID = AddTextOption("$LastSeedOverviewCtrlStatus", "$LastSeedRunning")
	else
		Overview_RunStatusText_OID = AddTextOption("$LastSeedOverviewCtrlStatus", "$LastSeedNotRunning")
	endif
	;PRESETS
	AddEmptyOption()
	AddHeaderOption("$LastSeedOverviewHeaderPresets")
	if LastSeedRunning.GetValueInt() != 2 || must_exit
		AddTextOption("$LastSeedNotRunningError", "", OPTION_FLAG_DISABLED)
	else
		Overview_GameplayPreset_OID = AddMenuOption("$LastSeedPresetsSelect", PresetsGameplay[_Seed_Setting_Presets_Gameplay.GetValueInt() - 1])
	endif
	
	/;
	SetCursorPosition(1) ; Move cursor to top right position

	AddHeaderOption("$LastSeedOverviewHeaderPlayerAttributes")

	;HUNGER STATUS
	if LastSeedRunning.GetValueInt() != 2 || must_exit
		AddTextOption("$LastSeedNotRunningError", "", OPTION_FLAG_DISABLED)
	else
		;HUNGER STATUS
		if GetHungerSystem().IsSystemRunning()
			Overview_HungerStatusText_OID = AddTextOption("$LastSeedOverviewHungerValue", (((_Seed_AttributeHunger.GetValue() / _Seed_AttributeHungerMax.GetValue()) * 100.0) as int) + "%")
		else
			Overview_HungerStatusText_OID = AddTextOption("$LastSeedOverviewHungerValue", "$LastSeedDisabled")
		endif
		;THIRST STATUS
		;if GetMonsterHandler().getVampireSettings(false, true, true)
		;	Overview_ThirstStatusText_OID = AddTextOption("$LastSeedOverviewThirstValue", "$LastSeedSuspended")
		;elseif getThirstSystem().IsSystemRunning()
		if getThirstSystem().IsSystemRunning()
			Overview_ThirstStatusText_OID = AddTextOption("$LastSeedOverviewThirstValue", (((_Seed_AttributeThirst.GetValue() / _Seed_AttributeThirstMax.GetValue()) * 100.0) as int) + "%")
		else
			Overview_ThirstStatusText_OID = AddTextOption("$LastSeedOverviewThirstValue", "$LastSeedDisabled")
		endif
		;FATIGUE STATUS
		if getFatigueSystem().IsSystemRunning()
			Overview_FatigueStatusText_OID = AddTextOption("$LastSeedOverviewFatigueValue", (((_Seed_AttributeFatigue.GetValue() / _Seed_AttributeFatigueMax.GetValue()) * 100.0) as int) + "%")
		else
			Overview_FatigueStatusText_OID = AddTextOption("$LastSeedOverviewFatigueValue", "$LastSeedDisabled")
		endif
		;VITALITY STATUS
		if getVitalitySystem().IsSystemRunning()
			Overview_VitalityStatusText_OID = AddTextOption("$LastSeedOverviewVitalityValue", (((_Seed_AttributeVitality.GetValue() / _Seed_AttributeVitalityMax.GetValue()) * 100.0) as int) + "%")
		else
			Overview_VitalityStatusText_OID = AddTextOption("$LastSeedOverviewVitalityValue", "$LastSeedDisabled")
		endif
		
		;ALCOHOL STATUS
		Overview_AlcoholStatusText_OID = AddTextOption("$LastSeedOverviewAlcoholValue", ((_Seed_AttributeDrunk.GetValue() as int) + "%"))
		;SKOOMA STATUS
		Overview_SkoomaStatusText_OID = AddTextOption("$LastSeedOverviewSkoomaValue", ((_Seed_AttributeSkooma.GetValue() as int) + "%"))
	endif

	AddEmptyOption()
	AddEmptyOption()
endFunction


function PageReset_Gameplay()
	SetCursorFillMode(TOP_TO_BOTTOM)
	if LastSeedRunning.GetValueInt() != 2 || must_exit
		AddTextOption("$LastSeedNotRunningError", "", OPTION_FLAG_DISABLED)
		return
	endif
	
	;/------
	GENERAL
	------/;
	AddHeaderOption("$LastSeedGameplayHeaderGeneral")
	Gameplay_FocusEnabled_OID = _Seed_AddToggleOption(_Seed_Setting_Focus, "$LastSeedGameplaySettingFocusEnable")
	Gameplay_EnableDungeonFocus_OID = _Seed_AddToggleOption(_Seed_Settings_FocusInDungeons, "$LastSeedGameplaySettingDungeonFocus")
	Gameplay_AutoConsume_OID = _Seed_AddToggleOption(_Seed_Setting_AutoConsume, "$LastSeedGameplaySettingAutoConsume")
	Gameplay_EnableWaterBottles_OID = _Seed_AddToggleOption(_Seed_Settings_EnableWaterBottles, "$LastSeedAdvancedSettingEnableWaterBottles")
	Gameplay_InnDialogWater_OID = _Seed_AddToggleOption(_Seed_Settings_InnDialogWater, "$LastSeedGameplaySettingInnDialogWater")
	Gameplay_InnDialogMeals_OID = _Seed_AddToggleOption(_Seed_Settings_InnDialogMeals, "$LastSeedGameplaySettingInnDialogMeals")
	Advanced_AlternativeDeathSystem_OID = _Seed_AddToggleOption(_Seed_Setting_AlternateDeathSystem, "$LastSeedAdvancedSettingAlternativeDeathSystem")
	Gameplay_Cannibalism_OID = _Seed_AddToggleOption(_Seed_Setting_CannibalismEnabled, "$LastSeedGameplaySettingCannibalism")
	Gameplay_VampirismMode_OID = AddMenuOption("$LastSeedGameplaySettingPlayerVampirism", VampirismModeList[_Seed_Setting_VampireBehavior.GetValueInt() - 1])
	Advanced_PlayerIsLich_OID = _Seed_AddToggleOption(_Seed_SettingPlayerIsLich, "$LastSeedAdvancedSettingPlayerIsLich")
	AddEmptyOption()
	
	;NEW COLUMN
	SetCursorPosition(1)
	
	; FOLLOWERS
	AddHeaderOption("$LastSeedGameplayHeaderFollowers")
	Gameplay_Followers_OID = AddMenuOption("$LastSeedGameplaySettingsFollowers", FollowerModeList[_Seed_Setting_SystemEnabled_FollowerNeeds.GetValueInt() - 1])
	Gameplay_FollowerPartyCount_OID = AddMenuOption("$LastSeedPartyCount", followerCountList[_Seed_Setting_PartyCount.GetValueInt()])
	Advanced_ProvisionWeightPP_OID = AddSliderOption("$LastSeedAdvancedSettingProvisionWeight", _Seed_Provisions_WeightPerPerson.GetValue(), "{0}")
	Gameplay_FollowersConsumeFood_OID = _Seed_AddToggleOption(_Seed_Setting_FollowersConsumeFood, "$LastSeedGameplaySettingFollowersConsumeFood")
	Gameplay_SeranaDrinksBlood_OID = _Seed_AddToggleOption(_Seed_Setting_SeranaDrinksBlood, "$LastSeedGameplaySettingSeranaDrinksBlood")
	AddEmptyOption()
		
	;FOOD
	AddHeaderOption("$LastSeedGameplayHeaderFood")
	Gameplay_FoodWeightMulti_OID = AddSliderOption("$LastSeedGameplaySettingWeightMulti", _Seed_Setting_FoodWeightMulti.GetValue(), "{1}")
	Gameplay_FoodPriceMulti_OID = AddSliderOption("$LastSeedGameplaySettingPriceMulti", _Seed_Setting_FoodPriceMulti.GetValue(), "{1}")
 
	Gameplay_FoodNames_OID = AddMenuOption("$LastSeedGameplaySettingFoodNames", FoodNamesList[_Seed_Setting_AddNames.GetValueInt() - 1])
	AddEmptyOption()
	
endFunction
					 

function PageReset_Needs()
	SetCursorFillMode(TOP_TO_BOTTOM)
	if LastSeedRunning.GetValueInt() != 2 || must_exit
		AddTextOption("$LastSeedNotRunningError", "", OPTION_FLAG_DISABLED)
		return
	endif
	
	AddHeaderOption("$LastSeedGameplayHeaderGeneral")
	Gameplay_NeedsAffectedByRegeneration_OID = _Seed_AddToggleOption(_Seed_Setting_NeedsAffectedByRegeneration, "$LastSeedGameplaySettingNeedsRegeneration")	
	Gameplay_MovementPenalty_OID = _Seed_AddToggleOption(_Seed_Setting_ThirstAffectsMovement, "$LastSeedGameplaySettingPlayerMovement")
	AddEmptyOption()
	
	;/----
	HUNGER
	-----/;
	AddHeaderOption("$LastSeedGameplayHeaderHunger")
	Gameplay_HungerEnabled_OID = _Seed_AddToggleOption(_Seed_Setting_SystemEnabled_Hunger, "$LastSeedGameplaySettingHungerEnable")
	Gameplay_HungerRate_OID = AddSliderOption("$LastSeedGameplaySettingHungerRate", _Seed_Setting_RateMulti_Hunger.GetValue(), "{1}")
	Gameplay_DiminishingFoodReturns_OID = _Seed_AddToggleOption(_Seed_Setting_DiminishingFoodReturns, "$LastSeedGameplaySettingDiminishingFoodReturn")	
	
	;NEW COLUMN
	SetCursorPosition(1)
	;/----
	THIRST
	-----/;
				  
	AddHeaderOption("$LastSeedGameplayHeaderThirst")
	Gameplay_ThirstEnabled_OID = _Seed_AddToggleOption(_Seed_Setting_SystemEnabled_Thirst, "$LastSeedGameplaySettingThirstEnable")
	Gameplay_ThirstRate_OID = AddSliderOption("$LastSeedGameplaySettingThirstRate", _Seed_Setting_RateMulti_Thirst.GetValue(), "{1}")
	AddEmptyOption()
	
	;/-----
	FATIGUE
	------/;
				  
	AddHeaderOption("$LastSeedGameplayHeaderFatigue")
	Gameplay_FatigueEnabled_OID = _Seed_AddToggleOption(_Seed_Setting_SystemEnabled_Fatigue, "$LastSeedGameplaySettingFatigueEnable")
	Gameplay_FatigueRate_OID = AddSliderOption("$LastSeedGameplaySettingFatigueRate", _Seed_Setting_RateMulti_Fatigue.GetValue(), "{1}")
	Gameplay_SleepAffectedByNeeds_OID = _Seed_AddToggleOption(_Seed_Setting_SleepAffectedByNeeds, "$LastSeedGameplaySettingSleepAffectedByNeeds")
	Gameplay_SleepAffectedByLocation_OID = _Seed_AddToggleOption(_Seed_Setting_SleepAffectedByLocation, "$LastSeedGameplaySettingSleepAffectedByLocation")
endFunction

function PageReset_Vitality()
	SetCursorFillMode(TOP_TO_BOTTOM)
	if LastSeedRunning.GetValueInt() != 2 || must_exit
		AddTextOption("$LastSeedNotRunningError", "", OPTION_FLAG_DISABLED)
		return
	endif

	;/------
	VITALITY
	------/;
	;AddEmptyOption()
	AddHeaderOption("$LastSeedGameplayHeaderVitality")
	Gameplay_VitalityEnabled_OID = _Seed_AddToggleOption(_Seed_Setting_SystemEnabled_Vitality, "$LastSeedGameplaySettingVitalityEnable")
	Gameplay_VitalityRate_OID = AddSliderOption("$LastSeedGameplaySettingVitalityRate", _Seed_Setting_RateMulti_Vitality.GetValue(), "{1}")
	Gameplay_NoVitalityMode_OID = AddMenuOption("$LastSeedGameplaySettingPlayerVitalityMode", NoVitalityList[_Seed_Setting_NoVitalityMode.GetValueInt() - 1])

	
	SetCursorPosition(1)
	
	;/------------
	VITALITY MULTI
	------------/;
	;AddEmptyOption()
	AddHeaderOption("$LastSeedGameplayHeaderVitalityMulti")
	Gameplay_VitalityHungerMulti_OID = AddSliderOption("$LastSeedGameplaySettingVitalityHungerMulti", _Seed_setting_VitalityHungerMulti.GetValue(), "{1}")
	Gameplay_VitalityThirstMulti_OID = AddSliderOption("$LastSeedGameplaySettingVitalityThirstMulti", _Seed_setting_VitalityThirstMulti.GetValue(), "{1}")
	Gameplay_VitalityFatigueMulti_OID = AddSliderOption("$LastSeedGameplaySettingVitalityFatigueMulti", _Seed_setting_VitalityFatigueMulti.GetValue(), "{1}")
	Gameplay_VitalityDiseaseMulti_OID = AddSliderOption("$LastSeedGameplaySettingVitalityDiseaseMulti", _Seed_setting_VitalityDiseaseMulti.GetValue(), "{1}")
	Gameplay_VitalityExposureMulti_OID = AddSliderOption("$LastSeedGameplaySettingVitalityExposureMulti", _Seed_setting_VitalityExposureMulti.GetValue(), "{1}")
endFunction

function PageReset_AlcoholDisease()
	SetCursorFillMode(TOP_TO_BOTTOM)
	if LastSeedRunning.GetValueInt() != 2 || must_exit
		AddTextOption("$LastSeedNotRunningError", "", OPTION_FLAG_DISABLED)
		return
	endif
	
	;/------
	ALCOHOL
	------/;
	AddHeaderOption("$LastSeedAlcoholHeaderAlcohol")
	Alcohol_Enabled_OID = _Seed_AddToggleOption(_Seed_Setting_AlcoholSystemEnabled, "$LastSeedGameplaySettingAlcoholEnable")
	Gameplay_AlcoholRate_OID = AddSliderOption("$LastSeedGameplaySettingAlcoholRate", _Seed_Setting_RateMulti_Alcohol.GetValue(), "{1}")
	Skooma_Enabled_OID = _Seed_AddToggleOption(_Seed_Setting_SkoomaSystemEnabled, "$LastSeedGameplaySettingSkoomaEnable")
	Gameplay_SkoomaRate_OID = AddSliderOption("$LastSeedGameplaySettingSkoomaRate", _Seed_Setting_RateMulti_Skooma.GetValue(), "{1}")	
	Alcohol_RateAle_OID = AddSliderOption("$LastSeedGameplaySettingAlcoholRateAle", _Seed_Setting_AlcoholMulti_Ale.GetValue(), "{1}")
	Alcohol_RateWine_OID = AddSliderOption("$LastSeedGameplaySettingAlcoholRateWine", _Seed_Setting_AlcoholMulti_Wine.GetValue(), "{1}")
	Alcohol_RateSpirits_OID = AddSliderOption("$LastSeedGameplaySettingAlcoholRateSpirits", _Seed_Setting_AlcoholMulti_Spirits.GetValue(), "{1}")
	Alcohol_RateSkoomaWeak_OID = AddSliderOption("$LastSeedGameplaySettingAlcoholRateSkoomaWeak", _Seed_Setting_SkoomaMulti_Weak.GetValue(), "{1}")
	Alcohol_RateSkoomaStrong_OID = AddSliderOption("$LastSeedGameplaySettingAlcoholRateSkoomaStrong", _Seed_Setting_SkoomaMulti_Strong.GetValue(), "{1}")
	Alcohol_Stumbling_OID = _Seed_AddToggleOption(_Seed_Setting_DrunkStumbling, "$LastSeedGameplaySettingAlcoholStumbling")
	Alcohol_Shenanigans_OID = _Seed_AddToggleOption(_Seed_Settings_DrunkenShenanigans, "$LastSeedGameplaySettingAlcoholShenanigans")	
	
	
	;/------
	DISEASE
	------/;	
	SetCursorPosition(1)
	AddHeaderOption("$LastSeedGameplayHeaderDisease")
	Disease_Enabled_OID = _Seed_AddToggleOption(_Seed_Setting_DiseaseType, "$LastSeedGameplaySettingDiseaseEnable")
	Disease_Additional_OID = _Seed_AddToggleOption(_Seed_SettingAdditionalDiseases, "$LastSeedGameplaySettingAdditionalDiseases")
	Disease_ShrinesCure_OID = _Seed_AddToggleOption(_Seed_Setting_ShrinesCure, "$LastSeedGameplaySettingShrinesCureDisease")
	Disease_PriestsCure_OID = _Seed_AddToggleOption(_Seed_Setting_DiseasePriestsCure, "$LastSeedGameplaySettingPriestsCureDisease")
	;Disease_PotionsCure_OID = _Seed_AddToggleOption(_Seed_Setting_DiseasePotionsCure, "$LastSeedGameplaySettingPotionsCureDisease")
	Disease_PotionsCure_OID = AddMenuOption("$LastSeedGameplaySettingPotionsCureDisease", DiseasePotionModeList[_Seed_Setting_DiseasePotionsCure.GetValueInt() - 1])
	Disease_ChanceRawFood_OID = AddSliderOption("$LastSeedGameplaySettingDiseaseChanceRawFood", _Seed_Setting_DiseaseChanceRawFood.GetValue(), "{0}")
	Disease_ChanceStaleFood_OID = AddSliderOption("$LastSeedGameplaySettingDiseaseChanceStaleFood", _Seed_Setting_DiseaseChanceStaleFood.GetValue(), "{0}")
	Disease_ChanceDirtyWater_OID = AddSliderOption("$LastSeedGameplaySettingDiseaseChanceDirtyWater", _Seed_Setting_DiseaseChanceDirtyWater.GetValue(), "{0}")
	
	;/
	if SeedUtil.GetCompatibilitySystem().isBathingInSkyrimLoaded
		Disease_Dirty_OID = _Seed_AddToggleOption(_Seed_Setting_DirtyDiseases, "$LastSeedGameplaySettingDiseaseDirty")
	endif
	/;
	
endFunction

function PageReset_FoodSpoilage()
	SetCursorFillMode(TOP_TO_BOTTOM)
	if LastSeedRunning.GetValueInt() != 2 || must_exit
		AddTextOption("$LastSeedNotRunningError", "", OPTION_FLAG_DISABLED)
		return
	endif
	
	;/--------------
	GENERAL SPOILAGE
	--------------/;
	AddHeaderOption("$LastSeedGameplayHeaderSpoilage")
	Gameplay_SpoilageEnable_OID = _Seed_AddToggleOption(_Seed_Setting_SpoilageEnable, "$LastSeedGameplaySettingSpoilageEnable")
	Gameplay_SpoilageRemove_OID = AddMenuOption("$LastSeedGameplaySettingSpoilageRemove", SpoilageRemoveModeList[_Seed_Setting_SpoilageRemove.GetValueInt() - 1])
	Gameplay_SpoilageTemperature_OID = _Seed_AddToggleOption(_Seed_Setting_SpoilageTemperatureMulti, "$LastSeedGameplaySettingSpoilageTemperature")	
	;/
	Spoilage_ContainersEnabled_OID = _Seed_AddToggleOption(_Seed_Setting_ContainerSpoilageEnable, "$LastSeedGameplaySettingContainerSpoilageEnable")
	Spoilage_ContainersRate_OID = AddSliderOption("$LastSeedGameplaySettingContainerSpoilageRate", _Seed_Setting_ContainerSpoilageRate.GetValue(), "{0}")
	/;


	;/-----------------
	FOOD SPOILAGE RATES
	-----------------/;
	AddHeaderOption("$LastSeedGameplayHeaderSpoilageRates")
	Spoilage_Bread_OID = AddSliderOption("$LastSeedGameplaySettingSpoilageRateBread", _Seed_Setting_SpoilRate01_Bread.GetValue(), "{0}")
	Spoilage_MeatRaw_OID = AddSliderOption("$LastSeedGameplaySettingSpoilageRateMeatRaw", _Seed_Setting_SpoilRate02_RawMeat.GetValue(), "{0}")
	Spoilage_MeatCooked_OID = AddSliderOption("$LastSeedGameplaySettingSpoilageRateMeatCooked", _Seed_Setting_SpoilRate03_CookedMeat.GetValue(), "{0}")
	Spoilage_SmallGameRaw_OID = AddSliderOption("$LastSeedGameplaySettingSpoilageSmallGameRaw", _Seed_Setting_SpoilRate04_RawSmallGame.GetValue(), "{0}")
	Spoilage_SmallGameCooked_OID = AddSliderOption("$LastSeedGameplaySettingSpoilageSmallGameCooked", _Seed_Setting_SpoilRate05_CookedSmallGame.GetValue(), "{0}")
	Spoilage_FishRaw_OID = AddSliderOption("$LastSeedGameplaySettingSpoilageFishRaw", _Seed_Setting_SpoilRate06_RawFish.GetValue(), "{0}")
	Spoilage_FishCooked_OID = AddSliderOption("$LastSeedGameplaySettingSpoilageFishCooked", _Seed_Setting_SpoilRate07_CookedFish.GetValue(), "{0}")
	
	;NEW COLUMN
	SetCursorPosition(1)
	AddHeaderOption("$LastSeedGameplayHeaderSpoilageRatesCont")
	Spoilage_SeafoodRaw_OID = AddSliderOption("$LastSeedGameplaySettingSpoilageSeafoodRaw", _Seed_Setting_SpoilRate08_RawSeafood.GetValue(), "{0}")
	Spoilage_SeafoodCooked_OID = AddSliderOption("$LastSeedGameplaySettingSpoilageSeafoodCooked", _Seed_Setting_SpoilRate09_CookedSeafood.GetValue(), "{0}")
	Spoilage_Vegetables_OID = AddSliderOption("$LastSeedGameplaySettingSpoilageVegitables", _Seed_Setting_SpoilRate10_Vegitables.GetValue(), "{0}")
	Spoilage_Fruit_OID = AddSliderOption("$LastSeedGameplaySettingSpoilageFruit", _Seed_Setting_SpoilRate11_Fruit.GetValue(), "{0}")
	Spoilage_Cheese_OID = AddSliderOption("$LastSeedGameplaySettingSpoilageCheese", _Seed_Setting_SpoilRate12_Cheese.GetValue(), "{0}")
	Spoilage_Treats_OID = AddSliderOption("$LastSeedGameplaySettingSpoilageTreats", _Seed_Setting_SpoilRate13_Treats.GetValue(), "{0}")
	Spoilage_Pastries_OID = AddSliderOption("$LastSeedGameplaySettingSpoilagePastry", _Seed_Setting_SpoilRate14_Pastry.GetValue(), "{0}")
	Spoilage_Stews_OID = AddSliderOption("$LastSeedGameplaySettingSpoilageStew", _Seed_Setting_SpoilRate15_Stew.GetValue(), "{0}")
	Spoilage_CheeseBowls_OID = AddSliderOption("$LastSeedGameplaySettingSpoilageCheeseBowl", _Seed_Setting_SpoilRate16_CheeseBowls.GetValue(), "{0}")
	Spoilage_DrinkMilk_OID = AddSliderOption("$LastSeedGameplaySettingSpoilageMilk", _Seed_Setting_SpoilRate17_Milk.GetValue(), "{0}")
	Spoilage_IceWraithTeeth_OID = AddSliderOption("$LastSeedGameplaySettingSpoilageIceWraithTeeth", _Seed_Setting_SpoilRate_IceWraithTeeth.GetValue(), "{0}")
endFunction

int function _Seed_AddToggleOption(GlobalVariable akSettingsGlobal, string label)
	if akSettingsGlobal.GetValueInt() == 2
		return AddToggleOption(label, true)
	else
		return AddToggleOption(label, false)
	endif
endFunction

int function _Seed_AddToggleOptionInt(int val, string label)
	if val == 2
		return AddToggleOption(label, true)
	else
		return AddToggleOption(label, false)
	endif
endFunction

function PageReset_Interface()
	SetCursorFillMode(TOP_TO_BOTTOM)
	if LastSeedRunning.GetValueInt() != 2 || must_exit
		AddTextOption("$LastSeedNotRunningError", "", OPTION_FLAG_DISABLED)
		return
	endif
	
	;EFFECTS
	AddHeaderOption("$LastSeedInterfaceHeaderEffects")
	Interface_SoundEffects_OID = _Seed_AddToggleOption(_Seed_Setting_NeedsSFX, "$LastSeedInterfaceSettingSoundEffects")
	Interface_FullScreenEffects_OID = _Seed_AddToggleOption(_Seed_Setting_NeedsVFX, "$LastSeedInterfaceSettingImagespaceModifiers")	
	Interface_ForceFeedback_OID = _Seed_AddToggleOption(_Seed_Setting_NeedsForceFeedback, "$LastSeedInterfaceSettingForceFeedback")
	
	;NOTIFIACTIONS
	AddEmptyOption()
	AddHeaderOption("$LastSeedInterfaceHeaderNotifications")
	Interface_ConditionMessages_OID = _Seed_AddToggleOption(_Seed_Setting_Notifications, "$LastSeedInterfaceSettingConditionMsgToggle")
	Interface_ConditionMessagesFollowers_OID = _Seed_AddToggleOption(_Seed_Setting_Notifications_Followers, "$LastSeedInterfaceSettingConditionMsgFollowersToggle")	
	Interface_FocusNotificatons_OID = _Seed_AddToggleOption(_Seed_Setting_FocusNotifications, "$LastSeedInterfaceSettingConditionMsgFocusToggle")	
	Interface_FrostfallNotificatons_OID = _Seed_AddToggleOption(_Seed_Setting_FrostfallNotifications, "$LastSeedInterfaceSettingConditionMsgFrostfallToggle")	
	;TODO: Add follower notifications
	
	;ANIMATIONS
	SetCursorPosition(1)
	AddHeaderOption("$LastSeedInterfaceHeaderAnimations")
	Interface_Animation_OID = _Seed_AddToggleOption(_Seed_Setting_AnimatePlayer, "$LastSeedInterfaceSettingAnimationsToggle")
	Interface_FollowerAnimation_OID = _Seed_AddToggleOption(_Seed_Setting_AnimateFollowers, "$LastSeedInterfaceSettingAnimationsFollowersToggle")
	Interface_AnimationPickup_OID = _Seed_AddToggleOption(_Seed_Setting_AnimatePickup, "$LastSeedInterfaceSettingAnimationsPickupToggle")
endfunction

function PageReset_Meters()
	meterMenuOpened = true

	SetCursorFillMode(TOP_TO_BOTTOM)
	if LastSeedRunning.GetValueInt() != 2 || must_exit
		AddTextOption("$LastSeedNotRunningError", "", OPTION_FLAG_DISABLED)
		return
	endif
	
	;NEEDS METERS
	;SetCursorPosition(1)
	AddHeaderOption("$LastSeedInterfaceHeaderMetersGeneral")
	Meters_UIMeterDisplay_OID = AddMenuOption("$LastSeedInterfaceSettingMeterDisplayMode", getMeterModeString(_Seed_Setting_HungerMeterDisplayMode))
	Meters_UIMeterDisplayTime_OID = AddSliderOption("$LastSeedInterfaceSettingMeterDisplaytime", _Seed_Setting_HungerMeterDisplayTime.getValueInt(), "{0}")
	Meters_UIMeterOpacity_OID = AddSliderOption("$LastSeedInterfaceSettingUIMeterOpacity", _Seed_Setting_MeterHungerOpacity.getValueInt(), "{0}")
	AddEmptyOption()
	
	;VITALITY METER
	AddHeaderOption("$LastSeedInterfaceHeaderMetersVitality")
	Meters_UIMeterDisplay_Vitality_OID = AddMenuOption("$LastSeedInterfaceSettingMeterDisplayModeVitality", getMeterModeString(_Seed_Setting_VitalityMeterDisplayMode))
	Meters_UIMeterDisplayTime_Vitality_OID = AddSliderOption("$LastSeedInterfaceSettingMeterDisplaytime", _Seed_Setting_VitalityMeterDisplayTime.getValueInt(), "{0}")
	Meters_UIMeterOpacity_Vitality_OID = AddSliderOption("$LastSeedInterfaceSettingUIMeterOpacity", _Seed_Setting_MeterVitalityOpacity.getValueInt(), "{0}")
	AddEmptyOption()
	
	SetCursorPosition(1)
	AddHeaderOption("$LastSeedInterfaceHeaderMetersPosition")
	Meters_manualPosition_OID = _Seed_AddToggleOption(_seed_setting_manualMeterConfig, "$LastSeedInterfaceManualMeterConfig")
	AddEmptyOption()
	
	if(_seed_setting_manualMeterConfig.getValueInt() == 1)
		Meters_UIMeterXPos_Hunger_OID = AddSliderOption("$SeedMeterSettingUIMeterXPos_hunger", _Seed_Setting_MeterHungerXPos.GetValue(), "{1}")
		Meters_UIMeterYPos_Hunger_OID = AddSliderOption("$SeedMeterSettingUIMeterYPos_hunger", _Seed_Setting_MeterHungerYPos.GetValue(), "{1}")
		Meters_UIMeterHAnchor_Hunger_OID = AddMenuOption("$SeedMeterSettingUIMeterHAnchor_Hunger", HorizontalAnchorList[_Seed_Setting_MeterHungerHAnchor.GetValueInt()])
		Meters_UIMeterVAnchor_Hunger_OID = AddMenuOption("$SeedMeterSettingUIMeterVAnchor_Hunger", VerticalAnchorList[_Seed_Setting_MeterHungerVAnchor.GetValueInt()])
		AddEmptyOption()
		
		Meters_UIMeterXPos_Thirst_OID = AddSliderOption("$SeedMeterSettingUIMeterXPos_Thirst", _Seed_Setting_MeterThirstXPos.GetValue(), "{1}")
		Meters_UIMeterYPos_Thirst_OID = AddSliderOption("$SeedMeterSettingUIMeterYPos_Thirst", _Seed_Setting_MeterThirstYPos.GetValue(), "{1}")	
		Meters_UIMeterHAnchor_Thirst_OID = AddMenuOption("$SeedMeterSettingUIMeterHAnchor_Thirst", HorizontalAnchorList[_Seed_Setting_MeterThirstHAnchor.GetValueInt()])
		Meters_UIMeterVAnchor_Thirst_OID = AddMenuOption("$SeedMeterSettingUIMeterVAnchor_Thirst", VerticalAnchorList[_Seed_Setting_MeterThirstVAnchor.GetValueInt()])		
		AddEmptyOption()
		
		Meters_UIMeterXPos_Fatigue_OID = AddSliderOption("$SeedMeterSettingUIMeterXPos_Fatigue", _Seed_Setting_MeterFatigueXPos.GetValue(), "{1}")
		Meters_UIMeterYPos_Fatigue_OID = AddSliderOption("$SeedMeterSettingUIMeterYPos_Fatigue", _Seed_Setting_MeterFatigueYPos.GetValue(), "{1}")
		Meters_UIMeterHAnchor_Fatigue_OID = AddMenuOption("$SeedMeterSettingUIMeterHAnchor_Fatigue", HorizontalAnchorList[_Seed_Setting_MeterFatigueHAnchor.GetValueInt()])
		Meters_UIMeterVAnchor_Fatigue_OID = AddMenuOption("$SeedMeterSettingUIMeterVAnchor_Fatigue", VerticalAnchorList[_Seed_Setting_MeterFatigueVAnchor.GetValueInt()])
		AddEmptyOption()
		
		Meters_UIMeterXPos_Vitality_OID = AddSliderOption("$SeedMeterSettingUIMeterXPos_Vitality", _Seed_Setting_MeterVitalityXPos.GetValue(), "{1}")
		Meters_UIMeterYPos_Vitality_OID = AddSliderOption("$SeedMeterSettingUIMeterYPos_Vitality", _Seed_Setting_MeterVitalityYPos.GetValue(), "{1}")
		Meters_UIMeterHAnchor_Vitality_OID = AddMenuOption("$SeedMeterSettingUIMeterHAnchor_Vitality", HorizontalAnchorList[_Seed_Setting_MeterVitalityHAnchor.GetValueInt()])
		Meters_UIMeterVAnchor_Vitality_OID = AddMenuOption("$SeedMeterSettingUIMeterVAnchor_Vitality", VerticalAnchorList[_Seed_Setting_MeterVitalityVAnchor.GetValueInt()])
		AddEmptyOption()
		
		
		AddHeaderOption("$LastSeedInterfaceTitleGeneral")
		
		Meters_UIMeterScale_OID = AddSliderOption("$LastSeedInterfaceSettingMeterScale", _Seed_Setting_MeterScale.getValueInt(), "{1}")
		Meters_UIMeterScaleVitality_OID = AddSliderOption("$LastSeedInterfaceSettingMeterScaleVitality", _Seed_Setting_MeterScaleVitality.getValueInt(), "{1}")
		;Meters_UIMeterWidth_OID = AddSliderOption("$LastSeedInterfaceSettingMeterWidth", _Seed_Setting_MeterHungerWidth.getValueInt(), "{1}")
		;Meters_UIMeterHeight_OID = AddSliderOption("$LastSeedInterfaceSettingMeterHeight", _Seed_Setting_MeterHungerHeight.getValueInt(), "{1}")
		;Meters_UIMeterWidth_Vitality_OID = AddSliderOption("$LastSeedInterfaceSettingMeterWidthVitality", _Seed_Setting_MeterVitalityWidth.getValueInt(), "{1}")
		;Meters_UIMeterHeight_Vitality_OID = AddSliderOption("$LastSeedInterfaceSettingMeterHeightVitality", _Seed_Setting_MeterVitalityHeight.getValueInt(), "{1}")
		
	endif


	
	; TODO: Advanced Meter Settings
	;Meters_UIMeterHAnchor_OID = AddMenuOption("$FrostfallInterfaceSettingUIMeterHAnchor", HorizontalAnchorList[_Frost_Setting_MeterExposureHAnchor.GetValueInt()])
	;Meters_UIMeterVAnchor_OID = AddMenuOption("$FrostfallInterfaceSettingUIMeterVAnchor", VerticalAnchorList[_Frost_Setting_MeterExposureVAnchor.GetValueInt()])
	;Meters_UIMeterXPos_OID = AddSliderOption("$FrostfallInterfaceSettingUIMeterXPos", _Seed_Setting_H.GetValue(), "{1}")
	;Meters_UIMeterYPos_OID = AddSliderOption("$FrostfallInterfaceSettingUIMeterYPos", _Frost_Setting_MeterExposureYPos.GetValue(), "{1}")
	
	;Meters_UIMeterFillDirection_OID = AddMenuOption("$FrostfallInterfaceSettingUIMeterFillDirection", FillDirectionListLimited[_Frost_Setting_MeterExposureFillDirection.GetValueInt()])
	;Meters_UIMeterWidth_OID = 0
	;Meters_UIMeterHeight_OID = 0
	
	;/
	AddHeaderOption("$LastSeedInterfaceHeaderMetersGeneral")
	Meters_UIMeterDisplay_OID = AddMenuOption("$LastSeedInterfaceSettingMeterDisplayMode", getMeterModeString(_Seed_Setting_HungerMeterDisplayMode))
	Meters_UIMeterDisplayTime_OID = AddSliderOption("$LastSeedInterfaceSettingMeterDisplaytime", _Seed_Setting_HungerMeterDisplayTime.getValueInt(), "{0}")
	Meters_UIMeterOpacity_OID = AddSliderOption("$LastSeedInterfaceSettingUIMeterOpacity", _Seed_Setting_MeterHungerOpacity.getValueInt(), "{0}")
	AddEmptyOption()
	AddHeaderOption("$LastSeedInterfaceHeaderMetersVitality")
	Meters_UIMeterDisplay_Vitality_OID = AddMenuOption("$LastSeedInterfaceSettingMeterDisplayModeVitality", getMeterModeString(_Seed_Setting_VitalityMeterDisplayMode))
	Meters_UIMeterDisplayTime_Vitality_OID = AddSliderOption("$LastSeedInterfaceSettingMeterDisplaytime", _Seed_Setting_VitalityMeterDisplayTime.getValueInt(), "{0}")
	Meters_UIMeterOpacity_Vitality_OID = AddSliderOption("$LastSeedInterfaceSettingUIMeterOpacity", _Seed_Setting_MeterVitalityOpacity.getValueInt(), "{0}")
	/;
	


	
	;Meters_UIMeterLayout_OID = 0
	;Meters_UIMeterScale_OID = 0
	;Meters_UIMeterFlipped_OID = 0
	;Meters_UIMeterColor_OID = 0


	
	
	;AddHeaderOption("$LastSeedInterfaceHeaderMetersAdvanced")
	;AddHeaderOption("$LastSeedInterfaceHeaderMetersHungerName")
	;AddHeaderOption("$LastSeedInterfaceHeaderMetersThirstName")
	;AddHeaderOption("$LastSeedInterfaceHeaderMetersFatigueName")
	;AddHeaderOption("$LastSeedInterfaceHeaderMetersVitalityName")
	
	
	;$LastSeedInterfaceSettingMeterDisplaytime
	;$LastSeedInterfaceSettingMeterDisplayMode
endFunction

function PageReset_Advanced()
	SetCursorFillMode(TOP_TO_BOTTOM)

	AddHeaderOption("$LastSeedAdvancedHeaderProvisioningSkill")
	Advanced_ProvisioningSkillRespec_OID = AddTextOption("$LastSeedAdvancedProvisioningSkillRespec", "", OPTION_FLAG_DISABLED)
	Advanced_ProvisioningSkillRestore_OID = AddToggleOption("$LastSeedAdvancedProvisioningSkillRestore", false, OPTION_FLAG_DISABLED)
	Advanced_ProvisioningSkillRestoreSlider_OID = AddSliderOption("$LastSeedAdvancedProvisioningSkillRestoreAmount", 0, "{0}", OPTION_FLAG_DISABLED)
endFunction

function PageReset_SaveLoad()
	SetCursorFillMode(TOP_TO_BOTTOM)
	if LastSeedRunning.GetValueInt() != 2 || must_exit
		AddTextOption("$LastSeedNotRunningError", "")
		return
	endif

	AddHeaderOption("$LastSeedSaveLoadHeaderProfile")
	if _Seed_Setting_AutoSaveLoad.GetValueInt() == 2
		SaveLoad_SelectProfile_OID = AddMenuOption("$LastSeedSaveLoadCurrentProfile", GetProfileName(_Seed_Setting_CurrentProfile.GetValueInt()))
	else
		SaveLoad_SelectProfile_OID = AddMenuOption("$LastSeedSaveLoadCurrentProfile", GetProfileName(_Seed_Setting_CurrentProfile.GetValueInt()))
	endif
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	SaveLoad_ProfileHelp_OID = AddTextOption("$LastSeedSaveLoadAboutProfiles", "")
	if _Seed_Setting_AutoSaveLoad.GetValueInt() == 2
		SaveLoad_Enable_OID = AddToggleOption("$LastSeedSaveLoadEnable", true)
	else
		SaveLoad_Enable_OID = AddToggleOption("$LastSeedSaveLoadEnable", false)
	endif

	SetCursorPosition(1) ; Move cursor to top right position

	AddEmptyOption()
	if _Seed_Setting_AutoSaveLoad.GetValueInt() == 2
		; IcZ (SE 1.7.104): Special Edition ships SkyUI as SkyUI_SE.esp. 5.3 looked only for SkyUI.esp
		; and read ReqSWFRelease off None, which failed on every Profiles page open on SE.
		SKI_Main skyui = Game.GetFormFromFile(0x00000814, "SkyUI.esp") as SKI_Main
		if !skyui
			skyui = Game.GetFormFromFile(0x00000814, "SkyUI_SE.esp") as SKI_Main
		endif
		int version = 0
		if skyui
			version = skyui.ReqSWFRelease
		endif
		if version >= 1026 	; SkyUI 5.1+
			SaveLoad_RenameProfile_OID = AddInputOption("", "$LastSeedSaveLoadRenameProfile")
		else
			SaveLoad_RenameProfile_OID = AddTextOption("$LastSeedSkyUI51Required", "$LastSeedSaveLoadRenameProfile", OPTION_FLAG_DISABLED)
		endif
		SaveLoad_DefaultProfile_OID = AddTextOption("", "$LastSeedSaveLoadDefaultProfile")
	endif
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	if _Seed_Setting_AutoSaveLoad.GetValueInt() == 2
		AddTextOption("$LastSeedSaveLoadSettingsSaved", "")
	endif
endFunction

function ResetPageLists()
	SetCursorFillMode(TOP_TO_BOTTOM)
	
	if LastSeedRunning.GetValueInt() != 2 || must_exit
		AddTextOption("$LastSeedNotRunningError", "")
		return
	endif
	
	int i = 0
	
	_listRefNames = Utility.CreateStringArray(_listRef[_selectedList].GetSize(), "")
	
	while (i < _listRefNames.Length)
		_listRefNames[i] = _listRef[_selectedList].GetAt(i).GetName()
		i += 1
	endWhile
	
	SetCursorPosition(1)
	selectedForm = _listRef[_selectedList].GetAt(_selectedItem)
	AddHeaderOption(SelectedForm.getName())
	if(_Seed_SystemFoods.hasform(selectedForm))
		FoodLists_Edit_OID = addToggleOption("$LastSeedFoodListEditItem", false, OPTION_FLAG_DISABLED)
	else
		FoodLists_Edit_OID = addToggleOption("$LastSeedFoodListEditItem", editFoodItem)	
	endif
	;SHOW EDIT MENU
	if(editFoodItem)
		FoodLists_Edit_ListMenu_OID = AddMenuOption("$LastSeedFoodListFoodLists", _listMenu[_selectedList_edit])
		int foodType = GetFoodType(selectedForm as potion)
		if(foodType > 0 && foodType < 18)
			
			if _Seed_Food_RestoreHungerMinor.HasForm(selectedForm as potion)
				restoreIndex = 0
			elseif _Seed_Food_RestoreHungerMajor.HasForm(selectedForm as potion)
				restoreIndex = 1
			elseif _Seed_Food_RestoreHungerSuperior.HasForm(selectedForm as potion)
				restoreIndex = 2
			elseif _Seed_Food_RestoreHungerMassive.HasForm(selectedForm as potion)
				restoreIndex = 3
			else 
				restoreIndex = 0
				setFoodRestoreAmount(selectedForm as potion, 1) 
			endif
			FoodLists_Edit_RestoreHunger_OID = AddMenuOption("$LastSeedFoodListRestoreAmount", _HungerMenu[restoreIndex])
			
			;PRESERVED
			bool isPreserved = IsFoodPreserved(selectedForm as Potion)
			FoodLists_Edit_Preserved_OID = addToggleOption("$LastSeedFoodListEditPreserved", isPreserved)
			
			;SALTED
			if(isPreserved)
				bool isSalted = IsFoodSalted(selectedForm as Potion)		
				FoodLists_Edit_Salted_OID = AddToggleOption("$LastSeedFoodListEditSalted", isSalted)
			else
				AddToggleOption("$LastSeedFoodListEditSalted", false, OPTION_FLAG_DISABLED)
			endif
		else
			FoodLists_Edit_RestoreHunger_OID = AddMenuOption("$LastSeedFoodListRestoreAmount", "", OPTION_FLAG_DISABLED)
			FoodLists_Edit_Preserved_OID = AddToggleOption("$LastSeedFoodListEditPreserved", false, OPTION_FLAG_DISABLED)
			FoodLists_Edit_Salted_OID = AddToggleOption("$LastSeedFoodListEditSalted", false, OPTION_FLAG_DISABLED)
		endif
		
		;ALCOHOL SETTINGS
		if foodType == 18
			alcoholIndex = 0				
			if _Seed_DrinkAlcoholicAle.HasForm(selectedForm as potion)
				alcoholIndex = 0
			elseif _Seed_DrinkAlcoholicWine.HasForm(selectedForm as potion)
				alcoholIndex = 1
			elseif _Seed_DrinkAlcoholicSpirit.HasForm(selectedForm as potion)
				alcoholIndex = 2
			elseif _Seed_DrinkSkoomaWeak.HasForm(selectedForm as potion)
				alcoholIndex = 3
			elseif _Seed_DrinkSkoomaStrong.HasForm(selectedForm as potion)
				alcoholIndex = 4
			else
				alcoholIndex = 0
				GetFoodDataStoreHandler().SetAlcoholType(SelectedForm as potion, 1)
			endif
			FoodLists_Edit_Alcohol_OID = AddMenuOption("$LastSeedFoodListAlcoholType", _AlcoholMenu[alcoholIndex])
		else
			FoodLists_Edit_Alcohol_OID = AddMenuOption("$LastSeedFoodListAlcoholType", "", OPTION_FLAG_DISABLED)
		endif
		
		;FOOD PORTIONS
		selectedPortion = GetFoodDataStoreHandler().GetMultiPartFoodResult_Array(selectedForm as potion, false)
		FoodLists_Edit_Portions_OID = AddToggleOption("$LastSeedFoodListEditPortions", selectedPortion)
		if selectedPortion
			portionCount = GetFoodDataStoreHandler().GetMultiPartFoodQuantity_Array(selectedForm as potion)

			;Add Food Portion Information
			if GetFoodDataStoreHandler().isNotFood(selectedPortion)
				selectedListPortions = 20
			elseif GetFoodDataStoreHandler().isBloodPotion(selectedPortion)
				selectedListPortions = 19
			else
				selectedListPortions = GetFoodType(selectedPortion) - 1
			endif	

			
			_listRefNamesPortions = Utility.CreateStringArray(_listRef[selectedListPortions].GetSize(), "")
			i = 0
			while (i < _listRefNamesPortions.Length)
				_listRefNamesPortions[i] = _listRef[selectedListPortions].GetAt(i).GetName()
				i += 1
			endWhile
			selectedItemPortions = _listRef[selectedListPortions].ToArray().Find(selectedPortion)
			
			FoodLists_Edit_PortionsListMenu_OID = AddMenuOption("$LastSeedFoodListFoodListsPortion", _listMenu[selectedListPortions])
		
			FoodLists_Edit_PortionsItemMenu_OID = AddMenuOption("$LastSeedFoodListAvailableItemsPortion", _listRefNamesPortions[selectedItemPortions])

			FoodLists_Edit_PortionsCount_OID = AddSliderOption("$LastSeedFoodListEditPortionCount", portionCount, "{0}")

			
		else
			FoodLists_Edit_PortionsListMenu_OID = AddMenuOption("$LastSeedFoodListFoodListsPortion", "", OPTION_FLAG_DISABLED)
			FoodLists_Edit_PortionsItemMenu_OID = AddMenuOption("$LastSeedFoodListAvailableItemsPortion", "", OPTION_FLAG_DISABLED)
			FoodLists_Edit_PortionsCount_OID = AddSliderOption("$LastSeedFoodListEditPortionCount", 0, "{0}", OPTION_FLAG_DISABLED)
		endif
	;SHOW ITEM DESCRIPTION
	else
		SetCursorPosition(0)
		AddHeaderOption("$LastSeedFoodListFormHeader")

		FoodLists_ListMenu_OID = AddMenuOption("$LastSeedFoodListFoodLists", _listMenu[_selectedList])
		
		FoodLists_ItemMenu_OID = AddMenuOption("$LastSeedFoodListAvailableItems", _listRefNames[_selectedItem])
		
		AddEmptyOption()
		
		;FoodLists_AddItem_OID = _Seed_AddToggleOption(_Seed_Setting_FoodListAdd, "$LastSeedFoodListAddItem")
		;FoodLists_ReclassifyItem_OID = _Seed_AddToggleOption(_Seed_Setting_FoodListReclassify, "$LastSeedFoodListReclassifyItem")
	
		addEmptyOption()
		selectedForm = _listRef[_selectedList].GetAt(_selectedItem)
		
		AddHeaderOption("$LastSeedFoodListProperties")
		if(selectedForm)
			String sFileName = Game.GetModName(Math.RightShift(selectedForm.GetFormID(), 24))
			AddTextOption("Source Mod: " + sFileName, "")
			
			i = 0
			while (i < _fullListMenu.Length)
				if (_fullListRef[i].HasForm(selectedForm))
					AddTextOption(_fullListMenu[i], "")
				endIf
				i += 1
			endWhile
			potion theFood = selectedForm as potion
			if(theFood)
				potion foodPortion = GetFoodDataStoreHandler().GetMultiPartFoodResult_Array(theFood, false)
				if foodPortion
					int portionAmount = GetFoodDataStoreHandler().GetMultiPartFoodQuantity_Array(theFood)
					AddTextOption("Portioned: " + foodPortion.getName() + " x" + portionAmount, "")
				endIf
			endif
		endif
	endif

endFunction





function PageReset_Help()
	SetCursorFillMode(TOP_TO_BOTTOM)
	if LastSeedRunning.GetValueInt() != 2 || must_exit
		AddHeaderOption("$LastSeedAdvancedHeaderAdvanced")
		Advanced_ForceStartMod_OID = _Seed_AddToggleOption(_Seed_Setting_ForceStartMod, "$LastSeedAdvancedSettingForceStart")
		AddTextOption("$LastSeedNotRunningError", "", OPTION_FLAG_DISABLED)
		return
	endif
	
	AddHeaderOption("$LastSeedAdvancedHeaderTutorials")
	Help_SettingEnableTutorials_OID = _Seed_AddToggleOption(_Seed_Setting_DisplayTutorials, "$LastSeedAdvancedSettingTutorialsShow")
	Help_SettingsResetTutorials_OID = _Seed_AddToggleOption(_Seed_Setting_ResetTutorials, "$LastSeedAdvancedSettingTutorialsReset")
	
	AddHeaderOption("$LastSeedAdvancedHeaderAdvanced")
	; Advanced_LogLevel_OID = AddMenuOption("$LastSeedLogLevel", LogLevel[_Seed_Setting_LogLevel.GetValueInt() + 1])
																																				
	; Advanced_PO3WaterDetection_OID = _Seed_AddToggleOption(_Seed_Setting_PO3WaterDetection, "$LastSeedAdvancedSettingPO3WaterDetection")
	Advanced_ResetFormLists_OID = _Seed_AddToggleOption(_Seed_Setting_ResetFoodLists, "$LastSeedAdvancedSettingResetFormlists")
	;Advanced_ForceStartMod_OID = _Seed_AddToggleOption(_Seed_Setting_ForceStartMod, "$LastSeedAdvancedSettingForceStart")
	if isSpecialEdition() && !seedUtil.GetCompatibilitySystem().isSkyrimVR
		Advanced_VampireMonitoring_OID = _Seed_AddToggleOption(_Seed_SettingVampireMonitoring, "$LastSeedAdvancedSettingVampireMonitoringSE")
	else
		Advanced_VampireMonitoring_OID = _Seed_AddToggleOption(_Seed_SettingVampireMonitoring, "$LastSeedAdvancedSettingVampireMonitoringLE")
	endif
														 
						  
																																  
	  
																					  
	  
																																			  
																													 
																																				  
	Advanced_RefreshSystemsOnLoad_OID = _Seed_AddToggleOption(_Seed_Setting_RefreshSystemsOnLoad, "$LastSeedAdvancedSettingRefreshOnLoad")
	
	AddHeaderOption("$LastSeedAdvancedHeaderProvisioningSkill")
	Advanced_ProvisioningSkillRespec_OID = AddTextOption("$LastSeedAdvancedProvisioningSkillRespec", "")
	Advanced_ProvisioningSkillRestore_OID = AddToggleOption("$LastSeedAdvancedProvisioningSkillRestore", false)
	Advanced_ProvisioningSkillRestoreSlider_OID = AddSliderOption("$LastSeedAdvancedProvisioningSkillRestoreAmount", 0, "{0}", OPTION_FLAG_DISABLED)
	
	SetCursorPosition(1)
	AddHeaderOption("$LastSeedAdvancedHeaderHotkeys")
	Gameplay_CheckNeedsHotkey_OID = AddKeyMapOption("$LastSeedHotkeyCheckNeeds", _Seed_HotkeyCheckNeeds.GetValueInt())
	Gameplay_AutoEatHotkey_OID = AddKeyMapOption("$LastSeedHotkeyAutoEat", _Seed_HotkeyAutoEat.GetValueInt())
	Gameplay_AutoDrinkHotkey_OID = AddKeyMapOption("$LastSeedHotkeyAutoDrink", _Seed_HotkeyAutoDrink.GetValueInt())
	Gameplay_ProvisionsHotkey_OID = AddKeyMapOption("$LastSeedHotkeyProvisions", _Seed_HotkeyProvisions.GetValueInt())
	Gameplay_IntensityHotkey_OID = AddKeyMapOption("$LastSeedHotkeyIntensity", _Seed_HotkeyIntensity.GetValueInt())
	Gameplay_ExamineFoodHotkey_OID = AddKeyMapOption("$LastSeedHotkeyExamineFood", _Seed_HotkeyExamineFood.GetValueInt())
	Gameplay_DrinkFromStreamHotkey_OID = AddKeyMapOption("$LastSeedHotkeyDrinkFromStream", _Seed_HotkeyDrinkFromStream.GetValueInt())
	

																									 
																											
																																				 
endFunction

string function getMeterModeString(GlobalVariable globalVar)
	int i = globalVar.getValueInt()
	
	;/
	int index = 0
	if i == 2
		index = 1
	elseif i == 4
		index = 2
	elseif i == 5
		index = 3
	endif	
	/;

	;/
	int index = 0
	if i == 5
		index = 1
	endif
	/;
	;/
	int index = 0
	if i == 2
		index = 1
	elseif i == 5
		index = 2
	endif
	SeedDebug(0, "[" + debugSystemName + "]: i=" + i + ", index = " + index)
	return MeterModeList[index]
	/;
	return MeterModeList[i]

endFunction

int function getMeterModeInt(GlobalVariable globalVar)
	int i = globalVar.getValueInt()
	int index = 0

	;/
	if i == 2
		index = 1
	elseif i == 4
		index = 2
	elseif i == 5
		index = 3
	endif
	/;
		
	;/
	if i == 5
		index = 1
	endif
	/;
	;/
	if i == 2
		index = 1
	elseif i == 5
		index = 2
	endif
	return index
	/;
	return i
endFunction

function setNeedsMode(GlobalVariable globalVar, int index)
	;/
	int result = 2
	if index == 1
		result = 5
	endif
	/;	
		
	;/
	if index == 1
		result = 2
	elseif index == 2
		result = 4
	elseif index == 3
		result = 5
	endif	
	/;
	;/
	int result = 1
	if index == 1
		result = 2	
	elseif index == 2
		result = 5
	endif	
	globalVar.setValue(result)
	/;
	globalVar.setValue(index)
endFunction 

event OnPageReset(string page)
	SeedDebug(0, "[" + debugSystemName + "]: Resetting Page ")
	if page == ""
		LoadCustomContent("lastseed/logo.dds")
	else
		UnloadCustomContent()
	endif

	if page == "$LastSeedOverviewPage"
		PageReset_Overview()
	elseif page == "$LastSeedGameplayPage"
		PageReset_Gameplay()
	elseif page == "$LastSeedNeedsPage"
		PageReset_Needs()
	elseif page == "$LastSeedVitalityPage"
		PageReset_Vitality()
	elseif page == "$LastSeedAlcoholDiseasePage"
		PageReset_AlcoholDisease()	
	elseif page == "$LastSeedSpoilagePage"
		PageReset_FoodSpoilage()
	elseif page == "$LastSeedInterfacePage"
		PageReset_Interface()
	elseif page == "$LastSeedMetersPage"
		PageReset_Meters()
	elseif page == "$LastSeedAdvancedPage"
		PageReset_Advanced()
	elseif page == "$LastSeedHelpPage"
		PageReset_Help()
	elseif page == "$LastSeedSaveLoadPage"
		PageReset_SaveLoad()
	elseif page == "$LastFoodListPage"
		ResetPageLists()
	endif
endEvent

event OnOptionHighlight(int option)
	;FOOD LISTS
	if option == FoodLists_ListMenu_OID
		SetInfoText("$LastSeedFoodListHighlight")
	elseif option == FoodLists_ItemMenu_OID
		SetInfoText("$LastSeedFoodOptionHighlight")
	elseif option == FoodLists_Edit_PortionsListMenu_OID
		SetInfoText("$LastSeedFoodListEditPortionsListHighlight")
	elseif option == FoodLists_Edit_PortionsItemMenu_OID
		SetInfoText("$LastSeedFoodListEditPortionsOptionHighlight")
	elseif option == FoodLists_Edit_ListMenu_OID
		SetInfoText("$LastSeedFoodListEditHighlight")
	elseif option == FoodLists_Edit_Preserved_OID
		SetInfoText("$LastSeedFoodListEditPreservedHighlight")
	elseif option == FoodLists_Edit_Portions_OID
		SetInfoText("$LastSeedFoodListEditPortionsHighlight")
	elseif option == FoodLists_Edit_Salted_OID
		SetInfoText("$LastSeedFoodListEditSaltedHighlight")
	elseif option == FoodLists_Edit_RestoreHunger_OID
		SetInfoText("$LastSeedFoodListEditRestoreAmountHighlight")
	elseif option == FoodLists_Edit_Alcohol_OID
		SetInfoText("$LastSeedFoodListEditAlcoholHighlight")
	elseif option == FoodLists_Edit_PortionsCount_OID
		SetInfoText("$LastSeedFoodListEditPortionCountHighlight")
	elseif option == Overview_RunStatusText_OID
		SetInfoText("$LastSeedOptionHighlightRunStatus")
	elseif option == Overview_StartSystem_OID
		SetInfoText("$LastSeedOverviewHighlightEnabled")
	elseif option == Overview_GameplayPreset_OID
		SetInfoText("$LastSeedOptionHighlightGameplayPreset")
	elseif option == Overview_HungerStatusText_OID
		SetInfoText("$LastSeedOptionHighlightAttributeHunger")
	elseif option == Overview_ThirstStatusText_OID
		SetInfoText("$LastSeedOptionHighlightAttributeThirst")
	elseif option == Overview_FatigueStatusText_OID
		SetInfoText("$LastSeedOptionHighlightAttributeFatigue")
	elseif option == Overview_VitalityStatusText_OID
		SetInfoText("$LastSeedOptionHighlightAttributeVitality")
	elseif option == Overview_AlcoholStatusText_OID
		SetInfoText("$LastSeedOptionHighlightAttributeAlcohol")
	elseif option == Overview_SkoomaStatusText_OID
		SetInfoText("$LastSeedOptionHighlightAttributeSkooma")
	elseif option == Gameplay_HungerEnabled_OID
		SetInfoText("$LastSeedOptionHighlightSettingHungerEnabled")
	elseif option == Gameplay_ThirstEnabled_OID
		SetInfoText("$LastSeedOptionHighlightSettingThirstEnabled")	
	elseif option == Gameplay_MovementPenalty_OID
		SetInfoText("$LastSeedOptionHighlightSettingMovementText")
	elseif option == Gameplay_FoodNames_OID
		SetInfoText("$LastSeedOptionHighlightSettingFoodNames")
	elseif option == Gameplay_Cannibalism_OID
		SetInfoText("$LastSeedOptionHighlightSettingCannibalism")
	elseif option == Gameplay_InnDialogWater_OID
		SetInfoText("$LastSeedOptionHighlightSetting_InnDialogWater")
	elseif option == Gameplay_InnDialogMeals_OID
		SetInfoText("$LastSeedOptionHighlightSetting_InnDialogMeals")
	elseif option == Gameplay_EnableWaterBottles_OID
		SetInfoText("$LastSeedOptionHighlightEnableWaterBottles")
	elseif option == Gameplay_EnableDungeonFocus_OID
		SetInfoText("$LastSeedOptionHighlightDungeonFocus")
	elseif option == Gameplay_DiminishingFoodReturns_OID
		SetInfoText("$LastSeedGameplayHighlightSettingDiminishingFoodReturn")
	elseif option == Gameplay_AutoConsume_OID
		SetInfoText("$LastSeedGameplayHighlightSettingAutoConsume")
	elseif option == Gameplay_NeedsAffectedByRegeneration_OID
		SetInfoText("$LastSeedGameplayHighlightSettingNeedsRegen")
	elseif option == Gameplay_ProvisionsAddPortions_OID
		; IcZ: 5.3 showed the option's own label here; the translation files carried the help text
		; under the label key as a second definition. Split into its own key 2026-09-13.
		SetInfoText("$LastSeedGameplayHighlightSettingProvisionsAddPortions")
	elseif option == Gameplay_FoodWeightMulti_OID
		SetInfoText("$LastSeedOptionHighlightSettingFoodWeightMulti")
	elseif option == Gameplay_FoodPriceMulti_OID
		SetInfoText("$LastSeedOptionHighlightSettingFoodPriceMulti")
	elseif option == Gameplay_FatigueEnabled_OID
		SetInfoText("$LastSeedOptionHighlightSettingFatigueEnabled")
	elseif option == Gameplay_VitalityEnabled_OID
		SetInfoText("$LastSeedOptionHighlightSettingVitalityEnabled")
	elseif option == Gameplay_HungerRate_OID
		SetInfoText("$LastSeedOptionHighlightSettingHungerRateSlider")
	elseif option == Gameplay_ThirstRate_OID
		SetInfoText("$LastSeedOptionHighlightSettingThirstRateSlider")
	elseif option == Gameplay_FatigueRate_OID
		SetInfoText("$LastSeedOptionHighlightSettingFatigueRateSlider")	
	elseif option == Gameplay_AlcoholRate_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholRateSlider")
	elseif option == Gameplay_SkoomaRate_OID
		SetInfoText("$LastSeedOptionHighlightSettingSkoomaRateSlider")		
	elseif option == Gameplay_SleepAffectedByNeeds_OID
		SetInfoText("$LastSeedOptionHighlightSettingSleepAffectedByNeeds")
	elseif option == Gameplay_SleepAffectedByLocation_OID
		SetInfoText("$LastSeedOptionHighlightSettingSleepAffectedByLocation")	
	elseif option == Gameplay_VitalityRate_OID
		SetInfoText("$LastSeedOptionHighlightSettingVitalityRateSlider")
		
	elseif option == Gameplay_VitalityHungerMulti_OID
		SetInfoText("$LastSeedOptionHighlightSettingVitalityHungerMultiSlider")
	elseif option == Gameplay_VitalityThirstMulti_OID
		SetInfoText("$LastSeedOptionHighlightSettingVitalityThirstMultiSlider")
	elseif option == Gameplay_VitalityFatigueMulti_OID
		SetInfoText("$LastSeedOptionHighlightSettingVitalityFatigueMultiSlider")
	elseif option == Gameplay_VitalityDiseaseMulti_OID
		SetInfoText("$LastSeedOptionHighlightSettingVitalityDiseaseMultiSlider")
	elseif option == Gameplay_VitalityExposureMulti_OID
		SetInfoText("$LastSeedOptionHighlightSettingVitalityExposureMultiSlider")
		
		
	elseif option == Gameplay_NoVitalityMode_OID
		SetInfoText("$LastSeedOptionHighlightSettingNoVitality")
	elseif option == Gameplay_FocusEnabled_OID
		SetInfoText("$LastSeedOptionHighlightSettingFocusText")	
	elseif option == Gameplay_NeedsPauseDialogue_OID
		SetInfoText("$LastSeedOptionHighlightSettingNeedsDialogueText")
	elseif option == Gameplay_VampirismMode_OID
		SetInfoText("$LastSeedOptionHighlightSettingVampirism")	
	elseif option == Gameplay_Followers_OID
		SetInfoText("$LastSeedOptionHighlightSettingFollowerNeedsEnabled_NoIndividual")
	elseif option == Gameplay_FollowerPartyCount_OID 
		SetInfoText("$LastSeedOptionHighlightSettingPartyCount")
	elseif option == Gameplay_FollowersConsumeFood_OID 
		SetInfoText("$LastSeedOptionHighlightSettingFollowersConsumeFood")
	elseif option == Gameplay_SeranaDrinksBlood_OID 
		SetInfoText("$LastSeedOptionHighlightSeranaDrinksBlood")
	elseif option == Advanced_PlayerIsLich_OID 
		SetInfoText("$LastSeedOptionHighlightSettingPlayerIsLich")
	elseif option == Advanced_AlternativeDeathSystem_OID 
		SetInfoText("$LastSeedOptionHighlightSettingAlternativeDeath")
	elseif option == Advanced_RefreshSystemsOnLoad_OID 
		SetInfoText("$LastSeedOptionHighlightSettingRefreshOnLoad")
	elseif option == Gameplay_PortioningEnable_OID
		SetInfoText("$LastSeedOptionHighlightSettingPortioningEnabled")		
	;ALCOHOL & SKOOMA
	elseif option == Alcohol_Enabled_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholEnabled")
	elseif option == Skooma_Enabled_OID
		SetInfoText("$LastSeedOptionHighlightSettingSkoomaEnabled")
	elseif option == Alcohol_Stumbling_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholStumbling")
	elseif option == Alcohol_RateAle_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholAlcoholRateAle")	
	elseif option == Alcohol_RateWine_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholAlcoholRateWine")
	elseif option == Alcohol_RateSpirits_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholAlcoholRateSpirits")
	elseif option == Alcohol_RateSkoomaWeak_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholAlcoholRateSkoomaWeak")
	elseif option == Alcohol_RateSkoomaStrong_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholAlcoholRateSkoomaStrong")
	elseif option == Alcohol_Shenanigans_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholAlcoholShenanigans")
	;DISEASE
	elseif option == Disease_Enabled_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholDiseaseEnabled")
	elseif option == Disease_Additional_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholDiseaseAdditional")
	elseif option == Disease_Dirty_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholDiseaseDirty")
	elseif option == Disease_ChanceRawFood_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholDiseaseChanceRawFood")
	elseif option == Disease_ChanceStaleFood_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholDiseaseChanceStaleFood")
	elseif option == Disease_ChanceDirtyWater_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholDiseaseChanceDirtyWater")
	elseif option == Disease_PotionsCure_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholDiseasePotionsCure")
	elseif option == Disease_ShrinesCure_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholDiseaseShrinesCure")
	elseif option == Disease_PriestsCure_OID
		SetInfoText("$LastSeedOptionHighlightSettingAlcoholDiseasePriestsCure")
	; SPOILAGE
	elseif option == Gameplay_SpoilageEnable_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageEnabled")
	elseif option == Gameplay_SpoilageRemove_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRemove")
	elseif option == Gameplay_SpoilageTemperature_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageTemperature")	
	elseif option == Spoilage_ContainersEnabled_OID
		SetInfoText("$LastSeedOptionHighlightSettingContainerSpoilageEnabled")
	elseif option == Spoilage_ContainersRate_OID
		SetInfoText("$LastSeedOptionHighlightSettingContainerSpoilageRate")		
	elseif option == Spoilage_Bread_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRateBread")	
	elseif option == Spoilage_MeatRaw_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRateRawMeat")
	elseif option == Spoilage_MeatCooked_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRateCookedMeat")	
	elseif option == Spoilage_SmallGameRaw_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRateRawSmallGame")		
	elseif option == Spoilage_SmallGameCooked_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRateCookedSmallGame")
	elseif option == Spoilage_FishRaw_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRateRawFish")		
	elseif option == Spoilage_FishCooked_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRateCookedFish")		
	elseif option == Spoilage_SeafoodRaw_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRateRawSeafood")		
	elseif option == Spoilage_SeafoodCooked_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRateCookedSeafood")		
	elseif option == Spoilage_Vegetables_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRateVegitables")		
	elseif option == Spoilage_Fruit_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRateFruit")		
	elseif option == Spoilage_Cheese_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRateCheese")		
	elseif option == Spoilage_Treats_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRateTreats")		
	elseif option == Spoilage_Pastries_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRatePastries")		
	elseif option == Spoilage_Stews_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRateStews")		
	elseif option == Spoilage_CheeseBowls_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRateCheeseBowls")	
	elseif option == Spoilage_DrinkMilk_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRateMilk")
	elseif option == Spoilage_IceWraithTeeth_OID
		SetInfoText("$LastSeedOptionHighlightSettingSpoilageRateIceWraithTeeth")	
		
	;PROFILE
	elseif option == SaveLoad_SelectProfile_OID
		SetInfoText("$LastSeedOptionHighlightSettingSelectProfile")
	elseif option == SaveLoad_RenameProfile_OID
		SetInfoText("$LastSeedOptionHighlightSettingRenameProfile")
	elseif option == SaveLoad_DefaultProfile_OID
		SetInfoText("$LastSeedOptionHighlightSettingDefaultProfile")
	elseif option == SaveLoad_Enable_OID
		SetInfoText("$LastSeedOptionHighlightSettingEnableSaveLoad")
	;INTERFACE
	elseif option == Interface_SoundEffects_OID
		SetInfoText("$LastSeedOptionHighlightSoundEffects")
	elseif option == Interface_FullScreenEffects_OID
		SetInfoText("$LastSeedOptionHighlightSettingFullScreenEffectsToggle")
	elseif option == Interface_ForceFeedback_OID
		SetInfoText("$LastSeedOptionHighlightForceFeedback")
	elseif option == Interface_ConditionMessages_OID
		SetInfoText("$LastSeedOptionHighlightSettingConditionMsgToggle")
	elseif option == Interface_ConditionMessagesFollowers_OID
		SetInfoText("$LastSeedOptionHighlightSettingConditionMsgFollowersToggle")
	elseif option == Interface_FocusNotificatons_OID
		SetInfoText("$LastSeedOptionHighlightSettingConditionMsgFocusToggle")
	elseif option == Interface_FrostfallNotificatons_OID
		SetInfoText("$LastSeedOptionHighlightSettingConditionMsgFrostfallToggle")
	elseif option == Interface_Animation_OID
		SetInfoText("$LastSeedOptionHighlightAnimation")
	elseif option == Interface_AnimationFirstPerson_OID
		SetInfoText("$LastSeedOptionHighlightAnimationFirstPerson")
	elseif option == Interface_FollowerAnimation_OID
		SetInfoText("$LastSeedOptionHighlightFollowerAnimation")
	elseif option == Interface_AnimationPickup_OID
		SetInfoText("$LastSeedOptionHighlightFollowerPickup")
	elseif option == Meters_manualPosition_OID
		SetInfoText("$LastSeedOptionHighlightInterfaceManualMeterConfig")
		
				
	;ADVANCED
	elseif option == Advanced_ProvisioningSkillRespec_OID
		SetInfoText("$LastSeedOptionHighlightSettingRespec")
	elseif option == Advanced_ProvisioningSkillRestore_OID
		SetInfoText("$LastSeedOptionHighlightSettingRestore")
	
	;METERS
	elseif option == Meters_UIMeterDisplay_OID
		SetInfoText("$LastSeedOptionHightlightUIMeterDisplay")
	elseif option == Meters_UIMeterDisplay_Vitality_OID
		SetInfoText("$LastSeedOptionHightlightUIMeterDisplay")
	elseif option == Meters_UIMeterLayout_OID
		SetInfoText("$LastSeedMeterLayoutHighlight")
	elseif option == Meters_UIMeterOpacity_OID
		SetInfoText("$LastSeedMeterOpacityHighlight")
	elseif option == Meters_UIMeterOpacity_Vitality_OID
		SetInfoText("$LastSeedMeterOpacityHighlight")
	elseif option == Meters_UIMeterDisplayTime_OID
		SetInfoText("$LastSeedOptionHightlightUIMeterDisplayTime")
	elseif option == Meters_UIMeterDisplayTime_Vitality_OID
		SetInfoText("$LastSeedOptionHightlightUIMeterDisplayTime")
	elseif option == Meters_UIMeterXPos_Hunger_OID || option == Meters_UIMeterXPos_Thirst_OID || option == Meters_UIMeterXPos_Fatigue_OID || option == Meters_UIMeterXPos_Vitality_OID
			SetInfoText("$LastSeedMeterXPosHighlight")
	elseif option == Meters_UIMeterYPos_Hunger_OID || option == Meters_UIMeterYPos_Thirst_OID || option == Meters_UIMeterYPos_Fatigue_OID  || option == Meters_UIMeterYPos_Vitality_OID
		SetInfoText("$LastSeedMeterYPosHighlight") 
	elseif option == Meters_UIMeterHAnchor_Hunger_OID || option == Meters_UIMeterHAnchor_Thirst_OID || option == Meters_UIMeterHAnchor_Fatigue_OID || option == Meters_UIMeterHAnchor_Vitality_OID
		SetInfoText("$LastSeedMeterHAnchorHighlight")
	elseif option == Meters_UIMeterVAnchor_Hunger_OID || option == Meters_UIMeterVAnchor_Thirst_OID || option == Meters_UIMeterVAnchor_Fatigue_OID || option == Meters_UIMeterVAnchor_Vitality_OID
			SetInfoText("$LastSeedMeterVAnchorHighlight")
	elseif option == Meters_UIMeterHeight_OID || option == Meters_UIMeterHeight_Vitality_OID	
		SetInfoText("$LastSeedHighlightInterfaceSettingMeterHeight")
	elseif option == Meters_UIMeterWidth_OID || option == Meters_UIMeterWidth_Vitality_OID
		SetInfoText("$LastSeedHighlightInterfaceSettingMeterWidth")		
	elseif option == Meters_UIMeterScale_OID || option == Meters_UIMeterScaleVitality_OID
		SetInfoText("$LastSeedMeterScaleHighlight")	
	elseif option == Meters_UIMeterFillDirection_OID
		SetInfoText("$LastSeedMeterFillDirectionHighlight")
	elseif option == Meters_UIMeterScale_OID
		SetInfoText("$LastSeedMeterScaleHighlight")
	elseif option == Meters_UIMeterFlipped_OID
		SetInfoText("$LastSeedMeterFlippedHighlight")
	elseif option == Meters_UIMeterColor_OID
		SetInfoText("$LastSeedMeterColorHighlight")
	elseif option == Meters_UIMeterXPos_OID
		SetInfoText("$LastSeedMeterXPosHighlight")
	elseif option == Meters_UIMeterYPos_OID
		SetInfoText("$LastSeedMeterYPosHighlight")
	elseif option == Meters_UIMeterHAnchor_OID
		SetInfoText("$LastSeedMeterHAnchorHighlight")
	elseif option == Meters_UIMeterVAnchor_OID
		SetInfoText("$LastSeedMeterVAnchorHighlight")
	elseif option == Help_SettingEnableTutorials_OID
		SetInfoText("$LastSeedAdvancedHighlightSettingTutorialsShow")
	elseif option == Help_SettingsResetTutorials_OID
		SetInfoText("$LastSeedAdvancedHighlightSettingTutorialsReset")
	elseif option == Advanced_ResetFormLists_OID
		SetInfoText("$LastSeedAdvancedHighlightSettingResetFormlists")
	elseif option == Advanced_PO3WaterDetection_OID
		SetInfoText("$LastSeedAdvancedHighlightSettingPO3WaterDetection")		
	elseif option == Advanced_ForceStartMod_OID
		SetInfoText("$LastSeedAdvancedHighlightSettingForceStart")
	elseif option == Advanced_VampireMonitoring_OID && isSpecialEdition()
		SetInfoText("$LastSeedAdvancedHighlightSettingVampireMonitoringSE")	
	elseif option == Advanced_VampireMonitoring_OID
		SetInfoText("$LastSeedAdvancedHighlightSettingVampireMonitoringLE")	
	elseif option == Advanced_SafeLocation_OID
		SetInfoText("$LastSeedAdvancedHighlightSettingSafeLocation")
	elseif option == Advanced_ProvisionWeightPP_OID
		SetInfoText("$LastSeedAdvancedHighlightSettingProvisionWeight")
	elseif option == Advanced_LogLevel_OID
		SetInfoText("$LastSeedAdvancedHighlightSettingLogLevel")
	elseif option == Gameplay_CheckNeedsHotkey_OID || option == Gameplay_AutoEatHotkey_OID || option == Gameplay_AutoDrinkHotkey_OID || option == Gameplay_ProvisionsHotkey_OID || option == Gameplay_IntensityHotkey_OID || option == Gameplay_ExamineFoodHotkey_OID || option == Gameplay_DrinkFromStreamHotkey_OID
		SetInfoText("$LastSeedOptionHighlightHK")
	elseif option == FoodLists_AddItem_OID
		SetInfoText("$LastSeedFoodListAddItemHighlight")
	elseif option == FoodLists_ReclassifyItem_OID
		SetInfoText("$LastSeedFoodListReclassifyItemHighlight")
	elseif option == FoodLists_Edit_OID
		SetInfoText("$LastSeedFoodListReclassifyItemHighlight")
	endif
endEvent

event OnOptionSelect(int option)
	;LAST SEED ENABLED
	if option == Overview_RunStatusText_OID
		if LastSeedRunning.GetValueInt() == 2
			bool b = ShowMessage("$LastSeedOverviewShutDownPrompt")
			if b
				must_exit = true
				LastSeedRunning.SetValue(1)
				ForcePageReset()
				;FrostfallMain.RegisterForModEvents()
				;SendEvent_StopFrostfall()
			endif
		else
			bool b = ShowMessage("$LastSeedOverviewStartUpPrompt")
			if b
				must_exit = true
				LastSeedRunning.SetValue(2)
				ForcePageReset()
				;FrostfallMain.RegisterForModEvents()
				;SendEvent_StartFrostfall()
			endif
		endif
	elseif option == Overview_StartSystem_OID
		_Seed_OnOptionSelect(LastSeedStartingUp, Overview_StartSystem_OID, "system_enabled")
	;FOCUS OPTION
	elseif option == Gameplay_FocusEnabled_OID
		_Seed_OnOptionSelect(_Seed_Setting_Focus, Gameplay_FocusEnabled_OID, "focus_enabled")

	;SPOILAGE
	elseif option == Gameplay_SpoilageEnable_OID
		_Seed_OnOptionSelect(_Seed_Setting_SpoilageEnable, Gameplay_SpoilageEnable_OID, "Spoilage_enabled")	
	elseif option == Gameplay_SpoilageTemperature_OID
		_Seed_OnOptionSelect(_Seed_Setting_SpoilageTemperatureMulti, Gameplay_SpoilageTemperature_OID, "Spoilage_temperature")
	elseif option == Spoilage_ContainersEnabled_OID
		_Seed_OnOptionSelect(_Seed_Setting_ContainerSpoilageEnable, Spoilage_ContainersEnabled_OID, "Spoilage_containers_enabled")		
	elseif option == Gameplay_PortioningEnable_OID
		_Seed_OnOptionSelect(_Seed_Setting_FoodPortioning, Gameplay_PortioningEnable_OID, "FoodPortioning_enabled")	
	;ENABLE VITALITY
	elseif option == Gameplay_VitalityEnabled_OID
		_Seed_OnOptionSelect(_Seed_Setting_SystemEnabled_Vitality, Gameplay_VitalityEnabled_OID, "vitality_enabled")
	;ENABLE HUNGER
	elseif option == Gameplay_HungerEnabled_OID
		_Seed_OnOptionSelect(_Seed_Setting_SystemEnabled_Hunger, Gameplay_HungerEnabled_OID, "hunger_enabled")
	; ENABLE THIRST
	elseif option == Gameplay_ThirstEnabled_OID
		_Seed_OnOptionSelect(_Seed_Setting_SystemEnabled_Thirst, Gameplay_ThirstEnabled_OID, "thirst_enabled")
	elseif option == Gameplay_MovementPenalty_OID
		_Seed_OnOptionSelect(_Seed_Setting_ThirstAffectsMovement, Gameplay_MovementPenalty_OID, "thirst_affects_movement")	

	elseif option == Gameplay_Cannibalism_OID
		_Seed_OnOptionSelect(_Seed_Setting_CannibalismEnabled, Gameplay_Cannibalism_OID, "Cannibalism")	
	
	elseif option == Gameplay_InnDialogWater_OID
		_Seed_OnOptionSelect(_Seed_Settings_InnDialogWater, Gameplay_InnDialogWater_OID, "InnDialogWater")	
	elseif option == Gameplay_InnDialogMeals_OID
		_Seed_OnOptionSelect(_Seed_Settings_InnDialogMeals, Gameplay_InnDialogMeals_OID, "InnDialogMeals")	
	
	elseif option == Gameplay_EnableWaterBottles_OID
		_Seed_OnOptionSelect(_Seed_Settings_EnableWaterBottles, Gameplay_EnableWaterBottles_OID, "EnableWaterBottles")
	elseif option == Gameplay_EnableDungeonFocus_OID
		_Seed_OnOptionSelect(_Seed_Settings_FocusInDungeons, Gameplay_EnableDungeonFocus_OID, "DungeonFocus")				
	; DIMINISHING RETURNS
	elseif option == Gameplay_DiminishingFoodReturns_OID
		_Seed_OnOptionSelect(_Seed_Setting_DiminishingFoodReturns, Gameplay_DiminishingFoodReturns_OID, "diminishing_returns")
	; AUTO-EATING
	elseif option == Gameplay_AutoConsume_OID
		_Seed_OnOptionSelect(_Seed_Setting_AutoConsume, Gameplay_AutoConsume_OID, "auto_consume")
	; NEEDS AFFECTED BY REGENERATION
	elseif option == Gameplay_NeedsAffectedByRegeneration_OID
		_Seed_OnOptionSelect(_Seed_Setting_NeedsAffectedByRegeneration, Gameplay_NeedsAffectedByRegeneration_OID, "regeneration")
	; ADD PORTIONS TO PROVISIONS CONTAINER
	elseif option == Gameplay_ProvisionsAddPortions_OID
		; IcZ: 5.3 saved this under "auto_consume", overwriting the Auto-Eat setting in the profile.
		; Its own key is "portions_to_provisions" (CleanProfile still removes it, as 5.3 intends).
		_Seed_OnOptionSelect(_Seed_ProvisionsAddPortions, Gameplay_ProvisionsAddPortions_OID, "portions_to_provisions")			
	; ENABLE FATIGUE
	elseif option == Gameplay_FatigueEnabled_OID
		_Seed_OnOptionSelect(_Seed_Setting_SystemEnabled_Fatigue, Gameplay_FatigueEnabled_OID, "fatigue_enabled")	
	; SLEEP AFFECTED BY NEEDS AND LOCATION	
	elseif option == Gameplay_SleepAffectedByNeeds_OID
		_Seed_OnOptionSelect(_Seed_Setting_SleepAffectedByNeeds, Gameplay_SleepAffectedByNeeds_OID, "sleep_needs")	
	elseif option == Gameplay_SleepAffectedByLocation_OID
		_Seed_OnOptionSelect(_Seed_Setting_SleepAffectedByLocation, Gameplay_SleepAffectedByLocation_OID, "sleep_location")	
	; ENABLE ALCOHOL
	elseif option == Alcohol_Enabled_OID
		_Seed_OnOptionSelect(_Seed_Setting_AlcoholSystemEnabled, Alcohol_Enabled_OID, "alcohol_enabled")
	elseif option == Skooma_Enabled_OID
		_Seed_OnOptionSelect(_Seed_Setting_SkoomaSystemEnabled, Skooma_Enabled_OID, "skooma_enabled")
	elseif option == Alcohol_Stumbling_OID
		_Seed_OnOptionSelect(_Seed_Setting_DrunkStumbling, Alcohol_Stumbling_OID, "alcohol_stumbling")
	elseif option == Alcohol_Shenanigans_OID
		_Seed_OnOptionSelect(_Seed_Settings_DrunkenShenanigans, Alcohol_Shenanigans_OID, "drunken_shenanigans")		
	; ENABLE DISEASE
	elseif option == Disease_Enabled_OID
		_Seed_OnOptionSelect(_Seed_Setting_DiseaseType, Disease_Enabled_OID, "disease_enabled")
	elseif option == Disease_Additional_OID
		_Seed_OnOptionSelect(_Seed_SettingAdditionalDiseases, Disease_Additional_OID, "additional_diseases")
	; DIRTY DISEASES
	elseif option == Disease_Dirty_OID
		_Seed_OnOptionSelect(_Seed_Setting_DirtyDiseases, Disease_Dirty_OID, "disease_dirty")
	; POTIONS CURE DISEASES
	;elseif option == Disease_PotionsCure_OID
	;	_Seed_OnOptionSelect(_Seed_Setting_DiseasePotionsCure, Disease_PotionsCure_OID, "disease_potions")
	; SHRINES CURE DISEASES
	elseif option == Disease_ShrinesCure_OID
		_Seed_OnOptionSelect(_Seed_Setting_ShrinesCure, Disease_ShrinesCure_OID, "shrines")
	;PRIESTS CURE DISEASES
	elseif option == Disease_PriestsCure_OID
		_Seed_OnOptionSelect(_Seed_Setting_DiseasePriestsCure, Disease_PriestsCure_OID, "priests")
	; FOLLOWERS EAT FOOD
	elseif option == Gameplay_FollowersConsumeFood_OID
		_Seed_OnOptionSelect(_Seed_Setting_FollowersConsumeFood, Gameplay_FollowersConsumeFood_OID, "followersConsume")
	; SERANA DRINKS BLOOD
	elseif option == Gameplay_SeranaDrinksBlood_OID
		_Seed_OnOptionSelect(_Seed_Setting_SeranaDrinksBlood, Gameplay_SeranaDrinksBlood_OID)			
	; LICH SETTINGS
	elseif option == Advanced_PlayerIsLich_OID
		_Seed_OnOptionSelect(_Seed_SettingPlayerIsLich, Advanced_PlayerIsLich_OID)
	elseif option == Advanced_AlternativeDeathSystem_OID
		_Seed_OnOptionSelect(_Seed_Setting_AlternateDeathSystem, Advanced_AlternativeDeathSystem_OID, "Advanced_AlternativeDeath")
	elseif option == Advanced_RefreshSystemsOnLoad_OID
		_Seed_OnOptionSelect(_Seed_Setting_RefreshSystemsOnLoad, Advanced_RefreshSystemsOnLoad_OID)	
	;INTERFACE
	elseif option == Interface_SoundEffects_OID
		_Seed_OnOptionSelect(_Seed_Setting_NeedsSFX, Interface_SoundEffects_OID, "interface_sfx")
	elseif option == Interface_FullScreenEffects_OID
		_Seed_OnOptionSelect(_Seed_Setting_NeedsVFX, Interface_FullScreenEffects_OID, "interface_vfx")	
	elseif option == Interface_ForceFeedback_OID
		_Seed_OnOptionSelect(_Seed_Setting_NeedsForceFeedback, Interface_ForceFeedback_OID, "interface_feedback")
	elseif option == Interface_ConditionMessages_OID
		_Seed_OnOptionSelect(_Seed_Setting_Notifications, Interface_ConditionMessages_OID, "interface_messages")
	elseif option == Interface_ConditionMessagesFollowers_OID
		_Seed_OnOptionSelect(_Seed_Setting_Notifications_Followers, Interface_ConditionMessagesFollowers_OID, "interface_messages_followers")
	elseif option == Interface_FocusNotificatons_OID
		_Seed_OnOptionSelect(_Seed_Setting_FocusNotifications, Interface_FocusNotificatons_OID, "interface_focusMessages")
	elseif option == Interface_FrostfallNotificatons_OID
		_Seed_OnOptionSelect(_Seed_Setting_FrostfallNotifications, Interface_FrostfallNotificatons_OID, "interface_frostfallMessages")
	elseif option == Interface_Animation_OID
		_Seed_OnOptionSelect(_Seed_Setting_AnimatePlayer, Interface_Animation_OID, "interface_animations_player")
	elseif option == Interface_AnimationFirstPerson_OID
		_Seed_OnOptionSelect(_Seed_Setting_AnimatePlayer_FirstPerson, Interface_AnimationFirstPerson_OID, "interface_animations_first_person")
	elseif option == Interface_FollowerAnimation_OID
		_Seed_OnOptionSelect(_Seed_Setting_AnimateFollowers, Interface_FollowerAnimation_OID, "interface_animations_followers")	
	elseif option == Interface_AnimationPickup_OID
		_Seed_OnOptionSelect(_Seed_Setting_AnimatePickup, Interface_AnimationPickup_OID, "interface_animations_pickup")		
	elseif option == Meters_manualPosition_OID 
		_Seed_OnOptionSelect(_seed_setting_manualMeterConfig, Meters_manualPosition_OID, "manual_meter_config")
		ForcePageReset()
	;ADVANCED
	elseif option == Help_SettingEnableTutorials_OID
		_Seed_OnOptionSelect(_Seed_Setting_DisplayTutorials, Help_SettingEnableTutorials_OID, "help_enableTutorials")
	elseif option == Help_SettingsResetTutorials_OID
		_Seed_OnOptionSelect(_Seed_Setting_ResetTutorials, Help_SettingsResetTutorials_OID)		
	elseif option == Advanced_ResetFormLists_OID
		_Seed_OnOptionSelect(_Seed_Setting_ResetFoodLists, Advanced_ResetFormLists_OID)
	elseif option == Advanced_PO3WaterDetection_OID
		_Seed_OnOptionSelect(_Seed_Setting_PO3WaterDetection, Advanced_PO3WaterDetection_OID, "advanced_PO3_water")
	elseif option == Advanced_ForceStartMod_OID
		_Seed_OnOptionSelect(_Seed_Setting_ForceStartMod, Advanced_ForceStartMod_OID)
	elseif option == Advanced_VampireMonitoring_OID
		_Seed_OnOptionSelect(_Seed_SettingVampireMonitoring, Advanced_VampireMonitoring_OID, "advanced_vampireMonitoring")		
	elseif option == Advanced_SafeLocation_OID
		Location playerLocation = playerRef.GetCurrentLocation()
		if playerLocation != None
			If _Seed_SafeLocations.HasForm(playerLocation)
				_Seed_SafeLocations.RemoveAddedForm(playerLocation)
				SetToggleOptionValue(Advanced_SafeLocation_OID, false)
			Else
				_Seed_SafeLocations.AddForm(playerLocation)
				SetToggleOptionValue(Advanced_SafeLocation_OID, true)
			Endif
		Endif
    elseif option == Advanced_ProvisioningSkillRespec_OID
        bool b = ShowMessage("$LastSeedAdvancedProvisioningSkillRespecConfirm")
        if b
            GetSkillTreeHandler().RefundSkillPoints()
            ShowMessage("$LastSeedAdvancedProvisioningSkillRestoreDone", false)
        endif
    elseif option == Advanced_ProvisioningSkillRestore_OID
        bool b = ShowMessage("$LastSeedAdvancedProvisioningSkillRestoreConfirm")
        if b
            ShowMessage("$LastSeedAdvancedProvisioningSkillRestoreSelect")
            SetToggleOptionValue(Advanced_ProvisioningSkillRestore_OID, true, true)
            SetOptionFlags(Advanced_ProvisioningSkillRestoreSlider_OID, OPTION_FLAG_NONE)
        endif
	;PROFILE
	elseif option == SaveLoad_ProfileHelp_OID
		ShowProfileHelp()
	elseif option == SaveLoad_DefaultProfile_OID
		bool b = ShowMessage("$FrostfallSaveLoadDefaultProfileConfirm")
		if b
			GenerateDefaultProfile(_Seed_Setting_CurrentProfile.GetValueInt())
			SwitchToProfile(_Seed_Setting_CurrentProfile.GetValueInt())
			ForcePageReset()
		endif
	elseif option == SaveLoad_Enable_OID
		if _Seed_Setting_AutoSaveLoad.GetValueInt() == 2
			_Seed_Setting_AutoSaveLoad.SetValueInt(1)
			SetToggleOptionValue(SaveLoad_Enable_OID, false)
			JsonUtil.SetIntValue(CONFIG_PATH + "common", "auto_load", 1)
			JsonUtil.Save(CONFIG_PATH + "common")
		elseif _Seed_Setting_AutoSaveLoad.GetValueInt() == 1
			_Seed_Setting_AutoSaveLoad.SetValueInt(2)
			SetToggleOptionValue(SaveLoad_Enable_OID, true)
			JsonUtil.SetIntValue(CONFIG_PATH + "common", "auto_load", 2)
			JsonUtil.Save(CONFIG_PATH + "common")
			SaveAllSettings(_Seed_Setting_CurrentProfile.GetValueInt())
		endIf
		ForcePageReset()
	;FOOD LIST
	elseif option == FoodLists_AddItem_OID
		_Seed_OnOptionSelect(_Seed_Setting_FoodListAdd, FoodLists_AddItem_OID)
	elseif option == FoodLists_ReclassifyItem_OID
		_Seed_OnOptionSelect(_Seed_Setting_FoodListReclassify, FoodLists_ReclassifyItem_OID)
		
	elseif option == FoodLists_Edit_OID
		if editFoodItem == true
			editFoodItem = false
			_selectedList = _selectedList_edit
			;selectedPortion = GetFoodDataStoreHandler().GetMultiPartFoodResult_Array(selectedForm as potion, false)
			;if selectedPortion
			;	;Add Food Portion Information
			;	if GetFoodDataStoreHandler().isNotFood(selectedPortion)
			;		selectedListPortions = 20
			;	elseif GetFoodDataStoreHandler().isBloodPotion(selectedPortion)
			;		selectedListPortions = 19
			;	else
			;		selectedListPortions = GetFoodType(selectedPortion) - 1
			;	endif	
			;	;selectedItemPortions = _listRef[selectedListPortions].ToArray().Find(selectedPortion)
			;endif
		else
			editFoodItem = true
		endif
		ForcePageReset()
	elseif option == FoodLists_Edit_Preserved_OID
		if IsFoodPreserved(selectedForm as potion)
			SetFoodPreserved(selectedForm as potion, false)
			SetFoodSalted(selectedForm as potion, false)
		else
			SetFoodPreserved(selectedForm as potion)
		endif
		ForcePageReset()
	elseif option == FoodLists_Edit_Salted_OID
		if IsFoodSalted(selectedForm as potion)
			SetFoodSalted(selectedForm as potion, false)
		else
			SetFoodSalted(selectedForm as potion)
		endif
		ForcePageReset()
	elseif option == FoodLists_Edit_Portions_OID
		potion theFood = selectedForm as potion
		if theFood
			if 	GetFoodDataStoreHandler().GetMultiPartFoodResult_Array(theFood, false)
				GetFoodDataStoreHandler().RemoveMultiPartFood_Array(theFood)
			else
				GetFoodDataStoreHandler().AddMultiPartFood_Array(theFood, _Seed_WaterBottleEmpty, 1)
				selectedListPortions = 20
				selectedPortion = _Seed_WaterBottleEmpty
				;selectedItemPortions = _listRef[selectedListPortions].ToArray().Find(_Seed_WaterBottleEmpty)
				
			endif
		endif
		ForcePageReset()
	endif
endEvent

function _Seed_OnOptionSelect(GlobalVariable akSettingsGlobal, int aiOID, string asProfileSetting = "")
	if akSettingsGlobal.GetValueInt() == 2
		akSettingsGlobal.SetValueInt(1)
		SetToggleOptionValue(aiOID, false)
	else
		akSettingsGlobal.SetValueInt(2)
		SetToggleOptionValue(aiOID, true)
	endif
	if asProfileSetting != ""
		SaveSettingToCurrentProfile(asProfileSetting, akSettingsGlobal.GetValueInt())
	endif
endFunction





event OnOptionDefault(int option)
	if option == Gameplay_CheckNeedsHotkey_OID
		UnregisterForKey(_Seed_HotkeyCheckNeeds.GetValueInt())
		_Seed_HotkeyCheckNeeds.SetValue(0)
		ForcePageReset()
		PlayerRef.AddSpell(_Seed_CheckNeedsSpell, false)
		SaveSettingToCurrentProfile("hotkey_checkNeeds", 0)
	elseif option == Gameplay_AutoEatHotkey_OID
		UnregisterForKey(_Seed_HotkeyAutoEat.GetValueInt())
		_Seed_HotkeyAutoEat.SetValue(0)
		ForcePageReset()
		PlayerRef.AddSpell(_Seed_AutoEat, false)
		SaveSettingToCurrentProfile("hotkey_AutoEat", 0)
	elseif option == Gameplay_AutoDrinkHotkey_OID
		UnregisterForKey(_Seed_HotkeyAutoDrink.GetValueInt())
		_Seed_HotkeyAutoDrink.SetValue(0)
		ForcePageReset()
		PlayerRef.AddSpell(_Seed_AutoDrink, false)
		SaveSettingToCurrentProfile("hotkey_AutoDrink", 0)
	elseif option == Gameplay_ProvisionsHotkey_OID
		UnregisterForKey(_Seed_HotkeyProvisions.GetValueInt())
		_Seed_HotkeyProvisions.SetValue(0)
		ForcePageReset()
		PlayerRef.AddSpell(_Seed_ProvisionsSpell, false)
		SaveSettingToCurrentProfile("hotkey_Provisions", 0)
	elseif option == Gameplay_IntensityHotkey_OID
		UnregisterForKey(_Seed_HotkeyIntensity.GetValueInt())
		_Seed_HotkeyIntensity.SetValue(0)
		ForcePageReset()
		if Provisioning_PerkRank_UnboundIntensity.getValue() > 0
			PlayerRef.AddSpell(_Seed_IntensityPlayerSpell, false)
		Endif	
		SaveSettingToCurrentProfile("hotkey_Intensity", 0)
	elseif option == Gameplay_ExamineFoodHotkey_OID
		UnregisterForKey(_Seed_HotkeyExamineFood.GetValueInt())
		_Seed_HotkeyExamineFood.SetValue(0)
		ForcePageReset()
		PlayerRef.AddSpell(_Seed_ExamineFood, false)
		SaveSettingToCurrentProfile("hotkey_ExamineFood", 0)
	elseif option == Gameplay_DrinkFromStreamHotkey_OID
		UnregisterForKey(_Seed_HotkeyDrinkFromStream.GetValueInt())
		_Seed_HotkeyDrinkFromStream.SetValue(0)
		ForcePageReset()
		PlayerRef.AddSpell(_Seed_DrinkFromStreamSpell, false)
		SaveSettingToCurrentProfile("hotkey_DrinkFromStream", 0)
	endif
endEvent

event OnOptionMenuOpen(int option)
	;FOOD LIST MENU
	if option == FoodLists_ListMenu_OID
		SetMenuDialogStartIndex(_selectedList)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(_listMenu)
	elseif option == FoodLists_ItemMenu_OID
		SetMenuDialogStartIndex(_selectedItem)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(_listRefNames)
	elseif option == FoodLists_Edit_PortionsListMenu_OID
		SetMenuDialogStartIndex(selectedListPortions)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(_listMenu)
	elseif option == FoodLists_Edit_PortionsItemMenu_OID
		SetMenuDialogStartIndex(selectedListPortions)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(_listRefNamesPortions)			
	elseif option == FoodLists_Edit_ListMenu_OID
		SetMenuDialogStartIndex(_selectedList_edit)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(_listMenu)
	elseif option == FoodLists_Edit_RestoreHunger_OID
		SetMenuDialogStartIndex(restoreIndex)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(_HungerMenu)
	elseif option == FoodLists_Edit_Alcohol_OID
		SetMenuDialogStartIndex(alcoholIndex)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(_alcoholMenu)
    ;ZERO VITALITY
    elseif option == Gameplay_NoVitalityMode_OID
        SetMenuDialogOptions(NoVitalityList)
        SetMenuDialogStartIndex(_Seed_Setting_NoVitalityMode.GetValueInt() - 1)
        SetMenuDialogDefaultIndex(0)		
	;ENABLE FOLLOWERS
    elseif option == Gameplay_Followers_OID
        SetMenuDialogOptions(followerModeList)
        SetMenuDialogStartIndex(_Seed_Setting_SystemEnabled_FollowerNeeds.GetValueInt() - 1)
        SetMenuDialogDefaultIndex(1)	
	elseif option == Gameplay_FollowerPartyCount_OID 
        SetMenuDialogOptions(followerCountList)
        SetMenuDialogStartIndex(_Seed_Setting_PartyCount.GetValueInt())
        SetMenuDialogDefaultIndex(0)
	;GAMEPLAY
	elseif option == Disease_PotionsCure_OID
		SetMenuDialogOptions(DiseasePotionModeList)
		SetMenuDialogStartIndex(_Seed_Setting_DiseasePotionsCure.GetValueInt() - 1)
		SetMenuDialogDefaultIndex(1)
	;VAMPIRISM MODE
	elseif option == Gameplay_VampirismMode_OID
		SetMenuDialogOptions(VampirismModeList)
		SetMenuDialogStartIndex(_Seed_Setting_VampireBehavior.GetValueInt() - 1)
		SetMenuDialogDefaultIndex(1)
	;DESCRIPTIVE FOOD NAMES
	elseif option == Gameplay_FoodNames_OID
		SetMenuDialogOptions(FoodNamesList)
		SetMenuDialogStartIndex(_Seed_Setting_AddNames.GetValueInt() - 1)
		SetMenuDialogDefaultIndex(1)
	; SPOILAGE
	elseif option == Gameplay_SpoilageRemove_OID
		SetMenuDialogOptions(SpoilageRemoveModeList)
		SetMenuDialogStartIndex(_Seed_Setting_SpoilageRemove.GetValueInt() - 1)
		SetMenuDialogDefaultIndex(1)
	;PRESETS
	elseif option == Overview_GameplayPreset_OID
		SetMenuDialogOptions(PresetsGameplay)
		SetMenuDialogStartIndex(_Seed_Setting_Presets_Gameplay.GetValueInt() - 1)
		SetMenuDialogDefaultIndex(1)
	;LOG LEVEL
	elseif option == Advanced_LogLevel_OID
		SetMenuDialogOptions(LogLevel)
		SetMenuDialogStartIndex(_Seed_Setting_LogLevel.GetValueInt() + 1)
		SetMenuDialogDefaultIndex(1)
	; METER DISPLAY MODE
	elseif option == Meters_UIMeterDisplay_OID
		SetMenuDialogOptions(MeterModeList)
		SetMenuDialogStartIndex(getMeterModeInt(_Seed_Setting_HungerMeterDisplayMode))
		SetMenuDialogDefaultIndex(1)
	; VITALITY METER DISPLAY MODE
	elseif option == Meters_UIMeterDisplay_Vitality_OID
		SetMenuDialogOptions(MeterModeList)
		SetMenuDialogStartIndex(getMeterModeInt(_Seed_Setting_VitalityMeterDisplayMode))
		SetMenuDialogDefaultIndex(1)
	;METER ANCHOR POSITIONS
	elseif option == Meters_UIMeterHAnchor_Hunger_OID
			SetMenuDialogOptions(HorizontalAnchorList)
			SetMenuDialogStartIndex(_Seed_Setting_MeterHungerHAnchor.GetValueInt())			
	elseif option == Meters_UIMeterVAnchor_Hunger_OID
			SetMenuDialogOptions(VerticalAnchorList)
			SetMenuDialogStartIndex(_Seed_Setting_MeterHungerVAnchor.GetValueInt())		
	elseif option == Meters_UIMeterHAnchor_Thirst_OID
			SetMenuDialogOptions(HorizontalAnchorList)
			SetMenuDialogStartIndex(_Seed_Setting_MeterThirstHAnchor.GetValueInt())			
	elseif option == Meters_UIMeterVAnchor_Thirst_OID
			SetMenuDialogOptions(VerticalAnchorList)
			SetMenuDialogStartIndex(_Seed_Setting_MeterThirstVAnchor.GetValueInt())		
	elseif option == Meters_UIMeterHAnchor_Fatigue_OID
			SetMenuDialogOptions(HorizontalAnchorList)
			SetMenuDialogStartIndex(_Seed_Setting_MeterFatigueHAnchor.GetValueInt())
	elseif option == Meters_UIMeterVAnchor_Fatigue_OID
			SetMenuDialogOptions(VerticalAnchorList)
			SetMenuDialogStartIndex(_Seed_Setting_MeterFatigueVAnchor.GetValueInt())
	elseif option == Meters_UIMeterHAnchor_Vitality_OID
			SetMenuDialogOptions(HorizontalAnchorList)
			SetMenuDialogStartIndex(_Seed_Setting_MeterVitalityHAnchor.GetValueInt())
	elseif option == Meters_UIMeterVAnchor_Vitality_OID
			SetMenuDialogOptions(VerticalAnchorList)
			SetMenuDialogStartIndex(_Seed_Setting_MeterVitalityVAnchor.GetValueInt())
	
	; PROFILE SELECT - NOT CURRENTLY USED
	elseif option == SaveLoad_SelectProfile_OID
		string[] profile_list = new string[10]
		int i = 0
		while i < 10
			string pname = GetProfileName(i + 1)
			profile_list[i] = pname
			i += 1
		endWhile
		SetMenuDialogOptions(profile_list)
		SetMenuDialogStartIndex(_Seed_Setting_CurrentProfile.GetValueInt() - 1)
		SetMenuDialogDefaultIndex(0)
	endif
endEvent

event OnOptionMenuAccept(int option, int index)
	;FOOD LIST MENU
	if option == FoodLists_ListMenu_OID
		_selectedList = index
		_selectedList_edit = index
		_selectedItem = 0
		ForcePageReset()
	elseif option == FoodLists_ItemMenu_OID
		_selectedItem = index
		ForcePageReset()
	elseif option == FoodLists_Edit_ListMenu_OID
		potion theFood = selectedForm as potion
		if(theFood)
			_selectedList = 0
			ClearFoodType(theFood)
			_selectedList_edit = index
			if index == 20
				SetAsNotFood(theFood)
			elseif index == 19
				setBloodPotion(theFood)
			else
				SetFoodType(theFood, index + 1)
			endif
		endif
		ForcePageReset()
	elseif option == FoodLists_Edit_PortionsListMenu_OID
		selectedListPortions = index
		potion newPortion = _listRef[selectedListPortions].GetAt(0) as potion
		GetFoodDataStoreHandler().UpdateMultiPartFood_Array(selectedForm as potion, newPortion, portionCount) 
		ForcePageReset()
	elseif option == FoodLists_Edit_PortionsItemMenu_OID
		potion newPortion = _listRef[selectedListPortions].GetAt(index) as potion
		GetFoodDataStoreHandler().UpdateMultiPartFood_Array(selectedForm as potion, newPortion, portionCount) 
		ForcePageReset()
	elseif option == FoodLists_Edit_RestoreHunger_OID
		potion theFoodRestore = selectedForm as potion
		if theFoodRestore
			clearFoodRestoreAmount(theFoodRestore)
			setFoodRestoreAmount(theFoodRestore, index + 1)
		endif
		ForcePageReset()
	elseif option == FoodLists_Edit_Alcohol_OID
		potion theFoodRestore = selectedForm as potion
		if theFoodRestore
			GetFoodDataStoreHandler().SetAlcoholType(SelectedForm as potion, index + 1)
		endif
		ForcePageReset()	
	;NO VITALITY
	elseif option == Gameplay_NoVitalityMode_OID
        SetMenuOptionValue(Gameplay_NoVitalityMode_OID, NoVitalityList[index])
        _Seed_Setting_NoVitalityMode.SetValueInt(index + 1)
        SaveSettingToCurrentProfile("no_vitality_mode", _Seed_Setting_NoVitalityMode.GetValueInt())
	;ENABLE FOLLOWERS
	elseif option == Gameplay_Followers_OID
        SetMenuOptionValue(Gameplay_Followers_OID, followerModeList[index])
        _Seed_Setting_SystemEnabled_FollowerNeeds.SetValueInt(index + 1)
        SaveSettingToCurrentProfile("FollowerNeeds_enabled", _Seed_Setting_SystemEnabled_FollowerNeeds.GetValueInt())
	elseif option == Gameplay_FollowerPartyCount_OID 
        SetMenuOptionValue(Gameplay_FollowerPartyCount_OID , followerCountList[index])
        _Seed_Setting_PartyCount.SetValueInt(index)
        SaveSettingToCurrentProfile("FollowerNeeds_count", _Seed_Setting_PartyCount.GetValueInt())
	;VAMPIRE MODE
	elseif option == Gameplay_VampirismMode_OID
		SetMenuOptionValue(Gameplay_VampirismMode_OID, VampirismModeList[index])
		_Seed_Setting_VampireBehavior.SetValueInt(index + 1)
		SaveSettingToCurrentProfile("vampire_mode", _Seed_Setting_VampireBehavior.GetValueInt())
	;DESCRIPTIVE FOOD NAMES
	elseif option == Gameplay_FoodNames_OID
		SetMenuOptionValue(Gameplay_FoodNames_OID, FoodNamesList[index])
		_Seed_Setting_AddNames.SetValueInt(index + 1)
		SaveSettingToCurrentProfile("food_names", _Seed_Setting_AddNames.GetValueInt())
	; SPOILAGE
	elseif option == Gameplay_SpoilageRemove_OID
		SetMenuOptionValue(Gameplay_SpoilageRemove_OID, SpoilageRemoveModeList[index])
		_Seed_Setting_SpoilageRemove.SetValueInt(index + 1)
		SaveSettingToCurrentProfile("Spoilage_remove", _Seed_Setting_SpoilageRemove.GetValueInt())
	; CURE DISEASE
	elseif option == Disease_PotionsCure_OID
		SetMenuOptionValue(Disease_PotionsCure_OID, DiseasePotionModeList[index])
		_Seed_Setting_DiseasePotionsCure.SetValueInt(index + 1)
		SaveSettingToCurrentProfile("disease_potion_mode", _Seed_Setting_DiseasePotionsCure.GetValueInt())
	;GAMEPLAY PRESET
	elseif option == Overview_GameplayPreset_OID
		SetMenuOptionValue(Overview_GameplayPreset_OID, PresetsGameplay[index])
		_Seed_Setting_Presets_Gameplay.SetValueInt(index + 1)
		SaveSettingToCurrentProfile("gameplayPreset", _Seed_Setting_Presets_Gameplay.GetValueInt())
		GetConfigurationHandler().setPresets(index + 1)
	;LOG LEVEL
	elseif option == Advanced_LogLevel_OID
		SetMenuOptionValue(Advanced_LogLevel_OID, LogLevel[index])
		_Seed_Setting_LogLevel.SetValueInt(index - 1)
		SaveSettingToCurrentProfile("logLevel", _Seed_Setting_LogLevel.GetValueInt())		
	; METER
	elseif option == Meters_UIMeterDisplay_OID
		SetMenuOptionValue(Meters_UIMeterDisplay_OID, MeterModeList[index])
		setNeedsMode(_Seed_Setting_HungerMeterDisplayMode, index)
		SaveSettingToCurrentProfile("meter_mode", getMeterModeInt(_Seed_Setting_HungerMeterDisplayMode))
	; VITALITY METERS
	elseif option == Meters_UIMeterDisplay_Vitality_OID
		SetMenuOptionValue(Meters_UIMeterDisplay_Vitality_OID, MeterModeList[index])
		setNeedsMode(_Seed_Setting_VitalityMeterDisplayMode, index)
		SaveSettingToCurrentProfile("meter_mode_vitality", _Seed_Setting_VitalityMeterDisplayMode.GetValueInt())
	;METER ANCHORS
	elseif option == Meters_UIMeterHAnchor_Hunger_OID
		_Seed_Setting_MeterHungerHAnchor.SetValueInt(index)
		SaveSettingToCurrentProfile("Hunger_H", _Seed_Setting_MeterHungerHAnchor.GetValueInt())
		SetMenuOptionValue(Meters_UIMeterHAnchor_Hunger_OID, HorizontalAnchorList[index])	
	elseif option == Meters_UIMeterVAnchor_Hunger_OID
		_Seed_Setting_MeterHungerVAnchor.SetValueInt(index)
		SaveSettingToCurrentProfile("Hunger_V", _Seed_Setting_MeterHungerVAnchor.GetValueInt())
		SetMenuOptionValue(Meters_UIMeterVAnchor_Hunger_OID, VerticalAnchorList[index])	
	elseif option == Meters_UIMeterHAnchor_Thirst_OID
		_Seed_Setting_MeterThirstHAnchor.SetValueInt(index)
		SaveSettingToCurrentProfile("Thirst_H", _Seed_Setting_MeterThirstHAnchor.GetValueInt())
		SetMenuOptionValue(Meters_UIMeterHAnchor_Thirst_OID, HorizontalAnchorList[index])		
	elseif option == Meters_UIMeterVAnchor_Thirst_OID
		_Seed_Setting_MeterThirstVAnchor.SetValueInt(index)
		SaveSettingToCurrentProfile("Thirst_V", _Seed_Setting_MeterThirstVAnchor.GetValueInt())
		SetMenuOptionValue(Meters_UIMeterVAnchor_Thirst_OID, VerticalAnchorList[index])
	elseif option == Meters_UIMeterHAnchor_Fatigue_OID
		_Seed_Setting_MeterFatigueHAnchor.SetValueInt(index)
		SaveSettingToCurrentProfile("Fatigue_H", _Seed_Setting_MeterFatigueHAnchor.GetValueInt())
		SetMenuOptionValue(Meters_UIMeterHAnchor_Fatigue_OID, HorizontalAnchorList[index])
	elseif option == Meters_UIMeterVAnchor_Fatigue_OID
		_Seed_Setting_MeterFatigueVAnchor.SetValueInt(index)
		SaveSettingToCurrentProfile("Fatigue_V", _Seed_Setting_MeterFatigueVAnchor.GetValueInt())
		SetMenuOptionValue(Meters_UIMeterVAnchor_Fatigue_OID, VerticalAnchorList[index])
	elseif option == Meters_UIMeterHAnchor_Vitality_OID
		_Seed_Setting_MeterVitalityHAnchor.SetValueInt(index)
		SaveSettingToCurrentProfile("Vitality_H", _Seed_Setting_MeterVitalityHAnchor.GetValueInt())
		SetMenuOptionValue(Meters_UIMeterHAnchor_Vitality_OID, HorizontalAnchorList[index])
	elseif option == Meters_UIMeterVAnchor_Vitality_OID
		_Seed_Setting_MeterVitalityVAnchor.SetValueInt(index)
		SaveSettingToCurrentProfile("Vitality_V", _Seed_Setting_MeterVitalityVAnchor.GetValueInt())
		SetMenuOptionValue(Meters_UIMeterVAnchor_Vitality_OID, VerticalAnchorList[index])
		
	;PROFILE - NOT CURRENTLY USED
	elseif option == SaveLoad_SelectProfile_OID
		bool b = ShowMessage("$LastSeedSaveLoadConfirm")
		if b
			SwitchToProfile(index + 1)
		endif
	endif
endEvent

event OnOptionSliderOpen(int option)	
	; PORTION COUNT
	If option == FoodLists_Edit_PortionsCount_OID
			SetSliderDialogStartValue(portionCount)
			SetSliderDialogDefaultValue(1)
			SetSliderDialogRange(1, 20)         
			SetSliderDialogInterval(1)
	; FOOD WEIGHT
	elseIf option == Gameplay_FoodWeightMulti_OID
			SetSliderDialogStartValue(_Seed_Setting_FoodWeightMulti.GetValue())
			SetSliderDialogDefaultValue(1)
			SetSliderDialogRange(0, 5)         
			SetSliderDialogInterval(0.1)
	; FOOD PRICE
	elseIf option == Gameplay_FoodPriceMulti_OID
			SetSliderDialogStartValue(_Seed_Setting_FoodPriceMulti.GetValue())
			SetSliderDialogDefaultValue(1)
			SetSliderDialogRange(0, 5)         
			SetSliderDialogInterval(0.1)
	; VITALITY RATE
	elseIf option == Gameplay_VitalityRate_OID
			SetSliderDialogStartValue(_Seed_Setting_RateMulti_Vitality.GetValue())
			SetSliderDialogDefaultValue(1)
			SetSliderDialogRange(0.1, 5)         
			SetSliderDialogInterval(0.1)
	; VITALITY MULTI HUNGER
	elseIf option == Gameplay_VitalityHungerMulti_OID
			SetSliderDialogStartValue(_Seed_setting_VitalityHungerMulti.GetValue())
			SetSliderDialogDefaultValue(1)
			SetSliderDialogRange(0.1, 3)       
			SetSliderDialogInterval(0.1)
	; VITALITY MULTI THIRST
	elseIf option == Gameplay_VitalityThirstMulti_OID
			SetSliderDialogStartValue(_Seed_setting_VitalityThirstMulti.GetValue())
			SetSliderDialogDefaultValue(1)
			SetSliderDialogRange(0.1, 3)         
			SetSliderDialogInterval(0.1)
	; VITALITY MULTI FATIGUE
	elseIf option == Gameplay_VitalityFatigueMulti_OID
			SetSliderDialogStartValue(_Seed_setting_VitalityFatigueMulti.GetValue())
			SetSliderDialogDefaultValue(1)
			SetSliderDialogRange(0.1, 3)         
			SetSliderDialogInterval(0.1)
	; VITALITY MULTI DISEASE
	elseIf option == Gameplay_VitalityDiseaseMulti_OID
			SetSliderDialogStartValue(_Seed_setting_VitalityDiseaseMulti.GetValue())
			SetSliderDialogDefaultValue(1)
			SetSliderDialogRange(0.1, 3)         
			SetSliderDialogInterval(0.1)
	; VITALITY EXPOSURE DISEASE
	elseIf option == Gameplay_VitalityExposureMulti_OID
			SetSliderDialogStartValue(_Seed_setting_VitalityExposureMulti.GetValue())
			SetSliderDialogDefaultValue(1)
			SetSliderDialogRange(0.1, 3)         
			SetSliderDialogInterval(0.1)
	; HUNGER RATE
	elseIf option == Gameplay_HungerRate_OID
			SetSliderDialogStartValue(_Seed_Setting_RateMulti_Hunger.GetValue())
			SetSliderDialogDefaultValue(1)
			SetSliderDialogRange(0.1, 5)         
			SetSliderDialogInterval(0.1)
	; THIRST RATE
	elseIf option == Gameplay_ThirstRate_OID
			SetSliderDialogStartValue(_Seed_Setting_RateMulti_Thirst.GetValue())
			SetSliderDialogDefaultValue(1)
			SetSliderDialogRange(0.1, 5)         
			SetSliderDialogInterval(0.1)
	; FATIGUE RATE
	elseIf option == Gameplay_FatigueRate_OID
			SetSliderDialogStartValue(_Seed_Setting_RateMulti_Fatigue.GetValue())
			SetSliderDialogDefaultValue(1)
			SetSliderDialogRange(0.1, 5)         
			SetSliderDialogInterval(0.1)
	; ALCOHOL RATE
	elseIf option == Gameplay_AlcoholRate_OID
			SetSliderDialogStartValue(_Seed_Setting_RateMulti_Alcohol.GetValue())
			SetSliderDialogDefaultValue(1)
			SetSliderDialogRange(0.1, 5)         
			SetSliderDialogInterval(0.1)
	; SKOOMA RATE
	elseIf option == Gameplay_SkoomaRate_OID
			SetSliderDialogStartValue(_Seed_Setting_RateMulti_Alcohol.GetValue())
			SetSliderDialogDefaultValue(1)
			SetSliderDialogRange(0.1, 5)         
			SetSliderDialogInterval(0.1)
	; ALCOHOL RATE - ALE
	elseIf option == Alcohol_RateAle_OID
        SetSliderDialogStartValue(_Seed_Setting_AlcoholMulti_Ale.GetValue())
        SetSliderDialogDefaultValue(1)
        SetSliderDialogRange(0.1, 5)         
		SetSliderDialogInterval(0.1)
	; ALCOHOL RATE - WINE
	elseIf option == Alcohol_RateWine_OID
        SetSliderDialogStartValue(_Seed_Setting_AlcoholMulti_Wine.GetValue())
        SetSliderDialogDefaultValue(1)
        SetSliderDialogRange(0.1, 5)         
		SetSliderDialogInterval(0.1)
	; ALCOHOL RATE - SPIRIT
	elseIf option == Alcohol_RateSpirits_OID
        SetSliderDialogStartValue(_Seed_Setting_AlcoholMulti_Spirits.GetValue())
        SetSliderDialogDefaultValue(1)
        SetSliderDialogRange(0.1, 5)
		SetSliderDialogInterval(0.1)
	; SKOOMA RATE - WEAK
	elseIf option == Alcohol_RateSkoomaWeak_OID
        SetSliderDialogStartValue(_Seed_Setting_SkoomaMulti_Weak.GetValue())
        SetSliderDialogDefaultValue(1)
        SetSliderDialogRange(0.1, 5)
		SetSliderDialogInterval(0.1)
	; SKOOMA RATE - STRONG
	elseIf option == Alcohol_RateSkoomaStrong_OID
        SetSliderDialogStartValue(_Seed_Setting_SkoomaMulti_Strong.GetValue())
        SetSliderDialogDefaultValue(1)
        SetSliderDialogRange(0.1, 5)
		SetSliderDialogInterval(0.1)
	; DISEASE CHANCE - RAW FOOD
	elseIf option == Disease_ChanceRawFood_OID
        SetSliderDialogStartValue(_Seed_Setting_DiseaseChanceRawFood.GetValue())
        SetSliderDialogDefaultValue(15)
        SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(5)
	; DISEASE CHANCE - SPOILED FOOD
	elseIf option == Disease_ChanceStaleFood_OID
        SetSliderDialogStartValue(_Seed_Setting_DiseaseChanceStaleFood.GetValue())
        SetSliderDialogDefaultValue(15)
        SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(5)
	; DISEASE CHANCE - DIRTY WATER
	elseIf option == Disease_ChanceDirtyWater_OID
        SetSliderDialogStartValue(_Seed_Setting_DiseaseChanceDirtyWater.GetValue())
        SetSliderDialogDefaultValue(15)
        SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(5)
	; SPOILAGE RATE
	elseIf option == Spoilage_ContainersRate_OID
        SetSliderDialogStartValue(_Seed_Setting_ContainerSpoilageRate.GetValue())
        SetSliderDialogDefaultValue(15)
        SetSliderDialogRange(1, 100)
		SetSliderDialogInterval(5)	
	;FOOD SPOILAGE RATES
	elseIf option == Spoilage_Bread_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate01_Bread.GetValue())
        SetSliderDialogDefaultValue(168)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)	
	elseIf option == Spoilage_MeatRaw_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate02_RawMeat.GetValue())
        SetSliderDialogDefaultValue(24)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)	
	elseIf option == Spoilage_MeatCooked_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate03_CookedMeat.GetValue())
        SetSliderDialogDefaultValue(60)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)	
	elseIf option == Spoilage_SmallGameRaw_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate04_RawSmallGame.GetValue())
        SetSliderDialogDefaultValue(24)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)	
	elseIf option == Spoilage_SmallGameCooked_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate05_CookedSmallGame.GetValue())
        SetSliderDialogDefaultValue(60)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)	
	elseIf option == Spoilage_FishRaw_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate06_RawFish.GetValue())
        SetSliderDialogDefaultValue(24)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)	
	elseIf option == Spoilage_FishCooked_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate07_CookedFish.GetValue())
        SetSliderDialogDefaultValue(60)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)	
	elseIf option == Spoilage_SeafoodRaw_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate08_RawSeafood.GetValue())
        SetSliderDialogDefaultValue(24)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)	
	elseIf option == Spoilage_SeafoodCooked_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate09_CookedSeafood.GetValue())
        SetSliderDialogDefaultValue(60)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)	
	elseIf option == Spoilage_Vegetables_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate10_Vegitables.GetValue())
        SetSliderDialogDefaultValue(120)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)	
	elseIf option == Spoilage_Fruit_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate11_Fruit.GetValue())
        SetSliderDialogDefaultValue(120)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)	
	elseIf option == Spoilage_Cheese_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate12_Cheese.GetValue())
        SetSliderDialogDefaultValue(120)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)	
	elseIf option == Spoilage_Treats_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate13_Treats.GetValue())
        SetSliderDialogDefaultValue(168)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)	
	elseIf option == Spoilage_Pastries_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate14_Pastry.GetValue())
        SetSliderDialogDefaultValue(120)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)	
	elseIf option == Spoilage_Stews_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate15_Stew.GetValue())
        SetSliderDialogDefaultValue(120)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)		
	elseIf option == Spoilage_CheeseBowls_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate16_CheeseBowls.GetValue())
        SetSliderDialogDefaultValue(120)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)	
	elseIf option == Spoilage_DrinkMilk_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate17_Milk.GetValue())
        SetSliderDialogDefaultValue(120)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)
	elseIf option == Spoilage_IceWraithTeeth_OID
        SetSliderDialogStartValue(_Seed_Setting_SpoilRate_IceWraithTeeth.GetValue())
        SetSliderDialogDefaultValue(36)
        SetSliderDialogRange(1, 400)
		SetSliderDialogInterval(1)
				
	;METERS
	elseIf option == Meters_UIMeterDisplayTime_OID
        SetSliderDialogStartValue(_Seed_Setting_HungerMeterDisplayTime.GetValue())
        SetSliderDialogDefaultValue(4)
        SetSliderDialogRange(1, 30)
		SetSliderDialogInterval(1)
	elseIf option == Meters_UIMeterDisplayTime_Vitality_OID
        SetSliderDialogStartValue(_Seed_Setting_VitalityMeterDisplayTime.GetValue())
        SetSliderDialogDefaultValue(4)
        SetSliderDialogRange(1, 30)
		SetSliderDialogInterval(1)
	elseIf option == Meters_UIMeterOpacity_OID
        SetSliderDialogStartValue(_Seed_Setting_MeterHungerOpacity.GetValue())
        SetSliderDialogDefaultValue(100)
        SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseIf option == Meters_UIMeterOpacity_Vitality_OID
        SetSliderDialogStartValue(_Seed_Setting_MeterVitalityOpacity.GetValue())
        SetSliderDialogDefaultValue(100)
        SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseIf option == Advanced_ProvisionWeightPP_OID
        SetSliderDialogStartValue(_Seed_Provisions_WeightPerPerson.GetValue())
        SetSliderDialogDefaultValue(25)
        SetSliderDialogRange(1, 300)
		SetSliderDialogInterval(1)
		
	;Meter Positions
	elseIf option == Meters_UIMeterXPos_Hunger_OID
		SetSliderDialogStartValue(_Seed_Setting_MeterHungerXPos.GetValue())
		SetSliderDialogDefaultValue(HUNGER_METER_TOPLEFT_16_10_X)
		SetSliderDialogRange(0.0, 1280.0)
		SetSliderDialogInterval(0.1)
	elseIf option == Meters_UIMeterYPos_Hunger_OID
		SetSliderDialogStartValue(_Seed_Setting_MeterHungerYPos.GetValue())
		SetSliderDialogDefaultValue(HUNGER_METER_TOPLEFT_16_10_Y)
		SetSliderDialogRange(0.0, 800.0)
		SetSliderDialogInterval(0.1)
	elseIf option == Meters_UIMeterXPos_Thirst_OID
		SetSliderDialogStartValue(_Seed_Setting_MeterThirstXPos.GetValue())
		SetSliderDialogDefaultValue(THIRST_METER_TOPLEFT_16_10_X)
		SetSliderDialogRange(0.0, 1280.0)
		SetSliderDialogInterval(0.1)
	elseIf option == Meters_UIMeterYPos_Thirst_OID
		SetSliderDialogStartValue(_Seed_Setting_MeterThirstYPos.GetValue())
		SetSliderDialogDefaultValue(THIRST_METER_TOPLEFT_16_10_Y)
		SetSliderDialogRange(0.0, 800.0)
		SetSliderDialogInterval(0.1)	
	elseIf option == Meters_UIMeterXPos_Fatigue_OID
		SetSliderDialogStartValue(_Seed_Setting_MeterFatigueXPos.GetValue())
		SetSliderDialogDefaultValue(FATIGUE_METER_TOPLEFT_16_10_X)
		SetSliderDialogRange(0.0, 1280.0)
		SetSliderDialogInterval(0.1)
	elseIf option == Meters_UIMeterYPos_Fatigue_OID
		SetSliderDialogStartValue(_Seed_Setting_MeterFatigueYPos.GetValue())
		SetSliderDialogDefaultValue(FATIGUE_METER_TOPLEFT_16_10_Y)
		SetSliderDialogRange(0.0, 800.0)
		SetSliderDialogInterval(0.1)
	elseIf option == Meters_UIMeterXPos_Vitality_OID
		SetSliderDialogStartValue(_Seed_Setting_MeterVitalityXPos.GetValue())
		SetSliderDialogDefaultValue(VITALITY_METER_TOPLEFT_16_10_X)
		SetSliderDialogRange(0.0, 1280.0)
		SetSliderDialogInterval(0.1)
	elseIf option == Meters_UIMeterYPos_Vitality_OID
		SetSliderDialogStartValue(_Seed_Setting_MeterVitalityYPos.GetValue())
		SetSliderDialogDefaultValue(VITALITY_METER_TOPLEFT_16_10_Y)
		SetSliderDialogRange(0.0, 800.0)
		SetSliderDialogInterval(0.1)
	;METER SIZE
	elseIf option == Meters_UIMeterHeight_OID
		SetSliderDialogStartValue(_Seed_Setting_MeterHungerHeight.GetValue())
		SetSliderDialogDefaultValue(CHARGE_METER_HEIGHT_INV)
		SetSliderDialogRange(-100, 100)
		SetSliderDialogInterval(0.1)
	elseIf option == Meters_UIMeterWidth_OID
		SetSliderDialogStartValue(_Seed_Setting_MeterHungerWidth.GetValue())
		SetSliderDialogDefaultValue(CHARGE_METER_WIDTH)
		SetSliderDialogRange(-450, 450)
		SetSliderDialogInterval(0.1)
	elseIf option == Meters_UIMeterHeight_Vitality_OID
		SetSliderDialogStartValue(_Seed_Setting_MeterVitalityHeight.GetValue())
		SetSliderDialogDefaultValue(NORMAL_METER_HEIGHT)
		SetSliderDialogRange(-100, 100)
		SetSliderDialogInterval(0.1)

	elseIf option == Meters_UIMeterScale_OID
		SetSliderDialogStartValue(_Seed_Setting_MeterScale.GetValue())
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(10, 200)
		SetSliderDialogInterval(1)
	elseIf option == Meters_UIMeterScaleVitality_OID
		SetSliderDialogStartValue(_Seed_Setting_MeterScaleVitality.GetValue())
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(10, 200)
		SetSliderDialogInterval(1)	
	elseIf option == Meters_UIMeterWidth_Vitality_OID
		SetSliderDialogStartValue(_Seed_Setting_MeterVitalityWidth.GetValue())
		SetSliderDialogDefaultValue(NORMAL_METER_WIDTH)
		SetSliderDialogRange(-450, 450)
		SetSliderDialogInterval(0.1)
	; SKILLS
    elseif option == Advanced_ProvisioningSkillRestoreSlider_OID
        SetSliderDialogStartValue(0.0)
        SetSliderDialogDefaultValue(0.0)
        SetSliderDialogRange(0, ProvisioningPerkPointsTotal.GetValue())
        SetSliderDialogInterval(1.0)
	EndIf
endEvent
event OnOptionSliderAccept(int option, float value)
	; PORTION COUNT
	If option == FoodLists_Edit_PortionsCount_OID
		GetFoodDataStoreHandler().UpdateMultiPartFood_Array(selectedForm as potion, selectedPortion, value as int)
		SetSliderOptionValue(option, value, "{1}")
		ForcePageReset()
	; FOOD WEIGHT
	elseIf option == Gameplay_FoodWeightMulti_OID
		_Seed_Setting_FoodWeightMulti.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("FoodWeight", Value as int)
	; FOOD PRICE
	elseIf option == Gameplay_FoodPriceMulti_OID
		_Seed_Setting_FoodPriceMulti.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("FoodPrice", Value as int)
	; VITALITY RATE
	elseIf option == Gameplay_VitalityRate_OID
		_Seed_Setting_RateMulti_Vitality.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("VitalityRate", Value as int)
	; VITALITY MULTI HUNGER
	elseIf option == Gameplay_VitalityHungerMulti_OID
		_Seed_setting_VitalityHungerMulti.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("VitalityMultiHunger", Value as int)
	; VITALITY MULTI THIRST
	elseIf option == Gameplay_VitalityThirstMulti_OID
		_Seed_setting_VitalityThirstMulti.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("VitalityMultiThirst", Value as int)
	; VITALITY MULTI FATIGUE
	elseIf option == Gameplay_VitalityFatigueMulti_OID
		_Seed_setting_VitalityFatigueMulti.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("VitalityMultiFatigue", Value as int)
	; VITALITY MULTI DISEASE
	elseIf option == Gameplay_VitalityDiseaseMulti_OID
		_Seed_setting_VitalityDiseaseMulti.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("VitalityMultiDisease", Value as int)
	; VITALITY MULTI EXPOSURE
	elseIf option == Gameplay_VitalityExposureMulti_OID
		_Seed_setting_VitalityExposureMulti.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("VitalityMultiExposure", Value as int)
	; HUNGER RATE
	elseIf option == Gameplay_HungerRate_OID
		_Seed_Setting_RateMulti_Hunger.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("HungerRate", Value as int)
	; THIRST RATE
	elseIf option == Gameplay_ThirstRate_OID
		_Seed_Setting_RateMulti_Thirst.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("ThirstRate", Value as int)
	; FATIGUE RATE
	elseIf option == Gameplay_FatigueRate_OID
		_Seed_Setting_RateMulti_Fatigue.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("FatigueRate", Value as int)
	;ALCOHOL RATE
	elseIf option == Gameplay_AlcoholRate_OID
		_Seed_Setting_RateMulti_Alcohol.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("AlcoholRate", Value as int)
	;SKOOMA RATE
	elseIf option == Gameplay_SkoomaRate_OID
		_Seed_Setting_RateMulti_Skooma.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("SkoomaRate", Value as int)
	; ALCOHOL RATE - ALE
	elseIf option == Alcohol_RateAle_OID
		_Seed_Setting_AlcoholMulti_Ale.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("Alcohol_RateAle", Value as int)
	; ALCOHOL RATE - WINE
	elseIf option == Alcohol_RateWine_OID
		_Seed_Setting_AlcoholMulti_Wine.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("Alcohol_RateWine", Value as int)
	; ALCOHOL RATE - SPIRITS
	elseIf option == Alcohol_RateSpirits_OID
		_Seed_Setting_AlcoholMulti_Spirits.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("Alcohol_RateSpirits", Value as int)
	; SKOOMA RATE - WEAK
	elseIf option == Alcohol_RateSkoomaWeak_OID
		_Seed_Setting_SkoomaMulti_Weak.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("Skooma_RateWeak", Value as int)
	; SKOOMA RATE - STRONG
	elseIf option == Alcohol_RateSkoomaStrong_OID
		_Seed_Setting_SkoomaMulti_Strong.SetValue(Value)
		SetSliderOptionValue(option, value, "{1}")
		SaveSettingToCurrentProfile("Skooma_RateStrong", Value as int)
	; DISEASE RATE - RAW FOOD
	elseIf option == Disease_ChanceRawFood_OID
		_Seed_Setting_DiseaseChanceRawFood.SetValue(Value)
		SaveSettingToCurrentProfile("Disease_ChanceRawFood", Value as int)
		SetSliderOptionValue(option, value, "{0}")
	; DISEASE RATE - SPOILED FOOD
	elseIf option == Disease_ChanceStaleFood_OID
		_Seed_Setting_DiseaseChanceStaleFood.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Disease_ChanceStaleFood", Value as int)
	; DISEASE RATE - DIRTY WATER
	elseIf option == Disease_ChanceDirtyWater_OID
		_Seed_Setting_DiseaseChanceDirtyWater.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Disease_ChanceDirtyWater", Value as int)
	; CONTAINER SPOILAGE RATE
	elseIf option == Spoilage_ContainersRate_OID
		_Seed_Setting_ContainerSpoilageRate.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")	
		SaveSettingToCurrentProfile("Spoilage_ContainersRate", Value as int)
	;FOOD SPOILAGE RATES
	elseIf option == Spoilage_Bread_OID
		_Seed_Setting_SpoilRate01_Bread.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_Bread", Value as int)
	elseIf option == Spoilage_MeatRaw_OID
 		_Seed_Setting_SpoilRate02_RawMeat.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_MeatRaw", Value as int)
	elseIf option == Spoilage_MeatCooked_OID
		_Seed_Setting_SpoilRate03_CookedMeat.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_MeatCooked", Value as int)
	elseIf option == Spoilage_SmallGameRaw_OID
		_Seed_Setting_SpoilRate04_RawSmallGame.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_SmallGameRaw", Value as int)
	elseIf option == Spoilage_SmallGameCooked_OID
		_Seed_Setting_SpoilRate05_CookedSmallGame.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_SmallGameCooked", Value as int)
	elseIf option == Spoilage_FishRaw_OID
		_Seed_Setting_SpoilRate06_RawFish.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_FishRaw", Value as int)
	elseIf option == Spoilage_FishCooked_OID
		_Seed_Setting_SpoilRate07_CookedFish.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_FishCooked", Value as int)
	elseIf option == Spoilage_SeafoodRaw_OID
		_Seed_Setting_SpoilRate08_RawSeafood.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_SeafoodRaw", Value as int)
	elseIf option == Spoilage_SeafoodCooked_OID
		_Seed_Setting_SpoilRate09_CookedSeafood.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_SeafoodCooked", Value as int)
	elseIf option == Spoilage_Vegetables_OID
		_Seed_Setting_SpoilRate10_Vegitables.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_Vegetables", Value as int)
	elseIf option == Spoilage_Fruit_OID
		_Seed_Setting_SpoilRate11_Fruit.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_Fruit", Value as int)
	elseIf option == Spoilage_Cheese_OID
		_Seed_Setting_SpoilRate12_Cheese.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_Cheese", Value as int)
	elseIf option == Spoilage_Treats_OID
		_Seed_Setting_SpoilRate13_Treats.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_Treats", Value as int)
	elseIf option == Spoilage_Pastries_OID
		_Seed_Setting_SpoilRate14_Pastry.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_Pastries", Value as int)
	elseIf option == Spoilage_Stews_OID
		_Seed_Setting_SpoilRate15_Stew.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_Stews", Value as int)
	elseIf option == Spoilage_CheeseBowls_OID
		_Seed_Setting_SpoilRate16_CheeseBowls.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_CheeseBowls", Value as int)
	elseIf option == Spoilage_DrinkMilk_OID
		_Seed_Setting_SpoilRate17_Milk.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_DrinkMilk", Value as int)
	elseIf option == Spoilage_IceWraithTeeth_OID
		_Seed_Setting_SpoilRate_IceWraithTeeth.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Spoilage_IceWraithTeeth", Value as int)		
	elseIf option == Meters_UIMeterDisplayTime_OID
		_Seed_Setting_HungerMeterDisplayTime.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meters_UIMeterDisplayTime", Value as int)
	elseIf option == Meters_UIMeterDisplayTime_Vitality_OID
		_Seed_Setting_VitalityMeterDisplayTime.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meters_UIMeterDisplayTime_Vitality", Value as int)
	elseIf option == Meters_UIMeterOpacity_OID
		_Seed_Setting_MeterHungerOpacity.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meters_UIMeterOpacity", Value as int)
	elseIf option == Meters_UIMeterOpacity_Vitality_OID
		_Seed_Setting_MeterVitalityOpacity.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meters_UIMeterOpacity_Vitality", Value as int)
	elseIf option == Advanced_ProvisionWeightPP_OID
		_Seed_Provisions_WeightPerPerson.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Advanced_ProvisionsWeight", Value as int)
		
	; Meter Positions
	elseIf option == Meters_UIMeterXPos_Hunger_OID
		_Seed_Setting_MeterHungerXPos.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meter_HungerX", Value as int)	
	elseIf option == Meters_UIMeterYPos_Hunger_OID
		_Seed_Setting_MeterHungerYPos.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meter_HungerY", Value as int)	
	elseIf option == Meters_UIMeterXPos_Thirst_OID
		_Seed_Setting_MeterThirstXPos.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meter_ThirstX", Value as int)	
	elseIf option == Meters_UIMeterYPos_Thirst_OID
		_Seed_Setting_MeterThirstYPos.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meter_ThirstY", Value as int)	
	elseIf option == Meters_UIMeterXPos_Fatigue_OID
		_Seed_Setting_MeterFatigueXPos.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meter_FatigueX", Value as int)				
	elseIf option == Meters_UIMeterYPos_Fatigue_OID
		_Seed_Setting_MeterFatigueYPos.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meter_FatigueY", Value as int)			
	elseIf option == Meters_UIMeterXPos_Vitality_OID
		_Seed_Setting_MeterVitalityXPos.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meter_VitalityX", Value as int)
	elseIf option == Meters_UIMeterYPos_Vitality_OID
		_Seed_Setting_MeterVitalityYPos.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meter_VitalityY", Value as int)
	; METER SIZE
	elseIf option == Meters_UIMeterScale_OID
		_Seed_Setting_MeterScale.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meter_Scale", Value as int)	
	elseIf option == Meters_UIMeterScaleVitality_OID
		_Seed_Setting_MeterScaleVitality.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meter_Scale_Vitality", Value as int)	
	
	
	elseIf option == Meters_UIMeterWidth_OID
		_Seed_Setting_MeterHungerWidth.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meter_Width", Value as int)	
	elseIf option == Meters_UIMeterHeight_OID
		_Seed_Setting_MeterHungerHeight.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meter_Height", Value as int)	
	elseIf option == Meters_UIMeterWidth_Vitality_OID
		_Seed_Setting_MeterVitalityWidth.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meter_WidthVitality", Value as int)	
	elseIf option == Meters_UIMeterHeight_Vitality_OID
		_Seed_Setting_MeterVitalityHeight.SetValue(Value)
		SetSliderOptionValue(option, value, "{0}")
		SaveSettingToCurrentProfile("Meter_HeightVitality", Value as int)	
	; Skills
    elseif option == Advanced_ProvisioningSkillRestoreSlider_OID
		getSkillTreeHandler().restorePerkPoints(value as int)
        ShowMessage("$LastSeedAdvancedProvisioningSkillRestoreDone", false)
        SetOptionFlags(Advanced_ProvisioningSkillRestoreSlider_OID, OPTION_FLAG_DISABLED, true)
        SetToggleOptionValue(Advanced_ProvisioningSkillRestore_OID, false)
    endif	
endEvent

event OnOptionInputOpen(int option)
	if option == SaveLoad_RenameProfile_OID
		SetInputDialogStartText(GetProfileName(_Seed_Setting_CurrentProfile.GetValueInt()))
	endif
endEvent

event OnOptionInputAccept(int option, string str)
	if option == SaveLoad_RenameProfile_OID
		if str != ""
			string profile_path = CONFIG_PATH + "profile" + _Seed_Setting_CurrentProfile.GetValueInt()
			JsonUtil.SetStringValue(profile_path, "profile_name", str)
			JsonUtil.Save(profile_path)
			ForcePageReset()
		else
			ShowMessage("$LastSeedSaveLoadRenameErrorBlank", false)
		endif
	endif
endEvent

Event OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
	bool success
	if option == Gameplay_CheckNeedsHotkey_OID
		success = RemapHotkey(option, keyCode, conflictControl, conflictName, _Seed_HotkeyCheckNeeds, _Seed_CheckNeedsSpell)
		if success
			SaveSettingToCurrentProfile("hotkey_checkNeeds", keyCode)
		endif
	elseif option == Gameplay_AutoEatHotkey_OID
		success = RemapHotkey(option, keyCode, conflictControl, conflictName, _Seed_HotkeyAutoEat, _Seed_AutoEat)
		if success
			SaveSettingToCurrentProfile("hotkey_AutoEat", keyCode)
		endif
	elseif option == Gameplay_AutoDrinkHotkey_OID
		success = RemapHotkey(option, keyCode, conflictControl, conflictName, _Seed_HotkeyAutoDrink, _Seed_AutoDrink)
		if success
			SaveSettingToCurrentProfile("hotkey_AutoDrink", keyCode)
		endif
	elseif option == Gameplay_ProvisionsHotkey_OID
		success = RemapHotkey(option, keyCode, conflictControl, conflictName, _Seed_HotkeyProvisions, _Seed_ProvisionsSpell)
		if success
			SaveSettingToCurrentProfile("hotkey_Provisions", keyCode)
		endif		
	elseif option == Gameplay_IntensityHotkey_OID
		success = RemapHotkey(option, keyCode, conflictControl, conflictName, _Seed_HotkeyIntensity, _Seed_IntensityPlayerSpell)
		if success
			SaveSettingToCurrentProfile("hotkey_Intensity", keyCode)
		endif		
	elseif option == Gameplay_ExamineFoodHotkey_OID
		success = RemapHotkey(option, keyCode, conflictControl, conflictName, _Seed_HotkeyExamineFood, _Seed_ExamineFood)
		if success
			SaveSettingToCurrentProfile("hotkey_ExamineFood", keyCode)
		endif	
	elseif option == Gameplay_DrinkFromStreamHotkey_OID
		success = RemapHotkey(option, keyCode, conflictControl, conflictName, _Seed_HotkeyDrinkFromStream, _Seed_DrinkFromStreamSpell)
		if success
			SaveSettingToCurrentProfile("hotkey_DrinkFromStream", keyCode)
		endif	
	endif
EndEvent

bool function RemapHotkey(int option, int keyCode, string conflictControl, string conflictName, GlobalVariable akHotkeyGlobal, Spell akHotkeySpell)
	_Camp_Strings cs = _CampInternal.GetCampfireStrings()
	if conflictControl != ""
		if conflictName != ""
			; "This key is already bound to " + conflictControl + " in " + conflictName + ". Undesirable behavior may occur; use with caution, or assign to a different control."
			bool b = ShowMessage(cs.HotkeyConflict1 + conflictControl + cs.HotkeyConflict2 + conflictName + cs.HotkeyConflict3_mod)
			if b
				akHotkeyGlobal.SetValueInt(keyCode)
				RegisterForKey(akHotkeyGlobal.GetValueInt())
				ForcePageReset()
				Game.GetPlayer().RemoveSpell(akHotkeySpell)
				return true
			endif
		else
			; "This key is already bound to " + conflictControl + " in Skyrim. Please select a different key."
			ShowMessage(cs.HotkeyConflict1 + conflictControl + cs.HotkeyConflict3_game, a_withCancel = false)
			return false
		endif
	else
		akHotkeyGlobal.SetValueInt(keyCode)
		RegisterForKey(akHotkeyGlobal.GetValueInt())
		ForcePageReset()
		Game.GetPlayer().RemoveSpell(akHotkeySpell)
		return true
	endif
endFunction

Event OnKeyDown(int keyCode)
	if UI.IsMenuOpen("Console") || \
	 UI.IsMenuOpen("Book Menu") || \
	 UI.IsMenuOpen("BarterMenu") || \
	 UI.IsMenuOpen("ContainerMenu") || \
	 UI.IsMenuOpen("Crafting Menu") || \
	 UI.IsMenuOpen("Dialogue Menu") || \
	 UI.IsMenuOpen("FavoritesMenu") || \
	 UI.IsMenuOpen("InventoryMenu") || \
	 UI.IsMenuOpen("Journal Menu") || \
	 UI.IsMenuOpen("Lockpicking Menu") || \
	 UI.IsMenuOpen("MagicMenu") || \
	 UI.IsMenuOpen("MapMenu") || \
	 UI.IsMenuOpen("MessageBoxMenu") || \
	 UI.IsMenuOpen("Sleep/Wait Menu") || \
	 UI.IsMenuOpen("StatsMenu") || \
	 UI.IsMenuOpen("UITextEntryMenu")
		return
	endif
	if keyCode == _Seed_HotkeyCheckNeeds.GetValueInt()
		_Seed_CheckNeedsSpell.Cast(PlayerRef)
	elseif keyCode == _Seed_HotkeyAutoEat.GetValueInt()
		_Seed_AutoEat.Cast(PlayerRef)
	elseif keyCode == _Seed_HotkeyAutoDrink.GetValueInt()
		_Seed_AutoDrink.Cast(PlayerRef)
	elseif keyCode == _Seed_HotkeyProvisions.GetValueInt()
		_Seed_ProvisionsSpell.Cast(PlayerRef)	
	elseif keyCode == _Seed_HotkeyIntensity.GetValueInt()
		if Provisioning_PerkRank_UnboundIntensity.getValue() > 0
			_Seed_IntensityPlayerSpell.Cast(PlayerRef)		
		Else
			_Seed_SkillLockedMessage.show()
		Endif
	elseif keyCode == _Seed_HotkeyExamineFood.GetValueInt()
		_Seed_ExamineFood.Cast(PlayerRef)
	elseif keyCode == _Seed_HotkeyDrinkFromStream.GetValueInt()
		_Seed_DrinkFromStreamSpell.Cast(PlayerRef)			
	endif
EndEvent
	
string function GetCustomControl(int keyCode)

endFunction

; @TODO: Don't duplicate registration with LoadProfileOnStartup()
function RegisterForKeysOnLoad()

endFunction

string function GetProfileName(int aiProfileIndex)
	return JsonUtil.GetStringValue(CONFIG_PATH + "profile" + aiProfileIndex, "profile_name", missing = "Profile " + aiProfileIndex)
endFunction

function SetProfileName(int aiProfileIndex, string asProfileName)
	JsonUtil.SetStringValue(CONFIG_PATH + "profile" + aiProfileIndex, "profile_name", asProfileName)
endFunction

function SaveSettingToCurrentProfile(string asKeyName, int aiValue)
	if _Seed_Setting_AutoSaveLoad.GetValueInt() == 2
		int current_profile_index = _Seed_Setting_CurrentProfile.GetValueInt()
		JsonUtil.SetIntValue(CONFIG_PATH + "profile" + current_profile_index, asKeyName, aiValue)
		JsonUtil.Save(CONFIG_PATH + "profile" + current_profile_index)
	endif
endFunction

int function LoadSettingFromProfile(int aiProfileIndex, string asKeyName)
	return JsonUtil.GetIntValue(CONFIG_PATH + "profile" + aiProfileIndex, asKeyName, -1)
endFunction

function LoadProfileOnStartup()
	;/
	int auto_load = JsonUtil.GetIntValue(CONFIG_PATH + "common", "auto_load", 0)
	if auto_load == 2
		_Seed_Setting_AutoSaveLoad.SetValueInt(2)
		int last_profile = JsonUtil.GetIntValue(CONFIG_PATH + "common", "last_profile", 0)
		if last_profile != 0
			_Seed_Setting_CurrentProfile.SetValueInt(last_profile)
			SwitchToProfile(last_profile)
		else
			; default to Profile 1 and write the file
			_Seed_Setting_CurrentProfile.SetValueInt(1)
			JsonUtil.SetIntValue(CONFIG_PATH + "common", "last_profile", 1)
			JsonUtil.Save(CONFIG_PATH + "common")
			SwitchToProfile(1)
		endif
	elseif auto_load == 1
		_Seed_Setting_AutoSaveLoad.SetValueInt(1)
	elseif auto_load == 0
		; The file or setting does not exist, create it and default to auto-loading.
		; default to Profile 1 and write the file
		_Seed_Setting_AutoSaveLoad.SetValueInt(2)
		_Seed_Setting_CurrentProfile.SetValueInt(1)
		JsonUtil.SetIntValue(CONFIG_PATH + "common", "auto_load", 2)
		JsonUtil.SetIntValue(CONFIG_PATH + "common", "last_profile", 1)
		JsonUtil.Save(CONFIG_PATH + "common")
		SwitchToProfile(1)
	endif
	
	updateMeterPositions()
	/;
endFunction

function ShowProfileHelp()
	ShowMessage("$LastSeedSaveLoadTopic", false)
	ShowMessage("$LastSeedSaveLoadTopicCont", false)
	ShowMessage("$LastSeedSaveLoadTopicCont2", false)
endFunction

function SwitchToProfile(int aiProfileIndex)
	GetConfigurationHandler().onStart()

	_Seed_Setting_CurrentProfile.SetValueInt(aiProfileIndex)
	JsonUtil.SetIntValue(CONFIG_PATH + "common", "last_profile", aiProfileIndex)
	JsonUtil.Save(CONFIG_PATH + "common")

	string pname = JsonUtil.GetStringValue(CONFIG_PATH + "profile" + aiProfileIndex, "profile_name", "")
	if pname == ""
		GenerateDefaultProfile(aiProfileIndex)
	endif
	CleanProfile(aiProfileIndex)

	;Initialize Settings
	int i = aiProfileIndex
	;GAMEPLAY
	ApplySettingFromProfile(i, "gameplayPreset", _Seed_Setting_Presets_Gameplay)
	ApplySettingFromProfile(i, "focus_enabled", _Seed_Setting_Focus)
	; ApplySettingFromProfile(i, "FoodPortioning_enabled", _Seed_Setting_FoodPortioning)
	ApplySettingFromProfile(i, "diminishing_returns", _Seed_Setting_DiminishingFoodReturns)
	ApplySettingFromProfile(i, "auto_consume", _Seed_Setting_AutoConsume)
	ApplySettingFromProfile(i, "regeneration", _Seed_Setting_NeedsAffectedByRegeneration)
	; ApplySettingFromProfile(i, "portions_to_provisions", _Seed_ProvisionsAddPortions)
	ApplySettingFromProfile(i, "followersConsume", _Seed_Setting_FollowersConsumeFood)
	ApplySettingFromProfile(i, "FollowerNeeds_enabled", _Seed_Setting_SystemEnabled_FollowerNeeds)
	ApplySettingFromProfile(i, "FollowerNeeds_count", _Seed_Setting_PartyCount)
	ApplySettingFromProfile(i, "vampire_mode", _Seed_Setting_VampireBehavior)
	ApplySettingFromProfile(i, "food_names", _Seed_Setting_AddNames)
	ApplySettingFromProfile(i, "FoodPrice", _Seed_Setting_FoodPriceMulti)
	ApplySettingFromProfile(i, "FoodWeight", _Seed_Setting_FoodWeightMulti)
	ApplySettingFromProfile(i, "Cannibalism", _Seed_Setting_CannibalismEnabled)
	ApplySettingFromProfile(i, "InnDialogWater", _Seed_Settings_InnDialogWater)
	ApplySettingFromProfile(i, "InnDialogMeals", _Seed_Settings_InnDialogMeals)
	ApplySettingFromProfile(i, "EnableWaterBottles", _Seed_Settings_EnableWaterBottles)
	ApplySettingFromProfile(i, "DungeonFocus", _Seed_Settings_FocusInDungeons)
	
	;HUNGER
	ApplySettingFromProfile(i, "hunger_enabled", _Seed_Setting_SystemEnabled_Hunger)
	ApplySettingFromProfile(i, "HungerRate", _Seed_Setting_RateMulti_Hunger)
	
	;THIRST
	ApplySettingFromProfile(i, "thirst_enabled", _Seed_Setting_SystemEnabled_Thirst)
	ApplySettingFromProfile(i, "ThirstRate", _Seed_Setting_RateMulti_Thirst)
	ApplySettingFromProfile(i, "thirst_affects_movement", _Seed_Setting_ThirstAffectsMovement)
	
	;FATIGUE
	ApplySettingFromProfile(i, "fatigue_enabled", _Seed_Setting_SystemEnabled_Fatigue)
	ApplySettingFromProfile(i, "FatigueRate", _Seed_Setting_RateMulti_Fatigue)
	ApplySettingFromProfile(i, "sleep_needs", _Seed_Setting_SleepAffectedByNeeds)
	ApplySettingFromProfile(i, "sleep_location", _Seed_Setting_SleepAffectedByLocation)
	
	;VITALITY
	ApplySettingFromProfile(i, "vitality_enabled", _Seed_Setting_SystemEnabled_Vitality)
	ApplySettingFromProfile(i, "no_vitality_mode", _Seed_Setting_NoVitalityMode)
	ApplySettingFromProfile(i, "VitalityRate", _Seed_Setting_RateMulti_Vitality)
	ApplySettingFromProfile(i, "VitalityMultiHunger", _Seed_setting_VitalityHungerMulti)
	ApplySettingFromProfile(i, "VitalityMultiThirst", _Seed_setting_VitalityThirstMulti)
	ApplySettingFromProfile(i, "VitalityMultiFatigue", _Seed_setting_VitalityFatigueMulti)
	ApplySettingFromProfile(i, "VitalityMultiDisease", _Seed_setting_VitalityDiseaseMulti)
	ApplySettingFromProfile(i, "VitalityMultiExposure", _Seed_setting_VitalityExposureMulti)
	
	;ALCOHOL
	ApplySettingFromProfile(i, "alcohol_enabled", _Seed_Setting_AlcoholSystemEnabled)
	ApplySettingFromProfile(i, "AlcoholRate", _Seed_Setting_RateMulti_Alcohol)
	ApplySettingFromProfile(i, "drunken_shenanigans", _Seed_Settings_DrunkenShenanigans)
	ApplySettingFromProfile(i, "alcohol_stumbling", _Seed_Setting_DrunkStumbling)
	ApplySettingFromProfile(i, "Alcohol_RateAle", _Seed_Setting_AlcoholMulti_Ale)
	ApplySettingFromProfile(i, "Alcohol_RateWine", _Seed_Setting_AlcoholMulti_Wine)
	ApplySettingFromProfile(i, "Alcohol_RateSpirits", _Seed_Setting_AlcoholMulti_Spirits)
	
	;SKOOMA
	ApplySettingFromProfile(i, "skooma_enabled", _Seed_Setting_SkoomaSystemEnabled)
	ApplySettingFromProfile(i, "SkoomaRate", _Seed_Setting_RateMulti_Skooma)
	ApplySettingFromProfile(i, "Skooma_RateWeak", _Seed_Setting_SkoomaMulti_Weak)
	ApplySettingFromProfile(i, "Skooma_RateStrong", _Seed_Setting_SkoomaMulti_Strong)
	
	;DISEASE
	ApplySettingFromProfile(i, "disease_enabled", _Seed_Setting_DiseaseType)
	ApplySettingFromProfile(i, "additional_diseases", _Seed_SettingAdditionalDiseases)
	; ApplySettingFromProfile(i, "disease_dirty", _Seed_Setting_DirtyDiseases)
	; ApplySettingFromProfile(i, "disease_potions", _Seed_Setting_DiseasePotionsCure)
	ApplySettingFromProfile(i, "disease_potion_mode", _Seed_Setting_DiseasePotionsCure)
	ApplySettingFromProfile(i, "shrines", _Seed_Setting_ShrinesCure)
	ApplySettingFromProfile(i, "priests", _Seed_Setting_DiseasePriestsCure)
	ApplySettingFromProfile(i, "Disease_ChanceRawFood", _Seed_Setting_DiseaseChanceRawFood)
	ApplySettingFromProfile(i, "Disease_ChanceStaleFood", _Seed_Setting_DiseaseChanceStaleFood)
	ApplySettingFromProfile(i, "Disease_ChanceDirtyWater", _Seed_Setting_DiseaseChanceDirtyWater)

	;SPOILAGE
	ApplySettingFromProfile(i, "Spoilage_enabled", _Seed_Setting_SpoilageEnable)
	ApplySettingFromProfile(i, "Spoilage_temperature", _Seed_Setting_SpoilageTemperatureMulti)
	; ApplySettingFromProfile(i, "Spoilage_containers_enabled", _Seed_Setting_ContainerSpoilageEnable)
	; ApplySettingFromProfile(i, "Spoilage_ContainersRate", _Seed_Setting_ContainerSpoilageRate)
	ApplySettingFromProfile(i, "Spoilage_remove", _Seed_Setting_SpoilageRemove)
	
	;FOOD SPOILAGE RATES
	ApplySettingFromProfile(i, "Spoilage_Bread", _Seed_Setting_SpoilRate01_Bread)
	ApplySettingFromProfile(i, "Spoilage_MeatRaw", _Seed_Setting_SpoilRate02_RawMeat)
	ApplySettingFromProfile(i, "Spoilage_MeatCooked", _Seed_Setting_SpoilRate03_CookedMeat)
	ApplySettingFromProfile(i, "Spoilage_SmallGameRaw", _Seed_Setting_SpoilRate04_RawSmallGame)
	ApplySettingFromProfile(i, "Spoilage_SmallGameCooked", _Seed_Setting_SpoilRate05_CookedSmallGame)
	ApplySettingFromProfile(i, "Spoilage_FishRaw", _Seed_Setting_SpoilRate06_RawFish)
	ApplySettingFromProfile(i, "Spoilage_FishCooked", _Seed_Setting_SpoilRate07_CookedFish)
	ApplySettingFromProfile(i, "Spoilage_SeafoodRaw", _Seed_Setting_SpoilRate08_RawSeafood)
	ApplySettingFromProfile(i, "Spoilage_SeafoodCooked", _Seed_Setting_SpoilRate09_CookedSeafood)
	ApplySettingFromProfile(i, "Spoilage_Vegetables", _Seed_Setting_SpoilRate10_Vegitables)
	ApplySettingFromProfile(i, "Spoilage_Fruit", _Seed_Setting_SpoilRate11_Fruit)
	ApplySettingFromProfile(i, "Spoilage_Cheese", _Seed_Setting_SpoilRate12_Cheese)
	ApplySettingFromProfile(i, "Spoilage_Treats", _Seed_Setting_SpoilRate13_Treats)
	ApplySettingFromProfile(i, "Spoilage_Pastries", _Seed_Setting_SpoilRate14_Pastry)
	ApplySettingFromProfile(i, "Spoilage_Stews", _Seed_Setting_SpoilRate15_Stew)
	ApplySettingFromProfile(i, "Spoilage_CheeseBowls", _Seed_Setting_SpoilRate16_CheeseBowls)
	ApplySettingFromProfile(i, "Spoilage_DrinkMilk", _Seed_Setting_SpoilRate17_Milk)
	ApplySettingFromProfile(i, "Spoilage_IceWraithTeeth", _Seed_Setting_SpoilRate_IceWraithTeeth)
	
	
	;INTERFACE
	ApplySettingFromProfile(i, "interface_sfx", _Seed_Setting_NeedsSFX)
	ApplySettingFromProfile(i, "interface_vfx", _Seed_Setting_NeedsVFX)
	ApplySettingFromProfile(i, "interface_feedback", _Seed_Setting_NeedsForceFeedback)
	ApplySettingFromProfile(i, "interface_messages", _Seed_Setting_Notifications)
	ApplySettingFromProfile(i, "interface_messages_followers", _Seed_Setting_Notifications_Followers)
	ApplySettingFromProfile(i, "interface_focusMessages", _Seed_Setting_FocusNotifications)
	ApplySettingFromProfile(i, "interface_frostfallMessages", _Seed_Setting_FrostfallNotifications)
	ApplySettingFromProfile(i, "interface_animations_player", _Seed_Setting_AnimatePlayer)
	; ApplySettingFromProfile(i, "interface_animations_first_person", _Seed_Setting_AnimatePlayer_FirstPerson)
	ApplySettingFromProfile(i, "interface_animations_followers", _Seed_Setting_AnimateFollowers)
	ApplySettingFromProfile(i, "interface_animations_pickup", _Seed_Setting_AnimatePickup)
	
	;METERS
	ApplySettingFromProfile(i, "manual_meter_config", _seed_setting_manualMeterConfig)
	ApplySettingFromProfile(i, "meter_mode", _Seed_Setting_HungerMeterDisplayMode)
	ApplySettingFromProfile(i, "meter_mode_vitality", _Seed_Setting_VitalityMeterDisplayMode)
	ApplySettingFromProfile(i, "Meters_UIMeterDisplayTime", _Seed_Setting_HungerMeterDisplayTime)
	ApplySettingFromProfile(i, "Meters_UIMeterDisplayTime_Vitality", _Seed_Setting_VitalityMeterDisplayTime)
	ApplySettingFromProfile(i, "Meters_UIMeterOpacity", _Seed_Setting_MeterHungerOpacity)
	ApplySettingFromProfile(i, "Meters_UIMeterOpacity_Vitality", _Seed_Setting_MeterVitalityOpacity)
	ApplySettingFromProfile(i, "Meter_Scale", _Seed_Setting_MeterScale)
	ApplySettingFromProfile(i, "Meter_Scale_Vitality", _Seed_Setting_MeterScaleVitality)
	; ApplySettingFromProfile(i, "Meter_Width", _Seed_Setting_MeterHungerWidth)
	; ApplySettingFromProfile(i, "Meter_Height", _Seed_Setting_MeterHungerHeight)
	; ApplySettingFromProfile(i, "Meter_WidthVitality", _Seed_Setting_MeterVitalityWidth)
	; ApplySettingFromProfile(i, "Meter_HeightVitality", _Seed_Setting_MeterVitalityHeight)
	
	; METER ANCHORS
	ApplySettingFromProfile(i, "Hunger_H", _Seed_Setting_MeterHungerHAnchor)
	ApplySettingFromProfile(i, "Hunger_V", _Seed_Setting_MeterHungerVAnchor)
	ApplySettingFromProfile(i, "Thirst_H", _Seed_Setting_MeterThirstHAnchor)
	ApplySettingFromProfile(i, "Thirst_V", _Seed_Setting_MeterThirstVAnchor)
	ApplySettingFromProfile(i, "Fatigue_H", _Seed_Setting_MeterFatigueHAnchor)
	ApplySettingFromProfile(i, "Fatigue_V", _Seed_Setting_MeterFatigueVAnchor)
	ApplySettingFromProfile(i, "Vitality_H", _Seed_Setting_MeterVitalityHAnchor)
	ApplySettingFromProfile(i, "Vitality_V", _Seed_Setting_MeterVitalityVAnchor)

	;METER POSITIONS
	ApplySettingFromProfile(i, "Meter_HungerX", _Seed_Setting_MeterHungerXPos)
	ApplySettingFromProfile(i, "Meter_HungerY", _Seed_Setting_MeterHungerYPos)
	ApplySettingFromProfile(i, "Meter_ThirstX", _Seed_Setting_MeterThirstXPos)
	ApplySettingFromProfile(i, "Meter_ThirstY", _Seed_Setting_MeterThirstYPos)
	ApplySettingFromProfile(i, "Meter_FatigueX", _Seed_Setting_MeterFatigueXPos)
	ApplySettingFromProfile(i, "Meter_FatigueY", _Seed_Setting_MeterFatigueYPos)
	ApplySettingFromProfile(i, "Meter_VitalityX", _Seed_Setting_MeterVitalityXPos)
	ApplySettingFromProfile(i, "Meter_VitalityY", _Seed_Setting_MeterVitalityYPos)
		
	;ADVANCED
	ApplySettingFromProfile(i, "help_enableTutorials", _Seed_Setting_DisplayTutorials)
	; ApplySettingFromProfile(i, "advanced_PO3_water", _Seed_Setting_PO3WaterDetection)
	ApplySettingFromProfile(i, "advanced_vampireMonitoring", _Seed_SettingVampireMonitoring)
	; ApplySettingFromProfile(i, "logLevel", _Seed_Setting_LogLevel)
	ApplySettingFromProfile(i, "Advanced_ProvisionsWeight", _Seed_Provisions_WeightPerPerson)
	
	;HOTKEYS	
	applyHotkeyFromProfile(i, "hotkey_checkNeeds", _Seed_HotkeyCheckNeeds, _Seed_CheckNeedsSpell)
	applyHotkeyFromProfile(i, "hotkey_AutoEat", _Seed_HotkeyAutoEat, _Seed_AutoEat)
	applyHotkeyFromProfile(i, "hotkey_AutoDrink", _Seed_HotkeyAutoDrink, _Seed_AutoDrink)
	applyHotkeyFromProfile(i, "hotkey_Provisions", _Seed_HotkeyProvisions, _Seed_ProvisionsSpell)
	applyHotkeyFromProfile(i, "hotkey_ExamineFood", _Seed_HotkeyExamineFood, _Seed_ExamineFood)
	applyHotkeyFromProfile(i, "hotkey_DrinkFromStream", _Seed_HotkeyDrinkFromStream, _Seed_DrinkFromStreamSpell)
	
	bool addIntensity = (Provisioning_PerkRank_UnboundIntensity.getValue() as int) > 0
	applyHotkeyFromProfile(i, "hotkey_Intensity", _Seed_HotkeyIntensity, _Seed_IntensityPlayerSpell, addIntensity)
	
	GetConfigurationHandler().onFinish()
	updateMeterPositions()
endFunction

function applyHotkeyFromProfile(int aiProfileIndex, string asKeyName, GlobalVariable theGlobal, spell theSpell, bool addTheSpell = true)
	int val = LoadSettingFromProfile(aiProfileIndex, asKeyName)
	if val != -1 && val != 0
		RegisterForKey(val)
		theGlobal.SetValueInt(val)
		PlayerRef.RemoveSpell(theSpell)
	else
		UnregisterForKey(theGlobal.GetValueInt())
		theGlobal.SetValue(0)
		if addTheSpell
			PlayerRef.AddSpell(theSpell, false)
		endif
	endif
endFunction

function ApplySettingFromProfile(int aiProfileIndex, string asKeyName, GlobalVariable theGlobal)
	int val = LoadSettingFromProfile(aiProfileIndex, asKeyName)
	if val != -1
		theGlobal.SetValueInt(val)
	endif
endFunction

function GenerateDefaultProfile(int aiProfileIndex)
	string profile_path = CONFIG_PATH + "profile" + aiProfileIndex
	JsonUtil.SetStringValue(profile_path, "profile_name", "Profile " + aiProfileIndex)
	
	;GAMEPLAY
	JsonUtil.SetIntValue(profile_path, "gameplayPreset", 2)
	JsonUtil.SetIntValue(profile_path, "focus_enabled", 2)
	JsonUtil.SetIntValue(profile_path, "diminishing_returns", 2)
	JsonUtil.SetIntValue(profile_path, "auto_consume", 1)
	JsonUtil.SetIntValue(profile_path, "regeneration", 2)
	JsonUtil.SetIntValue(profile_path, "followersConsume", 2)
	JsonUtil.SetIntValue(profile_path, "FollowerNeeds_enabled", 2)
	JsonUtil.SetIntValue(profile_path, "FollowerNeeds_count", 0)
	JsonUtil.SetIntValue(profile_path, "vampire_mode", 2)
	JsonUtil.SetIntValue(profile_path, "food_names", 1)
	JsonUtil.SetFloatValue(profile_path, "FoodPrice", 1.0)
	JsonUtil.SetFloatValue(profile_path, "FoodWeight", 1.0)
	JsonUtil.SetIntValue(profile_path, "Cannibalism", 1)
	JsonUtil.SetIntValue(profile_path, "InnDialogWater", 2)
	JsonUtil.SetIntValue(profile_path, "InnDialogMeals", 2)
	JsonUtil.SetIntValue(profile_path, "EnableWaterBottles", 2)
	JsonUtil.SetIntValue(profile_path, "DungeonFocus", 2)
	
	;HUNGER	
	JsonUtil.SetIntValue(profile_path, "hunger_enabled", 2)
	JsonUtil.SetFloatValue(profile_path, "HungerRate", 1.0)
	
	;THIRST
	JsonUtil.SetIntValue(profile_path, "thirst_enabled", 2)
	JsonUtil.SetFloatValue(profile_path, "ThirstRate", 1.0)
	JsonUtil.SetIntValue(profile_path, "thirst_affects_movement", 2)
	
	;FATIGUE
	JsonUtil.SetIntValue(profile_path, "fatigue_enabled", 2)
	JsonUtil.SetFloatValue(profile_path, "FatigueRate", 1.0)
	JsonUtil.SetIntValue(profile_path, "sleep_needs", 2)
	JsonUtil.SetIntValue(profile_path, "sleep_location", 2)

	;VITALITY
	JsonUtil.SetIntValue(profile_path, "vitality_enabled", 2)	
	JsonUtil.SetIntValue(profile_path, "no_vitality_mode", 2)	
	JsonUtil.SetFloatValue(profile_path, "VitalityRate", 1.0)	
	JsonUtil.SetFloatValue(profile_path, "VitalityMultiHunger", 1.0)	
	JsonUtil.SetFloatValue(profile_path, "VitalityMultiThirst", 1.0)	
	JsonUtil.SetFloatValue(profile_path, "VitalityMultiFatigue", 1.0)	
	JsonUtil.SetFloatValue(profile_path, "VitalityMultiDisease", 1.0)	
	JsonUtil.SetFloatValue(profile_path, "VitalityMultiExposure", 1.0)	
	
	;ALCOHOL
	JsonUtil.SetIntValue(profile_path, "alcohol_enabled", 2)	
	JsonUtil.SetFloatValue(profile_path, "AlcoholRate", 1.0)	
	JsonUtil.SetIntValue(profile_path, "alcohol_stumbling", 2)	
	JsonUtil.SetIntValue(profile_path, "drunken_shenanigans", 2)	
	JsonUtil.SetFloatValue(profile_path, "Alcohol_RateAle", 1.0)	
	JsonUtil.SetFloatValue(profile_path, "Alcohol_RateWine", 1.0)	
	JsonUtil.SetFloatValue(profile_path, "Alcohol_RateSpirits", 1.0)
	
	;SKOOMA
	JsonUtil.SetIntValue(profile_path, "skooma_enabled", 2)	
	JsonUtil.SetFloatValue(profile_path, "skooma_rate", 1.0)	
	JsonUtil.SetFloatValue(profile_path, "Skooma_RateWeak", 1.0)	
	JsonUtil.SetFloatValue(profile_path, "Skooma_RateStrong", 1.0)	

	;DISEASE
	JsonUtil.SetIntValue(profile_path, "disease_enabled", 2)	
	JsonUtil.SetIntValue(profile_path, "additional_diseases", 2)	
	; JsonUtil.SetIntValue(profile_path, "disease_dirty", 2)	
	JsonUtil.SetIntValue(profile_path, "disease_potion_mode", 2)	
	JsonUtil.SetIntValue(profile_path, "shrines", 2)	
	JsonUtil.SetIntValue(profile_path, "priests", 2)	
	JsonUtil.SetIntValue(profile_path, "Disease_ChanceRawFood", 15)	
	JsonUtil.SetIntValue(profile_path, "Disease_ChanceStaleFood", 25)
	JsonUtil.SetIntValue(profile_path, "Disease_ChanceDirtyWater", 10)
	
	;SPOILAGE	
	JsonUtil.SetIntValue(profile_path, "Spoilage_enabled", 2)
	JsonUtil.SetIntValue(profile_path, "Spoilage_temperature", 2)
	JsonUtil.SetIntValue(profile_path, "Spoilage_remove", 1)
	
	;FOOD SPOILAGE RATES
	JsonUtil.SetIntValue(profile_path, "Spoilage_Bread", 168)
	JsonUtil.SetIntValue(profile_path, "Spoilage_MeatRaw", 48)
	JsonUtil.SetIntValue(profile_path, "Spoilage_MeatCooked", 96)	
	JsonUtil.SetIntValue(profile_path, "Spoilage_SmallGameRaw", 48)
	JsonUtil.SetIntValue(profile_path, "Spoilage_SmallGameCooked", 96)
	JsonUtil.SetIntValue(profile_path, "Spoilage_FishRaw", 48)
	JsonUtil.SetIntValue(profile_path, "Spoilage_FishCooked", 96)
	JsonUtil.SetIntValue(profile_path, "Spoilage_SeafoodRaw", 48)
	JsonUtil.SetIntValue(profile_path, "Spoilage_SeafoodCooked", 96)
	JsonUtil.SetIntValue(profile_path, "Spoilage_Vegetables", 168)
	JsonUtil.SetIntValue(profile_path, "Spoilage_Fruit", 168)
	JsonUtil.SetIntValue(profile_path, "Spoilage_Cheese", 168)
	JsonUtil.SetIntValue(profile_path, "Spoilage_Treats", 168)
	JsonUtil.SetIntValue(profile_path, "Spoilage_Pastries", 168)
	JsonUtil.SetIntValue(profile_path, "Spoilage_Stews", 168)
	JsonUtil.SetIntValue(profile_path, "Spoilage_CheeseBowls", 168)
	JsonUtil.SetIntValue(profile_path, "Spoilage_DrinkMilk", 120)
	JsonUtil.SetIntValue(profile_path, "Spoilage_IceWraithTeeth", 72) 

	;INTERFACE
	JsonUtil.SetIntValue(profile_path, "interface_sfx", 2) 
	JsonUtil.SetIntValue(profile_path, "interface_vfx", 2) 
	JsonUtil.SetIntValue(profile_path, "interface_feedback", 2) 
	JsonUtil.SetIntValue(profile_path, "interface_feedback", 2) 
	JsonUtil.SetIntValue(profile_path, "interface_messages", 2) 
	JsonUtil.SetIntValue(profile_path, "interface_messages_followers", 2) 
	JsonUtil.SetIntValue(profile_path, "interface_focusMessages", 2) 
	JsonUtil.SetIntValue(profile_path, "interface_frostfallMessages", 2) 
	JsonUtil.SetIntValue(profile_path, "interface_animations_player", 2) 
	JsonUtil.SetIntValue(profile_path, "interface_animations_followers", 2) 
	JsonUtil.SetIntValue(profile_path, "interface_animations_pickup", 1) 

	;METERS
	JsonUtil.SetIntValue(profile_path, "manual_meter_config", 2)
	JsonUtil.SetIntValue(profile_path, "meter_mode", 2)
	JsonUtil.SetIntValue(profile_path, "meter_mode_vitality", 2)
	JsonUtil.SetIntValue(profile_path, "Meters_UIMeterDisplayTime", 4)
	JsonUtil.SetIntValue(profile_path, "Meters_UIMeterDisplayTime_Vitality", 4)
	JsonUtil.SetFloatValue(profile_path, "Meters_UIMeterOpacity", 100.0)
	JsonUtil.SetFloatValue(profile_path, "Meters_UIMeterOpacity_Vitality", 100.0)
	
	; METER MANUAL CONFIG
	JsonUtil.SetFloatValue(profile_path, "Meter_Scale", 100.0)
	JsonUtil.SetFloatValue(profile_path, "Meter_Scale_Vitality", 100.0)

	; METER MANUAL CONFIG - ANCHORS
	JsonUtil.SetIntValue(profile_path, "Hunger_H", HUNGER_METER_TOPLEFT_HANCHOR)
	JsonUtil.SetIntValue(profile_path, "Hunger_V", HUNGER_METER_TOPLEFT_VANCHOR)
	JsonUtil.SetIntValue(profile_path, "Thirst_H", THIRST_METER_TOPLEFT_HANCHOR)
	JsonUtil.SetIntValue(profile_path, "Thirst_V", THIRST_METER_TOPLEFT_VANCHOR)
	JsonUtil.SetIntValue(profile_path, "Fatigue_H", FATIGUE_METER_TOPLEFT_HANCHOR)
	JsonUtil.SetIntValue(profile_path, "Fatigue_V", FATIGUE_METER_TOPLEFT_VANCHOR)	
	JsonUtil.SetIntValue(profile_path, "Vitality_H", VITALITY_METER_TOPLEFT_HANCHOR)
	JsonUtil.SetIntValue(profile_path, "Vitality_V", VITALITY_METER_TOPLEFT_VANCHOR)

	;METER MANUAL CONFIG - POSITIONS
	JsonUtil.SetFloatValue(profile_path, "Meter_HungerX", HUNGER_METER_TOPLEFT_16_9_X)
	JsonUtil.SetFloatValue(profile_path, "Meter_HungerY", HUNGER_METER_TOPLEFT_16_9_Y)
	JsonUtil.SetFloatValue(profile_path, "Meter_ThirstX", THIRST_METER_TOPLEFT_16_9_X)
	JsonUtil.SetFloatValue(profile_path, "Meter_ThirstY", THIRST_METER_TOPLEFT_16_9_Y)
	JsonUtil.SetFloatValue(profile_path, "Meter_FatigueX", FATIGUE_METER_TOPLEFT_16_9_X)
	JsonUtil.SetFloatValue(profile_path, "Meter_FatigueY", FATIGUE_METER_TOPLEFT_16_9_Y)
	JsonUtil.SetFloatValue(profile_path, "Meter_VitalityX", VITALITY_METER_TOPLEFT_16_9_X)
	JsonUtil.SetFloatValue(profile_path, "Meter_VitalityY", VITALITY_METER_TOPLEFT_16_9_Y)
	
	;ADVANCED
	JsonUtil.SetIntValue(profile_path, "help_enableTutorials", 2)
	JsonUtil.SetIntValue(profile_path, "Advanced_ProvisionsWeight", 15)
	if(isSpecialEdition())
		JsonUtil.SetIntValue(profile_path, "advanced_vampireMonitoring", 1)
	else
		JsonUtil.SetIntValue(profile_path, "advanced_vampireMonitoring", 2)
	endif

	;HOTKEYS	
	JsonUtil.SetIntValue(profile_path, "hotkey_checkNeeds", 0)
	JsonUtil.SetIntValue(profile_path, "hotkey_AutoEat", 0)
	JsonUtil.SetIntValue(profile_path, "hotkey_AutoDrink", 0)
	JsonUtil.SetIntValue(profile_path, "hotkey_Provisions", 0)
	JsonUtil.SetIntValue(profile_path, "hotkey_ExamineFood", 0)
	JsonUtil.SetIntValue(profile_path, "hotkey_DrinkFromStream", 0)
	
	JsonUtil.Save(profile_path)
endFunction

function updateMeterPositions()
	; Update Meter Positions
	if(_seed_setting_manualMeterConfig.getValueInt() == 1)
		UpdateMeterConfiguration(0)
		UpdateMeterConfiguration(1)
		UpdateMeterConfiguration(2)
		UpdateMeterConfiguration(3)
	else
		ApplyMeterPreset(2)
	endif
endFunction

function SaveAllSettings(int aiProfileIndex)
	string profile_path = CONFIG_PATH + "profile" + aiProfileIndex
		
	;GAMEPLAY
	JsonUtil.SetIntValue(profile_path, "gameplayPreset", _Seed_Setting_Presets_Gameplay.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "focus_enabled", _Seed_Setting_Focus.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "FoodPortioning_enabled", _Seed_Setting_FoodPortioning.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "diminishing_returns", _Seed_Setting_DiminishingFoodReturns.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "auto_consume", _Seed_Setting_AutoConsume.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "regeneration", _Seed_Setting_NeedsAffectedByRegeneration.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "followersConsume", _Seed_Setting_FollowersConsumeFood.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "FollowerNeeds_enabled", _Seed_Setting_SystemEnabled_FollowerNeeds.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "FollowerNeeds_count", _Seed_Setting_PartyCount.GetValueInt())	
	JsonUtil.SetIntValue(profile_path, "vampire_mode", _Seed_Setting_VampireBehavior.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "food_names", _Seed_Setting_AddNames.GetValueInt())
	JsonUtil.SetFloatValue(profile_path, "FoodPrice", _Seed_Setting_FoodPriceMulti.GetValue())
	JsonUtil.SetFloatValue(profile_path, "FoodWeight", _Seed_Setting_FoodWeightMulti.GetValue())
	JsonUtil.SetIntValue(profile_path, "Cannibalism", _Seed_Setting_CannibalismEnabled.GetValueInt())
	
	JsonUtil.SetIntValue(profile_path, "InnDialogWater", _Seed_Settings_InnDialogWater.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "InnDialogMeals", _Seed_Settings_InnDialogMeals.GetValueInt())
	
	JsonUtil.SetIntValue(profile_path, "EnableWaterBottles", _Seed_Settings_EnableWaterBottles.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "DungeonFocus", _Seed_Settings_FocusInDungeons.GetValueInt())
	
	;HUNGER
	JsonUtil.SetIntValue(profile_path, "hunger_enabled", _Seed_Setting_SystemEnabled_Hunger.GetValueInt())
	JsonUtil.SetFloatValue(profile_path, "HungerRate", _Seed_Setting_RateMulti_Hunger.GetValue())

	
	;THIRST
	JsonUtil.SetIntValue(profile_path, "thirst_enabled", _Seed_Setting_SystemEnabled_Thirst.GetValueInt())
	JsonUtil.SetFloatValue(profile_path, "ThirstRate", _Seed_Setting_RateMulti_Thirst.GetValue())
	JsonUtil.SetIntValue(profile_path, "thirst_affects_movement", _Seed_Setting_ThirstAffectsMovement.GetValueInt())
	
	;FATIGUE
	JsonUtil.SetIntValue(profile_path, "fatigue_enabled", _Seed_Setting_SystemEnabled_Fatigue.GetValueInt())
	JsonUtil.SetFloatValue(profile_path, "FatigueRate", _Seed_Setting_RateMulti_Fatigue.GetValue())
	JsonUtil.SetIntValue(profile_path, "sleep_needs", _Seed_Setting_SleepAffectedByNeeds.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "sleep_location", _Seed_Setting_SleepAffectedByLocation.GetValueInt())


	;VITALITY
	JsonUtil.SetIntValue(profile_path, "vitality_enabled", _Seed_Setting_SystemEnabled_Vitality.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "no_vitality_mode", _Seed_Setting_NoVitalityMode.GetValueInt())
	JsonUtil.SetFloatValue(profile_path, "VitalityRate", _Seed_Setting_RateMulti_Vitality.GetValueInt())
	JsonUtil.SetFloatValue(profile_path, "VitalityMultiHunger", _Seed_setting_VitalityHungerMulti.GetValue())
	JsonUtil.SetFloatValue(profile_path, "VitalityMultiThirst", _Seed_setting_VitalityThirstMulti.GetValue())
	JsonUtil.SetFloatValue(profile_path, "VitalityMultiFatigue", _Seed_setting_VitalityFatigueMulti.GetValue())
	JsonUtil.SetFloatValue(profile_path, "VitalityMultiDisease", _Seed_setting_VitalityDiseaseMulti.GetValue())
	JsonUtil.SetFloatValue(profile_path, "VitalityMultiExposure", _Seed_setting_VitalityExposureMulti.GetValue())
	
	;ALCOHOL
	JsonUtil.SetIntValue(profile_path, "alcohol_enabled", _Seed_Setting_AlcoholSystemEnabled.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "alcohol_stumbling", _Seed_Setting_DrunkStumbling.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "drunken_shenanigans", _Seed_Settings_DrunkenShenanigans.GetValueInt())
	JsonUtil.SetFloatValue(profile_path, "AlcoholRate", _Seed_Setting_RateMulti_Alcohol.GetValue())
	JsonUtil.SetFloatValue(profile_path, "Alcohol_RateAle", _Seed_Setting_AlcoholMulti_Ale.GetValue())
	JsonUtil.SetFloatValue(profile_path, "Alcohol_RateWine", _Seed_Setting_AlcoholMulti_Wine.GetValue())
	JsonUtil.SetFloatValue(profile_path, "Alcohol_RateSpirits", _Seed_Setting_AlcoholMulti_Spirits.GetValue())


	;SKOOMA
	JsonUtil.SetIntValue(profile_path, "skooma_enabled", _Seed_Setting_SkoomaSystemEnabled.GetValueInt())
	JsonUtil.SetFloatValue(profile_path, "SkoomaRate", _Seed_Setting_RateMulti_Skooma.GetValue())
	JsonUtil.SetFloatValue(profile_path, "Skooma_RateWeak", _Seed_Setting_SkoomaMulti_Weak.GetValue())
	JsonUtil.SetFloatValue(profile_path, "Skooma_RateStrong", _Seed_Setting_SkoomaMulti_Strong.GetValue())


	;DISEASE
	JsonUtil.SetIntValue(profile_path, "disease_enabled", _Seed_Setting_DiseaseType.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "additional_diseases", _Seed_SettingAdditionalDiseases.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "disease_potion_mode", _Seed_Setting_DiseasePotionsCure.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "shrines", _Seed_Setting_ShrinesCure.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "priests", _Seed_Setting_DiseasePriestsCure.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Disease_ChanceRawFood", _Seed_Setting_DiseaseChanceRawFood.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Disease_ChanceStaleFood", _Seed_Setting_DiseaseChanceStaleFood.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Disease_ChanceDirtyWater", _Seed_Setting_DiseaseChanceDirtyWater.GetValueInt())

	;SPOILAGE
	JsonUtil.SetIntValue(profile_path, "Spoilage_enabled", _Seed_Setting_SpoilageEnable.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_temperature", _Seed_Setting_SpoilageTemperatureMulti.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_remove", _Seed_Setting_SpoilageRemove.GetValueInt())

	;FOOD SPOILAGE RATES
	JsonUtil.SetIntValue(profile_path, "Spoilage_Bread", _Seed_Setting_SpoilRate01_Bread.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_MeatRaw", _Seed_Setting_SpoilRate02_RawMeat.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_MeatCooked", _Seed_Setting_SpoilRate03_CookedMeat.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_SmallGameRaw", _Seed_Setting_SpoilRate04_RawSmallGame.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_SmallGameCooked", _Seed_Setting_SpoilRate05_CookedSmallGame.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_FishRaw", _Seed_Setting_SpoilRate06_RawFish.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_FishCooked", _Seed_Setting_SpoilRate07_CookedFish.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_SeafoodRaw", _Seed_Setting_SpoilRate08_RawSeafood.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_SeafoodCooked", _Seed_Setting_SpoilRate09_CookedSeafood.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_Vegetables", _Seed_Setting_SpoilRate10_Vegitables.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_Fruit", _Seed_Setting_SpoilRate11_Fruit.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_Cheese", _Seed_Setting_SpoilRate12_Cheese.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_Treats", _Seed_Setting_SpoilRate13_Treats.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_Pastries", _Seed_Setting_SpoilRate14_Pastry.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_Stews", _Seed_Setting_SpoilRate15_Stew.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_CheeseBowls", _Seed_Setting_SpoilRate16_CheeseBowls.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_DrinkMilk", _Seed_Setting_SpoilRate17_Milk.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Spoilage_IceWraithTeeth", _Seed_Setting_SpoilRate_IceWraithTeeth.GetValueInt())

	;INTERFACE
	JsonUtil.SetIntValue(profile_path, "interface_sfx", _Seed_Setting_NeedsSFX.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "interface_vfx", _Seed_Setting_NeedsVFX.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "interface_feedback", _Seed_Setting_NeedsForceFeedback.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "interface_messages", _Seed_Setting_Notifications.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "interface_messages_followers", _Seed_Setting_Notifications_Followers.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "interface_focusMessages", _Seed_Setting_FocusNotifications.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "interface_frostfallMessages", _Seed_Setting_FrostfallNotifications.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "interface_animations_player", _Seed_Setting_AnimatePlayer.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "interface_animations_followers", _Seed_Setting_AnimateFollowers.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "interface_animations_pickup", _Seed_Setting_AnimatePickup.GetValueInt())


	;METERS
	JsonUtil.SetIntValue(profile_path, "manual_meter_config", _seed_setting_manualMeterConfig.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "meter_mode", _Seed_Setting_HungerMeterDisplayMode.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "meter_mode_vitality", _Seed_Setting_VitalityMeterDisplayMode.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Meters_UIMeterDisplayTime", _Seed_Setting_HungerMeterDisplayTime.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Meters_UIMeterDisplayTime_Vitality", _Seed_Setting_VitalityMeterDisplayTime.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Meters_UIMeterOpacity", _Seed_Setting_MeterHungerOpacity.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Meters_UIMeterOpacity_Vitality", _Seed_Setting_MeterVitalityOpacity.GetValueInt())
	JsonUtil.SetFloatValue(profile_path, "Meter_Scale", _Seed_Setting_MeterScale.GetValue())
	JsonUtil.SetFloatValue(profile_path, "Meter_Scale_Vitality", _Seed_Setting_MeterScaleVitality.GetValue())

	; METER ANCHORS
	JsonUtil.SetIntValue(profile_path, "Hunger_H", _Seed_Setting_MeterHungerHAnchor.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Hunger_V", _Seed_Setting_MeterHungerVAnchor.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Thirst_H", _Seed_Setting_MeterThirstHAnchor.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Thirst_V", _Seed_Setting_MeterThirstVAnchor.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Fatigue_H", _Seed_Setting_MeterFatigueHAnchor.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Fatigue_V", _Seed_Setting_MeterFatigueVAnchor.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Vitality_H", _Seed_Setting_MeterVitalityHAnchor.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Vitality_V", _Seed_Setting_MeterVitalityVAnchor.GetValueInt())
	
	;METER POSITIONS
	JsonUtil.SetFloatValue(profile_path, "Meter_HungerX", _Seed_Setting_MeterHungerXPos.GetValue())
	JsonUtil.SetFloatValue(profile_path, "Meter_HungerY", _Seed_Setting_MeterHungerYPos.GetValue())
	JsonUtil.SetFloatValue(profile_path, "Meter_ThirstX", _Seed_Setting_MeterThirstXPos.GetValue())
	JsonUtil.SetFloatValue(profile_path, "Meter_ThirstY", _Seed_Setting_MeterThirstYPos.GetValue())
	JsonUtil.SetFloatValue(profile_path, "Meter_FatigueX", _Seed_Setting_MeterFatigueXPos.GetValue())
	JsonUtil.SetFloatValue(profile_path, "Meter_FatigueY", _Seed_Setting_MeterFatigueYPos.GetValue())
	JsonUtil.SetFloatValue(profile_path, "Meter_VitalityX", _Seed_Setting_MeterVitalityXPos.GetValue())
	JsonUtil.SetFloatValue(profile_path, "Meter_VitalityY", _Seed_Setting_MeterVitalityYPos.GetValue())
		
	;ADVANCED
	JsonUtil.SetIntValue(profile_path, "help_enableTutorials", _Seed_Setting_DisplayTutorials.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "advanced_vampireMonitoring", _Seed_SettingVampireMonitoring.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "Advanced_ProvisionsWeight", _Seed_Provisions_WeightPerPerson.GetValueInt())
	
	;HOTKEYS	
	JsonUtil.SetIntValue(profile_path, "hotkey_checkNeeds", _Seed_HotkeyCheckNeeds.GetValue() as int)
	JsonUtil.SetIntValue(profile_path, "hotkey_AutoEat", _Seed_HotkeyAutoEat.GetValue() as int)
	JsonUtil.SetIntValue(profile_path, "hotkey_AutoDrink", _Seed_HotkeyAutoDrink.GetValue() as int)
	JsonUtil.SetIntValue(profile_path, "hotkey_Provisions", _Seed_HotkeyProvisions.GetValue() as int)
	JsonUtil.SetIntValue(profile_path, "hotkey_Intensity", _Seed_HotkeyIntensity.GetValue() as int)
	JsonUtil.SetIntValue(profile_path, "hotkey_ExamineFood", _Seed_HotkeyExamineFood.GetValue() as int)
	JsonUtil.SetIntValue(profile_path, "hotkey_DrinkFromStream", _Seed_HotkeyDrinkFromStream.GetValue() as int)

	JsonUtil.Save(profile_path)
endFunction

function CleanProfile(int aiProfileIndex)
	string profile_path = CONFIG_PATH + "profile" + aiProfileIndex

	bool result

	result = JsonUtil.UnsetIntValue(profile_path, "FoodPortioning_enabled")
	result = JsonUtil.UnsetIntValue(profile_path, "portions_to_provisions")
	result = JsonUtil.UnsetIntValue(profile_path, "disease_dirty")
	result = JsonUtil.UnsetIntValue(profile_path, "disease_potions")
	result = JsonUtil.UnsetIntValue(profile_path, "Spoilage_containers_enabled")
	result = JsonUtil.UnsetIntValue(profile_path, "Spoilage_ContainersRate")
	result = JsonUtil.UnsetIntValue(profile_path, "interface_animations_first_person")
	result = JsonUtil.UnsetIntValue(profile_path, "Meter_Width")
	result = JsonUtil.UnsetIntValue(profile_path, "Meter_Height")
	result = JsonUtil.UnsetIntValue(profile_path, "Meter_WidthVitality")
	result = JsonUtil.UnsetIntValue(profile_path, "Meter_HeightVitality")
	result = JsonUtil.UnsetIntValue(profile_path, "advanced_PO3_water")
	result = JsonUtil.UnsetIntValue(profile_path, "_Seed_Setting_LogLevel")
		
	JsonUtil.Save(profile_path)
endFunction

;NOT USED
function ResetTutorials()
	_Seed_HelpDone_Focus.SetValueInt(1)
	_Seed_HelpDone_Variety.SetValueInt(1)
endFunction


; Meters ======================================================================

string[] FILL_DIRECTIONS
string[] HORIZONTAL_ANCHORS
string[] VERTICAL_ANCHORS

float NORMAL_METER_WIDTH = 292.8
float NORMAL_METER_HEIGHT = 25.2

float CHARGE_METER_WIDTH = 292.0
float CHARGE_METER_HEIGHT = 22.0
float CHARGE_METER_HEIGHT_INV = -22.0

;DEFAULTS
int VITALITY_METER_TOPLEFT_HANCHOR = 0 			; HANCHOR_LEFT
int VITALITY_METER_TOPLEFT_VANCHOR = 0 			; VANCHOR_TOP
int VITALITY_METER_TOPLEFT_FILLDIR = 1 			; FILLDIR_RIGHT

int HUNGER_METER_TOPLEFT_HANCHOR = 2 			; HANCHOR_CENTER
int HUNGER_METER_TOPLEFT_VANCHOR = 1 			; VANCHOR_BOTTOM
int HUNGER_METER_TOPLEFT_FILLDIR = 2 			; FILLDIR_BOTH

int THIRST_METER_TOPLEFT_HANCHOR = 0 			; HANCHOR_CENTER
int THIRST_METER_TOPLEFT_VANCHOR = 1 			; VANCHOR_BOTTOM
int THIRST_METER_TOPLEFT_FILLDIR = 2 			; FILLDIR_BOTH

int FATIGUE_METER_TOPLEFT_HANCHOR = 1 			; HANCHOR_CENTER
int FATIGUE_METER_TOPLEFT_VANCHOR = 1 			; VANCHOR_BOTTOM
int FATIGUE_METER_TOPLEFT_FILLDIR = 2 			; FILLDIR_BOTH

float VITALITY_METER_TOPLEFT_16_9_X = 69.2
float VITALITY_METER_TOPLEFT_16_9_Y = 113.0
float VITALITY_METER_TOPLEFT_16_10_X = 64.2
float VITALITY_METER_TOPLEFT_16_10_Y = 113.0
float VITALITY_METER_TOPLEFT_4_3_X = 65.2
float VITALITY_METER_TOPLEFT_4_3_Y = 113.0

float HUNGER_METER_TOPLEFT_16_9_X = 916.75
float HUNGER_METER_TOPLEFT_16_9_Y = 717.5
float HUNGER_METER_TOPLEFT_16_10_X = 916.75
float HUNGER_METER_TOPLEFT_16_10_Y = 725.5
float HUNGER_METER_TOPLEFT_4_3_X = 916.75		;ADJUST THIS
float HUNGER_METER_TOPLEFT_4_3_Y = 717.5		;ADJUST THIS

float THIRST_METER_TOPLEFT_16_9_X = 1194.25
float THIRST_METER_TOPLEFT_16_9_Y = 717.5
float THIRST_METER_TOPLEFT_16_10_X = 1208.25
float THIRST_METER_TOPLEFT_16_10_Y = 725.5	
float THIRST_METER_TOPLEFT_4_3_X = 1194.25		;ADJUST THIS
float THIRST_METER_TOPLEFT_4_3_Y = 717.5		;ADJUST THIS

float FATIGUE_METER_TOPLEFT_16_9_X = 636.5
float FATIGUE_METER_TOPLEFT_16_9_Y = 717.5
float FATIGUE_METER_TOPLEFT_16_10_X = 623.5
float FATIGUE_METER_TOPLEFT_16_10_Y = 725.5	
float FATIGUE_METER_TOPLEFT_4_3_X = 636.5		;ADJUST THIS
float FATIGUE_METER_TOPLEFT_4_3_Y = 717.5		;ADJUST THIS

;OTHERS
int VITALITY_METER_BOTTOMLEFT_HANCHOR = 0 		; HANCHOR_LEFT
int VITALITY_METER_BOTTOMLEFT_VANCHOR = 1 		; VANCHOR_BOTTOM
int VITALITY_METER_BOTTOMLEFT_FILLDIR = 1 		; FILLDIR_RIGHT
int VITALITY_METER_BOTTOMRIGHT_HANCHOR = 1		; HANCHOR_RIGHT
int VITALITY_METER_BOTTOMRIGHT_VANCHOR = 1 		; VANCHOR_BOTTOM
int VITALITY_METER_BOTTOMRIGHT_FILLDIR = 0		; FILLDIR_LEFT
int VITALITY_METER_TOPRIGHT_HANCHOR = 1			; HANCHOR_RIGHT
int VITALITY_METER_TOPRIGHT_VANCHOR = 0 		; VANCHOR_TOP
int VITALITY_METER_TOPRIGHT_FILLDIR = 0			; FILLDIR_LEFT

int HUNGER_METER_BOTTOMLEFT_HANCHOR = 2 		; HANCHOR_CENTER
int HUNGER_METER_BOTTOMLEFT_VANCHOR = 1 		; VANCHOR_BOTTOM
int HUNGER_METER_BOTTOMLEFT_FILLDIR = 2 		; FILLDIR_BOTH
int HUNGER_METER_BOTTOMRIGHT_HANCHOR = 2		; HANCHOR_CENTER
int HUNGER_METER_BOTTOMRIGHT_VANCHOR = 1 		; VANCHOR_BOTTOM
int HUNGER_METER_BOTTOMRIGHT_FILLDIR = 2		; FILLDIRBOTH
int HUNGER_METER_TOPRIGHT_HANCHOR = 2			; HANCHOR_CENTER
int HUNGER_METER_TOPRIGHT_VANCHOR = 1 			; VANCHOR_BOTTOM
int HUNGER_METER_TOPRIGHT_FILLDIR = 2			; FILLDIRBOTH

float VITALITY_METER_BOTTOMLEFT_16_9_X = 69.2
float VITALITY_METER_BOTTOMLEFT_16_9_Y = 618.0
float VITALITY_METER_BOTTOMRIGHT_16_9_X = 1211.0
float VITALITY_METER_BOTTOMRIGHT_16_9_Y = 618.0
float VITALITY_METER_TOPRIGHT_16_9_X = 1211.0
float VITALITY_METER_TOPRIGHT_16_9_Y = 113.0

float HUNGER_METER_BOTTOMLEFT_16_9_X = 916.75
float HUNGER_METER_BOTTOMLEFT_16_9_Y = 717.5
float HUNGER_METER_BOTTOMRIGHT_16_9_X = 916.75
float HUNGER_METER_BOTTOMRIGHT_16_9_Y = 717.5
float HUNGER_METER_TOPRIGHT_16_9_X = 916.75
float HUNGER_METER_TOPRIGHT_16_9_Y = 717.5

float VITALITY_METER_BOTTOMLEFT_16_10_X = 64.2
float VITALITY_METER_BOTTOMLEFT_16_10_Y = 628.0
float VITALITY_METER_BOTTOMRIGHT_16_10_X = 1216.0
float VITALITY_METER_BOTTOMRIGHT_16_10_Y = 628.0
float VITALITY_METER_TOPRIGHT_16_10_X = 1216.0
float VITALITY_METER_TOPRIGHT_16_10_Y = 113.0
float HUNGER_METER_BOTTOMLEFT_16_10_X = 916.75
float HUNGER_METER_BOTTOMLEFT_16_10_Y = 717.5
float HUNGER_METER_BOTTOMRIGHT_16_10_X = 916.75
float HUNGER_METER_BOTTOMRIGHT_16_10_Y = 717.5
float HUNGER_METER_TOPRIGHT_16_10_X = 916.75
float HUNGER_METER_TOPRIGHT_16_10_Y = 717.5

float VITALITY_METER_BOTTOMLEFT_4_3_X = 69.2
float VITALITY_METER_BOTTOMLEFT_4_3_Y = 645.0
float VITALITY_METER_BOTTOMRIGHT_4_3_X = 1218.0
float VITALITY_METER_BOTTOMRIGHT_4_3_Y = 645.0
float VITALITY_METER_TOPRIGHT_4_3_X = 1218.0
float VITALITY_METER_TOPRIGHT_4_3_Y = 113.0

float HUNGER_METER_BOTTOMLEFT_4_3_X = 916.75
float HUNGER_METER_BOTTOMLEFT_4_3_Y = 717.5
float HUNGER_METER_BOTTOMRIGHT_4_3_X = 916.75
float HUNGER_METER_BOTTOMRIGHT_4_3_Y = 717.5
float HUNGER_METER_TOPRIGHT_4_3_X = 916.75
float HUNGER_METER_TOPRIGHT_4_3_Y = 717.5

int meter_being_configured = 0
int METER_BEING_CONFIGURED_NONE = 0
int METER_BEING_CONFIGURED_VITALITY = 1
int METER_BEING_CONFIGURED_HUNGER = 2
int METER_BEING_CONFIGURED_THIRST = 3
int METER_BEING_CONFIGURED_FATIGUE = 4

function ApplyMeterPreset(int aiPresetIdx)
	_Seed_Setting_MeterScale.setValue(100)
	_Seed_Setting_MeterScaleVitality.setValue(100)

	int w = Utility.GetINIInt("iSize W:Display")
	int h = Utility.GetINIInt("iSize H:Display")
	float ratio = (w as float)/(h as float)
	debug.trace("[LastSeed] Detected display resolution " + w + "x" + h + " (" + ratio + " aspect ratio).")
	if ratio > 1.7 && ratio < 1.8
		debug.trace("[LastSeed] Loading 16:9 aspect ratio meter preset.")
	elseif ratio == 1.6
		debug.trace("[LastSeed] Loading 16:10 aspect ratio meter preset.")
		aiPresetIdx += 4
	elseif ratio > 1.3 && ratio < 1.4
		debug.trace("[LastSeed] Loading 4:3 aspect ratio meter preset.")
		aiPresetIdx += 8
	else
		if config_is_open
			bool result = ShowMessage("$LastSeedMeterLayoutProblem")
			if result == false
				return
			endif
		else
			debug.trace("[LastSeed] The display aspect ratio wasn't supported. Defaulting to 16:9.")
		endif
	endif
	
	if aiPresetIdx == 6
		; 16:10 Top Left
		_Seed_Setting_MeterVitalityFillDirection.SetValueInt(VITALITY_METER_TOPLEFT_FILLDIR)
		_Seed_Setting_MeterVitalityHAnchor.SetValueInt(VITALITY_METER_TOPLEFT_HANCHOR)
		_Seed_Setting_MeterVitalityVAnchor.SetValueInt(VITALITY_METER_TOPLEFT_VANCHOR)
		_Seed_Setting_MeterVitalityXPos.SetValue(VITALITY_METER_TOPLEFT_16_10_X)
		_Seed_Setting_MeterVitalityYPos.SetValue(VITALITY_METER_TOPLEFT_16_10_Y)
		_Seed_Setting_MeterVitalityHeight.SetValue(NORMAL_METER_HEIGHT)
		_Seed_Setting_MeterVitalityWidth.SetValue(NORMAL_METER_WIDTH)

		_Seed_Setting_MeterHungerFillDirection.SetValueInt(HUNGER_METER_TOPLEFT_FILLDIR)
		_Seed_Setting_MeterHungerHAnchor.SetValueInt(HUNGER_METER_TOPLEFT_HANCHOR)
		_Seed_Setting_MeterHungerVAnchor.SetValueInt(HUNGER_METER_TOPLEFT_VANCHOR)
		_Seed_Setting_MeterHungerXPos.SetValue(HUNGER_METER_TOPLEFT_16_10_X)
		_Seed_Setting_MeterHungerYPos.SetValue(HUNGER_METER_TOPLEFT_16_10_Y)
		_Seed_Setting_MeterHungerHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterHungerWidth.SetValue(CHARGE_METER_WIDTH)
		
		_Seed_Setting_MeterThirstFillDirection.SetValueInt(THIRST_METER_TOPLEFT_FILLDIR)
		_Seed_Setting_MeterThirstHAnchor.SetValueInt(THIRST_METER_TOPLEFT_HANCHOR)
		_Seed_Setting_MeterThirstVAnchor.SetValueInt(THIRST_METER_TOPLEFT_VANCHOR)
		_Seed_Setting_MeterThirstXPos.SetValue(THIRST_METER_TOPLEFT_16_10_X)
		_Seed_Setting_MeterThirstYPos.SetValue(THIRST_METER_TOPLEFT_16_10_Y)
		_Seed_Setting_MeterThirstHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterThirstWidth.SetValue(CHARGE_METER_WIDTH)
		
		_Seed_Setting_MeterFatigueFillDirection.SetValueInt(FATIGUE_METER_TOPLEFT_FILLDIR)
		_Seed_Setting_MeterFatigueHAnchor.SetValueInt(FATIGUE_METER_TOPLEFT_HANCHOR)
		_Seed_Setting_MeterFatigueVAnchor.SetValueInt(FATIGUE_METER_TOPLEFT_VANCHOR)
		_Seed_Setting_MeterFatigueXPos.SetValue(FATIGUE_METER_TOPLEFT_16_10_X)
		_Seed_Setting_MeterFatigueYPos.SetValue(FATIGUE_METER_TOPLEFT_16_10_Y)
		_Seed_Setting_MeterFatigueHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterFatigueWidth.SetValue(CHARGE_METER_WIDTH)

	;if aiPresetIdx == 2
	else
		; 16:9 Top Left
		_Seed_Setting_MeterVitalityFillDirection.SetValueInt(VITALITY_METER_TOPLEFT_FILLDIR)
		_Seed_Setting_MeterVitalityHAnchor.SetValueInt(VITALITY_METER_TOPLEFT_HANCHOR)
		_Seed_Setting_MeterVitalityVAnchor.SetValueInt(VITALITY_METER_TOPLEFT_VANCHOR)
		_Seed_Setting_MeterVitalityXPos.SetValue(VITALITY_METER_TOPLEFT_16_9_X)
		_Seed_Setting_MeterVitalityYPos.SetValue(VITALITY_METER_TOPLEFT_16_9_Y)
		_Seed_Setting_MeterVitalityHeight.SetValue(NORMAL_METER_HEIGHT)
		_Seed_Setting_MeterVitalityWidth.SetValue(NORMAL_METER_WIDTH)

		_Seed_Setting_MeterHungerFillDirection.SetValueInt(HUNGER_METER_TOPLEFT_FILLDIR)
		_Seed_Setting_MeterHungerHAnchor.SetValueInt(HUNGER_METER_TOPLEFT_HANCHOR)
		_Seed_Setting_MeterHungerVAnchor.SetValueInt(HUNGER_METER_TOPLEFT_VANCHOR)
		_Seed_Setting_MeterHungerXPos.SetValue(HUNGER_METER_TOPLEFT_16_9_X)
		_Seed_Setting_MeterHungerYPos.SetValue(HUNGER_METER_TOPLEFT_16_9_Y)
		_Seed_Setting_MeterHungerHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterHungerWidth.SetValue(CHARGE_METER_WIDTH)
		
		_Seed_Setting_MeterThirstFillDirection.SetValueInt(THIRST_METER_TOPLEFT_FILLDIR)
		_Seed_Setting_MeterThirstHAnchor.SetValueInt(THIRST_METER_TOPLEFT_HANCHOR)
		_Seed_Setting_MeterThirstVAnchor.SetValueInt(THIRST_METER_TOPLEFT_VANCHOR)
		_Seed_Setting_MeterThirstXPos.SetValue(THIRST_METER_TOPLEFT_16_9_X)
		_Seed_Setting_MeterThirstYPos.SetValue(THIRST_METER_TOPLEFT_16_9_Y)
		_Seed_Setting_MeterThirstHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterThirstWidth.SetValue(CHARGE_METER_WIDTH)	
		
		_Seed_Setting_MeterFatigueFillDirection.SetValueInt(FATIGUE_METER_TOPLEFT_FILLDIR)
		_Seed_Setting_MeterFatigueHAnchor.SetValueInt(FATIGUE_METER_TOPLEFT_HANCHOR)
		_Seed_Setting_MeterFatigueVAnchor.SetValueInt(FATIGUE_METER_TOPLEFT_VANCHOR)
		_Seed_Setting_MeterFatigueXPos.SetValue(FATIGUE_METER_TOPLEFT_16_9_X)
		_Seed_Setting_MeterFatigueYPos.SetValue(FATIGUE_METER_TOPLEFT_16_9_Y)
		_Seed_Setting_MeterFatigueHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterFatigueWidth.SetValue(CHARGE_METER_WIDTH)
	endif

;/
	elseif aiPresetIdx == 10
		; 4:3 Top Left
		_Seed_Setting_MeterVitalityFillDirection.SetValueInt(VITALITY_METER_TOPLEFT_FILLDIR)
		_Seed_Setting_MeterVitalityHAnchor.SetValueInt(VITALITY_METER_TOPLEFT_HANCHOR)
		_Seed_Setting_MeterVitalityVAnchor.SetValueInt(VITALITY_METER_TOPLEFT_VANCHOR)
		_Seed_Setting_MeterVitalityXPos.SetValue(VITALITY_METER_TOPLEFT_4_3_X)
		_Seed_Setting_MeterVitalityYPos.SetValue(VITALITY_METER_TOPLEFT_4_3_Y)
		_Seed_Setting_MeterVitalityHeight.SetValue(NORMAL_METER_HEIGHT)
		_Seed_Setting_MeterVitalityWidth.SetValue(NORMAL_METER_WIDTH)

		_Seed_Setting_MeterHungerFillDirection.SetValueInt(HUNGER_METER_TOPLEFT_FILLDIR)
		_Seed_Setting_MeterHungerHAnchor.SetValueInt(HUNGER_METER_TOPLEFT_HANCHOR)
		_Seed_Setting_MeterHungerVAnchor.SetValueInt(HUNGER_METER_TOPLEFT_VANCHOR)
		_Seed_Setting_MeterHungerXPos.SetValue(HUNGER_METER_TOPLEFT_4_3_X)
		_Seed_Setting_MeterHungerYPos.SetValue(HUNGER_METER_TOPLEFT_4_3_Y)
		_Seed_Setting_MeterHungerHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterHungerWidth.SetValue(CHARGE_METER_WIDTH)
		
		_Seed_Setting_MeterThirstFillDirection.SetValueInt(THIRST_METER_TOPLEFT_FILLDIR)
		_Seed_Setting_MeterThirstHAnchor.SetValueInt(THIRST_METER_TOPLEFT_HANCHOR)
		_Seed_Setting_MeterThirstVAnchor.SetValueInt(THIRST_METER_TOPLEFT_VANCHOR)
		_Seed_Setting_MeterThirstXPos.SetValue(THIRST_METER_TOPLEFT_4_3_X)
		_Seed_Setting_MeterThirstYPos.SetValue(THIRST_METER_TOPLEFT_4_3_Y)
		_Seed_Setting_MeterThirstHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterThirstWidth.SetValue(CHARGE_METER_WIDTH)

		_Seed_Setting_MeterFatigueFillDirection.SetValueInt(FATIGUE_METER_TOPLEFT_FILLDIR)
		_Seed_Setting_MeterFatigueHAnchor.SetValueInt(FATIGUE_METER_TOPLEFT_HANCHOR)
		_Seed_Setting_MeterFatigueVAnchor.SetValueInt(FATIGUE_METER_TOPLEFT_VANCHOR)
		_Seed_Setting_MeterFatigueXPos.SetValue(FATIGUE_METER_TOPLEFT_4_3_X)
		_Seed_Setting_MeterFatigueYPos.SetValue(FATIGUE_METER_TOPLEFT_4_3_Y)
		_Seed_Setting_MeterFatigueHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterFatigueWidth.SetValue(CHARGE_METER_WIDTH)
		
	elseif aiPresetIdx == 0
		; 16:9 Bottom Left - NOT CURRENTLY USED
		_Seed_Setting_MeterVitalityFillDirection.SetValueInt(VITALITY_METER_BOTTOMLEFT_FILLDIR)
		_Seed_Setting_MeterVitalityHAnchor.SetValueInt(VITALITY_METER_BOTTOMLEFT_HANCHOR)
		_Seed_Setting_MeterVitalityVAnchor.SetValueInt(VITALITY_METER_BOTTOMLEFT_VANCHOR)
		_Seed_Setting_MeterVitalityXPos.SetValue(VITALITY_METER_BOTTOMLEFT_16_9_X)
		_Seed_Setting_MeterVitalityYPos.SetValue(VITALITY_METER_BOTTOMLEFT_16_9_Y)
		_Seed_Setting_MeterVitalityHeight.SetValue(NORMAL_METER_HEIGHT)
		_Seed_Setting_MeterVitalityWidth.SetValue(NORMAL_METER_WIDTH)

		_Seed_Setting_MeterHungerFillDirection.SetValueInt(HUNGER_METER_BOTTOMLEFT_FILLDIR)
		_Seed_Setting_MeterHungerHAnchor.SetValueInt(HUNGER_METER_BOTTOMLEFT_HANCHOR)
		_Seed_Setting_MeterHungerVAnchor.SetValueInt(HUNGER_METER_BOTTOMLEFT_VANCHOR)
		_Seed_Setting_MeterHungerXPos.SetValue(HUNGER_METER_BOTTOMLEFT_16_9_X)
		_Seed_Setting_MeterHungerYPos.SetValue(HUNGER_METER_BOTTOMLEFT_16_9_Y)
		_Seed_Setting_MeterHungerHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterHungerWidth.SetValue(CHARGE_METER_WIDTH)
				
	elseif aiPresetIdx == 1
		; 16:9 Bottom Right - NOT CURRENTLY USED
		_Seed_Setting_MeterVitalityFillDirection.SetValueInt(VITALITY_METER_BOTTOMRIGHT_FILLDIR)
		_Seed_Setting_MeterVitalityHAnchor.SetValueInt(VITALITY_METER_BOTTOMRIGHT_HANCHOR)
		_Seed_Setting_MeterVitalityVAnchor.SetValueInt(VITALITY_METER_BOTTOMRIGHT_VANCHOR)
		_Seed_Setting_MeterVitalityXPos.SetValue(VITALITY_METER_BOTTOMRIGHT_16_9_X)
		_Seed_Setting_MeterVitalityYPos.SetValue(VITALITY_METER_BOTTOMRIGHT_16_9_Y)
		_Seed_Setting_MeterVitalityHeight.SetValue(NORMAL_METER_HEIGHT)
		_Seed_Setting_MeterVitalityWidth.SetValue(NORMAL_METER_WIDTH)

		_Seed_Setting_MeterHungerFillDirection.SetValueInt(HUNGER_METER_BOTTOMRIGHT_FILLDIR)
		_Seed_Setting_MeterHungerHAnchor.SetValueInt(HUNGER_METER_BOTTOMRIGHT_HANCHOR)
		_Seed_Setting_MeterHungerVAnchor.SetValueInt(HUNGER_METER_BOTTOMRIGHT_VANCHOR)
		_Seed_Setting_MeterHungerXPos.SetValue(HUNGER_METER_BOTTOMRIGHT_16_9_X)
		_Seed_Setting_MeterHungerYPos.SetValue(HUNGER_METER_BOTTOMRIGHT_16_9_Y)
		_Seed_Setting_MeterHungerHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterHungerWidth.SetValue(CHARGE_METER_WIDTH)
	elseif aiPresetIdx == 3
		; 16:9 Top Right - NOT CURRENTLY USED
		_Seed_Setting_MeterVitalityFillDirection.SetValueInt(VITALITY_METER_TOPRIGHT_FILLDIR)
		_Seed_Setting_MeterVitalityHAnchor.SetValueInt(VITALITY_METER_TOPRIGHT_HANCHOR)
		_Seed_Setting_MeterVitalityVAnchor.SetValueInt(VITALITY_METER_TOPRIGHT_VANCHOR)
		_Seed_Setting_MeterVitalityXPos.SetValue(VITALITY_METER_TOPRIGHT_16_9_X)
		_Seed_Setting_MeterVitalityYPos.SetValue(VITALITY_METER_TOPRIGHT_16_9_Y)
		_Seed_Setting_MeterVitalityHeight.SetValue(NORMAL_METER_HEIGHT)
		_Seed_Setting_MeterVitalityWidth.SetValue(NORMAL_METER_WIDTH)

		_Seed_Setting_MeterHungerFillDirection.SetValueInt(HUNGER_METER_TOPRIGHT_FILLDIR)
		_Seed_Setting_MeterHungerHAnchor.SetValueInt(HUNGER_METER_TOPRIGHT_HANCHOR)
		_Seed_Setting_MeterHungerVAnchor.SetValueInt(HUNGER_METER_TOPRIGHT_VANCHOR)
		_Seed_Setting_MeterHungerXPos.SetValue(HUNGER_METER_TOPRIGHT_16_9_X)
		_Seed_Setting_MeterHungerYPos.SetValue(HUNGER_METER_TOPRIGHT_16_9_Y)
		_Seed_Setting_MeterHungerHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterHungerWidth.SetValue(CHARGE_METER_WIDTH)
	elseif aiPresetIdx == 4
		; 16:10 Bottom Left - NOT CURRENTLY USED
		_Seed_Setting_MeterVitalityFillDirection.SetValueInt(VITALITY_METER_BOTTOMLEFT_FILLDIR)
		_Seed_Setting_MeterVitalityHAnchor.SetValueInt(VITALITY_METER_BOTTOMLEFT_HANCHOR)
		_Seed_Setting_MeterVitalityVAnchor.SetValueInt(VITALITY_METER_BOTTOMLEFT_VANCHOR)
		_Seed_Setting_MeterVitalityXPos.SetValue(VITALITY_METER_BOTTOMLEFT_16_10_X)
		_Seed_Setting_MeterVitalityYPos.SetValue(VITALITY_METER_BOTTOMLEFT_16_10_Y)
		_Seed_Setting_MeterVitalityHeight.SetValue(NORMAL_METER_HEIGHT)
		_Seed_Setting_MeterVitalityWidth.SetValue(NORMAL_METER_WIDTH)

		_Seed_Setting_MeterHungerFillDirection.SetValueInt(HUNGER_METER_BOTTOMLEFT_FILLDIR)
		_Seed_Setting_MeterHungerHAnchor.SetValueInt(HUNGER_METER_BOTTOMLEFT_HANCHOR)
		_Seed_Setting_MeterHungerVAnchor.SetValueInt(HUNGER_METER_BOTTOMLEFT_VANCHOR)
		_Seed_Setting_MeterHungerXPos.SetValue(HUNGER_METER_BOTTOMLEFT_16_10_X)
		_Seed_Setting_MeterHungerYPos.SetValue(HUNGER_METER_BOTTOMLEFT_16_10_Y)
		_Seed_Setting_MeterHungerHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterHungerWidth.SetValue(CHARGE_METER_WIDTH)
	elseif aiPresetIdx == 5
		; 16:10 Bottom Right - NOT CURRENTLY USED
		_Seed_Setting_MeterVitalityFillDirection.SetValueInt(VITALITY_METER_BOTTOMRIGHT_FILLDIR)
		_Seed_Setting_MeterVitalityHAnchor.SetValueInt(VITALITY_METER_BOTTOMRIGHT_HANCHOR)
		_Seed_Setting_MeterVitalityVAnchor.SetValueInt(VITALITY_METER_BOTTOMRIGHT_VANCHOR)
		_Seed_Setting_MeterVitalityXPos.SetValue(VITALITY_METER_BOTTOMRIGHT_16_10_X)
		_Seed_Setting_MeterVitalityYPos.SetValue(VITALITY_METER_BOTTOMRIGHT_16_10_Y)
		_Seed_Setting_MeterVitalityHeight.SetValue(NORMAL_METER_HEIGHT)
		_Seed_Setting_MeterVitalityWidth.SetValue(NORMAL_METER_WIDTH)

		_Seed_Setting_MeterHungerFillDirection.SetValueInt(HUNGER_METER_BOTTOMRIGHT_FILLDIR)
		_Seed_Setting_MeterHungerHAnchor.SetValueInt(HUNGER_METER_BOTTOMRIGHT_HANCHOR)
		_Seed_Setting_MeterHungerVAnchor.SetValueInt(HUNGER_METER_BOTTOMRIGHT_VANCHOR)
		_Seed_Setting_MeterHungerXPos.SetValue(HUNGER_METER_BOTTOMRIGHT_16_10_X)
		_Seed_Setting_MeterHungerYPos.SetValue(HUNGER_METER_BOTTOMRIGHT_16_10_Y)
		_Seed_Setting_MeterHungerHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterHungerWidth.SetValue(CHARGE_METER_WIDTH)

	elseif aiPresetIdx == 7
		; 16:10 Top Right - NOT CURRENTLY USED
		_Seed_Setting_MeterVitalityFillDirection.SetValueInt(VITALITY_METER_TOPRIGHT_FILLDIR)
		_Seed_Setting_MeterVitalityHAnchor.SetValueInt(VITALITY_METER_TOPRIGHT_HANCHOR)
		_Seed_Setting_MeterVitalityVAnchor.SetValueInt(VITALITY_METER_TOPRIGHT_VANCHOR)
		_Seed_Setting_MeterVitalityXPos.SetValue(VITALITY_METER_TOPRIGHT_16_10_X)
		_Seed_Setting_MeterVitalityYPos.SetValue(VITALITY_METER_TOPRIGHT_16_10_Y)
		_Seed_Setting_MeterVitalityHeight.SetValue(NORMAL_METER_HEIGHT)
		_Seed_Setting_MeterVitalityWidth.SetValue(NORMAL_METER_WIDTH)

		_Seed_Setting_MeterHungerFillDirection.SetValueInt(HUNGER_METER_TOPRIGHT_FILLDIR)
		_Seed_Setting_MeterHungerHAnchor.SetValueInt(HUNGER_METER_TOPRIGHT_HANCHOR)
		_Seed_Setting_MeterHungerVAnchor.SetValueInt(HUNGER_METER_TOPRIGHT_VANCHOR)
		_Seed_Setting_MeterHungerXPos.SetValue(HUNGER_METER_TOPRIGHT_16_10_X)
		_Seed_Setting_MeterHungerYPos.SetValue(HUNGER_METER_TOPRIGHT_16_10_Y)
		_Seed_Setting_MeterHungerHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterHungerWidth.SetValue(CHARGE_METER_WIDTH)
	elseif aiPresetIdx == 8
		; 4:3 Bottom Left - NOT CURRENTLY USED
		_Seed_Setting_MeterVitalityFillDirection.SetValueInt(VITALITY_METER_BOTTOMLEFT_FILLDIR)
		_Seed_Setting_MeterVitalityHAnchor.SetValueInt(VITALITY_METER_BOTTOMLEFT_HANCHOR)
		_Seed_Setting_MeterVitalityVAnchor.SetValueInt(VITALITY_METER_BOTTOMLEFT_VANCHOR)
		_Seed_Setting_MeterVitalityXPos.SetValue(VITALITY_METER_BOTTOMLEFT_4_3_X)
		_Seed_Setting_MeterVitalityYPos.SetValue(VITALITY_METER_BOTTOMLEFT_4_3_Y)
		_Seed_Setting_MeterVitalityHeight.SetValue(NORMAL_METER_HEIGHT)
		_Seed_Setting_MeterVitalityWidth.SetValue(NORMAL_METER_WIDTH)

		_Seed_Setting_MeterHungerFillDirection.SetValueInt(HUNGER_METER_BOTTOMLEFT_FILLDIR)
		_Seed_Setting_MeterHungerHAnchor.SetValueInt(HUNGER_METER_BOTTOMLEFT_HANCHOR)
		_Seed_Setting_MeterHungerVAnchor.SetValueInt(HUNGER_METER_BOTTOMLEFT_VANCHOR)
		_Seed_Setting_MeterHungerXPos.SetValue(HUNGER_METER_BOTTOMLEFT_4_3_X)
		_Seed_Setting_MeterHungerYPos.SetValue(HUNGER_METER_BOTTOMLEFT_4_3_Y)
		_Seed_Setting_MeterHungerHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterHungerWidth.SetValue(CHARGE_METER_WIDTH)
	elseif aiPresetIdx == 9
		; 4:3 Bottom Right - NOT CURRENTLY USED
		_Seed_Setting_MeterVitalityFillDirection.SetValueInt(VITALITY_METER_BOTTOMRIGHT_FILLDIR)
		_Seed_Setting_MeterVitalityHAnchor.SetValueInt(VITALITY_METER_BOTTOMRIGHT_HANCHOR)
		_Seed_Setting_MeterVitalityVAnchor.SetValueInt(VITALITY_METER_BOTTOMRIGHT_VANCHOR)
		_Seed_Setting_MeterVitalityXPos.SetValue(VITALITY_METER_BOTTOMRIGHT_4_3_X)
		_Seed_Setting_MeterVitalityYPos.SetValue(VITALITY_METER_BOTTOMRIGHT_4_3_Y)
		_Seed_Setting_MeterVitalityHeight.SetValue(NORMAL_METER_HEIGHT)
		_Seed_Setting_MeterVitalityWidth.SetValue(NORMAL_METER_WIDTH)

		_Seed_Setting_MeterHungerFillDirection.SetValueInt(HUNGER_METER_BOTTOMRIGHT_FILLDIR)
		_Seed_Setting_MeterHungerHAnchor.SetValueInt(HUNGER_METER_BOTTOMRIGHT_HANCHOR)
		_Seed_Setting_MeterHungerVAnchor.SetValueInt(HUNGER_METER_BOTTOMRIGHT_VANCHOR)
		_Seed_Setting_MeterHungerXPos.SetValue(HUNGER_METER_BOTTOMRIGHT_4_3_X)
		_Seed_Setting_MeterHungerYPos.SetValue(HUNGER_METER_BOTTOMRIGHT_4_3_Y)
		_Seed_Setting_MeterHungerHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterHungerWidth.SetValue(CHARGE_METER_WIDTH)

	elseif aiPresetIdx == 11
		; 4:3 Top Right - NOT CURRENTLY USED
		_Seed_Setting_MeterVitalityFillDirection.SetValueInt(VITALITY_METER_TOPRIGHT_FILLDIR)
		_Seed_Setting_MeterVitalityHAnchor.SetValueInt(VITALITY_METER_TOPRIGHT_HANCHOR)
		_Seed_Setting_MeterVitalityVAnchor.SetValueInt(VITALITY_METER_TOPRIGHT_VANCHOR)
		_Seed_Setting_MeterVitalityXPos.SetValue(VITALITY_METER_TOPRIGHT_4_3_X)
		_Seed_Setting_MeterVitalityYPos.SetValue(VITALITY_METER_TOPRIGHT_4_3_Y)
		_Seed_Setting_MeterVitalityHeight.SetValue(NORMAL_METER_HEIGHT)
		_Seed_Setting_MeterVitalityWidth.SetValue(NORMAL_METER_WIDTH)

		_Seed_Setting_MeterHungerFillDirection.SetValueInt(HUNGER_METER_TOPRIGHT_FILLDIR)
		_Seed_Setting_MeterHungerHAnchor.SetValueInt(HUNGER_METER_TOPRIGHT_HANCHOR)
		_Seed_Setting_MeterHungerVAnchor.SetValueInt(HUNGER_METER_TOPRIGHT_VANCHOR)
		_Seed_Setting_MeterHungerXPos.SetValue(HUNGER_METER_TOPRIGHT_4_3_X)
		_Seed_Setting_MeterHungerYPos.SetValue(HUNGER_METER_TOPRIGHT_4_3_Y)
		_Seed_Setting_MeterHungerHeight.SetValue(CHARGE_METER_HEIGHT_INV)
		_Seed_Setting_MeterHungerWidth.SetValue(CHARGE_METER_WIDTH)
	endif
	/;

	UpdateMeterConfiguration(0)
	UpdateMeterConfiguration(1)
	UpdateMeterConfiguration(2)
	UpdateMeterConfiguration(3)
endFunction

function ConfigureMeter(int aiMeterIdx, int aiFillDirectionIdx, int aiHAnchorIdx, int aiVAnchorIdx, float afPositionX, float afPositionY, float afHeight, float afWidth)
	; Not configured: Color, Opacity
	Common_SKI_MeterWidget MyMeter = None
	CommonMeterInterfaceHandler MyMeterHandler = None
	if aiMeterIdx == 0
		MyMeter = VitalityMeter
		MyMeterHandler = VitalityMeterHandler
	elseif aiMeterIdx == 1
		MyMeter = HungerMeter
		MyMeterHandler = HungerMeterHandler
	
	elseif aiMeterIdx == 2
		MyMeter = ThirstMeter
		MyMeterHandler = ThirstMeterHandler
	elseif aiMeterIdx == 3
		MyMeter = FatigueMeter
		MyMeterHandler = FatigueMeterHandler
	endif

	if !MyMeter
		return
	endIf

	MyMeter.FillDirection = FILL_DIRECTIONS[aiFillDirectionIdx]
	MyMeter.HAnchor = HORIZONTAL_ANCHORS[aiHAnchorIdx]
	MyMeter.VAnchor = VERTICAL_ANCHORS[aiVAnchorIdx]
	MyMeter.X = afPositionX
	MyMeter.Y = afPositionY
	MyMeter.Height = afHeight
	MyMeter.Width = afWidth
	MyMeterHandler.ForceMeterDisplay()
endFunction

function UpdateMeterConfiguration(int aiMeterIdx)
	if aiMeterIdx == 0
		; Vitality
		_Seed_Setting_MeterVitalityFillDirection.setValue(VITALITY_METER_TOPLEFT_FILLDIR)
		_Seed_Setting_MeterVitalityHeight.setValue(NORMAL_METER_HEIGHT * (_Seed_Setting_MeterScaleVitality.getValue() / 100))
		_Seed_Setting_MeterVitalityWidth.setValue(NORMAL_METER_WIDTH * (_Seed_Setting_MeterScaleVitality.getValue() / 100))		
		
		ConfigureMeter(0, _Seed_Setting_MeterVitalityFillDirection.GetValueInt(), 	\
						  _Seed_Setting_MeterVitalityHAnchor.GetValueInt(),			\
						  _Seed_Setting_MeterVitalityVAnchor.GetValueInt(),			\
						  _Seed_Setting_MeterVitalityXPos.GetValue(),				\
						  _Seed_Setting_MeterVitalityYPos.GetValue(),				\
						  _Seed_Setting_MeterVitalityHeight.GetValue(),				\
						  _Seed_Setting_MeterVitalityWidth.GetValue())

	elseif aiMeterIdx == 1
		; Hunger
		_Seed_Setting_MeterHungerFillDirection.setValue(HUNGER_METER_TOPLEFT_FILLDIR)
		_Seed_Setting_MeterHungerHeight.setValue(CHARGE_METER_HEIGHT_INV * (_Seed_Setting_MeterScale.getValue() / 100))
		_Seed_Setting_MeterHungerWidth.setValue(CHARGE_METER_WIDTH * (_Seed_Setting_MeterScale.getValue() / 100))
		
		ConfigureMeter(1, _Seed_Setting_MeterHungerFillDirection.GetValueInt(), 	\
						  _Seed_Setting_MeterHungerHAnchor.GetValueInt(),			\
						  _Seed_Setting_MeterHungerVAnchor.GetValueInt(),			\
						  _Seed_Setting_MeterHungerXPos.GetValue(),					\
						  _Seed_Setting_MeterHungerYPos.GetValue(),					\
						  _Seed_Setting_MeterHungerHeight.GetValue(),				\
						  _Seed_Setting_MeterHungerWidth.GetValue())
		elseif aiMeterIdx == 2
		; Thirst
		_Seed_Setting_MeterThirstFillDirection.setValue(THIRST_METER_TOPLEFT_FILLDIR)
		;_Seed_Setting_MeterThirstHeight.setValue(CHARGE_METER_HEIGHT_INV)
		;_Seed_Setting_MeterThirstWidth.setValue(CHARGE_METER_WIDTH)
		
		ConfigureMeter(2, _Seed_Setting_MeterThirstFillDirection.GetValueInt(), 	\
						  _Seed_Setting_MeterThirstHAnchor.GetValueInt();/0/;,		\
						  _Seed_Setting_MeterThirstVAnchor.GetValueInt(),			\
						  _Seed_Setting_MeterThirstXPos.GetValue(),					\
						  _Seed_Setting_MeterThirstYPos.GetValue(),					\
						  _Seed_Setting_MeterHungerHeight.GetValue(),				\
						  _Seed_Setting_MeterHungerWidth.GetValue())
		elseif aiMeterIdx == 3
		; Fatigue
		_Seed_Setting_MeterFatigueFillDirection.setValue(FATIGUE_METER_TOPLEFT_FILLDIR)
		;_Seed_Setting_MeterFatigueHeight.setValue(CHARGE_METER_HEIGHT_INV)
		;_Seed_Setting_MeterFatigueWidth.setValue(CHARGE_METER_WIDTH)
		
		ConfigureMeter(3, _Seed_Setting_MeterFatigueFillDirection.GetValueInt(), 	\
						  _Seed_Setting_MeterFatigueHAnchor.GetValueInt() ;/1/;,	\
						  _Seed_Setting_MeterFatigueVAnchor.GetValueInt(),			\
						  _Seed_Setting_MeterFatigueXPos.GetValue(),				\
						  _Seed_Setting_MeterFatigueYPos.GetValue(),				\
						  _Seed_Setting_MeterHungerHeight.GetValue(),				\
						  _Seed_Setting_MeterHungerWidth.GetValue())
	endif
endFunction

function RemoveAllMeters()
	SendEvent_LastSeedRemoveVitalityMeter()
	SendEvent_LastSeedRemoveHungerMeter()
	SendEvent_LastSeedRemoveThirstMeter()
	SendEvent_LastSeedRemoveFatigueMeter()
endFunction

function ForceAllMeters()
	SendEvent_ForceVitalityMeterDisplay()
	SendEvent_ForceHungerMeterDisplay()
	SendEvent_ForceThirstMeterDisplay()
	SendEvent_ForceFatigueMeterDisplay()
endFunction

float function GetMeterScale(float afCurrentWidth, float afBaseWidth)
	return afCurrentWidth / afBaseWidth
endFunction

bool function IsMeterInverted(CommonMeterInterfaceHandler handler)
	if handler.meter_inversion_value != -1.0
		if handler.lower_is_better && handler.AttributeValue.GetValue() < handler.meter_inversion_value
			return true
		elseif !handler.lower_is_better && handler.AttributeValue.GetValue() > handler.meter_inversion_value
			return true
		else
			return false
		endif
	else
		return false
	endif
endFunction

function SendEvent_LastSeedRemoveVitalityMeter()
	int handle = ModEvent.Create("LastSeed_RemoveVitalityMeter")
    if handle
        ModEvent.Send(handle)
    endif
endFunction

function SendEvent_LastSeedRemoveHungerMeter()
	int handle = ModEvent.Create("LastSeed_RemoveHungerMeter")
    if handle
        ModEvent.Send(handle)
    endif
endFunction

function SendEvent_LastSeedRemoveThirstMeter()
	int handle = ModEvent.Create("LastSeed_RemoveThirstMeter")
    if handle
        ModEvent.Send(handle)
    endif
endFunction

function SendEvent_LastSeedRemoveFatigueMeter()
	int handle = ModEvent.Create("LastSeed_RemoveFatigueMeter")
    if handle
        ModEvent.Send(handle)
    endif
endFunction

function SendEvent_ForceVitalityMeterDisplay(bool abFlash = false)
	int handle = ModEvent.Create("LastSeed_ForceVitalityMeterDisplay")
	if handle
		ModEvent.PushBool(handle, abFlash)
		ModEvent.Send(handle)
	endif
endFunction

function SendEvent_ForceHungerMeterDisplay(bool abFlash = false)
	int handle = ModEvent.Create("LastSeed_ForceHungerMeterDisplay")
	if handle
		ModEvent.PushBool(handle, abFlash)
		ModEvent.Send(handle)
	endif
endFunction

function SendEvent_ForceThirstMeterDisplay(bool abFlash = false)
	int handle = ModEvent.Create("LastSeed_ForceThirstMeterDisplay")
	if handle
		ModEvent.PushBool(handle, abFlash)
		ModEvent.Send(handle)
	endif
endFunction

function SendEvent_ForceFatigueMeterDisplay(bool abFlash = false)
	int handle = ModEvent.Create("LastSeed_ForceFatigueMeterDisplay")
	if handle
		ModEvent.PushBool(handle, abFlash)
		ModEvent.Send(handle)
	endif
endFunction
