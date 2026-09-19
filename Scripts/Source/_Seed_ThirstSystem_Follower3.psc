scriptname _Seed_ThirstSystem_Follower3 extends _Seed_ThirstSystem_Follower

import CampUtil
import _SeedInternal

; Overrides _Seed_AttributeSystem
Actor function getActor()
	currentActor = CampUtil.GetTrackedFollower(3)
	return currentActor
endFunction

function StartUp()
	parent.startup()
	debugSystemName = "Thirst_Follower3"
	followerIndex = 3
endFunction