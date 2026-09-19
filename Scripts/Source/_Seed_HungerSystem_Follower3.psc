scriptname _Seed_HungerSystem_Follower3 extends _Seed_HungerSystem

import CampUtil
import _SeedInternal

; Overrides _Seed_AttributeSystem
Actor function getActor()
	currentActor = CampUtil.GetTrackedFollower(3)
	return currentActor
endFunction

; Overrides _Seed_AttributeSystem
bool function isPlayer()
	return false
endFunction

function StartUp()
	parent.startup()
	debugSystemName = "Thirst_Follower3"
	followerIndex = 3
endFunction