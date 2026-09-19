Scriptname _Seed_ConfigurationHandler extends Quest 
;/
REFERENCED IN:
_Seed_ConfigurationHandlerQuest "Configuration Handler" [QUST:06250AD0]
/;

import SeedUtil
import CampUtil
import _SeedInternal

; GlobalVariable property _Seed_AttributeHunger auto
; GlobalVariable property _Seed_AttributeHungerMax auto
; GlobalVariable property _Seed_AttributeThirst auto
; GlobalVariable property _Seed_AttributeThirstMax auto
; GlobalVariable property _Seed_AttributeFatigue auto
; GlobalVariable property _Seed_AttributeFatigueMax auto
; GlobalVariable property _Seed_AttributeVitality auto
; GlobalVariable property _Seed_AttributeVitalityMax auto

GlobalVariable property LastSeedRunning auto
GlobalVariable property LastSeedStartupFinished auto
GlobalVariable property LastSeedRunning_KWCheck auto
GlobalVariable property LastSeedStartingUp auto
GlobalVariable Property _Seed_Setting_ForceStartMod auto
GlobalVariable property _Seed_Setting_Presets_Gameplay auto
GlobalVariable property _Seed_Setting_DiminishingFoodReturns auto
GlobalVariable property _Seed_Setting_FoodWeightMulti auto
GlobalVariable property _Seed_Setting_FoodPriceMulti auto
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
GlobalVariable property _Seed_Setting_FocusNotifications auto
GlobalVariable property _Seed_Setting_SystemEnabled_Fatigue auto
GlobalVariable property _Seed_Setting_SystemEnabled_Hunger auto
GlobalVariable property _Seed_Setting_SystemEnabled_Thirst auto
GlobalVariable property _Seed_Setting_SystemEnabled_Vitality auto
GlobalVariable property _Seed_Setting_SystemEnabled_FollowerNeeds auto
GlobalVariable property _Seed_Setting_RateMulti_Hunger auto
GlobalVariable property _Seed_Setting_RateMulti_Thirst auto
GlobalVariable property _Seed_Setting_RateMulti_Fatigue auto
GlobalVariable property _Seed_Setting_RateMulti_Vitality auto
GlobalVariable property _Seed_Setting_VampireBehavior auto
GlobalVariable property _Seed_Setting_Focus auto
GlobalVariable property _Seed_Setting_CannibalismEnabled auto
GlobalVariable property _Seed_Setting_FoodPortioning auto
GlobalVariable property _Seed_Setting_ThirstAffectsMovement auto
GlobalVariable property _Seed_Setting_NoVitalityMode auto
GlobalVariable property _Seed_Setting_SleepAffectedByNeeds auto
GlobalVariable property _Seed_Setting_SleepAffectedByLocation auto
GlobalVariable property _Seed_Setting_NeedsAffectedByRegeneration auto
;ALCOHOL AND DISEASE
GlobalVariable property _Seed_Setting_AlcoholSystemEnabled auto
GlobalVariable property _Seed_Setting_SkoomaSystemEnabled auto
GlobalVariable property _Seed_Setting_DrunkStumbling auto
GlobalVariable property _Seed_Settings_DrunkenShenanigans auto
GlobalVariable property _Seed_Setting_AlcoholMulti_Ale auto
GlobalVariable property _Seed_Setting_AlcoholMulti_Wine auto
GlobalVariable property _Seed_Setting_AlcoholMulti_Spirits auto
GlobalVariable property _Seed_Setting_DiseaseType auto
GlobalVariable property _Seed_SettingAdditionalDiseases auto
GlobalVariable property _Seed_Setting_DiseaseChanceRawFood auto
GlobalVariable property _Seed_Setting_DiseaseChanceStaleFood auto
GlobalVariable property _Seed_Setting_DiseaseChanceDirtyWater auto
GlobalVariable property _Seed_Setting_DiseasePotionsCure auto
GlobalVariable property _Seed_Setting_ShrinesCure auto
;SPOILAGE
GlobalVariable property _Seed_Setting_SpoilageEnable auto
GlobalVariable property _Seed_Setting_SpoilageRemove auto
GlobalVariable property _Seed_Setting_SpoilageTemperatureMulti auto
GlobalVariable property _Seed_Setting_ContainerSpoilageEnable auto
GlobalVariable property _Seed_Setting_ContainerSpoilageRate auto
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

GlobalVariable property _Seed_Setting_CurrentProfile auto
GlobalVariable property _Seed_Setting_AutoSaveLoad auto

GlobalVariable property _Seed_HelpDone_Focus auto
GlobalVariable property _Seed_HelpDone_Variety auto
globalVariable property _Seed_HelpDone_Skooma auto
globalVariable property _Seed_HelpDone_Disease auto
globalVariable property _Seed_HelpDone_PoorSleep auto
globalVariable property _Seed_HelpDone_Waterskins auto
globalVariable property _Seed_HelpDone_Food auto
globalVariable property _Seed_HelpDone_Alcohol auto
globalVariable property _Seed_HelpDone_SkoomaDrank auto
globalVariable property _Seed_HelpDone_Stew auto
globalVariable property _Seed_HelpDone_DangerousFood auto

GlobalVariable property _Seed_Setting_AnimatePlayer auto
GlobalVariable property _Seed_Setting_AnimatePlayer_FirstPerson auto
GlobalVariable property _Seed_Setting_AnimateFollowers auto
GlobalVariable property _Seed_Setting_ResetFoodLists auto
GlobalVariable property _Seed_SettingVampireMonitoring auto
GlobalVariable property _Seed_SettingPlayerIsLich auto

Message property _Seed_Help_Reset auto								;06250AD1
Message property _Seed_ResettingFormlists_Start auto				;062D966C
Message property _Seed_ResettingFormlists_Finish auto				;062D966D

Message property _Seed_ConfigMenuMain auto							;06250AD1
	
Message property _Seed_ConfigMenuOverview auto						;06250AD4
Message property _Seed_ConfigMenuOverview_ModEnabled auto			;06255BD6
Message property _Seed_ConfigMenuOverview_Presets auto				;06255BD7
		
Message property _Seed_ConfigMenuNeeds1 auto						;06255BD8
Message property _Seed_ConfigMenuNeeds2 auto						;06255BD8
Message property _Seed_ConfigMenuNeeds3 auto						;06255BD8
Message property _Seed_ConfigMenuNeeds_Vitality auto				;06255BDA
Message property _Seed_ConfigMenuNeeds_VitalityDeath auto			;06255BDB
Message property _Seed_ConfigMenuNeeds_Hunger auto					;06255BDC
Message property _Seed_ConfigMenuNeeds_DiminishingReturns auto		;06255BDD
Message property _Seed_ConfigMenuNeeds_Thirst auto					;06255BDE
Message property _Seed_ConfigMenuNeeds_Fatigue auto					;06255BDF
Message property _Seed_ConfigMenuNeeds_Focus auto					;06255BE0
Message property _Seed_ConfigMenuNeeds_Cannibalism auto				;TODO
Message property _Seed_ConfigMenuNeeds_Portioning  auto				;06255BE1
Message property _Seed_ConfigMenuNeeds_AutoEat auto					;06255BE2
Message property _Seed_ConfigMenuNeeds_Vampire auto					;06255BE3
Message property _Seed_ConfigMenuNeeds_Movement auto				;06255BE4
Message property _Seed_ConfigMenuNeeds_PortionsToProvisions auto	;06255BE5
Message property _Seed_ConfigMenuNeeds_Followers auto				;0625ACE7

Message property _Seed_ConfigMenuAlcoholDisease auto				;0625ACE8
Message property _Seed_ConfigMenuAlcoholDisease2 auto				;065A366F
Message property _Seed_ConfigMenuAlcoholDisease_Tripping auto		;062D966A
Message property _Seed_ConfigMenuAlcoholDisease_RandomPassOut auto	;TODO
Message property _Seed_ConfigMenuAlcoholDisease_Alcohol auto		;0625ACE9
Message property _Seed_ConfigMenuAlcoholDisease_Disease auto		;0625ACEA
Message property _Seed_ConfigMenuAlcoholDisease_AdditionalDiseases auto		;065A3670
Message property _Seed_ConfigMenuAlcoholDisease_Potions auto		;0625ACEB
Message property _Seed_ConfigMenuAlcoholDisease_Shrines auto		;0625ACEC

Message property _Seed_ConfigMenuEffects1 auto						;0625FDEE
Message property _Seed_ConfigMenuEffects2 auto						;06264EFC
Message property _Seed_ConfigMenuEffects3 auto						;062DE771
Message property _Seed_ConfigMenuEffects_SFX auto					;0625FDEF
Message property _Seed_ConfigMenuEffects_VFX auto					;0625FDF0
Message property _Seed_ConfigMenuEffects_Feedback auto				;0625FDF1
Message property _Seed_ConfigMenuEffects_Notifications auto			;0625FDF2
Message property _Seed_ConfigMenuEffects_NotificationsFollowers auto ;0625FDF3
Message property _Seed_ConfigMenuEffects_Animations auto 			;06264EFD
Message property _Seed_ConfigMenuEffects_AnimationsFollowers auto 	;06264EFE
Message property _Seed_ConfigMenuEffects_NotificationsFocus auto 	;062DE770

Message property _Seed_ConfigMenuSpoilage auto 						;0625FDF4
Message property _Seed_ConfigMenuSpoilage_Food auto 				;0625FDF5
Message property _Seed_ConfigMenuSpoilage_Containers auto 			;0625FDF6
Message property _Seed_ConfigMenuSpoilage_Remove auto 				;062FCDA8
Message property _Seed_ConfigMenuSpoilage_TemperatureMulti auto 	;TODO

Message property _Seed_ConfigMenuHelp1 auto 						;0625FDF7
Message property _Seed_ConfigMenuHelp2 auto 						;0659432E
Message property _Seed_ConfigMenuHelp_Show auto 					;0625FDF8
Message property _Seed_ConfigMenuHelp_Reset auto 					;0625FDF9
Message property _Seed_ConfigMenuHelp_ResetFoodLists auto 			;062D966B
Message property _Seed_ConfigMenuHelp_IsLich auto 					;06594330
Message property _Seed_ConfigMenuHelp_VampireMonitoring auto 		;0659432F

Message property _Seed_StartingUpMsg auto 			;TODO

int initialSetting_Hunger
int initialSetting_Thirst
int initialSetting_Fatigue
int initialSetting_Vitality
int initialSetting_Followers
int initialSetting_Disease
int initialSetting_System
int initiallyRunning
int initialSetting_Movement
int initialSetting_AnimatePlayer
int initialSetting_AnimateFollowers
int initialSetting_DiseasePotionsCure
int initialSetting_AdditionalDiseases
int initialSetting_VampireMonitoring
int initialSetting_PlayerIsLich
int initialSetting_NeedsAffectedByRegeneration
int initialSetting_Spoilage
int initialSetting_AutoConsume
int initialSetting_Alcohol
int initialSetting_Skooma


function startConfig()
	if LastSeedRunning.GetValueInt() == 2 && LastSeedStartupFinished.GetValueInt() != 2
		_Seed_StartingUpMsg.Show()
		return
	endif
	onStart() 
	startMenu()
	onFinish()
endFunction

Function startMenu()	
	int ibutton = _Seed_ConfigMenuMain.show()

	if ibutton == 0	; Quit
		;return	
	elseif ibutton == 1		; Overview
		overviewMenu()
	elseif ibutton == 2	; Needs
		NeedsMenu1()
	elseif ibutton == 3	; Alchohol & Disease
		AlcoholDiseaseMenu()
	elseif ibutton == 4	; Food Spoilage
		FoodSpoilageMenu()
	elseif ibutton == 5	; Effects
		EffectsMenu1()
	elseif ibutton == 6	; Help
		HelpMenu1()

	endif
endFunction

function overviewMenu()
	int ibutton = _Seed_ConfigMenuOverview.show()
	if ibutton == 0 ;Back
		startMenu()
	elseif ibutton == 1 ; Mod Enabled
		setMenuOption(_Seed_ConfigMenuOverview_ModEnabled, LastSeedStartingUp)
		overviewMenu()
	elseif ibutton == 2 ;Presets
		int result = setMenuOption(_Seed_ConfigMenuOverview_Presets, _Seed_Setting_Presets_Gameplay)
		if result > 0
			setPresets(result)
		endif
		overviewMenu()
	endif
endfunction

;NOTE: I tried to implement a paging system on this menu using conditional visibility of the options, but it turned out to be a bit painful to implement. I've left this method unchanged as it does work, but it's best not to duplicate it for other menus.
;/
function NeedsMenu()
	;Available Options
	int BACK = 0
	int ENABLE_VITALITY = 1
	int VITALITY_DEATH = 2
	int ENABLE_HUNGER = 3
	int DIMINISHING_RETURNS = 4
	int NEXT_PAGE_1 = 5
	int ENABLE_THIRST = 6
	int ENABLE_FATIGUE = 7
	int ENABLE_FOCUS = 8
	int PORTIONING = 9
	int PORTIONS_TO_PROVISIONS = 10
	int NEXT_PAGE_2 = 11
	int AUTO_EAT = 12
	int VAMPIRE_BEHAVIOUR = 13
	int NEEDS_AFFECT_MOVEMENT = 14
	int FOLLOWER_NEEDS = 15
	int NEXT_PAGE_3 = 16
	
	;Get Selection
	int ibutton = _Seed_ConfigMenuNeeds.show()
	
	; Fix Selection (buttons cannot return more than 9, so need to add 10 to options higher than that)
	if (_Seed_ConfigMenuNeedsPage.getValueInt() == 2 && ibutton < 5) || _Seed_ConfigMenuNeedsPage.getValueInt() == 3
		ibutton = iButton + 10
	endif
	
	;Process Selection
	if ibutton == NEXT_PAGE_1
		_Seed_ConfigMenuNeedsPage.setValue(2)
		NeedsMenu()
	elseif ibutton == NEXT_PAGE_2
		_Seed_ConfigMenuNeedsPage.setValue(3)
		NeedsMenu()
	elseif ibutton == NEXT_PAGE_3
		_Seed_ConfigMenuNeedsPage.setValue(1)
		NeedsMenu()
	elseif ibutton == BACK
		startMenu()
	elseif ibutton == ENABLE_VITALITY
		setMenuOption(_Seed_ConfigMenuNeeds_Vitality, _Seed_Setting_SystemEnabled_Vitality)
		NeedsMenu()
	elseif ibutton == VITALITY_DEATH
		setMenuOption(_Seed_ConfigMenuNeeds_VitalityDeath, _Seed_Setting_NoVitalityMode)
		NeedsMenu()
	elseif ibutton == ENABLE_HUNGER
		setMenuOption(_Seed_ConfigMenuNeeds_Hunger, _Seed_Setting_SystemEnabled_Hunger)
		NeedsMenu()
	elseif ibutton == DIMINISHING_RETURNS
		setMenuOption(_Seed_ConfigMenuNeeds_DiminishingReturns, _Seed_Setting_DiminishingFoodReturns)
		NeedsMenu()
	elseif ibutton == ENABLE_THIRST
		setMenuOption(_Seed_ConfigMenuNeeds_Thirst, _Seed_Setting_SystemEnabled_Thirst)
		NeedsMenu()
	elseif ibutton == ENABLE_FATIGUE
		setMenuOption(_Seed_ConfigMenuNeeds_Fatigue, _Seed_Setting_SystemEnabled_Fatigue)
		NeedsMenu()
	elseif ibutton == ENABLE_FOCUS
		setMenuOption(_Seed_ConfigMenuNeeds_Focus, _Seed_Setting_Focus)
		NeedsMenu()
	elseif ibutton == PORTIONING
		setMenuOption(_Seed_ConfigMenuNeeds_Portioning, _Seed_Setting_FoodPortioning)
		NeedsMenu()	
	elseif ibutton == AUTO_EAT
		setMenuOption(_Seed_ConfigMenuNeeds_AutoEat, _Seed_Setting_AutoConsume)
		NeedsMenu()
	elseif ibutton == VAMPIRE_BEHAVIOUR
		setMenuOption(_Seed_ConfigMenuNeeds_Vampire, _Seed_Setting_VampireBehavior)
		NeedsMenu()
	elseif ibutton == NEEDS_AFFECT_MOVEMENT
		setMenuOption(_Seed_ConfigMenuNeeds_Movement, _Seed_Setting_ThirstAffectsMovement)
		NeedsMenu()
	elseif ibutton == PORTIONS_TO_PROVISIONS
		setMenuOption(_Seed_ConfigMenuNeeds_PortionsToProvisions, _Seed_ProvisionsAddPortions)
		NeedsMenu()
		elseif ibutton == FOLLOWER_NEEDS
		setMenuOption(_Seed_ConfigMenuNeeds_Followers, _Seed_Setting_SystemEnabled_FollowerNeeds)
		NeedsMenu()
	endif
endfunction
/;
function NeedsMenu1()	
	;Get Selection
	int ibutton = _Seed_ConfigMenuNeeds1.show()
	
	;Process Selection
	if ibutton == 0 ;Main Menu
		startMenu()
	elseif ibutton == 1 ; Enable Vitality
		setMenuOption(_Seed_ConfigMenuNeeds_Vitality, _Seed_Setting_SystemEnabled_Vitality)
		NeedsMenu1()
	elseif ibutton == 2 ; Zero Vitality
		setMenuOption(_Seed_ConfigMenuNeeds_VitalityDeath, _Seed_Setting_NoVitalityMode)
		NeedsMenu1()
	elseif ibutton == 3 ; Enable Hunger
		setMenuOption(_Seed_ConfigMenuNeeds_Hunger, _Seed_Setting_SystemEnabled_Hunger)
		NeedsMenu1()
	elseif ibutton == 4 ; Diminishing Returns
		setMenuOption(_Seed_ConfigMenuNeeds_DiminishingReturns, _Seed_Setting_DiminishingFoodReturns)
		NeedsMenu1()
	elseif ibutton == 5 ; NEXT
		NeedsMenu2()
	endif
endfunction

function NeedsMenu2()
	;Get Selection
	int ibutton = _Seed_ConfigMenuNeeds2.show()
	
	;Process Selection
	if ibutton == 0 ; Thirst
		setMenuOption(_Seed_ConfigMenuNeeds_Thirst, _Seed_Setting_SystemEnabled_Thirst)
		NeedsMenu2()
	elseif ibutton == 1 ; Fatigue
		setMenuOption(_Seed_ConfigMenuNeeds_Fatigue, _Seed_Setting_SystemEnabled_Fatigue)
		NeedsMenu2()
	elseif ibutton == 2 ; Focus
		setMenuOption(_Seed_ConfigMenuNeeds_Focus, _Seed_Setting_Focus)
		NeedsMenu2()
	elseif ibutton == 3 ; Cannibalism
		setMenuOption(_Seed_ConfigMenuNeeds_Cannibalism, _Seed_Setting_CannibalismEnabled)
		NeedsMenu2()
	elseif ibutton == 4 ; NEXT
		NeedsMenu3()		
	endif
endfunction

function NeedsMenu3()
	;Get Selection
	int ibutton = _Seed_ConfigMenuNeeds3.show()
	
	;Process Selection
	if ibutton == 0 ; Auto-Eat
		setMenuOption(_Seed_ConfigMenuNeeds_AutoEat, _Seed_Setting_AutoConsume)
		NeedsMenu3()
	elseif ibutton == 1 ; Vampire Settings
		setMenuOption(_Seed_ConfigMenuNeeds_Vampire, _Seed_Setting_VampireBehavior)
		NeedsMenu3()
	elseif ibutton == 2 ; Needs Affect Movmement
		setMenuOption(_Seed_ConfigMenuNeeds_Movement, _Seed_Setting_ThirstAffectsMovement)
		NeedsMenu3()
	elseif ibutton == 3 ; Follower Needs
		setMenuOption(_Seed_ConfigMenuNeeds_Followers, _Seed_Setting_SystemEnabled_FollowerNeeds)
		NeedsMenu3()
	elseif ibutton == 4 ; Next
		NeedsMenu1()
	endif
endfunction

function AlcoholDiseaseMenu()
	int ibutton = _Seed_ConfigMenuAlcoholDisease.show()
	if ibutton == 0 ;Back
		startMenu()
	elseif ibutton == 1 ; Enable Alcohol
		setMenuOption(_Seed_ConfigMenuAlcoholDisease_Alcohol, _Seed_Setting_AlcoholSystemEnabled, _Seed_Setting_SkoomaSystemEnabled)
		AlcoholDiseaseMenu()
	elseif ibutton == 2 ; Enable Alcohol Tripping
		setMenuOption(_Seed_ConfigMenuAlcoholDisease_Tripping, _Seed_Setting_DrunkStumbling)
		AlcoholDiseaseMenu()
	elseif ibutton == 3 ;Change Location on Pass Out
		setMenuOption(_Seed_ConfigMenuAlcoholDisease_RandomPassOut, _Seed_Settings_DrunkenShenanigans)
		AlcoholDiseaseMenu()		
	elseif ibutton == 4 ;More
		AlcoholDiseaseMenu2()
	endif
endFunction

function AlcoholDiseaseMenu2()
	int ibutton = _Seed_ConfigMenuAlcoholDisease2.show()
	if ibutton == 0 ;Progressive Diseases
		setMenuOption(_Seed_ConfigMenuAlcoholDisease_Disease, _Seed_Setting_DiseaseType)
		AlcoholDiseaseMenu2()
	elseif ibutton == 1 ;Additional Diseases
		setMenuOption(_Seed_ConfigMenuAlcoholDisease_AdditionalDiseases, _Seed_SettingAdditionalDiseases)
		AlcoholDiseaseMenu2()
	elseif ibutton == 2 ;Potions Don't Cure Disease
		setMenuOption(_Seed_ConfigMenuAlcoholDisease_Potions, _Seed_Setting_DiseasePotionsCure)
		AlcoholDiseaseMenu2()
	elseif ibutton == 3 ; Shrines Don't Cure Disease
		setMenuOption(_Seed_ConfigMenuAlcoholDisease_Shrines, _Seed_Setting_ShrinesCure)
		AlcoholDiseaseMenu2()
	elseif ibutton == 4 ; More
		AlcoholDiseaseMenu()
	endif
endFunction


function FoodSpoilageMenu()
	int ibutton = _Seed_ConfigMenuSpoilage.show()
	if ibutton == 0 ;Back
		startMenu()
	elseif ibutton == 1 ; Food Spoilage
		setMenuOption(_Seed_ConfigMenuSpoilage_Food, _Seed_Setting_SpoilageEnable)
		FoodSpoilageMenu()
	elseif ibutton == 2 ;Remove Perished Food
		setMenuOption(_Seed_ConfigMenuSpoilage_Remove, _Seed_Setting_SpoilageRemove)
		FoodSpoilageMenu()
	elseif ibutton == 3 ;Spoilage affected by Temperature
		setMenuOption(_Seed_ConfigMenuSpoilage_TemperatureMulti, _Seed_Setting_SpoilageTemperatureMulti)
		FoodSpoilageMenu()
	endif
endFunction

function EffectsMenu1()
	int ibutton = _Seed_ConfigMenuEffects1.show()
	if ibutton == 0 ;Back
		startMenu()
	elseif ibutton == 1 ; Sound Effects
		setMenuOption(_Seed_ConfigMenuEffects_SFX, _Seed_Setting_NeedsSFX)
		EffectsMenu1()
	elseif ibutton == 2 ;Fullscreen Effects
		setMenuOption(_Seed_ConfigMenuEffects_VFX, _Seed_Setting_NeedsVFX)
		EffectsMenu1()
	elseif ibutton == 3 ;Force Feedback
		setMenuOption(_Seed_ConfigMenuEffects_Feedback, _Seed_Setting_NeedsForceFeedback)
		EffectsMenu1()
	elseif ibutton == 4 ; More
		EffectsMenu2()
	endif
endFunction

function EffectsMenu2()
	int ibutton = _Seed_ConfigMenuEffects2.show()
	if ibutton == 0 ;Player Notifications
		setMenuOption(_Seed_ConfigMenuEffects_Notifications, _Seed_Setting_Notifications)
		EffectsMenu2()
	elseif ibutton == 1 ;Follower Notifications
		setMenuOption(_Seed_ConfigMenuEffects_NotificationsFollowers, _Seed_Setting_Notifications_Followers)
		EffectsMenu2()
	elseif ibutton == 2 ; Player Animations
		setMenuOption(_Seed_ConfigMenuEffects_Animations, _Seed_Setting_AnimatePlayer)
		EffectsMenu2()
	elseif ibutton == 3 ; Follower Animations
		setMenuOption(_Seed_ConfigMenuEffects_AnimationsFollowers, _Seed_Setting_AnimateFollowers)
		EffectsMenu2()
	elseif ibutton == 4 ;More
		EffectsMenu3()
	endif
endFunction

function EffectsMenu3()
	int ibutton = _Seed_ConfigMenuEffects3.show()
	if ibutton == 0 ;Focus Notifications
		setMenuOption(_Seed_ConfigMenuEffects_NotificationsFocus, _Seed_Setting_FocusNotifications)
		EffectsMenu3()
	elseif ibutton == 1 ;More
		EffectsMenu1()
	endif
endFunction

function HelpMenu1()
	int ibutton = _Seed_ConfigMenuHelp1.show()
	if ibutton == 0 ;Back
		startMenu()
	elseif ibutton == 1 ; Sound Effects
		setMenuOption(_Seed_ConfigMenuHelp_Show, _Seed_Setting_DisplayTutorials)
		HelpMenu1()
	elseif ibutton == 2 ;Fullscreen Effects
		setMenuOption(_Seed_ConfigMenuHelp_Reset, _Seed_Setting_ResetTutorials)
		HelpMenu1()
	elseif ibutton == 3 ;Reset Food Formlists
		setMenuOption(_Seed_ConfigMenuHelp_ResetFoodLists, _Seed_Setting_ResetFoodLists)
		HelpMenu1()
	elseif ibutton == 4 ;More
		setMenuOption(_Seed_ConfigMenuHelp_ResetFoodLists, _Seed_Setting_ResetFoodLists)
		HelpMenu2()
	endif
endFunction

function HelpMenu2()
	int ibutton = _Seed_ConfigMenuHelp2.show()
	if ibutton == 0 ;Vampire Monitoring
		setMenuOption(_Seed_ConfigMenuHelp_VampireMonitoring, _Seed_SettingVampireMonitoring)
		HelpMenu2()
	elseif ibutton == 1 ; Player Is Lich
		setMenuOption(_Seed_ConfigMenuHelp_IsLich, _Seed_SettingPlayerIsLich)
		HelpMenu2()
	elseif ibutton == 2 ;More
		setMenuOption(_Seed_ConfigMenuHelp_ResetFoodLists, _Seed_Setting_ResetFoodLists)
		HelpMenu1()
	endif
endFunction


int function setMenuOption(Message menu, globalVariable var, globalVariable var2 = none)
	int selection = -1
	if var != none
		;debug.notification("Current Selection: " + var.getValueInt())
		debug.notification(GetTranslationHandler().CurrentSelection + var.getValueInt())
		
		Utility.Wait(0.1)
		selection = menu.show()
		if(selection > 0)
			var.setValue(selection)
			if var2
				var2.setValue(selection)
			endif
		endif
	;else 
	;	menu.show()
	endif
	return selection
endFunction



function onStart()
	SeedDebug(0, "[ConfigurationHandler]: Setting Initial Values")
	initialSetting_Hunger = _Seed_Setting_SystemEnabled_Hunger.GetValueInt()
	initialSetting_Thirst = _Seed_Setting_SystemEnabled_Thirst.GetValueInt()
	initialSetting_Fatigue = _Seed_Setting_SystemEnabled_Fatigue.GetValueInt()
	initialSetting_Vitality = _Seed_Setting_SystemEnabled_Vitality.GetValueInt()
	initialSetting_Followers = _Seed_Setting_SystemEnabled_FollowerNeeds.GetValueInt()
	initialSetting_Disease = _Seed_Setting_DiseaseType.GetValueInt()
	initialSetting_AdditionalDiseases = _Seed_SettingAdditionalDiseases.GetValueInt()
	initialSetting_System = LastSeedStartingUp.GetValueInt()
	initiallyRunning = LastSeedRunning.GetValueInt()
	initialSetting_Movement = _Seed_Setting_ThirstAffectsMovement.GetValueInt()
	initialSetting_AnimatePlayer = _Seed_Setting_AnimatePlayer.GetValueInt()
	initialSetting_AnimateFollowers = _Seed_Setting_AnimateFollowers.GetValueInt()
	initialSetting_DiseasePotionsCure = _Seed_Setting_DiseasePotionsCure.GetValueInt()
	initialSetting_VampireMonitoring = _Seed_SettingVampireMonitoring.GetValueInt()
	initialSetting_PlayerIsLich = _Seed_SettingPlayerIsLich.GetValueInt()
	initialSetting_NeedsAffectedByRegeneration = _Seed_Setting_NeedsAffectedByRegeneration.GetValueInt()
	initialSetting_Spoilage = _Seed_Setting_SpoilageEnable.GetValueInt()
	initialSetting_AutoConsume = _Seed_Setting_AutoConsume.GetValueInt()
	initialSetting_Alcohol = _Seed_Setting_AlcoholSystemEnabled.GetValueInt()
	initialSetting_Skooma = _Seed_Setting_SkoomaSystemEnabled.GetValueInt()
	SeedDebug(0, "[ConfigurationHandler]: Finished Setting Initial Values")
endFunction


function onFinish()

	SeedDebug(0, "[ConfigurationHandler]: Running onFinish")
	
	; ENABLE VAMPIRE MONITORING
	int currentSetting_VampireMonitoring = _Seed_SettingVampireMonitoring.GetValueInt()	
	if initialSetting_VampireMonitoring != currentSetting_VampireMonitoring
		if currentSetting_VampireMonitoring == 2
			getMonsterHandler().startMonitoring()
		else
			getMonsterHandler().stopMonitoring()
		endif
	endif
	
	; ENABLE LICH
	int currentSetting_PlayerIsLich = _Seed_SettingPlayerIsLich.GetValueInt()	
	if initialSetting_PlayerIsLich != currentSetting_PlayerIsLich
		if currentSetting_PlayerIsLich == 2
			getMonsterHandler().addLichSpell()
		else
			getMonsterHandler().addLichSpell(false)
		endif
	endif	
	

	

	; ENABLE HUNGER
	int currentSetting_Hunger = _Seed_Setting_SystemEnabled_Hunger.GetValueInt()
	if initialSetting_Hunger != currentSetting_Hunger
		if currentSetting_Hunger == 2
			GetHungerSystem().StartSystem()
			GetFollowerSystem().StartHungerSystems()
		else
			GetHungerSystem().StopSystem()
			GetFollowerSystem().StopHungerSystems()
		endif
	endif
	
	; ENABLE THIRST
	int currentSetting_Thirst = _Seed_Setting_SystemEnabled_Thirst.GetValueInt()
	if initialSetting_Thirst != currentSetting_Thirst
		if currentSetting_Thirst == 2
			GetThirstSystem().StartSystem()
			GetFollowerSystem().StartThirstSystems()
		else
			GetThirstSystem().StopSystem()
			GetFollowerSystem().StopThirstSystems()
		endif
	endif
	
	; ENABLE FATIGUE
	int currentSetting_Fatigue = _Seed_Setting_SystemEnabled_Fatigue.GetValueInt()
	if initialSetting_Fatigue != currentSetting_Fatigue
		if currentSetting_Fatigue == 2
			GetFatigueSystem().StartSystem()
		else
			GetFatigueSystem().StopSystem()
		endif
	endif
	
	; ENABLE VITALITY
	int currentSetting_Vitality = _Seed_Setting_SystemEnabled_Vitality.GetValueInt()
	if initialSetting_Vitality != currentSetting_Vitality
		if currentSetting_Vitality == 2
			GetVitalitySystem().StartSystem()
		else
			GetVitalitySystem().StopSystem()
		endif
	endif	
	
	; DISABLE AUTO-EATING
	int currentSetting_AutoConsume = _Seed_Setting_AutoConsume.GetValueInt()
	if initialSetting_AutoConsume != currentSetting_AutoConsume && currentSetting_AutoConsume == 1
		GetConsumeManager().stopSystem()
	endif
	
	;DISABLE ALCOHOL
	int currentSetting_Alcohol = _Seed_Setting_AlcoholSystemEnabled.GetValueInt()
	if initialSetting_Alcohol != currentSetting_Alcohol && currentSetting_Alcohol == 1
		GetAlcoholSystem().stopSystem()
	endif
	
	;DISABLE SKOOMA
	int currentSetting_Skooma = _Seed_Setting_SkoomaSystemEnabled.GetValueInt()
	if initialSetting_Skooma != currentSetting_Skooma && currentSetting_Skooma == 1
		GetSkoomaSystem().stopSystem()
	endif
	
	; ENABLE FOLLOWER NEEDS
	int currentSetting_Followers = _Seed_Setting_SystemEnabled_FollowerNeeds.GetValueInt()
    if initialSetting_Followers != currentSetting_Followers
        if currentSetting_Followers == 3
			GetFollowerSystem().stopPartySystem()
			GetConsumeManagerParty().stopSystem()
            GetFollowerSystem().StartSystem()			
        Elseif currentSetting_Followers == 2
			GetFollowerSystem().stopSystem()
			GetConsumeManagerFollowers().StopSystem()
            GetFollowerSystem().StartPartySystem()
		else
			GetFollowerSystem().stopSystem()
			GetConsumeManagerFollowers().stopSystem()
            GetFollowerSystem().stopPartySystem()	
			GetConsumeManagerParty().stopSystem()			
        endif
    Endif

	;/TODO: REMOVE THIS
	int currentSetting_Followers = _Seed_Setting_SystemEnabled_FollowerNeeds.GetValueInt()
	if initialSetting_Followers != currentSetting_Followers
		if currentSetting_Followers == 2
			GetFollowerSystem().StartSystem()
		else
			GetFollowerSystem().StopSystem()
		endif
	endif
	/;
	
	; ENABLE PROGRESSIVE DISEASES
	int currentSetting_Disease = _Seed_Setting_DiseaseType.GetValueInt()
	if initialSetting_Disease != currentSetting_Disease
		if currentSetting_Disease == 2
			GetDiseaseSystem().StartSystem()
		else
			GetDiseaseSystem().StopSystem()
		endif
	endif
	
	; ENABLE ADDITIONAL Diseases
	int currentSetting_AdditionalDiseases = _Seed_SettingAdditionalDiseases.GetValueInt()
	if initialSetting_AdditionalDiseases != currentSetting_AdditionalDiseases
		if currentSetting_AdditionalDiseases == 2
			getDiseaseHitMonitor().start()
		else
			getDiseaseHitMonitor().stop()
		endif
	endif
	
	;ENABLE POTION CURES
	int currentSetting_DiseasePotionsCure = _Seed_Setting_DiseasePotionsCure.GetValueInt()
	if initialSetting_DiseasePotionsCure != currentSetting_DiseasePotionsCure
		SeedUtil.GetVendorStockSystem().setPotionLeveledListsFromSetting()
	endif
		
	;UPDATE MOVEMENT
	int currentSetting_Movement = _Seed_Setting_ThirstAffectsMovement.GetValueInt()
	if initialSetting_Movement != currentSetting_Movement
		GetHungerSystem().ApplyAttributeLevel(GetPlayerHungerLevel(), false)
		GetThirstSystem().ApplyAttributeLevel(GetPlayerThirstLevel(), false)
		GetFatigueSystem().ApplyAttributeLevel(GetPlayerFatigueLevel(), false)
		GetVitalitySystem().ApplyAttributeLevel(GetPlayerVitalityLevel(), false)
	endif
	
	;RESET TUTORIALS
	if _Seed_Setting_ResetTutorials.getValueInt() == 2
		_Seed_HelpDone_Focus.SetValueInt(1)
		_Seed_HelpDone_Variety.SetValueInt(1)
		_Seed_HelpDone_Skooma.setValue(1)
		_Seed_HelpDone_Disease.setValue(1)
		_Seed_HelpDone_PoorSleep.setValue(1)
		_Seed_HelpDone_Waterskins.setValue(1)
		_Seed_HelpDone_Food.setValue(1)
		_Seed_HelpDone_Alcohol.setValue(1)
		_Seed_HelpDone_SkoomaDrank.setValue(1)
		_Seed_HelpDone_Stew.setValue(1)
		_Seed_HelpDone_DangerousFood.setValue(1)
	
		_Seed_Setting_ResetTutorials.setValue(1)
		_Seed_Help_Reset.show()
	endif
	
	;RESET FOODLISTS
	if _Seed_Setting_ResetFoodLists.getValueInt() == 2
		;Show start message
		_Seed_ResettingFormlists_Start.show()
		
		;Reset Formlists
		GetFoodDatastoreHandler().ResetAllFormLists()
		GetFoodDatastoreHandler().resetMultiPartFood_Array()
		
		;Add food from other mods
		GetFoodDatastoreHandler().addFrostfall()
		GetFoodDatastoreHandler().addCACO()
		GetFoodDatastoreHandler().addBruma()
		GetFoodDatastoreHandler().addRequiem()
		GetFoodDatastoreHandler().addHunterborn()
		; GetFoodDatastoreHandler().AddHunterbornSoups()
		GetFoodDatastoreHandler().addApothecary()
		GetFoodDatastoreHandler().addCRF()
		GetFoodDatastoreHandler().addCCFishing()
		GetFoodDatastoreHandler().addUSSEP()
		GetFoodDatastoreHandler().addWintersun()
		GetFoodDatastoreHandler().addBetterVampiresBloodPotions()
		GetFoodDatastoreHandler().AddFoodExpanded()
		GetFoodDatastoreHandler().AddCookingExpanded()
		GetFoodDatastoreHandler().AddWarmDrinks()
		GetFoodDatastoreHandler().AddProjectAho()
		GetFoodDatastoreHandler().AddInterestingNPCs()
		GetFoodDatastoreHandler().AddImmersiveEncounters()
		GetFoodDatastoreHandler().AddWyrmstooth()
		GetFoodDatastoreHandler().AddFalskaar()
		GetFoodDatastoreHandler().AddNordicCooking()
		GetFoodDatastoreHandler().AddMealtime()
		GetFoodDatastoreHandler().AddSAFO()										   						 
		
		;Finish Up
		_Seed_Setting_ResetFoodLists.setValue(1)
		_Seed_ResettingFormlists_Finish.show()
	endif
		
	;STOP ANIMATIONS
	int currentSetting_AnimatePlayer = _Seed_Setting_AnimatePlayer.GetValueInt()
	int currentSetting_AnimateFollowers = _Seed_Setting_AnimateFollowers.GetValueInt()
	if currentSetting_AnimatePlayer != InitialSetting_AnimatePlayer && currentSetting_AnimatePlayer == 1
		GetAnimationHandler().stopAnimation(Game.GetPlayer(), 0)
	endif
	if currentSetting_AnimateFollowers != InitialSetting_AnimateFollowers && currentSetting_AnimateFollowers == 1
		stopAnimationFollowers()
	endif
	
	; ENABLE REGENERATION MONITORING
	int currentSetting_NeedsAffectedByRegeneration = _Seed_Setting_NeedsAffectedByRegeneration.GetValueInt()	
	if initialSetting_NeedsAffectedByRegeneration != currentSetting_NeedsAffectedByRegeneration && currentSetting_NeedsAffectedByRegeneration == 2
		GetHungerSystem().startMonitoringRegeneration()
		GetThirstSystem().startMonitoringRegeneration()
		GetFatigueSystem().startMonitoringRegeneration()
		GetFollowerSystem().GetHungerSystem(1).startMonitoringRegeneration()
		GetFollowerSystem().GetHungerSystem(2).startMonitoringRegeneration()
		GetFollowerSystem().GetHungerSystem(3).startMonitoringRegeneration()
		GetFollowerSystem().GetThirstSystem(1).startMonitoringRegeneration()
		GetFollowerSystem().GetThirstSystem(2).startMonitoringRegeneration()
		GetFollowerSystem().GetThirstSystem(3).startMonitoringRegeneration()
	endif
	
	; SPOILAGE
	int currentSetting_Spoilage = _Seed_Setting_SpoilageEnable.GetValueInt()
	if initialSetting_Spoilage != currentSetting_Spoilage
		if currentSetting_Spoilage == 2	
			GetSpoilageSystem().StartSystem()		
		else
			GetSpoilageSystem().StopSystem()		
		endif
	endif
	
	bool isSKYUILoaded = Game.GetFormFromFile(0x01000814, "SkyUI_SE.esp")
	if(isSKYUILoaded == false)
		isSKYUILoaded = Game.GetFormFromFile(0x01000814, "SkyUI.esp")
	endif
	; LAST SEED ENABLED
	if (isSKYUILoaded)
		int currentlyRunning = LastSeedRunning.GetValueInt()
		if initiallyRunning != currentlyRunning
			if currentlyRunning == 2
				LastSeedRunning_KWCheck.SetValueInt(2)
				getMainSystem().StartLastSeed()
			else
				LastSeedRunning_KWCheck.SetValueInt(1)
				getMainSystem().StopLastSeed()			
			endif
		endif
	else
		int currentSetting_System = LastSeedStartingUp.GetValueInt()
		int currentlyRunning = LastSeedRunning.GetValueInt()
		if initialSetting_System != currentSetting_System
			if currentSetting_System == 1 && currentlyRunning == 2
				getMainSystem().stopLastSeed()
				LastSeedRunning.setValue(1)
			elseif currentSetting_System == 1 && currentlyRunning == 1
				getMainSystem().preStop()
			elseif currentSetting_System == 2 && currentlyRunning == 1
				if(_Seed_Setting_ForceStartMod.getValueInt() != 2)
					getMainSystem().preStart()			
				else
					getMainSystem().OnSleepStop(false)
				endif
			endif
			;Stop animations
			GetAnimationHandler().stopAnimation(Game.GetPlayer(), 0)
			stopAnimationFollowers()
		endif
	endif
	SeedDebug(0, "[ConfigurationHandler]: Finished Running onFinish")
endFunction

function stopAnimationFollowers()
		Actor follower1 = GetTrackedFollower(1)
		Actor follower2 = GetTrackedFollower(2)
		Actor follower3 = GetTrackedFollower(3)
		
		if follower1
			GetAnimationHandler().stopAnimation(follower1, 1)
		endif	
		if follower2
			GetAnimationHandler().stopAnimation(follower2, 2)
		endif
		if follower3
			GetAnimationHandler().stopAnimation(follower3, 3)
		endif
endFunction

function setPresets(int option)
	;Just for Fun:
	if option == 1
		; Hunger, thirst and fatigue Rate 	0.75x
		_Seed_Setting_RateMulti_Hunger.setValue(0.7)
		_Seed_Setting_RateMulti_Thirst.setValue(0.7)
		_Seed_Setting_RateMulti_Fatigue.setValue(0.7)
		; Automatic Eating and Drinking 	Enabled
		_Seed_Setting_AutoConsume.setValue(2)
		; Vitality System 	Disabled
		_Seed_Setting_SystemEnabled_Vitality.setValue(1)
		; Food Spoilage 	Disabled
		_Seed_Setting_SpoilageEnable.setValue(1)
		; Spoiled food found in containers 	Never
		_Seed_Setting_ContainerSpoilageEnable.setValue(1)
		; Follower Needs 	Disabled
		_Seed_Setting_SystemEnabled_FollowerNeeds.setValue(1)
		
		; Progressive Diseases	Disabled
		_Seed_Setting_DiseaseType.SetValue(1)
		; Cure Disease Potion Mode 	Generic
		_Seed_Setting_DiseasePotionsCure.SetValue(1)
		; Shrines Don't Cure Diseases	Disabled
		_Seed_Setting_ShrinesCure.SetValue(2)
		; Diminishing Returns	Disabled
		_Seed_Setting_DiminishingFoodReturns.SetValue(1)
		; Food Price and Weight	1
		_Seed_Setting_FoodWeightMulti.SetValue(1)
		_Seed_Setting_FoodPriceMulti.SetValue(1)
		
		;Sleep Affected by Needs and Location	Disabled
		_Seed_Setting_SleepAffectedByNeeds.setValue(1)
		_Seed_Setting_SleepAffectedByLocation.setValue(1)
	;Immersive Challenge:
	elseIf option == 2
		; Hunger, thirst and fatigue rate 	1.0x
		_Seed_Setting_RateMulti_Hunger.setValue(1)
		_Seed_Setting_RateMulti_Thirst.setValue(1)
		_Seed_Setting_RateMulti_Fatigue.setValue(1)
		
		; Automatic Eating and Drinking 	Disabled
		_Seed_Setting_AutoConsume.setValue(1)
		; Vitality System 	Enabled
		_Seed_Setting_SystemEnabled_Vitality.setValue(2)
		; Vitality Rate 	1.0x
		_Seed_Setting_RateMulti_Vitality.setValue(1)
		; Death when Vitality reaches 0 	Disabled
		_Seed_Setting_NoVitalityMode.setValue(1)
		; Food Spoilage 	Enabled
		_Seed_Setting_SpoilageEnable.setValue(2)
		; Spoiled food found in containers 	Sometimes
		_Seed_Setting_ContainerSpoilageEnable.setValue(2)
		_Seed_Setting_ContainerSpoilageRate.setValue(50)
		; Follower Needs 	Enabled
		_Seed_Setting_SystemEnabled_FollowerNeeds.setValue(3)
		
		;Sleep Affected by Needs and Location	Enabled
		_Seed_Setting_SleepAffectedByNeeds.setValue(2)
		_Seed_Setting_SleepAffectedByLocation.setValue(2)
		
		; Progressive Diseases	Enabled
		_Seed_Setting_DiseaseType.SetValue(2)
		
		; Cure Disease Potion Mode	Specific
		_Seed_Setting_DiseasePotionsCure.SetValue(2)
		; Shrines Don't Cure Diseases	Enabled
		_Seed_Setting_ShrinesCure.SetValue(2)
		; Diminishing Returns	Enabled
		_Seed_Setting_DiminishingFoodReturns.SetValue(2)
		
		;Spoilage Rates
		_Seed_Setting_SpoilRate01_Bread.SetValue(168.0)
		_Seed_Setting_SpoilRate02_RawMeat.SetValue(48.0)
		_Seed_Setting_SpoilRate03_CookedMeat.SetValue(96.0)
		_Seed_Setting_SpoilRate04_RawSmallGame.SetValue(48.0)
		_Seed_Setting_SpoilRate05_CookedSmallGame.SetValue(96.0)
		_Seed_Setting_SpoilRate06_RawFish.SetValue(48.0)
		_Seed_Setting_SpoilRate07_CookedFish.SetValue(96.0)
		_Seed_Setting_SpoilRate08_RawSeafood.SetValue(48.0)
		_Seed_Setting_SpoilRate09_CookedSeafood.SetValue(96.0)
		_Seed_Setting_SpoilRate10_Vegitables.SetValue(168.0)
		_Seed_Setting_SpoilRate11_Fruit.SetValue(168.0)
		_Seed_Setting_SpoilRate12_Cheese.SetValue(168.0)
		_Seed_Setting_SpoilRate13_Treats.SetValue(168.0)
		_Seed_Setting_SpoilRate14_Pastry.SetValue(168.0)
		_Seed_Setting_SpoilRate15_Stew.SetValue(168.0)
		_Seed_Setting_SpoilRate16_CheeseBowls.SetValue(168.0)
		_Seed_Setting_SpoilRate17_Milk.SetValue(120.0)
		
		; Food Price and Weight	1
		_Seed_Setting_FoodWeightMulti.SetValue(1)
		_Seed_Setting_FoodPriceMulti.SetValue(1)
	elseIf option == 3
		; Hunger, thirst and fatigue rate 	1.0x
		_Seed_Setting_RateMulti_Hunger.setValue(1)
		_Seed_Setting_RateMulti_Thirst.setValue(1)
		_Seed_Setting_RateMulti_Fatigue.setValue(1)
		
		; Automatic Eating and Drinking 	Disabled
		_Seed_Setting_AutoConsume.setValue(1)
		; Vitality System 	Enabled
		_Seed_Setting_SystemEnabled_Vitality.setValue(2)
		; Vitality Rate 	1.5x
		_Seed_Setting_RateMulti_Vitality.setValue(1.5)
		; Death when Vitality reaches 0 	Enabled
		_Seed_Setting_NoVitalityMode.setValue(2)
		; Food Spoilage 	Enabled
		_Seed_Setting_SpoilageEnable.setValue(2)
		; Spoiled food found in containers 	Often
		_Seed_Setting_ContainerSpoilageEnable.setValue(2)
		_Seed_Setting_ContainerSpoilageRate.setValue(75)
		; Follower Needs 	Enabled
		_Seed_Setting_SystemEnabled_FollowerNeeds.setValue(3)
		
		; Progressive Diseases	Enabled
		_Seed_Setting_DiseaseType.SetValue(2)
		; Cure Disease Potion Mode 	No Cure
		_Seed_Setting_DiseasePotionsCure.SetValue(3)
		; Shrines Don't Cure Diseases	Enabled
		_Seed_Setting_ShrinesCure.SetValue(2)
		; Diminishing Returns	Enabled
		_Seed_Setting_DiminishingFoodReturns.SetValue(2)
		
		;Sleep Affected by Needs and Location	Enabled
		_Seed_Setting_SleepAffectedByNeeds.setValue(2)
		_Seed_Setting_SleepAffectedByLocation.setValue(2)
		
		;Spoilage Rates
		_Seed_Setting_SpoilRate01_Bread.SetValue(120.0)
		_Seed_Setting_SpoilRate02_RawMeat.SetValue(24.0)
		_Seed_Setting_SpoilRate03_CookedMeat.SetValue(60.0)
		_Seed_Setting_SpoilRate04_RawSmallGame.SetValue(24.0)
		_Seed_Setting_SpoilRate05_CookedSmallGame.SetValue(60.0)
		_Seed_Setting_SpoilRate06_RawFish.SetValue(24.0)
		_Seed_Setting_SpoilRate07_CookedFish.SetValue(60.0)
		_Seed_Setting_SpoilRate08_RawSeafood.SetValue(24.0)
		_Seed_Setting_SpoilRate09_CookedSeafood.SetValue(60.0)
		_Seed_Setting_SpoilRate10_Vegitables.SetValue(120.0)
		_Seed_Setting_SpoilRate11_Fruit.SetValue(120.0)
		_Seed_Setting_SpoilRate12_Cheese.SetValue(120.0)
		_Seed_Setting_SpoilRate13_Treats.SetValue(168.0)
		_Seed_Setting_SpoilRate14_Pastry.SetValue(120.0)
		_Seed_Setting_SpoilRate15_Stew.SetValue(168.0)
		_Seed_Setting_SpoilRate16_CheeseBowls.SetValue(120.0)
		_Seed_Setting_SpoilRate17_Milk.SetValue(120.0)
		
		; Food Price and Weight	2
		_Seed_Setting_FoodWeightMulti.SetValue(2)
		_Seed_Setting_FoodPriceMulti.SetValue(2)
	endif
endFunction

