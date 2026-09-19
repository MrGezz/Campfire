Scriptname _Seed_StumblingEffect extends ActiveMagicEffect  

import _SeedInternal

int property refreshTimeMin = 10 auto hidden
int property refreshTimeMax = 20 auto hidden
int property trippingChance auto
spell property _Seed_StumbleSpell auto

GlobalVariable property _Seed_Setting_DrunkStumbling auto

Actor property PlayerRef auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	if _Seed_Setting_DrunkStumbling.getValue() == 2 
		int refreshTime = Utility.RandomInt(refreshTimeMin,refreshTimeMax)
		RegisterForSingleUpdate(refreshTime)
		SeedDebug(0, "[Alcohol]: Starting Stumbling Effect")
	endif
endEvent

event OnUpdate()		
	SeedDebug(0, "[Alcohol]: Checking stumble")

	if PlayerRef.IsSprinting() && Utility.RandomInt(1,100) <= trippingChance * 2
		PlayerRef.PushActorAway(PlayerRef, 0)
		PlayerRef.ApplyHavokImpulse(PlayerRef.GetAngleX(), PlayerRef.GetAngleY(), -0.3, 150)
	elseif PlayerRef.IsRunning() && Utility.RandomInt(1,100) <= trippingChance
		PlayerRef.PushActorAway(PlayerRef, 0)
		PlayerRef.ApplyHavokImpulse(PlayerRef.GetAngleX(), PlayerRef.GetAngleY(), -0.3, 150)
	endif	
	
	int refreshTime = Utility.RandomInt(refreshTimeMin,refreshTimeMax)
	RegisterForSingleUpdate(refreshTime)
endEvent