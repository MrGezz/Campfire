Scriptname _Seed_ConsumeManagerFollowers extends _Seed_ConsumeManager

import _SeedInternal
import seedUtil
import CampUtil

float property waitTimeFollower = 1.0 auto hidden

function startAutoConsuming()

    NPC_AutoEating(1, Follower1AutoEating)
    NPC_AutoEating(2, Follower2AutoEating)
    NPC_AutoEating(3, Follower3AutoEating)

    NPC_AutoDrinking(1, Follower1AutoDrinking)
    NPC_AutoDrinking(2, Follower2AutoDrinking)
    NPC_AutoDrinking(3, Follower3AutoDrinking)
	
	NPC_AutoFeeding(1, Follower1AutoFeeding)
    NPC_AutoFeeding(2, Follower2AutoFeeding)
    NPC_AutoFeeding(3, Follower3AutoFeeding)
    
    if Follower1AutoEating || Follower2AutoEating || Follower3AutoEating || Follower1AutoDrinking || Follower2AutoDrinking || Follower3AutoDrinking
		registerForSingleUpdate(waitTimeFollower)
		SeedDebug(0, "[ConsumeManager] still auto-consuming...")
    else
		isUpdating = false
		SeedDebug(0, "[ConsumeManager] Stopping auto-consuming")
		
		; Show Follower 1 Messages & Animations
		if follower1HungerMessage != "" && _Seed_Setting_Notifications_Followers.getValue() as int == 2
			Debug.Notification(follower1HungerMessage)
		endif
		if enqueueEatAnimationFollower1
			GetAnimationHandler().EatAnimation(1)
		endif
	
		if follower1ThirstMessage != "" && _Seed_Setting_Notifications_Followers.getValue() as int == 2
			Debug.Notification(follower1ThirstMessage)			
		endif
		if enqueueDrinkAnimationFollower1
			GetAnimationHandler().DrinkAnimation(1)
		endif
		follower1ThirstMessage = ""
		follower1HungerMessage = ""
		enqueueEatAnimationFollower1 = false
		enqueueDrinkAnimationFollower1 = false

		
		; Show Follower 2 Messages & Animations
		if follower2HungerMessage != "" && _Seed_Setting_Notifications_Followers.getValue() as int == 2
			Debug.Notification(follower2HungerMessage)
			;eatAnimation(GetTrackedFollower(2))
		endif
		if enqueueEatAnimationFollower2
			GetAnimationHandler().EatAnimation(2)
		endif
		if follower2ThirstMessage != "" && _Seed_Setting_Notifications_Followers.getValue() as int == 2
			Debug.Notification(follower2ThirstMessage)
		endif
		if enqueueDrinkAnimationFollower2
			GetAnimationHandler().DrinkAnimation(2)
		endif
		follower2HungerMessage = ""
		follower2ThirstMessage = ""
		enqueueEatAnimationFollower2 = false
		enqueueDrinkAnimationFollower2 = false
		
		; Show Follower 3 Messages & Animations
		if follower3HungerMessage != "" && _Seed_Setting_Notifications_Followers.getValue() as int == 2
			Debug.Notification(follower3HungerMessage)
		endif
		if enqueueEatAnimationFollower3
			GetAnimationHandler().EatAnimation(3)
		endif
		if follower3ThirstMessage != "" && _Seed_Setting_Notifications_Followers.getValue() as int == 2
			Debug.Notification(follower3ThirstMessage)
		endif
		if enqueueDrinkAnimationFollower3
			GetAnimationHandler().DrinkAnimation(3)
		endif
		follower3HungerMessage = ""
		follower3ThirstMessage = ""
		enqueueEatAnimationFollower3 = false
		enqueueDrinkAnimationFollower3 = false
		
		GetFollowerSystem().GetHungerSystem(1).AutoEatenFood.Revert()
		GetFollowerSystem().GetThirstSystem(1).AutoDrank.Revert()
		GetFollowerSystem().GetHungerSystem(2).AutoEatenFood.Revert()
		GetFollowerSystem().GetThirstSystem(2).AutoDrank.Revert()
		GetFollowerSystem().GetHungerSystem(3).AutoEatenFood.Revert()
		GetFollowerSystem().GetThirstSystem(3).AutoDrank.Revert()
    endif
endFunction

Function StopSystem()	
	Follower1AutoEating = false
	Follower2AutoEating = false
	Follower3AutoEating = false
	
	Follower1AutoDrinking = false
	Follower2AutoDrinking = false
	Follower3AutoDrinking = false
	
	Follower1AutoFeeding = false
	Follower2AutoFeeding = false
	Follower3AutoFeeding = false
	;parent.stopSystem()
EndFunction