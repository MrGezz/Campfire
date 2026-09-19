scriptname _Seed_ThirstSystem_Follower1 extends _Seed_ThirstSystem_Follower

import CampUtil
import _SeedInternal

; Overrides _Seed_AttributeSystem
Actor function getActor()
	currentActor = CampUtil.GetTrackedFollower(1)
	return currentActor
endFunction

function StartUp()
	parent.startup()
	debugSystemName = "Thirst_Follower1"
	followerIndex = 1
endFunction