scriptname _Seed_ActivatorHandler extends Quest

import SeedUtil

GlobalVariable property _Seed_CarriageRode auto

Actor property playerRef auto
Potion Property _Seed_WaterBottleEmpty Auto
Message property _Seed_ConvertWineBottleMsg auto

PRKF_DA11Cannibalism_000EE5C3 property cannibalismPerk auto


function rideCarriage()
	_Seed_CarriageRode.setValue(2)
	Utility.Wait(13)
	_Seed_CarriageRode.setValue(1)
endFunction

function feedOnCorpse(ObjectReference akTargetRef, Actor akActor)
	cannibalismPerk.Fragment_0(akTargetRef, akActor)
endFunction

function convertWineBottle(ObjectReference akNewContainer, form bottle)
	if akNewContainer == playerRef && LastSeedIsRunning() && _Seed_ConvertWineBottleMsg.show() == 1
		playerRef.removeItem(bottle, 1, true)
		playerRef.addItem(_Seed_WaterBottleEmpty, 1)
	endif
endFunction