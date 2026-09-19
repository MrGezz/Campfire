Scriptname _Seed_DiseaseHitMonitor extends ReferenceAlias

import _SeedInternal
import utility

Actor property PlayerRef auto

Formlist[] Property _Seed_Races auto
Formlist[] Property _Seed_RaceDiseases auto

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)	
	; LOCK
    if !(akAggressor as actor) || akProjectile
		return 
	else
		GoToState("Locked")
    endIf
	
	race enemyRace = (akAggressor as actor).GetLeveledActorBase().GetRace()
	int i = _Seed_Races.Length
	bool stillSearching = true

	; Loop through race lists until you find the enemy race
	While i > 0 && stillSearching
		i -= 1
		if(_Seed_Races[i].HasForm(enemyRace))
			stillSearching = false			
			;Fetch a random disease from the corresponding disease list
			int selection = 0
			int maxSelection = _Seed_RaceDiseases[i].GetSize() - 1
			if(maxSelection > 0)
				selection = randomInt(0, maxSelection)	
			endif
			spell disease = _Seed_RaceDiseases[i].GetAt(selection) as spell
						
			;Apply disease to player
			if(disease)
				PlayerRef.DoCombatSpellApply(disease, PlayerRef)				
				SeedDebug(0, "[DiseaseHitDetector]: Applied disease from formlist: " + _Seed_RaceDiseases[i].GetFormID())
				SeedDebug(0, "	selected index: " + selection)
			else
				SeedDebug(3, "[DiseaseHitDetector]: ERROR - Failed to apply disease from formlist: " + _Seed_RaceDiseases[i].GetFormID())
				SeedDebug(3, "	selected index: " + selection)
				SeedDebug(3, "	max index: " + maxSelection)
			endif
		endif
	endWhile
	
	; UNLOCK
    GoToState("")
endevent

State Locked
    Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)
		;Do Nothing
    endevent
endState