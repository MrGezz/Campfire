scriptname _Seed_FoodDatastoreHandler extends Quest
{ This script handles the lookup and storage of food data. Actual 
  hunger / thirst / spoilage logic is handled by their requisite
  systems. }

;/
	Food Datastore - NOT CURRENTLY USED
	
	The store is an 8-array Linked Array that stores data using
	the pattern [WholeFood, ResultFood, QuantityFood, ...]
/;

import utility
import SeedUtil
import CampUtil
import _SeedInternal
import StringUtil

;Multi-Part String Properties - NOT CURRENTLY USED
;/
String[] property multiFoodList auto hidden
String seperator = "|"
/;

; Multi-Part Array Properties
Potion[] property multiFoodList_WholeFood auto hidden
Potion[] property multiFoodList_WholeFood_2 auto hidden
Potion[] property multiFoodList_WholeFood_3 auto hidden
Potion[] property multiFoodList_WholeFood_4 auto hidden
Potion[] property multiFoodList_ResultFood auto hidden
Potion[] property multiFoodList_ResultFood_2 auto hidden
Potion[] property multiFoodList_ResultFood_3 auto hidden
Potion[] property multiFoodList_ResultFood_4 auto hidden
int[] property multiFoodList_Quantity auto hidden
int[] property multiFoodList_Quantity_2 auto hidden
int[] property multiFoodList_Quantity_3 auto hidden
int[] property multiFoodList_Quantity_4 auto hidden

FormList[] property foodLists auto hidden
FormList[] property foodRestoreAmount auto hidden
FormList[] property AlcoholType auto hidden
Potion[] property Quantities auto hidden
Potion[] property spoiledVersions auto hidden
FormList property _Seed_SpoiledFoods auto

FormList property _Seed_Food_RestoreHungerMinor auto
FormList property _Seed_Food_RestoreHungerMajor auto
FormList property _Seed_Food_RestoreHungerSuperior auto
FormList property _Seed_Food_RestoreHungerMassive auto
FormList property _Seed_Food_RestoreHungerMinorBASE auto
FormList property _Seed_Food_RestoreHungerMajorBASE auto
FormList property _Seed_Food_RestoreHungerSuperiorBASE auto
FormList property _Seed_Food_RestoreHungerMassiveBASE auto

FormList property _Seed_DrinkAlcoholicAle auto
FormList property _Seed_DrinkAlcoholicWine auto
FormList property _Seed_DrinkAlcoholicSpirit auto
FormList property _Seed_DrinkAlcoholicAleBASE auto
FormList property _Seed_DrinkAlcoholicWineBASE auto
FormList property _Seed_DrinkAlcoholicSpiritBASE auto

FormList property _Seed_DrinkSkoomaWeak auto
FormList property _Seed_DrinkSkoomaStrong auto
FormList property _Seed_DrinkSkoomaWeakBASE auto
FormList property _Seed_DrinkSkoomaStrongBASE auto

FormList property _Seed_DrinkWater auto

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
FormList property _Seed_SystemFoods auto

FormList property _Seed_BreadBASE auto
FormList property _Seed_MeatRawBASE auto
FormList property _Seed_MeatCookedBASE auto
FormList property _Seed_SmallGameRawBASE auto
FormList property _Seed_SmallGameCookedBASE auto
FormList property _Seed_FishRawBASE auto
FormList property _Seed_FishCookedBASE auto
FormList property _Seed_SeafoodRawBASE auto
FormList property _Seed_SeafoodCookedBASE auto
FormList property _Seed_VegetablesBASE auto
FormList property _Seed_FruitBASE auto
FormList property _Seed_CheeseBASE auto
FormList property _Seed_TreatsBASE auto
FormList property _Seed_PastriesBASE auto
FormList property _Seed_StewsBASE auto
FormList property _Seed_CheeseBowlsBASE auto
FormList property _Seed_DrinkMilkBASE auto
FormList property _Seed_DrinkAlcoholicBASE auto
FormList property _Seed_DrinkNonAlcoholicBASE auto
FormList property _Seed_PreservedBASE auto
FormList property _Seed_SaltedFoodBASE auto
FormList property _Seed_NotFoodBASE auto
FormList property _Seed_FoodMiscObjects auto

FormList property _Camp_ModWaterSkins auto

FormList property _Seed_BloodPotions auto
FormList property _Seed_BloodPotionsBASE auto

Potion property _Seed_Spoiled_Bread auto
Potion property _Seed_Spoiled_MeatRaw auto
Potion property _Seed_Spoiled_MeatCooked auto
Potion property _Seed_Spoiled_SmallGameRaw auto
Potion property _Seed_Spoiled_SmallGameCooked auto
Potion property _Seed_Spoiled_FishRaw auto
Potion property _Seed_Spoiled_FishCooked auto
Potion property _Seed_Spoiled_SeafoodRaw auto
Potion property _Seed_Spoiled_SeafoodCooked auto
Potion property _Seed_Spoiled_Vegetable auto
Potion property _Seed_Spoiled_Fruit auto
Potion property _Seed_Spoiled_Cheese auto
Potion property _Seed_Spoiled_Treat auto
Potion property _Seed_Spoiled_Pastry auto
Potion property _Seed_Spoiled_Stew auto
Potion property _Seed_Spoiled_CheeseBowl auto
Potion property _Seed_Spoiled_Milk auto
MiscObject property _Seed_PerishedFood auto

Potion property TGTQ02BalmoraBlue auto

Keyword property VendorItemFood auto
Keyword property VendorItemFoodRaw auto

Keyword property _Seed_PO3_Detection auto
Keyword property _Seed_PO3_Detection_HungerLight auto
Keyword property _Seed_PO3_Detection_HungerMedium auto
Keyword property _Seed_PO3_Detection_HungerFilling auto
Keyword property _Seed_PO3_Detection_HungerHearty auto
Keyword property _Seed_PO3_Detection_Thirst auto
Keyword property _Seed_PO3_Detection_AlcoholWeak auto
Keyword property _Seed_PO3_Detection_AlcoholModerate auto
Keyword property _Seed_PO3_Detection_AlcoholStrong auto
Keyword property _Seed_PO3_Detection_SkoomaWeak auto
Keyword property _Seed_PO3_Detection_SkoomaStrong auto
Keyword property _Seed_PO3_Detection_Preserved auto
Keyword property _Seed_PO3_Detection_Salted auto
Keyword property _Seed_PO3_Detection_NotFood auto

Keyword property _Seed_PO3_Detection_Bread auto
Keyword property _Seed_PO3_Detection_MeatRaw auto
Keyword property _Seed_PO3_Detection_MeatCooked auto
Keyword property _Seed_PO3_Detection_SmallGameRaw auto
Keyword property _Seed_PO3_Detection_SmallGameCooked auto
Keyword property _Seed_PO3_Detection_FishRaw auto
Keyword property _Seed_PO3_Detection_FishCooked auto
Keyword property _Seed_PO3_Detection_SeafoodRaw auto
Keyword property _Seed_PO3_Detection_SeafoodCooked auto
Keyword property _Seed_PO3_Detection_Vegetables auto
Keyword property _Seed_PO3_Detection_Fruit auto
Keyword property _Seed_PO3_Detection_Cheese auto
Keyword property _Seed_PO3_Detection_Treats auto
Keyword property _Seed_PO3_Detection_Pastries auto
Keyword property _Seed_PO3_Detection_Stews auto
Keyword property _Seed_PO3_Detection_CheeseBowls auto
Keyword property _Seed_PO3_Detection_DrinkMilk auto
Keyword property _Seed_PO3_Detection_DrinkAlcoholic auto
Keyword property _Seed_PO3_Detection_DrinkNonAlcoholic auto



; Original Multi-Part Properties - NOT CURRENTLY USED
Potion property _Seed_Quantity01 auto
Potion property _Seed_Quantity02 auto
Potion property _Seed_Quantity03 auto
Potion property _Seed_Quantity04 auto
Potion property _Seed_Quantity05 auto
Potion property _Seed_Quantity06 auto
Potion property _Seed_Quantity07 auto
Potion property _Seed_Quantity08 auto
Potion property _Seed_Quantity09 auto
Potion property _Seed_Quantity10 auto
Potion property _Seed_Quantity11 auto
Potion property _Seed_Quantity12 auto
Potion property _Seed_Quantity13 auto
Potion property _Seed_Quantity14 auto
Potion property _Seed_Quantity15 auto
Potion property _Seed_Quantity16 auto
Potion property _Seed_Quantity17 auto
Potion property _Seed_Quantity18 auto
Potion property _Seed_Quantity19 auto
Potion property _Seed_Quantity20 auto
Potion[] multiPartFoodData1
Potion[] multiPartFoodData2
Potion[] multiPartFoodData3
Potion[] multiPartFoodData4
Potion[] multiPartFoodData5
Potion[] multiPartFoodData6
Potion[] multiPartFoodData7
Potion[] multiPartFoodData8

; Multi-Food Items
Potion property FoodBread01A auto			; Bread Loaf
Potion property FoodBread01B auto			; Bread
Potion property FoodCheeseWheel01A auto		; Goat Cheese Wheel
Potion property FoodCheeseWheel01B auto		; Sliced Goat Cheese Wheel
Potion property FoodCheeseWedge01 auto		; Goat Cheese Wedge
Potion property FoodCheeseWheel02A auto		; Eidar Cheese Wheel
Potion property FoodCheeseWheel02B auto		; Sliced Eidar Cheese Wheel
Potion property FoodCheeseWedge02 auto		; Eidar Cheese Wedge
Potion property _Seed_Waterskin1 auto		; Waterskin of Dirty Water, Nearly Empty
Potion property _Seed_Waterskin2 auto		; Waterskin of Dirty Water, Mostly Full
Potion property _Seed_Waterskin3 auto		; Waterskin of Dirty Water, Full
Potion property _Seed_Waterskin1Clean auto	; Waterskin of Clean Water, Nearly Empty
Potion property _Seed_Waterskin2Clean auto	; Waterskin of Clean Water, Mostly Full
Potion property _Seed_Waterskin3Clean auto	; Waterskin of Clean Water, Full
Potion property _Seed_WaterskinEmpty auto	; Empty Waterskin
Potion property _Seed_WaterskinSea auto		; Waterskin, Seawater
Potion property _Seed_WaterskinSnow auto	; Waterskin, Snow

Potion Property _Seed_WaterBottleEmpty Auto
Potion Property _Seed_WaterBottle Auto
Potion Property _Seed_WaterBottleClean Auto
Potion Property _Seed_WaterBottleSea Auto
Potion Property _Seed_WaterBottleSnow Auto

potion property Ale auto 								; "Ale" [ALCH:00034C5E]
potion property AleWhiterunQuest auto 					; "Argonian Ale" [ALCH:0009380D]
potion property DLC2FoodAshfireMead auto 				; "Ashfire Mead" [ALCH:0403572F]
potion property FoodBlackBriarMead auto 				; "Black-Briar Mead" [ALCH:0002C35A]
potion property FoodBlackBriarMeadPrivateReserve auto 	; "Black-Briar Reserve" [ALCH:000F693F]
potion property FoodMead auto 							; "Nord Mead" [ALCH:00034C5D]
potion property FreeformDragonBridgeMead auto 			; "Dragon's Breath Mead" [ALCH:000555E8]
potion property MQ101JuniperMead auto 					; "Mead with Juniper Berry" [ALCH:00107A8A]
potion property FoodHonningbrewMead auto 				; "Honningbrew Mead" [ALCH:000508CA]

Potion property FoodHoney auto				; Honey
Potion property BYOHFoodFlour auto			; Flour
Potion property BYOHFoodButter auto			; Butter
Potion property _Seed_CookingWater auto		; Broth
Potion property _Seed_TestFood auto			; Food for weight and price check on load
Potion property _Seed_RiverWater auto		; For drinking from streams

;CACO Changed Food
Potion property FirebrandWine auto		; FirebrandWine "Firebrand Wine" [ALCH:0001895F]
Potion property FoodWineAlto auto	;FoodWineAlto "Alto Noir Wine" [ALCH:0003133B]
Potion property FoodWineAltoA auto		;FoodWineAltoA "Alto Blanc Wine" [ALCH:000C5349]
Potion property FoodWineBottle02 auto		;FoodWineBottle02 "Village Red Wine" [ALCH:0003133C]
Potion property FoodWineBottle02A auto		;FoodWineBottle02A "Village White Wine" [ALCH:000C5348]
Potion property MQ201Drink auto		;MQ201Drink "Colovian Brandy" [ALCH:00036D53]
Potion property BYOHFoodWineBottle03 auto		;BYOHFoodWineBottle03 "Surilie Brothers Wine" [ALCH:03003536]
Potion property BYOHFoodWineBottle04 auto		;BYOHFoodWineBottle04 "Argonian Bloodwine" [ALCH:03003535]
Potion property DLC2Flin auto		;DLC2FoodDrinkFlin "Flin" [ALCH:040207E5]
Potion property DLC2Matze auto		;DLC2FoodDrinkMatze "Mazte" [ALCH:040248CE]
Potion property DLC2RRF04Sujamma auto		;DLC2FoodDrinkRRF04Sujamma "Sadri's Sujamma" [ALCH:04024E0B]
Potion property DLC2RRFavor01EmberbrandWine auto		;DLC2FoodDrinkRRFavor01EmberbrandWine "Emberbrand Wine" [ALCH:040320DF]
Potion property DLC2Shein auto		;DLC2Shein "Shein" [ALCH:040248CC]
Potion property DLC2Sujamma auto		;DLC2Sujamma "Sujamma" [ALCH:040207E6]
Potion property MS14WineAltoA auto		;MS14WineAltoA "Jessica's Wine" [ALCH:000F257E]
Potion property FoodSolitudeSpicedWine auto		;FoodSolitudeSpicedWine "Spiced Wine" [ALCH:00085368]
Potion property WEDL03CyrodilicBrandy auto		;WEDL03CyrodilicBrandy "Cyrodilic Brandy" [ALCH:000B91D7]
Potion property FavorSorexRum auto		;FavorSorexRum "Stros M'Kai Rum" [ALCH:000D055E]

Potion property FoodPie auto		;FoodPie "Apple Pie" [ALCH:00064B43]
Potion property FoodBeef auto		;FoodBeef "Raw Beef" [ALCH:00065C99]	
Potion property FoodHorkerMeat auto		;FoodHorkerMeat "Raw Horker Meat" [ALCH:00065C9B]	
Potion property FoodHorseMeat auto		;FoodHorseMeat "Raw Horse Meat" [ALCH:00065C9C]	
Potion property FoodVenison auto		;FoodVenison "Raw Venison" [ALCH:000669A2]	
Potion property FoodMammothMeat auto		;FoodMeatMammoth "Raw Mammoth Snout" [ALCH:000669A4]	
Potion property FoodGoatMeatCooked auto		;FoodGoatMeatCooked "Roast Goat" [ALCH:0007224C]	
Potion property FoodHorseMeatCooked auto		;FoodHorseMeatCooked "Roast Horse Haunch" [ALCH:000722B0]	
Potion property DLC2FoodBoarMeat auto		;DLC2FoodBoarMeat "Raw Boar Meat" [ALCH:0403BD14]	
Potion property DLC2FoodAshHopperMeat auto		;DLC2FoodAshHopperMeat "Raw Ash Hopper Meat" [ALCH:0403BD15]	
Potion property DLC2FoodBoarMeatCooked auto		;DLC2FoodBoarMeatCooked "Cured Boar Meat" [ALCH:0403CF72]	
Potion property FoodBeefCooked auto		;FoodBeefCooked "Cooked Beef" [ALCH:000721E8]
Potion property DLC1BloodPotion auto	;DLC1BloodPotion "Potion of Blood" [ALCH:02018EF3]


GlobalVariable property _Seed_RestoreHungerMinorAmount auto
GlobalVariable property _Seed_RestoreHungerMajorAmount auto
GlobalVariable property _Seed_RestoreHungerSuperiorAmount auto
GlobalVariable property _Seed_RestoreHungerMassiveAmount auto
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

GlobalVariable property _Seed_Setting_FoodPriceMulti auto
GlobalVariable property _Seed_Setting_FoodWeightMulti auto
GlobalVariable property _Seed_Setting_AddNames auto
GlobalVariable property _Seed_Settings_EnableWaterBottles auto															  

Message property _Seed_ImportCACO auto
Message property _Seed_ImportCACO_Done auto
Message Property _Seed_ImportApothecary auto
Message Property _Seed_ImportApothecary_Done auto
Message Property _Seed_ImportHunterborn auto
Message Property _Seed_ImportHunterborn_Done auto
Message Property _Seed_ImportHunterbornSoups auto
Message Property _Seed_ImportHunterbornSoups_Done auto
Message Property _Seed_ImportRequiem auto
Message Property _Seed_ImportRequiem_Done auto
Message Property _Seed_ImportBruma auto
Message Property _Seed_ImportBruma_Done	 auto
Message Property _Seed_ImportCCFish auto
Message Property _Seed_ImportCCFish_Done auto
Message Property _Seed_ErrorNoMultiPartSlots auto

Message Property _Seed_ImportWarmDrinks auto
Message Property _Seed_ImportWarmDrinks_Done auto
Message Property _Seed_ImportProjectAho auto
Message Property _Seed_ImportProjectAho_Done auto
Message Property _Seed_ImportSAFO auto
Message Property _Seed_ImportSAFO_Done auto
Message Property _Seed_ImportNordicCooking auto
Message Property _Seed_ImportNordicCooking_Done auto
Message Property _Seed_ImportMealtime auto
Message Property _Seed_ImportMealtime_Done auto

ObjectReference property _Seed_ProvisionsContainerRef Auto
GlobalVariable property _Seed_ProvisionsAddPortions auto
GlobalVariable property _Seed_ForceAddFoodToProvisions_CACO auto
GlobalVariable property _Seed_FoodListsSet auto
Actor property PlayerRef auto


;/
	System Management
/;

function StartSystem()	
	if !self.IsRunning()
		self.Start()
	endif
	If _Seed_FoodListsSet.getValue() as int != 2
		InitializeArrays()
		; CreateFoodKeywordValueMaps()
		addCampfireWaterskinsAll()
		initialiseMultiPartFood()
		ResetAllFormLists()
		_Seed_FoodListsSet.setValue(2)
	Endif
endFunction

function StopSystem()
	if self.IsRunning()
		self.Stop()
	endif
endFunction

function addToProvisions(Form multiPart, int aiCount, bool isFollower)
	if isFood(multiPart) && (_Seed_ProvisionsAddPortions.GetValueInt() == 2 || isFollower || getConsumeManager().isUpdating || _Seed_ForceAddFoodToProvisions_CACO.getValue() == 2)
		_Seed_ProvisionsContainerRef.AddItem(multiPart, aiCount, true)
		_Seed_ForceAddFoodToProvisions_CACO.setValue(1)
	else
		PlayerRef.AddItem(multiPart, aiCount, true)
	endif
endFunction

function setFoodProperties()
	if GetSKSELoaded() && _Seed_TestFood.GetGoldValue() == 1
		int amount = RandomInt(2, 10000)
		_Seed_TestFood.SetGoldValue(amount)
		
		;Add Keywords
		;/
		if SeedUtil.GetCompatibilitySystem().isPO3Loaded && isSpecialEdition()
			;Hunger
			; setPO3Keywords(_Seed_Food_RestoreHungerMinor, _Seed_PO3_Detection_HungerLight)
			; setPO3Keywords(_Seed_Food_RestoreHungerMajor, _Seed_PO3_Detection_HungerMedium)
			; setPO3Keywords(_Seed_Food_RestoreHungerSuperior, _Seed_PO3_Detection_HungerFilling)
			; setPO3Keywords(_Seed_Food_RestoreHungerMassive, _Seed_PO3_Detection_HungerHearty)
			
			;FoodTypes
			setPO3Keywords(_Seed_Bread, _Seed_PO3_Detection_Bread)
			setPO3Keywords(_Seed_MeatRaw, _Seed_PO3_Detection_MeatRaw)
			setPO3Keywords(_Seed_MeatCooked, _Seed_PO3_Detection_MeatCooked)
			setPO3Keywords(_Seed_SmallGameRaw, _Seed_PO3_Detection_SmallGameRaw)
			setPO3Keywords(_Seed_SmallGameCooked, _Seed_PO3_Detection_SmallGameCooked)
			setPO3Keywords(_Seed_FishRaw, _Seed_PO3_Detection_FishRaw)
			setPO3Keywords(_Seed_FishCooked, _Seed_PO3_Detection_FishCooked)
			setPO3Keywords(_Seed_SeafoodRaw, _Seed_PO3_Detection_SeafoodRaw)
			setPO3Keywords(_Seed_SeafoodCooked, _Seed_PO3_Detection_SeafoodCooked)
			setPO3Keywords(_Seed_Vegetables, _Seed_PO3_Detection_Vegetables)
			setPO3Keywords(_Seed_Fruit, _Seed_PO3_Detection_Fruit)
			setPO3Keywords(_Seed_Cheese, _Seed_PO3_Detection_Cheese)
			setPO3Keywords(_Seed_Treats, _Seed_PO3_Detection_Treats)
			setPO3Keywords(_Seed_Pastries, _Seed_PO3_Detection_Pastries)
			setPO3Keywords(_Seed_Stews, _Seed_PO3_Detection_Stews)
			setPO3Keywords(_Seed_CheeseBowls, _Seed_PO3_Detection_CheeseBowls)
			setPO3Keywords(_Seed_DrinkMilk, _Seed_PO3_Detection_DrinkMilk)
			setPO3Keywords(_Seed_DrinkAlcoholic, _Seed_PO3_Detection_DrinkAlcoholic)
			setPO3Keywords(_Seed_DrinkNonAlcoholic, _Seed_PO3_Detection_DrinkNonAlcoholic)


			; Add Preserved Food
			setPO3Keywords(_Seed_Preserved, _Seed_PO3_Detection_Preserved)
			; setPO3Keywords(_Seed_SaltedFood, _Seed_PO3_Detection_Salted)
			
			;Alcohol
			; setPO3Keywords(_Seed_DrinkAlcoholicAle, _Seed_PO3_Detection_AlcoholWeak)
			; setPO3Keywords(_Seed_DrinkAlcoholicWine, _Seed_PO3_Detection_AlcoholModerate)
			; setPO3Keywords(_Seed_DrinkAlcoholicSpirit, _Seed_PO3_Detection_AlcoholStrong)
			
			;Skooma
			; setPO3Keywords(_Seed_DrinkSkoomaWeak, _Seed_PO3_Detection_SkoomaWeak)
			; setPO3Keywords(_Seed_DrinkSkoomaStrong, _Seed_PO3_Detection_SkoomaStrong)
			
			
			;Add NotFood
			; setPO3Keywords(_Seed_NotFood, _Seed_PO3_Detection_NotFood)
		endif
		/;
		if _Seed_Setting_FoodPriceMulti.getValue() != 1
			setFoodPrice(_Seed_Bread, amount)
			setFoodPrice(_Seed_MeatRaw, amount)
			setFoodPrice(_Seed_MeatCooked, amount)
			setFoodPrice(_Seed_SmallGameRaw, amount)
			setFoodPrice(_Seed_SmallGameCooked, amount)
			setFoodPrice(_Seed_FishRaw, amount)
			setFoodPrice(_Seed_FishCooked, amount)
			setFoodPrice(_Seed_SeafoodRaw, amount)
			setFoodPrice(_Seed_SeafoodCooked, amount)
			setFoodPrice(_Seed_Vegetables, amount)
			setFoodPrice(_Seed_Fruit, amount)
			setFoodPrice(_Seed_Cheese, amount)
			setFoodPrice(_Seed_Treats, amount)
			setFoodPrice(_Seed_Pastries, amount)
			setFoodPrice(_Seed_Stews, amount)
			setFoodPrice(_Seed_CheeseBowls, amount)
			setFoodPrice(_Seed_DrinkMilk, amount)
			setFoodPrice(_Seed_DrinkAlcoholic, amount)
			setFoodPrice(_Seed_DrinkNonAlcoholic, amount)
			setFoodPrice(_Seed_FoodMiscObjects, amount)
		endif
		
		if _Seed_Setting_FoodWeightMulti.getValue() != 1
			setFoodWeight(_Seed_Bread, amount)
			setFoodWeight(_Seed_MeatRaw, amount)
			setFoodWeight(_Seed_MeatCooked, amount)
			setFoodWeight(_Seed_SmallGameRaw, amount)
			setFoodWeight(_Seed_SmallGameCooked, amount)
			setFoodWeight(_Seed_FishRaw, amount)
			setFoodWeight(_Seed_FishCooked, amount)
			setFoodWeight(_Seed_SeafoodRaw, amount)
			setFoodWeight(_Seed_SeafoodCooked, amount)
			setFoodWeight(_Seed_Vegetables, amount)
			setFoodWeight(_Seed_Fruit, amount)
			setFoodWeight(_Seed_Cheese, amount)
			setFoodWeight(_Seed_Treats, amount)
			setFoodWeight(_Seed_Pastries, amount)
			setFoodWeight(_Seed_Stews, amount)
			setFoodWeight(_Seed_CheeseBowls, amount)
			setFoodWeight(_Seed_DrinkMilk, amount)
			setFoodWeight(_Seed_DrinkAlcoholic, amount)
			setFoodWeight(_Seed_DrinkNonAlcoholic, amount)
			setFoodWeight(_Seed_FoodMiscObjects, amount)
		endif
		
		if _Seed_Setting_AddNames.getValue() == 2
			;/
			if SeedUtil.GetCompatibilitySystem().isPO3Loaded && isSpecialEdition()
				AddMagicEffectToFormList(_Seed_Food_RestoreHungerMinor, 0, amount)
				AddMagicEffectToFormList(_Seed_Food_RestoreHungerMajor, 1, amount)
				AddMagicEffectToFormList(_Seed_Food_RestoreHungerSuperior, 2, amount)
				AddMagicEffectToFormList(_Seed_Food_RestoreHungerMassive, 3, amount)
				
				; Add Drinks
				AddMagicEffectToFormList(_Seed_DrinkNonAlcoholic, 7, amount, true)
				AddMagicEffectToFormList(_Seed_DrinkMilk, 7, amount)
				AddMagicEffectToFormList(_Seed_DrinkAlcoholicAle, 7, amount)
				AddMagicEffectToFormList(_Seed_DrinkAlcoholicWine, 7, amount)
				AddMagicEffectToFormList(_Seed_DrinkAlcoholicSpirit, 7, amount)
				AddMagicEffectToFormList(_Seed_Stews, 7, amount)
				
				; Add Alcohol			
				AddMagicEffectToFormList(_Seed_DrinkAlcoholicAle, 4, amount)
				AddMagicEffectToFormList(_Seed_DrinkAlcoholicWine, 5, amount)
				AddMagicEffectToFormList(_Seed_DrinkAlcoholicSpirit, 6, amount)
				
				; Add Raw Food
				AddMagicEffectToFormList(_Seed_MeatRaw, 8, amount)
				AddMagicEffectToFormList(_Seed_SmallGameRaw, 8, amount)
				AddMagicEffectToFormList(_Seed_FishRaw, 8, amount)
				AddMagicEffectToFormList(_Seed_SeafoodRaw, 8, amount)
				
				; Add Preserved Food
				AddMagicEffectToFormList(_Seed_Preserved, 9, amount)
				AddMagicEffectToFormList(_Seed_SaltedFood, 10, amount)
				
				; Add Skooma
				AddMagicEffectToFormList(_Seed_DrinkSkoomaWeak, 11, amount)
				AddMagicEffectToFormList(_Seed_DrinkSkoomaStrong, 12, amount)		
			else
			/;
				AddNameType(_Seed_Food_RestoreHungerMinor, GetTranslationHandler().foodLight, amount)
				AddNameType(_Seed_Food_RestoreHungerMajor, GetTranslationHandler().foodMedium, amount)
				AddNameType(_Seed_Food_RestoreHungerSuperior, GetTranslationHandler().foodFilling, amount)
				AddNameType(_Seed_Food_RestoreHungerMassive, GetTranslationHandler().foodHearty, amount)
				
				AddNameType(_Seed_DrinkAlcoholicAle, GetTranslationHandler().drinkWeak, amount)
				AddNameType(_Seed_DrinkAlcoholicWine, GetTranslationHandler().drinkModerate, amount)
				AddNameType(_Seed_DrinkAlcoholicSpirit, GetTranslationHandler().drinkStrong, amount)
				
				AddNameType(_Seed_DrinkSkoomaWeak, GetTranslationHandler().drinkWeak, amount)
				AddNameType(_Seed_DrinkSkoomaStrong, GetTranslationHandler().drinkStrong, amount)
			;endif
		endif		
	endif
endFunction


Function setPO3Keywords(FormList FoodList, Keyword theKeyword, bool addMainKeyword = true)
	Int iIndex = FoodList.GetSize() as Int
	While iIndex > 0
		iIndex -= 1
		Form theFood = FoodList.GetAt(iIndex)
		If theFood
			if(addMainKeyword)
				if(!theFood.hasKeyword(_Seed_PO3_Detection))
					PO3_SKSEFunctions.AddKeywordToForm(theFood, _Seed_PO3_Detection)
				endif
			endif
			if(!theFood.hasKeyword(theKeyword))
				PO3_SKSEFunctions.AddKeywordToForm(theFood, theKeyword)
			endif
		EndIf
	EndWhile
EndFunction

bool function checkTestFoodPrice(int amount)
	if _Seed_TestFood.getGoldValue() == amount
		return true
	endif
	return false
endFunction

Function AddMagicEffectToFormList(FormList FoodList, int index, int testAmount, bool ignoreWater = false)
	if !checkTestFoodPrice(testAmount)
		return
	endif
	
	Int iIndex = FoodList.GetSize() as Int
	While iIndex > 0
		iIndex -= 1
		Potion theFood = FoodList.GetAt(iIndex) as Potion
		If theFood
			AddMagicEffect(theFood, index, ignoreWater)
		EndIf
	EndWhile
EndFunction

Function AddMagicEffect(potion theFood, int index, bool ignoreWater = false)	
	; Check for waterskins
	if ignoreWater && _Seed_DrinkWater.Find(theFood) != -1
		return
	endif
	
	;Add effect if it hasn't already been added
	magicEffect[] foodEffects = TheFood.GetMagicEffects()
	magicEffect effectToAdd = _Seed_TestFood.GetNthEffectMagicEffect(index)
	if foodEffects.RFind(effectToAdd) < 0
		PO3_SKSEFunctions.AddEffectItemToPotion(theFood, _Seed_TestFood, index)	
	endif
EndFunction

Function AddNameType(FormList FoodList, String type, int testAmount)
	Int iIndex = FoodList.GetSize() as Int
	While iIndex > 0
		if !checkTestFoodPrice(testAmount)
			return
		endif
		iIndex -= 1
		Form theFood = FoodList.GetAt(iIndex)
		If theFood
			string newName = theFood.GetName() + type
			TheFood.SetName(newName)
		EndIf
	EndWhile
EndFunction

Function AddNamePreserved()
	Int iIndex = _Seed_Preserved.GetSize() as Int
	While iIndex > 0
		iIndex -= 1
		Form theFood = _Seed_Preserved.GetAt(iIndex)
		If theFood
			string type = ", Preserved)"
			If _Seed_SaltedFood.Find(theFood) != -1
				type = ", Salted)"
			EndIf
			string name = theFood.GetName()
			string newName = Substring(name, 0, getLength(name) - 1) + type
			TheFood.SetName(newName)
		EndIf
	EndWhile
EndFunction



function setFoodPrice(FormList FoodList, int testAmount)
	SeedDebug(0, "[FoodDataStoreHandler]: Updating Prices for " + FoodList.getName())
	Int iIndex = FoodList.GetSize() as Int
	While iIndex > 0
		if !checkTestFoodPrice(testAmount)
			SeedDebug(0, "[FoodDataStoreHandler]: Aborting check.")
			return
		endif
		iIndex -= 1
		Form theFood = FoodList.GetAt(iIndex)
		If theFood
			int value = (theFood.GetGoldValue() * _Seed_Setting_FoodPriceMulti.getValue()) as int
			SeedDebug(0, "[FoodDataStoreHandler]: Setting gold value for " + theFood.getName() + ": " + value)
			theFood.SetGoldValue(value)
		EndIf
	EndWhile
endFunction

function setFoodWeight(FormList FoodList, int testAmount)
	Int iIndex = FoodList.GetSize() as Int
	While iIndex > 0
		if !checkTestFoodPrice(testAmount)
			return
		endif
		iIndex -= 1
		Form theFood = FoodList.GetAt(iIndex)
		If theFood
			theFood.SetWeight(theFood.GetWeight() *  _Seed_Setting_FoodWeightMulti.getValue())
		EndIf
	EndWhile
endFunction


function addRiverWater()
	_Seed_DrinkNonAlcoholic.addForm(_Seed_RiverWater)
endFunction

;MOD ADDED FOODS
function AddFrostfall(bool checkRequired = true)
	bool addFood = true
	if(checkRequired)
		addFood = SeedUtil.GetCompatibilitySystem().isFrostfallLoaded
	endif
	
	
	if addFood
		AddModFood(0x0001CEBD, "Frostfall.esp", _Seed_NotFood)	;_Frost_DrinkEffectPotion1 "Strong Brew" [ALCH:0301CEBD]
		AddModFood(0x0001CEBF, "Frostfall.esp", _Seed_NotFood)	;_Frost_DrinkEffectPotion2 "Strong Brew" [ALCH:0301CEBF]
		AddModFood(0x0001CEC1, "Frostfall.esp", _Seed_NotFood)	;_Frost_DrinkEffectPotion3 "Strong Brew" [ALCH:0301CEC1]
		AddModFood(0x0001D430, "Frostfall.esp", _Seed_NotFood)	;_Frost_WaterPotion "Snowberry Extract" [ALCH:0301D430]
		AddModFood(0x03066B5F, "Frostfall.esp", _Seed_NotFood)	;_Frost_FoodEffectPotion "Hearty Meal" [ALCH:03066B5F]
		AddModFood(0x00062FEC, "Frostfall.esp", _Seed_NotFood)	;_Frost_FrostbittenPotionBody "Frostbite (Body)" [ALCH:03062FEC]
		AddModFood(0x00068121, "Frostfall.esp", _Seed_NotFood)	;_Frost_FrostbittenPotionHands "Frostbite (Hands)" [ALCH:03068121]
		AddModFood(0x03068123, "Frostfall.esp", _Seed_NotFood)	;_Frost_FrostbittenPotionHead "Frostbite (Head)" [ALCH:03068123]
		AddModFood(0x03068125, "Frostfall.esp", _Seed_NotFood)	;_Frost_FrostbittenPotionFeet "Frostbite (Feet)" [ALCH:03068125]
		
		AddFrostfallSystem()
	endif
endFunction

function AddFrostfallSystem()
		AddModFood(0x0001CEBD, "Frostfall.esp", _Seed_SystemFoods)	;_Frost_DrinkEffectPotion1 "Strong Brew" [ALCH:0301CEBD]
		AddModFood(0x0001CEBF, "Frostfall.esp", _Seed_SystemFoods)	;_Frost_DrinkEffectPotion2 "Strong Brew" [ALCH:0301CEBF]
		AddModFood(0x0001CEC1, "Frostfall.esp", _Seed_SystemFoods)	;_Frost_DrinkEffectPotion3 "Strong Brew" [ALCH:0301CEC1]
		AddModFood(0x0001D430, "Frostfall.esp", _Seed_SystemFoods)	;_Frost_WaterPotion "Snowberry Extract" [ALCH:0301D430]
		AddModFood(0x03066B5F, "Frostfall.esp", _Seed_SystemFoods)	;_Frost_FoodEffectPotion "Hearty Meal" [ALCH:03066B5F]
		AddModFood(0x00062FEC, "Frostfall.esp", _Seed_SystemFoods)	;_Frost_FrostbittenPotionBody "Frostbite (Body)" [ALCH:03062FEC]
		AddModFood(0x00068121, "Frostfall.esp", _Seed_SystemFoods)	;_Frost_FrostbittenPotionHands "Frostbite (Hands)" [ALCH:03068121]
		AddModFood(0x03068123, "Frostfall.esp", _Seed_SystemFoods)	;_Frost_FrostbittenPotionHead "Frostbite (Head)" [ALCH:03068123]
		AddModFood(0x03068125, "Frostfall.esp", _Seed_SystemFoods)	;_Frost_FrostbittenPotionFeet "Frostbite (Feet)" [ALCH:03068125]
endFunction

function addCACO(bool checkRequired = true)
	bool addFood = true
	if(checkRequired)
		addFood = SeedUtil.GetCompatibilitySystem().isCACOLoaded
	endif

	if addFood
	; CHANGE PORTIONED FOODS - EXISTING
	RemoveMultiPartFood_Array(FoodBread01A)
	RemoveMultiPartFood_Array(FoodCheeseWheel01A)
	RemoveMultiPartFood_Array(FoodCheeseWheel01B)
	RemoveMultiPartFood_Array(FoodCheeseWheel02A)
	RemoveMultiPartFood_Array(FoodCheeseWheel02B)

	; CHANGE PORTIONED FOODS - ALCOHOL
	SetAlcoholType(FirebrandWine, 1)
	SetAlcoholType(FoodWineAlto, 1)
	SetAlcoholType(FoodWineAltoA, 1)
	SetAlcoholType(FoodWineBottle02, 1)
	SetAlcoholType(FoodWineBottle02A, 1)
	SetAlcoholType(MQ201Drink, 1)
	SetAlcoholType(BYOHFoodWineBottle03, 1)
	SetAlcoholType(BYOHFoodWineBottle04, 1)
	SetAlcoholType(DLC2Flin, 1)
	SetAlcoholType(DLC2Matze, 1)
	SetAlcoholType(DLC2RRF04Sujamma, 1)
	SetAlcoholType(DLC2RRFavor01EmberbrandWine, 1)
	SetAlcoholType(DLC2Shein, 1)
	SetAlcoholType(DLC2Sujamma, 1)
	SetAlcoholType(FirebrandWine, 1)
	SetAlcoholType(MS14WineAltoA, 1)
	SetAlcoholType(FoodSolitudeSpicedWine, 1)
	SetAlcoholType(FavorSorexRum, 1)

	_Seed_ImportCACO.show(20.0)

	SetFoodRestoreAmount(FoodPie, 1)
	SetFoodRestoreAmount(FoodBeef, 1)
	SetFoodRestoreAmount(FoodHorkerMeat, 1)
	SetFoodRestoreAmount(FoodHorseMeat, 1)
	SetFoodRestoreAmount(FoodVenison, 1)
	SetFoodRestoreAmount(FoodMammothMeat, 1)
	SetFoodRestoreAmount(FoodGoatMeatCooked, 2)
	SetFoodRestoreAmount(FoodHorseMeatCooked, 2)
	SetFoodRestoreAmount(DLC2FoodBoarMeat, 1)
	SetFoodRestoreAmount(DLC2FoodAshHopperMeat, 1)
	SetFoodRestoreAmount(DLC2FoodBoarMeatCooked, 2)
	SetFoodRestoreAmount(FoodBeefCooked, 2)
	
	;NO NEED TO FIX
	;BYOHFoodDrinkMilk "Jug of Fresh Milk" [ALCH:03003534]
	;BYOHFoodFlour "Sack of Wheat Flour" [ALCH:03003538]
	;FoodVegCabbage "Cabbage" [ALCH:00064B3F]
	;BYOHFoodBakeBreadPotato01A "Potato Bread" [ALCH:03003537]	
	
	; CACO NEEDS INGESTIBLES
	AddModFood(0x005E14C8, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsFatigueLvl00 "Rested" [ALCH:0x005E14C8]
	AddModFood(0x005D72AF, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsFatigueLvl01 "Tired" [ALCH:0x005D72AF]
	AddModFood(0x005DC3C0, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsFatigueLvl02 "Fatigued" [ALCH:0x005DC3C0]
	AddModFood(0x005DC3C2, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsFatigueLvl03 "Exhausted" [ALCH:0x005DC3C2]
	AddModFood(0x005DC3C2, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsHungerLvl00 "Not Hungry" [ALCH:0x0046A34E]
	AddModFood(0x0073499B, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsHungerLvl00End "Not Hungry" [ALCH:0x0073499B]
	AddModFood(0x004FD2BA, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsHungerLvl01 "Hungry" [ALCH:0x004FD2BA]
	AddModFood(0x004FD2B7, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsHungerLvl02 "Famished" [ALCH:0x004FD2B7]
	AddModFood(0x004FD2BC, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsHungerLvl03 "Starving" [ALCH:0x004FD2BC]
	AddModFood(0x005D2185, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsSleepNotTired01 "Not Tired" [ALCH:0x005D2185]
	AddModFood(0x005D2186, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsSleepNotTired02 "Not Tired" [ALCH:0x005D2186]
	AddModFood(0x005D21A0, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsSleepNotTired03 "Not Tired" [ALCH:0x005D21A0]
	AddModFood(0x005D21A2, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsSleepNotTired04 "Not Tired" [ALCH:0x005D21A2]
	AddModFood(0x005D21A4, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsSleepNotTired05 "Not Tired" [ALCH:0x005D21A4]
	AddModFood(0x005D21A6, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsSleepNotTired06 "Not Tired" [ALCH:0x005D21A6]
	AddModFood(0x005D21A8, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsSleepNotTired07 "Not Tired" [ALCH:0x005D21A8]
	AddModFood(0x005D21AA, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsSleepNotTired08 "Not Tired" [ALCH:0x005D21AA]
	AddModFood(0x005D2188, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsSleepRested01 "Rested" [ALCH:0x005D2188]
	AddModFood(0x005D2192, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsSleepRested02 "Rested" [ALCH:0x005D2192]
	AddModFood(0x005D2194, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsSleepRested03 "Rested" [ALCH:0x005D2194]
	AddModFood(0x005D2196, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsSleepRested04 "Rested" [ALCH:0x005D2196]
	AddModFood(0x005D2198, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsSleepRested05 "Rested" [ALCH:0x005D2198]
	AddModFood(0x005D219A, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsSleepRested06 "Rested" [ALCH:0x005D219A]
	AddModFood(0x005D219C, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsSleepRested07 "Rested" [ALCH:0x005D219C]
	AddModFood(0x005D219E, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	; CACO_FoodBasicNeedsSleepRested08 "Rested" [ALCH:0x005D219E]

	_Seed_ImportCACO.show(40.0)
		
	;NEW FOOD - ALCOHOL
	AddModFood(0x0045AFF9, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	;BYOHFoodWineBottle031 "Surilie Brothers Wine" [ALCH:0x0045AFF9]
	AddModFood(0x0045AFFC, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	;BYOHFoodWineBottle032 "Surilie Brothers Wine" [ALCH:0x0045AFFC]
	AddModFood(0x0045AFFE, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	;BYOHFoodWineBottle033 "Surilie Brothers Wine" [ALCH:0x0045AFFE]
	AddModFood(0x0045AFF2, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	;BYOHFoodWineBottle041 "Argonian Bloodwine" [ALCH:0x0045AFF2]
	AddModFood(0x0045AFF3, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;BYOHFoodWineBottle042 "Argonian Bloodwine" [ALCH:0x0045AFF3]
	AddModFood(0x0045AFF6, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;BYOHFoodWineBottle043 "Argonian Bloodwine" [ALCH:0x0045AFF6]
	AddModFood(0x0046011A, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	;DLC2FoodDrinkFlin1 "Flin" [ALCH:0x0046011A]
	AddModFood(0x00460116, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;DLC2FoodDrinkFlin2 "Flin" [ALCH:0x00460116]
	AddModFood(0x00460117, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	;DLC2FoodDrinkFlin3 "Flin" [ALCH:0x00460117]
	AddModFood(0x00460140, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;DLC2FoodDrinkMatze1 "Mazte" [ALCH:0x00460140]
	AddModFood(0x00460142, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;DLC2FoodDrinkMatze2 "Mazte" [ALCH:0x00460142]
	AddModFood(0x00460144, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;DLC2FoodDrinkMatze3 "Mazte" [ALCH:0x00460144]
	AddModFood(0x0046012A, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;DLC2FoodDrinkRRF04Sujamma1 "Sadri's Sujamma" [ALCH:0x0046012A]
	AddModFood(0x0046012B, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;DLC2FoodDrinkRRF04Sujamma2 "Sadri's Sujamma" [ALCH:0x0046012B]
	AddModFood(0x0046012E, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;DLC2FoodDrinkRRF04Sujamma3 "Sadri's Sujamma" [ALCH:0x0046012E]
	AddModFood(0x0045B00A, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;DLC2FoodDrinkRRFavor01EmberbrandWine1 "Emberbrand Wine" [ALCH:0x0045B00A]
	AddModFood(0x0045B00C, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;DLC2FoodDrinkRRFavor01EmberbrandWine2 "Emberbrand Wine" [ALCH:0x0045B00C]
	AddModFood(0x0045B00E, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;DLC2FoodDrinkRRFavor01EmberbrandWine3 "Emberbrand Wine" [ALCH:0x0045B00E]
	AddModFood(0x0046013A, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;DLC2Shein1 "Shein" [ALCH:0x0046013A]
	AddModFood(0x0046013C, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;DLC2Shein2 "Shein" [ALCH:0x0046013C]
	AddModFood(0x0046013E, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;DLC2Shein3 "Shein" [ALCH:0x0046013E]
	AddModFood(0x00460124, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;DLC2Sujamma1 "Sujamma" [ALCH:0x00460124]
	AddModFood(0x00460126, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;DLC2Sujamma2 "Sujamma" [ALCH:0x00460126]
	AddModFood(0x00460128, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;DLC2Sujamma3 "Sujamma" [ALCH:0x00460128]
	AddModFood(0x00450DD2, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;FoodDrinkFirebrandWine1 "Firebrand Wine" [ALCH:0x00450DD2]
	AddModFood(0x00450DD4, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;FoodDrinkFirebrandWine2 "Firebrand Wine" [ALCH:0x00450DD4]
	AddModFood(0x00450DD6, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;FoodDrinkFirebrandWine3 "Firebrand Wine" [ALCH:0x00450DD6]
	AddModFood(0x0044BCCB, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MQ201DrinkBrandy1 "Colovian Brandy" [ALCH:0x0044BCCB]
	AddModFood(0x0044BCC9, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MQ201DrinkBrandy2 "Colovian Brandy" [ALCH:0x0044BCC9]
	AddModFood(0x0044BCC7, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MQ201DrinkBrandy3 "Colovian Brandy" [ALCH:0x0044BCC7]
	AddModFood(0x0044BCC5, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MQ201DrinkBrandy4 "Colovian Brandy" [ALCH:0x0044BCC5]
	AddModFood(0x0044BCC3, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MQ201DrinkBrandy5 "Colovian Brandy" [ALCH:0x0044BCC3]
	AddModFood(0x0044BCC1, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MQ201DrinkBrandy6 "Colovian Brandy" [ALCH:0x0044BCC1]
	AddModFood(0x0044BCBF, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MQ201DrinkBrandy7 "Colovian Brandy" [ALCH:0x0044BCBF]
	AddModFood(0x0044BCBD, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MQ201DrinkBrandy8 "Colovian Brandy" [ALCH:0x0044BCBD]
	AddModFood(0x0044BCBB, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MQ201DrinkBrandy9 "Colovian Brandy" [ALCH:0x0044BCBB]
	AddModFood(0x0044BCB9, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MQ201DrinkBrandy10 "Colovian Brandy" [ALCH:0x0044BCB9]
	AddModFood(0x0044BCB6, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MQ201DrinkBrandy11 "Colovian Brandy" [ALCH:0x0044BCB6]
	AddModFood(0x0044BCB4, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MQ201DrinkBrandy12 "Colovian Brandy" [ALCH:0x0044BCB4]
	AddModFood(0x0044BCB2, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MQ201DrinkBrandy13 "Colovian Brandy" [ALCH:0x0044BCB2]
	AddModFood(0x0044BCA2, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MQ201DrinkBrandy14 "Colovian Brandy" [ALCH:0x0044BCA2]
	AddModFood(0x0044BCA1, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MQ201DrinkBrandy15 "Colovian Brandy" [ALCH:0x0044BCA1]
	AddModFood(0x00450DDB, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MS14WineAltoA1 "Jessica's Wine" [ALCH:0x00450DDB]
	AddModFood(0x00450DDD, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MS14WineAltoA2 "Jessica's Wine" [ALCH:0x00450DDD]
	AddModFood(0x00450DDF, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;MS14WineAltoA3 "Jessica's Wine" [ALCH:0x00450DDF]
	AddModFood(0x00450DE4, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;FoodSolitudeSpicedWine1 "Spiced Wine" [ALCH:0x00450DE4]
	AddModFood(0x00450DE6, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;FoodSolitudeSpicedWine2 "Spiced Wine" [ALCH:0x00450DE6]
	AddModFood(0x00450DE8, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;FoodSolitudeSpicedWine3 "Spiced Wine" [ALCH:0x00450DE8]
	AddModFood(0x002F8755, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;WEDL03CyrodilicBrandy1 "Cyrodilic Brandy" [ALCH:0x002F8755]
	AddModFood(0x002F8757, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;WEDL03CyrodilicBrandy2 "Cyrodilic Brandy" [ALCH:0x002F8757]
	AddModFood(0x002F8758, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;WEDL03CyrodilicBrandy3 "Cyrodilic Brandy" [ALCH:0x002F8758]
	AddModFood(0x002F875B, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;WEDL03CyrodilicBrandy4 "Cyrodilic Brandy" [ALCH:0x002F875B]
	AddModFood(0x002F875D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;WEDL03CyrodilicBrandy5 "Cyrodilic Brandy" [ALCH:0x002F875D]
	AddModFood(0x002F875F, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;WEDL03CyrodilicBrandy6 "Cyrodilic Brandy" [ALCH:0x002F875F]
	AddModFood(0x002F8761, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;WEDL03CyrodilicBrandy7 "Cyrodilic Brandy" [ALCH:0x002F8761]
	AddModFood(0x002F8763, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;WEDL03CyrodilicBrandy8 "Cyrodilic Brandy" [ALCH:0x002F8763]
	AddModFood(0x002F8765, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;WEDL03CyrodilicBrandy9 "Cyrodilic Brandy" [ALCH:0x002F8765]	
	AddModFood(0x002F8767, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;WEDL03CyrodilicBrandy10 "Cyrodilic Brandy" [ALCH:0x002F8767]
	AddModFood(0x002F8769, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;WEDL03CyrodilicBrandy11 "Cyrodilic Brandy" [ALCH:0x002F8769]
	AddModFood(0x002F876B, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;WEDL03CyrodilicBrandy12 "Cyrodilic Brandy" [ALCH:0x002F876B]
	AddModFood(0x002F876D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;WEDL03CyrodilicBrandy13 "Cyrodilic Brandy" [ALCH:0x002F876D]
	AddModFood(0x002F876F, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;WEDL03CyrodilicBrandy14 "Cyrodilic Brandy" [ALCH:0x002F876F]
	AddModFood(0x002F8771, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;WEDL03CyrodilicBrandy15 "Cyrodilic Brandy" [ALCH:0x002F8771]
	AddModFood(0x002BBAC9, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;FoodWineAlto1 "Alto Noir Wine" [ALCH:0x002BBAC9]
	AddModFood(0x002BBAC7, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;FoodWineAlto2 "Alto Noir Wine" [ALCH:0x002BBAC7]
	AddModFood(0x002BBAC6, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;FoodWineAlto3 "Alto Noir Wine" [ALCH:0x002BBAC6]
	AddModFood(0x002EE520, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;FoodWineAltoA1 "Alto Blanc Wine" [ALCH:0x002EE520]
	AddModFood(0x002EE522, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;FoodWineAltoA2 "Alto Blanc Wine" [ALCH:0x002EE522]	
	AddModFood(0x002EE524, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;FoodWineAltoA3 "Alto Blanc Wine" [ALCH:0x002EE524]
	AddModFood(0x002EE529, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;FoodWineBottle021 "Village Red Wine" [ALCH:0x002EE529]
	AddModFood(0x002EE52B, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;FoodWineBottle022 "Village Red Wine" [ALCH:0x002EE52B]
	AddModFood(0x002EE52D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;FoodWineBottle023 "Village Red Wine" [ALCH:0x002EE52D]
	AddModFood(0x002EE52F, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;FoodWineBottle02A1 "Village White Wine" [ALCH:0x002EE52F]
	AddModFood(0x002EE531, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;FoodWineBottle02A2 "Village White Wine" [ALCH:0x002EE531]
	AddModFood(0x001FB171, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	;CACO_FoodDrinkAppleCider_Nernie "Apple Cider" [ALCH:0x001FB171]
	
	;NEW FOOD - FLOUR
	AddModFood(0x005023ED, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour01 "Sack of Wheat Flour" [ALCH:0x005023ED]
	AddModFood(0x005023EA, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour02 "Sack of Wheat Flour" [ALCH:0x005023EA]
	AddModFood(0x005023E9, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour03 "Sack of Wheat Flour" [ALCH:0x005023E9]
	AddModFood(0x005023E7, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour04 "Sack of Wheat Flour" [ALCH:0x005023E7]
	AddModFood(0x005023E5, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour05 "Sack of Wheat Flour" [ALCH:0x005023E5]
	AddModFood(0x005023E3, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour06 "Sack of Wheat Flour" [ALCH:0x005023E3]
	AddModFood(0x005023E1, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour07 "Sack of Wheat Flour" [ALCH:0x005023E1]
	AddModFood(0x005023DF, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour08 "Sack of Wheat Flour" [ALCH:0x005023DF]
	AddModFood(0x005023DD, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour09 "Sack of Wheat Flour" [ALCH:0x005023DD]
	AddModFood(0x005023DB, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour10 "Sack of Wheat Flour" [ALCH:0x005023DB]
	AddModFood(0x005023D9, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour11 "Sack of Wheat Flour" [ALCH:0x005023D9]
	AddModFood(0x005023D7, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour12 "Sack of Wheat Flour" [ALCH:0x005023D7]
	AddModFood(0x005023D5, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour13 "Sack of Wheat Flour" [ALCH:0x005023D5]
	AddModFood(0x005023D3, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour14 "Sack of Wheat Flour" [ALCH:0x005023D3]
	AddModFood(0x005023D1, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour15 "Sack of Wheat Flour" [ALCH:0x005023D1]
	AddModFood(0x005023CF, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour16 "Sack of Wheat Flour" [ALCH:0x005023CF]
	AddModFood(0x005023CD, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour17 "Sack of Wheat Flour" [ALCH:0x005023CD]
	AddModFood(0x005023CB, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour18 "Sack of Wheat Flour" [ALCH:0x005023CB]
	AddModFood(0x005023C9, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodFlour19 "Sack of Wheat Flour" [ALCH:0x005023C9]
	AddModFood(0x00A10116, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;CACO_FoodIngrFlourBarley "Sack of Barley Flour" [ALCH:0x00A10116]
	AddModFood(0x0052ACD4, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley01 "Sack of Barley Flour" [ALCH:0x0052ACD4]
	AddModFood(0x0052ACD6, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley02 "Sack of Barley Flour" [ALCH:0x0052ACD6]
	AddModFood(0x0052ACD8, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley03 "Sack of Barley Flour" [ALCH:0x0052ACD8]
	AddModFood(0x0052ACDA, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley04 "Sack of Barley Flour" [ALCH:0x0052ACDA]
	AddModFood(0x0052ACDC, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley05 "Sack of Barley Flour" [ALCH:0x0052ACDC]
	AddModFood(0x0052ACDE, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley06 "Sack of Barley Flour" [ALCH:0x0052ACDE]
	AddModFood(0x0052ACE0, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley07 "Sack of Barley Flour" [ALCH:0x0052ACE0]
	AddModFood(0x0052ACE2, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley08 "Sack of Barley Flour" [ALCH:0x0052ACE2]
	AddModFood(0x0052ACE4, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley09 "Sack of Barley Flour" [ALCH:0x0052ACE4]
	AddModFood(0x0052ACE6, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley10 "Sack of Barley Flour" [ALCH:0x0052ACE6]
	AddModFood(0x0052ACE8, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley11 "Sack of Barley Flour" [ALCH:0x0052ACE8]
	AddModFood(0x0052ACEA, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley12 "Sack of Barley Flour" [ALCH:0x0052ACEA]
	AddModFood(0x0052ACEC, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley13 "Sack of Barley Flour" [ALCH:0x0052ACEC]
	AddModFood(0x0052ACEE, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley14 "Sack of Barley Flour" [ALCH:0x0052ACEE]
	AddModFood(0x0052ACF0, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley15 "Sack of Barley Flour" [ALCH:0x0052ACF0]
	AddModFood(0x0052ACF2, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley16 "Sack of Barley Flour" [ALCH:0x0052ACF2]
	AddModFood(0x0052ACF4, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley17 "Sack of Barley Flour" [ALCH:0x0052ACF4]
	AddModFood(0x0052ACF6, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley18 "Sack of Barley Flour" [ALCH:0x0052ACF6]
	AddModFood(0x0052ACF8, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	;BYOHFoodIngrFlourBarley19 "Sack of Barley Flour" [ALCH:0x0052ACF8]

	_Seed_ImportCACO.show(60.0)

	; NEW FOOD - SIMPLE STEWS
	AddModFood(0x002200C9, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food1StewAshHopper "Ash Hopper Stew" [ALCH:0x002200C9]
	AddModFood(0x00534F1A, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food1StewBear "Bear Stew" [ALCH:0x00534F1A]
	AddModFood(0x00A1011C, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food1StewChicken "Chicken Stew" [ALCH:0x00A1011C]
	AddModFood(0x0022009F, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food1StewDog "Dogmeat Stew" [ALCH:0x0022009F]
	AddModFood(0x002200A5, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food1StewGoat_CookingExpanded "Goat Stew" [ALCH:0x002200A5]
	AddModFood(0x002B18D8, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food1StewGourdCarrot "Squash Stew" [ALCH:0x002B18D8]
	AddModFood(0x001FB16D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food1StewGourd_Nernie "Squash and Onion Stew" [ALCH:0x001FB16D]
	AddModFood(0x002200A0, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food1StewHorse "Equine Stew" [ALCH:0x002200A0]
	AddModFood(0x0052AD03, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food1StewHuman_Wolfs "Human Stew" [ALCH:0x0052AD03]
	AddModFood(0x00534F1D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food1StewMammoth "Mammoth Stew" [ALCH:0x00534F1D]
	AddModFood(0x0022009B, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food1StewPheasant "Pheasant Stew" [ALCH:0x0022009B]
	AddModFood(0x00220073, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food1StewRabbit_Wolfs "Rabbit Stew" [ALCH:0x00220073]
	AddModFood(0x00190B5D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food1StewSabreCat_HOC "Sabre Stew" [ALCH:0x00190B5D]
	AddModFood(0x0099E778, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food1StewSheep "Mutton Stew" [ALCH:0x0099E778]	
	AddModFood(0x00534F20, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food1StewTroll "Trollmeat Stew" [ALCH:0x00534F20]
	AddModFood(0x009FEC40, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2PorridgeBarley_Nernie "Barley Porridge" [ALCH:0x009FEC40]
	AddModFood(0x005C2E48, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2PorridgeRice_Nernie "Saltrice Porridge" [ALCH:0x005C2E48]
	AddModFood(0x001FB181, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2PorridgeWheat_Nernie "Wheat Porridge" [ALCH:0x001FB181]	
	AddModFood(0x0022009E, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2SoupChicken_CookingExpanded "Chicken Soup" [ALCH:0x0022009E]
	AddModFood(0x009A89CE, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2SoupPea_SF "Pea Soup" [ALCH:0x009A89CE]
	AddModFood(0x002200A1, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2SoupRabbit_CookingExpanded "Rabbit Soup" [ALCH:0x002200A1]	
	AddModFood(0x002B18D7, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2SoupSlaughterfish "Slaughterfish Soup" [ALCH:0x002B18D7]
	AddModFood(0x002200CA, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2SoupYam_CookingExpanded "Yam Soup" [ALCH:0x002200CA]
	AddModFood(0x00A1014A, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2StewAshHopperFire "Fire Hopper Stew" [ALCH:0x00A1014A]
	AddModFood(0x001FB173, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2StewFish_Nernie "Slaughterfish Stew" [ALCH:0x001FB173]
	AddModFood(0x00220099, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food3SoupMushroom_CookingExpanded "Mushroom Soup" [ALCH:0x00220099]
	AddModFood(0x0022009A, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food4SoupMammothFondue_CookingExpanded "Mammoth Fondue" [ALCH:0x0022009A]
	AddModFood(0x002B18DE, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food4SoupSalmonSpicy "Savory Salmon Soup" [ALCH:0x002B18DE]
	AddModFood(0x002B18DC, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food3SoupChickenSavory "Savory Chicken Soup" [ALCH:0x002B18DC]
	AddModFood(0x002B18CF, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_FoodSoup3SabreCat "Sabre Cat Soup" [ALCH:0x002B18CF]		
	
	
	; NEW FOOD - COMPLEX STEWS
	AddModFood(0x00A1011D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food1StewVegetable_SF "Vegetable Stew" [ALCH:0x00A1011D]
	AddModFood(0x00220098, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2SoupBread_CookingExpanded "Bread Soup" [ALCH:0x00220098]
	AddModFood(0x002B18CA, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2SoupSalmonPotato "Salmon and Potato Soup" [ALCH:0x002B18CA]
	AddModFood(0x002B18D9, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2StewBeefVeg "Beef and Vegetable Stew" [ALCH:0x002B18D9]
	AddModFood(0x002B18CE, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2StewBoarVeg "Boar and Vegetable Stew" [ALCH:0x002B18CE]	
	AddModFood(0x002B18A4, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2StewChickenVeg "Chicken and Vegetable Stew" [ALCH:0x002B18A4]
	AddModFood(0x001FB15C, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2StewHorker_RWS "Hearty Horker Stew" [ALCH:0x001FB15C]
	AddModFood(0x0099E796, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2StewPorkVeg "Pork and Vegetable Stew" [ALCH:0x0099E796]
	AddModFood(0x002200DD, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2StewVenisonVeg_Nernie "Venison Vegetable Stew" [ALCH:0x002200DD]
	AddModFood(0x00190B5B, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food2StewWoodsman_HOC "Woodsman Stew" [ALCH:0x00190B5B]
	AddModFood(0x002B18E0, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food3SoupBaconCheese "Bacon Cheese Soup" [ALCH:0x002B18E0]
	AddModFood(0x002200DA, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food3SoupBeefVeg_Nernie "Beef Cabbage Soup" [ALCH:0x002200DA]
	AddModFood(0x002B18D6, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food3SoupChickenMushroom "Chicken Mushroom Soup" [ALCH:0x002B18D6]
	AddModFood(0x002B18D0, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food3SoupHamVegetable "Ham and Vegetable Soup" [ALCH:0x002B18D0]
	AddModFood(0x002B18DB, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food3SoupLeek "Creamy Leek Soup" [ALCH:0x002B18DB]
	AddModFood(0x002B18D2, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food3SoupMeatBall "Meat Ball Soup" [ALCH:0x002B18D2]
	AddModFood(0x002B18DD, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food3SoupSalmonCreamy "Salmon Cream Soup" [ALCH:0x002B18DD]
	AddModFood(0x002B18DA, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food4SoupBeefEgg "Beef and Egg Soup" [ALCH:0x002B18DA]
	AddModFood(0x00220003, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food4SoupClamChowder_BF "Haafingar Clam Chowder" [ALCH:0x00220003]
	AddModFood(0x00220118, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food4SoupPotageMagnifique01_SL00 "Potage le Magnifique" [ALCH:0x00220118]
	AddModFood(0x002B18CB, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food4SoupSeafoodMedley "Seafood Medley Soup" [ALCH:0x002B18CB]
	AddModFood(0x002B18D1, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food4SoupSquashBacon "Squash and Bacon Soup" [ALCH:0x002B18D1]
	AddModFood(0x00220000, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food5SoupBouillabaisse_BF "Wayrest Bouillabaisse" [ALCH:0x00220000]
	AddModFood(0x00220005, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food5SoupCoqAuVin_BF "Coq Au Vin" [ALCH:0x00220005]
	AddModFood(0x00220006, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food5SoupeAuPistou_BF "Soupe Au Pistou" [ALCH:0x00220006]
	AddModFood(0x00220002, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food5SoupVichyssoise_BF "Jehannoise" [ALCH:0x00220002]
	AddModFood(0x002B18D5, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food3StewBeefMushroom "Beef and Mushroom Stew" [ALCH:0x002B18D5]
	AddModFood(0x002B18DF, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food4StewBeefEgg "Beef and Egg Stew" [ALCH:0x002B18DF]
	AddModFood(0x00220147, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food4StewReachBriarHeart_SL00 "Reachman's Stew" [ALCH:0x00220147]
	AddModFood(0x002B18CD, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food4StewSlowCookedPork "Slow Cooked Pork" [ALCH:0x002B18CD]
	AddModFood(0x00220008, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food5MealBeefStroganoff_BF "Beef Stroganius" [ALCH:0x00220008]
	AddModFood(0x002B18CC, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	;CACO_Food5StewPulledPork "Pulled Pork Ragout" [ALCH:0x002B18CC]

	;NEW FOOD - BREAD
	AddModFood(0x004B6322, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMajor) 	;BYOHFoodBakeBreadPotato01B "Potato Bread" [ALCH:0x004B6322]
	AddModFood(0x004B6328, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMajor) 	;CACO_FoodBakeBreadDarkB_Nernie "Dark Bread" [ALCH:0x004B6328]
	AddModFood(0x001FB199, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMajor) 	;CACO_FoodBakeBreadDark_Nernie "Dark Bread" [ALCH:0x001FB199]
	AddModFood(0x004C569B, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMajor) 	;CACO_FoodBakeBreadRound01B_Nernie "Barley Bread" [ALCH:0x004C569B]
	AddModFood(0x001FB19F, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMajor) 	;CACO_FoodBakeBreadRound01_Nernie "Barley Bread" [ALCH:0x001FB19F]
	AddModFood(0x004C569D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMajor) 	;CACO_FoodBakeBreadRound02B_Nernie "Barley Nut Bread" [ALCH:0x004C569D]
	AddModFood(0x001FB19D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMajor) 	;CACO_FoodBakeBreadRound02_Nernie "Barley Nut Bread" [ALCH:0x001FB19D]
	AddModFood(0x004B6325, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMajor) 	;CACO_FoodBakeBreadWheatB_Nernie "Wheat Bread" [ALCH:0x004B6325]
	AddModFood(0x004B631F, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMajor) 	;CACO_FoodBakeBreadWheatHoneyB_Nernie "Honey Wheat Bread" [ALCH:0x004B631F]
	AddModFood(0x001FB1A1, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Bread, _Seed_Food_RestoreHungerMajor) 	;CACO_FoodBakeBreadWheat_Nernie "Wheat Bread" [ALCH:0x001FB1A1]



	; NEW FOOD - SMALL PASTRY
	AddModFood(0x0054E497, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Pastries, _Seed_Food_RestoreHungerSuperior) ;BYOHFoodBakeDumplingChaurus01 "Chaurus Dumpling" [ALCH:0x0054E497]	
	AddModFood(0x00200309, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Pastries, _Seed_Food_RestoreHungerSuperior) ;CACO_FoodBakeTartSnowberry_Insanity "Snowberry Tart" [ALCH:0x00200309]
	AddModFood(0x0054E48A, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) ;FoodPieSlice "Apple Pie Slice" [ALCH:0x0054E48A]
	
	; NEW FOOD - LARGE PASTRY
	AddModFood(0x0022000B, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive) ;CACO_Food4BakeEggMushroomQuiche_BF "Mushroom and Cheese Quiche" [ALCH:0x0022000B]
	AddModFood(0x00220009, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive) ;CACO_Food3BakePieMeat_BF "Glenpoint Savory Pie" [ALCH:0x00220009]
	AddModFood(0x00220004, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive) ;CACO_Food3BakePieSnowberry_BF "Snowberry Pie" [ALCH:0x00220004]

	; NEW FOOD - RAW FISH
	AddModFood(0x00190B58, "Complete Alchemy & Cooking Overhaul.esp", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor) ;CACO_FoodSeaSlaughterfishRaw "Raw Slaughterfish" [ALCH:0x00190B58]	

	
	; NEW FOOD - COOKED FISH
	AddModFood(0x004A6FE8, "Complete Alchemy & Cooking Overhaul.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerSuperior) ;CACO_Food2SeaSalmonFried_BF "Pan Fried Salmon" [ALCH:0x004A6FE8]
	AddModFood(0x0022000C, "Complete Alchemy & Cooking Overhaul.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerSuperior) ;CACO_Food3SeaSalmonGravlax_BF "Gravlax" [ALCH:0x0022000C]
	AddModFood(0x00220001, "Complete Alchemy & Cooking Overhaul.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerSuperior) ;CACO_Food3SeaSlaughterfishBattered_BF "Beer Battered Slaughterfish" [ALCH:0x00220001]
	AddModFood(0x004A6FFD, "Complete Alchemy & Cooking Overhaul.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMinor, _Seed_Preserved, _Seed_SaltedFood) ;CACO_FoodSeaSalmonDried "Dried Salmon" [ALCH:0x004A6FFD]
	
	; NEW FOOD - COOKED SEAFOOD
	AddModFood(0x002200A6, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SeafoodCooked, _Seed_Food_RestoreHungerMajor) 	;CACO_FoodSeaClamCooked "Cooked Clam" [ALCH:0x002200A6]
	AddModFood(0x0022013E, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SeafoodCooked, _Seed_Food_RestoreHungerMajor) 	;CACO_FoodSeaClamGrilled_SL00 "Grilled Clams" [ALCH:0x0022013E]
	AddModFood(0x00725695, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SeafoodCooked, _Seed_Food_RestoreHungerSuperior) ;CACO_FoodSeaMudcrabClawButter "Buttered Mudcrab Claw" [ALCH:0x00725695]
	AddModFood(0x00220108, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SeafoodCooked, _Seed_Food_RestoreHungerMajor) 	;CACO_FoodSeaMudcrabClaw_SL00 "Steamed Mudcrab Claw" [ALCH:0x00220108]
	AddModFood(0x00725696, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SeafoodCooked, _Seed_Food_RestoreHungerSuperior) ;CACO_FoodSeaMudcrabLegsButter "Buttered Mudcrab Legs" [ALCH:0x00725696]
	
	; NEW FOOD - RAW SMALL GAME
	AddModFood(0x00190B5F, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SmallGameRaw, _Seed_Food_RestoreHungerMinor) 	;CACO_FoodMeatHawk_HOC "Raw Hawk Breast" [ALCH:0x00190B5F]
	AddModFood(0x00190B5E, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SmallGameRaw, _Seed_Food_RestoreHungerMinor)	;CACO_FoodMeatTern_HOC "Raw Tern Breast" [ALCH:0x00190B5E]

	
	; NEW FOOD - RAW MEAT
	AddModFood(0x0048DA6D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor) ;FoodBeefRawPortion "Raw Beef Steak" [ALCH:0x0048DA6D]
	AddModFood(0x004B1215, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor) ;CACO_FoodMeatAshHopperLegRawPortion_SL00 "Raw Ash Hopper Leg Meat" [ALCH:0x004B1215]
	AddModFood(0x004C0579, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor) ;CACO_FoodMeatAshHopperMeat "Raw Ash Hopper Meat" [ALCH:0x004C0579]
	AddModFood(0x00190B54, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor) ;CACO_FoodMeatBear "Raw Bear Meat" [ALCH:0x00190B54]
	AddModFood(0x0048DA65, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor) ;CACO_FoodMeatBearRawPortion "Raw Bear Steak" [ALCH:0x0048DA65]
	AddModFood(0x0054425D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor) ;CACO_FoodMeatBoarRawPortion "Raw Boar Sliced" [ALCH:0x0054425D]
	AddModFood(0x00190B63, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor) ;CACO_FoodMeatChaurusMeat "Raw Chaurus Meat" [ALCH:0x00190B63]
	AddModFood(0x00190B50, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor) ;CACO_FoodMeatFox "Raw Fox Meat" [ALCH:0x00190B50]
	AddModFood(0x0048DA62, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor) ;CACO_FoodMeatGenericRawPortion_KRY "Raw Meat" [ALCH:0x0048DA62]
	AddModFood(0x0049CDC7, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor) ;CACO_FoodMeatGoatPortionRaw "Raw Goat Meat" [ALCH:0x0049CDC7]
	AddModFood(0x00492B83, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor) ;CACO_FoodMeatHumanoidFleshRawPortion "Raw Hominid Meat" [ALCH:0x00492B83]
	AddModFood(0x00190B56, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor) ;CACO_FoodMeatMammoth "Raw Mammoth Meat" [ALCH:0x00190B56]
	AddModFood(0x0049CDAC, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor) ;CACO_FoodMeatMammothRawPortion "Raw Mammoth Steak" [ALCH:0x0049CDAC]
	AddModFood(0x0099E788, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor) ;CACO_FoodMeatPorkRawPortion "Raw Pork Sliced" [ALCH:0x0099E788]
	AddModFood(0x00190B53, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor) ;CACO_FoodMeatSabre "Raw Sabre Cat Meat" [ALCH:0x00190B53]
	AddModFood(0x004A1ED3, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor) ;CACO_FoodMeatSabreRawPortion "Raw Sabre Cat Steak" [ALCH:0x004A1ED3]
	AddModFood(0x0049CDA3, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor)	;CACO_FoodMeatSkeeverRaw "Raw Skeever Meat" [ALCH:0x0049CDA3]
	AddModFood(0x0048DA5A, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor)	;CACO_FoodMeatTroll "Raw Troll Meat" [ALCH:0x0048DA5A]
	AddModFood(0x00492B79, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor)	;CACO_FoodMeatTrollRawPortion "Raw Troll Steak" [ALCH:0x00492B79]
	AddModFood(0x0049CDBC, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor)	;FoodHorkerMeatRawPortion "Raw Horker Loaf" [ALCH:0x0049CDBC]
	AddModFood(0x0049CDB1, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor)	;FoodHorseMeatRawPortion "Raw Horse Steak" [ALCH:0x0049CDB1]
	AddModFood(0x00492B7C, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor)	;FoodMeatMammothRawPortion "Raw Mammoth Snout Steak" [ALCH:0x00492B7C]
	AddModFood(0x00492B7A, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor)	;FoodVenisonRawPortion "Raw Venison Steak" [ALCH:0x00492B7A]


	;NEW FOOD - COOKED SMALL GAME
	AddModFood(0x00497C91, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatHawkCooked_HOC "Cooked Hawk" [ALCH:0x00497C91]
	AddModFood(0x00497C94, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatTernCooked_HOC "Cooked Tern" [ALCH:0x00497C94]

	; NEW FOOD - COOKED MEAT
	AddModFood(0x005C7F6E, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_Food1MeatLiverCooked "Cooked Liver" [ALCH:0x005C7F6E]
	AddModFood(0x002002CD, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_Food3MeatSausageBeef_ExtraFood "Beef Sausage" [ALCH:0x002002CD]
	AddModFood(0x002002D1, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_Food3MeatSausageChicken_ExtraFood "Chicken Sausage" [ALCH:0x002002D1]
	AddModFood(0x00220127, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatAshHopperLegCooked_SL00 "Cooked Ash Hopper Leg Meat" [ALCH:0x00220127]
	AddModFood(0x004C057D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatAshHopperMeatCooked "Cooked Ash Hopper Meat" [ALCH:0x004C057D]
	AddModFood(0x00190B55, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatBearCooked "Cooked Bear Steak" [ALCH:0x00190B55]
	AddModFood(0x00220142, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodBeefCookedWhole "Roast Beef" [ALCH:0x00220142]
	AddModFood(0x002002AD, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatBoarBacon_ExtraFood "Boar Bacon" [ALCH:0x002002AD]
	AddModFood(0x004D9AE6, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatBoarCookedPortion "Cooked Boar Slices" [ALCH:0x004D9AE6]
	AddModFood(0x0054426C, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatBoarCuredPortion "Cured Boar Slices" [ALCH:0x0054426C]
	AddModFood(0x004C0572, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatChaurusMeatCooked "Cooked Chaurus Meat" [ALCH:0x004C0572]
	AddModFood(0x0020A519, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatCuredSliced_Nernie "Cured Meat Slices" [ALCH:0x0020A519]
	AddModFood(0x0020A518, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatCured_Nernie "Cured Meat" [ALCH:0x0020A518]
	AddModFood(0x004A6FF8, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatDogCooked "Cooked Canine Rack" [ALCH:0x004A6FF8]
	AddModFood(0x001FB15E, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatFoxCooked "Cooked Fox Meat" [ALCH:0x001FB15E]
	AddModFood(0x0049CDC5, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatGoatPortionCooked "Cooked Goat" [ALCH:0x0049CDC5]
	AddModFood(0x00195C73, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatHumanoidFleshCooked "Roasted Flesh" [ALCH:0x00195C73]	
	AddModFood(0x0054E4A4, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatMarinatedBear "Marinated Bear Steak" [ALCH:0x0054E4A4]
	AddModFood(0x005B8C2C, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatMarinatedBeef "Marinated Beef Steak" [ALCH:0x005B8C2C]
	AddModFood(0x0054E4A3, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatMarinatedChicken "Marinated Chicken Breast" [ALCH:0x0054E4A3]
	AddModFood(0x0054E4A6, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatMarinatedFox "Marinated Fox" [ALCH:0x0054E4A6]
	AddModFood(0x0054E4A8, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatMarinatedGoat "Marinated Goat" [ALCH:0x0054E4A8]
	AddModFood(0x0054E4AA, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatMarinatedHumanoidFlesh "Marinated Flesh" [ALCH:0x0054E4AA]
	AddModFood(0x0054E4AC, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatMarinatedSabre "Marinated Sabre Cat Steak" [ALCH:0x0054E4AC]
	AddModFood(0x0054E4AE, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatMarinatedTroll "Marinated Troll Meat" [ALCH:0x0054E4AE]
	AddModFood(0x0099E78A, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatPorkBacon_ExtraFood "Bacon" [ALCH:0x0099E78A]
	AddModFood(0x0099E78C, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatPorkCookedPortion "Cooked Ham Slices" [ALCH:0x0099E78C]
	AddModFood(0x0099E784, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatPorkCured "Cured Pork" [ALCH:0x0099E784]
	AddModFood(0x0099E78E, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatPorkCuredPortion "Cured Ham Slices" [ALCH:0x0099E78E]
	AddModFood(0x0022002B, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatRoastedHeart_Wolfs "Roasted Heart" [ALCH:0x0022002B]
	AddModFood(0x00195C75, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatSabreCooked "Cooked Sabre Cat Steak" [ALCH:0x00195C75]
	AddModFood(0x0099E776, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatSheepCooked "Cooked Mutton" [ALCH:0x0099E776]
	AddModFood(0x00220048, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatSkeeverTailCooked "Cooked Skeever Tail" [ALCH:0x00220048]
	AddModFood(0x0048DA60, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMeatTrollCooked "Cooked Troll Meat" [ALCH:0x0048DA60]
	AddModFood(0x00220143, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;CACO_FoodVenisonCookedWhole "Cooked Venison" [ALCH:0x00220143]
	AddModFood(0x0049CDB5, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor)	;FoodHorseMeatCookedPortion "Cooked Horse Steak" [ALCH:0x0049CDB5]

	_Seed_ImportCACO.show(80.0)
	
	; NEW FOOD - PRESERVED MEAT
	AddModFood(0x00516874, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodMeatJerkyBear_ExtraFood "Bear Jerky" [ALCH:0x00516874]
	AddModFood(0x00220027, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodMeatJerkyBeef_ExtraFood "Beef Jerky" [ALCH:0x00220027]
	AddModFood(0x00516876, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodMeatJerkyBoar_ExtraFood "Boar Jerky" [ALCH:0x00516876]
	AddModFood(0x00516878, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodMeatJerkyChicken_ExtraFood "Chicken Jerky" [ALCH:0x00516878]
	AddModFood(0x00516879, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodMeatJerkyGoat_ExtraFood "Goat Jerky" [ALCH:0x00516879]
	AddModFood(0x0051687D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodMeatJerkyHorker_ExtraFood "Horker Jerky" [ALCH:0x0051687D]
	AddModFood(0x00516880, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodMeatJerkyHorse_ExtraFood "Horse Jerky" [ALCH:0x00516880]
	AddModFood(0x0051687B, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodMeatJerkyHumanoid_ExtraFood "Hominid Jerky" [ALCH:0x0051687B]
	AddModFood(0x00516870, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodMeatJerkyMammoth_ExtraFood "Mammoth Jerky" [ALCH:0x00516870]
	AddModFood(0x0099E786, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodMeatJerkyPork_ExtraFood "Pork Jerky" [ALCH:0x0099E786]
	AddModFood(0x00516872, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodMeatJerkySabre_ExtraFood "Sabre Cat Jerky" [ALCH:0x00516872]
	AddModFood(0x00516881, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodMeatJerkySalmon_ExtraFood "Salmon Jerky" [ALCH:0x00516881]
	AddModFood(0x00516883, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodMeatJerkySkeever_ExtraFood "Skeever Jerky" [ALCH:0x00516883]
	AddModFood(0x00516886, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodMeatJerkyTroll_ExtraFood "Troll Jerky" [ALCH:0x00516886]
	AddModFood(0x0051686D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodMeatJerkyVenison_ExtraFood "Venison Jerky" [ALCH:0x0051686D]
	AddModFood(0x00190B57, "Complete Alchemy & Cooking Overhaul.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodMeatMammothCooked "Cooked Mammoth Steak" [ALCH:0x00190B57]
	
	
	; NEW FOOD - CHEESE
	AddModFood(0x001FB179, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Cheese, _Seed_Food_RestoreHungerMinor)	;CACO_FoodCheeseWedge01C_Nernie "Haafingar Cheese" [ALCH:0x001FB179]
	AddModFood(0x001FB177, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Cheese, _Seed_Food_RestoreHungerMinor)	;CACO_FoodCheeseWedge02C_Nernie "Ivarstead Cheese" [ALCH:0x001FB177]
	AddModFood(0x001FB175, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Cheese, _Seed_Food_RestoreHungerMinor)	;CACO_FoodCheeseWedge03C_Nernie "Rorikstead Cheese" [ALCH:0x001FB175]
	AddModFood(0x001FB17F, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Cheese, _Seed_Food_RestoreHungerMinor)	;CACO_FoodCheeseWheel01A_Nernie "Haafingar Cheese Wheel" [ALCH:0x001FB17F]
	AddModFood(0x001FB187, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Cheese, _Seed_Food_RestoreHungerMinor)	;CACO_FoodCheeseWheel01B_Nernie "Haafingar Cheese Sliced" [ALCH:0x001FB187]
	AddModFood(0x001FB17D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Cheese, _Seed_Food_RestoreHungerMinor)	;CACO_FoodCheeseWheel02A_Nernie "Ivarstead Cheese Wheel" [ALCH:0x001FB17D]
	AddModFood(0x001FB185, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Cheese, _Seed_Food_RestoreHungerMinor)	;CACO_FoodCheeseWheel02B_Nernie "Ivarstead Cheese Sliced" [ALCH:0x001FB185]
	AddModFood(0x001FB17B, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Cheese, _Seed_Food_RestoreHungerMinor)	;CACO_FoodCheeseWheel03A_Nernie "Rorikstead Cheese Wheel" [ALCH:0x001FB17B]
	AddModFood(0x001FB183, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Cheese, _Seed_Food_RestoreHungerMinor)	;CACO_FoodCheeseWheel03B_Nernie "Rorikstead Cheese Sliced" [ALCH:0x001FB183]
	
	; NEW FOOD - NON-ALCOHOLIC DRINKS
	AddModFood(0x002200F6, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkNonAlcoholic)	;CACO_FoodDrinkAlenog_Jas "Alenog" [ALCH:0x002200F6]
	AddModFood(0x00701F72, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkNonAlcoholic)	;CACO_FoodDrinkJuiceApple "Apple Juice" [ALCH:0x00701F72]
	AddModFood(0x006FCE69, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkNonAlcoholic)	;CACO_FoodDrinkJuiceCarrot "Carrot Juice" [ALCH:0x006FCE69]
	AddModFood(0x00701F74, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkNonAlcoholic)	;CACO_FoodDrinkJuiceGrape "Jazbay Grape Juice" [ALCH:0x00701F74]
	AddModFood(0x00701F71, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkNonAlcoholic)	;CACO_FoodDrinkJuiceSnowberry "Snowberry Juice" [ALCH:0x00701F71]
	AddModFood(0x006FCE6A, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkNonAlcoholic)	;CACO_FoodDrinkJuiceTomato "Tomato Juice" [ALCH:0x006FCE6A]
	AddModFood(0x00220110, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkNonAlcoholic)	;CACO_FoodDrinkTeaCanisRoot_SL00 "Canis Root Tea" [ALCH:0x00220110]
	AddModFood(0x005E65D6, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkNonAlcoholic)	;CACO_FoodDrinkTeaLavenderHoney "Lavender Honey Tea" [ALCH:0x005E65D6]
	AddModFood(0x005E65D3, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkNonAlcoholic)	;CACO_FoodDrinkTeaMugwort "Mugwort Tea" [ALCH:0x005E65D3]
			
	; NEW FOOD - FRUIT
	AddModFood(0x00220122, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMinor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodSweetJamJazbey_SL00 "Jazbay Jam" [ALCH:0x00220122]
	AddModFood(0x00220120, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMinor, _Seed_Preserved, _Seed_SaltedFood)	;CACO_FoodSweetJamSnowberry_SL00 "Snowberry Jam" [ALCH:0x00220120]

	; NEW FOOD - VEGITABLES
	AddModFood(0x00511764, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	;FoodVegCabbageHalf "Cabbage Half" [ALCH:0x00511764]	
	AddModFood(0x00220146, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	;CACO_FoodGrilledBriarHeat_SL00 "Grilled Briar Heart" [ALCH:0x00220146]
	AddModFood(0x00220106, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMushMoraTapinella_SL00 "Grilled Mora Tapinella" [ALCH:0x00220106]
	AddModFood(0x0022011E, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	;CACO_FoodMushScalyPholiota_SL00 "Grilled Scaly Pholiota" [ALCH:0x0022011E]
	AddModFood(0x002200CB, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	;CACO_FoodVegAshYamBaked "Cooked Yam" [ALCH:0x002200CB]
	AddModFood(0x00534F23, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	;CACO_FoodVegAshYamBakedOven "Baked Yam" [ALCH:0x00534F23]
	AddModFood(0x004CF8C1, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	;CACO_FoodVegCarrotsGrilled "Cooked Carrots" [ALCH:0x004CF8C1]
	AddModFood(0x00220026, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	;CACO_FoodVegPotatoesMashed_Wolfs "Mashed Potatoes" [ALCH:0x00220026]
	AddModFood(0x0050C65D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	;FoodVegPotatoesBakedOven "Baked Potatoes" [ALCH:0x0050C65D]
	
	; NEW FOOD - INGREDIENTS
	AddModFood(0x004E3D30, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	;CACO_FoodIngrListFiller "Filler" [ALCH:0x004E3D30]
	AddModFood(0x005B8C29, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	;CACO_FoodIngrMarinade "Marinade" [ALCH:0x005B8C29]
	AddModFood(0x009E056E, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	;CACO_FoodIngrOil01 "Oil" [ALCH:0x009E056E]
	AddModFood(0x009E056C, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	;CACO_FoodIngrOil02 "Oil" [ALCH:0x009E056C]
	AddModFood(0x009E056A, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	;CACO_FoodIngrOil03 "Oil" [ALCH:0x009E056A]
	AddModFood(0x009E0567, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	;CACO_FoodIngrOil04 "Oil" [ALCH:0x009E0567]
	AddModFood(0x0050750B, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	;CACO_FoodIngrSalt01 "Salt" [ALCH:0x0050750B]
	AddModFood(0x0050750A, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	;CACO_FoodIngrSalt02 "Salt" [ALCH:0x0050750A]
	AddModFood(0x004B633B, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	;CACO_FoodIngrSalt03 "Salt" [ALCH:0x004B633B]
	AddModFood(0x0050750D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	;CACO_FoodIngrSalt04 "Salt" [ALCH:0x0050750D]
	AddModFood(0x009E0574, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	;CACO_FoodIngrVinegar01 "Vinegar" [ALCH:0x009E0574]
	AddModFood(0x009E0572, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	;CACO_FoodIngrVinegar02 "Vinegar" [ALCH:0x009E0572]
	AddModFood(0x009E0570, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood)	;CACO_FoodIngrVinegar03 "Vinegar" [ALCH:0x009E0570]
	AddModFood(0x009E0568, "Complete Alchemy & Cooking Overhaul.esp", _Seed_NotFood, none, none, true)	;CACO_FoodIngrVinegar04 "Vinegar" [ALCH:0x009E0568]
	
	;NEW FOOD - WATER
	AddModFood(0x004E3D2D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkNonAlcoholic)	;CACO_FoodIngrWater01 "Jug of Water" [ALCH:0x004E3D2D]
	AddModFood(0x004E3D2B, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkNonAlcoholic)	;CACO_FoodIngrWater02 "Jug of Water" [ALCH:0x004E3D2B]
	AddModFood(0x004E3D29, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkNonAlcoholic)	;CACO_FoodIngrWater03 "Jug of Water" [ALCH:0x004E3D29]
	AddModFood(0x004E3D27, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkNonAlcoholic)	;CACO_FoodIngrWater04 "Jug of Water" [ALCH:0x004E3D27]
	AddModFood(0x004E3D25, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkNonAlcoholic)	;CACO_FoodIngrWater05 "Jug of Water" [ALCH:0x004E3D25]
	AddModFood(0x004E3D23, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkNonAlcoholic)	;CACO_FoodIngrWater06 "Jug of Water" [ALCH:0x004E3D23]
	AddModFood(0x004E3D21, "Complete Alchemy & Cooking Overhaul.esp", _Seed_DrinkNonAlcoholic)	;CACO_FoodIngrWater07 "Jug of Water" [ALCH:0x004E3D21]
	
	;NEW FOOD - OTHER
	AddModFood(0x002200A2, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	;CACO_FoodEggCooked_Nernie "Hard Boiled Egg" [ALCH:0x002200A2]
	AddModFood(0x002B18D4, "Complete Alchemy & Cooking Overhaul.esp", _Seed_Treats, _Seed_Food_RestoreHungerMajor)	;_CACO_FoodSweetCheesePudding "Sweet Cheese Pudding" [ALCH:0x002B18D4]
		
	addCACOInjectedRecords()
	addCACOBloodPotions()
	addCACOSystem()
	initialiseWaterBottles_CACO()
	initialiseMultiPartFood_CACO()
	
	_Seed_ImportCACO_Done.show()
	endif
endFunction

function addCACOInjectedRecords()
	ClearAndAddModFood(0x00CCA111, "Update.esm", _Seed_DrinkNonAlcoholic)	;CACO_FoodIngrWater "Jug of Water" [ALCH:0x00CCA111]
	ClearAndAddModFood(0x00CCA119, "Update.esm", _Seed_NotFood, none, none, true)	;CACO_FoodIngrSeasoning "Seasoning" [ALCH:0x00CCA119]
	ClearAndAddModFood(0x00CCA120, "Update.esm", _Seed_NotFood, none, none, true)	;CACO_FoodIngrSugar "Sugar" [ALCH:0x00CCA120]
	ClearAndAddModFood(0x00CCA121, "Update.esm", _Seed_DrinkMilk, _Seed_Food_RestoreHungerMinor, none, true)	;CACO_FoodDrinkMilkBottle "Milk" [ALCH:0x00CCA121]
	ClearAndAddModFood(0x00CCA122, "Update.esm", _Seed_DrinkMilk, _Seed_Food_RestoreHungerMinor, none, true)	;CACO_FoodIngrCream "Cream" [ALCH:0x00CCA122]
	ClearAndAddModFood(0x00CCA123, "Update.esm", _Seed_NotFood, none, none, true)	;CACO_FoodIngrDough "Dough" [ALCH:0x00CCA123]
	ClearAndAddModFood(0x00CCA124, "Update.esm", _Seed_NotFood, none, none, true)	;CACO_FoodIngrOil "Oil" [ALCH:0x00CCA124]
	ClearAndAddModFood(0x00CCA125, "Update.esm", _Seed_NotFood, none, none, true)	;CACO_FoodIngrVinegar "Vinegar" [ALCH:0x00CCA125]
	ClearAndAddModFood(0x00CCA126, "Update.esm", _Seed_DrinkNonAlcoholic, none, none, true)	;CACO_FoodBrothLight "Light Broth" [ALCH:0x00CCA126]
	ClearAndAddModFood(0x00CCA127, "Update.esm", _Seed_DrinkNonAlcoholic, none, none, true)	;CACO_FoodBrothBrown "Brown Broth" [ALCH:0x00CCA127]
	ClearAndAddModFood(0x00CCA128, "Update.esm", _Seed_DrinkNonAlcoholic, none, none, true)	;CACO_FoodBrothSea "Seafood Broth" [ALCH:0x00CCA128]
	ClearAndAddModFood(0x00CCA129, "Update.esm", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor, none, true)	;CACO_FoodVegOnion "Onion" [ALCH:0x00CCA129]
	ClearAndAddModFood(0x00CCA130, "Update.esm", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, none, true) ;CACO_FoodMeatHumanoidFlesh "Raw Hominid Flesh" [ALCH:0x00CCA130]
	ClearAndAddModFood(0x00CCA146, "Update.esm", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, none, true)	;CACO_FoodMeatSheepRaw "Raw Mutton" [ALCH:0x00CCA146]	
	ClearAndAddModFood(0x00CCA145, "Update.esm", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, none, true) ;CACO_FoodMeatPork "Raw Pork" [ALCH:0x00CCA145]
	ClearAndAddModFood(0x00CCA147, "Update.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMajor, none, true)	;FoodSeaSalmonWhole01 "Salmon" [ALCH:0x00CCA147]
	ClearAndAddModFood(0x00CCA148, "Update.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMajor, none, true)	;FoodSeaSalmonWhole02 "Salmon" [ALCH:0x00CCA148]
	ClearAndAddModFood(0x00CCA150, "Update.esm", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor, none, true)	;CACO_FoodFruitPumpkin "Pumpkin" [ALCH:0x00CCA150]
	ClearAndAddModFood(0x00CCA151, "Update.esm", _Seed_Fruit, _Seed_Food_RestoreHungerMinor, none, true)	;CACO_FoodFruitBlueberries "Blueberries" [ALCH:0x00CCA151]
	ClearAndAddModFood(0x00CCA152, "Update.esm", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor, none, true)	;CACO_FoodVegPeas "Peas" [ALCH:0x00CCA152]	
	ClearAndAddModFood(0x00CCA153, "Update.esm", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor, none, true)	;CACO_FoodVegScribCabbage "Scrib Cabbage" [ALCH:0x00CCA153]
	ClearAndAddModFood(0x00CCA154, "Update.esm", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor, none, true)	;CACO_FoodVegTurnip "Turnip" [ALCH:0x00CCA154]
endFunction

function addCACOBloodPotions()
	AddModFood(0x0055D7EB, "Complete Alchemy & Cooking Overhaul.esp", _Seed_BloodPotions)	; CACO_BloodPotionAltmer "Potion of Blood (Altmer)" [ALCH:0x0055D7EB]
	AddModFood(0x0055D7EE, "Complete Alchemy & Cooking Overhaul.esp", _Seed_BloodPotions)	; CACO_BloodPotionArgonian "Potion of Blood (Argonian)" [ALCH:0x0055D7EE]
	AddModFood(0x0055D7F3, "Complete Alchemy & Cooking Overhaul.esp", _Seed_BloodPotions)	; CACO_BloodPotionBosmer "Potion of Blood (Bosmer)" [ALCH:0x0055D7F3]
	AddModFood(0x0055D7F6, "Complete Alchemy & Cooking Overhaul.esp", _Seed_BloodPotions)	; CACO_BloodPotionBreton "Potion of Blood (Breton)" [ALCH:0x0055D7F6]
	AddModFood(0x0055D7F9, "Complete Alchemy & Cooking Overhaul.esp", _Seed_BloodPotions)	; CACO_BloodPotionDunmer "Potion of Blood (Dunmer)" [ALCH:0x0055D7F9]
	AddModFood(0x0055D7FB, "Complete Alchemy & Cooking Overhaul.esp", _Seed_BloodPotions)	; CACO_BloodPotionImperial "Potion of Blood (Imperial)" [ALCH:0x0055D7FB]
	AddModFood(0x0055D7FA, "Complete Alchemy & Cooking Overhaul.esp", _Seed_BloodPotions)	; CACO_BloodPotionKhajiit "Potion of Blood (Khajiit)" [ALCH:0x0055D7FA]
	AddModFood(0x0055D7F8, "Complete Alchemy & Cooking Overhaul.esp", _Seed_BloodPotions)	; CACO_BloodPotionNord "Potion of Blood (Nord)" [ALCH:0x0055D7F8]
	AddModFood(0x0055D7F7, "Complete Alchemy & Cooking Overhaul.esp", _Seed_BloodPotions)	; CACO_BloodPotionOrc "Potion of Blood (Orc)" [ALCH:0x0055D7F7]
	AddModFood(0x0055D7F2, "Complete Alchemy & Cooking Overhaul.esp", _Seed_BloodPotions)	; CACO_BloodPotionRedguard "Potion of Blood (Redguard)" [ALCH:0x0055D7F2]
endFunction

function addCACOSystem()
	AddModFood(0x005E14C8, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsFatigueLvl00 "Rested" [ALCH:0x005E14C8]
	AddModFood(0x005D72AF, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsFatigueLvl01 "Tired" [ALCH:0x005D72AF]
	AddModFood(0x005DC3C0, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsFatigueLvl02 "Fatigued" [ALCH:0x005DC3C0]
	AddModFood(0x005DC3C2, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsFatigueLvl03 "Exhausted" [ALCH:0x005DC3C2]
	AddModFood(0x005DC3C2, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsHungerLvl00 "Not Hungry" [ALCH:0x0046A34E]
	AddModFood(0x0073499B, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsHungerLvl00End "Not Hungry" [ALCH:0x0073499B]
	AddModFood(0x004FD2BA, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsHungerLvl01 "Hungry" [ALCH:0x004FD2BA]
	AddModFood(0x004FD2B7, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsHungerLvl02 "Famished" [ALCH:0x004FD2B7]
	AddModFood(0x004FD2BC, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsHungerLvl03 "Starving" [ALCH:0x004FD2BC]
	AddModFood(0x005D2185, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsSleepNotTired01 "Not Tired" [ALCH:0x005D2185]
	AddModFood(0x005D2186, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsSleepNotTired02 "Not Tired" [ALCH:0x005D2186]
	AddModFood(0x005D21A0, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsSleepNotTired03 "Not Tired" [ALCH:0x005D21A0]
	AddModFood(0x005D21A2, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsSleepNotTired04 "Not Tired" [ALCH:0x005D21A2]
	AddModFood(0x005D21A4, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsSleepNotTired05 "Not Tired" [ALCH:0x005D21A4]
	AddModFood(0x005D21A6, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsSleepNotTired06 "Not Tired" [ALCH:0x005D21A6]
	AddModFood(0x005D21A8, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsSleepNotTired07 "Not Tired" [ALCH:0x005D21A8]
	AddModFood(0x005D21AA, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsSleepNotTired08 "Not Tired" [ALCH:0x005D21AA]
	AddModFood(0x005D2188, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsSleepRested01 "Rested" [ALCH:0x005D2188]
	AddModFood(0x005D2192, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsSleepRested02 "Rested" [ALCH:0x005D2192]
	AddModFood(0x005D2194, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsSleepRested03 "Rested" [ALCH:0x005D2194]
	AddModFood(0x005D2196, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsSleepRested04 "Rested" [ALCH:0x005D2196]
	AddModFood(0x005D2198, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsSleepRested05 "Rested" [ALCH:0x005D2198]
	AddModFood(0x005D219A, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsSleepRested06 "Rested" [ALCH:0x005D219A]
	AddModFood(0x005D219C, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsSleepRested07 "Rested" [ALCH:0x005D219C]
	AddModFood(0x005D219E, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SystemFoods)	; CACO_FoodBasicNeedsSleepRested08 "Rested" [ALCH:0x005D219E]
endFunction



function addBetterVampiresBloodPotions(bool checkRequired = true)
	bool addFood = true
	if(checkRequired)
		addFood = SeedUtil.GetCompatibilitySystem().isBetterVampiresLoaded
	endif
	
	if addFood
		AddModFood(0x0050AF47, "Better Vampires.esp", _Seed_BloodPotions)	; DLC1BloodPotion2 "Stale Blood Potion" [ALCH:0x0050AF47]
	endif
endFunction

function AddBruma(bool checkRequired = true)
	bool addFood = true
	if(checkRequired)
		addFood = SeedUtil.GetCompatibilitySystem().isBrumaLoaded
	endif
	
	if addFood
		_Seed_ImportBruma.show()
		;-----------------
		; BS_DLC_patch.esp
		;-----------------
		; VEGITABALES
		ClearAndAddModFood(0x0000B9D1, "BS_DLC_patch.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	; BSKFoodCornCooked "Cooked Corn" [ALCH:0x0000B9D1]
		
		;----------------
		; BSHeartland.esm
		;----------------
		; BREAD
		ClearAndAddModFood(0x000B6C5B, "BSHeartland.esm", _Seed_Bread, _Seed_Food_RestoreHungerMajor)	; CYRFoodColovianBreadWreath "Colovian Bread Wreath" [ALCH:0x000B6C5B]
		ClearAndAddModFood(0x0005F070, "BSHeartland.esm", _Seed_Bread, _Seed_Food_RestoreHungerMajor)	; CYRFoodCornBreadA "Corn Bread" [ALCH:0x0005F070]
		ClearAndAddModFood(0x0005F066, "BSHeartland.esm", _Seed_Bread, _Seed_Food_RestoreHungerMajor)	; CYRFoodCornBreadB "Corn Bread" [ALCH:0x0005F066]
		ClearAndAddModFood(0x00071A0F, "BSHeartland.esm", _Seed_Bread, _Seed_Food_RestoreHungerMajor)	; CYRFoodRiceBreadA "Rice Bread" [ALCH:0x00071A0F]
		ClearAndAddModFood(0x00071A10, "BSHeartland.esm", _Seed_Bread, _Seed_Food_RestoreHungerMajor)	; CYRFoodRiceBreadB "Rice Bread" [ALCH:0x00071A10]
		
		
		; RAW MEAT
		ClearAndAddModFood(0x000AD219, "BSHeartland.esm", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; CYRKvatchMS02BearBait "Venison" [ALCH:0x000AD219]
		
		
		; COOKED MEAT
		ClearAndAddModFood(0x000B6C55, "BSHeartland.esm", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; CYRFoodBeefSkewer "Beef Skewer" [ALCH:0x000B6C55]
		ClearAndAddModFood(0x000DEFD2, "BSHeartland.esm", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; CYRFoodHam "Ham" [ALCH:0x000DEFD2]
		
		
		
		; RAW SMALL GAME
		ClearAndAddModFood(0x00062712, "BSHeartland.esm", _Seed_SmallGameRaw, _Seed_Food_RestoreHungerMinor)	; CYRFoodTurkey "Turkey Breast" [ALCH:0x00062712]
		
		; COOKED SMALL GAME
		ClearAndAddModFood(0x000CC280, "BSHeartland.esm", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMajor)	; CYRFoodRatCooked "Cooked Rat Meat" [ALCH:0x000CC280]
		ClearAndAddModFood(0x000721C7, "BSHeartland.esm", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMajor)	; CYRFoodTurkeyCooked "Roast Turkey" [ALCH:0x000721C7]
		
		; RAW FISH
		ClearAndAddModFood(0x00049320, "BSHeartland.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)	; CYRFoodTrout "Trout Meat" [ALCH:0x00049320]
		
		; COOKED FISH
		ClearAndAddModFood(0x000721C8, "BSHeartland.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMajor)	; CYRFoodTroutCooked "Trout Steak" [ALCH:0x000721C8]
		ClearAndAddModFood(0x000AF403, "BSHeartland.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMajor)	; CYRKvatchFF08RewardFishDish "Agvald's Seafood Surprise" [ALCH:0x000AF403]
		
		; VEGETABLES
		ClearAndAddModFood(0x00071A14, "BSHeartland.esm", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	; CYRFoodGarlicCarrots "Garlic Carrots" [ALCH:0x00071A14]
		
		
		; FRUIT
		ClearAndAddModFood(0x000B6C56, "BSHeartland.esm", _Seed_Fruit, _Seed_Food_RestoreHungerSuperior)	; CYRFoodAppleBaked "Baked Apple" [ALCH:0x000B6C56]
		ClearAndAddModFood(0x00071A13, "BSHeartland.esm", _Seed_Fruit, _Seed_Food_RestoreHungerSuperior)	; CYRFoodWatermelonSalad "Watermelon Salad" [ALCH:0x00071A13]
		
		
		
		; CHEESE
		ClearAndAddModFood(0x0005F06D, "BSHeartland.esm", _Seed_Cheese, _Seed_Food_RestoreHungerMinor)	; CYRFoodCheeseWheel01A "Cheese Wheel" [ALCH:0x0005F06D]
		ClearAndAddModFood(0x0005F06C, "BSHeartland.esm", _Seed_Cheese, _Seed_Food_RestoreHungerMinor)	; CYRFoodCheeseWheel01B "Sliced Cheese" [ALCH:0x0005F06C]
		ClearAndAddModFood(0x0005F06E, "BSHeartland.esm", _Seed_Cheese, _Seed_Food_RestoreHungerMinor)	; CYRFoodCheeseWedge01 "Cheese Wedge" [ALCH:0x0005F06E]
		ClearAndAddModFood(0x000CC27D, "BSHeartland.esm", _Seed_Cheese, _Seed_Food_RestoreHungerMinor)	; CYRFoodCheeseWheel02A "Olroy Cheese Wheel" [ALCH:0x000CC27D]
		ClearAndAddModFood(0x000CC27E, "BSHeartland.esm", _Seed_Cheese, _Seed_Food_RestoreHungerMinor)	; CYRFoodCheeseWheel02B "Sliced Olroy Cheese" [ALCH:0x000CC27E]
		ClearAndAddModFood(0x000CC27F, "BSHeartland.esm", _Seed_Cheese, _Seed_Food_RestoreHungerMinor)	; CYRFoodCheeseWedge02 "Olroy Cheese Wedge" [ALCH:0x000CC27F]
		
		Potion CYRFoodCheeseWheel01A = Game.GetFormFromFile(0x0005F06D, "BSHeartland.esm") as Potion
		Potion CYRFoodCheeseWheel01B = Game.GetFormFromFile(0x0005F06C, "BSHeartland.esm") as Potion
		Potion CYRFoodCheeseWedge01 = Game.GetFormFromFile(0x0005F06E, "BSHeartland.esm") as Potion
		UpdateMultiPartFood_Array(CYRFoodCheeseWheel01A, CYRFoodCheeseWedge01, 7)
		UpdateMultiPartFood_Array(CYRFoodCheeseWheel01B, CYRFoodCheeseWedge01, 4)
		
		Potion CYRFoodCheeseWheel02A = Game.GetFormFromFile(0x000CC27D, "BSHeartland.esm") as Potion
		Potion CYRFoodCheeseWheel02B = Game.GetFormFromFile(0x000CC27E, "BSHeartland.esm") as Potion
		Potion CYRFoodCheeseWedge02 = Game.GetFormFromFile(0x000CC27F, "BSHeartland.esm") as Potion
		UpdateMultiPartFood_Array(CYRFoodCheeseWheel02A, CYRFoodCheeseWedge02, 7)
		UpdateMultiPartFood_Array(CYRFoodCheeseWheel02B, CYRFoodCheeseWedge02, 4)
		
		; TREATS
		ClearAndAddModFood(0x000E8481, "BSHeartland.esm", _Seed_Treats, _Seed_Food_RestoreHungerSuperior)	; ELSfoodMooncake01 "Mooncake" [ALCH:0x000E8481]
		ClearAndAddModFood(0x000E85E6, "BSHeartland.esm", _Seed_Treats, _Seed_Food_RestoreHungerSuperior)	; CYRFoodSpecial30LayerCake "30 Layer Cake" [ALCH:0x000E85E6]
		ClearAndAddModFood(0x000D2F3D, "BSHeartland.esm", _Seed_Treats, _Seed_Food_RestoreHungerSuperior)	; CYRFoodSweetcake "Sweetcake" [ALCH:0x000D2F3D]
		ClearAndAddModFood(0x000F6725, "BSHeartland.esm", _Seed_Treats, _Seed_Food_RestoreHungerMinor)	; CYRFoodCarrotCake "Carrot Cake" [ALCH:0x000F6725]
		ClearAndAddModFood(0x000F6726, "BSHeartland.esm", _Seed_Treats, _Seed_Food_RestoreHungerMinor)	; CYRFoodCarrotCakeSlice "Carrot Cake slice" [ALCH:0x000F6726]
		
		Potion CYRFoodCarrotCake = Game.GetFormFromFile(0x000F6725, "BSHeartland.esm") as Potion
		Potion CYRFoodCarrotCakeSlice = Game.GetFormFromFile(0x000F6726, "BSHeartland.esm") as Potion
		UpdateMultiPartFood_Array(CYRFoodCarrotCake, CYRFoodCarrotCakeSlice, 3)
		
		; TREATS - PRESERVED
		ClearAndAddModFood(0x000B6C54, "BSHeartland.esm", _Seed_Treats, _Seed_Food_RestoreHungerMajor, _Seed_Preserved)	; CYRFoodCandyBunnies "Candy Bunnies" [ALCH:0x000B6C54]
		ClearAndAddModFood(0x000B6C58, "BSHeartland.esm", _Seed_Treats, _Seed_Food_RestoreHungerMajor, _Seed_Preserved)	; CYRFoodJamApple "Apple Jam" [ALCH:0x000B6C58]
		ClearAndAddModFood(0x000B6C59, "BSHeartland.esm", _Seed_Treats, _Seed_Food_RestoreHungerMajor, _Seed_Preserved)	; CYRFoodJamGrape "Grape Jam" [ALCH:0x000B6C59]
		ClearAndAddModFood(0x000B6C53, "BSHeartland.esm", _Seed_Treats, _Seed_Food_RestoreHungerMajor, _Seed_Preserved)	; CYRFoodLollipop "Lollipop" [ALCH:0x000B6C53]
		
		; PASTRIES - SIMPLE
		ClearAndAddModFood(0x0005F06A, "BSHeartland.esm", _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)	; CYRFoodBeefPasty "Beef Pasty" [ALCH:0x0005F06A]
		ClearAndAddModFood(0x000DEFA8, "BSHeartland.esm", _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)	; CYRFoodBlackberryCrostata "Blackberry Crostata" [ALCH:0x000DEFA8]
		ClearAndAddModFood(0x000DEFAB, "BSHeartland.esm", _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)	; CYRFoodStrawberryCrostata "Strawberry Crostata" [ALCH:0x000DEFAB]
		ClearAndAddModFood(0x0005F064, "BSHeartland.esm", _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)	; CYRFoodVenisonPasty "Venison Pasty" [ALCH:0x0005F064]
		
		; PASTRIES - COMPLEX
		ClearAndAddModFood(0x00001D7F, "BSHeartland.esm", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; CYRFoodApplewatchPie "Applewatch Pie" [ALCH:0x00001D7F]
		ClearAndAddModFood(0x00062713, "BSHeartland.esm", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; CYRFoodShepherdsPie "Shepherd's Pie" [ALCH:0x00062713]
		ClearAndAddModFood(0x000721C9, "BSHeartland.esm", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; CYRFoodSlaughterfishPie "Slaughterfish Pie" [ALCH:0x000721C9]
		ClearAndAddModFood(0x000DEFA5, "BSHeartland.esm", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; CYRFoodSurvantsPie "Survant's Pie" [ALCH:0x000DEFA5]
		ClearAndAddModFood(0x000AF401, "BSHeartland.esm", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; CYRKvatchFF08Pie "Agvald's Speciality Pie" [ALCH:0x000AF401]
		
		; STEWS - SIMPLE
		ClearAndAddModFood(0x000DEFA6, "BSHeartland.esm", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; CYRFoodFishSoup "Fish Soup" [ALCH:0x000DEFA6]
		ClearAndAddModFood(0x000721CA, "BSHeartland.esm", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; CYRFoodJuggedRabbit "Jugged Rabbit" [ALCH:0x000721CA]
		ClearAndAddModFood(0x0005F071, "BSHeartland.esm", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; CYRFoodMudrcrabStew "Mudcrab Stew" [ALCH:0x0005F071]
		
		; STEWS - COMPLEX
		ClearAndAddModFood(0x000B6C52, "BSHeartland.esm", _Seed_Stews, _Seed_Food_RestoreHungerMassive)	; CYRFoodColovianBeefStew "Colovian Beef Stew" [ALCH:0x000B6C52]
		ClearAndAddModFood(0x000721C6, "BSHeartland.esm", _Seed_Stews, _Seed_Food_RestoreHungerMassive)	; CYRFoodImperialCityStew "Imperial City Stew" [ALCH:0x000721C6]
		ClearAndAddModFood(0x000AF402, "BSHeartland.esm", _Seed_Stews, _Seed_Food_RestoreHungerMassive)	; CYRKvatchFF08RewardSoup "Agvald's Speciality Soup" [ALCH:0x000AF402]
		
		; CHEESE BOWLS
		ClearAndAddModFood(0x000B6C5A, "BSHeartland.esm", _Seed_CheeseBowls, _Seed_Food_RestoreHungerSuperior)	; CYRFoodCheeseCurds01 "Cheese Curds" [ALCH:0x000B6C5A]
		
		; ALCOHOLIC DRINK - ALE
		ClearAndAddModFood(0x0005F073, "BSHeartland.esm", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	; CYRAle "Ale" [ALCH:0x0005F073]
		ClearAndAddModFood(0x0005F06B, "BSHeartland.esm", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	; CYRFoodApplewatchCider "Applewatch Cider" [ALCH:0x0005F06B]
		ClearAndAddModFood(0x0005F069, "BSHeartland.esm", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	; CYRFoodBeer "Beer" [ALCH:0x0005F069]
		ClearAndAddModFood(0x0005F06F, "BSHeartland.esm", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	; CYRFoodGreenwoodMead "Greenwood Mead" [ALCH:0x0005F06F]
		ClearAndAddModFood(0x0005F068, "BSHeartland.esm", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	; CYRFoodMead "Mead" [ALCH:0x0005F068]
		
		; ALCOHOLIC DRINK - WINE
		ClearAndAddModFood(0x0005F065, "BSHeartland.esm", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicWine)	; CYRFoodCheapWine01 "Cheap Wine" [ALCH:0x0005F065]
		ClearAndAddModFood(0x0005F067, "BSHeartland.esm", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicWine)	; CYRFoodCheapWine02 "Cheap Wine" [ALCH:0x0005F067]
		ClearAndAddModFood(0x00062715, "BSHeartland.esm", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicWine)	; CYRFoodShadowbanishWine "Shadowbanish Wine" [ALCH:0x00062715]
		ClearAndAddModFood(0x00062716, "BSHeartland.esm", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicWine)	; CYRFoodColovianBattlecry "Colovian Battlecry" [ALCH:0x00062716]
		
		; ALCOHOLIC DRINK - SPIRITS
		ClearAndAddModFood(0x0005F072, "BSHeartland.esm", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicSpirit)	; CYRFlin "Flin" [ALCH:0x0005F072]
		ClearAndAddModFood(0x000858EF, "BSHeartland.esm", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicSpirit)	; CYRFoodBrandyBottle01A "Brandy" [ALCH:0x000858EF]
		ClearAndAddModFood(0x000DF0DB, "BSHeartland.esm", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicSpirit)	; CYRFoodBrandyBottle02 "Brandy Flask" [ALCH:0x000DF0DB]
		
		;-------------
		; BSAssets.esm
		;-------------
		; BREAD
		ClearAndAddModFood(0x00602945, "BSAssets.esm", _Seed_Bread, _Seed_Food_RestoreHungerMajor)	; BSKFoodEyebread "Eyebread" [ALCH:0x00602945]
		ClearAndAddModFood(0x00602945, "BSAssets.esm", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	; BSKBYOHFoodButter_PROXY_HF "Butter" [ALCH:0x00602B1C]
		ClearAndAddModFood(0x00602945, "BSAssets.esm", _Seed_Bread, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	; BSKBYOHFoodFlour_PROXY_HF "Sack of Flour" [ALCH:0x00602B1B]
		ClearAndAddModFood(0x00602945, "BSAssets.esm", _Seed_Bread, _Seed_Food_RestoreHungerMajor)	; BSKFoodSteamedRice "Steamed Rice" [ALCH:0x0060202D]
		
		; RAW MEAT
		ClearAndAddModFood(0x006020AE, "BSAssets.esm", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; BSKFoodBoarMeat "Boar Meat" [ALCH:0x006020AE]
		ClearAndAddModFood(0x006028D8, "BSAssets.esm", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; BSKFoodLambLeg "Lamb Leg" [ALCH:0x006028D8]
		ClearAndAddModFood(0x006028B7, "BSAssets.esm", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; BSKFoodSheepMeat "Mutton Leg" [ALCH:0x006028B7]
		
		; COOKED MEAT
		ClearAndAddModFood(0x006020AF, "BSAssets.esm", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; BSKFoodBoarMeatCooked "Cooked Boar Meat" [ALCH:0x006020AF]
		ClearAndAddModFood(0x006028C6, "BSAssets.esm", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; BSKFoodLambCooked "Roast Lamb" [ALCH:0x006028C6]
		ClearAndAddModFood(0x006028B8, "BSAssets.esm", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; BSKFoodSheepMeatCooked "Mutton Roast" [ALCH:0x006028B8]
		
		
		; RAW SMALL GAME
		ClearAndAddModFood(0x006020AD, "BSAssets.esm", _Seed_SmallGameRaw, _Seed_Food_RestoreHungerMinor)	; BSKFoodRatMeat "Rat Meat" [ALCH:0x006020AD]
		
		; COOKED SMALL GAME
		ClearAndAddModFood(0x0060280E, "BSAssets.esm", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; BSKFoodEggBoiled "Boiled Egg" [ALCH:0x0060280E]
		
		; RAW SEAFOOD
		ClearAndAddModFood(0x00602B1D, "BSAssets.esm", _Seed_SeafoodRaw, _Seed_Food_RestoreHungerMinor)	; BSKBYOHFoodMudcrabLegs_PROXY_HF "Mudcrab Legs" [ALCH:0x00602B1D]
		
		; VEGITABLES
		ClearAndAddModFood(0x00601421, "BSAssets.esm", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) ; BSEdjeFoodCabbageRed01 "Red Cabbage" [ALCH:0x00601421]
		ClearAndAddModFood(0x00602B07, "BSAssets.esm", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) ; BSKFoodBeet "Beet" [ALCH:0x00602B07]
		ClearAndAddModFood(0x00602943, "BSAssets.esm", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	; BSKFoodCabbageRoll "Cabbage Roll" [ALCH:0x00602943]
		ClearAndAddModFood(0x006020AC, "BSAssets.esm", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; BSKFoodLettuce "Lettuce" [ALCH:0x006020AC]
		ClearAndAddModFood(0x00601FB8, "BSAssets.esm", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; BSKFoodParsnip "Parsnip" [ALCH:0x00601FB8]
		ClearAndAddModFood(0x00601FC8, "BSAssets.esm", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; BSKFoodPumpkin "Pumpkin" [ALCH:0x00601FC8]
		ClearAndAddModFood(0x00602812, "BSAssets.esm", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; BSKFoodRadish "Radish" [ALCH:0x00602812]
		ClearAndAddModFood(0x00602564, "BSAssets.esm", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; BSKFoodScribCabbage "Scrib Cabbage" [ALCH:0x00602564]
		ClearAndAddModFood(0x0060283C, "BSAssets.esm", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; BSKFoodCorn "Corn" [ALCH:0x0060283C]
		
		; FRUIT
		ClearAndAddModFood(0x0060283A, "BSAssets.esm", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)	; BSKFoodBanana "Banana" [ALCH:0x0060283A]
		ClearAndAddModFood(0x00602991, "BSAssets.esm", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)	; BSKFoodCherry "Cherry" [ALCH:0x00602991]
		ClearAndAddModFood(0x00601FCA, "BSAssets.esm", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)	; BSKFoodGrapes "Grapes" [ALCH:0x00601FCA]
		ClearAndAddModFood(0x0060280B, "BSAssets.esm", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)	; BSKFoodOrange "Orange" [ALCH:0x0060280B]
		ClearAndAddModFood(0x00602079, "BSAssets.esm", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)	; BSKFoodPeach "Peach" [ALCH:0x00602079]
		ClearAndAddModFood(0x00602078, "BSAssets.esm", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)	; BSKFoodPear "Pear" [ALCH:0x00602078]
		ClearAndAddModFood(0x00602839, "BSAssets.esm", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)	; BSKFoodStrawberry "Strawberry" [ALCH:0x00602839]
		ClearAndAddModFood(0x00601911, "BSAssets.esm", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)	; BSKFoodWatermelon "Watermelon" [ALCH:0x00601911]
		
		; TREATS
		ClearAndAddModFood(0x0060280F, "BSAssets.esm", _Seed_Treats, _Seed_Food_RestoreHungerSuperior)	; BSKFoodFlapjack "Flapjack" [ALCH:0x0060280F]
		
		; MILK
		ClearAndAddModFood(0x0060280A, "BSAssets.esm", _Seed_DrinkMilk, _Seed_Food_RestoreHungerMinor)	; BSKFoodJugofCream01 "Jug of Cream" [ALCH:0x0060280A]
		ClearAndAddModFood(0x00602810, "BSAssets.esm", _Seed_DrinkMilk, _Seed_Food_RestoreHungerMinor)	; BSKFoodJugofCream02 "Jug of Cream" [ALCH:0x00602810]
		ClearAndAddModFood(0x00602B18, "BSAssets.esm", _Seed_DrinkMilk, _Seed_Food_RestoreHungerMinor)	; BSKBYOHFoodMilk_PROXY_HF "Jug of Milk" [ALCH:0x00602B18]
		
		; ALCOHOLIC DRINK - WINE
		ClearAndAddModFood(0x00602B1A, "BSAssets.esm", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicWine)	; BSKBYOHFoodWineBottle03_PROXY_HF "Surilie Brothers Wine" [ALCH:0x00602B1A]
		ClearAndAddModFood(0x00602B19, "BSAssets.esm", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicWine)	; BSKBYOHFoodWineBottle04_PROXY_HF "Argonian Bloodwine" [ALCH:0x00602B19]   
		
		; NON-ALCOHOLIC DRINKS
		ClearAndAddModFood(0x00602B19, "BSAssets.esm", _Seed_DrinkNonAlcoholic)	; BSKFoodCoffee "Coffee" [ALCH:0x0060298B]
		ClearAndAddModFood(0x00602B19, "BSAssets.esm", _Seed_DrinkNonAlcoholic)	; BSKFoodCoffee02Green "Coffee" [ALCH:0x0060298D]
		ClearAndAddModFood(0x00602B19, "BSAssets.esm", _Seed_DrinkNonAlcoholic)	; BSKFoodCoffeeTankard "Coffee Tankard" [ALCH:0x0060298C]
		
		initialiseWaterBottles_Bruma()
		
		_Seed_ImportBruma_Done.show()
	endif
endFunction

function AddHunterborn(bool checkRequired = true)
	bool addFood = true
	if(checkRequired)
		addFood = SeedUtil.GetCompatibilitySystem().isHunterbornLoaded
	endif
	
	if addFood
		_Seed_ImportHunterborn.show()
		
		; MeatRaw
		ClearAndAddModFood(0x0009C5D7, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_Pet_Meat "Smelly Meat" [ALCH:0x0009C5D7]
		ClearAndAddModFood(0x00014795, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_Raw_Bear "Raw Bear Meat" [ALCH:0x00014795]
		ClearAndAddModFood(0x00029849, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_Raw_Dragon "Raw Dragon Meat" [ALCH:0x00029849]
		ClearAndAddModFood(0x00014D21, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_Raw_Elk "Venison (Elk)" [ALCH:0x00014D21]
		ClearAndAddModFood(0x0001479A, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_Raw_Goat "Raw Goat Meat" [ALCH:0x0001479A]
		ClearAndAddModFood(0x0001479E, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_Raw_Mammoth "Raw Mammoth Meat" [ALCH:0x0001479E]
		ClearAndAddModFood(0x000147A0, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_Raw_Sabrecat "Raw Sabre Cat Meat" [ALCH:0x000147A0]
		ClearAndAddModFood(0x00014796, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_Raw_Skeever "Raw Skeever Meat" [ALCH:0x00014796]
		ClearAndAddModFood(0x00014D24, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_Raw_Slaughterfish "Raw Slaughterfish Meat" [ALCH:0x00014D24]
		ClearAndAddModFood(0x00029847, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_Raw_Troll "Raw Troll Meat" [ALCH:0x00029847]
		ClearAndAddModFood(0x0001479C, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_Raw_Wolf "Raw Wolf Meat" [ALCH:0x0001479C]
		ClearAndAddModFood(0x00029846, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_Raw_Spider "Raw Spider Meat" [ALCH:0x00029846]
		ClearAndAddModFood(0x00027783, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_Raw_Chaurus "Raw Chaurus Meat" [ALCH:0x00027783]
		
		
		; MeatCooked
		ClearAndAddModFood(0x000314C5, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)        ;_DS_Food_BoiledSpiderPaste "Boiled Spider Paste" [ALCH:0x000314C5]
		ClearAndAddModFood(0x00199A0C, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)    ;HB_FireFood_Food_BearSteak "Bear Steak" [ALCH:0x00199A0C]
		ClearAndAddModFood(0x00199A0D, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)    ;HB_FireFood_Food_MammothSteak "Mammoth Steak" [ALCH:0x00199A0D]
		ClearAndAddModFood(0x00199A0E, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)    ;HB_FireFood_Food_SearedSabreCat "Seared Sabre Cat" [ALCH:0x00199A0E]
		ClearAndAddModFood(0x00017E25, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_AleBraisedSabreCat "Ale Braised Sabre Cat" [ALCH:0x00017E25]
		ClearAndAddModFood(0x00017E2D, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_BreadedElkCutlet "Breaded Elk Cutlet" [ALCH:0x00017E2D]
		ClearAndAddModFood(0x00031A49, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)    ;_DS_Food_CarrotPotatoDragon "Carrot, Potato, Dragon" [ALCH:0x00031A49]
		ClearAndAddModFood(0x00029DBA, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_CharredTroll "Charred Troll" [ALCH:0x00029DBA]
		ClearAndAddModFood(0x000314CC, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_ChaurusChops "Chaurus Chops" [ALCH:0x000314CC]
		ClearAndAddModFood(0x00029DBC, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_DragonSteak "Dragon Steak" [ALCH:0x00029DBC]
		ClearAndAddModFood(0x00017E43, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_ElfEaredElk "Elf Eared Elk" [ALCH:0x00017E43]
		ClearAndAddModFood(0x00017E35, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_ElkSteak "Elk Steak" [ALCH:0x00017E35]
		ClearAndAddModFood(0x00017E37, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_GoatHaunch "Goat Haunch" [ALCH:0x00017E37]
		ClearAndAddModFood(0x00017E45, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)    ;_DS_Food_GoatPotatoes "Goat and Potatoes" [ALCH:0x00017E45]
		ClearAndAddModFood(0x00017E3D, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_HoneyedMammothRoast "Honeyed Mammoth Roast" [ALCH:0x00017E3D]
		ClearAndAddModFood(0x00012C6C, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_HorseHeart "Horse Heart" [ALCH:0x00012C6C]
		ClearAndAddModFood(0x00017E1D, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior, _Seed_SaltedFood, _Seed_Preserved)        ;_DS_Food_HorseJerky "Horse Jerky" [ALCH:0x00017E1D]
		ClearAndAddModFood(0x00017E49, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)        ;_DS_Food_HotHoneyHorker "Hot Honey Horker" [ALCH:0x00017E49]
		ClearAndAddModFood(0x00017E4B, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_MarinatedMammothElsweyr "Marinated Mammoth in Elsweyr Sauce" [ALCH:0x00017E4B]
		ClearAndAddModFood(0x00017E29, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)        ;_DS_Food_MeadBraisedBear "Mead Braised Bear" [ALCH:0x00017E29]
		ClearAndAddModFood(0x00017E3F, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)        ;_DS_Food_MincedMarinatedBear "Minced Marinated Bear" [ALCH:0x00017E3F]
		ClearAndAddModFood(0x00017E31, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)        ;_DS_Food_MullwineBraisedMammoth "Mullwine Braised Mammoth" [ALCH:0x00017E31]
		ClearAndAddModFood(0x00017E23, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)        ;_DS_Food_MuttChop "Mutt Chop" [ALCH:0x00017E23]
		ClearAndAddModFood(0x00012C6B, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)        ;_DS_Food_OxHeart "Ox Heart" [ALCH:0x00012C6B]
		ClearAndAddModFood(0x00078EAD, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)        ;_DS_Food_RoastBoar "Roast Boar" [ALCH:0x00078EAD]
		ClearAndAddModFood(0x00017E33, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_SabreCatPotRoast "Sabre Cat Pot Roast" [ALCH:0x00017E33]
		ClearAndAddModFood(0x000F2794, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)        ;_DS_Food_SausagedRat "Sausaged Rat" [ALCH:0x000F2794]
		ClearAndAddModFood(0x00017E51, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)        ;_DS_Food_SkeweredSkeever "Skewered Skeever" [ALCH:0x00017E51]
		ClearAndAddModFood(0x00017E3B, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)        ;_DS_Food_SmokedElkRoast "Smoked Elk Roast" [ALCH:0x00017E3B]
		ClearAndAddModFood(0x00017E0D, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)        ;_DS_Food_SpicedDicedGoat "Spiced Diced Goat" [ALCH:0x00017E0D]
		ClearAndAddModFood(0x000314C4, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)        ;_DS_Food_SpiderFry "Spider Fry" [ALCH:0x000314C4]
		ClearAndAddModFood(0x000314CD, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior, _Seed_SaltedFood, _Seed_Preserved)        ;_DS_Food_TrollJerky "Troll Jerky" [ALCH:0x000314CD]
		ClearAndAddModFood(0x00017E1B, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior, _Seed_SaltedFood, _Seed_Preserved)        ;_DS_Food_VenisonJerky "Venison Jerky" [ALCH:0x00017E1B]
		ClearAndAddModFood(0x00017E2B, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)        ;_DS_Food_VenisonTenderloin "Venison Tenderloin" [ALCH:0x00017E2B]
		ClearAndAddModFood(0x00017E27, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_WolfChopSnowberry "Wolf Chop in Snowberry Sauce" [ALCH:0x00017E27]
		ClearAndAddModFood(0x00017E39, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)        ;_DS_Food_WolfHaunch "Wolf Haunch" [ALCH:0x00017E39]
		ClearAndAddModFood(0x000314D7, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_WyrmChips "Wyrm and Chips" [ALCH:0x000314D7]
		ClearAndAddModFood(0x000ED67E, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_Teabag_DeviledChaurus "Deviled Chaurus" [ALCH:0x000ED67E]
		ClearAndAddModFood(0x000ED670, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_Teabag_GlazedGoatLoin "Glazed Goat Loin" [ALCH:0x000ED670]
		ClearAndAddModFood(0x000ED67A, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_Teabag_FarmersBreakfast "Farmer's Breakfast" [ALCH:0x000ED67A]
		ClearAndAddModFood(0x000ED680, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_Teabag_FattyFinFry "Fatty Fin Fry" [ALCH:0x000ED680]
		ClearAndAddModFood(0x000F2785, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_Teabag_FlamingDragon "Flaming Dragon" [ALCH:0x000F2785]
		ClearAndAddModFood(0x000F2789, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_Teabag_FoxHole "Fox in a Hole" [ALCH:0x000F2789]
		ClearAndAddModFood(0x000F2787, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_Teabag_MammothBalls "Mammoth Balls" [ALCH:0x000F2787]
		ClearAndAddModFood(0x000F2783, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_Teabag_MashedTroll "Mashed Troll" [ALCH:0x000F2783]
		ClearAndAddModFood(0x000F278B, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_Teabag_PredatorsPrice "Predators' Price" [ALCH:0x000F278B]
		ClearAndAddModFood(0x000F278D, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_Teabag_SkeeverScramble "Skeever Scramble" [ALCH:0x000F278D]
		ClearAndAddModFood(0x000ED66E, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_Teabag_SpiderSurprise "Spider Surprise" [ALCH:0x000ED66E]
		ClearAndAddModFood(0x000ED672, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_Teabag_SpottedDog "Spotted Dog" [ALCH:0x000ED672]
		ClearAndAddModFood(0x000ED67C, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_Teabag_WoolCoat "Wool Coat" [ALCH:0x000ED67C]
		
		
		
		; SmallGameRaw
		ClearAndAddModFood(0x0009C5CF, "Hunterborn.esp", _Seed_SmallGameRaw, _Seed_Food_RestoreHungerMinor)        ;_DS_Food_Pet_Chicken "Tasty Chicken" [ALCH:0x0009C5CF]
		ClearAndAddModFood(0x0011AFC8, "Hunterborn.esp", _Seed_SmallGameRaw, _Seed_Food_RestoreHungerMinor) ;_DS_Food_Pet_Chicken_Arctic "Placeholder" [ALCH:0x0011AFC8]
		ClearAndAddModFood(0x00014798, "Hunterborn.esp", _Seed_SmallGameRaw, _Seed_Food_RestoreHungerMinor)         ;_DS_Food_Raw_Fox "Raw Fox Meat" [ALCH:0x00014798]
		ClearAndAddModFood(0x000147A2, "Hunterborn.esp", _Seed_SmallGameRaw, _Seed_Food_RestoreHungerMinor) ;_DS_Food_Raw_Hare "Raw Rabbit Meat" [ALCH:0x000147A2]
		ClearAndAddModFood(0x00014228, "Hunterborn.esp", _Seed_SmallGameRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_Food_EdibleInsect "Edible Insect" [ALCH:0x00014228]
		
		
		; SmallGameCooked
		ClearAndAddModFood(0x00017E47, "Hunterborn.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_DragonStuffedRabbit "Dragon Stuffed Rabbit" [ALCH:0x00017E47]
		ClearAndAddModFood(0x00017E2F, "Hunterborn.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_FoxHerbCutlet "Fox Herb Cutlet" [ALCH:0x00017E2F]
		ClearAndAddModFood(0x00017E1F, "Hunterborn.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_SearedFox "Seared Fox" [ALCH:0x00017E1F]
		ClearAndAddModFood(0x00017E21, "Hunterborn.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_SearedRabbit "Seared Rabbit" [ALCH:0x00017E21]
		ClearAndAddModFood(0x000ED66A, "Hunterborn.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_Teabag_RarebitRagout "Rarebit Ragout" [ALCH:0x000ED66A]
		
		; FishCooked
		ClearAndAddModFood(0x000ED674, "Hunterborn.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_Teabag_FishCrabSauce "Fish with Crab Sauce" [ALCH:0x000ED674]
		ClearAndAddModFood(0x00017E53, "Hunterborn.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_VelvetSlaughter "Velvet Slaughter" [ALCH:0x00017E53]
		ClearAndAddModFood(0x000E8564, "Hunterborn.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_Teabag_SalmonBake "Salmon Bake" [ALCH:0x000E8564]
		
		; SeafoodRaw
		ClearAndAddModFood(0x00014D22, "Hunterborn.esp", _Seed_SeafoodRaw, _Seed_Food_RestoreHungerMinor)    ;_DS_Food_Raw_Mudcrab "Raw Mudcrab Meat" [ALCH:0x00014D22]
		
		; SeafoodCooked
		ClearAndAddModFood(0x00017E4D, "Hunterborn.esp", _Seed_SeafoodCooked, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_BoiledMudcrab "Boiled Mudcrab" [ALCH:0x00017E4D]
		ClearAndAddModFood(0x00017E4F, "Hunterborn.esp", _Seed_SeafoodCooked, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_MudcrabEgg "Mudcrab Egg Scramble" [ALCH:0x00017E4F]
		ClearAndAddModFood(0x000ED676, "Hunterborn.esp", _Seed_SeafoodCooked, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_Teabag_MorthalMudders "Morthal Mudders" [ALCH:0x000ED676]
		ClearAndAddModFood(0x000ED678, "Hunterborn.esp", _Seed_SeafoodCooked, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_Teabag_OceansKiss "Ocean's Kiss" [ALCH:0x000ED678]
			
		; Vegetables
		ClearAndAddModFood(0x00014226, "Hunterborn.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)    ;_DS_Food_EdibleFlower "Edible Flower" [ALCH:0x00014226]
		ClearAndAddModFood(0x0001422A, "Hunterborn.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)    ;_DS_Food_EdibleMushroom "Edible Mushroom" [ALCH:0x0001422A]
		ClearAndAddModFood(0x0009C5C9, "Hunterborn.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)    ;_DS_Food_Pet_Carrot "Tasty Carrot" [ALCH:0x0009C5C9]
		
		; Fruit
		ClearAndAddModFood(0x0001422E, "Hunterborn.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_EdibleBerry "Edible Berry" [ALCH:0x0001422E]
		ClearAndAddModFood(0x000C4E31, "Hunterborn.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMinor)     ;_DS_Food_EdibleBerryBunch "Bunch of Berries" [ALCH:0x000C4E31]
		ClearAndAddModFood(0x0001422C, "Hunterborn.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMinor)        ;_DS_Food_EdibleRoot "Edible Root" [ALCH:0x0001422C]
		ClearAndAddModFood(0x00055772, "Hunterborn.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)    ;_DS_Food_Watermelon "Watermelon" [ALCH:0x00055772]
		
		
		; Pastries
		ClearAndAddModFood(0x00029854, "Hunterborn.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)    ;_DS_Food_ChaurusPie "Chaurus Pie" [ALCH:0x00029854]
		ClearAndAddModFood(0x000314D4, "Hunterborn.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)        ;_DS_Food_DragonBloodPudding "Dragon Blood-Pudding" [ALCH:0x000314D4]
		ClearAndAddModFood(0x00017E55, "Hunterborn.esp", _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_SweetWolf "Sweetwolf" [ALCH:0x00017E55]
		
		; Stews
		ClearAndAddModFood(0x00017E13, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ;_DS_Food_MudcrabChowder "Mudcrab Chowder" [ALCH:0x00017E13]
		ClearAndAddModFood(0x00017E08, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ;_DS_Food_BearCarrotStew "Bear Carrot Stew" [ALCH:0x00017E08]
		ClearAndAddModFood(0x00078EAB, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ;_DS_Food_BoarLeekStew "Boar Leek Stew" [ALCH:0x00078EAB]
		ClearAndAddModFood(0x00078EA9, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ;_DS_Food_BoarPotatoStew "Boar Potato Stew" [ALCH:0x00078EA9]
		ClearAndAddModFood(0x000314D1, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ;_DS_Food_DragonHeartStew "Dragon Heart Stew" [ALCH:0x000314D1]
		ClearAndAddModFood(0x00017E0B, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_FoxAppleStew "Fox Apple Stew" [ALCH:0x00017E0B]
		ClearAndAddModFood(0x00017E09, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_HuntersStew "Hunter's Hearty Stew" [ALCH:0x00017E09]
		ClearAndAddModFood(0x00017E11, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_MammothTomatoStew "Mammoth Tomato Stew" [ALCH:0x00017E11]
		ClearAndAddModFood(0x000314C9, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ;_DS_Food_PoisonersStew "Poisoner's Stew" [ALCH:0x000314C9]
		ClearAndAddModFood(0x00017E0F, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_RabbitMushroomStew "Rabbit Mushroom Stew" [ALCH:0x00017E0F]
		ClearAndAddModFood(0x00017E15, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_SaltySabredStew "Salty Sabred Stew" [ALCH:0x00017E15]
		ClearAndAddModFood(0x00017E17, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ;_DS_Food_SkeevenderStew "Skeevender Stew" [ALCH:0x00017E17]
		ClearAndAddModFood(0x00029DB9, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ;_DS_Food_SpiderSoup "Spider Soup" [ALCH:0x00029DB9]
		ClearAndAddModFood(0x00017E19, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_WolfCabbageStew "Wolf Cabbage Stew" [ALCH:0x00017E19]
		ClearAndAddModFood(0x0007DFB3, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ;_DS_Food_WatermelonGazpacho "Watermelon Gazpacho" [ALCH:0x0007DFB3]
		ClearAndAddModFood(0x000F278F, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_Teabag_BearBeerCheeseChowder "Bear and Beer Cheese Chowder" [ALCH:0x000F278F]
		ClearAndAddModFood(0x000ED66C, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ;_DS_Food_Teabag_BeggarsBroth "Humble Stew" [ALCH:0x000ED66C]
		ClearAndAddModFood(0x000ED667, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_Teabag_HighKingsStew "High King's Stew" [ALCH:0x000ED667]
		ClearAndAddModFood(0x000F2791, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_Teabag_ReachmenSoup "Reachmen Soup" [ALCH:0x000F2791]
		ClearAndAddModFood(0x00017E41, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ;_DS_Food_RootBear "Root Bear" [ALCH:0x00017E41]
		
		
		
		
		
		; DrinkNonAlcoholic
		ClearAndAddModFood(0x000402D7, "Hunterborn.esp", _Seed_DrinkNonAlcoholic)        ;_DS_Tea_Juniper "Juniper Tea" [ALCH:0x000402D7]
		ClearAndAddModFood(0x000402DA, "Hunterborn.esp", _Seed_DrinkNonAlcoholic)    ;_DS_Tea_Lavender "Lavender Tea" [ALCH:0x000402DA]
		ClearAndAddModFood(0x000402DE, "Hunterborn.esp", _Seed_DrinkNonAlcoholic)    ;_DS_Tea_MoonDance "Moon Dance Tea" [ALCH:0x000402DE]
		ClearAndAddModFood(0x000402DC, "Hunterborn.esp", _Seed_DrinkNonAlcoholic)    ;_DS_Tea_MountainFlower "Mountain Flower Tea" [ALCH:0x000402DC]
		ClearAndAddModFood(0x000402E0, "Hunterborn.esp", _Seed_DrinkNonAlcoholic)        ;_DS_Tea_NirnSpring "Nirn Spring Tea" [ALCH:0x000402E0]
		ClearAndAddModFood(0x000402E2, "Hunterborn.esp", _Seed_DrinkNonAlcoholic)        ;_DS_Tea_Snowberry "Snowberry Tea" [ALCH:0x000402E2]
		ClearAndAddModFood(0x0003FD68, "Hunterborn.esp", _Seed_DrinkNonAlcoholic)        ;_DS_Tea_TenDragons "Ten Dragons Tea" [ALCH:0x0003FD68]
		ClearAndAddModFood(0x000402E4, "Hunterborn.esp", _Seed_DrinkNonAlcoholic)        ;_DS_Tea_WheatBoon "Wheat Boon Tea" [ALCH:0x000402E4]
		
		
		; FROZEN FOOD - LE ONLY
		if !isSpecialEdition()
			ClearAndAddModFood(0x00152B62, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)        ;_DS_DLC2FoodAshHopperMeat_Frozen "Ash Hopper Meat (Frozen)" [ALCH:0x00152B62]
			ClearAndAddModFood(0x00152B64, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_DLC2FoodBoarMeat_Frozen "Boar Meat (Frozen)" [ALCH:0x00152B64]
			ClearAndAddModFood(0x00152B70, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_FoodBeef_Frozen "Raw Beef (Frozen)" [ALCH:0x00152B70]
			ClearAndAddModFood(0x00152B72, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_FoodChicken_Frozen "Chicken Breast (Frozen)" [ALCH:0x00152B72]
			ClearAndAddModFood(0x00152B66, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_FoodClamMeat_Frozen "Clam Meat (Frozen)" [ALCH:0x00152B66]
			ClearAndAddModFood(0x00152B68, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_FoodDogMeat_Frozen "Dog Meat (Frozen)" [ALCH:0x00152B68]
			ClearAndAddModFood(0x00152B6A, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_FoodGoatMeat_Frozen "Leg of Goat (Frozen)" [ALCH:0x00152B6A]
			ClearAndAddModFood(0x00152B6C, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_FoodHorkerMeat_Frozen "Horker Meat (Frozen)" [ALCH:0x00152B6C]
			ClearAndAddModFood(0x00152B6E, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_FoodHorseMeat_Frozen "Horse Meat (Frozen)" [ALCH:0x00152B6E]
			ClearAndAddModFood(0x00152B74, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_FoodMammothMeat_Frozen "Mammoth Snout (Frozen)" [ALCH:0x00152B74]
			ClearAndAddModFood(0x00152B76, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_FoodPheasant_Frozen "Pheasant Breast (Frozen)" [ALCH:0x00152B76]
			ClearAndAddModFood(0x00152B78, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_FoodRabbit_Frozen "Raw Rabbit Leg (Frozen)" [ALCH:0x00152B78]
			ClearAndAddModFood(0x00152B7A, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_FoodSalmon_Frozen "Salmon Meat (Frozen)" [ALCH:0x00152B7A]
			ClearAndAddModFood(0x00152B60, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_FoodVenison_Frozen "Venison (Frozen)" [ALCH:0x00152B60]
			ClearAndAddModFood(0x00152B5E, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_Food_Raw_Wolf_Frozen "Raw Wolf Meat (Frozen)" [ALCH:0x00152B5E]
			ClearAndAddModFood(0x00152B41, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_Food_Raw_Bear_Frozen "Raw Bear Meat (Frozen)" [ALCH:0x00152B41]
			ClearAndAddModFood(0x00152B46, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_Food_Raw_Chaurus_Frozen "Raw Chaurus Meat (Frozen)" [ALCH:0x00152B46]
			ClearAndAddModFood(0x00152B48, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_Food_Raw_Elk_Frozen "Venison (Elk, Frozen)" [ALCH:0x00152B48]
			ClearAndAddModFood(0x00152B4A, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_Food_Raw_Fox_Frozen "Raw Fox Meat (Frozen)" [ALCH:0x00152B4A]
			ClearAndAddModFood(0x00152B4C, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_Food_Raw_Goat_Frozen "Raw Goat Meat (Frozen)" [ALCH:0x00152B4C]
			ClearAndAddModFood(0x00152B4E, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_Food_Raw_Hare_Frozen "Raw Rabbit Meat (Frozen)" [ALCH:0x00152B4E]
			ClearAndAddModFood(0x00152B50, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_Food_Raw_Mammoth_Frozen "Raw Mammoth Meat (Frozen)" [ALCH:0x00152B50]
			ClearAndAddModFood(0x00152B52, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_Food_Raw_Mudcrab_Frozen "Raw Mudcrab Meat (Frozen)" [ALCH:0x00152B52]
			ClearAndAddModFood(0x00152B54, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_Food_Raw_Sabrecat_Frozen "Raw Sabre Cat Meat (Frozen)" [ALCH:0x00152B54]
			ClearAndAddModFood(0x00152B56, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_Food_Raw_Skeever_Frozen "Raw Skeever Meat (Frozen)" [ALCH:0x00152B56]
			ClearAndAddModFood(0x00152B58, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_Food_Raw_Slaughterfish_Frozen "Raw Slaughterfish Meat (Frozen)" [ALCH:0x00152B58]
			ClearAndAddModFood(0x00152B5A, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_Food_Raw_Spider_Frozen "Raw Spider Meat (Frozen)" [ALCH:0x00152B5A]
			ClearAndAddModFood(0x00152B5C, "Hunterborn.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)    ;_DS_Food_Raw_Troll_Frozen "Raw Troll Meat (Frozen)" [ALCH:0x00152B5C]
		endif
		
		
		
		; SE ONLY FOOD
		if isSpecialEdition()
			ClearAndAddModFood(0X0028CCFA, "Hunterborn.esp", _Seed_DrinkNonAlcoholic)                ;_DS_Food_Water "Water" [ALCH:0X0028CCFA]
			ClearAndAddModFood(0X00240CD0, "Hunterborn.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicWine)    ;_DS_Potn_Wine_Diseased "Poisoned Wine" [ALCH:0X00240CD0]
			ClearAndAddModFood(0X00240CDD, "Hunterborn.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicWine)    ;_DS_Potn_Wine_Fine "Fine Wine" [ALCH:0X00240CDD]
			ClearAndAddModFood(0X00240CDB, "Hunterborn.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicWine)       ;_DS_Potn_Wine_Spoiled "Spoiled Wine" [ALCH:0X00240CDB]
			ClearAndAddModFood(0X00287BF7, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)       ;_DS_Food_BoiledCabbageMammoth "Boiled Cabbage and Mammoth" [ALCH:0X00287BF7]
			ClearAndAddModFood(0X002A1197, "Hunterborn.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)        ; _DS_Food_EdibleMushroom2 "Edible Mushroom" [ALCH:0X002A1197]
			ClearAndAddModFood(0X0022776D, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior, _Seed_SaltedFood, _Seed_Preserved)        ; _DS_Food_MammothJerky "Mammoth Jerky" [ALCH:0X0022776D]
			ClearAndAddModFood(0X001C2257, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMinor)    ; _DS_Food_SearedFat "Seared Fat" [ALCH:0X001C2257]
			ClearAndAddModFood(0X0022776B, "Hunterborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)        ; _DS_Food_SearedMammoth "Seared Mammoth" [ALCH:0X0022776B]
			
			ClearAndAddModFood(0X002A1194, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Soup_BoiledMushrooms "Boiled Mushrooms" [ALCH:0X002A1194]
			ClearAndAddModFood(0X002AB3BA, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Soup_Cold "Cold Soup" [ALCH:0X002AB3BA]
			ClearAndAddModFood(0X0028CD18, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Soup_Meat "Soup Meat" [ALCH:0X0028CD18]
			ClearAndAddModFood(0X0029C06B, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Soup_MeatMushroom "Soup Meat Mushroom" [ALCH:0X0029C06B]
			ClearAndAddModFood(0X0029C06D, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Soup_MeatSeasonedMushroom "Soup Meat Seasoned Mushroom" [ALCH:0X0029C06D]
			ClearAndAddModFood(0X0028CD22, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Soup_MeatSeasoned "Soup Meat Seasoned" [ALCH:0X0028CD22]
			ClearAndAddModFood(0X0029C063, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Soup_MeatVege "Soup Meat Vege" [ALCH:0X0029C063]
			ClearAndAddModFood(0X0029C06F, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Soup_MeatVegeMushroom "Soup Meat Vege Mushroom" [ALCH:0X0029C06F]
			ClearAndAddModFood(0X0029C065, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Soup_MeatVegeSeasoned "Soup Meat Vege Seasoned" [ALCH:0X0029C065]
			ClearAndAddModFood(0X0029C071, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Soup_MeatVegeSeasonedMushroom "Soup Meat Vege Seasoned Mushroom" [ALCH:0X0029C071]
			ClearAndAddModFood(0X0028CD16, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Soup_Mixed "Soup Mixed" [ALCH:0X0028CD16]
			ClearAndAddModFood(0X0028CD1C, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Soup_MixedMeat "Soup Mixed Meat" [ALCH:0X0028CD1C]
			ClearAndAddModFood(0X0029C075, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Soup_MixedMeatMushroom "Soup Mixed Meat Mushroom" [ALCH:0X0029C075]
			ClearAndAddModFood(0X0028CD20, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Soup_MixedMeatSeasoned "Soup Mixed Meat Seasoned" [ALCH:0X0028CD20]
			ClearAndAddModFood(0X0029C077, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Soup_MixedMeatSeasonedMushroom "Soup Mixed Meat Seasoned Mushroom" [ALCH:0X0029C077]
			ClearAndAddModFood(0X0029C073, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Soup_MixedMushroom "Soup Mixed Mushroom" [ALCH:0X0029C073]
			ClearAndAddModFood(0X0028CD1E, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Soup_MixedSeasoned "Soup Mixed Seasoned" [ALCH:0X0028CD1E]
			ClearAndAddModFood(0X0029C079, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Soup_MixedSeasonedMushroom "Soup Mixed Seasoned Mushroom" [ALCH:0X0029C079]
			ClearAndAddModFood(0X0028CD04, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Soup_Vege "Soup Vege" [ALCH:0X0028CD04]
			ClearAndAddModFood(0X0029C07B, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Soup_VegeMushroom "Soup Vege Mushroom" [ALCH:0X0029C07B]
			ClearAndAddModFood(0X0028CD1A, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Soup_VegeSeasoned "Soup Seasoned" [ALCH:0X0028CD1A]
			ClearAndAddModFood(0X0029C07D, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Soup_VegeSeasonedMushroom "Soup Seasoned Mushroom" [ALCH:0X0029C07D]
			ClearAndAddModFood(0X002B04C0, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Stew_Cold "Cold Stew" [ALCH:0X002B04C0]
			ClearAndAddModFood(0X0029C057, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Stew_Meat "Stew Meat" [ALCH:0X0029C057]
			ClearAndAddModFood(0X0029C07F, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Stew_MeatMushroom "Stew Meat Mushroom" [ALCH:0X0029C07F]
			ClearAndAddModFood(0X0029C061, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Stew_MeatSeasoned "Stew Meat Seasoned" [ALCH:0X0029C061]
			ClearAndAddModFood(0X0029C081, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Stew_MeatSeasonedMushroom "Stew Meat Seasoned Mushroom" [ALCH:0X0029C081]
			ClearAndAddModFood(0X0029C067, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Stew_MeatVege "Stew Meat Vege" [ALCH:0X0029C067]
			ClearAndAddModFood(0X0029C083, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Stew_MeatVegeMushroom "Stew Meat Vege Mushroom" [ALCH:0X0029C083]
			ClearAndAddModFood(0X0029C069, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Stew_MeatVegeSeasoned "Stew Meat Vege Seasoned" [ALCH:0X0029C069]
			ClearAndAddModFood(0X0029C085, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Stew_MeatVegeSeasonedMushroom "Stew Meat Vege Seasoned Mushroom" [ALCH:0X0029C085]
			ClearAndAddModFood(0X0029C055, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Stew_Mixed "Stew Mixed" [ALCH:0X0029C055]
			ClearAndAddModFood(0X0029C05B, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Stew_MixedMeat "Stew Mixed Meat" [ALCH:0X0029C05B]
			ClearAndAddModFood(0X0029C087, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Stew_MixedMeatMushroom "Stew Mixed Meat Mushroom" [ALCH:0X0029C087]
			ClearAndAddModFood(0X0029C05F, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Stew_MixedMeatSeasoned "Stew Mixed Meat Seasoned" [ALCH:0X0029C05F]
			ClearAndAddModFood(0X0029C089, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Stew_MixedMeatSeasonedMushroom "Stew Mixed Meat Seasoned Mushroom" [ALCH:0X0029C089]
			ClearAndAddModFood(0X0029C08B, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Stew_MixedMushroom "Stew Mixed Mushroom" [ALCH:0X0029C08B]
			ClearAndAddModFood(0X0029C05D, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Stew_MixedSeasoned "Stew Mixed Seasoned" [ALCH:0X0029C05D]
			ClearAndAddModFood(0X0029C08D, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Stew_MixedSeasonedMushroom "Stew Mixed Seasoned Mushroom" [ALCH:0X0029C08D]
			ClearAndAddModFood(0X0029C053, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Stew_Vege "Stew Vege" [ALCH:0X0029C053]
			ClearAndAddModFood(0X0029C08F, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; _DS_Food_Stew_VegeMushroom "Stew Vege Mushroom" [ALCH:0X0029C08F]
			ClearAndAddModFood(0X0029C059, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Stew_VegeSeasoned "Stew Seasoned" [ALCH:0X0029C059]
			ClearAndAddModFood(0X0029C091, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)    ; _DS_Food_Stew_VegeSeasonedMushroom "Stew Seasoned Mushroom" [ALCH:0X0029C091]
			ClearAndAddModFood(0X002A11A2, "Hunterborn.esp", _Seed_NotFood)                        ; _DS_Food_Soup_AdditionalHint " Additions" [ALCH:0X002A11A2]
			ClearAndAddModFood(0X0028CD3D, "Hunterborn.esp",_Seed_NotFood)                        ; _DS_Food_Soup_Hint " Soup Starter" [ALCH:0X0028CD3D]
		endif
		
		initialiseWaterBottles_Hunterborn()
		AddHunterbornSystem()
		_Seed_ImportHunterborn_Done.show()
	endif
endFunction

function AddHunterbornSystem()
	ClearAndAddModFood(0X002A11A2, "Hunterborn.esp", _Seed_SystemFoods)                        ; _DS_Food_Soup_AdditionalHint " Additions" [ALCH:0X002A11A2]
	ClearAndAddModFood(0X0028CD3D, "Hunterborn.esp",_Seed_SystemFoods)                        ; _DS_Food_Soup_Hint " Soup Starter" [ALCH:0X0028CD3D]
endFunction


;UPDATE 4.0
function update_4_0_micro()
	multiFoodList_WholeFood_2 = new Potion[128]
	multiFoodList_WholeFood_3 = new Potion[128]
	multiFoodList_WholeFood_4 = new Potion[128]
	multiFoodList_ResultFood_2 = new Potion[128]
	multiFoodList_ResultFood_3 = new Potion[128]
	multiFoodList_ResultFood_4 = new Potion[128]
	multiFoodList_Quantity_2 = new int[128]
	multiFoodList_Quantity_3 = new int[128]
	multiFoodList_Quantity_4 = new int[128]
endFunction


function update_4_0()
	_Seed_Bread.removeAddedForm(_Seed_TestFood)
	_Seed_Bread.AddForm(_Seed_TestFood)
	
	_Seed_NotFood.AddForm(_Seed_WaterBottleEmpty)
	_Seed_NotFood.AddForm(_Seed_WaterBottleSea)
	_Seed_NotFood.AddForm(_Seed_WaterBottleSnow)
	
	_Seed_DrinkNonAlcoholic.AddForm(_Seed_WaterBottle)
	_Seed_DrinkNonAlcoholic.AddForm(_Seed_WaterBottleClean)
	
	AddMultiPartFood_Array(FoodCheeseWheel02A, FoodCheeseWedge02, 7)
	
	initialiseWaterBottles()
endfunction

function update_4_0_Hunterborn()
		ClearAndAddModFood(0X00287BF7, "Hunterborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)
		
		AddModFood(0x00017E1D, "Hunterborn.esp", _Seed_Preserved)		;_DS_Food_HorseJerky "Horse Jerky" [ALCH:0x00017E1D]
		AddModFood(0x000314CD, "Hunterborn.esp", _Seed_Preserved)		;_DS_Food_TrollJerky "Troll Jerky" [ALCH:0x000314CD]
		AddModFood(0x00017E1B, "Hunterborn.esp", _Seed_Preserved)		;_DS_Food_VenisonJerky "Venison Jerky" [ALCH:0x00017E1B]
		if isSpecialEdition()
			AddModFood(0X0022776D, "Hunterborn.esp", _Seed_Preserved)	; _DS_Food_MammothJerky "Mammoth Jerky" [ALCH:0X0022776D]
		endif
endFunction

function update_4_0_CACO()
	AddModFood(0x004A6FFD, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood) ;CACO_FoodSeaSalmonDried "Dried Salmon" [ALCH:0x004A6FFD]
	AddModFood(0x00516874, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodMeatJerkyBear_ExtraFood "Bear Jerky" [ALCH:0x00516874]
	AddModFood(0x00220027, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodMeatJerkyBeef_ExtraFood "Beef Jerky" [ALCH:0x00220027]
	AddModFood(0x00516876, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodMeatJerkyBoar_ExtraFood "Boar Jerky" [ALCH:0x00516876]
	AddModFood(0x00516878, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodMeatJerkyChicken_ExtraFood "Chicken Jerky" [ALCH:0x00516878]
	AddModFood(0x00516879, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodMeatJerkyGoat_ExtraFood "Goat Jerky" [ALCH:0x00516879]
	AddModFood(0x0051687D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodMeatJerkyHorker_ExtraFood "Horker Jerky" [ALCH:0x0051687D]
	AddModFood(0x00516880, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodMeatJerkyHorse_ExtraFood "Horse Jerky" [ALCH:0x00516880]
	AddModFood(0x0051687B, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodMeatJerkyHumanoid_ExtraFood "Hominid Jerky" [ALCH:0x0051687B]
	AddModFood(0x00516870, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodMeatJerkyMammoth_ExtraFood "Mammoth Jerky" [ALCH:0x00516870]
	AddModFood(0x0099E786, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodMeatJerkyPork_ExtraFood "Pork Jerky" [ALCH:0x0099E786]
	AddModFood(0x00516872, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodMeatJerkySabre_ExtraFood "Sabre Cat Jerky" [ALCH:0x00516872]
	AddModFood(0x00516881, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodMeatJerkySalmon_ExtraFood "Salmon Jerky" [ALCH:0x00516881]
	AddModFood(0x00516883, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodMeatJerkySkeever_ExtraFood "Skeever Jerky" [ALCH:0x00516883]
	AddModFood(0x00516886, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodMeatJerkyTroll_ExtraFood "Troll Jerky" [ALCH:0x00516886]
	AddModFood(0x0051686D, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodMeatJerkyVenison_ExtraFood "Venison Jerky" [ALCH:0x0051686D]
	AddModFood(0x00190B57, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodMeatMammothCooked "Cooked Mammoth Steak" [ALCH:0x00190B57]
	
	AddModFood(0x00220122, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodSweetJamJazbey_SL00 "Jazbay Jam" [ALCH:0x00220122]
	AddModFood(0x00220120, "Complete Alchemy & Cooking Overhaul.esp", _Seed_SaltedFood)	;CACO_FoodSweetJamSnowberry_SL00 "Snowberry Jam" [ALCH:0x00220120]	
endFunction

function update_4_3()
	;Fix Incorrect Spoiled Foods
	_Seed_Food_RestoreHungerMassive.removeAddedForm(_Seed_Spoiled_MeatCooked)
	_Seed_Food_RestoreHungerMajor.addForm(_Seed_Spoiled_MeatCooked)
	_Seed_Food_RestoreHungerMassive.removeAddedForm(_Seed_Spoiled_Cheesebowl)
	_Seed_Food_RestoreHungerMajor.addForm(_Seed_Spoiled_Cheesebowl)
	
	if(seedUtil.getCompatibilitySystem().isCACOLoaded)
		; Fix Firebrand Wine
		ReplaceModMultiPartFood_Array(0x07450DD4, "Complete Alchemy & Cooking Overhaul.esp", 	0x07450DD2, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkFirebrandWine2 "Firebrand Wine" [ALCH:0x07450DD4]	FoodDrinkFirebrandWine1 "Firebrand Wine" [ALCH:0x07450DD2]	1
		ReplaceModMultiPartFood_Array(0x07450DD6, "Complete Alchemy & Cooking Overhaul.esp", 	0x07450DD4, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkFirebrandWine3 "Firebrand Wine" [ALCH:0x07450DD6]	FoodDrinkFirebrandWine2 "Firebrand Wine" [ALCH:0x07450DD4]	1
		ReplaceModMultiPartFood_Array(0x00450DD2 , "Skyrim.esm", 								0x07450DD6, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FirebrandWine "Firebrand Wine" [ALCH:0001895F]	FoodDrinkFirebrandWine3 "Firebrand Wine" [ALCH:0x07450DD6]	1
		
		;Fix Embershard Wine
		ReplaceModMultiPartFood_Array(0x0045B00C, "Complete Alchemy & Cooking Overhaul.esp", 	0x0045B00A, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkRRFavor01EmberbrandWine2 "Emberbrand Wine" [ALCH:0x0045B00C]	DLC2FoodDrinkRRFavor01EmberbrandWine1 "Emberbrand Wine" [ALCH:0x0045B00A]	1
		ReplaceModMultiPartFood_Array(0x0045B00E, "Complete Alchemy & Cooking Overhaul.esp", 	0x0045B00C, "Complete Alchemy & Cooking Overhaul.esp", 1)	;DLC2FoodDrinkRRFavor01EmberbrandWine3 "Emberbrand Wine" [ALCH:0x0045B00E]	DLC2FoodDrinkRRFavor01EmberbrandWine2 "Emberbrand Wine" [ALCH:0x0045B00C]	1
		ReplaceModMultiPartFood_Array(0x000320DF, "Dragonborn.esm", 							0x0045B00E, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkRRFavor01EmberbrandWine "Emberbrand Wine" [ALCH:040320DF]	DLC2FoodDrinkRRFavor01EmberbrandWine3 "Emberbrand Wine" [ALCH:0x0045B00E]	1
		
		;FIX CHANGES FROM WATER BOTTLES
		ReplaceModMultiPartFood_Array(0x03003535, "HearthFires.esm", 							0x0745AFF6, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodDrinkWineBottle04 "Argonian Bloodwine" [ALCH:0x03003535]	BYOHFoodDrinkWineBottle043 "Argonian Bloodwine" [ALCH:0x0745AFF6]	1
		ReplaceModMultiPartFood_Array(0x03003536, "HearthFires.esm", 							0x0745AFFE, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodDrinkWineBottle03 "Surilie Brothers Wine" [ALCH:0x03003536]	BYOHFoodDrinkWineBottle033 "Surilie Brothers Wine" [ALCH:0x0745AFFE]	1
		ReplaceModMultiPartFood_Array(0x00085368, "Skyrim.esm", 								0x07450DE8, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkSolitudeSpicedWine "Spiced Wine" [ALCH:0x00085368]	FoodDrinkSolitudeSpicedWine3 "Spiced Wine" [ALCH:0x07450DE8]	1
		ReplaceModMultiPartFood_Array(0x00003133B, "Skyrim.esm",                            	0x072BBAC6, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWineAlto "Alto Noir Wine" [ALCH:0x0003133B]	FoodDrinkWineAlto3 "Alto Noir Wine" [ALCH:0x072BBAC6]	1
		ReplaceModMultiPartFood_Array(0x000F257E, "Skyrim.esm",                             	0x07450DDF, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMS14WineAltoA "Jessica's Wine" [ALCH:0x000F257E]	FoodDrinkMS14WineAltoA3 "Jessica's Wine" [ALCH:0x07450DDF]	1
		ReplaceModMultiPartFood_Array(0x0003133C, "Skyrim.esm",                             	0x072EE52D, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWineBottle02 "Village Red Wine" [ALCH:0x0003133C]	FoodDrinkWineBottle023 "Village Red Wine" [ALCH:0x072EE52D]	1
		ReplaceModMultiPartFood_Array(0x000C5348, "Skyrim.esm",                             	0x072EE533, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWineBottle02A "Village White Wine" [ALCH:0x000C5348]	FoodDrinkWineBottle02A3 "Village White Wine" [ALCH:0x072EE533]	1
		ReplaceModMultiPartFood_Array(0x000C5349, "Skyrim.esm",                             	0x072EE524, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWineAltoA "Alto Blanc Wine" [ALCH:0x000C5349]	FoodDrinkWineAltoA3 "Alto Blanc Wine" [ALCH:0x072EE524]	1
		ReplaceModMultiPartFood_Array(0x00036D53, "Skyrim.esm",                             	0x0744BCA1, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMQ201Drink "Colovian Brandy" [ALCH:0x00036D53]	FoodDrinkMQ201DrinkBrandy15 "Colovian Brandy" [ALCH:0x0744BCA1]	1
		ReplaceModMultiPartFood_Array(0x000B91D7, "Skyrim.esm",                             	0x072F8771, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWEDL03CyrodilicBrandy "Cyrodilic Brandy" [ALCH:0x000B91D7]	FoodDrinkWEDL03CyrodilicBrandy15 "Cyrodilic Brandy" [ALCH:0x072F8771]	1Shein
		ReplaceModMultiPartFood_Array(0x04024E0B, "Dragonborn.esm",                         	0x0746012E, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkRRF04Sujamma	DLC2FoodDrinkRRF04Sujamma3 "Sadri's Sujamma" [ALCH:0x0746012E]	1
		ReplaceModMultiPartFood_Array(0x040207E6, "Dragonborn.esm",                         	0x07460128, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkSujamma "Sujamma" [ALCH:0x040207E6]	DLC2FoodDrinkSujamma3 "Sujamma" [ALCH:0x07460128]	1
		ReplaceModMultiPartFood_Array(0x040248CE, "Dragonborn.esm",                         	0x07460144, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkMatze "Mazte" [ALCH:0x040248CE]	DLC2FoodDrinkMatze3 "Mazte" [ALCH:0x07460144]	1
		ReplaceModMultiPartFood_Array(0x040248CC, "Dragonborn.esm",                         	0x0746013E, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkShein "Shein" [ALCH:0x040248CC]	DLC2FoodDrinkShein3 "Shein" [ALCH:0x0746013E]	1
		ReplaceModMultiPartFood_Array(0x040207E5, "Dragonborn.esm",                         	0x07460117, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkFlin "Flin" [ALCH:0x040207E5]	DLC2FoodDrinkFlin3 "Flin" [ALCH:0x07460117]	1
	endif
endFunction

function update_4_6()
	ClearAndAddModFood(0x00014D24, "Hunterborn.esp", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)    ;_DS_Food_Raw_Slaughterfish "Raw Slaughterfish Meat" [ALCH:0x00014D24]
	_Seed_DrinkAlcoholic.AddForm(TGTQ02BalmoraBlue)
	_Seed_DrinkSkoomaWeak.RemoveAddedForm(TGTQ02BalmoraBlue)
	_Seed_DrinkSkoomaStrong.AddForm(TGTQ02BalmoraBlue)
endFunction

function addApothecary(bool checkRequired = true)
	bool addFood = true
	if(checkRequired)
		addFood = SeedUtil.GetCompatibilitySystem().isApothecaryLoaded
	endif
	
	if addFood
		_Seed_ImportApothecary.show()
		; PASTRIES
		ClearAndAddModFood(0X00069786, "ApothecaryFood.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)    ; MAG_FoodHoneyDumpling "Honey Dumpling" [ALCH:0X00069786]
		ClearAndAddModFood(0X00069787, "ApothecaryFood.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)    ; MAG_FoodJazbayDumpling "Jazbay Dumpling" [ALCH:0X00069787]
		ClearAndAddModFood(0X00069789, "ApothecaryFood.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)    ; MAG_FoodHorkerDumpling "Horker Dumpling" [ALCH:0X00069789]
		ClearAndAddModFood(0X0006978B, "ApothecaryFood.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)    ; MAG_FoodMammothDumpling "Mammoth Dumpling" [ALCH:0X0006978B]
		ClearAndAddModFood(0X0006978D, "ApothecaryFood.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)    ; MAG_FoodBeefDumpling "Beef Dumpling" [ALCH:0X0006978D]
		ClearAndAddModFood(0X0006978F, "ApothecaryFood.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)    ; MAG_FoodVenisonDumpling "Venison Dumpling" [ALCH:0X0006978F]
		ClearAndAddModFood(0X00069791, "ApothecaryFood.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)    ; MAG_FoodJuniperDumpling "Juniper Berry Dumpling" [ALCH:0X00069791]
		
		; CHEESEBOWLS
		ClearAndAddModFood(0X0006C664, "ApothecaryFood.esp", _Seed_CheeseBowls, _Seed_Food_RestoreHungerSuperior)    ; MAG_FoodMammothCheeseFondue "Mammoth Cheese Fondue" [ALCH:0X0006C664]
		ClearAndAddModFood(0X0006C66D, "ApothecaryFood.esp", _Seed_CheeseBowls, _Seed_Food_RestoreHungerSuperior)    ; MAG_FoodGoatCheeseFondue "Goat Cheese Fondue" [ALCH:0X0006C66D]
		
		; STEWS
		ClearAndAddModFood(0X0006C66E, "ApothecaryFood.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; MAG_FoodAshHopperStew "Ash Hopper Stew" [ALCH:0X0006C66E]
		ClearAndAddModFood(0X0006C670, "ApothecaryFood.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; MAG_FoodBoarStew "Boar Stew" [ALCH:0X0006C670]
		ClearAndAddModFood(0X0006C672, "ApothecaryFood.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; MAG_FoodMammothStew "Mammoth Stew" [ALCH:0X0006C672]
		ClearAndAddModFood(0X0006C678, "ApothecaryFood.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; MAG_FoodGoatStew "Goat Stew" [ALCH:0X0006C678]
		ClearAndAddModFood(0X0006C67E, "ApothecaryFood.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)    ; MAG_FoodTomatoLeekSoup "Tomato and Leek Soup" [ALCH:0X0006C67E]
		
		; ALCOHOLIC - SPIRITS
		ClearAndAddModFood(0X0006C685, "ApothecaryFood.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicSpirit)    ; MAG_DrinkSpicedRum "Spiced Rum" [ALCH:0X0006C685]
		ClearAndAddModFood(0X0006C686, "ApothecaryFood.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicSpirit)    ; MAG_DrinkWrothgarianRum "Wrothgarian Rum" [ALCH:0X0006C686]
		ClearAndAddModFood(0X0006C688, "ApothecaryFood.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicSpirit)    ; MAG_DrinkCyrodilicWhiskey "Cyrodilic Whiskey" [ALCH:0X0006C688]
		ClearAndAddModFood(0X0006C68A, "ApothecaryFood.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicSpirit)    ; MAG_DrinkRedEaglesRye "Red Eagle's Rye" [ALCH:0X0006C68A]
		ClearAndAddModFood(0X0006C68C, "ApothecaryFood.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicSpirit)    ; MAG_DrinkCyrodilicBrandy "Cyrodilic Brandy" [ALCH:0X0006C68C]
		
		initialiseWaterBottles_Apothecary()
		
		_Seed_ImportApothecary_Done.show()
	endif
endFunction

function AddRequiem(bool checkRequired = true)
	bool addFood = true
	if(checkRequired)
		addFood = SeedUtil.GetCompatibilitySystem().isRequiemLoaded
	endif
	
	if addFood
		_Seed_ImportRequiem.show()
		ClearAndAddModFood(0x00030D05, "Requiem.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)        	;REQ_Food_MeatSkeever "Skeever Meat" [ALCH:0x00030D05]
		ClearAndAddModFood(0x00284894, "Requiem.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)   ;REQ_Food_GreenPact "Strange Meat" [ALCH:0x00284894]
		ClearAndAddModFood(0x002897D4, "Requiem.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)        	;REQ_Food_StewBestial "Bestial Stew" [ALCH:0x002897D4]
		ClearAndAddModFood(0x0003DFE8, "Requiem.esp", _Seed_DrinkNonAlcoholic)            					;REQ_Food_Water "Bottled Water" [ALCH:0x0003DFE8]
		ClearAndAddModFood(0x00AD3910, "Requiem.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)        ;REQ_Drink_CinnabarBeer "Cinnabar Beer" [ALCH:0x00AD3910]
		
		initialiseWaterBottles_Requiem()
		
		_Seed_ImportRequiem_Done.show()
	endif
endFunction

function AddCRF(bool checkRequired = true)
	bool addFood = true
	if(checkRequired)
		addFood = SeedUtil.GetCompatibilitySystem().isCRFLoaded
	endif
	
	if addFood
		ClearAndAddModFood(0x00037108, "Cutting Room Floor.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)        	;CRFFoodFrostRiverMead "Frost River Mead" [ALCH:0x00037108]
		initialiseWaterBottles_CRF()
	endif
endFunction

function AddWintersun(bool checkRequired = true)
	bool addFood = true
	if(checkRequired)
		addFood = SeedUtil.GetCompatibilitySystem().isWintersunLoaded
	endif
	
	if addFood
		ClearAndAddModFood(0x0020A802, "Wintersun - Faiths of Skyrim.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMajor, _Seed_Preserved) ; WSN_Redguard_Morwha_Boon2_Food_0 "Sacred Pineapple" [ALCH:0x0020A802]
		ClearAndAddModFood(0x0020A805, "Wintersun - Faiths of Skyrim.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMajor, _Seed_Preserved) ; WSN_Redguard_Morwha_Boon2_Food_2 "Sacred Kiwi" [ALCH:0x0020A805]
		ClearAndAddModFood(0x0020A807, "Wintersun - Faiths of Skyrim.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMajor, _Seed_Preserved) ; WSN_Redguard_Morwha_Boon2_Food_1 "Sacred Mango" [ALCH:0x0020A807]
		ClearAndAddModFood(0x0020A809, "Wintersun - Faiths of Skyrim.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMajor, _Seed_Preserved) ; WSN_Redguard_Morwha_Boon2_Food_3 "Sacred Melon" [ALCH:0x0020A809]
		ClearAndAddModFood(0x0020A80B, "Wintersun - Faiths of Skyrim.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMajor, _Seed_Preserved) ; WSN_Redguard_Morwha_Boon2_Food_4 "Sacred Papaya" [ALCH:0x0020A80B]
		ClearAndAddModFood(0x0020A80D, "Wintersun - Faiths of Skyrim.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMajor, _Seed_Preserved) ; WSN_Redguard_Morwha_Boon2_Food_5 "Sacred Banana" [ALCH:0x0020A80D]	
	endif
endFunction

function AddFoodExpanded(bool checkRequired = true)
	bool addFood = true
	if(checkRequired)
		addFood = SeedUtil.GetCompatibilitySystem().isFoodExpandedLoaded || SeedUtil.GetCompatibilitySystem().isFoodExpandedLoadedFr
	endif
	

	if addFood
		string espName = "Ana_Skyrim Food Expanded - EN.esp"
		if(SeedUtil.GetCompatibilitySystem().isFoodExpandedLoadedFr)
			espName = "Ana_Skyrim Food Expanded.esp"
		endif
		
		; SOUP
		ClearAndAddModFood(0x00000D61, espName, _Seed_Stews, _Seed_Food_RestoreHungerMassive)			; FoodFishSoup "Fish soup" [ALCH:0x00000D61]
		ClearAndAddModFood(0x00000D65, espName, _Seed_Stews, _Seed_Food_RestoreHungerMassive)			; FoodCrabStew "Mudcrab stew" [ALCH:0x00000D65]
		ClearAndAddModFood(0x00000D69, espName, _Seed_Stews, _Seed_Food_RestoreHungerMassive)			; FoodClamStew "Creamy clam stew" [ALCH:0x00000D69]
		ClearAndAddModFood(0x00000D6D, espName, _Seed_Stews, _Seed_Food_RestoreHungerMajor)				; FoodGourdSoup "Gourd soup" [ALCH:0x00000D6D]
		ClearAndAddModFood(0x00004714, espName, _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)		; DLC2FoodTramaRootsSoup "Trama roots soup" [ALCH:0x00004714]
		ClearAndAddModFood(0x00004716, espName, _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)		; DLC2FoodScathecrawSoup "Scathecraw soup" [ALCH:0x00004716]
		
		; PASTRY		
		ClearAndAddModFood(0x00001835, espName, _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)		; BYOHFoodLeekCrostata "Leek Pie" [ALCH:0x00001835]
		ClearAndAddModFood(0x00001837, espName, _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)		; BYOHFoodTomatoCrostata "Tomato pie" [ALCH:0x00001837]
		ClearAndAddModFood(0x00004703, espName, _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)		; FoodMushroomStew "Mushroom stew" [ALCH:0x00004703]
	
		; HEARTY MEALS
		ClearAndAddModFood(0x00004708, espName, _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)		; FoodHeartyMealBeef "Hearty Meal - Beef" [ALCH:0x00004708]
		ClearAndAddModFood(0x0000470E, espName, _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)		; FoodHeartyMealVenison "Hearty Meal - Venison" [ALCH:0x0000470E]
		ClearAndAddModFood(0x0000471C, espName, _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)		; DLC2FoodHeartyMealBoar "Hearty Meal - Boar" [ALCH:0x0000471C]
		ClearAndAddModFood(0x0000470A, espName, _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMassive)	; FoodHeartyMealRabbit "Hearty Meal - Rabbit" [ALCH:0x0000470A]
		ClearAndAddModFood(0x0000470C, espName, _Seed_FishCooked, _Seed_Food_RestoreHungerMassive)		; FoodHeartyMealSalmon "Hearty Meal - Salmon" [ALCH:0x0000470C]
	endif
endFunction


function AddCookingExpanded(bool checkRequired = true)
	bool addFood = true
	if(checkRequired)
		addFood = SeedUtil.GetCompatibilitySystem().isCookingExpandedLoaded
	endif
	
	if addFood
		ClearAndAddModFood(0x00000801, "CookingExpanded.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)										; FoodHuntersPie "Hunter's Pie" [ALCH:0x00000801]
		ClearAndAddModFood(0x00001000, "CookingExpanded.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)										; FoodMushroomSoup "Mushroom Soup" [ALCH:0x00001000]
		ClearAndAddModFood(0x00001002, "CookingExpanded.esp", _Seed_CheeseBowls, _Seed_Food_RestoreHungerMassive)									; FoodMammothFondue "Mammoth Fondue" [ALCH:0x00001002]
		ClearAndAddModFood(0x00001009, "CookingExpanded.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive)									; FoodBeefBraised "Braised Beef" [ALCH:0x00001009]
		ClearAndAddModFood(0x0000100A, "CookingExpanded.esp", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)											; FoodSlaughterfish "Slaughterfish Meat" [ALCH:0x0000100A]
		ClearAndAddModFood(0x00CD0002, "CookingExpanded.esp", _Seed_Cheese, _Seed_Food_RestoreHungerMassive, _Seed_Preserved)						; FoodBoiledEgg "Hardboiled Egg" [ALCH:0x00CD0002]
		ClearAndAddModFood(0x00CD0004, "CookingExpanded.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)										; FoodGourdStuffed "Stuffed Gourd" [ALCH:0x00CD0004]
		ClearAndAddModFood(0x00CD0005, "CookingExpanded.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)											; FoodGoatStew "Goat Stew" [ALCH:0x00CD0005]
		ClearAndAddModFood(0x00CD0006, "CookingExpanded.esp", _Seed_SeafoodCooked, _Seed_Food_RestoreHungerMajor)									; FoodClamSteamed "Steamed Clams" [ALCH:0x00CD0006]
		ClearAndAddModFood(0x00CD0007, "CookingExpanded.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMassive)									; FoodSalmonSmoked "Smoked Salmon" [ALCH:0x00CD0007]
		ClearAndAddModFood(0x00CD0008, "CookingExpanded.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMassive, _Seed_Preserved, _Seed_SaltedFood)	; FoodSaltedLongfin "Salted Longfin" [ALCH:0x00CD0008]	
		ClearAndAddModFood(0x00000D7E, "CookingExpanded.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)										; FoodBreadSoup "Bread Soup" [ALCH:0x00000D7E]		
		ClearAndAddModFood(0x00001004, "CookingExpanded.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)										; FoodPheasantStew "Pheasant Stew" [ALCH:0x00001004]
		ClearAndAddModFood(0x0000100D, "CookingExpanded.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)										; FoodChickenSoup "Chicken Soup" [ALCH:0x0000100D]
		ClearAndAddModFood(0x00001DEB, "CookingExpanded.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)											; FoodBeggersStew "Dogmeat Stew" [ALCH:0x00001DEB]
		ClearAndAddModFood(0x00002E1D, "CookingExpanded.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)											; FoodHorseStew "Equine Stew" [ALCH:0x00002E1D]
		ClearAndAddModFood(0x00CD0001, "CookingExpanded.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)										; FoodRabbitStew "Rabbit Stew" [ALCH:0x00CD0001]
		ClearAndAddModFood(0x00CD0003, "CookingExpanded.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)											; FoodSeafoodSoup "Seafood Soup" [ALCH:0x00CD0003]		

		ClearAndAddModFood(0x000036C9, "CookingExpanded - Dragonborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)										; FoodBoarStew "Boar and Apple Stew" [ALCH:0x000036C9]
		ClearAndAddModFood(0x000036CA, "CookingExpanded - Dragonborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)										; FoodAshHopperStew "Ash Hopper Stew" [ALCH:0x000036CA]
		ClearAndAddModFood(0x000036CC, "CookingExpanded - Dragonborn.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)										; FoodYamSoup "Yam Soup" [ALCH:0x000036CC]
		ClearAndAddModFood(0x00009467, "CookingExpanded - Dragonborn.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)										; FoodYamBaked "Baked Yam" [ALCH:0x00009467]
		ClearAndAddModFood(0x00009468, "CookingExpanded - Dragonborn.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_Preserved, _Seed_SaltedFood)	; FoodAshHopperLegPickled "Pickled Ash Hopper Leg" [ALCH:0x00009468]
		ClearAndAddModFood(0x0000C33B, "CookingExpanded - Dragonborn.esp", _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)									; FoodPieYam "Sweet Yam Pie" [ALCH:0x0000C33B]
	endif
endFunction

function addUSSEP(bool checkRequired = true)
	bool addFood = true
	if(checkRequired)
		addFood = SeedUtil.GetCompatibilitySystem().isUSSEPLoaded
	endif
	
	if addFood
		string USSEP_ESP = "Unofficial Skyrim Special Edition Patch.esp"
		if !isSpecialEdition()
			USSEP_ESP = "Unofficial Skyrim Legendary Edition Patch.esp"
		endif
		ClearAndAddModFood(0x00000801, USSEP_ESP, _Seed_Pastries, _Seed_Food_RestoreHungerMassive)    ; FoodMeatPieUSKP "Meat Pie" [ALCH:0x00000801]
	endif
endFunction

function addCCFishing(bool checkRequired = true)
	bool addFood = true
	if(checkRequired)
		addFood = SeedUtil.GetCompatibilitySystem().isCCFishingLoaded
	endif
	
	if addFood
		_Seed_ImportCCFish.show()
	
		; Raw Seafood
		ClearAndAddModFood(0x00000EFE, "ccBGSSSE001-Fish.esm", _Seed_SeafoodRaw, _Seed_Food_RestoreHungerMinor)	; ccBGSSSE001_FoodCrabMeat "Crab Meat" [ALCH:0x00000EFE]
		
		; Cooked Seafood
		ClearAndAddModFood(0x00000F78, "ccBGSSSE001-Fish.esm", _Seed_SeafoodCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodCrabCakes "Crab Cakes" [ALCH:0x00000F78]
		
		; Raw Fish
		ClearAndAddModFood(0x00000890, "ccBGSSSE001-Fish.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)	; ccBGSSSE001_FoodAngler "Angler" [ALCH:0x00000890]
		ClearAndAddModFood(0x000008A4, "ccBGSSSE001-Fish.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)	; ccBGSSSE001_FoodArcticChar "Arctic Char" [ALCH:0x000008A4]
		ClearAndAddModFood(0x000008A3, "ccBGSSSE001-Fish.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)	; ccBGSSSE001_FoodArcticGrayling "Arctic Grayling" [ALCH:0x000008A3]
		ClearAndAddModFood(0x000008A2, "ccBGSSSE001-Fish.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)	; ccBGSSSE001_FoodAtlanticCod "Cod" [ALCH:0x000008A2]
		ClearAndAddModFood(0x0000089C, "ccBGSSSE001-Fish.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)	; ccBGSSSE001_FoodBucketFish "Brook Bass" [ALCH:0x0000089C]
		ClearAndAddModFood(0x000008A1, "ccBGSSSE001-Fish.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)	; ccBGSSSE001_FoodCabezon "Scorpion Fish" [ALCH:0x000008A1]
		ClearAndAddModFood(0x00000898, "ccBGSSSE001-Fish.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)	; ccBGSSSE001_FoodCarp "Carp" [ALCH:0x00000898]
		ClearAndAddModFood(0x00000897, "ccBGSSSE001-Fish.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)	; ccBGSSSE001_FoodCuckooCatfish "Catfish" [ALCH:0x00000897]
		ClearAndAddModFood(0x00000896, "ccBGSSSE001-Fish.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)	; ccBGSSSE001_FoodDragonfish "Direfish" [ALCH:0x00000896]
		ClearAndAddModFood(0x000008A0, "ccBGSSSE001-Fish.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)	; ccBGSSSE001_FoodGlassCatfish "Glass Catfish" [ALCH:0x000008A0]
		ClearAndAddModFood(0x0000089B, "ccBGSSSE001-Fish.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)	; ccBGSSSE001_FoodSalmon "Salmon" [ALCH:0x0000089B]
		ClearAndAddModFood(0x00000F25, "ccBGSSSE001-Fish.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)	; ccBGSSSE001_FoodSlaughterfish "Slaughterfish" [ALCH:0x00000F25]
		ClearAndAddModFood(0x0000089E, "ccBGSSSE001-Fish.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)	; ccBGSSSE001_FoodTripodFish "Tripod Spiderfish" [ALCH:0x0000089E]
		ClearAndAddModFood(0x00000891, "ccBGSSSE001-Fish.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)	; ccBGSSSE001_FoodTunaSalmon "Pogfish" [ALCH:0x00000891]
		ClearAndAddModFood(0x0000088B, "ccBGSSSE001-Fish.esm", _Seed_FishRaw, _Seed_Food_RestoreHungerMinor)	; ccBGSSSE001_FoodVampireFish "Vampire Fish" [ALCH:0x0000088B]
		
		; Cooked Fish
		ClearAndAddModFood(0x000008A5, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodAnglerCooked "Cooked Angler" [ALCH:0x000008A5]
		ClearAndAddModFood(0x0000088E, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodAnglerLarvaeCooked "Cooked Angler Larvae" [ALCH:0x0000088E]
		ClearAndAddModFood(0x0000088D, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodArcticCharCooked "Cooked Arctic Char" [ALCH:0x0000088D]
		ClearAndAddModFood(0x0000088C, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodArcticGraylingCooked "Cooked Arctic Grayling" [ALCH:0x0000088C]
		ClearAndAddModFood(0x0000088F, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodAsiaticGlassfishCooked "Cooked Glassfish" [ALCH:0x0000088F]
		ClearAndAddModFood(0x0000087A, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodAtlanticCodCooked "Cooked Cod" [ALCH:0x0000087A]
		ClearAndAddModFood(0x0000087B, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodAustrolebiasCooked "Cooked Pearlfish" [ALCH:0x0000087B]
		ClearAndAddModFood(0x0000087C, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodBucketFishCooked "Cooked Brook Bass" [ALCH:0x0000087C]
		ClearAndAddModFood(0x0000087D, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodCabezonCooked "Cooked Scorpion Fish" [ALCH:0x0000087D]
		ClearAndAddModFood(0x0000087E, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodCarpCooked "Cooked Carp" [ALCH:0x0000087E]
		ClearAndAddModFood(0x0000087F, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodCuckooCatfishCooked "Cooked Catfish" [ALCH:0x0000087F]
		ClearAndAddModFood(0x00000880, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodDragonfishCooked "Cooked Direfish" [ALCH:0x00000880]
		ClearAndAddModFood(0x00000881, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodFlameAngelfishCooked "Cooked Angelfish" [ALCH:0x00000881]
		ClearAndAddModFood(0x00000882, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodGlassCatfishCooked "Cooked Glass Catfish" [ALCH:0x00000882]
		ClearAndAddModFood(0x00000883, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodGoldfishCooked "Cooked Goldfish" [ALCH:0x00000883]
		ClearAndAddModFood(0x0000089A, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodJuvenileMudcrabCooked "Cooked Juvenile Mudcrab" [ALCH:0x0000089A]
		ClearAndAddModFood(0x00000884, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodLyretailAnthiasCooked "Cooked Lyretail Anthias" [ALCH:0x00000884]
		ClearAndAddModFood(0x00000886, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodPinnateSpadefishCooked "Cooked Spadefish" [ALCH:0x00000886]
		ClearAndAddModFood(0x00000885, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodPygmySunfishCooked "Cooked Pygmy Sunfish" [ALCH:0x00000885]
		ClearAndAddModFood(0x00000887, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodTripodFishCooked "Cooked Tripod Spiderfish" [ALCH:0x00000887]
		ClearAndAddModFood(0x0000088A, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodTunaSalmonCooked "Cooked Pogfish" [ALCH:0x0000088A]
		ClearAndAddModFood(0x00000888, "ccBGSSSE001-Fish.esm", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; ccBGSSSE001_FoodVampireFishCooked "Cooked Vampire Fish" [ALCH:0x00000888]
		
		; Soups
		ClearAndAddModFood(0x00000F76, "ccBGSSSE001-Fish.esm", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; ccBGSSSE001_FoodSoupCrabStew "Crab Stew" [ALCH:0x00000F76]
		ClearAndAddModFood(0x00000F02, "ccBGSSSE001-Fish.esm", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; ccBGSSSE001_FoodSoupCreamyCrabBisque "Creamy Crab Bisque" [ALCH:0x00000F02]
		ClearAndAddModFood(0x00000F06, "ccBGSSSE001-Fish.esm", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; ccBGSSSE001_FoodSoupPotatoCrabChowder "Potato Crab Chowder" [ALCH:0x00000F06]
		ClearAndAddModFood(0x00000F04, "ccBGSSSE001-Fish.esm", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; ccBGSSSE001_FoodSoupTomatoCrabBisque "Roasted Tomato Crab Bisque" [ALCH:0x00000F04]
		
		; Hot Soups
		;/
		ClearAndAddModFood(0x00000F77, "ccBGSSSE001-Fish.esm", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; ccBGSSSE001_FoodSoupCrabStewHOT "Hot Crab Stew" [ALCH:0x00000F77]
		ClearAndAddModFood(0x00000F0A, "ccBGSSSE001-Fish.esm", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; ccBGSSSE001_FoodSoupCreamyCrabBisqueHOT "Hot Creamy Crab Bisque" [ALCH:0x00000F0A]
		ClearAndAddModFood(0x00000F0B, "ccBGSSSE001-Fish.esm", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; ccBGSSSE001_FoodSoupPotatoCrabChowderHOT "Hot Potato Crab Chowder" [ALCH:0x00000F0B]
		ClearAndAddModFood(0x00000F0C, "ccBGSSSE001-Fish.esm", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; ccBGSSSE001_FoodSoupTomatoCrabBisqueHOT "Hot Roasted Tomato Crab Bisque" [ALCH:0x00000F0C]
		/;
		
		;Alcohol
		ClearAndAddModFood(0x00000C2D, "ccBGSSSE001-Fish.esm", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicSpirit)	; ccBGSSSE001_MiscKhajiit_AgedFlin "Aged Flin" [ALCH:0x00000C2D]
		
		initialiseWaterBottles_CCFishing()
		
		_Seed_ImportCCFish_Done.show()
	endif
endFunction

function AddModFood(int aiFormID, String espName, FormList list1, FormList list2 = none, FormList list3 = none, bool injectedRecord = false)
	Potion theFood = Game.GetFormFromFile(aiFormID, espName) as Potion
	if theFood	
		list1.AddForm(theFood)
		if list2 != none
			list2.AddForm(theFood)
		endif
		if list3 != none
			list3.AddForm(theFood)
		endif
	elseif !injectedRecord
		SeedDebug(3, "[FoodDataStoreHandler] WARNING: Unable to find food from mod " + espName + ": " + aiFormID)
	endIf
endFunction

function ClearAndAddModFood(int aiFormID, String espName, FormList list1, FormList list2 = none, FormList list3 = none, bool injectedRecord = false)
	Potion theFood = Game.GetFormFromFile(aiFormID, espName) as Potion
	if theFood	
		;First Clear existing settings
		if isKnownFood(theFood, false, true)
			ClearFoodIdentity(theFood)
			ClearFoodRestoreAmount(theFood)
			ClearAlcoholType(theFood)
			SetFoodPreserved(theFood, false)
			SetFoodSalted(theFood, false)
		endif
		AddModFood(aiFormID, espName, list1, list2, list3, injectedRecord)
	elseif !injectedRecord
		SeedDebug(3, "[FoodDataStoreHandler] WARNING: Unable to find food from mod " + espName + ": " + aiFormID)
	endIf
endFunction

function addCampfireWaterskinsAll()
	addCampfireWaterskin(_Seed_Waterskin1)
	addCampfireWaterskin(_Seed_Waterskin1Clean)
	addCampfireWaterskin(_Seed_Waterskin2)
	addCampfireWaterskin(_Seed_Waterskin2Clean)
	addCampfireWaterskin(_Seed_Waterskin3)
	addCampfireWaterskin(_Seed_Waterskin3Clean)
	addCampfireWaterskin(_Seed_WaterskinEmpty)
	addCampfireWaterskin(_Seed_WaterskinSea)
	addCampfireWaterskin(_Seed_WaterskinSnow)
endFunction

function addCampfireWaterskin(form waterskin)
	if _Camp_ModWaterSkins.Find(waterskin) == -1
		_Camp_ModWaterSkins.addForm(waterskin)
	endif
endFunction

function ResetAllFormLists()
	;Debug.Notification("Last Seed is Starting Up (0%)")
	ResetFormList(_Seed_Bread, _Seed_BreadBASE)
	ResetFormList(_Seed_Cheese, _Seed_CheeseBASE)
	ResetFormList(_Seed_CheeseBowls, _Seed_CheeseBowlsBASE)
	ResetFormList(_Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicBASE)
	ResetFormList(_Seed_DrinkAlcoholicAle, _Seed_DrinkAlcoholicAleBASE)
	ResetFormList(_Seed_DrinkAlcoholicSpirit, _Seed_DrinkAlcoholicSpiritBASE)
	ResetFormList(_Seed_DrinkAlcoholicWine, _Seed_DrinkAlcoholicWineBASE)	
	ResetFormList(_Seed_DrinkSkoomaWeak, _Seed_DrinkSkoomaWeakBASE)
	ResetFormList(_Seed_DrinkSkoomaStrong, _Seed_DrinkSkoomaStrongBASE)
	;Debug.Notification("Last Seed is Starting Up (25%)")
	ResetFormList(_Seed_DrinkMilk, _Seed_DrinkMilkBASE)
	ResetFormList(_Seed_DrinkNonAlcoholic, _Seed_DrinkNonAlcoholicBASE)
	ResetFormList(_Seed_FishCooked, _Seed_FishCookedBASE)
	ResetFormList(_Seed_FishRaw, _Seed_FishRawBASE)
	ResetFormList(_Seed_Food_RestoreHungerMajor, _Seed_Food_RestoreHungerMajorBASE)
	ResetFormList(_Seed_Food_RestoreHungerMassive, _Seed_Food_RestoreHungerMassiveBASE)
	ResetFormList(_Seed_Food_RestoreHungerMinor, _Seed_Food_RestoreHungerMinorBASE)
	;Debug.Notification("Last Seed is Starting Up (50%)")
	ResetFormList(_Seed_Food_RestoreHungerSuperior, _Seed_Food_RestoreHungerSuperiorBASE)
	ResetFormList(_Seed_Fruit, _Seed_FruitBASE)
	ResetFormList(_Seed_MeatCooked, _Seed_MeatCookedBASE)
	ResetFormList(_Seed_MeatRaw, _Seed_MeatRawBASE)
	ResetFormList(_Seed_NotFood, _Seed_NotFoodBASE)
	ResetFormList(_Seed_Pastries, _Seed_PastriesBASE)
	ResetFormList(_Seed_Preserved, _Seed_PreservedBASE)
	;Debug.Notification("Last Seed is Starting Up (75%)")
	ResetFormList(_Seed_SaltedFood, _Seed_SaltedFoodBASE)
	ResetFormList(_Seed_SeafoodCooked, _Seed_SeafoodCookedBASE)
	ResetFormList(_Seed_SeafoodRaw, _Seed_SeafoodRawBASE)
	ResetFormList(_Seed_SmallGameCooked, _Seed_SmallGameCookedBASE)
	ResetFormList(_Seed_SmallGameRaw, _Seed_SmallGameRawBASE)
	ResetFormList(_Seed_Stews, _Seed_StewsBASE)
	ResetFormList(_Seed_Treats, _Seed_TreatsBASE)
	ResetFormList(_Seed_Vegetables, _Seed_VegetablesBASE)
	resetFormlistBloodPotions()
	_Seed_SystemFoods.revert()
	;Debug.Notification("Finished adding food")
endFunction

function resetFormlistBloodPotions()
	ResetFormList(_Seed_BloodPotions, _Seed_BloodPotionsBASE)
endFunction


function ResetFormList(formList refList, formList baseList)
	SeedDebug(0, "[FoodDataStoreHandler]Setting Formlist: " + refList)
	refList.Revert()
	int aIndex = baseList.GetSize()
	While aIndex
		aIndex -= 1
		refList.AddForm(baseList.GetAt(aIndex))
		;SeedDebug(0, "[FoodDataStoreHandler]Added form: " + baseList.GetAt(aIndex))
	EndWhile
endFunction

function resetMultiPartFood_Array()
	multiFoodList_WholeFood = new Potion[128]
	multiFoodList_WholeFood_2 = new Potion[128]
	multiFoodList_WholeFood_3 = new Potion[128]
	multiFoodList_WholeFood_4 = new Potion[128]
	multiFoodList_ResultFood = new Potion[128]
	multiFoodList_ResultFood_2 = new Potion[128]
	multiFoodList_ResultFood_3 = new Potion[128]
	multiFoodList_ResultFood_4 = new Potion[128]
	multiFoodList_Quantity = new int[128]
	multiFoodList_Quantity_2 = new int[128]
	multiFoodList_Quantity_3 = new int[128]
	multiFoodList_Quantity_4 = new int[128]
	initialiseMultiPartFood()
endFunction

function initialiseMultiPartFood()
	; Bread
	AddMultiPartFood_Array(FoodBread01A, FoodBread01B, 1)
	
	;Goats Cheese
	AddMultiPartFood_Array(FoodCheeseWheel01A, FoodCheeseWedge01, 7)
	AddMultiPartFood_Array(FoodCheeseWheel01B, FoodCheeseWedge01, 4)
	
	; Eidar Cheese	
	AddMultiPartFood_Array(FoodCheeseWheel02A, FoodCheeseWedge02, 7)
	AddMultiPartFood_Array(FoodCheeseWheel02B, FoodCheeseWedge02, 6)
	
	; Dirty Waterskins
	AddMultiPartFood_Array(_Seed_Waterskin3, _Seed_Waterskin2, 1)
	AddMultiPartFood_Array(_Seed_Waterskin2, _Seed_Waterskin1, 1)
	AddMultiPartFood_Array(_Seed_Waterskin1, _Seed_WaterskinEmpty, 1)
	
	; Clean Waterskins
	AddMultiPartFood_Array(_Seed_Waterskin3Clean, _Seed_Waterskin2Clean, 1)
	AddMultiPartFood_Array(_Seed_Waterskin2Clean, _Seed_Waterskin1Clean, 1)
	AddMultiPartFood_Array(_Seed_Waterskin1Clean, _Seed_WaterskinEmpty, 1)
	
	; Waterskins that aren't drinkable
	AddMultiPartFood_Array(_Seed_WaterskinSea, _Seed_WaterskinSea, 1)
	AddMultiPartFood_Array(_Seed_WaterskinSnow, _Seed_WaterskinSnow, 1)
	
	initialiseWaterBottles()
	
	;Cooking Ingredient
	;AddMultiPartFood_Array(FoodHoney, FoodHoney, 1)
	;AddMultiPartFood_Array(BYOHFoodFlour, BYOHFoodFlour, 1)
	;AddMultiPartFood_Array(BYOHFoodButter, BYOHFoodButter, 1)
	;AddMultiPartFood_Array(_Seed_CookingWater, _Seed_CookingWater, 1)
endFunction

function initialiseWaterBottles()
	AddMultiPartFood_Array(_Seed_WaterBottle, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(_Seed_WaterBottleClean, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(_Seed_WaterBottleSea, _Seed_WaterBottleSea, 1)
	AddMultiPartFood_Array(_Seed_WaterBottleSea, _Seed_WaterBottleSea, 1)
	AddMultiPartFood_Array(_Seed_WaterBottleSnow, _Seed_WaterBottleSnow, 1)
	AddMultiPartFood_Array(Ale, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(AleWhiterunQuest, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(DLC2FoodAshfireMead, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(FoodBlackBriarMead, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(FoodBlackBriarMeadPrivateReserve, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(FoodHonningbrewMead, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(FoodMead, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(FreeformDragonBridgeMead, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(MQ101JuniperMead, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(BYOHFoodWineBottle04, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(BYOHFoodWineBottle03, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(DLC2RRFavor01EmberbrandWine, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(FirebrandWine, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(FoodSolitudeSpicedWine, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(FoodWineAlto, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(FoodWineAltoA, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(FoodWineBottle02, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(FoodWineBottle02A, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(MS14WineAltoA, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(MQ201Drink, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(WEDL03CyrodilicBrandy, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(DLC2Sujamma, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(DLC2RRF04Sujamma, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(DLC2Matze, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(DLC2Shein, _Seed_WaterBottleEmpty, 1)
	AddMultiPartFood_Array(DLC2Flin, _Seed_WaterBottleEmpty, 1)
endFunction


function initialiseWaterBottles_CACO()
	;CLEAR VANILLA BOTTLES
	RemoveMultiPartFood_Array(BYOHFoodWineBottle04)
	RemoveMultiPartFood_Array(BYOHFoodWineBottle03)
	RemoveMultiPartFood_Array(DLC2RRFavor01EmberbrandWine)
	RemoveMultiPartFood_Array(FirebrandWine)
	RemoveMultiPartFood_Array(FoodSolitudeSpicedWine)
	RemoveMultiPartFood_Array(FoodWineAlto)
	RemoveMultiPartFood_Array(FoodWineAltoA)
	RemoveMultiPartFood_Array(FoodWineBottle02)
	RemoveMultiPartFood_Array(FoodWineBottle02A)
	RemoveMultiPartFood_Array(MS14WineAltoA)
	RemoveMultiPartFood_Array(MQ201Drink)
	RemoveMultiPartFood_Array(WEDL03CyrodilicBrandy)
	RemoveMultiPartFood_Array(DLC2Sujamma)
	RemoveMultiPartFood_Array(DLC2RRF04Sujamma)
	RemoveMultiPartFood_Array(DLC2Matze)
	RemoveMultiPartFood_Array(DLC2Shein)
	RemoveMultiPartFood_Array(DLC2Flin)

	initialiseWaterBottles_Mod(0x0045AFF9, "Complete Alchemy & Cooking Overhaul.esp")	;BYOHFoodWineBottle031 "Surilie Brothers Wine" [ALCH:0x0045AFF9][ALCH:0x0045AFF9]
	initialiseWaterBottles_Mod(0x0045AFF2, "Complete Alchemy & Cooking Overhaul.esp")	;BYOHFoodWineBottle041 "Argonian Bloodwine" [ALCH:0x0045AFF2]
	initialiseWaterBottles_Mod(0x0046011A, "Complete Alchemy & Cooking Overhaul.esp")	;DLC2FoodDrinkFlin1 "Flin" [ALCH:0x0046011A]
	initialiseWaterBottles_Mod(0x00460140, "Complete Alchemy & Cooking Overhaul.esp")	;DLC2FoodDrinkMatze1 "Mazte" [ALCH:0x00460140]
	initialiseWaterBottles_Mod(0x0046012A, "Complete Alchemy & Cooking Overhaul.esp")	;DLC2FoodDrinkRRF04Sujamma1 "Sadri's Sujamma" [ALCH:0x0046012A]
	initialiseWaterBottles_Mod(0x0045B00A, "Complete Alchemy & Cooking Overhaul.esp")	;DLC2FoodDrinkRRFavor01EmberbrandWine1 "Emberbrand Wine" [ALCH:0x0045B00A]
	initialiseWaterBottles_Mod(0x0046013A, "Complete Alchemy & Cooking Overhaul.esp")	;DLC2Shein1 "Shein" [ALCH:0x0046013A]
	initialiseWaterBottles_Mod(0x00460124, "Complete Alchemy & Cooking Overhaul.esp")	;DLC2Sujamma1 "Sujamma" [ALCH:0x00460124]
	initialiseWaterBottles_Mod(0x00450DD2, "Complete Alchemy & Cooking Overhaul.esp")	;FoodDrinkFirebrandWine1 "Firebrand Wine" [ALCH:0x00450DD2]
	initialiseWaterBottles_Mod(0x0044BCCB, "Complete Alchemy & Cooking Overhaul.esp")	;MQ201DrinkBrandy1 "Colovian Brandy" [ALCH:0x0044BCCB]
	initialiseWaterBottles_Mod(0x00450DDB, "Complete Alchemy & Cooking Overhaul.esp")	;MS14WineAltoA1 "Jessica's Wine" [ALCH:0x00450DDB]
	initialiseWaterBottles_Mod(0x00450DE4, "Complete Alchemy & Cooking Overhaul.esp")	;FoodSolitudeSpicedWine1 "Spiced Wine" [ALCH:0x00450DE4]
	initialiseWaterBottles_Mod(0x002F8755, "Complete Alchemy & Cooking Overhaul.esp")	;WEDL03CyrodilicBrandy1 "Cyrodilic Brandy" [ALCH:0x002F8755]
	initialiseWaterBottles_Mod(0x002BBAC9, "Complete Alchemy & Cooking Overhaul.esp")	;FoodWineAlto1 "Alto Noir Wine" [ALCH:0x002BBAC9]
	initialiseWaterBottles_Mod(0x002EE520, "Complete Alchemy & Cooking Overhaul.esp")	;FoodWineAltoA1 "Alto Blanc Wine" [ALCH:0x002EE520]
	initialiseWaterBottles_Mod(0x002EE529, "Complete Alchemy & Cooking Overhaul.esp")	;FoodWineBottle021 "Village Red Wine" [ALCH:0x002EE529]
	initialiseWaterBottles_Mod(0x002EE52F, "Complete Alchemy & Cooking Overhaul.esp")	;FoodWineBottle02A1 "Village White Wine" [ALCH:0x002EE52F]
endFunction

function initialiseMultiPartFood_CACO()
	AddModMultiPartFood_Array(0x072BBAC7, "Complete Alchemy & Cooking Overhaul.esp",	0x072BBAC9, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWineAlto2 "Alto Noir Wine" [ALCH:0x072BBAC7]	FoodDrinkWineAlto1 "Alto Noir Wine" [ALCH:0x072BBAC9]	1
	AddModMultiPartFood_Array(0x072BBAC6, "Complete Alchemy & Cooking Overhaul.esp",	0x072BBAC7, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWineAlto3 "Alto Noir Wine" [ALCH:0x072BBAC6]	FoodDrinkWineAlto2 "Alto Noir Wine" [ALCH:0x072BBAC7]	1
	AddModMultiPartFood_Array(0x00003133B, "Skyrim.esm",								0x072BBAC6, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWineAlto "Alto Noir Wine" [ALCH:0x0003133B]	FoodDrinkWineAlto3 "Alto Noir Wine" [ALCH:0x072BBAC6]	1
	AddModMultiPartFood_Array(0x072EE522, "Complete Alchemy & Cooking Overhaul.esp",	0x072EE520, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWineAltoA2 "Alto Blanc Wine" [ALCH:0x072EE522]	FoodDrinkWineAltoA1 "Alto Blanc Wine" [ALCH:0x072EE520]	1
	AddModMultiPartFood_Array(0x072EE524, "Complete Alchemy & Cooking Overhaul.esp", 	0x072EE522, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWineAltoA3 "Alto Blanc Wine" [ALCH:0x072EE524]	FoodDrinkWineAltoA2 "Alto Blanc Wine" [ALCH:0x072EE522]	1
	AddModMultiPartFood_Array(0x000C5349, "Skyrim.esm", 								0x072EE524, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWineAltoA "Alto Blanc Wine" [ALCH:0x000C5349]	FoodDrinkWineAltoA3 "Alto Blanc Wine" [ALCH:0x072EE524]	1
	AddModMultiPartFood_Array(0x0745AFF3, "Complete Alchemy & Cooking Overhaul.esp", 	0x0745AFF2, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodDrinkWineBottle042 "Argonian Bloodwine" [ALCH:0x0745AFF3]	BYOHFoodDrinkWineBottle041 "Argonian Bloodwine" [ALCH:0x0745AFF2]	1
	AddModMultiPartFood_Array(0x0745AFF6, "Complete Alchemy & Cooking Overhaul.esp", 	0x0745AFF3, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodDrinkWineBottle043 "Argonian Bloodwine" [ALCH:0x0745AFF6]	BYOHFoodDrinkWineBottle042 "Argonian Bloodwine" [ALCH:0x0745AFF3]	1
	AddModMultiPartFood_Array(0x03003535, "HearthFires.esm", 							0x0745AFF6, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodDrinkWineBottle04 "Argonian Bloodwine" [ALCH:0x03003535]	BYOHFoodDrinkWineBottle043 "Argonian Bloodwine" [ALCH:0x0745AFF6]	1
	AddModMultiPartFood_Array(0x072F8757, "Complete Alchemy & Cooking Overhaul.esp", 	0x072F8755, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWEDL03CyrodilicBrandy2 "Cyrodilic Brandy" [ALCH:0x072F8757]	FoodDrinkWEDL03CyrodilicBrandy1 "Cyrodilic Brandy" [ALCH:0x072F8755]	1
	AddModMultiPartFood_Array(0x072F8758, "Complete Alchemy & Cooking Overhaul.esp", 	0x072F8757, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWEDL03CyrodilicBrandy3 "Cyrodilic Brandy" [ALCH:0x072F8758]	FoodDrinkWEDL03CyrodilicBrandy2 "Cyrodilic Brandy" [ALCH:0x072F8757]	1
	AddModMultiPartFood_Array(0x072F875B, "Complete Alchemy & Cooking Overhaul.esp", 	0x072F8758, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWEDL03CyrodilicBrandy4 "Cyrodilic Brandy" [ALCH:0x072F875B]	FoodDrinkWEDL03CyrodilicBrandy3 "Cyrodilic Brandy" [ALCH:0x072F8758]	1
	AddModMultiPartFood_Array(0x072F875D, "Complete Alchemy & Cooking Overhaul.esp", 	0x072F875B, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWEDL03CyrodilicBrandy5 "Cyrodilic Brandy" [ALCH:0x072F875D]	FoodDrinkWEDL03CyrodilicBrandy4 "Cyrodilic Brandy" [ALCH:0x072F875B]	1
	AddModMultiPartFood_Array(0x072F875F, "Complete Alchemy & Cooking Overhaul.esp", 	0x072F875D, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWEDL03CyrodilicBrandy6 "Cyrodilic Brandy" [ALCH:0x072F875F]	FoodDrinkWEDL03CyrodilicBrandy5 "Cyrodilic Brandy" [ALCH:0x072F875D]	1
	AddModMultiPartFood_Array(0x072F8761, "Complete Alchemy & Cooking Overhaul.esp", 	0x072F875F, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWEDL03CyrodilicBrandy7 "Cyrodilic Brandy" [ALCH:0x072F8761]	FoodDrinkWEDL03CyrodilicBrandy6 "Cyrodilic Brandy" [ALCH:0x072F875F]	1
	AddModMultiPartFood_Array(0x072F8763, "Complete Alchemy & Cooking Overhaul.esp", 	0x072F8761, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWEDL03CyrodilicBrandy8 "Cyrodilic Brandy" [ALCH:0x072F8763]	FoodDrinkWEDL03CyrodilicBrandy7 "Cyrodilic Brandy" [ALCH:0x072F8761]	1
	AddModMultiPartFood_Array(0x072F8765, "Complete Alchemy & Cooking Overhaul.esp", 	0x072F8763, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWEDL03CyrodilicBrandy9 "Cyrodilic Brandy" [ALCH:0x072F8765]	FoodDrinkWEDL03CyrodilicBrandy8 "Cyrodilic Brandy" [ALCH:0x072F8763]	1
	AddModMultiPartFood_Array(0x072F8767, "Complete Alchemy & Cooking Overhaul.esp", 	0x072F8765, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWEDL03CyrodilicBrandy10 "Cyrodilic Brandy" [ALCH:0x072F8767]	FoodDrinkWEDL03CyrodilicBrandy9 "Cyrodilic Brandy" [ALCH:0x072F8765]	1
	AddModMultiPartFood_Array(0x072F8769, "Complete Alchemy & Cooking Overhaul.esp", 	0x072F8767, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWEDL03CyrodilicBrandy11 "Cyrodilic Brandy" [ALCH:0x072F8769]	FoodDrinkWEDL03CyrodilicBrandy10 "Cyrodilic Brandy" [ALCH:0x072F8767]	1
	AddModMultiPartFood_Array(0x072F876B, "Complete Alchemy & Cooking Overhaul.esp", 	0x072F8769, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWEDL03CyrodilicBrandy12 "Cyrodilic Brandy" [ALCH:0x072F876B]	FoodDrinkWEDL03CyrodilicBrandy11 "Cyrodilic Brandy" [ALCH:0x072F8769]	1
	AddModMultiPartFood_Array(0x072F876D, "Complete Alchemy & Cooking Overhaul.esp", 	0x072F876B, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWEDL03CyrodilicBrandy13 "Cyrodilic Brandy" [ALCH:0x072F876D]	FoodDrinkWEDL03CyrodilicBrandy12 "Cyrodilic Brandy" [ALCH:0x072F876B]	1
	AddModMultiPartFood_Array(0x072F876F, "Complete Alchemy & Cooking Overhaul.esp", 	0x072F876D, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWEDL03CyrodilicBrandy14 "Cyrodilic Brandy" [ALCH:0x072F876F]	FoodDrinkWEDL03CyrodilicBrandy13 "Cyrodilic Brandy" [ALCH:0x072F876D]	1
	AddModMultiPartFood_Array(0x072F8771, "Complete Alchemy & Cooking Overhaul.esp", 	0x072F876F, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWEDL03CyrodilicBrandy15 "Cyrodilic Brandy" [ALCH:0x072F8771]	FoodDrinkWEDL03CyrodilicBrandy14 "Cyrodilic Brandy" [ALCH:0x072F876F]	1
	AddModMultiPartFood_Array(0x000B91D7, "Skyrim.esm", 								0x072F8771, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWEDL03CyrodilicBrandy "Cyrodilic Brandy" [ALCH:0x000B91D7]	FoodDrinkWEDL03CyrodilicBrandy15 "Cyrodilic Brandy" [ALCH:0x072F8771]	1
	AddModMultiPartFood_Array(0x00065C97, "Skyrim.esm", 								0x00065C98, "Skyrim.esm", 1)								; FoodBread01A "Farm Bread" [ALCH:0x00065C97]	FoodBread01B "Farm Bread" [ALCH:0x00065C98]	1
	AddModMultiPartFood_Array(0x071FB199, "Complete Alchemy & Cooking Overhaul.esp", 	0x074B6328, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodBakeBreadDark_Nernie "Dark Bread" [ALCH:0x071FB199]	CACO_FoodBakeBreadDarkB_Nernie "Dark Bread" [ALCH:0x074B6328]	1
	AddModMultiPartFood_Array(0x03003537, "HearthFires.esm", 							0x074B6322, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodBakeBreadPotato01A "Potato Bread" [ALCH:0x03003537]	BYOHFoodBakeBreadPotato01B "Potato Bread" [ALCH:0x074B6322]	1
	AddModMultiPartFood_Array(0x071FB19F, "Complete Alchemy & Cooking Overhaul.esp", 	0x074C569B, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodBakeBreadRound01_Nernie "Barley Bread" [ALCH:0x071FB19F]	CACO_FoodBakeBreadRound01B_Nernie "Barley Bread" [ALCH:0x074C569B]	1
	AddModMultiPartFood_Array(0x071FB19D, "Complete Alchemy & Cooking Overhaul.esp", 	0x074C569D, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodBakeBreadRound02_Nernie "Barley Nut Bread" [ALCH:0x071FB19D]	CACO_FoodBakeBreadRound02B_Nernie "Barley Nut Bread" [ALCH:0x074C569D]	1
	AddModMultiPartFood_Array(0x071FB1A1, "Complete Alchemy & Cooking Overhaul.esp", 	0x074B6325, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodBakeBreadWheat_Nernie "Wheat Bread" [ALCH:0x071FB1A1]	CACO_FoodBakeBreadWheatB_Nernie "Wheat Bread" [ALCH:0x074B6325]	1
	AddModMultiPartFood_Array(0x0720540E, "Complete Alchemy & Cooking Overhaul.esp", 	0x074B631F, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodBakeBreadWheatHoney_Nernie "Honey Wheat Bread" [ALCH:0x0720540E]	CACO_FoodBakeBreadWheatHoneyB_Nernie "Honey Wheat Bread" [ALCH:0x074B631F]	1
	AddModMultiPartFood_Array(0x00064B3F, "Skyrim.esm", 								0x07511764, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodVegCabbage "Cabbage" [ALCH:0x00064B3F]	FoodVegCabbageHalf "Cabbage Half" [ALCH:0x07511764]	1
	AddModMultiPartFood_Array(0x00064B34, "Skyrim.esm", 								0x00064B36, "Skyrim.esm", 1)								; FoodCheeseWheel02A "Eidar Cheese Wheel" [ALCH:0x00064B34]	FoodCheeseWheel02B "Eidar Cheese Sliced" [ALCH:0x00064B36]	1
	AddModMultiPartFood_Array(0x00064B36, "Skyrim.esm", 								0x00064B32, "Skyrim.esm", 8)								; FoodCheeseWheel02B "Sliced Eidar Cheese" [ALCH:0x00064B36]	FoodCheeseWedge02 "Eidar Cheese" [ALCH:0x00064B32]	8
	AddModMultiPartFood_Array(0x00064B33, "Skyrim.esm", 								0x00064B31, "Skyrim.esm", 11)								; FoodCheeseWheel01A "Goat Cheese Wheel" [ALCH:0x00064B33]	FoodCheeseWedge01 "Goat Cheese" [ALCH:0x00064B31]	11
	AddModMultiPartFood_Array(0x00064B35, "Skyrim.esm", 								0x00064B31, "Skyrim.esm", 7)								; FoodCheeseWheel01B "Goat Cheese Sliced" [ALCH:0x00064B35]	FoodCheeseWedge01 "Goat Cheese" [ALCH:0x00064B31]	7
	AddModMultiPartFood_Array(0x071FB17F, "Complete Alchemy & Cooking Overhaul.esp", 	0x071FB179, "Complete Alchemy & Cooking Overhaul.esp", 11)	; CACO_FoodCheeseWheel01A_Nernie "Haafingar Cheese Wheel" [ALCH:0x071FB17F]	CACO_FoodCheeseWedge01C_Nernie "Haafingar Cheese" [ALCH:0x071FB179]	11
	AddModMultiPartFood_Array(0x071FB187, "Complete Alchemy & Cooking Overhaul.esp", 	0x071FB179, "Complete Alchemy & Cooking Overhaul.esp", 7)	; CACO_FoodCheeseWheel01B_Nernie "Haafingar Cheese Sliced" [ALCH:0x071FB187]	CACO_FoodCheeseWedge01C_Nernie "Haafingar Cheese" [ALCH:0x071FB179]	7
	AddModMultiPartFood_Array(0x071FB17D, "Complete Alchemy & Cooking Overhaul.esp", 	0x071FB185, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodCheeseWheel02A_Nernie "Ivarstead Cheese Wheel" [ALCH:0x071FB17D]	CACO_FoodCheeseWheel02B_Nernie "Ivarstead Cheese Sliced" [ALCH:0x071FB185]	1
	AddModMultiPartFood_Array(0x071FB185, "Complete Alchemy & Cooking Overhaul.esp", 	0x071FB177, "Complete Alchemy & Cooking Overhaul.esp", 8)	; CACO_FoodCheeseWheel02B_Nernie "Ivarstead Cheese Sliced" [ALCH:0x071FB185]	CACO_FoodCheeseWedge02C_Nernie "Ivarstead Cheese" [ALCH:0x071FB177]	8
	AddModMultiPartFood_Array(0x071FB17B, "Complete Alchemy & Cooking Overhaul.esp", 	0x071FB175, "Complete Alchemy & Cooking Overhaul.esp", 11)	; CACO_FoodCheeseWheel03A_Nernie "Rorikstead Cheese Wheel" [ALCH:0x071FB17B]	CACO_FoodCheeseWedge03C_Nernie "Rorikstead Cheese" [ALCH:0x071FB175]	11
	AddModMultiPartFood_Array(0x071FB183, "Complete Alchemy & Cooking Overhaul.esp", 	0x071FB175, "Complete Alchemy & Cooking Overhaul.esp", 7)	; CACO_FoodCheeseWheel03B_Nernie "Rorikstead Cheese Sliced" [ALCH:0x071FB183]	CACO_FoodCheeseWedge03C_Nernie "Rorikstead Cheese" [ALCH:0x071FB175]	7
	
	AddModMultiPartFood_Array(0x07450DD4, "Complete Alchemy & Cooking Overhaul.esp", 	0x07450DD2, "Complete Alchemy & Cooking Overhaul.esp", 1)    ; FoodDrinkFirebrandWine2 "Firebrand Wine" [ALCH:0x07450DD4]    FoodDrinkFirebrandWine1 "Firebrand Wine" [ALCH:0x07450DD2]    1
	AddModMultiPartFood_Array(0x07450DD6, "Complete Alchemy & Cooking Overhaul.esp", 	0x07450DD4, "Complete Alchemy & Cooking Overhaul.esp", 1)    ; FoodDrinkFirebrandWine3 "Firebrand Wine" [ALCH:0x07450DD6]    FoodDrinkFirebrandWine2 "Firebrand Wine" [ALCH:0x07450DD4]    1
	AddModMultiPartFood_Array(0x00450DD2, "Skyrim.esm",									0x07450DD6, "Complete Alchemy & Cooking Overhaul.esp", 1)    ; FirebrandWine "Firebrand Wine" [ALCH:0001895F]    FoodDrinkFirebrandWine3 "Firebrand Wine" [ALCH:0x07450DD6]    1
	AddModMultiPartFood_Array(0x0045B00C, "Complete Alchemy & Cooking Overhaul.esp", 	0x0045B00A, "Complete Alchemy & Cooking Overhaul.esp", 1)    ; DLC2FoodDrinkRRFavor01EmberbrandWine2 "Emberbrand Wine" [ALCH:0x0045B00C]    DLC2FoodDrinkRRFavor01EmberbrandWine1 "Emberbrand Wine" [ALCH:0x0045B00A]    1
	AddModMultiPartFood_Array(0x0045B00E, "Complete Alchemy & Cooking Overhaul.esp", 	0x0045B00C, "Complete Alchemy & Cooking Overhaul.esp", 1)    ;DLC2FoodDrinkRRFavor01EmberbrandWine3 "Emberbrand Wine" [ALCH:0x0045B00E]    DLC2FoodDrinkRRFavor01EmberbrandWine2 "Emberbrand Wine" [ALCH:0x0045B00C]    1
	AddModMultiPartFood_Array(0x000320DF, "Dragonborn.esm", 							0x0045B00E, "Complete Alchemy & Cooking Overhaul.esp", 1)    ; DLC2FoodDrinkRRFavor01EmberbrandWine "Emberbrand Wine" [ALCH:040320DF]    DLC2FoodDrinkRRFavor01EmberbrandWine3 "Emberbrand Wine" [ALCH:0x0045B00E]    1
	;AddModMultiPartFood_Array(0x07450DD4, "Complete Alchemy & Cooking Overhaul.esp", 	0x07450DD2, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkFirebrandWine2 "Firebrand Wine" [ALCH:0x07450DD4]	FoodDrinkFirebrandWine1 "Firebrand Wine" [ALCH:0x07450DD2]	1
	;AddModMultiPartFood_Array(0x07450DD6, "Complete Alchemy & Cooking Overhaul.esp", 	0x07450DD4, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkFirebrandWine3 "Firebrand Wine" [ALCH:0x07450DD6]	FoodDrinkFirebrandWine2 "Firebrand Wine" [ALCH:0x07450DD4]	1
	;AddModMultiPartFood_Array(0x07450DD2, "Complete Alchemy & Cooking Overhaul.esp", 	0x07450DD6, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkFirebrandWine1 "Firebrand Wine" [ALCH:0x07450DD2]	FoodDrinkFirebrandWine3 "Firebrand Wine" [ALCH:0x07450DD6]	1
	;AddModMultiPartFood_Array(0x07450DD4, "Complete Alchemy & Cooking Overhaul.esp", 	0x07450DD2, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkFirebrandWine2 "Firebrand Wine" [ALCH:0x07450DD4]	FoodDrinkFirebrandWine1 "Firebrand Wine" [ALCH:0x07450DD2]	1
	;AddModMultiPartFood_Array(0x07450DD6, "Complete Alchemy & Cooking Overhaul.esp", 	0x07450DD4, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkFirebrandWine3 "Firebrand Wine" [ALCH:0x07450DD6]	FoodDrinkFirebrandWine2 "Firebrand Wine" [ALCH:0x07450DD4]	1
	;AddModMultiPartFood_Array(0x040320DF, "Dragonborn.esm", 							0x07450DD6, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkRRFavor01EmberbrandWine "Emberbrand Wine" [ALCH:0x040320DF]	FoodDrinkFirebrandWine3 "Firebrand Wine" [ALCH:0x07450DD6]	1
	
	AddModMultiPartFood_Array(0x07460116, "Complete Alchemy & Cooking Overhaul.esp", 	0x0746011A, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkFlin2 "Flin" [ALCH:0x07460116]	DLC2FoodDrinkFlin1 "Flin" [ALCH:0x0746011A]	1
	AddModMultiPartFood_Array(0x07460117, "Complete Alchemy & Cooking Overhaul.esp", 	0x07460116, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkFlin3 "Flin" [ALCH:0x07460117]	DLC2FoodDrinkFlin2 "Flin" [ALCH:0x07460116]	1
	AddModMultiPartFood_Array(0x040207E5, "Dragonborn.esm", 							0x07460117, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkFlin "Flin" [ALCH:0x040207E5]	DLC2FoodDrinkFlin3 "Flin" [ALCH:0x07460117]	1
	AddModMultiPartFood_Array(0x03003538, "HearthFires.esm", 							0x075023C9, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour "Sack of Wheat Flour" [ALCH:0x03003538]	BYOHFoodFlour19 "Sack of Wheat Flour" [ALCH:0x075023C9]	1
	AddModMultiPartFood_Array(0x075023EA, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023ED, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour02 "Sack of Wheat Flour" [ALCH:0x075023EA]	BYOHFoodFlour01 "Sack of Wheat Flour" [ALCH:0x075023ED]	1
	AddModMultiPartFood_Array(0x0752ACD6, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACD4, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley02 "Sack of Barley Flour" [ALCH:0x0752ACD6]	BYOHFoodIngrFlourBarley01 "Sack of Barley Flour" [ALCH:0x0752ACD4]	1
	AddModMultiPartFood_Array(0x075023E9, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023EA, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour03 "Sack of Wheat Flour" [ALCH:0x075023E9]	BYOHFoodFlour02 "Sack of Wheat Flour" [ALCH:0x075023EA]	1
	AddModMultiPartFood_Array(0x0752ACD8, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACD6, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley03 "Sack of Barley Flour" [ALCH:0x0752ACD8]	BYOHFoodIngrFlourBarley02 "Sack of Barley Flour" [ALCH:0x0752ACD6]	1
	AddModMultiPartFood_Array(0x075023E7, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023E9, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour04 "Sack of Wheat Flour" [ALCH:0x075023E7]	BYOHFoodFlour03 "Sack of Wheat Flour" [ALCH:0x075023E9]	1
	AddModMultiPartFood_Array(0x0752ACDA, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACD8, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley04 "Sack of Barley Flour" [ALCH:0x0752ACDA]	BYOHFoodIngrFlourBarley03 "Sack of Barley Flour" [ALCH:0x0752ACD8]	1
	AddModMultiPartFood_Array(0x075023E5, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023E7, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour05 "Sack of Wheat Flour" [ALCH:0x075023E5]	BYOHFoodFlour04 "Sack of Wheat Flour" [ALCH:0x075023E7]	1
	AddModMultiPartFood_Array(0x0752ACDC, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACDA, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley05 "Sack of Barley Flour" [ALCH:0x0752ACDC]	BYOHFoodIngrFlourBarley04 "Sack of Barley Flour" [ALCH:0x0752ACDA]	1
	AddModMultiPartFood_Array(0x075023E3, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023E5, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour06 "Sack of Wheat Flour" [ALCH:0x075023E3]	BYOHFoodFlour05 "Sack of Wheat Flour" [ALCH:0x075023E5]	1
	AddModMultiPartFood_Array(0x0752ACDE, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACDC, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley06 "Sack of Barley Flour" [ALCH:0x0752ACDE]	BYOHFoodIngrFlourBarley05 "Sack of Barley Flour" [ALCH:0x0752ACDC]	1
	AddModMultiPartFood_Array(0x075023E1, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023E3, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour07 "Sack of Wheat Flour" [ALCH:0x075023E1]	BYOHFoodFlour06 "Sack of Wheat Flour" [ALCH:0x075023E3]	1
	AddModMultiPartFood_Array(0x0752ACE0, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACDE, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley07 "Sack of Barley Flour" [ALCH:0x0752ACE0]	BYOHFoodIngrFlourBarley06 "Sack of Barley Flour" [ALCH:0x0752ACDE]	1
	AddModMultiPartFood_Array(0x075023DF, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023E1, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour08 "Sack of Wheat Flour" [ALCH:0x075023DF]	BYOHFoodFlour07 "Sack of Wheat Flour" [ALCH:0x075023E1]	1
	AddModMultiPartFood_Array(0x0752ACE2, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACE0, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley08 "Sack of Barley Flour" [ALCH:0x0752ACE2]	BYOHFoodIngrFlourBarley07 "Sack of Barley Flour" [ALCH:0x0752ACE0]	1
	AddModMultiPartFood_Array(0x075023DD, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023DF, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour09 "Sack of Wheat Flour" [ALCH:0x075023DD]	BYOHFoodFlour08 "Sack of Wheat Flour" [ALCH:0x075023DF]	1
	AddModMultiPartFood_Array(0x0752ACE4, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACE2, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley09 "Sack of Barley Flour" [ALCH:0x0752ACE4]	BYOHFoodIngrFlourBarley08 "Sack of Barley Flour" [ALCH:0x0752ACE2]	1
	AddModMultiPartFood_Array(0x075023DB, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023DD, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour10 "Sack of Wheat Flour" [ALCH:0x075023DB]	BYOHFoodFlour09 "Sack of Wheat Flour" [ALCH:0x075023DD]	1
	AddModMultiPartFood_Array(0x0752ACE6, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACE4, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley10 "Sack of Barley Flour" [ALCH:0x0752ACE6]	BYOHFoodIngrFlourBarley09 "Sack of Barley Flour" [ALCH:0x0752ACE4]	1
	AddModMultiPartFood_Array(0x075023D9, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023DB, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour11 "Sack of Wheat Flour" [ALCH:0x075023D9]	BYOHFoodFlour10 "Sack of Wheat Flour" [ALCH:0x075023DB]	1
	AddModMultiPartFood_Array(0x0752ACE8, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACE6, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley11 "Sack of Barley Flour" [ALCH:0x0752ACE8]	BYOHFoodIngrFlourBarley10 "Sack of Barley Flour" [ALCH:0x0752ACE6]	1
	AddModMultiPartFood_Array(0x075023D7, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023D9, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour12 "Sack of Wheat Flour" [ALCH:0x075023D7]	BYOHFoodFlour11 "Sack of Wheat Flour" [ALCH:0x075023D9]	1
	AddModMultiPartFood_Array(0x0752ACEA, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACE8, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley12 "Sack of Barley Flour" [ALCH:0x0752ACEA]	BYOHFoodIngrFlourBarley11 "Sack of Barley Flour" [ALCH:0x0752ACE8]	1
	AddModMultiPartFood_Array(0x075023D5, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023D7, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour13 "Sack of Wheat Flour" [ALCH:0x075023D5]	BYOHFoodFlour12 "Sack of Wheat Flour" [ALCH:0x075023D7]	1
	AddModMultiPartFood_Array(0x0752ACEC, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACEA, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley13 "Sack of Barley Flour" [ALCH:0x0752ACEC]	BYOHFoodIngrFlourBarley12 "Sack of Barley Flour" [ALCH:0x0752ACEA]	1
	AddModMultiPartFood_Array(0x075023D3, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023D5, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour14 "Sack of Wheat Flour" [ALCH:0x075023D3]	BYOHFoodFlour13 "Sack of Wheat Flour" [ALCH:0x075023D5]	1
	AddModMultiPartFood_Array(0x0752ACEE, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACEC, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley14 "Sack of Barley Flour" [ALCH:0x0752ACEE]	BYOHFoodIngrFlourBarley13 "Sack of Barley Flour" [ALCH:0x0752ACEC]	1
	AddModMultiPartFood_Array(0x075023D1, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023D3, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour15 "Sack of Wheat Flour" [ALCH:0x075023D1]	BYOHFoodFlour14 "Sack of Wheat Flour" [ALCH:0x075023D3]	1
	AddModMultiPartFood_Array(0x0752ACF0, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACEE, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley15 "Sack of Barley Flour" [ALCH:0x0752ACF0]	BYOHFoodIngrFlourBarley14 "Sack of Barley Flour" [ALCH:0x0752ACEE]	1
	AddModMultiPartFood_Array(0x075023CF, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023D1, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour16 "Sack of Wheat Flour" [ALCH:0x075023CF]	BYOHFoodFlour15 "Sack of Wheat Flour" [ALCH:0x075023D1]	1
	AddModMultiPartFood_Array(0x0752ACF2, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACF0, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley16 "Sack of Barley Flour" [ALCH:0x0752ACF2]	BYOHFoodIngrFlourBarley15 "Sack of Barley Flour" [ALCH:0x0752ACF0]	1
	AddModMultiPartFood_Array(0x075023CD, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023CF, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour17 "Sack of Wheat Flour" [ALCH:0x075023CD]	BYOHFoodFlour16 "Sack of Wheat Flour" [ALCH:0x075023CF]	1
	AddModMultiPartFood_Array(0x0752ACF4, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACF2, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley17 "Sack of Barley Flour" [ALCH:0x0752ACF4]	BYOHFoodIngrFlourBarley16 "Sack of Barley Flour" [ALCH:0x0752ACF2]	1
	AddModMultiPartFood_Array(0x075023CB, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023CD, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour18 "Sack of Wheat Flour" [ALCH:0x075023CB]	BYOHFoodFlour17 "Sack of Wheat Flour" [ALCH:0x075023CD]	1
	AddModMultiPartFood_Array(0x0752ACF6, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACF4, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley18 "Sack of Barley Flour" [ALCH:0x0752ACF6]	BYOHFoodIngrFlourBarley17 "Sack of Barley Flour" [ALCH:0x0752ACF4]	1
	AddModMultiPartFood_Array(0x075023C9, "Complete Alchemy & Cooking Overhaul.esp", 	0x075023CB, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodFlour19 "Sack of Wheat Flour" [ALCH:0x075023C9]	BYOHFoodFlour18 "Sack of Wheat Flour" [ALCH:0x075023CB]	1
	AddModMultiPartFood_Array(0x0752ACF8, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACF6, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodIngrFlourBarley19 "Sack of Barley Flour" [ALCH:0x0752ACF8]	BYOHFoodIngrFlourBarley18 "Sack of Barley Flour" [ALCH:0x0752ACF6]	1
	AddModMultiPartFood_Array(0x07A10116, "Complete Alchemy & Cooking Overhaul.esp", 	0x0752ACF8, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrFlourBarley "Sack of Barley Flour" [ALCH:0x07A10116]	BYOHFoodIngrFlourBarley19 "Sack of Barley Flour" [ALCH:0x0752ACF8]	1
	AddModMultiPartFood_Array(0x0750750A, "Complete Alchemy & Cooking Overhaul.esp", 	0x0750750B, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrSalt02 "Salt" [ALCH:0x0750750A]	CACO_FoodIngrSalt01 "Salt" [ALCH:0x0750750B]	1
	AddModMultiPartFood_Array(0x074B633B, "Complete Alchemy & Cooking Overhaul.esp", 	0x0750750A, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrSalt03 "Salt" [ALCH:0x074B633B]	CACO_FoodIngrSalt02 "Salt" [ALCH:0x0750750A]	1
	AddModMultiPartFood_Array(0x0750750D, "Complete Alchemy & Cooking Overhaul.esp", 	0x074B633B, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrSalt04 "Salt" [ALCH:0x0750750D]	CACO_FoodIngrSalt03 "Salt" [ALCH:0x074B633B]	1
	AddModMultiPartFood_Array(0x07450DDD, "Complete Alchemy & Cooking Overhaul.esp", 	0x07450DDB, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMS14WineAltoA2 "Jessica's Wine" [ALCH:0x07450DDD]	FoodDrinkMS14WineAltoA1 "Jessica's Wine" [ALCH:0x07450DDB]	1
	AddModMultiPartFood_Array(0x07450DDF, "Complete Alchemy & Cooking Overhaul.esp", 	0x07450DDD, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMS14WineAltoA3 "Jessica's Wine" [ALCH:0x07450DDF]	FoodDrinkMS14WineAltoA2 "Jessica's Wine" [ALCH:0x07450DDD]	1
	AddModMultiPartFood_Array(0x000F257E, "Skyrim.esm", 								0x07450DDF, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMS14WineAltoA "Jessica's Wine" [ALCH:0x000F257E]	FoodDrinkMS14WineAltoA3 "Jessica's Wine" [ALCH:0x07450DDF]	1
	AddModMultiPartFood_Array(0x07460142, "Complete Alchemy & Cooking Overhaul.esp", 	0x07460140, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkMatze2 "Mazte" [ALCH:0x07460142]	DLC2FoodDrinkMatze1 "Mazte" [ALCH:0x07460140]	1
	AddModMultiPartFood_Array(0x07460144, "Complete Alchemy & Cooking Overhaul.esp", 	0x07460142, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkMatze3 "Mazte" [ALCH:0x07460144]	DLC2FoodDrinkMatze2 "Mazte" [ALCH:0x07460142]	1
	AddModMultiPartFood_Array(0x040248CE, "Dragonborn.esm", 							0x07460144, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkMatze "Mazte" [ALCH:0x040248CE]	DLC2FoodDrinkMatze3 "Mazte" [ALCH:0x07460144]	1
	AddModMultiPartFood_Array(0x0403BD15, "Dragonborn.esm", 							0x074C0579, "Complete Alchemy & Cooking Overhaul.esp", 3)	; DLC2FoodMeatAshHopper "Raw Ash Hopper Meat" [ALCH:0x0403BD15]	CACO_FoodMeatAshHopperMeat "Raw Ash Hopper Meat" [ALCH:0x074C0579]	3
	AddModMultiPartFood_Array(0x07190B54, "Complete Alchemy & Cooking Overhaul.esp", 	0x0748DA65, "Complete Alchemy & Cooking Overhaul.esp", 3)	; CACO_FoodMeatBear "Raw Bear Meat" [ALCH:0x07190B54]	CACO_FoodMeatBearRawPortion "Raw Bear Steak" [ALCH:0x0748DA65]	3
	AddModMultiPartFood_Array(0x00065C99, "Skyrim.esm", 								0x0748DA6D, "Complete Alchemy & Cooking Overhaul.esp", 3)	; FoodMeatBeef "Raw Beef" [ALCH:0x00065C99]	FoodMeatBeefRawPortion "Raw Beef Steak" [ALCH:0x0748DA6D]	3
	AddModMultiPartFood_Array(0x07220142, "Complete Alchemy & Cooking Overhaul.esp", 	0x000721E8, "Skyrim.esm", 3)								; CACO_FoodMeatBeefCookedWhole "Roast Beef" [ALCH:0x07220142]	FoodMeatBeefCooked "Cooked Beef" [ALCH:0x000721E8]	3
	AddModMultiPartFood_Array(0x0403BD14, "Dragonborn.esm", 							0x0754425D, "Complete Alchemy & Cooking Overhaul.esp", 3)	; DLC2FoodMeatBoar "Raw Boar Meat" [ALCH:0x0403BD14]	CACO_FoodMeatBoarRawPortion "Raw Boar Sliced" [ALCH:0x0754425D]	3
	AddModMultiPartFood_Array(0x0403CF72, "Dragonborn.esm", 							0x0754426C, "Complete Alchemy & Cooking Overhaul.esp", 3)	; DLC2FoodMeatBoarCured "Cured Boar Meat" [ALCH:0x0403CF72]	CACO_FoodMeatBoarCuredPortion "Cured Boar Slices" [ALCH:0x0754426C]	3
	AddModMultiPartFood_Array(0x0720A518, "Complete Alchemy & Cooking Overhaul.esp", 	0x0720A519, "Complete Alchemy & Cooking Overhaul.esp", 3)	; CACO_FoodMeatCured_Nernie "Cured Meat" [ALCH:0x0720A518]	CACO_FoodMeatCuredSliced_Nernie "Cured Meat Slices" [ALCH:0x0720A519]	3
	AddModMultiPartFood_Array(0x00065C9A, "Skyrim.esm", 								0x0749CDC7, "Complete Alchemy & Cooking Overhaul.esp", 3)	; FoodMeatGoat "Raw Goat Leg" [ALCH:0x00065C9A]	CACO_FoodMeatGoatPortionRaw "Raw Goat Meat" [ALCH:0x0749CDC7]	3
	AddModMultiPartFood_Array(0x0007224C, "Skyrim.esm", 								0x0749CDC5, "Complete Alchemy & Cooking Overhaul.esp", 3)	; FoodMeatGoatCooked "Roast Goat" [ALCH:0x0007224C]	CACO_FoodMeatGoatPortionCooked "Cooked Goat" [ALCH:0x0749CDC5]	3
	AddModMultiPartFood_Array(0x01CCA130, "Update.esm", 								0x07492B83, "Complete Alchemy & Cooking Overhaul.esp", 3)	; CACO_FoodMeatHumanoidFlesh "Raw Hominid Flesh" [ALCH:0x01CCA130]	CACO_FoodMeatHumanoidFleshRawPortion "Raw Hominid Meat" [ALCH:0x07492B83]	3
	AddModMultiPartFood_Array(0x00065C9B, "Skyrim.esm", 								0x0749CDBC, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodMeatHorker "Raw Horker Meat" [ALCH:0x00065C9B]	FoodMeatHorkerRawPortion "Raw Horker Loaf" [ALCH:0x0749CDBC]	1
	AddModMultiPartFood_Array(0x00065C9C, "Skyrim.esm", 								0x0749CDB1, "Complete Alchemy & Cooking Overhaul.esp", 3)	; FoodMeatHorse "Raw Horse Meat" [ALCH:0x00065C9C]	FoodMeatHorseRawPortion "Raw Horse Steak" [ALCH:0x0749CDB1]	3
	AddModMultiPartFood_Array(0x000722B0, "Skyrim.esm", 								0x0749CDB5, "Complete Alchemy & Cooking Overhaul.esp", 3)	; FoodMeatHorseCookedWhole "Roast Horse Haunch" [ALCH:0x000722B0]	FoodMeatHorseCookedPortion "Cooked Horse Steak" [ALCH:0x0749CDB5]	3
	AddModMultiPartFood_Array(0x07190B56, "Complete Alchemy & Cooking Overhaul.esp", 	0x0749CDAC, "Complete Alchemy & Cooking Overhaul.esp", 4)	; CACO_FoodMeatMammoth "Raw Mammoth Meat" [ALCH:0x07190B56]	CACO_FoodMeatMammothRawPortion "Raw Mammoth Steak" [ALCH:0x0749CDAC]	4
	AddModMultiPartFood_Array(0x000669A4, "Skyrim.esm", 								0x07492B7C, "Complete Alchemy & Cooking Overhaul.esp", 5)	; FoodMeatMammoth "Raw Mammoth Snout" [ALCH:0x000669A4]	FoodMeatMammothRawPortion "Raw Mammoth Snout Steak" [ALCH:0x07492B7C]	5
	AddModMultiPartFood_Array(0x01CCA145, "Update.esm", 								0x0799E788, "Complete Alchemy & Cooking Overhaul.esp", 3)	; CACO_FoodMeatPork "Raw Pork" [ALCH:0x01CCA145]	CACO_FoodMeatPorkRawPortion "Raw Pork Sliced" [ALCH:0x0799E788]	3
	AddModMultiPartFood_Array(0x0799E784, "Complete Alchemy & Cooking Overhaul.esp", 	0x0799E78E, "Complete Alchemy & Cooking Overhaul.esp", 3)	; CACO_FoodMeatPorkCured "Cured Pork" [ALCH:0x0799E784]	CACO_FoodMeatPorkCuredPortion "Cured Ham Slices" [ALCH:0x0799E78E]	3
	AddModMultiPartFood_Array(0x07190B53, "Complete Alchemy & Cooking Overhaul.esp", 	0x074A1ED3, "Complete Alchemy & Cooking Overhaul.esp", 3)	; CACO_FoodMeatSabre "Raw Sabre Cat Meat" [ALCH:0x07190B53]	CACO_FoodMeatSabreRawPortion "Raw Sabre Cat Steak" [ALCH:0x074A1ED3]	3
	AddModMultiPartFood_Array(0x01CCA147, "Update.esm", 								0x00065C9F,"Skyrim.esm", 1)									; FoodSeaSalmonWhole01 "Salmon" [ALCH:0x01CCA147]	FoodSeaSalmon "Raw Salmon Fillet" [ALCH:0x00065C9F]	1
	AddModMultiPartFood_Array(0x01CCA148, "Update.esm", 								0x00065C9F,"Skyrim.esm", 1)									; FoodSeaSalmonWhole02 "Salmon" [ALCH:0x01CCA148]	FoodSeaSalmon "Raw Salmon Fillet" [ALCH:0x00065C9F]	1
	AddModMultiPartFood_Array(0x0748DA5A, "Complete Alchemy & Cooking Overhaul.esp", 	0x07492B79, "Complete Alchemy & Cooking Overhaul.esp", 3)	; CACO_FoodMeatTroll "Raw Troll Meat" [ALCH:0x0748DA5A]	CACO_FoodMeatTrollRawPortion "Raw Troll Steak" [ALCH:0x07492B79]	3
	AddModMultiPartFood_Array(0x000669A2, "Skyrim.esm", 								0x07492B7A, "Complete Alchemy & Cooking Overhaul.esp", 3)	; FoodMeatVenison "Raw Venison" [ALCH:0x000669A2]	FoodMeatVenisonRawPortion "Raw Venison Steak" [ALCH:0x07492B7A]	3
	AddModMultiPartFood_Array(0x07220143, "Complete Alchemy & Cooking Overhaul.esp", 	0x000722BD, "Skyrim.esm", 3)								; CACO_FoodMeatVenisonCookedWhole "Cooked Venison" [ALCH:0x07220143]	FoodMeatVenisonCooked "Cooked Venison Steak" [ALCH:0x000722BD]	3
	AddModMultiPartFood_Array(0x03003534, "HearthFires.esm", 							0x01CCA121, "Update.esm", 2)								; BYOHFoodDrinkMilk "Jug of Fresh Milk" [ALCH:0x03003534]	CACO_FoodDrinkMilkBottle "Milk" [ALCH:0x01CCA121]	2
	AddModMultiPartFood_Array(0x0744BCC9, "Complete Alchemy & Cooking Overhaul.esp", 	0x0744BCCB, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMQ201DrinkBrandy2 "Colovian Brandy" [ALCH:0x0744BCC9]	FoodDrinkMQ201DrinkBrandy1 "Colovian Brandy" [ALCH:0x0744BCCB]	1
	AddModMultiPartFood_Array(0x0744BCC7, "Complete Alchemy & Cooking Overhaul.esp", 	0x0744BCC9, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMQ201DrinkBrandy3 "Colovian Brandy" [ALCH:0x0744BCC7]	FoodDrinkMQ201DrinkBrandy2 "Colovian Brandy" [ALCH:0x0744BCC9]	1
	AddModMultiPartFood_Array(0x0744BCC5, "Complete Alchemy & Cooking Overhaul.esp", 	0x0744BCC7, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMQ201DrinkBrandy4 "Colovian Brandy" [ALCH:0x0744BCC5]	FoodDrinkMQ201DrinkBrandy3 "Colovian Brandy" [ALCH:0x0744BCC7]	1
	AddModMultiPartFood_Array(0x0744BCC3, "Complete Alchemy & Cooking Overhaul.esp", 	0x0744BCC5, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMQ201DrinkBrandy5 "Colovian Brandy" [ALCH:0x0744BCC3]	FoodDrinkMQ201DrinkBrandy4 "Colovian Brandy" [ALCH:0x0744BCC5]	1
	AddModMultiPartFood_Array(0x0744BCC1, "Complete Alchemy & Cooking Overhaul.esp", 	0x0744BCC3, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMQ201DrinkBrandy6 "Colovian Brandy" [ALCH:0x0744BCC1]	FoodDrinkMQ201DrinkBrandy5 "Colovian Brandy" [ALCH:0x0744BCC3]	1
	AddModMultiPartFood_Array(0x0744BCBF, "Complete Alchemy & Cooking Overhaul.esp", 	0x0744BCC1, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMQ201DrinkBrandy7 "Colovian Brandy" [ALCH:0x0744BCBF]	FoodDrinkMQ201DrinkBrandy6 "Colovian Brandy" [ALCH:0x0744BCC1]	1
	AddModMultiPartFood_Array(0x0744BCBD, "Complete Alchemy & Cooking Overhaul.esp", 	0x0744BCBF, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMQ201DrinkBrandy8 "Colovian Brandy" [ALCH:0x0744BCBD]	FoodDrinkMQ201DrinkBrandy7 "Colovian Brandy" [ALCH:0x0744BCBF]	1
	AddModMultiPartFood_Array(0x0744BCBB, "Complete Alchemy & Cooking Overhaul.esp", 	0x0744BCBD, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMQ201DrinkBrandy9 "Colovian Brandy" [ALCH:0x0744BCBB]	FoodDrinkMQ201DrinkBrandy8 "Colovian Brandy" [ALCH:0x0744BCBD]	1
	AddModMultiPartFood_Array(0x0744BCB9, "Complete Alchemy & Cooking Overhaul.esp", 	0x0744BCBB, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMQ201DrinkBrandy10 "Colovian Brandy" [ALCH:0x0744BCB9]	FoodDrinkMQ201DrinkBrandy9 "Colovian Brandy" [ALCH:0x0744BCBB]	1
	AddModMultiPartFood_Array(0x0744BCB6, "Complete Alchemy & Cooking Overhaul.esp", 	0x0744BCB9, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMQ201DrinkBrandy11 "Colovian Brandy" [ALCH:0x0744BCB6]	FoodDrinkMQ201DrinkBrandy10 "Colovian Brandy" [ALCH:0x0744BCB9]	1
	AddModMultiPartFood_Array(0x0744BCB4, "Complete Alchemy & Cooking Overhaul.esp", 	0x0744BCB6, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMQ201DrinkBrandy12 "Colovian Brandy" [ALCH:0x0744BCB4]	FoodDrinkMQ201DrinkBrandy11 "Colovian Brandy" [ALCH:0x0744BCB6]	1
	AddModMultiPartFood_Array(0x0744BCB2, "Complete Alchemy & Cooking Overhaul.esp", 	0x0744BCB4, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMQ201DrinkBrandy13 "Colovian Brandy" [ALCH:0x0744BCB2]	FoodDrinkMQ201DrinkBrandy12 "Colovian Brandy" [ALCH:0x0744BCB4]	1
	AddModMultiPartFood_Array(0x0744BCA2, "Complete Alchemy & Cooking Overhaul.esp", 	0x0744BCB2, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMQ201DrinkBrandy14 "Colovian Brandy" [ALCH:0x0744BCA2]	FoodDrinkMQ201DrinkBrandy13 "Colovian Brandy" [ALCH:0x0744BCB2]	1
	AddModMultiPartFood_Array(0x0744BCA1, "Complete Alchemy & Cooking Overhaul.esp", 	0x0744BCA2, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMQ201DrinkBrandy15 "Colovian Brandy" [ALCH:0x0744BCA1]	FoodDrinkMQ201DrinkBrandy14 "Colovian Brandy" [ALCH:0x0744BCA2]	1
	AddModMultiPartFood_Array(0x00036D53, "Skyrim.esm", 								0x0744BCA1, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkMQ201Drink "Colovian Brandy" [ALCH:0x00036D53]	FoodDrinkMQ201DrinkBrandy15 "Colovian Brandy" [ALCH:0x0744BCA1]	1
	AddModMultiPartFood_Array(0x079E056C, "Complete Alchemy & Cooking Overhaul.esp", 	0x079E056E, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrOil02 "Oil" [ALCH:0x079E056C]	CACO_FoodIngrOil01 "Oil" [ALCH:0x079E056E]	1
	AddModMultiPartFood_Array(0x079E056A, "Complete Alchemy & Cooking Overhaul.esp", 	0x079E056C, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrOil03 "Oil" [ALCH:0x079E056A]	CACO_FoodIngrOil02 "Oil" [ALCH:0x079E056C]	1
	AddModMultiPartFood_Array(0x079E0567, "Complete Alchemy & Cooking Overhaul.esp", 	0x079E056A, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrOil04 "Oil" [ALCH:0x079E0567]	CACO_FoodIngrOil03 "Oil" [ALCH:0x079E056A]	1
	AddModMultiPartFood_Array(0x01CCA124, "Update.esm", 								0x079E0567, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrOil "Oil" [ALCH:0x01CCA124]	CACO_FoodIngrOil04 "Oil" [ALCH:0x079E0567]	1
	AddModMultiPartFood_Array(0x00064B43, "Skyrim.esm", 								0x0754E48A, "Complete Alchemy & Cooking Overhaul.esp", 7)	; FoodBakePie "Apple Pie" [ALCH:0x00064B43]	FoodBakePieSlice "Apple Pie Slice" [ALCH:0x0754E48A]	7
	AddModMultiPartFood_Array(0x0746012B, "Complete Alchemy & Cooking Overhaul.esp", 	0x0746012A, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkRRF04Sujamma2 "Sadri's Sujamma" [ALCH:0x0746012B]	DLC2FoodDrinkRRF04Sujamma1 "Sadri's Sujamma" [ALCH:0x0746012A]	1
	AddModMultiPartFood_Array(0x0746012E, "Complete Alchemy & Cooking Overhaul.esp", 	0x0746012B, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkRRF04Sujamma3 "Sadri's Sujamma" [ALCH:0x0746012E]	DLC2FoodDrinkRRF04Sujamma2 "Sadri's Sujamma" [ALCH:0x0746012B]	1
	AddModMultiPartFood_Array(0x04024E0B, "Dragonborn.esm", 							0x0746012E, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkRRF04Sujamma	DLC2FoodDrinkRRF04Sujamma3 "Sadri's Sujamma" [ALCH:0x0746012E]	1
	AddModMultiPartFood_Array(0x0746013C, "Complete Alchemy & Cooking Overhaul.esp", 	0x0746013A, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkShein2 "Shein" [ALCH:0x0746013C]	DLC2FoodDrinkShein1 "Shein" [ALCH:0x0746013A]	1
	AddModMultiPartFood_Array(0x0746013E, "Complete Alchemy & Cooking Overhaul.esp", 	0x0746013C, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkShein3 "Shein" [ALCH:0x0746013E]	DLC2FoodDrinkShein2 "Shein" [ALCH:0x0746013C]	1
	AddModMultiPartFood_Array(0x040248CC, "Dragonborn.esm", 							0x0746013E, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkShein "Shein" [ALCH:0x040248CC]	DLC2FoodDrinkShein3 "Shein" [ALCH:0x0746013E]	1
	AddModMultiPartFood_Array(0x07450DE6, "Complete Alchemy & Cooking Overhaul.esp", 	0x07450DE4, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkSolitudeSpicedWine2 "Spiced Wine" [ALCH:0x07450DE6]	FoodDrinkSolitudeSpicedWine1 "Spiced Wine" [ALCH:0x07450DE4]	1
	AddModMultiPartFood_Array(0x07450DE8, "Complete Alchemy & Cooking Overhaul.esp", 	0x07450DE6, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkSolitudeSpicedWine3 "Spiced Wine" [ALCH:0x07450DE8]	FoodDrinkSolitudeSpicedWine2 "Spiced Wine" [ALCH:0x07450DE6]	1
	AddModMultiPartFood_Array(0x00085368, "Skyrim.esm", 								0x07450DE8, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkSolitudeSpicedWine "Spiced Wine" [ALCH:0x00085368]	FoodDrinkSolitudeSpicedWine3 "Spiced Wine" [ALCH:0x07450DE8]	1
	AddModMultiPartFood_Array(0x07460126, "Complete Alchemy & Cooking Overhaul.esp", 	0x07460124, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkSujamma2 "Sujamma" [ALCH:0x07460126]	DLC2FoodDrinkSujamma1 "Sujamma" [ALCH:0x07460124]	1
	AddModMultiPartFood_Array(0x07460128, "Complete Alchemy & Cooking Overhaul.esp", 	0x07460126, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkSujamma3 "Sujamma" [ALCH:0x07460128]	DLC2FoodDrinkSujamma2 "Sujamma" [ALCH:0x07460126]	1
	AddModMultiPartFood_Array(0x040207E6, "Dragonborn.esm", 							0x07460128, "Complete Alchemy & Cooking Overhaul.esp", 1)	; DLC2FoodDrinkSujamma "Sujamma" [ALCH:0x040207E6]	DLC2FoodDrinkSujamma3 "Sujamma" [ALCH:0x07460128]	1
	AddModMultiPartFood_Array(0x0745AFFC, "Complete Alchemy & Cooking Overhaul.esp", 	0x0745AFF9, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodDrinkWineBottle032 "Surilie Brothers Wine" [ALCH:0x0745AFFC]	BYOHFoodDrinkWineBottle031 "Surilie Brothers Wine" [ALCH:0x0745AFF9]	1
	AddModMultiPartFood_Array(0x0745AFFE, "Complete Alchemy & Cooking Overhaul.esp", 	0x0745AFFC, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodDrinkWineBottle033 "Surilie Brothers Wine" [ALCH:0x0745AFFE]	BYOHFoodDrinkWineBottle032 "Surilie Brothers Wine" [ALCH:0x0745AFFC]	1
	AddModMultiPartFood_Array(0x03003536, "HearthFires.esm", 							0x0745AFFE, "Complete Alchemy & Cooking Overhaul.esp", 1)	; BYOHFoodDrinkWineBottle03 "Surilie Brothers Wine" [ALCH:0x03003536]	BYOHFoodDrinkWineBottle033 "Surilie Brothers Wine" [ALCH:0x0745AFFE]	1
	AddModMultiPartFood_Array(0x079E0572, "Complete Alchemy & Cooking Overhaul.esp", 	0x079E0574, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrVinegar02 "Vinegar" [ALCH:0x079E0572]	CACO_FoodIngrVinegar01 "Vinegar" [ALCH:0x079E0574]	1
	AddModMultiPartFood_Array(0x079E0570, "Complete Alchemy & Cooking Overhaul.esp", 	0x079E0572, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrVinegar03 "Vinegar" [ALCH:0x079E0570]	CACO_FoodIngrVinegar02 "Vinegar" [ALCH:0x079E0572]	1
	AddModMultiPartFood_Array(0x079E0568, "Complete Alchemy & Cooking Overhaul.esp", 	0x079E0570, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrVinegar04 "Vinegar" [ALCH:0x079E0568]	CACO_FoodIngrVinegar03 "Vinegar" [ALCH:0x079E0570]	1
	AddModMultiPartFood_Array(0x01CCA125, "Update.esm", 								0x079E0568, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrVinegar "Vinegar" [ALCH:0x01CCA125]	CACO_FoodIngrVinegar04 "Vinegar" [ALCH:0x079E0568]	1
	AddModMultiPartFood_Array(0x074E3D2B, "Complete Alchemy & Cooking Overhaul.esp", 	0x074E3D2D, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrWater02 "Jug of Water" [ALCH:0x074E3D2B]	CACO_FoodIngrWater01 "Jug of Water" [ALCH:0x074E3D2D]	1
	AddModMultiPartFood_Array(0x074E3D29, "Complete Alchemy & Cooking Overhaul.esp", 	0x074E3D2B, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrWater03 "Jug of Water" [ALCH:0x074E3D29]	CACO_FoodIngrWater02 "Jug of Water" [ALCH:0x074E3D2B]	1
	AddModMultiPartFood_Array(0x074E3D27, "Complete Alchemy & Cooking Overhaul.esp", 	0x074E3D29, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrWater04 "Jug of Water" [ALCH:0x074E3D27]	CACO_FoodIngrWater03 "Jug of Water" [ALCH:0x074E3D29]	1
	AddModMultiPartFood_Array(0x074E3D25, "Complete Alchemy & Cooking Overhaul.esp", 	0x074E3D27, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrWater05 "Jug of Water" [ALCH:0x074E3D25]	CACO_FoodIngrWater04 "Jug of Water" [ALCH:0x074E3D27]	1
	AddModMultiPartFood_Array(0x074E3D23, "Complete Alchemy & Cooking Overhaul.esp", 	0x074E3D25, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrWater06 "Jug of Water" [ALCH:0x074E3D23]	CACO_FoodIngrWater05 "Jug of Water" [ALCH:0x074E3D25]	1
	AddModMultiPartFood_Array(0x074E3D21, "Complete Alchemy & Cooking Overhaul.esp", 	0x074E3D23, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrWater07 "Jug of Water" [ALCH:0x074E3D21]	CACO_FoodIngrWater06 "Jug of Water" [ALCH:0x074E3D23]	1
	AddModMultiPartFood_Array(0x01CCA111, "Update.esm", 								0x074E3D21, "Complete Alchemy & Cooking Overhaul.esp", 1)	; CACO_FoodIngrWater "Jug of Water" [ALCH:0x01CCA111]	CACO_FoodIngrWater07 "Jug of Water" [ALCH:0x074E3D21]	1
	AddModMultiPartFood_Array(0x072EE52B, "Complete Alchemy & Cooking Overhaul.esp", 	0x072EE529, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWineBottle022 "Village Red Wine" [ALCH:0x072EE52B]	FoodDrinkWineBottle021 "Village Red Wine" [ALCH:0x072EE529]	1
	AddModMultiPartFood_Array(0x072EE52D, "Complete Alchemy & Cooking Overhaul.esp", 	0x072EE52B, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWineBottle023 "Village Red Wine" [ALCH:0x072EE52D]	FoodDrinkWineBottle022 "Village Red Wine" [ALCH:0x072EE52B]	1
	AddModMultiPartFood_Array(0x0003133C, "Skyrim.esm", 								0x072EE52D, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWineBottle02 "Village Red Wine" [ALCH:0x0003133C]	FoodDrinkWineBottle023 "Village Red Wine" [ALCH:0x072EE52D]	1
	AddModMultiPartFood_Array(0x072EE531, "Complete Alchemy & Cooking Overhaul.esp", 	0x072EE52F, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWineBottle02A2 "Village White Wine" [ALCH:0x072EE531]	FoodDrinkWineBottle02A1 "Village White Wine" [ALCH:0x072EE52F]	1
	AddModMultiPartFood_Array(0x072EE533, "Complete Alchemy & Cooking Overhaul.esp", 	0x072EE531, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWineBottle02A3 "Village White Wine" [ALCH:0x072EE533]	FoodDrinkWineBottle02A2 "Village White Wine" [ALCH:0x072EE531]	1
	AddModMultiPartFood_Array(0x000C5348, "Skyrim.esm", 								0x072EE533, "Complete Alchemy & Cooking Overhaul.esp", 1)	; FoodDrinkWineBottle02A "Village White Wine" [ALCH:0x000C5348]	FoodDrinkWineBottle02A3 "Village White Wine" [ALCH:0x072EE533]	1
endFunction

Function addWarmDrinks(bool checkRequired = true)
    if checkRequired && !SeedUtil.GetCompatibilitySystem().isWarmDrinksLoaded
		return
    endif
	_Seed_ImportWarmDrinks.Show()
	
	;Non-Alcoholic Drinks
	ClearAndAddModFood(0x0000FB0A, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoBlueMountainTea "Blue Flower Tea" [ALCH:0x0000FB0A]
	ClearAndAddModFood(0x00019D0E, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoRedMountainTea "Red Flower Tea" [ALCH:0x00019D0E]
	ClearAndAddModFood(0x00019D11, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoPurpleMountainTea "Purple Flower Tea" [ALCH:0x00019D11]
	ClearAndAddModFood(0x0001EE13, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoElvenCoffee "Elven Coffee" [ALCH:0x0001EE13]
	ClearAndAddModFood(0x00029018, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoNordicCoffee "Nordic Coffee" [ALCH:0x00029018]
	ClearAndAddModFood(0x00029019, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoNordicBlueMountainTea "Nordic Blue Tea" [ALCH:0x00029019]
	ClearAndAddModFood(0x0002901D, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoNordicPurpleMountainTea "Nordic Purple Tea" [ALCH:0x0002901D]
	ClearAndAddModFood(0x00029021, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoSummerRedMountainTea "Summer Red Tea" [ALCH:0x00029021]
	ClearAndAddModFood(0x00029023, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoSummerPurpleMountainTea "Summer Purple Tea" [ALCH:0x00029023]
	ClearAndAddModFood(0x00029025, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoSweetenedBlueMountainTea "Sweetened Blue Tea" [ALCH:0x00029025]
	ClearAndAddModFood(0x00029027, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoSweetenedRedMountainTea "Sweetened Red Tea" [ALCH:0x00029027]
	ClearAndAddModFood(0x0002902B, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoSweetSugarTea "Sweet Sugar Tea" [ALCH:0x0002902B]
	ClearAndAddModFood(0x0002902D, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoCalmingBlueMountainTea "Calming Blue Tea" [ALCH:0x0002902D]
	ClearAndAddModFood(0x0002902F, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoWayoftheVoiceTea "Way of the Voice Tea" [ALCH:0x0002902F]
	ClearAndAddModFood(0x00029031, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoAshTea "Ash Tea" [ALCH:0x00029031]
	ClearAndAddModFood(0x00029033, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoEveningAshTea "Evening Ash Tea" [ALCH:0x00029033]
	ClearAndAddModFood(0x00029035, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoWinterMead "Winter Mead" [ALCH:0x00029035]
	ClearAndAddModFood(0x00029037, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoWinterAle "Winter Ale" [ALCH:0x00029037]
	ClearAndAddModFood(0x00029039, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoWinterWine "Winter Wine" [ALCH:0x00029039]
	ClearAndAddModFood(0x0002903B, "Warm Drinks.esp", _Seed_DrinkNonAlcoholic)    ; LeoHorseSweat "Horse's Sweat" [ALCH:0x0002903B]
	
	; Weak Alcohol
	ClearAndAddModFood(0x00023F16, "Warm Drinks.esp",  _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)    ; LeoDarkElvenCoffee "Dark Elven Coffee" [ALCH:0x00023F16]
	ClearAndAddModFood(0x0002903D, "Warm Drinks.esp",  _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)    ; LeoEightDivinesBlessing "Eight Divines Blessing" [ALCH:0x0002903D]
	
	_Seed_ImportWarmDrinks_Done.Show()
endFunction


Function addProjectAho(bool checkRequired = true)
    if checkRequired && SeedUtil.GetCompatibilitySystem().isProjectAhoLoaded
		return
    endif
	
	_Seed_ImportProjectAho.Show()
	; Non-alcoholic Drinks
	ClearAndAddModFood(0x001CB81A, "Dwarfsphere.esp", _Seed_DrinkNonAlcoholic)	; DwaSpJuiceApple01 "Green Apple Juice" [ALCH:0x001CB81A]
	initialiseWaterBottles_Mod(0x001CB81A, "Dwarfsphere.esp")
	ClearAndAddModFood(0x001CB81C, "Dwarfsphere.esp", _Seed_DrinkNonAlcoholic)	; DwaSpJuiceApple02 "Red Apple Juice" [ALCH:0x001CB81C]
	initialiseWaterBottles_Mod(0x001CB81C, "Dwarfsphere.esp")
	ClearAndAddModFood(0x001CB820, "Dwarfsphere.esp", _Seed_DrinkNonAlcoholic)	; DwaSpJuiceCarrot "Carrot Juice" [ALCH:0x001CB820]
	initialiseWaterBottles_Mod(0x001CB820, "Dwarfsphere.esp")
	ClearAndAddModFood(0x001CB825, "Dwarfsphere.esp", _Seed_DrinkNonAlcoholic)	; DwaSpJuiceJazBay "Grape Juice" [ALCH:0x001CB825]
	initialiseWaterBottles_Mod(0x001CB825, "Dwarfsphere.esp")
	ClearAndAddModFood(0x001CB81E, "Dwarfsphere.esp", _Seed_DrinkNonAlcoholic)	; DwaSpJuicePotato "Potato Juice" [ALCH:0x001CB81E]
	initialiseWaterBottles_Mod(0x001CB81E, "Dwarfsphere.esp")
	ClearAndAddModFood(0x001CB822, "Dwarfsphere.esp", _Seed_DrinkNonAlcoholic)	; DwaSpJuiceTomato "Tomato Juice" [ALCH:0x001CB822]
	initialiseWaterBottles_Mod(0x001CB822, "Dwarfsphere.esp")
	ClearAndAddModFood(0x008AEAB5, "Dwarfsphere.esp", _Seed_DrinkNonAlcoholic)	; DwaSpTelvanniBugMusk "Telvanni Bug Musk" [ALCH:0x008AEAB5]
	initialiseWaterBottles_Mod(0x008AEAB5, "Dwarfsphere.esp")
	
	; ; Alcohol - Wine
	ClearAndAddModFood(0x001BC4F3, "Dwarfsphere.esp", _Seed_DrinkAlcoholicWine)	; DwaSpWineGrass "Herbal Infusion" [ALCH:0x001BC4F3]
	initialiseWaterBottles_Mod(0x001BC4F3, "Dwarfsphere.esp")
	ClearAndAddModFood(0x001B73D9, "Dwarfsphere.esp", _Seed_DrinkAlcoholicWine)	; DwaSpWineKrambambuli "Kram Bam Bula" [ALCH:0x001B73D9]
	initialiseWaterBottles_Mod(0x001B73D9, "Dwarfsphere.esp")
	ClearAndAddModFood(0x0027801A, "Dwarfsphere.esp", _Seed_DrinkAlcoholicWine)	; DwaSpWineRoDeo01 "Flame Rodeo" [ALCH:0x0027801A]
	initialiseWaterBottles_Mod(0x0027801A, "Dwarfsphere.esp")
	ClearAndAddModFood(0x0027801C, "Dwarfsphere.esp", _Seed_DrinkAlcoholicWine)	; DwaSpWineRoDeo02 "Water Rodeo" [ALCH:0x0027801C]
	initialiseWaterBottles_Mod(0x0027801C, "Dwarfsphere.esp")
	ClearAndAddModFood(0x0027801E, "Dwarfsphere.esp", _Seed_DrinkAlcoholicWine)	; DwaSpWineRoDeo03 "Mud Rodeo" [ALCH:0x0027801E]
	initialiseWaterBottles_Mod(0x0027801E, "Dwarfsphere.esp")
	ClearAndAddModFood(0x00278020, "Dwarfsphere.esp", _Seed_DrinkAlcoholicWine)	; DwaSpWineRoDeo04 "Air Rodeo" [ALCH:0x00278020]
	initialiseWaterBottles_Mod(0x00278020, "Dwarfsphere.esp")
	
	; Alcohol - Spirits
	ClearAndAddModFood(0x001BC4F0, "Dwarfsphere.esp", _Seed_DrinkAlcoholicSpirit)	; DwaSpWineAlto "Alto Wine (Strong)" [ALCH:0x001BC4F0]
	initialiseWaterBottles_Mod(0x001BC4F0, "Dwarfsphere.esp")
	ClearAndAddModFood(0x001BC4F6, "Dwarfsphere.esp", _Seed_DrinkAlcoholicSpirit)	; DwaSpWineSoul "Loci Whiskey" [ALCH:0x001BC4F6]
	initialiseWaterBottles_Mod(0x001BC4F6, "Dwarfsphere.esp")
	_Seed_ImportProjectAho_Done.Show()
endFunction

function addInterestingNPCs(bool checkRequired = true)
    if checkRequired && !SeedUtil.GetCompatibilitySystem().isInterestingNPCsLoaded
		return
    endif

	; Meat - Raw
	ClearAndAddModFood(0x00058EA6, "3DNPC.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor, _Seed_Preserved)	; CallenHorkerMeat "Special Cut Horker Meat" [ALCH:0x00058EA6]
	ClearAndAddModFood(0x0012E105, "3DNPC.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor, _Seed_Preserved)	; CallenHorkerMeat2 "Special Cut Horker Meat" [ALCH:0x0012E105]
	
	; Complex Stew
	ClearAndAddModFood(0x0012E113, "3DNPC.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive, _Seed_Preserved)	; ClarioStew "Clario's Alchemical Horker Stew" [ALCH:0x0012E113]
	ClearAndAddModFood(0x00163D45, "3DNPC.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive, _Seed_Preserved)	; GorrMarriageMeal "Gorr's Homecooked Horker Stew" [ALCH:0x00163D45]
	ClearAndAddModFood(0x001D19FF, "3DNPC.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive, _Seed_Preserved)	; BetteStew "Bette's Stew" [ALCH:0x001D19FF]
	
	; Weak Alcohol
	ClearAndAddModFood(0x0014F6E5, "3DNPC.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)					; MogosMead "Mogo's Mead" [ALCH:0x0014F6E5]
	ClearAndAddModFood(0x0033C95E, "3DNPC.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)					; MogosMeadBlackBriarVersion "Mogo's Mead" [ALCH:0x0033C95E]
	ClearAndAddModFood(0x002C4BEA, "3DNPC.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)					; MeresineMead3DNPC "Meresine's Dragon's Breath Mead" [ALCH:0x002C4BEA]
					
	initialiseWaterBottles_Mod(0x0014F6E5, "3DNPC.esp")													; MogosMead "Mogo's Mead" [ALCH:0x0014F6E5]
	initialiseWaterBottles_Mod(0x0033C95E, "3DNPC.esp")													; MogosMeadBlackBriarVersion "Mogo's Mead" [ALCH:0x0033C95E]
	initialiseWaterBottles_Mod(0x002C4BEA, "3DNPC.esp")													; MeresineMead3DNPC "Meresine's Dragon's Breath Mead" [ALCH:0x002C4BEA]
endfunction

function AddImmersiveEncounters(bool checkRequired = true)
    if checkRequired && !SeedUtil.GetCompatibilitySystem().isImmersiveEncountersLoaded
		return
    endif
	ClearAndAddModFood(0x006CE6DB, "Immersive Encounters.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)		; _SetteMotherStew "Homemade Stew" [ALCH:0x006CE6DB]
	ClearAndAddModFood(0x00AF0CE6, "Immersive Encounters.esp", _Seed_DrinkNonAlcoholic)	 							; _SetteBerryTea "Snowberry Tea" [ALCH:0x00AF0CE6]
	ClearAndAddModFood(0x00BA3B64, "Immersive Encounters.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicSpirit)	; _SetteNeddBrandy "High Rock Brandy" [ALCH:0x00BA3B64]
	
	initialiseWaterBottles_Mod(0x00BA3B64, "Immersive Encounters.esp")										; _SetteNeddBrandy "High Rock Brandy" [ALCH:0x00BA3B64]
endfunction

function AddWyrmstooth(bool checkRequired = true)
    if checkRequired && !SeedUtil.GetCompatibilitySystem().isWyrmstoothLoaded
		return
    endif
	
	ClearAndAddModFood(0x0040ADC8, "Wyrmstooth.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicWine)	; WTSoln "Soln" [ALCH:0x0040ADC8]
	ClearAndAddModFood(0x0040AE43, "Wyrmstooth.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicWine)	; WTIceholmIchor "Iceholm Ichor" [ALCH:0x0040AE43]
	ClearAndAddModFood(0x0040D1B3, "Wyrmstooth.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicWine)	; WTGreef "Greef" [ALCH:0x0040D1B3]
	
	initialiseWaterBottles_Mod(0x0040ADC8, "Wyrmstooth.esp")									; WTSoln "Soln" [ALCH:0x0040ADC8]
	initialiseWaterBottles_Mod(0x0040AE43, "Wyrmstooth.esp")									; WTIceholmIchor "Iceholm Ichor" [ALCH:0x0040AE43]
	initialiseWaterBottles_Mod(0x0040D1B3, "Wyrmstooth.esp")									; WTGreef "Greef" [ALCH:0x0040D1B3]
endfunction

function AddFalskaar(bool checkRequired = true)
    if checkRequired && !SeedUtil.GetCompatibilitySystem().isFalskaarLoaded
		return
    endif
	
	; Meat - Cooked
	ClearAndAddModFood(0x00123534, "Falskaar.esm", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; FSFoodAudmundBeef "Audmund's Seasoned Beef" [ALCH:0x00123534]
	ClearAndAddModFood(0x0015DB7E, "Falskaar.esm", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; FSFoodWineBastedVenison "Wine Basted Venison" [ALCH:0x0015DB7E]
	
	; Stew
	ClearAndAddModFood(0x0015DB76, "Falskaar.esm", _Seed_Stews, _Seed_Food_RestoreHungerMassive)	; FSFoodVarrinaBreadStew "Varrina's Special Stew" [ALCH:0x0015DB76]
	ClearAndAddModFood(0x0015DB78, "Falskaar.esm", _Seed_Stews, _Seed_Food_RestoreHungerMassive)	; FSFoodSpiritStew "Spirit Stew" [ALCH:0x0015DB78]
	ClearAndAddModFood(0x0015DB7C, "Falskaar.esm", _Seed_Stews, _Seed_Food_RestoreHungerMassive)	; FSFoodSeasonedBeefStew "Seasoned Beef Stew" [ALCH:0x0015DB7C]
	ClearAndAddModFood(0x0015DB7A, "Falskaar.esm", _Seed_Stews, _Seed_Food_RestoreHungerMassive)	; FSFoodVegetableMedley "Vegetable Medley" [ALCH:0x0015DB7A]
	
	; Weak Alcohol
	ClearAndAddModFood(0x000D69CE, "Falskaar.esm", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)	; FSFoodAmberMead "Amber Mead" [ALCH:0x000D69CE]
	initialiseWaterBottles_Mod(0x000D69CE, "Falskaar.esm")
endfunction

function AddSAFO(bool checkRequired = true)
    if checkRequired && !SeedUtil.GetCompatibilitySystem().isSAFOLoaded
		return
    endif
	
	_Seed_ImportSAFO.Show()
	
	; Raw Meat
	ClearAndAddModFood(0x00000806, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_Food_RawBearMeat "Raw Bear Meat" [ALCH:0x00000806]
	ClearAndAddModFood(0x00000807, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_Food_LionMeat "Raw Sabercat Meat" [ALCH:0x00000807]
	ClearAndAddModFood(0x0000080C, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_Food_RawMammoth "Raw Mammoth Meat" [ALCH:0x0000080C]
	ClearAndAddModFood(0x0069ECCF, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_FoodRawMeat "Raw Wolf Meat" [ALCH:0x0069ECCF]
	ClearAndAddModFood(0x0069ECD1, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_FoodSkeeverMeat "Raw Skeever Meat" [ALCH:0x0069ECD1]
	ClearAndAddModFood(0x00023FC6, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_MeatBall_Bear "Bear Meatball" [ALCH:0x00023FC6]
	ClearAndAddModFood(0x00023FCE, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_MeatBall_Cow "Beef Meatball" [ALCH:0x00023FCE]
	ClearAndAddModFood(0x00023FD0, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_MeatBall_Deer "Deer Meatball" [ALCH:0x00023FD0]
	ClearAndAddModFood(0x00023FD2, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_MeatBall_Dog "Dog Meatball" [ALCH:0x00023FD2]
	ClearAndAddModFood(0x00023FD6, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_MeatBall_Giant "Giant Meatball" [ALCH:0x00023FD6]
	ClearAndAddModFood(0x00023FD8, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_MeatBall_Goat "Goat Meatball" [ALCH:0x00023FD8]
	ClearAndAddModFood(0x00023FDC, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_MeatBall_Mammoth "Mammoth Meatball" [ALCH:0x00023FDC]
	ClearAndAddModFood(0x00023FDE, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_MeatBall_Sabrecat "Sabrecat Meatball" [ALCH:0x00023FDE]
	ClearAndAddModFood(0x00023FE0, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_MeatBall_Skeever "Skeever Meatball" [ALCH:0x00023FE0]
	ClearAndAddModFood(0x00023FE2, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_MeatBall_Wolf "Wolf Meatball" [ALCH:0x00023FE2]
	ClearAndAddModFood(0x00009A1E, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_Sausage_Bear "Bear Sausage" [ALCH:0x00009A1E]
	ClearAndAddModFood(0x00009A22, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_Sausage_Giant "Giant Sausage" [ALCH:0x00009A22]
	ClearAndAddModFood(0x00009A26, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_Sausage_Mammoth "Mammoth Sausage" [ALCH:0x00009A26]
	ClearAndAddModFood(0x00009A28, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_Sausage_Sabrecat "Sabrecat Sausage" [ALCH:0x00009A28]
	ClearAndAddModFood(0x00009A2A, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_Sausage_Skeever "Skeever Sausage" [ALCH:0x00009A2A]
	ClearAndAddModFood(0x00009A2E, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_Sausage_Cow "Beef Sausage" [ALCH:0x00009A2E]
	ClearAndAddModFood(0x00009A30, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_Sausage_Deer "Venison Sausage" [ALCH:0x00009A30]
	ClearAndAddModFood(0x00009A32, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_Sausage_Dog "Dog Sausage" [ALCH:0x00009A32]
	ClearAndAddModFood(0x00009A36, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_Sausage_Goat "Goat Sausage" [ALCH:0x00009A36]
	ClearAndAddModFood(0x00009A38, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_Sausage_Horse "Horse Sausage" [ALCH:0x00009A38]
	ClearAndAddModFood(0x00009A3A, "SAFO.esp", _Seed_MeatRaw, _Seed_Food_RestoreHungerMajor)	; v_Sausage_Wolf "Wolf Sausage" [ALCH:0x00009A3A]

	; Cooked Meat
	ClearAndAddModFood(0x00000808, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Food_CookedBearMeat "Roasted Bear Meat" [ALCH:0x00000808]
	ClearAndAddModFood(0x00000809, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Food_CookedLionMeat "Roasted Sabercat Meat" [ALCH:0x00000809]
	ClearAndAddModFood(0x0000080F, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Food_CookedMammoth "Roasted Mammoth Steak" [ALCH:0x0000080F]
	ClearAndAddModFood(0x00005B35, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Steak_Bear "Bear Steak" [ALCH:0x00005B35]
	ClearAndAddModFood(0x00005B37, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Steak_Chaurus "Chaurus Steak" [ALCH:0x00005B37]
	ClearAndAddModFood(0x00005B3C, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Steak_Giant "Giant Steak" [ALCH:0x00005B3C]
	ClearAndAddModFood(0x00005B3E, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Steak_Hagraven "Hagraven Steak" [ALCH:0x00005B3E]
	ClearAndAddModFood(0x00005B43, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Steak_Mammoth "Mammoth Steak" [ALCH:0x00005B43]
	ClearAndAddModFood(0x00005B45, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Steak_Sabrecat "Sabrecat Steak" [ALCH:0x00005B45]
	ClearAndAddModFood(0x00005B47, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Steak_Skeever "Skeever Steak" [ALCH:0x00005B47]
	ClearAndAddModFood(0x00005B49, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Steak_Spider "Spider Steak" [ALCH:0x00005B49]
	ClearAndAddModFood(0x0000EF1D, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Steak_Dog "Dog Steak" [ALCH:0x0000EF1D]
	ClearAndAddModFood(0x0000E998, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Steak_Wolf "Wolf Steak" [ALCH:0x0000E998]
	ClearAndAddModFood(0x00023FCA, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_MeatBall_Bear_Cooked "Bear Meatball Cooked" [ALCH:0x00023FCA]
	ClearAndAddModFood(0x00023FE6, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_MeatBall_Cow_Cooked "Beef Meatball Cooked" [ALCH:0x00023FE6]
	ClearAndAddModFood(0x00023FE8, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_MeatBall_Deer_Cooked "Deer Meatball Cooked" [ALCH:0x00023FE8]
	ClearAndAddModFood(0x00023FEA, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_MeatBall_Dog_Cooked "Dog Meatball Cooked" [ALCH:0x00023FEA]
	ClearAndAddModFood(0x00023FEE, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_MeatBall_Giant_Cooked "Giant Meatball Cooked" [ALCH:0x00023FEE]
	ClearAndAddModFood(0x00023FF0, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_MeatBall_Goat_Cooked "Goat Meatball Cooked" [ALCH:0x00023FF0]
	ClearAndAddModFood(0x00023FF4, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_MeatBall_Mammoth_Cooked "Mammoth Meatball Cooked" [ALCH:0x00023FF4]
	ClearAndAddModFood(0x00023FF6, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_MeatBall_Sabrecat_Cooked "Sabrecat Meatball Cooked" [ALCH:0x00023FF6]
	ClearAndAddModFood(0x00023FF8, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_MeatBall_Skeever_Cooked "Skeever Meatball Cooked" [ALCH:0x00023FF8]
	ClearAndAddModFood(0x00023FFA, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_MeatBall_Wolf_Cooked "Wolf Meatball Cooked" [ALCH:0x00023FFA]
	ClearAndAddModFood(0x0000E9AD, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Boiled_GiantToe "Giant's Toe Boiled" [ALCH:0x0000E9AD]
	ClearAndAddModFood(0x0000E9B5, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Boiled_SkeeverTail "Skeever Tail Boiled" [ALCH:0x0000E9B5]
	ClearAndAddModFood(0x0000EF1F, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Boiled_FalmerEar "Falmer Ear Boiled" [ALCH:0x0000EF1F]
	ClearAndAddModFood(0x00022B40, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_FoodSteamAshHopperLeg "Steamed Ash Hopper Leg" [ALCH:0x00022B40]
	ClearAndAddModFood(0x00022B41, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_FoodSteamAshHopperMeat "Steamed Ash Hopper Meat" [ALCH:0x00022B41]
	ClearAndAddModFood(0x0002E22C, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Pudding_Bear_Lungs "Bear Lungs Pudding" [ALCH:0x0002E22C]
	ClearAndAddModFood(0x00033333, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Pudding_Cow_Lungs "Cow Lungs Pudding" [ALCH:0x00033333]
	ClearAndAddModFood(0x00033335, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Pudding_Deer_Lungs "Deer Lungs Pudding" [ALCH:0x00033335]
	ClearAndAddModFood(0x00033337, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Pudding_Dog_Lungs "Dog Lungs Pudding" [ALCH:0x00033337]
	ClearAndAddModFood(0x00033339, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Pudding_Elk_Lungs "Elk Lungs Pudding" [ALCH:0x00033339]
	ClearAndAddModFood(0x0003333D, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Pudding_Giant_Lungs "Giant Lungs Pudding" [ALCH:0x0003333D]
	ClearAndAddModFood(0x0003333F, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Pudding_Goat_Lungs "Goat Lungs Pudding" [ALCH:0x0003333F]
	ClearAndAddModFood(0x00033341, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Pudding_Hagraven_Lungs "Hagraven Lungs Pudding" [ALCH:0x00033341]
	ClearAndAddModFood(0x00033345, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Pudding_Horker_Lungs "Horker Lungs Pudding" [ALCH:0x00033345]
	ClearAndAddModFood(0x00033347, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Pudding_Horse_Lungs "Horse Lungs Pudding" [ALCH:0x00033347]
	ClearAndAddModFood(0x00033349, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Pudding_Mammoth_Lungs "Mammoth Lungs Pudding" [ALCH:0x00033349]
	ClearAndAddModFood(0x0003334B, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Pudding_Pheasant_Lungs "Pheasant Lungs Pudding" [ALCH:0x0003334B]
	ClearAndAddModFood(0x0003334D, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Pudding_Skeever_Lungs "Skeever Lungs Pudding" [ALCH:0x0003334D]
	ClearAndAddModFood(0x0003334F, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Pudding_Sabrecat_Lungs "Sabrecat Lungs Pudding" [ALCH:0x0003334F]
	ClearAndAddModFood(0x00033351, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Pudding_Troll_Lungs "Troll Lung Pudding" [ALCH:0x00033351]
	ClearAndAddModFood(0x00033353, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Pudding_Wolf_Lungs "Wolf Lungs Pudding" [ALCH:0x00033353]
	ClearAndAddModFood(0x00033367, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Pudding_Rabbit_Lungs "Rabbit Lungs Pudding" [ALCH:0x00033367]
	ClearAndAddModFood(0x0069ECD0, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_FoodCookedMeat "Roasted Wolf Meat" [ALCH:0x0069ECD0]
	ClearAndAddModFood(0x00009A3C, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Sausage_Bear_Cooked "Bear Sausage Cooked" [ALCH:0x00009A3C]
	ClearAndAddModFood(0x00009A41, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Sausage_Cow_Cooked "Beef Sausage Cooked" [ALCH:0x00009A41]
	ClearAndAddModFood(0x00009A43, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Sausage_Deer_Cooked "Venison Sausage Cooked" [ALCH:0x00009A43]
	ClearAndAddModFood(0x00009A45, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Sausage_Dog_Cooked "Dog Sausage Cooked" [ALCH:0x00009A45]
	ClearAndAddModFood(0x00009A4B, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Sausage_Giant_Cooked "Giant Sausage Cooked" [ALCH:0x00009A4B]
	ClearAndAddModFood(0x00009A4D, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Sausage_Goat_Cooked "Goat Sausage Cooked" [ALCH:0x00009A4D]
	ClearAndAddModFood(0x00009A51, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Sausage_Horse_Cooked "Horse Sausage Cooked" [ALCH:0x00009A51]
	ClearAndAddModFood(0x00009A53, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Sausage_Mammoth_Cooked "Mammoth Sausage Cooked" [ALCH:0x00009A53]
	ClearAndAddModFood(0x00009A55, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Sausage_Sabrecat_Cooked "Sabrecat Sausage Cooked" [ALCH:0x00009A55]
	ClearAndAddModFood(0x00009A57, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Sausage_Skeever_Cooked "Skeever Sausage Cooked" [ALCH:0x00009A57]
	ClearAndAddModFood(0x00009A59, "SAFO.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)	; v_Sausage_Wolf_Cooked "Wolf Sausage Cooked" [ALCH:0x00009A59]
	
	; Raw Small Game
	ClearAndAddModFood(0x0000080D, "SAFO.esp", _Seed_SmallGameRaw, _Seed_Food_RestoreHungerMinor)	; v_Food_RawFoxMeat "Raw Fox Meat" [ALCH:0x0000080D]
	ClearAndAddModFood(0x00023FCC, "SAFO.esp", _Seed_SmallGameRaw, _Seed_Food_RestoreHungerMinor)	; v_MeatBall_Chicken "Chicken Meatball" [ALCH:0x00023FCC]
	ClearAndAddModFood(0x00023FD4, "SAFO.esp", _Seed_SmallGameRaw, _Seed_Food_RestoreHungerMinor)	; v_MeatBall_Fox "Fox Meatball" [ALCH:0x00023FD4]
	ClearAndAddModFood(0x00023FDA, "SAFO.esp", _Seed_SmallGameRaw, _Seed_Food_RestoreHungerMinor)	; v_MeatBall_Hawk "Hawk Meatball" [ALCH:0x00023FDA]
	ClearAndAddModFood(0x00009A20, "SAFO.esp", _Seed_SmallGameRaw, _Seed_Food_RestoreHungerMinor)	; v_Sausage_Fox "Fox Sausage" [ALCH:0x00009A20]
	ClearAndAddModFood(0x00009A2C, "SAFO.esp", _Seed_SmallGameRaw, _Seed_Food_RestoreHungerMinor)	; v_Sausage_Chicken "Chicken Sausage" [ALCH:0x00009A2C]
	ClearAndAddModFood(0x00009A24, "SAFO.esp", _Seed_SmallGameRaw, _Seed_Food_RestoreHungerMinor)	; v_Sausage_Hawk "Hawk Sausage" [ALCH:0x00009A24]

	; Cooked Small Game
	ClearAndAddModFood(0x0000080E, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Food_CookedFoxMeat "Roasted Fox Meat" [ALCH:0x0000080E]
	ClearAndAddModFood(0x00005B3A, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Steak_Fox "Fox Steak" [ALCH:0x00005B3A]
	ClearAndAddModFood(0x00005B41, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Steak_Hawk "Hawk Steak" [ALCH:0x00005B41]
	ClearAndAddModFood(0x0000D26E, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Egg_HardBoiled "Hardboiled Chicken Egg" [ALCH:0x0000D26E]
	ClearAndAddModFood(0x0000D270, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Egg_Fried "Fried Chicken Egg" [ALCH:0x0000D270]
	ClearAndAddModFood(0x0000D272, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Egg_Coque "Softboiled Chicken Egg" [ALCH:0x0000D272]
	ClearAndAddModFood(0x0000D279, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Egg_Coque2 "Softboiled Warbler Egg" [ALCH:0x0000D279]
	ClearAndAddModFood(0x0000D27B, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Egg_HardBoiled2 "Hardboiled Warbler Egg" [ALCH:0x0000D27B]
	ClearAndAddModFood(0x0000D27D, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Egg_Fried2 "Fried Thrush Egg" [ALCH:0x0000D27D]
	ClearAndAddModFood(0x0000D27F, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Egg_Coque3 "Softboiled Thrush Egg" [ALCH:0x0000D27F]
	ClearAndAddModFood(0x0000D281, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Egg_Fried3 "Fried Warbler Egg" [ALCH:0x0000D281]
	ClearAndAddModFood(0x0000D283, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Egg_HardBoiled3 "Hardboiled Thrush Egg" [ALCH:0x0000D283]
	ClearAndAddModFood(0x0000D80A, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Egg_Coque4 "Softboiled Hawk Egg" [ALCH:0x0000D80A]
	ClearAndAddModFood(0x0000D80C, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Egg_Fried4 "Fried Hawk Egg" [ALCH:0x0000D80C]
	ClearAndAddModFood(0x0000D80E, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Egg_HardBoiled4 "Hardboiled Hawk Egg" [ALCH:0x0000D80E]
	ClearAndAddModFood(0x0000E9B9, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Boiled_SpiderEggs "Spider Egg Boiled" [ALCH:0x0000E9B9]
	ClearAndAddModFood(0x00023FE4, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_MeatBall_Chicken_Cooked "Chicken Meatball Cooked" [ALCH:0x00023FE4]
	ClearAndAddModFood(0x00023FEC, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_MeatBall_Fox_Cooked "Fox Meatball Cooked" [ALCH:0x00023FEC]
	ClearAndAddModFood(0x00023FF2, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_MeatBall_Hawk_Cooked "Hawk Meatball Cooked" [ALCH:0x00023FF2]
	ClearAndAddModFood(0x00009A3F, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Sausage_Chicken_Cooked "Chicken Sausage Cooked" [ALCH:0x00009A3F]
	ClearAndAddModFood(0x00009A49, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Sausage_Fox_Cooked "Fox Sausage Cooked" [ALCH:0x00009A49]
	ClearAndAddModFood(0x00009A4F, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Sausage_Hawk_Cooked "Hawk Sausage Cooked" [ALCH:0x00009A4F]
	ClearAndAddModFood(0x00022B44, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_FoodBoiledEgg "Boiled Egg" [ALCH:0x00022B44]
	ClearAndAddModFood(0x00033331, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Pudding_Chicken_Lungs "Chicken Lungs Pudding" [ALCH:0x00033331]
	ClearAndAddModFood(0x0003333B, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_pudding_Fox_Lungs "Fox Lungs Pudding" [ALCH:0x0003333B]
	ClearAndAddModFood(0x00033343, "SAFO.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor)	; v_Pudding_Hawk_Lungs "Hawk Lungs Pudding" [ALCH:0x00033343]

	; Fish Cooked
	ClearAndAddModFood(0x0000E9B7, "SAFO.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; v_Boiled_SlaughterfishEggs "Slaughterfish Egg Boiled" [ALCH:0x0000E9B7]
	ClearAndAddModFood(0x0000EF2E, "SAFO.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; v_Egg_Caviar "Caviar" [ALCH:0x0000EF2E]
	ClearAndAddModFood(0x0000D852, "SAFO.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; v_Steak_Slaughterfish "Slaughterfish Steak" [ALCH:0x0000D852]
	ClearAndAddModFood(0x0000DDC1, "SAFO.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; v_Steak_SilversidePerch "Silverside Perch Cooked" [ALCH:0x0000DDC1]
	ClearAndAddModFood(0x0000DDC3, "SAFO.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; v_Steak_AbaceanLongfin "Abacean Longfin Cooked" [ALCH:0x0000DDC3]
	ClearAndAddModFood(0x0000DDC6, "SAFO.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; v_Steak_RiverBetty "River Betty Cooked" [ALCH:0x0000DDC6]
	ClearAndAddModFood(0x0000DDC8, "SAFO.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; v_Steak_CyrodilicSpadetail "Cyrodilic Spadetail Cooked" [ALCH:0x0000DDC8]
	ClearAndAddModFood(0x0000DDCA, "SAFO.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)	; v_Steak_Histcarp "Histcarp Cooked" [ALCH:0x0000DDCA]

	; Raw Seafood
	ClearAndAddModFood(0x0069ECD2, "SAFO.esp", _Seed_SeafoodRaw, _Seed_Food_RestoreHungerMinor)	; v_MudCrabMeat "Raw Mudcrab Meat" [ALCH:0x0069ECD2]

	; Cooked Seafood
	ClearAndAddModFood(0x00000803, "SAFO.esp", _Seed_SeafoodCooked, _Seed_Food_RestoreHungerMajor)	; v_SteamMudCrabMeat "Steamed Mudcrab" [ALCH:0x00000803]
	ClearAndAddModFood(0x00022B46, "SAFO.esp", _Seed_SeafoodCooked, _Seed_Food_RestoreHungerMajor)	; v_FoodSteamClamMeat "Steamed Clams" [ALCH:0x00022B46]

	; Fruit
	ClearAndAddModFood(0x00009443, "SAFO.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)	; v_Fruit_Cucumber "Cucumber" [ALCH:0x00009443]
	ClearAndAddModFood(0x00009487, "SAFO.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)	; v_Fruit_Plum "Plum" [ALCH:0x00009487]
	ClearAndAddModFood(0x00009494, "SAFO.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)	; v_Fruit_Strawberry "Strawberry" [ALCH:0x00009494]
	ClearAndAddModFood(0x00009497, "SAFO.esp", _Seed_Fruit, _Seed_Food_RestoreHungerSuperior)	; v_Fruit_Watermelon "Watermelon" [ALCH:0x00009497]
	ClearAndAddModFood(0x0000949D, "SAFO.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)	; v_Fruit_Grape "Grape" [ALCH:0x0000949D]
	ClearAndAddModFood(0x0000F4A6, "SAFO.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)	; v_Fruit_AppleYEL "Yellow Apple" [ALCH:0x0000F4A6]
	ClearAndAddModFood(0x0000FFEB, "SAFO.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)	; v_Fruit_Peach "Peach" [ALCH:0x0000FFEB]
	ClearAndAddModFood(0x00047774, "SAFO.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)	; v_Fruit_Pear "Pear" [ALCH:0x00047774]
	ClearAndAddModFood(0x00009481, "SAFO.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMinor)	; v_Fruit_Peach_Half "Peach Half" [ALCH:0x00009481]
	ClearAndAddModFood(0x00009485, "SAFO.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMinor)	; v_Fruit_Pear_Half "Pear Half" [ALCH:0x00009485]
	ClearAndAddModFood(0x00009489, "SAFO.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMinor)	; v_Fruit_Plum_Half "Plum Half" [ALCH:0x00009489]
	ClearAndAddModFood(0x00009499, "SAFO.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMajor)	; v_Fruit_Watermelon_Half "Watermelon Half" [ALCH:0x00009499]
	ClearAndAddModFood(0x0000F4A0, "SAFO.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMinor)	; v_Fruit_AppleRED_Half "Red Apple Half" [ALCH:0x0000F4A0]
	ClearAndAddModFood(0x0000F4A2, "SAFO.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMinor)	; v_Fruit_AppleGRE_Half "Green Apple Half" [ALCH:0x0000F4A2]
	ClearAndAddModFood(0x0000F4A4, "SAFO.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMinor)	; v_Fruit_AppleYEL_Half "Yellow Apple Half" [ALCH:0x0000F4A4]
	ClearAndAddModFood(0x0000949B, "SAFO.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMinor)	; v_Fruit_Watermelon_Slice "Watermelon Slice" [ALCH:0x0000949B]

	; Vegetable
	ClearAndAddModFood(0x0000943D, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; v_Vegetable_Cabbage_Half "Cabbage Half" [ALCH:0x0000943D]
	ClearAndAddModFood(0x00009445, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; v_Vegetable_Cucumber "Cucumber" [ALCH:0x00009445]
	ClearAndAddModFood(0x00009447, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; v_Vegetable_Eggplant "Eggplant" [ALCH:0x00009447]
	ClearAndAddModFood(0x00009467, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; v_Vegetable_Onion "Onion" [ALCH:0x00009467]
	ClearAndAddModFood(0x00009469, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; v_Vegetable_Onion_Half "Onion Half" [ALCH:0x00009469]
	ClearAndAddModFood(0x0000946B, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; v_Vegetable_OnionRed "Red Onion" [ALCH:0x0000946B]
	ClearAndAddModFood(0x00009479, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; v_Vegetable_PaprikaRed "Red Pepper" [ALCH:0x00009479]
	ClearAndAddModFood(0x0000947B, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; v_Vegetable_PaprikaGreen "Green Pepper" [ALCH:0x0000947B]
	ClearAndAddModFood(0x0000947D, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; v_Vegetable_PaprikaYellow "Yellow Pepper" [ALCH:0x0000947D]
	ClearAndAddModFood(0x0000948B, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; v_Vegetable_Pumpkin "Pumpkin" [ALCH:0x0000948B]
	ClearAndAddModFood(0x0000948D, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; v_Vegetable_Pumpkin2 "Pumpkin" [ALCH:0x0000948D]
	ClearAndAddModFood(0x0000948F, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; v_Vegetable_Radish "Radish" [ALCH:0x0000948F]
	ClearAndAddModFood(0x0000949F, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; v_Vegetable_Zucchini "Zucchini" [ALCH:0x0000949F]
	ClearAndAddModFood(0x0000E99D, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor)	; v_Vegetable_Potato_Half "Potato Half" [ALCH:0x0000E99D]


	; Vegetables Cooked
	ClearAndAddModFood(0x0000E9AB, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	; v_Boiled_Carrot "Boiled Carrot" [ALCH:0x0000E9AB]
	ClearAndAddModFood(0x0000E9AF, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	; v_Boiled_Gourd "Gourd Boiled" [ALCH:0x0000E9AF]
	ClearAndAddModFood(0x0000E9B1, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	; v_Boiled_Potato "Potato Boiled" [ALCH:0x0000E9B1]
	ClearAndAddModFood(0x0000E9B3, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	; v_Boiled_ScalyPholiota "Scaly Pholiota Boiled" [ALCH:0x0000E9B3]
	ClearAndAddModFood(0x00022B3F, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	; v_FoodBakedAshYam "Baked Ash Yam" [ALCH:0x00022B3F]
	ClearAndAddModFood(0x00022B4A, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	; v_FoodStewedSquash "Stewed Squash" [ALCH:0x00022B4A]
	ClearAndAddModFood(0x0000EF34, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	; v_Mushroom_MoraTapinella_Cook "Mora Tapinella Grilled" [ALCH:0x0000EF34]
	ClearAndAddModFood(0x0000EF36, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	; v_Mushroom_GlowingMushrooms_Cook "Glowing Mushroom Grilled" [ALCH:0x0000EF36]
	ClearAndAddModFood(0x0000EF38, "SAFO.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)	; v_Mushroom_SwampFungalPod_Cook "Swamp Fungal Pod Grilled" [ALCH:0x0000EF38]
	
	; Pastry
	ClearAndAddModFood(0x0000B0B7, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Bear_Liver "Bear Liver Pie" [ALCH:0x0000B0B7]
	ClearAndAddModFood(0x0000B0BE, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Chicken_Liver "Chicken Liver Pie" [ALCH:0x0000B0BE]
	ClearAndAddModFood(0x0000B0C0, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Cow_Liver "Beef Liver Pie" [ALCH:0x0000B0C0]
	ClearAndAddModFood(0x0000B0C2, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Deer_Liver "Venison Liver Pie" [ALCH:0x0000B0C2]
	ClearAndAddModFood(0x0000B0C4, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Dog_Liver "Dog Liver Pie" [ALCH:0x0000B0C4]
	ClearAndAddModFood(0x0000B0C6, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Elk_Liver "Elk Liver Pie" [ALCH:0x0000B0C6]
	ClearAndAddModFood(0x0000B0C8, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Fox_Liver "Fox Liver Pie" [ALCH:0x0000B0C8]
	ClearAndAddModFood(0x0000B0CA, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Giant_Liver "Giant Liver Pie" [ALCH:0x0000B0CA]
	ClearAndAddModFood(0x0000B0CC, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Goat_Liver "Goat Liver Pie" [ALCH:0x0000B0CC]
	ClearAndAddModFood(0x0000B0CE, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Hagraven_Liver "Hagraven Liver Pie" [ALCH:0x0000B0CE]
	ClearAndAddModFood(0x0000B0D0, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Hawk_Liver "Hawk Liver Pie" [ALCH:0x0000B0D0]
	ClearAndAddModFood(0x0000B0D2, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Horker_Liver "Horker Liver Pie" [ALCH:0x0000B0D2]
	ClearAndAddModFood(0x0000B0D4, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Horse_Liver "Horse Liver Pie" [ALCH:0x0000B0D4]
	ClearAndAddModFood(0x0000B0D6, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Mammoth_Liver "Mammoth Liver Pie" [ALCH:0x0000B0D6]
	ClearAndAddModFood(0x0000B0D8, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Phaesant_Liver "Pheasant Liver Pie" [ALCH:0x0000B0D8]
	ClearAndAddModFood(0x0000B0DA, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Rabbit_Liver "Rabbit Liver Pie" [ALCH:0x0000B0DA]
	ClearAndAddModFood(0x0000B0DC, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Sabrecat_Liver "Sabrecat Liver Pie" [ALCH:0x0000B0DC]
	ClearAndAddModFood(0x0000B0DE, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Skeever_Liver "Skeever Liver Pie" [ALCH:0x0000B0DE]
	ClearAndAddModFood(0x0000B0E0, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Troll_Liver "Troll Liver Pie" [ALCH:0x0000B0E0]
	ClearAndAddModFood(0x0000B0E2, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Wolf_Liver "Wolf Liver Pie" [ALCH:0x0000B0E2]
	ClearAndAddModFood(0x0000D28B, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)	; v_Pie_Strawberry "Strawberry Pie" [ALCH:0x0000D28B]
	ClearAndAddModFood(0x0000D294, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)	; v_Pie_Pear "Pear Pie" [ALCH:0x0000D294]
	ClearAndAddModFood(0x0000D298, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)	; v_Pie_Snowberry "Snowberry Pie" [ALCH:0x0000D298]
	ClearAndAddModFood(0x0000E375, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)	; v_Tart_Cherry "Cherry Tart" [ALCH:0x0000E375]
	ClearAndAddModFood(0x0000E382, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)	; v_Tart_Peach "Peach Tart" [ALCH:0x0000E382]
	ClearAndAddModFood(0x0000E384, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)	; v_Tart_Pear "Pear Tart" [ALCH:0x0000E384]
	ClearAndAddModFood(0x0000E386, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)	; v_Tart_Apple "Apple Tart" [ALCH:0x0000E386]
	ClearAndAddModFood(0x0000E388, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)	; v_Tart_Plum "Plum Tart" [ALCH:0x0000E388]
	ClearAndAddModFood(0x0000E38A, "SAFO.esp", _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)	; v_Tart_Strawberry "Strawberry Tart" [ALCH:0x0000E38A]
	
	; Treats	
	ClearAndAddModFood(0x0000E390, "SAFO.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	; v_Marmalade_Apple "Apple Marmalade" [ALCH:0x0000E390]
	ClearAndAddModFood(0x0000E392, "SAFO.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	; v_Marmalade_Cherry "Cherry Marmalade" [ALCH:0x0000E392]
	ClearAndAddModFood(0x0000E398, "SAFO.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	; v_Marmalade_Peach "Peach Marmalade" [ALCH:0x0000E398]
	ClearAndAddModFood(0x0000E39A, "SAFO.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	; v_Marmalade_Pear "Pear Marmalade" [ALCH:0x0000E39A]
	ClearAndAddModFood(0x0000E39C, "SAFO.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	; v_Marmalade_Plum "Plum Marmalade" [ALCH:0x0000E39C]
	ClearAndAddModFood(0x0000E39E, "SAFO.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor, _Seed_Preserved)	; v_Marmalade_Strawberry "Strawberry Marmalade" [ALCH:0x0000E39E]

	; Stew
	ClearAndAddModFood(0x0000F4C0, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Soup_Carrot "Carrot Soup" [ALCH:0x0000F4C0]
	ClearAndAddModFood(0x0000F4C2, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Soup_Onion "Onion Soup" [ALCH:0x0000F4C2]
	ClearAndAddModFood(0x0000F4C4, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Soup_Peppers "Peppers Soup" [ALCH:0x0000F4C4]
	ClearAndAddModFood(0x0000F4C6, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Soup_Pumpkin "Pumpkin Soup" [ALCH:0x0000F4C6]
	ClearAndAddModFood(0x0000F4C8, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Soup_Leek "Leek Soup" [ALCH:0x0000F4C8]
	ClearAndAddModFood(0x0000F4E5, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_AbaceanLongfin "Abacean Longfin Stew" [ALCH:0x0000F4E5]
	ClearAndAddModFood(0x0000F4E7, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_Histcarp "Histcarp Stew" [ALCH:0x0000F4E7]
	ClearAndAddModFood(0x0000F4E9, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_RiverBetty "River Betty Stew" [ALCH:0x0000F4E9]
	ClearAndAddModFood(0x0000F4EB, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_CyrodilicSpadetail "Cyrodilic Spadetail Stew" [ALCH:0x0000F4EB]
	ClearAndAddModFood(0x0000F4F3, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_Bear "Bear Stew" [ALCH:0x0000F4F3]
	ClearAndAddModFood(0x0000F4F5, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_Chicken "Chicken Stew" [ALCH:0x0000F4F5]
	ClearAndAddModFood(0x0000F4F8, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_Pheasant "Pheasant Stew" [ALCH:0x0000F4F8]
	ClearAndAddModFood(0x0000F4FA, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_Giant "Giant Stew" [ALCH:0x0000F4FA]
	ClearAndAddModFood(0x0000F4FC, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_Hawk "Hawk Stew" [ALCH:0x0000F4FC]
	ClearAndAddModFood(0x0000F4FE, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_Sabrecat "Sabrecat Stew" [ALCH:0x0000F4FE]
	ClearAndAddModFood(0x0000F500, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_Skeever "Skeever Stew" [ALCH:0x0000F500]
	ClearAndAddModFood(0x0000F502, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_Wolf "Wolf Stew" [ALCH:0x0000F502]
	ClearAndAddModFood(0x0000F504, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_Dog "Dog Stew" [ALCH:0x0000F504]
	ClearAndAddModFood(0x0000F506, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_Mammoth "Mammoth Stew" [ALCH:0x0000F506]
	ClearAndAddModFood(0x0000F508, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_Fox "Fox Stew" [ALCH:0x0000F508]
	ClearAndAddModFood(0x0000F50A, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_Goat "Goat Stew" [ALCH:0x0000F50A]
	ClearAndAddModFood(0x0000F50C, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_Rabbit "Rabbit Stew" [ALCH:0x0000F50C]
	ClearAndAddModFood(0x0000F50E, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_Horse "Horse Stew" [ALCH:0x0000F50E]
	ClearAndAddModFood(0x0000FA80, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_Stew_Slaughterfish "Slaughterfish Stew" [ALCH:0x0000FA80]
	ClearAndAddModFood(0x0069ECD6, "SAFO.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)	; v_WolfStew "Wolf Stew" [ALCH:0x0069ECD6]

	; Cheesebowls
	ClearAndAddModFood(0x0000F4CF, "SAFO.esp", _Seed_CheeseBowls, _Seed_Food_RestoreHungerSuperior)	; v_Soup_CheeseEidar "Eidar Cheese Fondue" [ALCH:0x0000F4CF]
	ClearAndAddModFood(0x0000F4D1, "SAFO.esp", _Seed_CheeseBowls, _Seed_Food_RestoreHungerSuperior)	; v_Soup_CheeseGoat "Goat Cheese Fondue" [ALCH:0x0000F4D1]
	ClearAndAddModFood(0x0000F4D3, "SAFO.esp", _Seed_CheeseBowls, _Seed_Food_RestoreHungerSuperior)	; v_Soup_CheeseMammoth "Mammoth Cheese Fondue" [ALCH:0x0000F4D3]

	; Non-Alcoholic Drink
	ClearAndAddModFood(0x0000947F, "SAFO.esp", _Seed_DrinkNonAlcoholic)	; v_Drink_Peach_Juice "Peach Juice" [ALCH:0x0000947F]
	ClearAndAddModFood(0x00009483, "SAFO.esp", _Seed_DrinkNonAlcoholic)	; v_Drink_Apple_Juice "Apple Juice" [ALCH:0x00009483]
	ClearAndAddModFood(0x0000B034, "SAFO.esp", _Seed_DrinkNonAlcoholic)	; v_Drink_Tomato_Juice "Tomato Juice" [ALCH:0x0000B034]
	ClearAndAddModFood(0x0000B036, "SAFO.esp", _Seed_DrinkNonAlcoholic)	; v_Drink_Strawberry_Juice "Strawberry Juice" [ALCH:0x0000B036]
	ClearAndAddModFood(0x0000B038, "SAFO.esp", _Seed_DrinkNonAlcoholic)	; v_Drink_Grape_Juice "Grape Juice" [ALCH:0x0000B038]
	ClearAndAddModFood(0x0000B041, "SAFO.esp", _Seed_DrinkNonAlcoholic)	; v_Drink_Watermelon_Juice "Watermelon Juice" [ALCH:0x0000B041]
	ClearAndAddModFood(0x0069ECD4, "SAFO.esp", _Seed_DrinkNonAlcoholic)	; v_Food_Water "Bottled Water" [ALCH:0x0069ECD4]

	;Stock
	ClearAndAddModFood(0x0001EEA1, "SAFO.esp", _Seed_DrinkNonAlcoholic)	; v_Stock_Fish "Fish Stock" [ALCH:0x0001EEA1]
	ClearAndAddModFood(0x0001EEA6, "SAFO.esp", _Seed_DrinkNonAlcoholic)	; v_Stock_Chicken "Chicken Stock" [ALCH:0x0001EEA6]
	ClearAndAddModFood(0x0001EEA8, "SAFO.esp", _Seed_DrinkNonAlcoholic)	; v_Stock_Chillbone "Chillbone Stock" [ALCH:0x0001EEA8]
	ClearAndAddModFood(0x0001EEAA, "SAFO.esp", _Seed_DrinkNonAlcoholic)	; v_Stock_Hawk "Hawk Stock" [ALCH:0x0001EEAA]
	ClearAndAddModFood(0x0001EEAE, "SAFO.esp", _Seed_DrinkNonAlcoholic)	; v_Stock_Markarth "Markarth's Stock" [ALCH:0x0001EEAE]
	ClearAndAddModFood(0x0001EEB0, "SAFO.esp", _Seed_DrinkNonAlcoholic)	; v_Stock_Cow "Beef Stock" [ALCH:0x0001EEB0]
	ClearAndAddModFood(0x0001EEB2, "SAFO.esp", _Seed_DrinkNonAlcoholic)	; v_Stock_Hunter "Hunter's Stock" [ALCH:0x0001EEB2]
	ClearAndAddModFood(0x0001EEBA, "SAFO.esp", _Seed_DrinkNonAlcoholic)	; v_Stock_Ivarstead "Ivarstead's Stock" [ALCH:0x0001EEBA]

	; Milk
	ClearAndAddModFood(0x0069ECD3, "SAFO.esp", _Seed_DrinkMilk, _Seed_Food_RestoreHungerMinor)	; v_Milk "Bottled Milk" [ALCH:0x0069ECD3]
	initialiseWaterBottles_Mod(0x0069ECD3, "SAFO.esp")
	ClearAndAddModFood(0x0000B03A, "SAFO.esp", _Seed_DrinkMilk, _Seed_Food_RestoreHungerMinor)	; v_Drink_Milk_Cow "Cow Milk" [ALCH:0x0000B03A]
	ClearAndAddModFood(0x0000B03C, "SAFO.esp", _Seed_DrinkMilk, _Seed_Food_RestoreHungerMinor)	; v_Drink_Milk_Goat "Goat Milk" [ALCH:0x0000B03C]
	ClearAndAddModFood(0x0000B03E, "SAFO.esp", _Seed_DrinkMilk, _Seed_Food_RestoreHungerMinor)	; v_Drink_Milk_Mammoth "Mammoth Milk" [ALCH:0x0000B03E]
	
	_Seed_ImportSAFO_Done.Show()
endfunction


function AddNordicCooking(bool checkRequired = true)
    if checkRequired && !SeedUtil.GetCompatibilitySystem().isNordicCookingLoaded
		return
    endif
	_Seed_ImportNordicCooking.Show()
	
	; Cooked Meat
	ClearAndAddModFood(0x00000D62, "NordicCooking.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMajor, _Seed_SaltedFood)	; simpleModsJerky01 "Nordic Jerky" [ALCH:0x00000D62]
	ClearAndAddModFood(0x000038B3, "NordicCooking.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior)					; simpleModsRoast01 "Nordic Roasted Goat" [ALCH:0x000038B3]
	
	;Cooked Small Game
	ClearAndAddModFood(0x000038BC, "NordicCooking.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMajor)				; simpleModsRoast03 "Nordic Roasted Chicken" [ALCH:0x000038BC]
	
	; Cooked Vegetables
	ClearAndAddModFood(0x00001856, "NordicCooking.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)					; simpleModsHash01 "Nordic Hash" [ALCH:0x00001856]
	ClearAndAddModFood(0x000038B9, "NordicCooking.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)					; simpleModsRoast02 "Nordic Roasted Gourd" [ALCH:0x000038B9]
	ClearAndAddModFood(0x00005E91, "NordicCooking.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor)					; simpleModsSalad02 "Nordic Salad" [ALCH:0x00005E91]
	
	; Cooked Fish					
	ClearAndAddModFood(0x00003E24, "NordicCooking.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor)					; simpleModsSmoked01 "Nordic Smoked Salmon" [ALCH:0x00003E24]
	ClearAndAddModFood(0x000038B0, "NordicCooking.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerSuperior)					; simpleModsSalad01 "Nordic Salmon Salad" [ALCH:0x000038B0]

	; Stew					
	ClearAndAddModFood(0x00000D63, "NordicCooking.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)						; simpleModsStew01 "Nordic Beef Stew" [ALCH:0x00000D63]
	ClearAndAddModFood(0x000012EF, "NordicCooking.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)						; simpleModsStew02 "Nordic Horker Stew" [ALCH:0x000012EF]
	ClearAndAddModFood(0x00004E51, "NordicCooking.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)						; simpleModsStew05 "Nordic Venison Stew" [ALCH:0x00004E51]
	ClearAndAddModFood(0x000038B6, "NordicCooking.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)						; simpleModsStew04 "Nordic Clam Chowder" [ALCH:0x000038B6]
	ClearAndAddModFood(0x00005924, "NordicCooking.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)						; simpleModsStew06 "Nordic Chicken Soup" [ALCH:0x00005924]
	ClearAndAddModFood(0x00005E8D, "NordicCooking.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive)						; simpleModsStew07 "Nordic Veggie Stew" [ALCH:0x00005E8D]
	ClearAndAddModFood(0x00002322, "NordicCooking.esp", _Seed_Stews, _Seed_Food_RestoreHungerSuperior)						; simpleModsStew03 "Nordic Cheese Soup" [ALCH:0x00002322]

	; Pastry					
	ClearAndAddModFood(0x00000D65, "NordicCooking.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)					; simpleModsSandwich01 "Nordic Mammouth Cheese Steak" [ALCH:0x00000D65]
	ClearAndAddModFood(0x000048EB, "NordicCooking.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive)					; simpleModsSandwich02 "Nordic Cheese Hero" [ALCH:0x000048EB]
	ClearAndAddModFood(0x00005E8A, "NordicCooking.esp", _Seed_Pastries, _Seed_Food_RestoreHungerSuperior)					; simpleModsSandwich03 "Nordic Veggie Hero" [ALCH:0x00005E8A]

	; Non-Alcoholic Drinks					
	ClearAndAddModFood(0x00000D69, "NordicCooking.esp", _Seed_DrinkNonAlcoholic)											; simpleModsCarrotJuice01 "Nordic Carrot Juice" [ALCH:0x00000D69]
	ClearAndAddModFood(0x00003349, "NordicCooking.esp", _Seed_DrinkNonAlcoholic)											; simpleModsAppleAle01 "Nordic Green Apple Ale" [ALCH:0x00003349]
	ClearAndAddModFood(0x000053B9, "NordicCooking.esp", _Seed_DrinkNonAlcoholic)											; simpleModsCoffee "Nordic Coffee" [ALCH:0x000053B9]
	ClearAndAddModFood(0x000053BF, "NordicCooking.esp", _Seed_DrinkNonAlcoholic)											; simpleModsTea "Nordic Tea" [ALCH:0x000053BF]

	; Weak Alcohol					
	ClearAndAddModFood(0x00000D67, "NordicCooking.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle)						; simpleModsAppleCider01 "Nordic Red Apple Cider" [ALCH:0x00000D67]
	initialiseWaterBottles_Mod(0x00000D67, "NordicCooking.esm")

	; Alcohol - Wine					
	ClearAndAddModFood(0x00009478, "NordicCooking.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicWine)						; simpleModsAppleWine01 "Nordic Red Apple Wine" [ALCH:0x00009478]
	initialiseWaterBottles_Mod(0x00009478, "NordicCooking.esm")

	ClearAndAddModFood(0x00009479, "NordicCooking.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicWine)						; simpleModsAppleWine02 "Nordic Green Apple Wine" [ALCH:0x00009479]
	initialiseWaterBottles_Mod(0x00009479, "NordicCooking.esm")
	
	_Seed_ImportNordicCooking_Done.Show()
endfunction

function AddMealtime(bool checkRequired = true)
    if checkRequired && !SeedUtil.GetCompatibilitySystem().isMealtimeLoaded
		return
    endif
	_Seed_ImportMealtime.Show()
	; Cooked Meat
	ClearAndAddModFood(0x0006FEB3, "mealtimeyum.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerSuperior) 	; meatballyum "Breton Meatballs" ALCH:0x0006FEB3]
	ClearAndAddModFood(0x000324FF, "mealtimeyum.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMassive) 	; butterdragonyum "Butter Dragon" ALCH:0x000324FF]

	; Cooked Meat - Portioned
	ClearAndAddModFood(0x0001DCC8, "mealtimeyum.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMinor) 		; cornyyum "Corned Beef Plate" ALCH:0x0001DCC8]
	ClearAndAddModFood(0x0001DCCB, "mealtimeyum.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMinor) 		; cornysliceyum "Corned Beef Slice" ALCH:0x0001DCCB]
	AddModMultiPartFood_Array(0x0001DCC8, "mealtimeyum.esp",	0x0001DCCB, "mealtimeyum.esp", 4)	
	ClearAndAddModFood(0x000382EC, "mealtimeyum.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMinor) 		; baconyum "Horker Bacon" ALCH:0x000382EC]
	ClearAndAddModFood(0x000382F2, "mealtimeyum.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMinor) 		; baconsyum "Horker Bacon Slices" ALCH:0x000382F2]
	AddModMultiPartFood_Array(0x000382EC, "mealtimeyum.esp",	0x000382F2, "mealtimeyum.esp", 2)	
	ClearAndAddModFood(0x000065AA, "mealtimeyum.esp", _Seed_DrinkNonAlcoholic) 	; chilipotyum "Chili Con Carne Pot" ALCH:0x000065AA]
	ClearAndAddModFood(0x000065AC, "mealtimeyum.esp", _Seed_DrinkNonAlcoholic) 	; chiliyum "Chili Con Carne" ALCH:0x000065AC]
	AddModMultiPartFood_Array(0x000065AA, "mealtimeyum.esp",	0x000065AC, "mealtimeyum.esp", 4)	
	ClearAndAddModFood(0x00035419, "mealtimeyum.esp", _Seed_DrinkNonAlcoholic) 	; coddleyum "Sausage Potato Coddle" ALCH:0x00035419]
	ClearAndAddModFood(0x0003541E, "mealtimeyum.esp", _Seed_DrinkNonAlcoholic) 	; coddleservyum "Sausage Potato Coddle Plate" ALCH:0x0003541E]
	AddModMultiPartFood_Array(0x00035419, "mealtimeyum.esp",	0x0003541E, "mealtimeyum.esp", 4)	
	ClearAndAddModFood(0x000065B8, "mealtimeyum.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMinor) 		; roastboarplateyum "Roast Boar Platter" ALCH:0x000065B8]
	ClearAndAddModFood(0x000065BC, "mealtimeyum.esp", _Seed_MeatCooked, _Seed_Food_RestoreHungerMinor) 		; roastboaryum "Roast Boar Slice" ALCH:0x000065BC]
	AddModMultiPartFood_Array(0x000065B8, "mealtimeyum.esp",	0x000065BC, "mealtimeyum.esp", 4)	
	
	;Cooked Small Game
	ClearAndAddModFood(0x000065BA, "mealtimeyum.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMajor) 	; pateyum "Pate" ALCH:0x000065BA]
	ClearAndAddModFood(0x0006ADAC, "mealtimeyum.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMajor) 	; chickenmoleplateyum "Spicy Chicken Mole" ALCH:0x0006ADAC]
	ClearAndAddModFood(0x0006FEC7, "mealtimeyum.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMajor) 	; frickyum "Elves Ear Chicken Fricassee" ALCH:0x0006FEC7]
		
	; Cooked Small Game - Portioned
	ClearAndAddModFood(0x00023A99, "mealtimeyum.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor) 	; currsoupbowlyum "Yellow Chicken Curry Bowl" ALCH:0x00023A99]
	ClearAndAddModFood(0x00023A96, "mealtimeyum.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor) 	; currsoupyum "Yellow Chicken Curry" ALCH:0x00023A96]
	AddModMultiPartFood_Array(0x00023A99, "mealtimeyum.esp",	0x00023A96, "mealtimeyum.esp", 4)	
	ClearAndAddModFood(0x0003D418, "mealtimeyum.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor) 	; eggsaladservyum "Egg Salad Bowl" ALCH:0x0003D418]	
	ClearAndAddModFood(0x0003D40C, "mealtimeyum.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor) 	; eggsaladyum "Egg Salad" ALCH:0x0003D40C]
	AddModMultiPartFood_Array(0x0003D418, "mealtimeyum.esp",	0x0003D40C, "mealtimeyum.esp", 3)
	ClearAndAddModFood(0x0001211B, "mealtimeyum.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor) 	; eggplateyum "Daedra'd Egg Plate" ALCH:0x0001211B]
	ClearAndAddModFood(0x0001211D, "mealtimeyum.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor) 	; eggyum "Daedra'd Egg" ALCH:0x0001211D]
	AddModMultiPartFood_Array(0x0001211B, "mealtimeyum.esp",	0x0001211D, "mealtimeyum.esp", 3)
	ClearAndAddModFood(0x0000F24F, "mealtimeyum.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor) 	; roastchiknplateyum "Roast Chicken Platter" ALCH:0x0000F24F]
	ClearAndAddModFood(0x0001212A, "mealtimeyum.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor) 	; roastchiknlegyum "Roast Chicken Leg" ALCH:0x0001212A]
	AddModMultiPartFood_Array(0x0000F24F, "mealtimeyum.esp",	0x0001212A, "mealtimeyum.esp", 2)
	ClearAndAddModFood(0x0006ADA6, "mealtimeyum.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor) 	; satayplateyum "Spicy Chicken Satay Plate" ALCH:0x0006ADA6]
	ClearAndAddModFood(0x0006ADA8, "mealtimeyum.esp", _Seed_SmallGameCooked, _Seed_Food_RestoreHungerMinor) 	; satayservyum "Spicy Chicken Satay" ALCH:0x0006ADA8]
	AddModMultiPartFood_Array(0x0006ADA6, "mealtimeyum.esp",	0x0006ADA8, "mealtimeyum.esp", 4)
	
	
	; Cooked Fish
	ClearAndAddModFood(0x000036C9, "mealtimeyum.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor) 	; lutefiskyum "Jellied Fish" ALCH:0x000036C9]
	ClearAndAddModFood(0x00017EE4, "mealtimeyum.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor) 	; slatplatyum "Juniper Spiced Slaughterfish" ALCH:0x00017EE4]
	ClearAndAddModFood(0x00029864, "mealtimeyum.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMajor) 	; caviyum "Golden Caviar" ALCH:0x00029864]

	; Cooked Fish - PORTIONED
	ClearAndAddModFood(0x0007A109, "mealtimeyum.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMinor) 	; salmplateyum "Salmon and Juniper Mousse" ALCH:0x0007A109]
	ClearAndAddModFood(0x0007A10B, "mealtimeyum.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMinor) 	; salmyum "Salmon and Juniper Mousse" ALCH:0x0007A10B]	
	AddModMultiPartFood_Array(0x0007A109, "mealtimeyum.esp",	0x0007A10B, "mealtimeyum.esp", 6)
	ClearAndAddModFood(0x00032516, "mealtimeyum.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMinor) 	; mudcrabcakesyum "Mudcrab Cakes" ALCH:0x00032516]
	ClearAndAddModFood(0x00032514, "mealtimeyum.esp", _Seed_FishCooked, _Seed_Food_RestoreHungerMinor) 	; mudcrabcakeyum "Mudcrab Cake" ALCH:0x00032514]
	AddModMultiPartFood_Array(0x00032516, "mealtimeyum.esp",	0x00032514, "mealtimeyum.esp", 1)

	
	; Cooked Vegetables	
	ClearAndAddModFood(0x000324F4, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor) 	; beansyum "Dragon's Tongue Beans" ALCH:0x000324F4]
	ClearAndAddModFood(0x0006FEB9, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor) 	; hmmmyum "Dragon's Tongue Hummus" ALCH:0x0006FEB9]
	ClearAndAddModFood(0x0006FECD, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMajor) 	; mostexcellentpotatoyum "Stuffed Baked Potato" ALCH:0x0006FECD]
	
	; Cooked Vegetables - Portioned
	ClearAndAddModFood(0x00006596, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; casseroledishyum "Green Casserole Dish" ALCH:0x00006596]
	ClearAndAddModFood(0x000065A8, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; casseroleyum "Green Casserole" ALCH:0x000065A8]
	AddModMultiPartFood_Array(0x00006596, "mealtimeyum.esp",	0x000065A8, "mealtimeyum.esp", 4)	
	ClearAndAddModFood(0x0006FEDA, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; falafplateyum "Grapes and Ashyam Falafel Plate" ALCH:0x0006FEDA]
	ClearAndAddModFood(0x0006FED8, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; falafballyum "Grapes and Ashyam Falafel" ALCH:0x0006FED8]
	AddModMultiPartFood_Array(0x0006FEDA, "mealtimeyum.esp",	0x0006FED8, "mealtimeyum.esp", 9)	
	ClearAndAddModFood(0x00006598, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; mashtatodishyum "Mashed Potato Dish" ALCH:0x00006598]
	ClearAndAddModFood(0x000065A6, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; mashtatoyum "Mashed Potatoes" ALCH:0x000065A6]
	AddModMultiPartFood_Array(0x00006598, "mealtimeyum.esp",	0x000065A6, "mealtimeyum.esp", 3)	
	ClearAndAddModFood(0x000094B3, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; potsaladdishyum "Potato Salad Bowl" ALCH:0x000094B3]
	ClearAndAddModFood(0x000094B6, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; potsaladyum "Potato Salad" ALCH:0x000094B6]
	AddModMultiPartFood_Array(0x000094B3, "mealtimeyum.esp",	0x000094B6, "mealtimeyum.esp", 2)	
	ClearAndAddModFood(0x00023A94, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; potagebowlyum "Gourmet's Potage le Magnifique Bowl" ALCH:0x00023A94]
	ClearAndAddModFood(0x00023A91, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; potageyum "Gourmet's Potage le Magnifique" ALCH:0x00023A91]
	AddModMultiPartFood_Array(0x00023A94, "mealtimeyum.esp",	0x00023A91, "mealtimeyum.esp", 2)	
	ClearAndAddModFood(0x0003252F, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; vegetableplateyum3full "Vegetable Plate" ALCH:0x0003252F]
	ClearAndAddModFood(0x000A2952, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; vegetableplateyum2 "Vegetable Plate" ALCH:0x000A2952]
	AddModMultiPartFood_Array(0x0003252F, "mealtimeyum.esp",	0x000A2952, "mealtimeyum.esp", 1)	
	ClearAndAddModFood(0x000A2954, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; vegetableplateyum1empty "Vegetable Plate" ALCH:0x000A2954]
	AddModMultiPartFood_Array(0x000A2952, "mealtimeyum.esp",	0x000A2954, "mealtimeyum.esp", 1)	
	ClearAndAddModFood(0x0000659A, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; snowsaucedishyum "Snowberry Sauce Dish" ALCH:0x0000659A]
	ClearAndAddModFood(0x000065A4, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; snowsauceyum "Snowberry Sauce" ALCH:0x000065A4]
	AddModMultiPartFood_Array(0x0000659A, "mealtimeyum.esp",	0x000065A4, "mealtimeyum.esp", 1)	
	
	; Fruit
	ClearAndAddModFood(0x00032502, "mealtimeyum.esp", _Seed_Fruit, _Seed_Food_RestoreHungerSuperior) 	; applsaladyum "Apple Eider Salad" ALCH:0x00032502]
	
	; Fruit - Portioned
	ClearAndAddModFood(0x00023A71, "mealtimeyum.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMinor) 	; moonfruitdishyum "Moon Sugared Fruit Bowl" ALCH:0x00023A71]
	ClearAndAddModFood(0x00023A74, "mealtimeyum.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMinor) 	; moonfruitsyum "Moon Sugared Fruits" ALCH:0x00023A74]
	AddModMultiPartFood_Array(0x00023A71, "mealtimeyum.esp",	0x00023A74, "mealtimeyum.esp", 4)	
		
	; Pastry	
	ClearAndAddModFood(0x0003D3F7, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive) 	; baconsandhichyum "Horker Bacon Sandwich" ALCH:0x0003D3F7]
	ClearAndAddModFood(0x0003D406, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive) 	; eggsaladsandwichyum "Egg Salad Sandwich" ALCH:0x0003D406]
	ClearAndAddModFood(0x0003D41A, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive) 	; snowberrysandyum "Snowberry Jam Sandwich" ALCH:0x0003D41A]
	ClearAndAddModFood(0x00047632, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive) 	; jpieyum "Jazbay Pie" ALCH:0x00047632]
	ClearAndAddModFood(0x0005186D, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive) 	; chocopieyum "Chocolate Cream Pie" ALCH:0x0005186D]
	ClearAndAddModFood(0x0006AD9B, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive) 	; potpieyum "Chicken Pot Pie" ALCH:0x0006AD9B]
	ClearAndAddModFood(0x0006FEB6, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive) 	; flakesbowlyum "Wheat Flakes Bowl" ALCH:0x0006FEB6]
	ClearAndAddModFood(0x0009873A, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive) 	; butterbiscuiteggyum "Buttermilk Egg Biscuit" ALCH:0x0009873A]
	ClearAndAddModFood(0x0009873C, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMassive) 	; butterbiscuitgravyyum "Buttermilk Biscuits and Gravy" ALCH:0x0009873C]
	
	; Pastry - Portioned
	ClearAndAddModFood(0x0006AD9F, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; baklavyum "Dragons Tongue Honey Baklava" ALCH:0x0006AD9F]
	ClearAndAddModFood(0x0006ADA1, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; baklavpieceyum "Dragons Tongue Honey Baklava" ALCH:0x0006ADA1]
	AddModMultiPartFood_Array(0x0006AD9F, "mealtimeyum.esp",	0x0006ADA1, "mealtimeyum.esp", 9)	
	ClearAndAddModFood(0x0001212E, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; blanketplateyum "Plate of Boars in a Blanket" ALCH:0x0001212E]
	ClearAndAddModFood(0x00012120, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; blanketyum "Boar in a Blanket" ALCH:0x00012120]
	AddModMultiPartFood_Array(0x0001212E, "mealtimeyum.esp",	0x00012120, "mealtimeyum.esp", 5)
	ClearAndAddModFood(0x0003250E, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; devplateyum "Breton Hors d'Oeuvres" ALCH:0x0003250E]
	ClearAndAddModFood(0x0003250B, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; devyum "Breton Hors d'Oeuvre" ALCH:0x0003250B]
	AddModMultiPartFood_Array(0x0003250E, "mealtimeyum.esp",	0x0003250B, "mealtimeyum.esp", 2)
	ClearAndAddModFood(0x00015017, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; fritatayum "Tomato Egg Fritata" ALCH:0x00015017]
	ClearAndAddModFood(0x00015019, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; fritatasliceyum "Tomato Egg Fritata Slice" ALCH:0x00015019]
	AddModMultiPartFood_Array(0x00015017, "mealtimeyum.esp",	0x00015019, "mealtimeyum.esp", 9)
	ClearAndAddModFood(0x00015010, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; pastelesplateyum "Jazbay Leaf Pasteles" ALCH:0x00015010]
	ClearAndAddModFood(0x00015012, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; pasteleyum "Jazbay Leaf Pastel" ALCH:0x00015012]
	AddModMultiPartFood_Array(0x00015010, "mealtimeyum.esp",	0x00015012, "mealtimeyum.esp", 5)
	ClearAndAddModFood(0x00029862, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; raviolidshyum "Emperor Parasol Ravioli Dish" ALCH:0x00029862]
	ClearAndAddModFood(0x0002985F, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; ravioliyum "Emperor Parasol Ravioli" ALCH:0x0002985F]
	AddModMultiPartFood_Array(0x00029862, "mealtimeyum.esp",	0x0002985F, "mealtimeyum.esp", 3)
	ClearAndAddModFood(0x0002F621, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; spanyum "Frost Mirriam Pastry" ALCH:0x0002F621]
	ClearAndAddModFood(0x0002F624, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; spansliceyum "Frost Mirriam Pastry Slice" ALCH:0x0002F624]
	AddModMultiPartFood_Array(0x0002F621, "mealtimeyum.esp",	0x0002F624, "mealtimeyum.esp", 5)
	ClearAndAddModFood(0x0003D402, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; teasandwichesyum "Frost Mirriam Tea Sandwiches" ALCH:0x0003D402]
	ClearAndAddModFood(0x0003D3FD, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; teasandwichyum "Frost Mirriam Tea Sandwich" ALCH:0x0003D3FD]
	AddModMultiPartFood_Array(0x0003D402, "mealtimeyum.esp",	0x0003D3FD, "mealtimeyum.esp", 6)
	
	; Pasta - Portioned
	ClearAndAddModFood(0x00042529, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; pestopastservyum "Pesto Pasta" ALCH:0x00042529]
	ClearAndAddModFood(0x00042527, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; pestopastyum "Pesto Pasta" ALCH:0x00042527]
	AddModMultiPartFood_Array(0x00042529, "mealtimeyum.esp",	0x00042527, "mealtimeyum.esp", 2)
	ClearAndAddModFood(0x0002985D, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; pastserveyum "Elves Ear Pasta Plate" ALCH:0x0002985D]
	ClearAndAddModFood(0x0002985A, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; pastyum "Elves Ear Pasta" ALCH:0x0002985A]
	AddModMultiPartFood_Array(0x0002985D, "mealtimeyum.esp",	0x0002985A, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x0004252C, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; greekpastyum "Cyrodilic Pasta" ALCH:0x0004252C]
	ClearAndAddModFood(0x0004252E, "mealtimeyum.esp", _Seed_Pastries, _Seed_Food_RestoreHungerMinor) 	; greekpastservyum "Cyrodilic Pasta" ALCH:0x0004252E]	
	AddModMultiPartFood_Array(0x0004252C, "mealtimeyum.esp",	0x0004252E, "mealtimeyum.esp", 2)
	
	
	; Treat
	ClearAndAddModFood(0x00029842, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; iscreamyum "Ice Cream" ALCH:0x00029842]
	ClearAndAddModFood(0x00029845, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; iscreamsnowyum "Snowberry Ice Cream" ALCH:0x00029845]
	ClearAndAddModFood(0x0002984C, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; iscreamchocolateyum "Chocolate Ice Cream" ALCH:0x0002984C]
	ClearAndAddModFood(0x0002984F, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; iscreamgoldyum "Sovngarde Ice Cream" ALCH:0x0002984F]
	ClearAndAddModFood(0x00029852, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; cremebrulyum "Creme Brulee" ALCH:0x00029852]
	ClearAndAddModFood(0x00029855, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; souffleyum "Sunlight Souffle" ALCH:0x00029855]
	ClearAndAddModFood(0x00056979, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; chocolavayum "Chocolate Lava Cake" ALCH:0x00056979]
	ClearAndAddModFood(0x00060B82, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; mousecakealtoyum "Alto Wine Mousse Cake" ALCH:0x00060B82]
	ClearAndAddModFood(0x00060B86, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; mousecakechocoyum "Chocolate Mousse Cake" ALCH:0x00060B86]
	ClearAndAddModFood(0x00060B89, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; mousecakebutteryum "Butterscotch Mousse Cake" ALCH:0x00060B89]
	ClearAndAddModFood(0x00060B8C, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; mousecakesnowbyum "Dark Chocolate Snowberry Mousse Cake" ALCH:0x00060B8C]
	ClearAndAddModFood(0x00051871, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; marshyum "Marshmallow Stick" ALCH:0x00051871]
	ClearAndAddModFood(0x00051873, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; marshtoastyum "Toasted Marshmallow Stick" ALCH:0x00051873]
	ClearAndAddModFood(0x0006ADAF, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; cussyum "Icy Custard" ALCH:0x0006ADAF]
	ClearAndAddModFood(0x0006FECA, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; creamhoneyyum "Creamed Honey" ALCH:0x0006FECA]
	ClearAndAddModFood(0x0006FEF3, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; elsdelightyum "Elsweyr Delight" ALCH:0x0006FEF3]
	ClearAndAddModFood(0x0008942A, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; flossyum "Candy Floss" ALCH:0x0008942A]
	ClearAndAddModFood(0x00098732, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; butterbiscuityum "Buttermilk Biscuit" ALCH:0x00098732]
	ClearAndAddModFood(0x00098734, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; butterbiscuithoneyyum "Honey Buttermilk Biscuit" ALCH:0x00098734]
	ClearAndAddModFood(0x00098736, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; butterbiscuitsnowbyum "Snowberry Buttermilk Biscuit" ALCH:0x00098736]
	ClearAndAddModFood(0x00098738, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; butterbiscuitapplebeesyum "Applebutter Buttermilk Biscuit" ALCH:0x00098738]
	ClearAndAddModFood(0x0009873E, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; applebutteryum "Apple Butter" ALCH:0x0009873E]
	ClearAndAddModFood(0x00098740, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; sugaryum "Honey Sugar Crystals" ALCH:0x00098740]
	ClearAndAddModFood(0x00098742, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; cocoapowderyum "Nordic Cocoa Powder" ALCH:0x00098742]
	ClearAndAddModFood(0x00098744, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; spicemixyum "Spice Mix" ALCH:0x00098744]
	ClearAndAddModFood(0x000324FB, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerSuperior) 	; sugardragonyum "Sugarglass Dragon" ALCH:0x000324FB]
	
	; Treats - Portioned
	ClearAndAddModFood(0x0002C74B, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; appledishyum "Custard Baked Apples" ALCH:0x0002C74B]	
	ClearAndAddModFood(0x0002C748, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; appleyum "Custard Baked Apple" ALCH:0x0002C748]
	AddModMultiPartFood_Array(0x0002C74B, "mealtimeyum.esp",	0x0002C748, "mealtimeyum.esp", 3)
	ClearAndAddModFood(0x0006FED1, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; applecobpanyum "Spiced Apple Cobbler" ALCH:0x0006FED1]
	ClearAndAddModFood(0x0006FED4, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; applecobsliceyum "Spiced Apple Cobbler Slice" ALCH:0x0006FED4]
	AddModMultiPartFood_Array(0x0006FED1, "mealtimeyum.esp",	0x0006FED4, "mealtimeyum.esp", 5)
	ClearAndAddModFood(0x0001DCC2, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; azurascookieyum "Azura's Star Cookie" ALCH:0x0001DCC2]
	ClearAndAddModFood(0x0001DCC5, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; azurascookieplateyum "Azura's Star Cookie Plate" ALCH:0x0001DCC5]
	AddModMultiPartFood_Array(0x0001DCC2, "mealtimeyum.esp",	0x0001DCC5, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x00017EE8, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; baumyum "Riverwood Tree Cake" ALCH:0x00017EE8]
	ClearAndAddModFood(0x00017EED, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; baumsliceyum "Riverwood Tree Cake Slice" ALCH:0x00017EED]
	AddModMultiPartFood_Array(0x00017EE8, "mealtimeyum.esp",	0x00017EED, "mealtimeyum.esp", 3)
	ClearAndAddModFood(0x0001500A, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; bredpudyum "Bread Pudding" ALCH:0x0001500A]
	ClearAndAddModFood(0x0001500D, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; bredpudplateyum "Bread Pudding" ALCH:0x0001500D]
	AddModMultiPartFood_Array(0x0001500A, "mealtimeyum.esp",	0x0001500D, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x0002F61A, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; bundtyum "Stros M'Kai Rum Cake" ALCH:0x0002F61A]
	ClearAndAddModFood(0x0002F628, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; bundtsliceyum "Stros M'Kai Rum Cake Slice" ALCH:0x0002F628]
	AddModMultiPartFood_Array(0x0002F61A, "mealtimeyum.esp",	0x0002F628, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x0001ADDE, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; buttercakeyumbilbo "Decorated Buttercream Cake" ALCH:0x0001ADDE]
	ClearAndAddModFood(0x0001ADE2, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; buttercakeyumbilbocut "Decorated Buttercream Cake Slice" ALCH:0x0001ADE2]
	AddModMultiPartFood_Array(0x0001ADDE, "mealtimeyum.esp",	0x0001ADE2, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x0001ADCB, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; buttercakeyum "Buttercream Cake" ALCH:0x0001ADCB]
	ClearAndAddModFood(0x0001ADD9, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; buttercakesliceyum "Buttercream Cake Slice" ALCH:0x0001ADD9]	
	AddModMultiPartFood_Array(0x0001ADCB, "mealtimeyum.esp",	0x0001ADD9, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x0006FEE3, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; butterpoundcakeyum "Buttery Pound Cake" ALCH:0x0006FEE3]
	ClearAndAddModFood(0x0006FEE8, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; butterpoundcakesliceyum "Buttery Pound Cake Slice" ALCH:0x0006FEE8]
	AddModMultiPartFood_Array(0x0006FEE3, "mealtimeyum.esp",	0x0006FEE8, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x00015003, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; buttspieyum "Butterscotch Spice Pie" ALCH:0x00015003]
	ClearAndAddModFood(0x00015006, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; buttspiesliceyum "Butterscotch Spice Pie Slice" ALCH:0x00015006]
	AddModMultiPartFood_Array(0x00015003, "mealtimeyum.esp",	0x00015006, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x00020B9C, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; candyyamsplateyum "Candied Ash Yam Plate" ALCH:0x00020B9C]
	ClearAndAddModFood(0x00020B9A, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; candyyamsyum "Candied Ash Yams" ALCH:0x00020B9A]
	AddModMultiPartFood_Array(0x00020B9C, "mealtimeyum.esp",	0x00020B9A, "mealtimeyum.esp", 3)
	ClearAndAddModFood(0x0007A10E, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; carrotcakeyum "Carrot Cake" ALCH:0x0007A10E]
	ClearAndAddModFood(0x0007A110, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; carrotcakesliceyum "Carrot Cake Slice" ALCH:0x0007A110]
	AddModMultiPartFood_Array(0x0007A10E, "mealtimeyum.esp",	0x0007A110, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x0006FEF7, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; creampuffplateyum "Cream Puffs" ALCH:0x0006FEF7]
	ClearAndAddModFood(0x0006FEF9, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; creampuffyum "Cream Puff" ALCH:0x0006FEF9]
	AddModMultiPartFood_Array(0x0006FEF7, "mealtimeyum.esp",	0x0006FEF9, "mealtimeyum.esp", 6)
	ClearAndAddModFood(0x0001DCBE, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; delightyum "Snowberry Delight" ALCH:0x0001DCBE]
	ClearAndAddModFood(0x0001DCBB, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; delightservyum "Snowberry Delight Slice" ALCH:0x0001DCBB]
	AddModMultiPartFood_Array(0x0001DCBE, "mealtimeyum.esp",	0x0001DCBB, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x0006FEFC, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; flambeonfireyum "Baked Winterhold Flambe" ALCH:0x0006FEFC]
	ClearAndAddModFood(0x0006FF03, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; flambeyum "Baked Winterhold Flambe" ALCH:0x0006FF03]
	AddModMultiPartFood_Array(0x0006FEFC, "mealtimeyum.esp",	0x0006FF03, "mealtimeyum.esp", 1)
	ClearAndAddModFood(0x00017EFA, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; fruitcakeyum "Fruit Cake" ALCH:0x00017EFA]
	ClearAndAddModFood(0x00017EFE, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; fruitcakesliceyum "Fruit Cake Slice" ALCH:0x00017EFE]	
	AddModMultiPartFood_Array(0x00017EFA, "mealtimeyum.esp",	0x00017EFE, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x0002C738, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; fudgeyum "Fudge Brownie" ALCH:0x0002C738]
	ClearAndAddModFood(0x0002C73A, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; fudgesyum "Fudge Brownies" ALCH:0x0002C73A]
	AddModMultiPartFood_Array(0x0002C738, "mealtimeyum.esp",	0x0002C73A, "mealtimeyum.esp", 9)
	ClearAndAddModFood(0x0006FEEC, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; honeycakeyum "Honey Cake" ALCH:0x0006FEEC]
	ClearAndAddModFood(0x0006FEEF, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; honeycakesliceyum "Honey Cake Slice" ALCH:0x0006FEEF]
	AddModMultiPartFood_Array(0x0006FEEC, "mealtimeyum.esp",	0x0006FEEF, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x00014FFC, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; honeypuddingyum "Honey Pudding" ALCH:0x00014FFC]
	ClearAndAddModFood(0x00015000, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; honeypuddingbowlyum "Honey Pudding Bowl" ALCH:0x00015000]
	AddModMultiPartFood_Array(0x00014FFC, "mealtimeyum.esp",	0x00015000, "mealtimeyum.esp", 2)
	ClearAndAddModFood(0x000065BE, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; jazzcakeyum "Jazbay Cake" ALCH:0x000065BE]
	ClearAndAddModFood(0x000065C0, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; jazzcakesliceyum "Jazbay Cake Slice" ALCH:0x000065C0]
	AddModMultiPartFood_Array(0x000065BE, "mealtimeyum.esp",	0x000065C0, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x0002C735, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; jazsconeplateyum "Jazbay Meadowcream Scones" ALCH:0x0002C735]
	ClearAndAddModFood(0x00029867, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; jazsconeyum "Jazbay Meadowcream Scone" ALCH:0x00029867]
	AddModMultiPartFood_Array(0x0002C735, "mealtimeyum.esp",	0x00029867, "mealtimeyum.esp", 7)
	ClearAndAddModFood(0x00017EF3, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; panplateyum "Pancake Puff Plate" ALCH:0x00017EF3]
	ClearAndAddModFood(0x00017EF1, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; panyum "Pancake Puff" ALCH:0x00017EF1]
	AddModMultiPartFood_Array(0x00017EF3, "mealtimeyum.esp",	0x00017EF1, "mealtimeyum.esp", 9)
	ClearAndAddModFood(0x00017EF5, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; uberollyum "Ash Yam Cake" ALCH:0x00017EF5]
	ClearAndAddModFood(0x00017EF8, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; uberollcutyum "Ash Yam Cake Slice" ALCH:0x00017EF8]
	AddModMultiPartFood_Array(0x00017EF5, "mealtimeyum.esp",	0x00017EF8, "mealtimeyum.esp", 2)
	ClearAndAddModFood(0x0001ADD0, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; wedcakeyum "Dragonborn Wedding Cake" ALCH:0x0001ADD0]
	ClearAndAddModFood(0x0001ADD5, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; wedcakesliceyum "Wedding Cake Slice" ALCH:0x0001ADD5]
	AddModMultiPartFood_Array(0x0001ADD0, "mealtimeyum.esp",	0x0001ADD5, "mealtimeyum.esp", 20)
	ClearAndAddModFood(0x000A2956, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; wedcakeyum3tier "Wedding Cake" ALCH:0x000A2956]
	AddModMultiPartFood_Array(0x000A2956, "mealtimeyum.esp",	0x0001ADD5, "mealtimeyum.esp", 15)
	ClearAndAddModFood(0x0001ADE9, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; porridgeyumbowl "Cream Porridge Bowl" ALCH:0x0001ADE9]
	ClearAndAddModFood(0x0001ADE6, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; porridgeyum "Cream Porridge" ALCH:0x0001ADE6]
	AddModMultiPartFood_Array(0x0001ADE9, "mealtimeyum.esp",	0x0001ADE6, "mealtimeyum.esp", 2)
	ClearAndAddModFood(0x0001ADEB, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; potpanksyum "Potato Pancakes" ALCH:0x0001ADEB]
	ClearAndAddModFood(0x0001ADEF, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; potpankyum "Potato Pancake" ALCH:0x0001ADEF]
	AddModMultiPartFood_Array(0x0001ADEB, "mealtimeyum.esp",	0x0001ADEF, "mealtimeyum.esp", 5)
	ClearAndAddModFood(0x00023A78, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; velvetyum "Red Velvet Cake" ALCH:0x00023A78]
	ClearAndAddModFood(0x00023A7C, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; velvetsliceyum "Red Velvet Cake Slice" ALCH:0x00023A7C]	
	AddModMultiPartFood_Array(0x00023A78, "mealtimeyum.esp",	0x00023A7C, "mealtimeyum.esp", 3)
	ClearAndAddModFood(0x00023A80, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; logcakeyum "Log Cake" ALCH:0x00023A80]
	ClearAndAddModFood(0x00023A82, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; logcakesliceyum "Log Cake Slice" ALCH:0x00023A82]
	AddModMultiPartFood_Array(0x00023A80, "mealtimeyum.esp",	0x00023A82, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x00023AA0, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; redfudgeyum "Red Mountain Flower Fudge" ALCH:0x00023AA0]
	ClearAndAddModFood(0x00023AA2, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; redfudgesliceyum "Red Mountain Flower Fudge Slice" ALCH:0x00023AA2]
	AddModMultiPartFood_Array(0x00023AA0, "mealtimeyum.esp",	0x00023AA2, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x00026972, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; maltbowlyum "Flower Malt Bowl" ALCH:0x00026972]
	ClearAndAddModFood(0x00026974, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; maltsyum "Mountain Flower Malts" ALCH:0x00026974]
	AddModMultiPartFood_Array(0x00026972, "mealtimeyum.esp",	0x00026974, "mealtimeyum.esp", 9)
	ClearAndAddModFood(0x0002C742, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; sabcakesyum "Sabre Cakes" ALCH:0x0002C742]	
	ClearAndAddModFood(0x0002C73F, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; sabcakeyum "Sabre Cake" ALCH:0x0002C73F]
	AddModMultiPartFood_Array(0x0002C742, "mealtimeyum.esp",	0x0002C73F, "mealtimeyum.esp", 5)
	ClearAndAddModFood(0x000324F6, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; peanutfudgeyum "Dragon's Tongue Fudge" ALCH:0x000324F6]
	ClearAndAddModFood(0x000324F8, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; peanutfudgeserveyum "Dragon's Tongue Fudge Slice" ALCH:0x000324F8]
	AddModMultiPartFood_Array(0x000324F6, "mealtimeyum.esp",	0x000324F8, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x00032505, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; applcakeyum "Apple Spice Cake" ALCH:0x00032505]
	ClearAndAddModFood(0x00032507, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; applcakesliceyum "Apple Spice Cake Slice" ALCH:0x00032507]
	AddModMultiPartFood_Array(0x00032505, "mealtimeyum.esp",	0x00032507, "mealtimeyum.esp", 9)
	ClearAndAddModFood(0x00032532, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; wedcookiesyum "Wedding Cookies" ALCH:0x00032532]
	ClearAndAddModFood(0x00032534, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; wedcookieyum "Wedding Cookie" ALCH:0x00032534]
	AddModMultiPartFood_Array(0x00032532, "mealtimeyum.esp",	0x00032534, "mealtimeyum.esp", 15)
	ClearAndAddModFood(0x0003D410, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; lavendercakeyum "Lavender Cake" ALCH:0x0003D410]
	ClearAndAddModFood(0x0003D414, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; lavendercakesliceyum "Lavender Cake Slice" ALCH:0x0003D414]
	AddModMultiPartFood_Array(0x0003D410, "mealtimeyum.esp",	0x0003D414, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x00065C90, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; raincakeyum "Rainbow Mountain Flower Cake" ALCH:0x00065C90]
	ClearAndAddModFood(0x00065C92, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; raincakecutyum "Rainbow Mountain Flower Cake Slice" ALCH:0x00065C92]
	AddModMultiPartFood_Array(0x00065C90, "mealtimeyum.esp",	0x00065C92, "mealtimeyum.esp", 5)
	ClearAndAddModFood(0x0007F217, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; sweetcakeyum "Celebration Sweetroll" ALCH:0x0007F217]
	ClearAndAddModFood(0x0007F219, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; sweetcakesliceyum "Celebration Sweetroll Slice" ALCH:0x0007F219]
	AddModMultiPartFood_Array(0x0007F217, "mealtimeyum.esp",	0x0007F219, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x0004C737, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; wafflesyum "Honey Wheat Waffles" ALCH:0x0004C737]
	ClearAndAddModFood(0x0004C739, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; waffleyum "Honey Wheat Waffle" ALCH:0x0004C739]
	AddModMultiPartFood_Array(0x0004C737, "mealtimeyum.esp",	0x0004C739, "mealtimeyum.esp", 3)
	ClearAndAddModFood(0x0003253C, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; petalsredyumbig "Sugared Red Mountain Flowers" ALCH:0x0003253C]
	ClearAndAddModFood(0x00032539, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; petalsredyum "Sugared Red Mountain Flowers" ALCH:0x00032539]
	AddModMultiPartFood_Array(0x0003253C, "mealtimeyum.esp",	0x00032539, "mealtimeyum.esp", 2)	
	ClearAndAddModFood(0x00032540, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; petalspurpleyumbig "Sugared Purple Mountain Flowers" ALCH:0x00032540]
	ClearAndAddModFood(0x00032542, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; petalspurpleyum "Sugared Purple Mountain Flowers" ALCH:0x00032542]
	AddModMultiPartFood_Array(0x00032540, "mealtimeyum.esp",	0x00032542, "mealtimeyum.esp", 2)
	ClearAndAddModFood(0x00032544, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; petalsblueyumbig "Sugared Blue Mountain Flowers" ALCH:0x00032544]
	ClearAndAddModFood(0x00032546, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; petalsblueyum "Sugared Blue Mountain Flowers" ALCH:0x00032546]
	AddModMultiPartFood_Array(0x00032544, "mealtimeyum.esp",	0x00032546, "mealtimeyum.esp", 2)
	ClearAndAddModFood(0x00032548, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; petalsyellowyumbig "Sugared Yellow Mountain Flowers" ALCH:0x00032548]
	ClearAndAddModFood(0x0003254A, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; petalsyellowyum "Sugared Yellow Mountain Flowers" ALCH:0x0003254A]
	AddModMultiPartFood_Array(0x00032548, "mealtimeyum.esp",	0x0003254A, "mealtimeyum.esp", 2)	
	
	; This item returns multiple different items, not currently possible to handle
	ClearAndAddModFood(0x000065B2, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; flowercookieplatteryum "Flower Cookie Platter" ALCH:0x000065B2]
	ClearAndAddModFood(0x0000659E, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; flowercookieredyum "Red Mountain Flower Cookie" ALCH:0x0000659E]
	ClearAndAddModFood(0x0009874A, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; flowercookieyellowyum "Yellow Mountain Flower Cookie" ALCH:0x0009874A]
	
	;  Sauce
	ClearAndAddModFood(0x0003251D, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; Saucemoleyum "Chocolate Mole Sauce" ALCH:0x0003251D]
	ClearAndAddModFood(0x00032519, "mealtimeyum.esp", _Seed_Fruit, _Seed_Food_RestoreHungerMinor) 	; Saucemarinarayum "Tomato Frost Mirriam Marinara" ALCH:0x00032519]
	ClearAndAddModFood(0x0003251B, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; Saucepestoyum "Elves Ear Eider Pesto" ALCH:0x0003251B]
	ClearAndAddModFood(0x0003251F, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; Saucefrostmirriamyum "Frost Mirriam Dip" ALCH:0x0003251F]
	ClearAndAddModFood(0x00032521, "mealtimeyum.esp", _Seed_Vegetables, _Seed_Food_RestoreHungerMinor) 	; Saucepeanutyum "Spicy Dragon's Tongue Sauce" ALCH:0x00032521]
	
	; Soup
	ClearAndAddModFood(0x0006FEC4, "mealtimeyum.esp", _Seed_Stews, _Seed_Food_RestoreHungerMassive) 	; breadbowlstewyum "Beef Stew Bread Bowl" ALCH:0x0006FEC4]
	
	; Soup - Portioned
	ClearAndAddModFood(0x00023A9E, "mealtimeyum.esp", _Seed_Stews, _Seed_Food_RestoreHungerMinor) 	; snowfrothbowlyum "Frothy Snowberry Soup Bowl" ALCH:0x00023A9E]
	ClearAndAddModFood(0x00023A9B, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; snowfrothyum "Frothy Snowberry Soup" ALCH:0x00023A9B]
	AddModMultiPartFood_Array(0x00023A9E, "mealtimeyum.esp",	0x00023A9B, "mealtimeyum.esp", 1)
	ClearAndAddModFood(0x0006FEDD, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; gumbigyum "Spicy Chicken Gumbo" ALCH:0x0006FEDD]
	ClearAndAddModFood(0x0006FEDF, "mealtimeyum.esp", _Seed_Treats, _Seed_Food_RestoreHungerMinor) 	; gumsmallyum "Spicy Chicken Gumbo Bowl" ALCH:0x0006FEDF]
	AddModMultiPartFood_Array(0x0006FEDD, "mealtimeyum.esp",	0x0006FEDF, "mealtimeyum.esp", 3)

	
	; Bread - Portioned
	ClearAndAddModFood(0x00009491, "mealtimeyum.esp", _Seed_bread, _Seed_Food_RestoreHungerMinor) 	; breadrollyum "Bread Roll" ALCH:0x00009491]
	ClearAndAddModFood(0x0000948F, "mealtimeyum.esp", _Seed_bread, _Seed_Food_RestoreHungerMinor) 	; breadrollbasketyum "Bread Roll Basket" ALCH:0x0000948F]
	AddModMultiPartFood_Array(0x00009491, "mealtimeyum.esp",	0x0000948F, "mealtimeyum.esp", 7)
	ClearAndAddModFood(0x000065C4, "mealtimeyum.esp", _Seed_bread, _Seed_Food_RestoreHungerMinor) 	; breadstuffingyum "Bread Stuffing" ALCH:0x000065C4]
	ClearAndAddModFood(0x000065C2, "mealtimeyum.esp", _Seed_bread, _Seed_Food_RestoreHungerMinor) 	; breadstuffingdishyum "Bread Stuffing Dish" ALCH:0x000065C2]
	AddModMultiPartFood_Array(0x000065C4, "mealtimeyum.esp",	0x000065C2, "mealtimeyum.esp", 4)
	ClearAndAddModFood(0x00023A86, "mealtimeyum.esp", _Seed_bread, _Seed_Food_RestoreHungerMinor) 	; twigs3yumfull "Bread Twigs" ALCH:0x00023A86]
	ClearAndAddModFood(0x00023A88, "mealtimeyum.esp", _Seed_bread, _Seed_Food_RestoreHungerMinor) 	; twigs2yum "Bread Twigs" ALCH:0x00023A88]
	AddModMultiPartFood_Array(0x00023A86, "mealtimeyum.esp",	0x00023A88, "mealtimeyum.esp", 1)
	ClearAndAddModFood(0x00023A8A, "mealtimeyum.esp", _Seed_bread, _Seed_Food_RestoreHungerMinor) 	; twigs1yumempty "Bread Twigs" ALCH:0x00023A8A]
	AddModMultiPartFood_Array(0x00023A88, "mealtimeyum.esp",	0x00023A8A, "mealtimeyum.esp", 1)
	ClearAndAddModFood(0x0006FEBD, "mealtimeyum.esp", _Seed_bread, _Seed_Food_RestoreHungerMinor) 	; naanpileyum "Naan Bread Pile" ALCH:0x0006FEBD]
	ClearAndAddModFood(0x0006FEBB, "mealtimeyum.esp", _Seed_bread, _Seed_Food_RestoreHungerMinor) 	; naanyum "Naan Bread" ALCH:0x0006FEBB]
	AddModMultiPartFood_Array(0x0006FEBD, "mealtimeyum.esp",	0x0006FEBB, "mealtimeyum.esp", 5)



	; Cheesebowl
	ClearAndAddModFood(0x0003252C, "mealtimeyum.esp", _Seed_CheeseBowls, _Seed_Food_RestoreHungerSuperior) 	; poutineyum "Wilderness Poutine" ALCH:0x0003252C]
	ClearAndAddModFood(0x0006FEC1, "mealtimeyum.esp", _Seed_CheeseBowls, _Seed_Food_RestoreHungerSuperior) 	; breadbowlcheeseyum "Goat Cheese Dip Bread Bowl" ALCH:0x0006FEC1]

	; Cheesebowl - Portioned
	ClearAndAddModFood(0x0001DCCE, "mealtimeyum.esp", _Seed_CheeseBowls, _Seed_Food_RestoreHungerMinor) 	; fondutabowlyum "Eslweyr Fondue Bowl" ALCH:0x0001DCCE]
	ClearAndAddModFood(0x00020BA0, "mealtimeyum.esp", _Seed_CheeseBowls, _Seed_Food_RestoreHungerMinor) 	; fondutarareyum "Eslweyr Rarebit" ALCH:0x00020BA0]
	AddModMultiPartFood_Array(0x0001DCCE, "mealtimeyum.esp",	0x00020BA0, "mealtimeyum.esp", 5)
	ClearAndAddModFood(0x000065AE, "mealtimeyum.esp", _Seed_CheeseBowls, _Seed_Food_RestoreHungerMinor) 	; cheesecasseroledishyum "Cheese Casserole Dish" ALCH:0x000065AE]
	ClearAndAddModFood(0x000065B0, "mealtimeyum.esp", _Seed_CheeseBowls, _Seed_Food_RestoreHungerMinor) 	; cheesecasseroleyum "Cheese Casserole" ALCH:0x000065B0]
	AddModMultiPartFood_Array(0x000065AE, "mealtimeyum.esp",	0x000065B0, "mealtimeyum.esp", 4)
	
	; Non-Alcoholic Drinks
	ClearAndAddModFood(0x000065B4, "mealtimeyum.esp", _Seed_DrinkNonAlcoholic) 	; cocoayum "Nordic Hot Cocoa" ALCH:0x000065B4]
	
	; Milk
	ClearAndAddModFood(0x00023A6D, "mealtimeyum.esp", _Seed_DrinkMilk, _Seed_Food_RestoreHungerMinor) 	; honeymilkyum "Warm Honeyed Milk" ALCH:0x00023A6D]
	
	; Alcohol - Ale
	ClearAndAddModFood(0x000036CB, "mealtimeyum.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	; Eggnogyum "Egg Nog" ALCH:0x000036CB]
	ClearAndAddModFood(0x0004C740, "mealtimeyum.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	; FoodBlackBriarMeadyum "Black-Briar Mead Goblet" ALCH:0x0004C740]
	ClearAndAddModFood(0x00051846, "mealtimeyum.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	; foodDragonBridgeMeadyum "Dragon's Breath Mead Goblet" ALCH:0x00051846]
	ClearAndAddModFood(0x00051848, "mealtimeyum.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	; FoodBlackBriarMeadPrivateReserveyum "Black-Briar Reserve Goblet" ALCH:0x00051848]
	ClearAndAddModFood(0x0005184A, "mealtimeyum.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	; FoodHonningbrewMeadyum "Honningbrew Mead Goblet" ALCH:0x0005184A]
	ClearAndAddModFood(0x0005184C, "mealtimeyum.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	; FoodMeadyum "Nord Mead Goblet" ALCH:0x0005184C]
	ClearAndAddModFood(0x00051853, "mealtimeyum.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	; foodDLC2FoodAshfireMeadyum "Ashfire Mead Goblet" ALCH:0x00051853]
	ClearAndAddModFood(0x00051858, "mealtimeyum.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	; FoodSolitudeSpicedWineyum "Spiced Wine Goblet" ALCH:0x00051858]
	ClearAndAddModFood(0x00051865, "mealtimeyum.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	; foodAleyum "Ale Goblet" ALCH:0x00051865]
	ClearAndAddModFood(0x00051867, "mealtimeyum.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	; foodAleWhiterunQuestyum "Argonian Ale Goblet" ALCH:0x00051867]
	ClearAndAddModFood(0x0000659C, "mealtimeyum.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	; mulledcideryum "Mulled Cider" ALCH:0x0000659C]
	initialiseWaterBottles_Mod(0x0000659C, "mealtimeyum.esp")
	ClearAndAddModFood(0x00051844, "mealtimeyum.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicAle) 	; FoodMQ101JuniperMeadDyum "Mead with Juniper Berry" ALCH:0x00051844]
	initialiseWaterBottles_Mod(0x00051844, "mealtimeyum.esp")
	
	; Alcohol - Wine
	ClearAndAddModFood(0x0005185A, "mealtimeyum.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicWine) 	; FoodWineAltoyum "Alto Wine Goblet" ALCH:0x0005185A]
	ClearAndAddModFood(0x0005185C, "mealtimeyum.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicWine) 	; FoodWineBottleyum "Wine Goblet" ALCH:0x0005185C]
	ClearAndAddModFood(0x0005BA7E, "mealtimeyum.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicWine) 	; FirebrandWineyum "Firebrand Wine Goblet" ALCH:0x0005BA7E]
	
	; Alcohol - Spirits
	ClearAndAddModFood(0x00051856, "mealtimeyum.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicSpirit) 	; foodFavorSorexRumyum "Stros M'Kai Rum Goblet" ALCH:0x00051856]
	ClearAndAddModFood(0x0005185E, "mealtimeyum.esp", _Seed_DrinkAlcoholic, _Seed_DrinkAlcoholicSpirit) 	; foodMQ201Drinkyum "Brandy Goblet" ALCH:0x0005185E]
	
	_Seed_ImportMealtime_Done.show()
endfunction

function AddModMultiPartFood_Array(int WholeFoodID, String WholeFoodESP, int ResultFoodID, String ResultFoodESP, int quantity)
	Potion akWholeFood = Game.GetFormFromFile(WholeFoodID, WholeFoodESP) as Potion
	Potion akResultFood = Game.GetFormFromFile(ResultFoodID, ResultFoodESP) as Potion
	
	AddMultiPartFood_Array(akWholeFood, akResultFood, quantity)
endFunction


function initialiseWaterBottles_Bruma()
	initialiseWaterBottles_Mod(0x0005F073, "BSHeartland.esm")	; CYRAle "Ale" [ALCH:0x0005F073]
	initialiseWaterBottles_Mod(0x0005F06B, "BSHeartland.esm")	; CYRFoodApplewatchCider "Applewatch Cider" [ALCH:0x0005F06B]
	
	initialiseWaterBottles_Mod(0x0005F069, "BSHeartland.esm")	; CYRFoodBeer "Beer" [ALCH:0x0005F069]
	initialiseWaterBottles_Mod(0x0005F06F, "BSHeartland.esm")	; CYRFoodGreenwoodMead "Greenwood Mead" [ALCH:0x0005F06F]
	initialiseWaterBottles_Mod(0x0005F068, "BSHeartland.esm")	; CYRFoodMead "Mead" [ALCH:0x0005F068]

	initialiseWaterBottles_Mod(0x0005F065, "BSHeartland.esm")	; CYRFoodCheapWine01 "Cheap Wine" [ALCH:0x0005F065]
	initialiseWaterBottles_Mod(0x0005F067, "BSHeartland.esm")	; CYRFoodCheapWine02 "Cheap Wine" [ALCH:0x0005F067]
	initialiseWaterBottles_Mod(0x00062715, "BSHeartland.esm")	; CYRFoodShadowbanishWine "Shadowbanish Wine" [ALCH:0x00062715]
	initialiseWaterBottles_Mod(0x00062716, "BSHeartland.esm")	; CYRFoodColovianBattlecry "Colovian Battlecry" [ALCH:0x00062716]

	initialiseWaterBottles_Mod(0x000858EF, "BSHeartland.esm")	; CYRFoodBrandyBottle01A "Brandy" [ALCH:0x000858EF]
	initialiseWaterBottles_Mod(0x000DF0DB, "BSHeartland.esm")	; CYRFoodBrandyBottle02 "Brandy Flask" [ALCH:0x000DF0DB]	
	
	initialiseWaterBottles_Mod(0x00602B1A, "BSAssets.esm")		; BSKBYOHFoodWineBottle03_PROXY_HF "Surilie Brothers Wine" [ALCH:0x00602B1A]
	initialiseWaterBottles_Mod(0x00602B19, "BSAssets.esm")		; BSKBYOHFoodWineBottle04_PROXY_HF "Argonian Bloodwine" [ALCH:0x00602B19]   
	initialiseWaterBottles_Mod(0x0005F072, "BSAssets.esm")		; CYRFlin "Flin" [ALCH:0x0005F072]
endFunction

function initialiseWaterBottles_Hunterborn()
	initialiseWaterBottles_Mod(0X00240CD0, "Hunterborn.esp")	;_DS_Potn_Wine_Diseased "Poisoned Wine" [ALCH:0X00240CD0]
	initialiseWaterBottles_Mod(0X00240CDD, "Hunterborn.esp")	;_DS_Potn_Wine_Fine "Fine Wine" [ALCH:0X00240CDD]
	initialiseWaterBottles_Mod(0X00240CDB, "Hunterborn.esp")	;_DS_Potn_Wine_Spoiled "Spoiled Wine" [ALCH:0X00240CDB]
endfunction

function initialiseWaterBottles_Apothecary()
	initialiseWaterBottles_Mod(0X0006C685, "ApothecaryFood.esp")	; MAG_DrinkSpicedRum "Spiced Rum" [ALCH:0X0006C685]	
	initialiseWaterBottles_Mod(0X0006C686, "ApothecaryFood.esp")	; MAG_DrinkWrothgarianRum "Wrothgarian Rum" [ALCH:0X0006C686]	
	initialiseWaterBottles_Mod(0X0006C68, "ApothecaryFood.esp")		; MAG_DrinkCyrodilicWhiskey "Cyrodilic Whiskey" [ALCH:0X0006C68	
	initialiseWaterBottles_Mod(0X0006C68A, "ApothecaryFood.esp")	; MAG_DrinkRedEaglesRye "Red Eagle's Rye" [ALCH:0X0006C68A]	
	initialiseWaterBottles_Mod(0X0006C68C, "ApothecaryFood.esp")	; MAG_DrinkCyrodilicBrandy "Cyrodilic Brandy" [ALCH:0X0006C68C]	
endfunction

function initialiseWaterBottles_Requiem()
	initialiseWaterBottles_Mod(0x0003DFE8, "Requiem.esp")	;REQ_Food_Water "Bottled Water" [ALCH:0x0003DFE8]
	initialiseWaterBottles_Mod(0x00AD3910, "Requiem.esp")	;REQ_Drink_CinnabarBeer "Cinnabar Beer" [ALCH:0x00AD3910]
endfunction

function initialiseWaterBottles_CRF()
	initialiseWaterBottles_Mod(0x00037108, "Cutting Room Floor.esp.esp")	;CRFFoodFrostRiverMead "Frost River Mead" [ALCH:0x00037108]
endfunction

function initialiseWaterBottles_CCFishing()
	initialiseWaterBottles_Mod(0x00000C2D, "ccBGSSSE001-Fish.esm")	; ccBGSSSE001_MiscKhajiit_AgedFlin "Aged Flin" [ALCH:0x00000C2D]
endfunction


function initialiseWaterBottles_Mod(int aiFormID, String espName, potion replace = none)
	Potion theDrink = Game.GetFormFromFile(aiFormID, espName) as Potion	
	if(theDrink)
	AddMultiPartFood_Array(theDrink, _Seed_WaterBottleEmpty, 1)
		if(replace)
			RemoveMultiPartFood_Array(replace)
		endif
	endif
endFunction


function InitializeArrays()
	multiFoodList_WholeFood = new Potion[128]
	multiFoodList_WholeFood_2 = new Potion[128]
	multiFoodList_WholeFood_3 = new Potion[128]
	multiFoodList_WholeFood_4 = new Potion[128]
	multiFoodList_ResultFood = new Potion[128]
	multiFoodList_ResultFood_2 = new Potion[128]
	multiFoodList_ResultFood_3 = new Potion[128]
	multiFoodList_ResultFood_4 = new Potion[128]
	multiFoodList_Quantity = new int[128]
	multiFoodList_Quantity_2 = new int[128]
	multiFoodList_Quantity_3 = new int[128]
	multiFoodList_Quantity_4 = new int[128]
	
	;/
	multiFoodList = new String[128]
	multiPartFoodData1 = new Potion[128]
	multiPartFoodData2 = new Potion[128]
	multiPartFoodData3 = new Potion[128]
	multiPartFoodData4 = new Potion[128]
	multiPartFoodData5 = new Potion[128]
	multiPartFoodData6 = new Potion[128]
	multiPartFoodData7 = new Potion[128]
	multiPartFoodData8 = new Potion[128]

	
	Quantities = new Potion[20]
	Quantities[0] = _Seed_Quantity01
	Quantities[1] = _Seed_Quantity02
	Quantities[2] = _Seed_Quantity03
	Quantities[3] = _Seed_Quantity04
	Quantities[4] = _Seed_Quantity05
	Quantities[5] = _Seed_Quantity06
	Quantities[6] = _Seed_Quantity07
	Quantities[7] = _Seed_Quantity08
	Quantities[8] = _Seed_Quantity09
	Quantities[9] = _Seed_Quantity10
	Quantities[10] = _Seed_Quantity11
	Quantities[11] = _Seed_Quantity12
	Quantities[12] = _Seed_Quantity13
	Quantities[13] = _Seed_Quantity14
	Quantities[14] = _Seed_Quantity15
	Quantities[15] = _Seed_Quantity16
	Quantities[16] = _Seed_Quantity17
	Quantities[17] = _Seed_Quantity18
	Quantities[18] = _Seed_Quantity19
	Quantities[19] = _Seed_Quantity20
	/;
	
	foodLists = new FormList[19]
	foodLists[0] = _Seed_Bread
	foodLists[1] = _Seed_MeatRaw
	foodLists[2] = _Seed_MeatCooked
	foodLists[3] = _Seed_SmallGameRaw
	foodLists[4] = _Seed_SmallGameCooked
	foodLists[5] = _Seed_FishRaw
	foodLists[6] = _Seed_FishCooked
	foodLists[7] = _Seed_SeafoodRaw
	foodLists[8] = _Seed_SeafoodCooked
	foodLists[9] = _Seed_Vegetables
	foodLists[10] = _Seed_Fruit
	foodLists[11] = _Seed_Cheese
	foodLists[12] = _Seed_Treats
	foodLists[13] = _Seed_Pastries
	foodLists[14] = _Seed_Stews
	foodLists[15] = _Seed_CheeseBowls
	foodLists[16] = _Seed_DrinkMilk
	foodLists[17] = _Seed_DrinkAlcoholic
	foodLists[18] = _Seed_DrinkNonAlcoholic
	
	foodRestoreAmount = new FormList[4]
	foodRestoreAmount[0] = _Seed_Food_RestoreHungerMinor
	foodRestoreAmount[1] = _Seed_Food_RestoreHungerMajor
	foodRestoreAmount[2] = _Seed_Food_RestoreHungerSuperior
	foodRestoreAmount[3] = _Seed_Food_RestoreHungerMassive	
	
	AlcoholType = new FormList[5]
	AlcoholType[0] = _Seed_DrinkAlcoholicAle
	AlcoholType[1] = _Seed_DrinkAlcoholicWine
	AlcoholType[2] = _Seed_DrinkAlcoholicSpirit
	AlcoholType[3] = _Seed_DrinkSkoomaWeak
	AlcoholType[4] = _Seed_DrinkSkoomaStrong

	spoiledVersions = new Potion[19]
	spoiledVersions[0] = _Seed_Spoiled_Bread
	spoiledVersions[1] = _Seed_Spoiled_MeatRaw
	spoiledVersions[2] = _Seed_Spoiled_MeatCooked
	spoiledVersions[3] = _Seed_Spoiled_SmallGameRaw
	spoiledVersions[4] = _Seed_Spoiled_SmallGameCooked
	spoiledVersions[5] = _Seed_Spoiled_FishRaw
	spoiledVersions[6] = _Seed_Spoiled_FishCooked
	spoiledVersions[7] = _Seed_Spoiled_SeafoodRaw
	spoiledVersions[8] = _Seed_Spoiled_SeafoodCooked
	spoiledVersions[9] = _Seed_Spoiled_Vegetable
	spoiledVersions[10] = _Seed_Spoiled_Fruit
	spoiledVersions[11] = _Seed_Spoiled_Cheese
	spoiledVersions[12] = _Seed_Spoiled_Treat
	spoiledVersions[13] = _Seed_Spoiled_Pastry
	spoiledVersions[14] = _Seed_Spoiled_Stew
	spoiledVersions[15] = _Seed_Spoiled_CheeseBowl
	spoiledVersions[16] = _Seed_Spoiled_Milk
	spoiledVersions[17] = None
	spoiledVersions[18] = None
endFunction

;/
	Public Functions
/;

int function GetFoodMaxPerishDurationByType(int aiFoodType)
    if aiFoodType < 1 || aiFoodType > 17
        return -1
    endif

	int t = aiFoodType
	; Bread
	if t == 1
		return _Seed_Setting_SpoilRate01_Bread.getValueInt()
	; Raw meat
	elseif t == 2
		return _Seed_Setting_SpoilRate02_RawMeat.getValueInt()
	; Cooked meat
	elseif t == 3
		return _Seed_Setting_SpoilRate03_CookedMeat.getValueInt()
	; Raw Small Game
	elseif t == 4
		return _Seed_Setting_SpoilRate04_RawSmallGame.getValueInt()
	; Cooked Small Game
	elseif t == 5
		return _Seed_Setting_SpoilRate05_CookedSmallGame.getValueInt()
	; Raw Fish
	elseif t == 6
		return _Seed_Setting_SpoilRate06_RawFish.getValueInt()
	; Cooked Fish
	elseif t == 7
		return _Seed_Setting_SpoilRate07_CookedFish.getValueInt()
	; Raw Seafood
	elseif t == 8
		return _Seed_Setting_SpoilRate08_RawSeafood.getValueInt()
	; Cooked Seafood
	elseif t == 9
		return _Seed_Setting_SpoilRate09_CookedSeafood.getValueInt()
	; Vegitables
	elseif t == 10
		return _Seed_Setting_SpoilRate10_Vegitables.getValueInt()
	; Fruit
	elseif t == 11
		return _Seed_Setting_SpoilRate11_Fruit.getValueInt()
	; Cheese
	elseif t == 12
		return _Seed_Setting_SpoilRate12_Cheese.getValueInt()
	; Treats
	elseif t == 13
		return _Seed_Setting_SpoilRate13_Treats.getValueInt()
	; Pastry
	elseif t == 14
		return _Seed_Setting_SpoilRate14_Pastry.getValueInt()
	; Stew
	elseif t == 15
		return _Seed_Setting_SpoilRate15_Stew.getValueInt()
	; Cheese bowls
	elseif t == 16
		return _Seed_Setting_SpoilRate16_CheeseBowls.getValueInt()
	; Milk
	elseif t == 17
		return _Seed_Setting_SpoilRate17_Milk.getValueInt()
	endif
	
    return -1
endFunction

;NOTE: THis function is replicated in Alias Food MOnitor
formList function getFoodList(int foodId)
	; Drinks
	if foodId == 18
		return _Seed_DrinkAlcoholic
	elseif foodId == 19
		return _Seed_DrinkNonAlcoholic
	; Cooked Food
	elseif foodId == 1
		return _Seed_Bread
	elseif foodId == 3
		return _Seed_MeatCooked
	elseif foodId == 5
		return _Seed_SmallGameCooked
	elseif foodId == 7
		return _Seed_FishCooked
	elseif foodId == 9
		return _Seed_SeafoodCooked
	elseif foodId == 12
		return _Seed_Cheese
	elseif foodId == 13
		return _Seed_Treats
	elseif foodId == 14
		return _Seed_Pastries
	elseif foodId == 16
		return _Seed_CheeseBowls
	elseif foodId == 17
		return _Seed_DrinkMilk
	
	; RAW FOOD
	elseif foodId == 10
		return _Seed_Vegetables
	elseif foodId == 11
		return _Seed_Fruit
	elseif foodId == 2
		return _Seed_MeatRaw
	elseif foodId == 4
		return _Seed_SmallGameRaw
	elseif foodId == 6
		return _Seed_FishRaw
	elseif foodId == 8
		return _Seed_SeafoodRaw
		
	; STEWS
	elseif foodId == 15
		return _Seed_Stews
	endIf
	
	
	;FAIL
	return none
;/
	if foodId >= 1 && foodId <= 19
		return foodLists[foodId - 1]
	else
		return none
	endif
	/;
endFunction

int function IdentifyFood(Potion food)
	;PO3
	;/
	if food.hasKeyword(_Seed_PO3_Detection)
		; DRINKS
		if food.hasKeyword(_Seed_PO3_Detection_DrinkNonAlcoholic)
			return 19
		elseif food.hasKeyword(_Seed_PO3_Detection_DrinkAlcoholic)
			return 18
		
		; COOKED FOOD
		elseif food.hasKeyword(_Seed_PO3_Detection_Bread)
			return 1
		elseif food.hasKeyword(_Seed_PO3_Detection_Cheese)
			return 12
		elseif food.hasKeyword(_Seed_PO3_Detection_Stews)
			return 15
		elseif food.hasKeyword(_Seed_PO3_Detection_MeatCooked)
			return 3
		elseif food.hasKeyword(_Seed_PO3_Detection_SmallGameCooked)
			return 5
		elseif food.hasKeyword(_Seed_PO3_Detection_FishCooked)
			return 7
		elseif food.hasKeyword(_Seed_PO3_Detection_SeafoodCooked)
			return 9
		elseif food.hasKeyword(_Seed_PO3_Detection_Treats)
			return 13
		elseif food.hasKeyword(_Seed_PO3_Detection_Pastries)
			return 14
		elseif food.hasKeyword(_Seed_PO3_Detection_CheeseBowls)
			return 16
		elseif food.hasKeyword(_Seed_PO3_Detection_DrinkMilk)
			return 17
		
		;RAW FOOD
		elseif food.hasKeyword(_Seed_PO3_Detection_Vegetables)
			return 10
		elseif food.hasKeyword(_Seed_PO3_Detection_Fruit)

			return 11
		elseif food.hasKeyword(_Seed_PO3_Detection_MeatRaw)

			return 2
		elseif food.hasKeyword(_Seed_PO3_Detection_SmallGameRaw)
			return 4
		elseif food.hasKeyword(_Seed_PO3_Detection_FishRaw)
			return 6
		elseif food.hasKeyword(_Seed_PO3_Detection_SeafoodRaw)
			return 8	
		endif
	endif
	/;
	;Non-PO3
	; DRINKS
	if _Seed_DrinkNonAlcoholic.HasForm(food)
		return 19
	elseif _Seed_DrinkAlcoholic.HasForm(food)
		return 18
	
	; COOKED FOOD
	elseif _Seed_Bread.HasForm(food)
		return 1
	elseif _Seed_Cheese.HasForm(food)
		return 12
	elseif _Seed_Stews.HasForm(food)
		return 15
	elseif _Seed_MeatCooked.HasForm(food)
		return 3
	elseif _Seed_SmallGameCooked.HasForm(food)
		return 5
	elseif _Seed_FishCooked.HasForm(food)
		return 7
	elseif _Seed_SeafoodCooked.HasForm(food)
		return 9
	elseif _Seed_Treats.HasForm(food)
		return 13
	elseif _Seed_Pastries.HasForm(food)
		return 14
	elseif _Seed_CheeseBowls.HasForm(food)
		return 16
	elseif _Seed_DrinkMilk.HasForm(food)
		return 17
	
	;RAW FOOD
	elseif _Seed_Vegetables.HasForm(food)
		return 10
	elseif _Seed_Fruit.HasForm(food)
		return 11
	elseif _Seed_MeatRaw.HasForm(food)
		return 2
	elseif _Seed_SmallGameRaw.HasForm(food)
		return 4
	elseif _Seed_FishRaw.HasForm(food)
		return 6
	elseif _Seed_SeafoodRaw.HasForm(food)
		return 8
	; HUNTERBORN SOUPS AND STEWS
	elseIf seedUtil.GetCompatibilitySystem().isHunterbornSoupsLoaded
		keyword Soup = Game.GetFormFromFile(0x0028CD32, "Hunterborn - Soups and Stews.esp") as keyword				; _DS_KW_Food_Soup [KYWD:0x0028CD32]
		If food.HasKeyword(Soup)
			return 15
		endIf
	endif	
	

	;FAIL
	return 0

	;@TODO: Check keywords first

	; Return values:
	;	0: Not found
	;	n: Food Type (see Food IDs)


	;TODO: Remove this
;/	
	int i = 0
	while i < foodLists.Length
		if foodLists[i].HasForm(food)
			return i + 1
		else
			i += 1
		endif
	endWhile
	return 0
	/;
endFunction

float Function getFoodRestoreAmount(form theFood)
	;PO3 Detection
	;/
	if theFood.hasKeyword(_Seed_PO3_Detection)
		if theFood.hasKeyword(_Seed_PO3_Detection_HungerLight)
			return _Seed_RestoreHungerMinorAmount.GetValue()
		elseif theFood.hasKeyword(_Seed_PO3_Detection_HungerMedium)
			return _Seed_RestoreHungerMajorAmount.GetValue()
		elseif theFood.hasKeyword(_Seed_PO3_Detection_HungerFilling)
			return _Seed_RestoreHungerSuperiorAmount.GetValue()	
		elseif theFood.hasKeyword(_Seed_PO3_Detection_HungerHearty)
			return _Seed_RestoreHungerMassiveAmount.GetValue()
		endif
	endif
	/;

	If _Seed_Food_RestoreHungerMinor.HasForm(theFood)
		return _Seed_RestoreHungerMinorAmount.GetValue()
	elseif _Seed_Food_RestoreHungerMajor.HasForm(theFood)
		return _Seed_RestoreHungerMajorAmount.GetValue()
	elseif _Seed_Food_RestoreHungerSuperior.HasForm(theFood)
		return _Seed_RestoreHungerSuperiorAmount.GetValue()
	elseif _Seed_Food_RestoreHungerMassive.HasForm(theFood)
		return _Seed_RestoreHungerMassiveAmount.GetValue()
	ElseIf seedUtil.GetCompatibilitySystem().isHunterbornSoupsLoaded
		keyword Soup = Game.GetFormFromFile(0x0028CD32, "Hunterborn - Soups and Stews.esp") as keyword				; _DS_KW_Food_Soup [KYWD:0x0028CD32]
		If theFood.HasKeyword(Soup)
			keyword Has1Vege = Game.GetFormFromFile(0x002B04C3, "Hunterborn - Soups and Stews.esp") as keyword		; _DS_KW_Food_Soup_Has1Vege [KYWD:0x002B04C3]
			keyword Has2Vege = Game.GetFormFromFile(0x002B04C4, "Hunterborn - Soups and Stews.esp") as keyword		; _DS_KW_Food_Soup_Has2Vege [KYWD:0x002B04C4]
			keyword HasMeat = Game.GetFormFromFile(0x002B04C5, "Hunterborn - Soups and Stews.esp") as keyword		; _DS_KW_Food_Soup_HasMeat [KYWD:0x002B04C5]
			keyword HasMushroom = Game.GetFormFromFile(0x002B04C6, "Hunterborn - Soups and Stews.esp") as keyword	; _DS_KW_Food_Soup_HasMushroom [KYWD:0x002B04C6]
			;keyword HasSeason = Game.GetFormFromFile(0x002B04C7, "Hunterborn - Soups and Stews.esp") as keyword	; _DS_KW_Food_Soup_HasSeason [KYWD:0x002B04C7]
	
			Int score = 0
			If theFood.HasKeyword(Has1Vege)
				Score = Score + 1
			Endif
			If theFood.HasKeyword(Has2Vege)
				Score = Score +2
			Endif
			If theFood.HasKeyword(HasMeat)
				Score = Score +2
			Endif
			If theFood.HasKeyword(HasMushroom)
				Score = Score + 1
			Endif
	
			If score <= 1
				return _Seed_RestoreHungerMinorAmount.GetValue()
			ElseIf score == 2
				return _Seed_RestoreHungerMajorAmount.GetValue()
			ElseIf score == 3
				return _Seed_RestoreHungerSuperiorAmount.GetValue()
			ElseIf Score >= 4
				return _Seed_RestoreHungerMassiveAmount.GetValue()
			Endif
		endIf
	endif
	return 0
EndFunction

function AddFoodIdentity(Potion food, int foodId)
	; Adds a food to a category. Uses the Food ID enum
	; as the foodId. Also removes it from any other category.

	if foodId < 1 || foodId > 19
		SeedDebug(3, "[FoodDataStoreHandler]Attempted to set food " + food + " to type " + foodId + ", which is an invalid type.")
		SeedDebug(3, "[FoodDataStoreHandler]If you are the author of the mod that used AddFoodIdentity(), check the food type in your code.")
		return
	endif

	int idx = foodId - 1
	foodLists[idx].AddForm(food)
	SeedDebug(1, "[FoodDataStoreHandler]Set food " + food + " as type " + foodId)
endFunction

function RemoveFoodIdentity(Potion food, int foodId)
	; Removes a food from a category.

	int idx = foodId - 1
	foodLists[idx].RemoveAddedForm(food)
	SeedDebug(1, "[FoodDataStoreHandler]Unset food " + food + " from type " + foodId)
endFunction

function ClearFoodIdentity(Potion food)
	;int i = IdentifyFood(food)
	int i = foodLists.length
	While i
		i = i - 1
		foodLists[i].RemoveAddedForm(food)
	endwhile
	_Seed_NotFood.RemoveAddedForm(food)
	_Seed_BloodPotions.RemoveAddedForm(food)
endfunction

; Returns whether or not the food is preserved.
;NOTE: This function is replicated in _Seed_AliasFoodMonitor
bool function IsFoodPreserved(Potion food)
;/
	if food.hasKeyword(_Seed_PO3_Detection)
		if food.hasKeyword(_Seed_PO3_Detection_Preserved)
			return true
		else
			return false
		endif
	else
	/;
		if _Seed_Preserved.HasForm(food)
			return true
		else
			return false
		endif
	;endif
endFunction

function SetFoodPreserved(Potion food, bool abIsPreserved = true)
	; Sets the preservation state of the food.

	if abIsPreserved
		_Seed_Preserved.AddForm(food)
	else
		_Seed_Preserved.RemoveAddedForm(food)
	endif
endFunction

; Returns whether or not the food is Salted.
bool function IsFoodSalted(Potion food)
	if _Seed_SaltedFood.HasForm(food)
		return true
	else
		return false
	endif
endFunction

; Sets the salted state of the food.
function SetFoodSalted(Potion food, bool abIsSalted = true)
	if abIsSalted
		_Seed_SaltedFood.AddForm(food)
	else
		_Seed_SaltedFood.RemoveAddedForm(food)
	endif
endFunction


bool function IsNotFood(Potion food)
	return _Seed_NotFood.hasForm(food)
endFunction

function SetAsNotFood(Potion food, bool notFood = true)
	; Sets the preservation state of the food.

	if notFood
		clearFoodIdentity(food)
		ClearFoodRestoreAmount(food)
		ClearAlcoholType(food)
		_Seed_NotFood.AddForm(food)
	else
		_Seed_NotFood.RemoveAddedForm(food)
	endif
endFunction

bool function isBloodPotion(Potion food)
	return _Seed_BloodPotions.hasForm(food)
endFunction

function setBloodPotion(Potion food)
	clearFoodIdentity(food)
	ClearFoodRestoreAmount(food)
	ClearAlcoholType(food)	
	_Seed_BloodPotions.AddForm(food)
endFunction

function SetFoodRestoreAmount(Potion food, int foodRestoreId)
	ClearFoodRestoreAmount(food)
	AddFoodRestoreAmount(food, foodRestoreId)
endfunction
function AddFoodRestoreAmount(Potion food, int foodRestoreId)
	int idx = foodRestoreId - 1
	foodRestoreAmount[idx].AddForm(food)
endfunction

function RemoveFoodRestoreAmount(Potion food, int foodRestoreId)
	int idx = foodRestoreId - 1
	foodRestoreAmount[idx].RemoveAddedForm(food)
endfunction

function ClearFoodRestoreAmount(Potion food)
	int i = 0
	int size = foodRestoreAmount.Length
	While i < size
		foodRestoreAmount[i].RemoveAddedForm(food)
		i = i+1
	endwhile	
endfunction

function SetAlcoholType(Potion alcohol, int foodId)
	ClearAlcoholType(alcohol)
	AddAlcoholType(alcohol, foodId)
endfunction

function AddAlcoholType(Potion alcohol, int foodId)
	int idx = foodId - 1
	AlcoholType[idx].AddForm(alcohol)
endfunction

function RemoveAlcoholType(Potion alcohol, int foodId)
	int idx = foodId - 1
	AlcoholType[idx].RemoveAddedForm(alcohol)
endfunction

function ClearAlcoholType(Potion alcohol)
	int i = AlcoholType.Length
	While i
		i = i - 1
		AlcoholType[i].RemoveAddedForm(alcohol)
	endwhile	
endfunction

bool function isKnownFood(Form akBaseItem, bool includePerished, bool includeNotFood)
	Potion theFood = akBaseItem as Potion
    return (theFood && IdentifyFood(theFood)> 0) || _Seed_BloodPotions.HasForm(theFood) || (includePerished && akBaseItem == _Seed_PerishedFood) || (includeNotFood && _Seed_NotFood.HasForm(akBaseItem))
endFunction


bool function IsFood(Form akBaseItem)
	bool result = false
	
	Potion theFood = akBaseItem as Potion
	if theFood	
		;Check if the potion is food
		if GetSKSELoaded()
			result = theFood.IsFood()
		else
			result = theFood.HasKeyword(VendorItemFood) || theFood.HasKeyword(VendorItemFoodRaw)
		endif
		
		;If the food is already known, return true
		if result == false && isKnownFood(theFood, false, true)
			result = true
		endif
	endif
	
	return result
endFunction

;NOTE: This function is replicated in _Seed_AliasFoodMonitor
Form function GetSpoiledVersion(Potion food, int aiType = -1)
	if _Seed_SpoiledFoods.HasForm(food)
		return _Seed_PerishedFood
	endif

	int typeIndex
	if aiType != -1
		typeIndex = aiType - 1
	else
		aiType = IdentifyFood(food) - 1
		if typeIndex < 0
			return None
		endif
	endif

	return spoiledVersions[typeIndex]
endFunction

potion function getQuantityPotion(int quantity)
	potion result = Quantities[quantity - 1]
	SeedDebug(0, "[FoodDataStoreHandler] Found food type for int " + 1 + " - " + result)
	return Quantities[quantity - 1]
endFunction

int function getQuantityInt(potion quantity)
	int result = Quantities.Find(quantity) + 1
	SeedDebug(0, "[FoodDataStoreHandler] Found food type for potion " + 1 + " - " + result)
	return result
endFunction


;MULTI-PART ARRAY FUNCTIONS
; Gets the result food of the given multi-part food. 
Potion Function GetMultiPartFoodResult_Array(Potion akWholeFood, bool filterWater = true)	
	SeedDebug(0, "[FoodDataStoreHandler] Searching for multipart food: " + akWholeFood)
	int index = LinkedArrayFindPotion(akWholeFood, multiFoodList_WholeFood, multiFoodList_WholeFood_2, multiFoodList_WholeFood_3, multiFoodList_WholeFood_4)	
	if(index != -1)
		potion resultFood = LinkedArrayGetPotionAt(index, multiFoodList_ResultFood, multiFoodList_ResultFood_2, multiFoodList_ResultFood_3, multiFoodList_ResultFood_4)
		if filterWater  && resultFood == _Seed_WaterBottleEmpty && !isFullWaterBottle(akWholeFood) && (_Seed_Settings_EnableWaterBottles.getValue() as int) != 2 
			return none
		endif
		return resultFood
	endif
	;/
	potion result = none
	int i = multiFoodList_WholeFood.length
	bool notFound = true
	while i > 0 && notFound
		i-=1
		if multiFoodList_WholeFood[i] == akWholeFood
			SeedDebug(0, "[FoodDataStoreHandler] Found food at slot " + i)
			result = multiFoodList_ResultFood[i]
			notFound = false
			SeedDebug(0, "[FoodDataStoreHandler] Result is " + result) 
		endif
	endWhile
	return result
/;	
endFunction

bool function isFullWaterBottle(potion akWholeFood)
	return  akWholeFood == _Seed_WaterBottle || akWholeFood == _Seed_WaterBottleClean  || akWholeFood == _Seed_WaterBottleSea || akWholeFood == _Seed_WaterBottleSnow
endFunction
; Gets the result food of the given multi-part food. If not found, returns -1.
int Function GetMultiPartFoodQuantity_Array(Potion akWholeFood)	
	SeedDebug(0, "[FoodDataStoreHandler] Searching for multipart food quantity: " + akWholeFood)
	int index = LinkedArrayFindPotion(akWholeFood, multiFoodList_WholeFood, multiFoodList_WholeFood_2, multiFoodList_WholeFood_3, multiFoodList_WholeFood_4)
	if(index != -1)	
		return LinkedArrayGetIntAt(index, multiFoodList_Quantity, multiFoodList_Quantity_2, multiFoodList_Quantity_3, multiFoodList_Quantity_4)	
	endif
	;/
	int result = 0
	int i = multiFoodList_WholeFood.length
	bool notFound = true
	while i > 0 && notFound
		i-=1
		if multiFoodList_WholeFood[i] == akWholeFood
			SeedDebug(0, "[FoodDataStoreHandler] Found food at slot " + i)
			result = multiFoodList_Quantity[i]
			notFound = false
			SeedDebug(0, "[FoodDataStoreHandler] Qualtity is " + result) 
		endif
	endWhile	
	return result
	/;
endFunction

; Removes a food record from the table, if found. 
Function RemoveMultiPartFood_Array(Potion akWholeFood)
	SeedDebug(0, "[FoodDataStoreHandler] Removing multi-part Food " + akWholeFood)	
	int index = LinkedArrayFindPotion(akWholeFood, multiFoodList_WholeFood, multiFoodList_WholeFood_2, multiFoodList_WholeFood_3, multiFoodList_WholeFood_4)
	if(index != -1)
		LinkedArrayRemovePotionAt(index, multiFoodList_WholeFood, multiFoodList_WholeFood_2, multiFoodList_WholeFood_3, multiFoodList_WholeFood_4)
		LinkedArrayRemovePotionAt(index, multiFoodList_ResultFood, multiFoodList_ResultFood_2, multiFoodList_ResultFood_3, multiFoodList_ResultFood_4)
		LinkedArrayRemoveIntAt(index, multiFoodList_Quantity, multiFoodList_Quantity_2, multiFoodList_Quantity_3, multiFoodList_Quantity_4)
	endif
	;/
	int i = multiFoodList_Quantity.length
	while i > 0
		i-=1
		if multiFoodList_WholeFood[i] == akWholeFood
			multiFoodList_WholeFood[i] = none
			multiFoodList_resultFood[i] = none
			multiFoodList_Quantity[i] = 0
		endif
	endWhile
	/;
endFunction

function RemoveModMultiPartFood_Array(int WholeFoodID, String WholeFoodESP)
	Potion akWholeFood = Game.GetFormFromFile(WholeFoodID, WholeFoodESP) as Potion
	RemoveMultiPartFood_Array(akWholeFood)
endFunction

function ReplaceModMultiPartFood_Array(int WholeFoodID, String WholeFoodESP, int ResultFoodID, String ResultFoodESP, int quantity)
	Potion akWholeFood = Game.GetFormFromFile(WholeFoodID, WholeFoodESP) as Potion
	Potion akResultFood = Game.GetFormFromFile(ResultFoodID, ResultFoodESP) as Potion
	RemoveMultiPartFood_Array(akWholeFood)
	AddMultiPartFood_Array(akWholeFood, akResultFood, quantity)
endFunction


; Adds food entries to array. If found, updates it with the supplied data.
Function AddMultiPartFood_Array(Potion akWholeFood, Potion akResultFood, int aiQuantity)
	SeedDebug(0, "[FoodDataStoreHandler] Adding Food " + akWholeFood + " -> " + akResultFood + " - " + aiQuantity)
	int index = LinkedArrayAddPotion(akWholeFood, multiFoodList_WholeFood, multiFoodList_WholeFood_2, multiFoodList_WholeFood_3, multiFoodList_WholeFood_4)
	if(index != -1)
		SeedDebug(0, "[FoodDataStoreHandler] Added multi-part food " + akWholeFood.getName() + " to index " + index)
		LinkedArrayAddPotionAt(akResultFood, index, multiFoodList_ResultFood, multiFoodList_ResultFood_2, multiFoodList_ResultFood_3, multiFoodList_ResultFood_4)
		LinkedArrayAddIntAt(aiQuantity, index, multiFoodList_Quantity, multiFoodList_Quantity_2, multiFoodList_Quantity_3, multiFoodList_Quantity_4)
	else
		SeedDebug(3, "[FoodDataStoreHandler] There are no available slots in the multi-food array")
		_Seed_ErrorNoMultiPartSlots.show()		
	endif
	;/
	int i = multiFoodList_WholeFood.length
	bool notFound = true
	while i > 0 && notFound
		i-=1
		if multiFoodList_WholeFood[i] == none
			SeedDebug(0, "[FoodDataStoreHandler] Found empty slot at " + i)
			multiFoodList_WholeFood[i] = akWholeFood
			multiFoodList_ResultFood[i] = akResultFood
			multiFoodList_Quantity[i] = aiQuantity
			notFound = false
		endif
	endWhile
	;Send warning if run out of slots
	if notFound
		SeedDebug(3, "[FoodDataStoreHandler] WARNING: There are no available slots in the multi-food array")
		_Seed_ErrorNoMultiPartSlots.show()
	endif
	/;
endFunction


Function UpdateMultiPartFood_Keyword(Potion akWholeFood, Potion akResultFood, int aiQuantity)	
	If GetMultiPartFoodResult_Array(akWholeFood, false) == none
		UpdateMultiPartFood_Array(akWholeFood, akResultFood, aiQuantity)
		PlayerRef.AddItem(akResultFood, aiQuantity)
	Endif
EndFunction

; Remove old entries and add new ones.
Function UpdateMultiPartFood_Array(Potion akWholeFood, Potion akResultFood, int aiQuantity)
	RemoveMultiPartFood_Array(akWholeFood)
	AddMultiPartFood_Array(akWholeFood, akResultFood, aiQuantity)
endFunction

;END MULTI-PART ARRAY FUNCTIONS




;NEW LINKED ARRAY METHODS
int function LinkedArrayAddPotion(Potion akPotion, Potion[] akArray1, Potion[] akArray2, Potion[] akArray3, Potion[] akArray4)
    ; Adds a form to the first available element in the first available array
	; associated with this ArrayID.

	; Return values
    ;	-1 	=	Failed (Linked array full)
    ;	n 	= 	New element index

    int idx = -1
    idx = akArray1.Find(none)
    if idx != -1
    	akArray1[idx] = akPotion
    	return idx
    endif

    idx = -1
    idx = akArray2.Find(none)
    if idx != -1
    	akArray2[idx] = akPotion
    	return idx + 128
    endif

    idx = -1
    idx = akArray3.Find(none)
    if idx != -1
    	akArray3[idx] = akPotion
    	return idx + 256
    endif

    idx = -1
    idx = akArray4.Find(none)
    if idx != -1
    	akArray4[idx] = akPotion
    	return idx + 384
    endif

    return -1
endFunction

bool function LinkedArrayAddPotionAt(Potion akPotion, int aiIndex, Potion[] akArray1, Potion[] akArray2, Potion[] akArray3, Potion[] akArray4)
    ; Adds a potion to the linked-array relative index.

	; Return values
    ; false 	=               Error (linked array full)
    ; true		=   			Success

    int idx = 0       
    if aiIndex < 128
    	idx = aiIndex
    	akArray1[idx] = akPotion
    	return true
    endif

    if aiIndex < 256
    	idx = aiIndex - 128
    	akArray2[idx] = akPotion
    	return true
    endif

    if aiIndex < 384
    	idx = aiIndex - 256
    	akArray3[idx] = akPotion
    	return true
    endif

    if aiIndex < 512
    	idx = aiIndex - 384
    	akArray4[idx] = akPotion
    	return true
    endif

    return false
endFunction

int function LinkedArrayRemovePotion(Potion akPotion, Potion[] akArray1, Potion[] akArray2, Potion[] akArray3, Potion[] akArray4)
	; Removes the first occurrence of a form from the array, if found.
	
	; Return values
    ;	-1 	=	Failed (Linked array full)
    ;	n 	= 	New element index

	int idx = -1
	idx = akArray1.Find(akPotion)
	if idx != -1
		akArray1[idx] = none
		return idx
	endif

	idx = -1
	idx = akArray2.Find(akPotion)
	if idx != -1
		akArray2[idx] = none
		return idx + 128
	endif

	idx = -1
	idx = akArray3.Find(akPotion)
	if idx != -1
		akArray3[idx] = none
		return idx + 256
	endif

	idx = -1
	idx = akArray4.Find(akPotion)
	if idx != -1
		akArray4[idx] = none
		return idx + 384
	endif

	return -1
endFunction

bool function LinkedArrayRemovePotionAt(int aiIndex, Potion[] akArray1, Potion[] akArray2, Potion[] akArray3, Potion[] akArray4)
    ; Removes a potion at the linked-array relative index.

	; Return values
    ; false 	=               Error (linked array full)
    ; true		=   			Success

    int idx = 0       
    if aiIndex < 128
    	idx = aiIndex
    	akArray1[idx] = None
    	return true
    endif

    if aiIndex < 256
    	idx = aiIndex - 128
    	akArray2[idx] = None
    	return true
    endif

    if aiIndex < 384
    	idx = aiIndex - 256
    	akArray3[idx] = None
    	return true
    endif

    if aiIndex < 512
    	idx = aiIndex - 384
    	akArray4[idx] = None
    	return true
    endif

    return false
endFunction

int function LinkedArrayFindPotion(Potion akPotion, Potion[] akArray1, Potion[] akArray2, Potion[] akArray3, Potion[] akArray4)
	; Attempts to find the given potion in the associated array ID, and returns the index (relative to the linked array) if found.
	
	; Return values
	; -1	=	akPotion not found
	; n 	= 	akPotion index

	int idx = -1
	idx = akArray1.Find(akPotion)
	if idx != -1
		return idx
	endif
	idx = akArray2.Find(akPotion)
	if idx != -1
		return idx + 128
	endif
	idx = akArray3.Find(akPotion)
	if idx != -1
		return idx + 256
	endif
	idx = akArray4.Find(akPotion)
	if idx != -1
		return idx + 384
	endif

	return -1
endFunction

Potion function LinkedArrayGetPotionAt(int aiIndex, Potion[] akArray1, Potion[] akArray2, Potion[] akArray3, Potion[] akArray4)
	; Attempts to retrieve the potion at the supplied linked-array relative index. Returns None if aiIndex is out of bounds.	

	int idx = aiIndex
	if aiIndex < 128
		return akArray1[idx]
	elseif aiIndex < 256
		idx -= 128
		return akArray2[idx]
	elseif aiIndex < 384
		idx -= 256
		return akArray3[idx]
	elseif aiIndex < 512
		idx -= 384
		return akArray4[idx]
	endif

	return None
endFunction

bool function LinkedArrayAddIntAt(Int akInt, int aiIndex, Int[] akArray1, Int[] akArray2, Int[] akArray3, Int[] akArray4)
    ; Adds a potion to the linked-array relative index.

	; Return values
    ; false 	=               Error (linked array full)
    ; true		=   			Success

    int idx = 0       
    if aiIndex < 128
    	idx = aiIndex
    	akArray1[idx] = akInt
    	return true
    endif

    if aiIndex < 256
    	idx = aiIndex - 128
    	akArray2[idx] = akInt
    	return true
    endif

    if aiIndex < 384
    	idx = aiIndex - 256
    	akArray3[idx] = akInt
    	return true
    endif

    if aiIndex < 512
    	idx = aiIndex - 384
    	akArray4[idx] = akInt
    	return true
    endif

    return false
endFunction

bool function LinkedArrayRemoveIntAt(int aiIndex, Int[] akArray1, Int[] akArray2, Int[] akArray3, Int[] akArray4)
    ; Removes a potion at the linked-array relative index.

	; Return values
    ; false 	=               Error (linked array full)
    ; true		=   			Success

    int idx = 0       
    if aiIndex < 128
    	idx = aiIndex
    	akArray1[idx] = 0
    	return true
    endif

    if aiIndex < 256
    	idx = aiIndex - 128
    	akArray2[idx] = 0
    	return true
    endif

    if aiIndex < 384
    	idx = aiIndex - 256
    	akArray3[idx] = 0
    	return true
    endif

    if aiIndex < 512
    	idx = aiIndex - 384
    	akArray4[idx] = 0
    	return true
    endif

    return false
endFunction

int function LinkedArrayFindInt(Int akInt, Int[] akArray1, Int[] akArray2, Int[] akArray3, Int[] akArray4, \
								    			    Int[] akArray5, Int[] akArray6, Int[] akArray7, Int[] akArray8, bool abSort = true)
	; Attempts to find the given potion in the associated array ID, and returns the index (relative to the linked array) if found.
	
	; Return values
	; -1	=	akInt not found
	; n 	= 	akInt index

	int idx = -1
	idx = akArray1.Find(akInt)
	if idx != -1
		return idx
	endif
	idx = akArray2.Find(akInt)
	if idx != -1
		return idx + 128
	endif
	idx = akArray3.Find(akInt)
	if idx != -1
		return idx + 256
	endif
	idx = akArray4.Find(akInt)
	if idx != -1
		return idx + 384
	endif

	return -1
endFunction

Int function LinkedArrayGetIntAt(int aiIndex, Int[] akArray1, Int[] akArray2, Int[] akArray3, Int[] akArray4)
	; Attempts to retrieve the Int at the supplied linked-array relative index. Returns None if aiIndex is out of bounds.	

	int idx = aiIndex
	if aiIndex < 128
		return akArray1[idx]
	elseif aiIndex < 256
		idx -= 128
		return akArray2[idx]
	elseif aiIndex < 384
		idx -= 256
		return akArray3[idx]
	elseif aiIndex < 512
		idx -= 384
		return akArray4[idx]
	endif
	return -1
endFunction


function AddHunterbornSoups(bool checkRequired = true)

endFunction