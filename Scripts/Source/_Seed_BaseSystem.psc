scriptname _Seed_BaseSystem extends Quest

import _SeedInternal

GlobalVariable property UpdateFrequencyGlobal auto
{The global variable that determines how often this system should update. If left blank, this system is event-driven.}

bool initialized = false

function StartSystem()
	SeedDebug(-1, "StartSystem " + self)
	if !self.IsRunning()
		self.Start()
	endif
	StartUp()
	RegisterForSingleUpdate(5)
	OnUpdateGameTime()
	initialized = true
endFunction

function StopSystem()
	self.UnregisterForUpdate()
	self.UnregisterForUpdateGameTime()
	if self.IsRunning()
		self.Stop()
	endif
	ShutDown()
	initialized = false
endFunction

; @Override
function StartUp()
	; pass
endFunction

; @Override
function ShutDown()
	; pass
endFunction

bool function IsSystemRunning()
	return initialized
endFunction

; @Override
Event OnUpdate()
	; pass
endEvent

Event OnUpdateGameTime()
	float start_time = Game.GetRealHoursPassed()
	if UpdateFrequencyGlobal
		RegisterForSingleUpdateGameTime(UpdateFrequencyGlobal.GetValue())
		SeedDebug(-1, self + " Registering for new update: " + UpdateFrequencyGlobal.GetValue())
		SeedDebug(-1, self + " update finished in " + ((Game.GetRealHoursPassed() - start_time) * 3600.0) + " seconds.")
	else
		SeedDebug(-1, self + " update finished in " + ((Game.GetRealHoursPassed() - start_time) * 3600.0) + " seconds. No further updated scheduled")
	endif
	Update()
endEvent


Function startMonitoringRegeneration()
	if(self.IsRunning())
		RegisterForSingleUpdate(5)
	endif
endFunction

; @Overridden by system
function Update()
endFunction

Function RefreshSystem()
	if(!self.IsRunning())
		self.StartSystem()
	else
		if(UpdateFrequencyGlobal)
			RegisterForSingleUpdateGameTime(UpdateFrequencyGlobal.GetValue())
		endif
		RegisterForSingleUpdate(5)
	Endif
EndFunction

