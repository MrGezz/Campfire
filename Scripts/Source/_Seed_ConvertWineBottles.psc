Scriptname _Seed_ConvertWineBottles extends ObjectReference 

import seedUtil

miscObject property bottle auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	getActivatorHandler().convertWineBottle(akNewContainer, bottle)
endEvent