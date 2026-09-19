scriptname _Seed_RainBarrelActivateScript extends ObjectReference
import SeedUtil

Event OnActivate(ObjectReference akActionRef)
	GetWaterHandler().fillAllWaterskinsOrDrink()
EndEvent


