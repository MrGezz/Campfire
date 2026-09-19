scriptname _Seed_SkoomaSystem extends _Seed_AlcoholBaseSystem

import Utility
import SeedUtil
import _SeedInternal

GlobalVariable property _Seed_Setting_SkoomaMulti_Strong auto
GlobalVariable property _Seed_Setting_SkoomaMulti_Weak auto
GlobalVariable property _Seed_AddictionResistance auto ; NO LONGER USED
GlobalVariable property _Seed_IsHigh auto
GlobalVariable property Provisioning_PerkRank_SkoomaFiend auto
GlobalVariable property _Seed_SettingPlayerIsLich auto


; Spell property _Seed_DrunkSpellHungOver auto   ; Hung Over (after having passed out) (flag Disease)

int SKOOMA_TYPE_WEAK = 1
int SKOOMA_TYPE_STRONG = 2

float WEAK_SKOOMA_AMOUNT = 32.0
float STRONG_SKOOMA_AMOUNT = 52.0
float AMOUNT_VARIANCE = 10.0
float ADDICTION_MIN = 10.0



Event OnUpdateGameTime()
    parent.onUpdateGameTime()
	if Attribute.GetValue() <= 0.0
		_Seed_IsHigh.setValue(1)
	endif
EndEvent

function SkoomaConsumed(int drinktype)
	if GetMonsterHandler().getVampireSettings(false, false, true) || _Seed_SettingPlayerIsLich.getValueInt() == 2
		return
	endif

	; Set debug name
	if debugSystemName == ""
		debugSystemName = "Skooma"
	endif

    if SystemEnabled.getValueInt() == 2
		float variance = (RandomFloat(0.0, AMOUNT_VARIANCE) - (AMOUNT_VARIANCE / 2)) ; +/- half of Variance (random)
		
		float amount = -1.0
		if drinktype == SKOOMA_TYPE_WEAK
			amount = (WEAK_SKOOMA_AMOUNT + variance) * _Seed_Setting_SkoomaMulti_Weak.getValue()
		elseif drinktype == SKOOMA_TYPE_STRONG
			amount = (STRONG_SKOOMA_AMOUNT + variance) * _Seed_Setting_SkoomaMulti_Strong.getValue()
		endif
		
		; Reduce Drunk Amount for Vampires
		if GetMonsterHandler().getVampireSettings(false, true, false)
			amount = amount / 2
		endif
		
		IncreaseDrunk(amount)
		
		;if completelySober
			last_update_time = GetCurrentGameTime() * 24.0
			RegisterForSingleUpdateGameTime(update_interval)
			;completelySober = false
			_Seed_IsHigh.setValue(2)
		;endif	
	endif
endFunction

;@Override

function PassOut()
	parent.PassOut()
endFunction

;@Override
function IncreaseDrunk(float amount)
	checkAddiction()
	parent.increaseDrunk(amount)
endFunction

function checkAddiction()
	int upperLimit = 7 + (Provisioning_PerkRank_SkoomaFiend.getValue() as int)
	if RandomInt(1, upperLimit) <= Level.GetValue()
		becomeAddicted()
	endif
endFunction

function becomeAddicted()
	if !PlayerRef.HasSpell(Spell5)
		PlayerRef.AddSpell(Spell5, false)
		showMessage(Level6Msg)
	endif
EndFunction
