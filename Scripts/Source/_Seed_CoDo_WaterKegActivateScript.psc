scriptname _Seed_CoDo_WaterKegActivateScript extends ObjectReference

;
;	CommonDominator
;
;	211108	Script replaced for "Last Seed - Water"
;			Refill all available waterskins or drink directly
;
;	211129	Drink to quench thirst
;			Refill Provisions waterskins
;

import _SeedInternal
import SeedUtil				; CoDo

Actor Property PlayerRef Auto
Message Property _Seed_CoDoLS_ActivatorMsg Auto	; CoDo
MiscObject Property  _Seed_CoDoLS_ObjectKit Auto	; CoDo	Inventory item after Pick up
sound Property _Seed_ITMPotionUse Auto	; CoDo	Inventory item after Pick up


Event Oninit()
	BlockActivation(self)
Endevent 


Event OnActivate(ObjectReference akActionRef)
	SeedDebug(0, "[WaterSource] Starting Script")
	
	if akActionRef == PlayerRef
		int iButton = _Seed_CoDoLS_ActivatorMsg.Show()
		; Drink
		if iButton == 1
			SeedDebug(0, "[WaterSource] Drinking")
			_Seed_ITMPotionUse.PlayAndWait(playerRef)
			RestorePlayerthirst(120.0)			
		; Refill
		elseIf iButton == 2
			GetWaterHandler().fillAllWaterskins()
		; Pick up
		elseIf iButton == 3
			; get the original kit
			PlayerRef.AddItem(_Seed_CoDoLS_ObjectKit, 1, False)
			
			; remove world object	
			self.Disable(True)		
			self.Delete()
		endIf
	endif
endEvent

	