Scriptname _Seed_CustomiseFoodContainer extends ObjectReference
;/
REFERENCED IN: 
_Seed_CustomiseFoodContainerRef
(In Seed_SpoilSystemUtilityCell)
/;
;import CampUtil
import SeedUtil
import _SeedInternal

GlobalVariable property _Seed_CustomiseFood_GettingPortions auto
GlobalVariable property _Seed_CustomiseFoodContainerOpen auto

Message property _Seed_CustomiseFood_NotClassifiedMsg auto
Message property _Seed_CustomiseFood_NotFoodMsg auto

string property debugSystemName = "CustomiseFoodContainer" auto hidden

Actor property PlayerRef auto

Event OnActivate(ObjectReference akActionRef)
	opening()
	Utility.Wait(1)
	closing()
endEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	potion theFood = akBaseItem as potion
	Self.RemoveItem(akBaseItem, aiItemCount, True, PlayerRef)
	
	if theFood
		;Add Food Portions
		if _Seed_CustomiseFood_GettingPortions.getValueInt() == 2
			if IsKnownFood(theFood, true, false)
				_Seed_CustomiseFood_GettingPortions.setValue(1)
				GetCustomiseFoodHandler().getPortionsAmountMenu(theFood)
			else
				_Seed_CustomiseFood_NotClassifiedMsg.Show()
			endif
		;Reclassify Food
		elseif IsKnownFood(theFood, true, false)
			GetCustomiseFoodHandler().ReClassifyFood(theFood)
		;Classify New Food
		else
			GetCustomiseFoodHandler().ClassifyFood(theFood)
		endif
	;Remove non-food item
	else
		_Seed_CustomiseFood_NotFoodMsg.Show()
	endif
EndEvent

function opening()
	_Seed_CustomiseFoodContainerOpen.setValue(2)
endFunction

function closing()
	_Seed_CustomiseFoodContainerOpen.setValue(1)
endFUnction