scriptname _Seed_SpoilSystem extends _Seed_BaseSystem
;/
REFERENCED IN: _Seed_SpoilSystemQuest
/;
import utility
import seedUtil
import campUtil
import frostUtil

GlobalVariable property _Seed_SpoilTemperatureMulti auto
GlobalVariable property _Seed_Setting_SpoilageTemperatureMulti auto
MagicEffect property _Seed_IceWraithTeethEffect auto
Actor property playerRef auto

function StartSystem()
	Update()
	parent.startSystem()
endFunction

function StopSystem()
	_Seed_SpoilTemperatureMulti.setValue(1)

	; Remove spoilage trackers
	stopSpoilage(0)
	stopSpoilage(1)
	stopSpoilage(5)
	stopSpoilage(6)
	stopSpoilage(7)
	stopSpoilage(9)
		
	; Remove any trackers that were missed
	;/
	if GetSKSELoaded()
		int handle = ModEvent.Create("LastSeed_SpoilageShutdown")
		if (handle)
			ModEvent.Send(handle)
		endIf		
	endif
	/;
	parent.stopSystem()
endFunction


function stopSpoilage(int id)
	_Seed_AliasFoodMonitor foodMonitor = self.GetAlias(id) as _Seed_AliasFoodMonitor
	if foodMonitor
		foodMonitor.stopSpoilage()
	endif
endFunction


function setAllInventoryEventFilters()
	setInventoryEventFilter(0)
	setInventoryEventFilter(1)
	setInventoryEventFilter(5)
	setInventoryEventFilter(6)
	setInventoryEventFilter(7)
	setInventoryEventFilter(9)
endFunction

function setInventoryEventFilter(int id)
	_Seed_AliasFoodMonitor foodMonitor = self.GetAlias(id) as _Seed_AliasFoodMonitor
	if foodMonitor
		foodMonitor.addInventoryEventFilters()
	endif
endFUnction

event update()
	float tempMulti = 1.0
	if _Seed_Setting_SpoilageTemperatureMulti.getValue() == 2 && seedUtil.GetCompatibilitySystem().isFrostfallLoaded
		int temp = GetCurrentTemperature()
		if temp < 10
			tempMulti -= 0.5
			return
		endif
	endif
	if playerRef.HasMagicEffect(_Seed_IceWraithTeethEffect)
		tempMulti -= 0.3
	endif
	_Seed_SpoilTemperatureMulti.setValue(tempMulti)
endevent

function runDelayedUpdate()
	registerforSingleUpdate(0.5)
endFunction
event onUpdate()
	update()
endEvent