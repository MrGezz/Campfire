scriptname _Seed_FallbackReceiverRescueSystem extends FallbackEventReceiverForm

function RaiseEvent(String asEventName, Bool[] pushedBools, Int[] pushedInts, Float[] pushedFloats, Form[] pushedForms, String[] pushedStrings)
  	if asEventName == "Seed_OnRescuePlayer"
  		((self as Form) as _Seed_RescueSystem).OnRescuePlayer(pushedBools[0])
  	endif
endFunction