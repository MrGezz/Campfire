scriptname _Seed_HungerSystem_Follower2 extends _Seed_HungerSystem

import CampUtil
import _SeedInternal

; Overrides _Seed_AttributeSystem
Actor function getActor()
	currentActor = CampUtil.GetTrackedFollower(2)
	return currentActor
endFunction

; Overrides _Seed_AttributeSystem
bool function isPlayer()
	return false
endFunction

function StartUp()
	parent.startup()
	debugSystemName = "Thirst_Follower2"
	followerIndex = 2
endFunction