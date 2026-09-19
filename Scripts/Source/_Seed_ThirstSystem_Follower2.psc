scriptname _Seed_ThirstSystem_Follower2 extends _Seed_ThirstSystem_Follower

import CampUtil
import _SeedInternal

; Overrides _Seed_AttributeSystem
Actor function getActor()
	currentActor = CampUtil.GetTrackedFollower(2)
	return currentActor
endFunction

function StartUp()
	parent.startup()
	debugSystemName = "Thirst_Follower2"
	followerIndex = 2
endFunction