scriptname _Seed_VendorStock extends Quest

import utility
import _SeedInternal

potion property _Seed_WaterskinEmpty auto
MiscObject property _Seed_RainBarrel_MiscItem auto

ReferenceAlias property RiverwoodTraderChestAlias auto
ReferenceAlias property CaravanAChestAlias auto
ReferenceAlias property CaravanBChestAlias auto
ReferenceAlias property CaravanCChestAlias auto
ReferenceAlias property AvalAtheronChestAlias auto
ReferenceAlias property BethethorsChestAlias auto
ReferenceAlias property BirnaChestAlias auto
ReferenceAlias property BrandChestAlias auto
ReferenceAlias property PawnedPrawnChestAlias auto
ReferenceAlias property SolitudeBitsAndPiecesChestAlias auto
ReferenceAlias property ArnleifChestAlias auto
ReferenceAlias property GrayPineGoodsChestAlias auto
ReferenceAlias property NiranyeChestAlias auto

ObjectReference property WhiterunArcadiasCauldronChestRef auto
ObjectReference property RiverwoodTraderMerchantContainer auto
ObjectReference property CaravanAChestREF auto
ObjectReference property CaravanBChestREF auto
ObjectReference property CaravanCChestREF auto
ObjectReference property AvalAtheronChest auto
ObjectReference property BethethorsMerchantChestRef auto
ObjectReference property BirnaChest auto
ObjectReference property BrandChest auto
ObjectReference property PawnedPrawnChest auto
ObjectReference property MerchantSolitudeBitsAndPiecesChestRef auto
ObjectReference property ArnleifChest auto
ObjectReference property GrayPineGoodsChest auto
ObjectReference property NiranyeChest auto

LeveledItem Property LItemApothecaryPotionCureHMS75 Auto
LeveledItem Property LItemPotionCureHMS Auto
Formlist Property _Seed_Potion_CureList Auto
Formlist Property _Seed_Potion_CureListExtended Auto
GlobalVariable Property _Seed_Setting_DiseasePotionsCure Auto
GlobalVariable Property _Seed_SettingAdditionalDiseases Auto

Potion Property _Seed_CureVampirism auto

Event StartSystem()
	;Stock items
	FillAllAliases()
	wait(3.0)
	runUpdate()
	

	
	RegisterForSingleUpdateGameTime(24)
endEvent

Event StopSystem()
	ClearAllAliases()
	RemoveAllModItems()
	SetPotionLeveledLists()
	UnRegisterForUpdateGameTime()
endEvent

Event OnUpdateGameTime()
	runUpdate()
	RegisterForSingleUpdateGameTime(24)
endEvent

function runUpdate()
	;Clear the alias
	ClearAllAliases()
	
	;Remove any items found in any of the chests listed
	RemoveAllModItems()
	
	;Re-fill the alias
	FillAllAliases()
	
	;Set Cure Disease Potions Lists
	SetPotionLeveledLists(false)
	if _Seed_Setting_DiseasePotionsCure.getValue() == 2
		SetPotionLeveledLists()
	elseif _Seed_Setting_DiseasePotionsCure.getValue() == 3
		SetPotionLeveledListsVampirism()
	endif
endFunction

Function ClearAllAliases()

	;Clear all merchant chest aliases
	RiverwoodTraderChestAlias.Clear()
	CaravanAChestAlias.Clear()
	CaravanBChestAlias.Clear()
	CaravanCChestAlias.Clear()
	AvalAtheronChestAlias.Clear()
	BethethorsChestAlias.Clear()
	BirnaChestAlias.Clear()
	BrandChestAlias.Clear()
	PawnedPrawnChestAlias.Clear()
	SolitudeBitsAndPiecesChestAlias.Clear()
	ArnleifChestAlias.Clear()
	GrayPineGoodsChestAlias.Clear()
	NiranyeChestAlias.Clear()
	
endFunction

Function FillAllAliases()

	;Fill aliases to apply their inventories
	RiverwoodTraderChestAlias.ForceRefIfEmpty(RiverwoodTraderMerchantContainer)
	CaravanAChestAlias.ForceRefIfEmpty(CaravanAChestREF)
	CaravanBChestAlias.ForceRefIfEmpty(CaravanBChestREF)
	CaravanCChestAlias.ForceRefIfEmpty(CaravanCChestREF)
	AvalAtheronChestAlias.ForceRefIfEmpty(AvalAtheronChest)
	BethethorsChestAlias.ForceRefIfEmpty(BethethorsMerchantChestRef)
	BirnaChestAlias.ForceRefIfEmpty(BirnaChest)
	BrandChestAlias.ForceRefIfEmpty(BrandChest)
	PawnedPrawnChestAlias.ForceRefIfEmpty(PawnedPrawnChest)
	SolitudeBitsAndPiecesChestAlias.ForceRefIfEmpty(MerchantSolitudeBitsAndPiecesChestRef)
	ArnleifChestAlias.ForceRefIfEmpty(ArnleifChest)
	GrayPineGoodsChestAlias.ForceRefIfEmpty(GrayPineGoodsChest)
	NiranyeChestAlias.ForceRefIfEmpty(NiranyeChest)
endFunction

function RemoveAllModItems()
	;General Goods
	RemoveItemFromVendor(_Seed_WaterskinEmpty, RiverwoodTraderMerchantContainer)
	RemoveItemFromVendor(_Seed_RainBarrel_MiscItem, RiverwoodTraderMerchantContainer)

	RemoveItemFromVendor(_Seed_WaterskinEmpty, CaravanAChestREF)

	RemoveItemFromVendor(_Seed_WaterskinEmpty, CaravanBChestREF)

	RemoveItemFromVendor(_Seed_WaterskinEmpty, CaravanCChestREF)

	RemoveItemFromVendor(_Seed_WaterskinEmpty, AvalAtheronChest)
	RemoveItemFromVendor(_Seed_RainBarrel_MiscItem, AvalAtheronChest)

	RemoveItemFromVendor(_Seed_WaterskinEmpty, BethethorsMerchantChestRef)
	RemoveItemFromVendor(_Seed_RainBarrel_MiscItem, BethethorsMerchantChestRef)

	RemoveItemFromVendor(_Seed_WaterskinEmpty, BirnaChest)
	RemoveItemFromVendor(_Seed_RainBarrel_MiscItem, BirnaChest)

	RemoveItemFromVendor(_Seed_WaterskinEmpty, PawnedPrawnChest)
	RemoveItemFromVendor(_Seed_RainBarrel_MiscItem, PawnedPrawnChest)
	
	RemoveItemFromVendor(_Seed_WaterskinEmpty, MerchantSolitudeBitsAndPiecesChestRef)
	RemoveItemFromVendor(_Seed_RainBarrel_MiscItem, MerchantSolitudeBitsAndPiecesChestRef)

	RemoveItemFromVendor(_Seed_WaterskinEmpty, ArnleifChest)
	RemoveItemFromVendor(_Seed_RainBarrel_MiscItem, ArnleifChest)

	RemoveItemFromVendor(_Seed_WaterskinEmpty, GrayPineGoodsChest)
	RemoveItemFromVendor(_Seed_RainBarrel_MiscItem, GrayPineGoodsChest)

	RemoveItemFromVendor(_Seed_WaterskinEmpty, NiranyeChest)
	RemoveItemFromVendor(_Seed_RainBarrel_MiscItem, NiranyeChest)

	RemoveItemFromVendor(_Seed_WaterskinEmpty, BrandChest)
	RemoveItemFromVendor(_Seed_RainBarrel_MiscItem, BrandChest)

endFunction

function RemoveItemFromVendor(Form akItem, ObjectReference akContainer)
	if akContainer.GetItemCount(akItem) > 0
		akContainer.RemoveItem(akItem, akContainer.GetItemCount(akItem))
	endif
endFunction

;Change the Cure Potions Lists
Function SetPotionLeveledLists(Bool addPotions = True)
	; Clear Level Lists
	LItemApothecaryPotionCureHMS75.Revert()
	LItemPotionCureHMS.Revert()
	LItemApothecaryPotionCureHMS75.SetChanceNone(85)
	LItemPotionCureHMS.SetChanceNone(85)
	If addPotions
		; Select to use vanilla or extended potion list
		formList list
		if(_Seed_SettingAdditionalDiseases.getValue() == 2)
			list = _Seed_Potion_CureListExtended
		else
			 list = _Seed_Potion_CureList
		endif
		
		;Populate the level Lists with the potions
		Int iIndex = list.GetSize() as Int
		While iIndex > 0
			iIndex -= 1
			Form CurePotion = list.GetAt(iIndex)
			LItemApothecaryPotionCureHMS75.AddForm(CurePotion, 1, 1)
			LItemPotionCureHMS.AddForm(CurePotion, 1, 1)
		EndWhile						  
	EndIf
EndFunction

Function SetPotionLeveledListsVampirism()
	SetPotionLeveledLists(false)
	LItemApothecaryPotionCureHMS75.AddForm(_Seed_CureVampirism, 1, 1)
	LItemPotionCureHMS.AddForm(_Seed_CureVampirism, 1, 1)
endFunction

function setPotionLeveledListsFromSetting()
	if _Seed_Setting_DiseasePotionsCure.getValue() == 2
		SetPotionLeveledLists()
	elseif _Seed_Setting_DiseasePotionsCure.getValue() == 3
		SetPotionLeveledListsVampirism()
	else
		SetPotionLeveledLists(false)
	endif
endFunction

Function RefreshSystem()
	SeedDebug(1, "[VendorStock Manager]: Refreshing.")
	RegisterForSingleUpdateGameTime(24)
EndFunction

