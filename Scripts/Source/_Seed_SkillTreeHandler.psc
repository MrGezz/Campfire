scriptname _Seed_SkillTreeHandler extends Quest

import CampUtil
import SeedUtil

actor property PlayerRef auto

Activator property _Seed_PerkNodeController_Provisioning auto

GlobalVariable property ProvisioningPerkPointsEarned auto
GlobalVariable property ProvisioningPerkPointsTotal auto
GlobalVariable property ProvisioningPerkPointProgress auto
GlobalVariable property ProvisioningPerkPoints auto

GlobalVariable Property Provisioning_PerkRank_StrongBack auto
GlobalVariable Property Provisioning_PerkRank_IronStomach auto
GlobalVariable Property Provisioning_PerkRank_SkoomaFiend auto
GlobalVariable Property Provisioning_PerkRank_Preservationist auto
GlobalVariable Property Provisioning_PerkRank_Outdoorsman auto
GlobalVariable Property Provisioning_PerkRank_UnboundIntensity auto

GlobalVariable Property Provisioning_PerkRank_StrongBackMax auto
GlobalVariable Property Provisioning_PerkRank_IronStomachMax auto
GlobalVariable Property Provisioning_PerkRank_SkoomaFiendMax auto
GlobalVariable Property Provisioning_PerkRank_PreservationistMax auto
GlobalVariable Property Provisioning_PerkRank_OutdoorsmanMax auto
GlobalVariable Property Provisioning_PerkRank_UnboundIntensityMax auto

GlobalVariable property _Seed_Setting_Focus auto

Spell Property _Seed_IntensityPlayerSpell auto
Spell Property _Seed_StrongBackSpell auto ; TODO: Add this


Message property _Seed_PerkEarned auto
Message property _Seed_PerkAdvancement auto

bool progress25 = false
bool progress50 = false
bool progress75 = false
bool updating = false

function StartSystem()
	if !self.IsRunning()
		self.Start()
	endif
	;RegisterForUpdateGameTime(6)
	RegisterPerkTree(_Seed_PerkNodeController_Provisioning, "LastSeed.esp")
	RegisterForEvents()
	updateSkills()
endFunction

function StopSystem()
	UnregisterPerkTree(_Seed_PerkNodeController_Provisioning, "LastSeed.esp")
	;UnregisterForUpdateGameTime()
	if !self.IsRunning()
		self.Stop()
	endif
endFunction

function RegisterForEvents()
	FallbackEventEmitter campfirePerkEvent = GetEventEmitter_CampfirePerkPurchased()
	campfirePerkEvent.RegisterFormForModEventWithFallback("Campfire_CampfirePerkPurchased", "CampfirePerkPurchased", self)
endFunction

Event CampfirePerkPurchased()
	updateSkills()
endEvent

function updateSkills()
	;STRONG BACK
	if Provisioning_PerkRank_StrongBack.GetValueInt() > 0 && !PlayerRef.hasSpell(_Seed_StrongBackSpell)
		PlayerRef.AddSpell(_Seed_StrongBackSpell, false)
	elseif Provisioning_PerkRank_StrongBack.GetValueInt() == 0 && PlayerRef.hasSpell(_Seed_StrongBackSpell)
		PlayerRef.RemoveSpell(_Seed_StrongBackSpell)
	endif
		
	;UNBOUND INTENSITY
	if Provisioning_PerkRank_UnboundIntensity.GetValueInt() > 0 && !PlayerRef.hasSpell(_Seed_IntensityPlayerSpell)
		PlayerRef.AddSpell(_Seed_IntensityPlayerSpell)
	elseif Provisioning_PerkRank_UnboundIntensity.GetValueInt() == 0 && PlayerRef.hasSpell(_Seed_IntensityPlayerSpell)
		PlayerRef.RemoveSpell(_Seed_IntensityPlayerSpell)
	endif	

endFunction

function UnlockPerks()
	Provisioning_PerkRank_StrongBack.setValue(Provisioning_PerkRank_StrongBackMax.getValue())
	Provisioning_PerkRank_IronStomach.setValue(Provisioning_PerkRank_IronStomachMax.getValue())
	Provisioning_PerkRank_SkoomaFiend.setValue(Provisioning_PerkRank_SkoomaFiendMax.getValue())
	Provisioning_PerkRank_Preservationist.setValue(Provisioning_PerkRank_PreservationistMax.getValue())
	Provisioning_PerkRank_Outdoorsman.setValue(Provisioning_PerkRank_OutdoorsmanMax.getValue())
	Provisioning_PerkRank_UnboundIntensity.setValue(Provisioning_PerkRank_UnboundIntensityMax.getValue())
	updateSkills()
endFunction

function ClearPerks()
	Provisioning_PerkRank_StrongBack.SetValueInt(0)
	Provisioning_PerkRank_IronStomach.SetValueInt(0)
	Provisioning_PerkRank_SkoomaFiend.SetValueInt(0)
	Provisioning_PerkRank_Preservationist.SetValueInt(0)
	Provisioning_PerkRank_Outdoorsman.SetValueInt(0)
	Provisioning_PerkRank_UnboundIntensity.SetValueInt(0)
	updateSkills()
endFunction

function RefundSkillPoints()
    ProvisioningPerkPoints.SetValue(ProvisioningPerkPointsEarned.GetValue())
    ProvisioningPerkPointProgress.SetValue(0.0)
	ClearPerks()
endFunction

function restorePerkPoints(int value)
    ProvisioningPerkPointProgress.SetValue(0.0)
    ProvisioningPerkPoints.SetValue(value)
    ProvisioningPerkPointsEarned.SetValue(value)
    ClearPerks()
endFunction

Function progressExperience()    	
    while(updating)
        Utility.Wait(0.15)
    endwhile
    
    updating = true
    if(ProvisioningPerkPointsEarned.GetValue() < ProvisioningPerkPointsTotal.GetValue())
        int next_level = ProvisioningPerkPointsEarned.GetValue() as int + 1
        float actions_required
		
		int vitalityMulti = GetPlayerVitalityLevel() - 3
		if (vitalityMulti < 1)
			vitalityMulti = 1
		endif
		
        actions_required = (6 + ((next_level * 2) * 6 / vitalityMulti)) 

        float progress_value = (1.0 / actions_required)

        ProvisioningPerkPointProgress.SetValue(ProvisioningPerkPointProgress.GetValue() + progress_value)

        if (ProvisioningPerkPointProgress.GetValue() + 0.01) >= 1.0
            
			_Seed_PerkEarned.Show()
            
            ProvisioningPerkPointsEarned.SetValue(ProvisioningPerkPointsEarned.GetValue() as int + 1)
            ProvisioningPerkPoints.SetValue(ProvisioningPerkPoints.GetValue() as int + 1)

            if ProvisioningPerkPointsEarned.GetValue() as int >= ProvisioningPerkPointsTotal.GetValue() as int
                ProvisioningPerkPointProgress.SetValue(1.0)
            else
                ProvisioningPerkPointProgress.SetValue(0.0)
            endif
        else
            float perkProg = ProvisioningPerkPointProgress.GetValue() + 0.01
            bool showMessage = false

            ;Only show message at certain intervals
            if(perkProg >= 0.25 && perkProg < 0.50)                  
                if(!progress25)
                    showMessage = true
                else
                    showMessage = false
                endif
                progress25 = true
                progress50 = false
                progress75 = false
            ElseIf(perkProg >= 0.50 && perkProg < 0.75)
                if(!progress50)
                    showMessage = true
                else
                    showMessage = false
                endif
                progress25 = false
                progress50 = true
                progress75 = false            
            ElseIf(perkProg >= 0.75 && perkProg < 1.0)
                if(!progress75)
                    showMessage = true
                else
                    showMessage = false
                endif
                progress25 = false
                progress50 = false
                progress75 = true 
            endif

			if(showMessage)
				_Seed_PerkAdvancement.Show()
			endif             
        endif
    endif
    updating = false

EndFunction

;OLD
;/
Event onUpdateGameTime()
	if !isPlayerFocused()
		progressExperience()
		RegisterForUpdateGameTime(6)
	else 
		RegisterForUpdateGameTime(0.5)
	endif
endEvent

bool function progressExperience()	
	if(ProvisioningPerkPointsEarned.GetValue() < ProvisioningPerkPointsTotal.GetValue())
		int expGain = GetPlayerVitalityLevel() - 3
		if (expGain > 0)
			int next_level = ProvisioningPerkPointsEarned.GetValue() as int + 1
			
			float multi = 9.0
			if _Seed_Setting_Focus.getValue() as int == 2
				multi = 18.0
			endif
			
			float ticks_required = next_level * multi
			float progress_value = (expGain / ticks_required)
	
			ProvisioningPerkPointProgress.SetValue(ProvisioningPerkPointProgress.GetValue() + progress_value)
	
			if (ProvisioningPerkPointProgress.GetValue() + 0.01) >= 1.0
				
				_Seed_PerkEarned.Show()
				
				ProvisioningPerkPointsEarned.SetValue(ProvisioningPerkPointsEarned.GetValue() as int + 1)
				ProvisioningPerkPoints.SetValue(ProvisioningPerkPoints.GetValue() as int + 1)
	
				if ProvisioningPerkPointsEarned.GetValue() as int >= ProvisioningPerkPointsTotal.GetValue() as int
					ProvisioningPerkPointProgress.SetValue(1.0)
				else
					ProvisioningPerkPointProgress.SetValue(0.0)
				endif
			else
				float perkProg = ProvisioningPerkPointProgress.GetValue() + 0.01
				bool showMessage = false
	
				;Only show message at certain intervals
				if(perkProg >= 0.25 && perkProg < 0.50)                  
					if(!progress25)
						showMessage = true
					else
						showMessage = false
					endif
					progress25 = true
					progress50 = false
					progress75 = false
				ElseIf(perkProg >= 0.50 && perkProg < 0.75)
					if(!progress50)
						showMessage = true
					else
						showMessage = false
					endif
					progress25 = false
					progress50 = true
					progress75 = false            
				ElseIf(perkProg >= 0.75 && perkProg < 1.0)
					if(!progress75)
						showMessage = true
					else
						showMessage = false
					endif
					progress25 = false
					progress50 = false
					progress75 = true 
				endif
	
				if(showMessage)
					_Seed_PerkAdvancement.Show()
				endif         
			endif
		endif
    endif
endFunction
/;
