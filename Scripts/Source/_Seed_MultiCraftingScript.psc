Scriptname _Seed_MultiCraftingScript extends ObjectReference 
MiscObject Property token Auto

form Property CreatedObject1 Auto
Int Property CreatedObject1Count Auto

form Property CreatedObject2 Auto
Int Property CreatedObject2Count Auto

form Property CreatedObject3 Auto
Int Property CreatedObject3Count Auto

form Property CreatedObject4 Auto
Int Property CreatedObject4Count Auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
  if akNewContainer == Game.GetPlayer()
	; Add crafted Items
	addCraftedItem(CreatedObject1, CreatedObject1Count, akNewContainer)
	addCraftedItem(CreatedObject2, CreatedObject2Count, akNewContainer)
	addCraftedItem(CreatedObject3, CreatedObject3Count, akNewContainer)
	addCraftedItem(CreatedObject4, CreatedObject4Count, akNewContainer)
	
	;Remove Token
	akNewContainer.removeItem(token, 1, true)
  endIf
endEvent

function addCraftedItem(form CreatedObject, int count, ObjectReference akNewContainer)
	if CreatedObject != none
		akNewContainer.addItem(CreatedObject, count)
	endif
endFunction