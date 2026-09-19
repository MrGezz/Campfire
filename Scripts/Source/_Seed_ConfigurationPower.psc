Scriptname _Seed_ConfigurationPower extends ActiveMagicEffect  
;/
_Seed_ConfigMenu "Last Seed Options" [SPEL:06250AD3]
_Seed_ConfigMenu "Last Seed Options" [MGEF:06250AD2]
/;
import SeedUtil

Event OnEffectStart(Actor akTarget, Actor akCaster)
	GetConfigurationHandler().startConfig()
endEvent