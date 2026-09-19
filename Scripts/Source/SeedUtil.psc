scriptname SeedUtil hidden

LastSeedAPI function GetAPI() global
    return (Game.GetFormFromFile(0x0000B16A, "LastSeed.esp") as Quest) as LastSeedAPI
endFunction

; Public Enums ====================================================================================

; Food ID
int property FOODTYPE_BREAD             = 1     autoReadOnly
int property FOODTYPE_MEAT_RAW          = 2     autoReadOnly
int property FOODTYPE_MEAT_COOKED       = 3     autoReadOnly
int property FOODTYPE_SMALLGAME_RAW     = 4     autoReadOnly
int property FOODTYPE_SMALLGAME_COOKED  = 5     autoReadOnly
int property FOODTYPE_FISH_RAW          = 6     autoReadOnly
int property FOODTYPE_FISH_COOKED       = 7     autoReadOnly
int property FOODTYPE_SEAFOOD_RAW       = 8     autoReadOnly
int property FOODTYPE_SEAFOOD_COOKED    = 9     autoReadOnly
int property FOODTYPE_VEGETABLE         = 10    autoReadOnly
int property FOODTYPE_FRUIT             = 11    autoReadOnly
int property FOODTYPE_CHEESE            = 12    autoReadOnly
int property FOODTYPE_TREAT             = 13    autoReadOnly
int property FOODTYPE_PASTRY            = 14    autoReadOnly
int property FOODTYPE_STEW              = 15    autoReadOnly
int property FOODTYPE_CHEESEBOWL        = 16    autoReadOnly
int property DRINKTYPE_MILK             = 17    autoReadOnly
int property DRINKTYPE_ALCOHOLIC        = 18    autoReadOnly
int property DRINKTYPE_NONALCOHOLIC     = 19    autoReadOnly

; System Access ===================================================================================

; These are not intended for public use and are therefore undocumented.

_Seed_Main function getMainSystem() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.Main
endFunction

_Seed_SkillTreeHandler function getSkillTreeHandler() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.SkillTree
endFunction

_Seed_DiseaseManager function GetDiseaseSystem() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.Disease
endFunction

_Seed_VitalitySystem function GetVitalitySystem() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.Vitality
endFunction

_Seed_HungerSystem function GetHungerSystem() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.Hunger
endFunction

_Seed_HungerSystem_Party function GetPartyHungerSystem() global
	LastSeedAPI LastSeed = GetAPI()
	if LastSeed == none
    	RaiseSeedAPIError()
    	return none
	endif
	return LastSeed.HungerParty
endFunction

_Seed_ThirstSystem_Party function GetPartyThirstSystem() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.ThirstParty
endFunction



_Seed_ThirstSystem function GetThirstSystem() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.Thirst
endFunction

_Seed_FatigueSystem function GetFatigueSystem() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.Fatigue
endFunction

_Seed_SpoilSystem function GetSpoilageSystem() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.Spoil
endFunction

_Seed_AlcoholSystem function GetAlcoholSystem() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.Alcohol
endFunction

_Seed_SkoomaSystem function getSkoomaSystem() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.Skooma
endFunction

_Seed_VitalityMeterInterfaceHandler function GetVitalityMeterHandler() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.VitalityMeterHandler
endFunction

_Seed_HungerMeterInterfaceHandler function GetHungerMeterHandler() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.HungerMeterHandler
endFunction
_Seed_ThirstMeterInterfaceHandler function GetThirstMeterHandler() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.ThirstMeterHandler
endFunction


_Seed_FatigueMeterInterfaceHandler function GetFatigueMeterHandler() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.FatigueMeterHandler
endFunction

_Seed_CustomiseFoodHandler function GetCustomiseFoodHandler() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.CustomiseFood
endFunction

_Seed_FoodDatastoreHandler function GetFoodDatastoreHandler() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.FoodDatastore
endFunction

_Seed_FoodMaintenanceHandler function GetFoodMaintenanceHandler() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.FoodMaintenance
endFunction

_Seed_Compatibility function GetCompatibilitySystem() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.Compatibility
endFunction

_Seed_VendorStock function GetVendorStockSystem() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.Vendor
endFunction

FallbackEventEmitter function GetEventEmitter_LastSeedLoaded() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.EventEmitter_LastSeedLoaded as FallbackEventEmitter
endFunction

FallbackEventEmitter function GetEventEmitter_OnRescuePlayer() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.EventEmitter_OnRescuePlayer as FallbackEventEmitter
endFunction


_Seed_ConsumeManager function GetConsumeManager() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
		return LastSeed.AutoConsumePlayer
endFunction

_Seed_ConsumeManager function GetConsumeManagerFollowers() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
	return LastSeed.AutoConsumeFollowers
endFunction

_Seed_ConsumeManagerParty function GetConsumeManagerParty() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
        return LastSeed.AutoConsumeParty
endFunction


_Seed_ConfigurationHandler function GetConfigurationHandler() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
	return LastSeed.Config
endFunction

_Seed_AnimationHandler function GetAnimationHandler() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
	return LastSeed.Animation
endFunction

_Seed_TranslationHandler function GetTranslationHandler() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
	return LastSeed.Translation
endFunction

_Seed_WaterHandler function GetWaterHandler() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
	return LastSeed.Water
endFunction


_Seed_DialogHandler function GetDialogHandler() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.Dialog
endFunction

_Seed_FollowerNeedsSystem function GetFollowerSystem() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.Followers
endFunction

_Seed_MonsterHandler function getMonsterHandler() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.Monster
endFunction

_Seed_RescueSystem function getRescueSystem() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.Rescue
endFunction

_Seed_ActivatorHandler function getActivatorHandler() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.Activators
endFunction

Quest function getDiseaseHitMonitor() global
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return none
    endif
    return LastSeed.HitMonitor
endFunction

; Public Functions ================================================================================

;/********f* SeedUtil/GetAPIVersion
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Get the SeedUtil API version number.
*
* SYNTAX
*/;
float function GetAPIVersion() global
;/*
* PARAMETERS
* None
*
* RETURN VALUE
* The SeedUtil API version number. This is NOT the same thing as the version number of Last Seed.
* SeedUtil's API version number will increment only when changes have been made to the API itself.
*
* EXAMPLES
float ver = SeedUtil.GetAPIVersion()
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1.0
    endif
    return LastSeed._Seed_APIVersion.GetValue()
endFunction

;/********f* SeedUtil/GetLastSeedVersion
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Get the Last Seed mod version number.
*
* SYNTAX
*/;
float function GetLastSeedVersion() global
;/*
* PARAMETERS
* None
*
* RETURN VALUE
* The Last Seed version number.
*
* EXAMPLES
float ver = SeedUtil.GetLastSeedVersion()
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1.0
    endif
    return LastSeed._Seed_LastSeedVersion.GetValue()
endFunction

;/********f* SeedUtil/isSpecialEdition
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Gets whether this is Skyrim Special Edition or not,
*
* SYNTAX
*/;
bool function isSpecialEdition() global
;/*
* PARAMETERS
* None
*
* RETURN VALUE
* If the player is running SSE.
*
* EXAMPLES
bool isSSE = SeedUtil.isSpecialEdition()
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return false
    endif
    return LastSeed._Camp_IsSpecialEdition.GetValueInt() == 2
endFunction

;/********f* SeedUtil/IsPlayerFocused
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Returns whether or not the player is 'focused' (e.g. in a dungeon or other qualifying area
* that temporarily delays needs and Vitality).
*
* SYNTAX
*/;
bool function IsPlayerFocused() global
;/*
* PARAMETERS
* None
*
* RETURN VALUE
* True if the player is focused; false otherwise.
*
* EXAMPLES
;Is the player focused?
bool isFocused = SeedUtil.IsPlayerFocused()
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return false
    endif

    if LastSeed._Seed_IsPlayerFocused.GetValueInt() == 2
        return true
    else
        return false
    endif
endFunction


;/********f* SeedUtil/IsLastSeedRunning
* API VERSION ADDED
* 2.5
*
* DESCRIPTION
* Returns true if Last Seed whether Last Seed is currently running (i.e. not deactivated).
*
* SYNTAX
*/;
bool function LastSeedIsRunning() global
;/*
* PARAMETERS
* None
*
* RETURN VALUE
* True if Last Seed is running; false otherwise.
*
* EXAMPLES
;Is the player focused?
bool isFocused = SeedUtil.IsPlayerFocused()
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return false
    endif
    return (LastSeed.LastSeedRunning.getValue() as int) == 2
endFunction

;/********f* SeedUtil/GetFoodType
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Returns this food's type, if any.
*
* SYNTAX
*/;
int function GetFoodType(Potion akFood) global
;/*
* PARAMETERS
* akFood: The form to check.
*
* RETURN VALUE
* 0:                                This item is not food, or has no known type.
* FOODTYPE_BREAD (1):               This item is Bread.
* FOODTYPE_MEAT_RAW (2):            This item is Large Meat (Raw).
* FOODTYPE_MEAT_COOKED (3):         This item is Large Meat (Cooked).
* FOODTYPE_SMALLGAME_RAW (4):       This item is Small Game (Raw).
* FOODTYPE_SMALLGAME_COOKED (5):    This item is Small Game (Cooked).
* FOODTYPE_FISH_RAW (6):            This item is Fish (Raw).
* FOODTYPE_FISH_COOKED (7):         This item is Fish (Cooked).
* FOODTYPE_SEAFOOD_RAW (8):         This item is Seafood (Raw).
* FOODTYPE_SEAFOOD_COOKED (9):      This item is Seafood (Cooked).
* FOODTYPE_VEGETABLE (10):          This item is a Vegetable.
* FOODTYPE_FRUIT (11):              This item is Fruit.
* FOODTYPE_CHEESE (12):             This item is Cheese (sliced, unpreserved).
* FOODTYPE_TREAT (13):              This item is a Treat.
* FOODTYPE_PASTRY (14):             This item is a Pastry.
* FOODTYPE_STEW (15):               This item is Stew.
* FOODTYPE_CHEESEBOWL (16):         This item is a Cheese Bowl.
* DRINKTYPE_MILK (17):              This item is Milk.
* DRINKTYPE_ALCOHOLIC (18):         This item is an Alcoholic Drink or Skooma.
* DRINKTYPE_NONALCOHOLIC (19):      This item is a Non-Alcoholic Drink.
*
* EXAMPLES
;Is the spongecake a bread, or a treat?
int result = SeedUtil.GetFoodType(cake)
if result == SeedUtil.FOODTYPE_BREAD
    Debug.trace("It's bread!")
elseif result == SeedUtil.FOODTYPE_TREAT
    Debug.trace("It's a treat!")
endif
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1
    endif

    return LastSeed.FoodDatastore.IdentifyFood(akFood)
endFunction


;/********f* SeedUtil/SetFoodAmount
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Sets the amount of hunger the provided food restores
*
* SYNTAX
*/;
function setFoodRestoreAmount(Potion akFood, int restoreId) global
;/*
* PARAMETERS
* akFood: The food to set the type of.
* restoreType: The food's restore type. See below.
* Minor Amount (1): 	TODO
* Major Amount (2):		TODO
* Superior Amount (3):	TODO
* Massive Amount (4):	TODO	
*
* RETURN VALUE
* None.
*
* EXAMPLES
;Set the spongecake as a to restore a minor amount
SeedUtil.SetFoodType(cake, 1)
* NOTES
* * Do not set a single food to multiple types. The system
* does not check if a food is already set as a different type.
* If the food had its type set via script previously, use
* SeedUtil.unsetFoodRestoreAmount() first, and then set the new type.
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.FoodDatastore.AddFoodRestoreAmount(akFood, restoreId)
endFunction

;/********f* SeedUtil/clearFoodRestoreAmount
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Sets the amount of hunger the provided food restores
*
* SYNTAX
*/;
function clearFoodRestoreAmount(Potion akFood) global
;/*
* PARAMETERS
* akFood: The food to set the type of.
*
* RETURN VALUE
* None.
*
* EXAMPLES
;Clear the spongecake's food restore amount
SeedUtil.SetFoodType(cake)
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.FoodDatastore.ClearFoodRestoreAmount(akFood)
endFunction


;/********f* SeedUtil/UnSetFoodAmount
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Unsets the amount of hunger the provided food restores
*
* SYNTAX
*/;
function unsetFoodRestoreAmount(Potion akFood, int restoreId) global
;/*
* PARAMETERS
* akFood: The food to set the type of.
* restoreType: The food's restore type. See below.
* Minor Amount (1): 	TODO
* Major Amount (2):		TODO
* Superior Amount (3):	TODO
* Massive Amount (4):	TODO	
*
* RETURN VALUE
* None.
*
* EXAMPLES
;Unset the spongecake as a to restore a minor amount
SeedUtil.UnsetFoodType(cake, 1)
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.FoodDatastore.RemoveFoodRestoreAmount(akFood, restoreId)
endFunction




;/********f* SeedUtil/SetAlcoholAmount
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Sets the alcohol/Skooma level for the provided beverage
*
* SYNTAX
*/;
function setAlcoholAmount(Potion akFood, int alcoholId) global
;/*
* PARAMETERS
* akFood: The alcohol to set the type of.
* alcoholId: The alcohol type. See below.
* 1: Ale
* 2: Wine
* 3: Spirit
* 4: Weak Skooma
* 5: Strong Skooma
*
* RETURN VALUE
* None.
*
* EXAMPLES
;Set the Tequila to a spirit.
SeedUtil.setAlcoholAmount(Tequila, 3)
* NOTES
* * Do not set a single food to multiple types. The system
* does not check if a food is already set as a different type.
* If the food had its type set via script previously, use
* SeedUtil.unsetAlcoholAmount() first, and then set the new type.
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.FoodDatastore.AddAlcoholType(akFood, alcoholId)
endFunction

;/********f* SeedUtil/unsetAlcoholAmount
* API VERSION ADDED
* 1
*
* DESCRIPTION
* UnSets the alcohol level for the provided beverage
*
* SYNTAX
*/;
function unsetAlcoholAmount(Potion akFood, int alcoholId) global
;/*
* PARAMETERS
* akFood: The alcohol to set the type of.
* alcoholId: The alcohol type. See below.
* 1: Ale
* 2: Wine
* 3: Spirit
*
* RETURN VALUE
* None.
*
* EXAMPLES
;Set the Tequila to a spirit.
SeedUtil.setAlcoholAmount(Tequila, 3)
* NOTES
* * Do not set a single food to multiple types. The system
* does not check if a food is already set as a different type.
* If the food had its type set via script previously, use
* SeedUtil.UnsetFoodType() first, and then set the new type.
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.FoodDatastore.RemoveAlcoholType(akFood, alcoholId)
endFunction

;/********f* SeedUtil/clearAlcoholAmount
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Clears the alcohol level for the provided beverage
*
* SYNTAX
*/;
function clearAlcoholAmount(Potion akFood) global
;/*
* PARAMETERS
* akFood: The alcohol clear.
*
* RETURN VALUE
* None.
*
* EXAMPLES
;Clear the Tequila alcohol amount.
SeedUtil.clearAlcoholAmount(Tequila)
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.FoodDatastore.ClearAlcoholType(akFood)
endFunction

;/********f* SeedUtil/SetFoodType
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Sets the food's identity to the provided type.
*
* SYNTAX
*/;
function SetFoodType(Potion akFood, int aiType) global
;/*
* PARAMETERS
* akFood: The food to set the type of.
* aiType: The food's type. See below.
* FOODTYPE_BREAD (1):               This item is Bread.
* FOODTYPE_MEAT_RAW (2):            This item is Large Meat (Raw).
* FOODTYPE_MEAT_COOKED (3):         This item is Large Meat (Cooked).
* FOODTYPE_SMALLGAME_RAW (4):       This item is Small Game (Raw).
* FOODTYPE_SMALLGAME_COOKED (5):    This item is Small Game (Cooked).
* FOODTYPE_FISH_RAW (6):            This item is Fish (Raw).
* FOODTYPE_FISH_COOKED (7):         This item is Fish (Cooked).
* FOODTYPE_SEAFOOD_RAW (8):         This item is Seafood (Raw).
* FOODTYPE_SEAFOOD_COOKED (9):      This item is Seafood (Cooked).
* FOODTYPE_VEGETABLE (10):          This item is a Vegetable.
* FOODTYPE_FRUIT (11):              This item is Fruit.
* FOODTYPE_CHEESE (12):             This item is Cheese (sliced, unpreserved).
* FOODTYPE_TREAT (13):              This item is a Treat.
* FOODTYPE_PASTRY (14):             This item is a Pastry.
* FOODTYPE_STEW (15):               This item is Stew.
* FOODTYPE_CHEESEBOWL (16):         This item is a Cheese Bowl.
* DRINKTYPE_MILK (17):              This item is Milk.
* DRINKTYPE_ALCOHOLIC (18):         This item is an Alcoholic Drink.
* DRINKTYPE_NONALCOHOLIC (19):      This item is a Non-Alcoholic Drink.
*
* RETURN VALUE
* None.
*
* EXAMPLES
;Set the spongecake as a treat.
SeedUtil.SetFoodType(cake, SeedUtil.FOODTYPE_TREAT)
* NOTES
* * The type of base game food (from Skyrim and any DLC)
* cannot be set to a different value.
* * Do not set a single food to multiple types. The system
* does not check if a food is already set as a different type.
* If the food had its type set via script previously, use
* SeedUtil.UnsetFoodType() first, and then set the new type.
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.FoodDatastore.AddFoodIdentity(akFood, aiType)
endFunction

;/********f* SeedUtil/UnsetFoodType
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Unsets the food's identity from the provided type.
*
* SYNTAX
*/;
function UnsetFoodType(Potion akFood, int aiType) global
;/*
* PARAMETERS
* akFood: The food to unset the type of.
* aiType: The food's current type. See below.
* 1:    This item is Bread.
* 2:    This item is Large Meat (Raw).
* 3:    This item is Large Meat (Cooked).
* 4:    This item is Small Game (Raw).
* 5:    This item is Small Game (Cooked).
* 6:    This item is Fish (Raw).
* 7:    This item is Fish (Cooked).
* 8:    This item is Seafood (Raw).
* 9:    This item is Seafood (Cooked).
* 10:   This item is a Vegetable.
* 11:   This item is Fruit.
* 12:   This item is Cheese (sliced, unpreserved).
* 13:   This item is a Treat.
* 14:   This item is a Pastry.
* 15:   This item is Stew.
* 16:   This item is a Cheese Bowl.
* 17:   This item is Milk.
* 18:   This item is an Alcoholic Drink.
* 19:   This item is a Non-Alcoholic Drink.
*
* RETURN VALUE
* None.
*
* EXAMPLES
;Unset the spongecake as a treat.
SeedUtil.UnsetFoodType(cake, 13)
* NOTES
* The type of base game food (from Skyrim and any DLC)
* cannot be unset.
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.FoodDatastore.RemoveFoodIdentity(akFood, aiType)
endFunction

;/********f* SeedUtil/UnsetFoodType
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Unsets the food's identity from the provided type.
*
* SYNTAX
*/;
function ClearFoodType(Potion akFood) global
;/*
* PARAMETERS
* akFood: The food to clear
*
* RETURN VALUE
* None.
*
* EXAMPLES
;Clear the spongecake's food type.
SeedUtil.ClearFoodType(cake)
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.FoodDatastore.ClearFoodIdentity(akFood)
endFunction

;/********f* SeedUtil/SetNotFood
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Set whether or not a food should be explicitly ignored by last seed
*
* SYNTAX
*/;
function SetAsNotFood(Potion akFood, bool notFood = true) global
;/*
* PARAMETERS
* akFood: The food to set.
* notFood (optional): Whether or not to exclude this food. Default: True.
*
* RETURN VALUE
* None.
*
* EXAMPLES
;Set pepper to not be a food.
SeedUtil.SetAsNotFood(pepper)

;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.FoodDatastore.SetAsNotFood(akFood, notFood)
endFunction

;/********f* SeedUtil/SetBloodPotion
* API VERSION ADDED
* 4.0
*
* DESCRIPTION
* Set whether or not a food item is a blood potion
*
* SYNTAX
*/;
function setBloodPotion(Potion akFood) global
;/*
* PARAMETERS
* akFood: The food to set.
*
* RETURN VALUE
* None.
*
* EXAMPLES
;Set Vial of Blood to be recognised as a blood potion.
SeedUtil.SetAsNotFood(bloodVial)

;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.FoodDatastore.setBloodPotion(akFood)
endFunction



;/********f* SeedUtil/IsFoodPreserved
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Whether or not the food is "preserved" (does not spoil).
*
* SYNTAX
*/;
bool function IsFoodPreserved(Potion akFood) global
;/*
* PARAMETERS
* akFood: The food to check.
*
* RETURN VALUE
* True:     The food is preserved and does not spoil.
* False:    The food is not preserved and will spoil, 
*           if that setting is enabled.
*
* EXAMPLES
Debug.trace("Will the twinkie ever spoil?")
bool result = SeedUtil.IsFoodPreserved(twinkie)
if result == false
    Debug.trace("Guess not.")
endif
* NOTES
* Drinks of type Alcoholic and Non-Alcoholic always return 'true'.
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return false
    endif

    return LastSeed.FoodDatastore.IsFoodPreserved(akFood)
endFunction

;/********f* SeedUtil/SetFoodPreserved
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Set whether or not the food is preserved.
*
* SYNTAX
*/;
function SetFoodPreserved(Potion akFood, bool abIsPreserved = true) global
;/*
* PARAMETERS
* akFood: The food to set.
* abIsPreserved (optional): Whether or not the food is
*                           preserved. Default: True.
*
* RETURN VALUE
* None.
*
* EXAMPLES
;Set the spongecake to never spoil.
SeedUtil.SetFoodPreserved(cake)

;Set the waffle to spoil (if previously set to spoil).
SeedUtil.SetFoodPreserved(waffle, false)
* NOTES
* Food defaults to not being preserved; there is no need to call
* this function to mark it as "not preserved".
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.FoodDatastore.SetFoodPreserved(akFood, abIsPreserved)
endFunction

;/********f* SeedUtil/IsFoodSalted
* API VERSION ADDED
* 4.0
*
* DESCRIPTION
* Whether or not the food is "salted" (preserved and reduces thirst).
*
* SYNTAX
*/;
bool function IsFoodSalted(Potion akFood) global
;/*
* PARAMETERS
* akFood: The food to check.
*
* RETURN VALUE
* True:     The food is salted.
* False:    The food is not salted
*
* EXAMPLES
Debug.trace("Is the Jerky salted?")
bool result = SeedUtil.IsFoodPreserved(jerky)
if result == false
    Debug.trace("Guess not.")
endif
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return false
    endif

    return LastSeed.FoodDatastore.isFoodSalted(akFood)
endFunction

;/********f* SeedUtil/SetFoodSalted
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Set whether or not the food is salted.
*
* SYNTAX
*/;
function SetFoodSalted(Potion akFood, bool abIsSalted = true) global
;/*
* PARAMETERS
* akFood: The food to set.
* abIsSalted (optional): Whether or not the food is
*                           salted. Default: True.
*
* RETURN VALUE
* None.
*
* EXAMPLES
;Set the jerky to reduce thirst
SeedUtil.SetFoodSalted(jerky)
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.FoodDatastore.SetFoodSalted(akFood, abIsSalted)
endFunction

;/********f* SeedUtil/GetFoodMaxPerishDurationByType
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Whether or not the food is "preserved" (does not spoil).
*
* SYNTAX
*/;
int function GetFoodMaxPerishDurationByType(int aiFoodType) global
;/*
* PARAMETERS
* aiFoodType: The food type to check. -1 indicates an invalid type, or this food does not spoil.
*
* RETURN VALUE
* The duration (in hours) it takes this type of food to spoil to the next stage.
*
* EXAMPLES
Debug.trace("How many hours does it take raw fish to spoil?")
int result = SeedUtil.GetFoodMaxPerishDurationByType(6)
;*********/;
    
	return GetFoodDatastoreHandler().GetFoodMaxPerishDurationByType(aiFoodType)
endFunction

;/********f* SeedUtil/IsKnownFood
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Returns whether the item is a known food.
*
* SYNTAX
*/;
bool function IsKnownFood(Form akBaseItem, bool includePerished, bool includeNotFoodList) global
;/*
* PARAMETERS
* akBaseObject: The form to check.
*
* RETURN VALUE
* True if the form is a currently registered food; false otherwise.
*
* EXAMPLES
;Is the squibble something I can eat?
bool is_food = SeedUtil.IsKnownFood(squibble)
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return false
    endif
	return LastSeed.FoodDatastore.IsKnownFood(akBaseItem, includePerished, includeNotFoodList)
endFunction

;/********f* SeedUtil/IsKnownFood
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Returns whether the item is food.
*
* SYNTAX
*/;
bool function IsFood(Form akBaseItem) global
;/*
* PARAMETERS
* akBaseObject: The form to check.
*
* RETURN VALUE
* True if the form is food; false otherwise.
*
* EXAMPLES
;Is the squibble something I can eat?
bool is_food = SeedUtil.IsItemFood(squibble)
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return false
    endif
	return LastSeed.FoodDatastore.IsFood(akBaseItem)
endFunction

;/********f* SeedUtil/RestorePlayerHunger
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Restores the player's hunger by the provided amount.
*
* SYNTAX
*/;
function RestorePlayerHunger(float afAmount, float target = -1.0) global
;/*
* PARAMETERS
* afAmount: The amount to restore hunger by.
* target: The maximum level to restore hunger to.
*
* RETURN VALUE
* None.
*
* EXAMPLES
;Restore the player's hunger up to the next level.
SeedUtil.RestorePlayerHunger(20.0)
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

	LastSeed.Hunger.ChangeAttributeOverTimeIfFocussed()
	LastSeed.Hunger.DecreaseAttribute(afAmount, target)
endFunction


;/********f* SeedUtil/GetPlayerHunger
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Gets the player's current Hunger.
*
* SYNTAX
*/;
float function GetPlayerHunger() global
;/*
* PARAMETERS
* None.
*
* RETURN VALUE
* The player's current Hunger value.
*
* EXAMPLES
;How hungry is the player?
float hunger = SeedUtil.GetPlayerHunger()
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1.0
    endif

    return LastSeed.Hunger.attributeValueGlobal.GetValue()
endFunction

;/********f* SeedUtil/GetPartyHungerLevel
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Return the party's current hunger level. May be easier to use than GetPlayerHunger() if you don't
* need to know the actual hunger value.
*
* SYNTAX
*/;
int function GetPlayerHungerLevel() global
;/*
* PARAMETERS
* None
*
* RETURN VALUE
* * The party's current hunger level.
* * 0 = Well Fed
* * 1 = Satisfied
* * 2 = Hungry
* * 3 = Very Hungry
* * 4 = Ravenous
* * 5 = Starving
*
* EXAMPLES
;Is the party hungry?
float hng_level = SeedUtil.GetPlayerHungerLevel()
if hng_level >= 2
    debug.notification("Man I'm hungry!")
endif
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1
    endif

    return LastSeed._Seed_HungerLevel.GetValueInt()
endFunction


;/********f* SeedUtil/RestorePartyHunger
* API VERSION ADDED
* 1.4
*
* DESCRIPTION
* Restores the party’s hunger by the provided amount.
*
* SYNTAX
*/;
function RestorePartyHunger(float afAmount, float target = -1.0) global
;/*
* PARAMETERS
* afAmount: The amount to restore hunger by.
* target: The maximum level to restore hunger to.
*
* RETURN VALUE
* None.
*
* EXAMPLES
;Restore the party's hunger up to the next level.
SeedUtil.RestorePartyHunger(20.0)
;*********/;
	LastSeedAPI LastSeed = GetAPI()
	if LastSeed == none
    	RaiseSeedAPIError()
    	return
	endif
	afAmount = afAmount / getTrackedPartyCount() as float
	LastSeed.HungerParty.DecreaseAttribute(afAmount, target)
endFunction

;/********f* SeedUtil/GetPlayerHunger
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Gets the player's current Hunger.
*
* SYNTAX
*/;
float function GetPartyHunger() global
;/*
* PARAMETERS
* None.
*
* RETURN VALUE
* The player's current Hunger value.
*
* EXAMPLES
;How hungry is the player?
float hunger = SeedUtil.GetPlayerHunger()
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1.0
    endif

    return LastSeed.HungerParty.attributeValueGlobal.GetValue()
endFunction

;/********f* SeedUtil/RestorePartyThirst
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Restores the party's thirst by the provided amount.
*
* SYNTAX
*/;
function RestorePartyThirst(float afAmount, float target = -1.0) global
;/*
* PARAMETERS
* afAmount: The amount to restore thirst by.
* target: The maximum amount of thirst to restore
*
* RETURN VALUE
* None.
*
* EXAMPLES
;Restore the party's thirst up to the next level.
SeedUtil.RestorePartythirst(20.0)
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    afAmount = afAmount / getTrackedPartyCount() as float
    LastSeed.ThirstParty.DecreaseAttribute(afAmount, target)
endFunction

;/********f* SeedUtil/GetPartyThirst
* API VERSION ADDED
* 1.4
*
* DESCRIPTION
* Gets the party's current Thirst.
*
* SYNTAX
*/;
float function GetPartyThirst() global
;/*
* PARAMETERS
* None.
*
* RETURN VALUE
* The party's current Thirst value.
*
* EXAMPLES
;How thirsty is the party?
float thirst = SeedUtil.GetPartyThirst()
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1.0
    endif

    return LastSeed.ThirstParty.attributeValueGlobal.GetValue()
endFunction

;/********f* SeedUtil/GetPartyThirstLevel
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Return the party's current thirst level. May be easier to use than GetpartyThirst() if you don't
* need to know the actual thirst value.
*
* SYNTAX
*/;
int function GetPartyThirstLevel() global
;/*
* PARAMETERS
* None
*
* RETURN VALUE
* * The party's current thirst level.
* * 0 = Quenched
* * 1 = Refreshed
* * 2 = Thirsty
* * 3 = Very Thirsty
* * 4 = Parched
* * 5 = Dehydrated
*
* EXAMPLES
;Is the party thirsty?
float thirst_level = SeedUtil.GetPartyThirstLevel()
if thirst_level >= 2
    debug.notification("Man I'm thirsty!")
endif
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1
    endif

    return LastSeed._Seed_ThirstLevel_Party.GetValueInt()
endFunction


;/********f* SeedUtil/GetPartyHungerLevel
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Return the player's current hunger level. May be easier to use than GetPlayerHunger() if you don't
* need to know the actual hunger value.
*
* SYNTAX
*/;
int function GetPartyHungerLevel() global
;/*
* PARAMETERS
* None
*
* RETURN VALUE
* * The party's current hunger level.
* * 0 = Well Fed
* * 1 = Satisfied
* * 2 = Hungry
* * 3 = Very Hungry
* * 4 = Ravenous
* * 5 = Starving
*
* EXAMPLES
;Is the party hungry?
float hng_level = SeedUtil.GetPlayerHungerLevel()
if hng_level >= 2
    debug.notification("Man I'm hungry!")
endif
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1
    endif

    return LastSeed._Seed_HungerLevel_Party.GetValueInt()
endFunction

;/********f* SeedUtil/getTrackedPartyCount
* API VERSION ADDED
* 2.3
*
* DESCRIPTION
* Gets the current party size
*
* SYNTAX
*/;
int function getTrackedPartyCount() global
;/*
* PARAMETERS
* None
*
* RETURN VALUE
* The current number of followers in the party
*
* EXAMPLES
if SeedUtil.getTrackedPartyCount() == 0
	debug.notification("You feel lonely")
endif
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1
    endif
	return LastSeed.Followers.getPartyCount()
endFunction


;/********f* SeedUtil/RestorePlayerThirst
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Restores the player's thirst by the provided amount.
*
* SYNTAX
*/;
function RestorePlayerThirst(float afAmount, float target = -1.0) global
;/*
* PARAMETERS
* afAmount: The amount to restore thirst by.
* target: The maximum amount of thirst to restore
*
* RETURN VALUE
* None.
*
* EXAMPLES
;Restore the player's thirst up to the next level.
SeedUtil.RestorePlayerthirst(20.0)
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

	LastSeed.Thirst.ChangeAttributeOverTimeIfFocussed()
	LastSeed.Thirst.DecreaseAttribute(afAmount, target)
endFunction

;/********f* SeedUtil/RestorePlayerNeedsVampire()
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Restores the player's hunger and thirst when feeding as a vampire.
*
* SYNTAX
*/;
function VampireFeed() global
;/*
* PARAMETERS
* None
*
* RETURN VALUE
* None.
8
* NOTE: This method restores the amount stored in _Seed_RestoreHungerMassiveAmount (70)
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif
	LastSeed.Monster.vampireFeed()
endFunction


;/********f* SeedUtil/GetPlayerHungerLevel
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Return the player's current hunger level. May be easier to use than GetPlayerHunger() if you don't
* need to know the actual hunger value.
*
* SYNTAX
*/;
int function GetPlayerAlcoholLevel() global
;/*
* PARAMETERS
* None
*
* RETURN VALUE
* * The player's current hunger level.
* * 0 = Sober
* * 1 = Relaxed
* * 2 = Tipsy
* * 3 = Drunk
* * 4 = Very Drunk
* * 5 = Hungover
*
* EXAMPLES
;Is the player drunk?
float hng_level = SeedUtil.GetPlayerHungerLevel()
if hng_level >= 2
    debug.notification("Man I'm hungry!")
endif
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1
    endif

    return LastSeed._Seed_AlcoholLevel.GetValueInt()
endFunction


;/********f* SeedUtil/AlcoholConsumed
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Increases player's alcohol level.
*
* SYNTAX
*/;
function AlcoholConsumed(int type) global
;/*
* PARAMETERS
* type: The type of alcohol consumed
*
* RETURN VALUE
* None.
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.Alcohol.AlcoholConsumed(type)
endFunction


int function GetPlayerSkoomaLevel() global
;/*
* PARAMETERS
* None
*
* RETURN VALUE
* * The player's current hunger level.
* * 0 = Sober
* * 1 = Relaxed
* * 2 = Tipsy
* * 3 = Drunk
* * 4 = Very Drunk
* * 5 = Hungover
*
* EXAMPLES
;Is the player drunk?
float hng_level = SeedUtil.GetPlayerHungerLevel()
if hng_level >= 2
    debug.notification("Man I'm hungry!")
endif
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1
    endif

    return LastSeed._Seed_SkoomaLevel.GetValueInt()
endFunction
;/********f* SeedUtil/SkoomaConsumed
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Increases player's Skooma level.
*
* SYNTAX
*/;
function SkoomaConsumed(int type) global
;/*
* PARAMETERS
* type: The type of alcohol consumed
*
* RETURN VALUE
* None.
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.Skooma.SkoomaConsumed(type)
endFunction


;/********f* SeedUtil/catchRandomDisease
* 
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Adds random disease to the player
*
* SYNTAX
*/;
function catchRandomDisease(float DiseaseChance, bool includeVampirism = false) global
;/*
* PARAMETERS
* DiseaseChance: percent chance of contracting the disease
* 
*
* RETURN VALUE
* None.
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.Disease.applyRandomDisease(DiseaseChance, includeVampirism)
endFunction



;/********f* SeedUtil/applyRandomDisease
* LEGACY METHOD - NO LONGER USED
* 
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Adds random disease to the player
*
* SYNTAX
*/;
function applyRandomDisease(Int DiseaseChance) global
;/*
* PARAMETERS
* DiseaseChance: percent chance of contracting the disease
*
* RETURN VALUE
* None.
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.Disease.applyRandomDisease(DiseaseChance as float)
endFunction

;/********f* SeedUtil/getDiseaseChance
* LEGACY METHOD - NO LOGNGER USED
* 
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Gets the chance of catching a disease from a food or drink
*
* SYNTAX
*/;
int function getDiseaseChance(Form akBaseObject, Actor Target) global
;/*
* PARAMETERS
* DiseaseChance: percent chance of contracting the disease
*
* RETURN VALUE
* the chance of catching the disease, where 0 is no chance and 100 is guarenteed.
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return 0
    endif

    return LastSeed.Disease.getDiseaseChance(akBaseObject, Target) as int
endFunction


;/********f* SeedUtil/getDiseaseChanceFloat
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Gets the chance of catching a disease from a food or drink
*
* SYNTAX
*/;
float function getDiseaseChanceFloat(Form akBaseObject, Actor Target) global
;/*
* PARAMETERS
* DiseaseChance: percent chance of contracting the disease
*
* RETURN VALUE
* the chance of catching the disease, where 0 is no chance and 100 is guarenteed.
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return 0
    endif

    return LastSeed.Disease.getDiseaseChance(akBaseObject, Target)
endFunction

;/********f* SeedUtil/addCurrentDisease
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Adds a disease to the list of current diseases the player has
*
* SYNTAX
*/;
function addCurrentDisease(Spell disease, int stage) global
;/*
* PARAMETERS
* disease: the disease spell to add
* stage: the level of disease, 1 being mild and 5 being deadly
*
* RETURN VALUE
* None.
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.Disease.addCurrentDisease(disease, stage)
endFunction

;/********f* SeedUtil/removeCurrentDisease
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Removes a disease to the list of current diseases the player has
*
* SYNTAX
*/;
function removeCurrentDisease(Spell disease, int stage) global
;/*
* PARAMETERS
* disease: the disease spell to remove
* stage: the level of disease, 1 being mild and 5 being deadly
*
* RETURN VALUE
* None.
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return
    endif

    LastSeed.Disease.removeCurrentDisease(disease, stage)
endFunction

;/********f* SeedUtil/getLocationHazardLevel
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Gets the hazard level for the location the player is currently in.
*
* SYNTAX
*/;
int function getLocationHazardLevel() global
;/*
* PARAMETERS
* None
*
* RETURN VALUE
* The hazard level as an int
1: best (player homes and temples)
2: good (houses and inns)
3: average (everwhere else)
4: not confortable (giant camps, mines, farms and prison)
5: Not Good (Dungeons, cemeteries, dragon lairs, vampire lairs, werewolf lairs and Dwemer ruins)
6: Terrible (Crypts, Hagraven nests, animal dens, Dragon Priest lairs, shipwrecks, Spriggan groves and Falmer hives)
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1
    endif

    return LastSeed.Disease.getLocationHazardLevel()
endFunction

;/********f* SeedUtil/GetPlayerThirst
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Gets the player's current Thirst.
*
* SYNTAX
*/;
float function GetPlayerThirst() global
;/*
* PARAMETERS
* None.
*
* RETURN VALUE
* The player's current Thirst value.
*
* EXAMPLES
;How thirsty is the player?
float thirst = SeedUtil.GetPlayerThirst()
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1.0
    endif

    return LastSeed.Thirst.attributeValueGlobal.GetValue()
endFunction

;/********f* SeedUtil/GetPlayerThirstLevel
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Return the player's current thirst level. May be easier to use than GetPlayerThirst() if you don't
* need to know the actual thirst value.
*
* SYNTAX
*/;
int function GetPlayerThirstLevel() global
;/*
* PARAMETERS
* None
*
* RETURN VALUE
* * The player's current thirst level.
* * 0 = Quenched
* * 1 = Refreshed
* * 2 = Thirsty
* * 3 = Very Thirsty
* * 4 = Parched
* * 5 = Dehydrated
*
* EXAMPLES
;Is the player thirsty?
float thirst_level = SeedUtil.GetPlayerThirstLevel()
if thirst_level >= 2
    debug.notification("Man I'm thirsty!")
endif
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1
    endif

    return LastSeed._Seed_ThirstLevel.GetValueInt()
endFunction

;/********f* SeedUtil/GetPlayerFatigue
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Gets the player's current Fatigue.
*
* SYNTAX
*/;
float function GetPlayerFatigue() global
;/*
* PARAMETERS
* None.
*
* RETURN VALUE
* The player's current Fatigue value.
*
* EXAMPLES
;How fatigued is the player?
float fatigue = SeedUtil.GetPlayerFatigue()
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1.0
    endif

    return LastSeed.Fatigue.attributeValueGlobal.GetValue()
endFunction

;/********f* SeedUtil/GetPlayerFatigueLevel
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Return the player's current fatigue level. May be easier to use than GetPlayerFatigue() if you don't
* need to know the actual fatigue value.
*
* SYNTAX
*/;
int function GetPlayerFatigueLevel() global
;/*
* PARAMETERS
* None
*
* RETURN VALUE
* * The player's current fatigue level.
* * 0 = Rested / Well Rested / Lover's Comfort
* * 1 = Sharp
* * 2 = Tired
* * 3 = Very Tired
* * 4 = Haggard
* * 5 = Exhausted
*
* EXAMPLES
;Is the player tired?
float fatigue_level = SeedUtil.GetPlayerFatigueLevel()
if fatigue_level >= 2
    debug.notification("Man I'm tired!")
endif
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1
    endif

    return LastSeed._Seed_FatigueLevel.GetValueInt()
endFunction

;/********f* SeedUtil/GetPlayerVitality
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Gets the player's current Vitality.
*
* SYNTAX
*/;
float function GetPlayerVitality() global
;/*
* PARAMETERS
* None.
*
* RETURN VALUE
* The player's current Vitality value.
*
* EXAMPLES
;How high is the player's Vitality?
float vitality = SeedUtil.GetPlayerVitality()
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1.0
    endif

    return LastSeed.Vitality.attributeValueGlobal.GetValue()
endFunction

;/********f* SeedUtil/GetPlayerVitalityLevel
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Return the player's current vitality level. May be easier to use than GetPlayerVitality() if you don't
* need to know the actual vitality value.
*
* SYNTAX
*/;
int function GetPlayerVitalityLevel() global
;/*
* PARAMETERS
* None
*
* RETURN VALUE
* * The player's current vitality level.
* * 0 = Dying
* * 1 = Ruined
* * 2 = Weakened
* * 3 = Drained
* * 4 = Healthy
* * 5 = Very Healthy
* * 6 = Vigorous
* * 7 = Peak Condition
*
* NOTES
* Unlike other needs, higher vitality is better.
* 
* EXAMPLES
;Is the player healthy?
float vitality_level = SeedUtil.GetPlayerVitalityLevel()
if vitality_level >= 5
    debug.notification("I'm a health nut!")
endif
;*********/;
    LastSeedAPI LastSeed = GetAPI()
    if LastSeed == none
        RaiseSeedAPIError()
        return -1
    endif

    return LastSeed._Seed_VitalityLevel.GetValueInt()
endFunction





function RaiseSeedAPIError() global
    debug.trace("[LastSeed][ERROR] Fatal Last Seed API error occurred.")
endFunction

bool function isInOblivion() global
	LastSeedAPI LastSeed = GetAPI()
	if LastSeed == none
		RaiseSeedAPIError()
		return none
	endif
	Actor PlayerRef = LastSeed.PlayerRef
	location playerLocation = PlayerRef.GetCurrentLocation()
	cell playerCell = PlayerRef.GetParentCell()
	Worldspace akCurrentWorldspace = PlayerRef.GetWorldSpace()
	
	return LastSeed._Seed_OblivionLocations.HasForm(playerLocation as form) || LastSeed._Seed_OblivionAreas.HasForm(akCurrentWorldspace as form) || LastSeed._Seed_OblivionCells.HasForm(playerCell as form)
endFunction





















; =============================================================================
;
;
;
;
;            While on this glowing canvas stands
;            The labour of my busy hands
;            It will remain when I am gone
;            For you my friends to look upon
;
;
;
;
;==============================================================================