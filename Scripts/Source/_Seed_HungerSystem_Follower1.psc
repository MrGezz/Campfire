scriptname _Seed_HungerSystem_Follower1 extends _Seed_HungerSystem

import CampUtil
import _SeedInternal

; Overrides _Seed_AttributeSystem
Actor function getActor()
	currentActor = CampUtil.GetTrackedFollower(1)
	return currentActor
endFunction

; Overrides _Seed_AttributeSystem
bool function isPlayer()
	return false
endFunction

function StartUp()
	parent.startup()
	debugSystemName = "Hunger_Follower1"
	followerIndex = 1
endFunction