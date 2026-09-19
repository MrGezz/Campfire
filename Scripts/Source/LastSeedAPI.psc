scriptname LastSeedAPI extends Quest

_Seed_Main property Main auto											;_Seed_MainQuest "Last Seed Main Quest" [QUST:07000D72]
_Seed_VitalitySystem property Vitality auto								;_Seed_VitalitySystemQuest "Vitality System" [QUST:07004FC2]
_Seed_HungerSystem property Hunger auto									;_Seed_HungerSystemQuest "Hunger System" [QUST:070029CC]
_Seed_ThirstSystem property Thirst auto									;_Seed_ThirstSystemQuest "Thirst System" [QUST:070029D5]
_Seed_FatigueSystem property Fatigue auto								;_Seed_FatigueSystemQuest "Fatigue System" [QUST:070029D2]
_Seed_AlcoholSystem property Alcohol auto								;_Seed_AlcoholSystemQuest "Alcohol System" [QUST:060108E7]
_Seed_SkoomaSystem property Skooma auto									;_Seed_SkoomaSystemQuest "Skooma System" [QUST:062A6C31]
_Seed_DiseaseManager property Disease auto								;_Seed_DiseaseManagerQuest "Disease Handler" [QUST:060108E8]
;_Seed_ConsumeManager property AutoConsume auto							;_Seed_ConsumeMangerQuest "AutoConsume Manager" [QUST:06083E0D]
_Seed_ConsumeManagerPlayer property AutoConsumePlayer auto				;_Seed_ConsumeMangerPlayerQuest "Player AutoConsume Manager" [QUST:06083E0D]
_Seed_ConsumeManagerFollowers property AutoConsumeFollowers auto		;_Seed_ConsumeMangerFollowersQuest "Follower AutoConsume Manager" [QUST:062468CD]
_Seed_ConsumeManagerParty property AutoConsumeParty auto				;_Seed_ConsumeMangerFollowersQuest "Follower AutoConsume Manager" [QUST:062468CD]
_Seed_VitalityMeterInterfaceHandler property VitalityMeterHandler auto	;_Seed_VitalityMeterQuest "Vitality Meter" [QUST:07004FC3]
_Seed_HungerMeterInterfaceHandler property HungerMeterHandler auto		;_Seed_HungerMeterQuest "Hunger Meter" [QUST:07003F99]
_Seed_FollowerNeedsSystem property Followers auto						;_Seed_FollowerNeedsSystemQuest "Follower Needs System" [QUST:060CFD35]
_Seed_CustomiseFoodHandler property CustomiseFood auto					;_Seed_CustomiseFoodHandlerQuest "Customise Food Handler Quest" [QUST:06116B56]
_Seed_ThirstMeterInterfaceHandler property ThirstMeterHandler auto		;_Seed_ThirstMeterQuest "Thirst Meter" [QUST:06004A5E]
_Seed_FatigueMeterInterfaceHandler property FatigueMeterHandler auto	;_Seed_FatigueMeterQuest
_Seed_FoodDatastoreHandler property FoodDatastore auto					;_Seed_FoodDatastoreHandlerQuest "Food Datastore Handler" [QUST:0700B6CD]
_Seed_FoodMaintenanceHandler property FoodMaintenance auto				;_Seed_FoodMaintenanceHandlerQuest "Food Datastore Handler" [QUST:06575D0F]
_Seed_SpoilSystem property Spoil auto									;_Seed_SpoilSystemQuest "Food Spoil System" [QUST:07000D68]
_Seed_Compatibility property Compatibility auto							;_Seed_MainQuest "Last Seed Main Quest" [QUST:07000D72] / Aliases
_Seed_DialogHandler property Dialog auto								;_Seed_DialogHandlerQuest "DialogHandler" [QUST:06158876]
_Seed_MonsterHandler property Monster auto								;_Seed_MonsterHandlerQuest "Disease Handler" [QUST:061D722E]
_Seed_ConfigurationHandler property Config auto							;_Seed_ConfigurationHandlerQuest "Configuration Handler" [QUST:06250AD0]
_Seed_AnimationHandler property Animation auto							;_Seed_AnimationHandlerQuest "Animation Handler" [QUST:0627420D]
_Seed_TranslationHandler property Translation auto						;_Seed_TranslationHandlerQuest "Translation Handler" [QUST:062F2BA5]
_Seed_WaterHandler property Water auto									;_Seed_WaterHandlerQuest "Water Handler" [QUST:0632A6ED]
_Seed_VendorStock property Vendor auto									;_Seed_VendorQuest "Vendor Quest" [QUST:0653909B]
_Seed_RescueSystem property Rescue auto									;_Seed_RescueSystemQuest "Rescue System" [QUST:0655C7CE]
_Seed_ActivatorHandler property Activators auto							;_Seed_ActivatorHandlerQuest "Misc Activator Handler" [QUST:065F47F1]

Quest property HitMonitor auto											;_Seed_DiseaseHitMonitorQuest "Disease Hit Monitor" [QUST:0659E53F]

_Seed_HungerSystem_Party property HungerParty auto						;_Seed_HungerSystemQuest_Party "Hunger System" [QUST:063C763B]
_Seed_ThirstSystem_Party property ThirstParty auto						;_Seed_ThirstSystemQuest_Party "Thirst System" [QUST:063D1843]

_Seed_SkillTreeHandler property SkillTree auto							;_Seed_SkillTreeHandlerQuest "SkillTreeHandler" [QUST:064A11E1]

ReferenceAlias property EventEmitter_LastSeedLoaded auto				;_Seed_EventEmitter_LastSeedLoaded [QUST:0700A698]
ReferenceAlias property EventEmitter_OnRescuePlayer auto				;_Seed_EventEmitter_OnRescuePlayer [QUST:075576AD]

;TODO: Add API Version Global Variable
GlobalVariable property _Seed_APIVersion auto
GlobalVariable property _Seed_LastSeedVersion auto
GlobalVariable property _Seed_IsPlayerFocused auto

GlobalVariable property _Seed_HungerLevel auto
GlobalVariable property _Seed_ThirstLevel auto
GlobalVariable property _Seed_FatigueLevel auto
GlobalVariable property _Seed_VitalityLevel auto
GlobalVariable property _Seed_AlcoholLevel auto
GlobalVariable property _Seed_SkoomaLevel auto
GlobalVariable property _Camp_IsSpecialEdition auto

GlobalVariable property _Seed_HungerLevel_Party auto					;TODO
GlobalVariable property _Seed_ThirstLevel_Party auto

GlobalVariable property LastSeedRunning auto							;TODO

Formlist property _Seed_OblivionLocations auto
Formlist property _Seed_OblivionAreas auto
Formlist property _Seed_OblivionCells auto

Actor property PlayerRef auto
