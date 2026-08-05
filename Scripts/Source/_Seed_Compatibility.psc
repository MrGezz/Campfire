scriptname _Seed_Compatibility extends ReferenceAlias

import debug
import CampUtil
import SeedUtil
import _SeedInternal

; Minimum SKSE version required, by runtime. Encoded as (major * 10000) + (minor * 100) + build.
int property SKSE_MIN_VERSION_LE = 10703 autoReadOnly	; SKSE 1.7.3, Skyrim Legendary Edition
int property SKSE_MIN_VERSION_SE = 20020 autoReadOnly	; SKSE64 2.0.20, Skyrim Special Edition
int property SKSE_MIN_VERSION_VR = 20012 autoReadOnly	; SKSEVR 2.0.12, Skyrim VR

int property SKSE_MIN_VERSION = 10703 autoReadOnly
{Deprecated. The required SKSE version now depends on the runtime; use GetRequiredSKSEVersion().}

int property CAMPFIRE_MIN_VERSION = 11100 autoReadOnly

GlobalVariable property _Seed_PreviousVersion auto
GlobalVariable property _Seed_LastSeedVersion auto
GlobalVariable property _Camp_IsSpecialEdition auto

Spell property _Seed_IntensityPlayerSpell auto
Spell property _Seed_CheckNeedsSpell auto

string CONFIG_PATH = "../LastSeedData/"
bool datastore_update_required = false

;#PROPERTIES=====================================================================================================================
actor property PlayerRef auto
ReferenceAlias property PlayerAlias auto

bool property isSkyrimVR auto hidden							; Skyrim VR
bool property isSkyrimSE auto hidden						; Skyrim Special Edition
bool property isSKYUILoaded auto hidden						; SkyUI 4.1+
bool property isSKSELoaded auto hidden						; SKSE 1.7.3+ / SKSE64 2.0.20+ / SKSEVR 2.0.12+
bool property isFrostfallLoaded auto hidden					; Frostfall
bool property isCACOLoaded auto hidden						; Complete Alchemy and Cooking Overhaul

;#Spellbooks===================================================================

;#Scrolls======================================================================

;#Campfire Skill System============================================================
Activator property _Seed_PerkNodeController_Provisioning auto

;#Misc=============================================================================
Message property _Seed_CriticalError_SKSE auto
Message property _Seed_CriticalError_Campfire auto

;#Upgrade Flags====================================================================

;#Release Notes====================================================================


Event OnPlayerLoadGame()
	RunCompatibility()
	; RegisterForKeysOnLoad()
	; RegisterForControlsOnLoad()
	RegisterForEventsOnLoad()

	; Notify that we are finished loading up.
	SendEvent_LastSeedLoaded()
endEvent

function ErrorSKSE(int version)
	int min_version = GetRequiredSKSEVersion()
	if version
		trace("[LastSeed][Warning] Detected " + GetSKSEName() + " version " + FormatSKSEVersion(version) + ". Expected " + FormatSKSEVersion(min_version) + " or newer. Using Fallback Mode.")
	else
		trace("[LastSeed][Warning] " + GetSKSEName() + " was not detected. Expected version " + FormatSKSEVersion(min_version) + " or newer. Using Fallback Mode.")
	endif
	_Seed_CriticalError_SKSE.Show(((version as float) / 10000), ((min_version as float) / 10000))
endFunction

function FatalErrorCampfire(float version)
	float version_formatted = ((version as float) / 10000)
	float min_version_formatted = ((CAMPFIRE_MIN_VERSION as float) / 10000)
	trace("[LastSeed][ERROR] Detected Campfire version " + version_formatted + ", out of date! Expected " + min_version_formatted + " or newer.")
	while true
		_Seed_CriticalError_Campfire.Show(version_formatted, min_version_formatted)
		utility.wait(3.0)
	endWhile
endFunction

function RunCompatibility()
	trace("[LastSeed]======================================================================================================")
	trace("[LastSeed]                    Last Seed is now performing start-up and compatibility checks.                    ")
	trace("[LastSeed]     Papyrus warnings related to missing files may follow. These are NORMAL and should be ignored.    ")
	trace("[LastSeed]======================================================================================================")

	; Identify the runtime before checking SKSE, so that the correct minimum version is applied.
	int skse_major = SKSE.GetVersion()
	DetectGameRuntime(skse_major)

	int skse_min_version = GetRequiredSKSEVersion()
	string skse_name = GetSKSEName()
	if skse_major
		int skse_version = (skse_major * 10000) + (SKSE.GetVersionMinor() * 100) + SKSE.GetVersionBeta()
		if skse_version < skse_min_version
			isSKSELoaded = false
			ErrorSKSE(skse_version)
		else
			isSKSELoaded = true
			trace("[LastSeed] Detected " + skse_name + " version " + FormatSKSEVersion(skse_version) + " (expected " + FormatSKSEVersion(skse_min_version) + " or newer, success!)")
		endif
	else
		isSKSELoaded = false
		ErrorSKSE(0)
	endif

	VanillaGameLoadUp()

	; Verify that the food datastore has been populated.
	CheckDatastore()

	; Update the previous version value with the current version
	_Seed_PreviousVersion.SetValue(_Seed_LastSeedVersion.GetValue())

	float campfire_version = CampUtil.GetCampfireVersion()
	if campfire_version < CAMPFIRE_MIN_VERSION
		FatalErrorCampfire(campfire_version)
	else
		trace("[LastSeed] Detected Campfire version " + campfire_version + " (expected " + CAMPFIRE_MIN_VERSION + " or newer, success!)")
	endif

	isSKYUILoaded = IsPluginLoaded(0x01000814, "SkyUI.esp") || IsPluginLoaded(0x01000814, "SkyUI_SE.esp")
	isFrostfallLoaded = IsPluginLoaded(0x00064AF8, "Frostfall.esp")

	trace("[LastSeed]======================================================================================================")
	trace("[LastSeed]                      Last Seed start-up and compatibility checks complete.   		                ")
	trace("[LastSeed]======================================================================================================")

	if isSKYUILoaded
		; SendEvent_SKSE_LoadProfileOnStartup()
	endif
	
	; RegisterForControlsOnLoad()
	RegisterForEventsOnLoad()
	; RegisterForMenusOnLoad()
	AddStartupSpells()
	; RegisterCampfireSkill()

	; Load a meter preset for the user's display aspect ratio
	SendEvent_SKSE_ApplyMeterPreset(2)
endFunction

function VanillaGameLoadUp()
	; TBD
endFunction

function RegisterForControlsOnLoad()
	; TBD
endFunction

function RegisterForEventsOnLoad()
	GetHungerSystem().RegisterForEvents()
	GetThirstSystem().RegisterForEvents()
	GetFatigueSystem().RegisterForEvents()
	GetVitalityMeterHandler().RegisterForEvents()
	GetHungerMeterHandler().RegisterForEvents()
endFunction

function AddStartupSpells()
	PlayerRef.AddSpell(_Seed_IntensityPlayerSpell)
	PlayerRef.AddSpell(_Seed_CheckNeedsSpell)
endFunction

function SendEvent_LastSeedLoaded()
	FallbackEventEmitter emitter = GetEventEmitter_LastSeedLoaded()
	int handle = emitter.Create("LastSeed_Loaded")
	if handle
		emitter.Send(handle)
	endif
endFunction

function RegisterCampfireSkill()
	GlobalVariable CampfireAPIVersion = Game.GetFormFromFile(0x03F1BE, "Campfire.esm") as GlobalVariable
	if CampfireAPIVersion && CampfireAPIVersion.GetValueInt() >= 4
		bool b = CampUtil.RegisterPerkTree(_Seed_PerkNodeController_Provisioning, "LastSeed.esp")
	else
		debug.trace("[Campfire] ERROR: Unable to register Campfire Skill System for LastSeed.esp. Campfire was not found or the version loaded is not compatible. Expected CampUtil API 4 or higher, got " + CampfireAPIVersion.GetValueInt())
	endif
endFunction

function CheckDatastore()
	SeedDebug(3, "Implement datastore sanity checking not yet implemented.")
	; @TODO
endFunction

; Always resolved through GetFormFromFile. Game.GetModByName() returns 255 for light
; (ESL-flagged) plugins on Special Edition, which reported any such plugin as missing.
bool function IsPluginLoaded(int iFormID, string sPluginName)
	bool b = Game.GetFormFromFile(iFormID, sPluginName)
	if b
		debug.trace("[LastSeed] Loaded: " + sPluginName)
		return true
	else
		return false
	endif
endFunction

; Identifies which Skyrim runtime we are running on.
; SKSE 1.x is the 32-bit Legendary Edition build; SKSE64 and SKSEVR both report 2.x.
; Skyrim VR is told apart from Special Edition by its own master file.
;
; UNVERIFIED: 0x00000BD7 has not been read out of a shipped SkyrimVR.esm - confirm it in
; SSEEdit. Getting it wrong costs nothing on Special Edition, where SkyrimVR.esm is never
; present and the lookup correctly fails, but it would leave a VR game running the Special
; Edition code paths and silently disable the VR handling in CampCampfire, CampTent and
; _Camp_LightFireFurnScript.
;
; When SKSE is absent there is nothing to read the runtime from, so we fall back to the
; _Camp_IsSpecialEdition global. That global has to be set to 2 in the Special Edition
; build of Campfire.esm; this repository ships a single plugin for both runtimes and
; currently leaves it at 1, so the fallback identifies a Special Edition game with no SKSE
; installed as Legendary Edition. ssecheck.py fails a Special Edition build over it.
function DetectGameRuntime(int aiSKSEVersionMajor)
	isSkyrimVR = IsPluginLoaded(0x00000BD7, "SkyrimVR.esm")
	if aiSKSEVersionMajor >= 2
		isSkyrimSE = !isSkyrimVR
	elseif aiSKSEVersionMajor == 0 && _Camp_IsSpecialEdition
		isSkyrimSE = !isSkyrimVR && _Camp_IsSpecialEdition.GetValueInt() == 2
	else
		isSkyrimSE = false
	endif

	if isSkyrimVR
		trace("[LastSeed] Detected runtime: Skyrim VR.")
	elseif isSkyrimSE
		trace("[LastSeed] Detected runtime: Skyrim Special Edition.")
	else
		trace("[LastSeed] Detected runtime: Skyrim Legendary Edition.")
	endif
endFunction

; The minimum SKSE version Last Seed supports on the current runtime.
int function GetRequiredSKSEVersion()
	if isSkyrimVR
		return SKSE_MIN_VERSION_VR
	elseif isSkyrimSE
		return SKSE_MIN_VERSION_SE
	endif
	return SKSE_MIN_VERSION_LE
endFunction

; The name of the SKSE build expected on the current runtime, for logging.
string function GetSKSEName()
	if isSkyrimVR
		return "SKSEVR"
	elseif isSkyrimSE
		return "SKSE64"
	endif
	return "SKSE"
endFunction

; Renders an encoded SKSE version as major.minor.build. Printing the encoded value as a
; float renders SKSE64 2.0.20 as "2.002", which reads as older than SKSE 1.7.3.
string function FormatSKSEVersion(int aiVersion)
	int major = aiVersion / 10000
	int minor = (aiVersion % 10000) / 100
	int build = aiVersion % 100
	return (major as string) + "." + (minor as string) + "." + (build as string)
endFunction

;@NOFALLBACK
function SendEvent_SKSE_ApplyMeterPreset(int aiValue)
	if isSKSELoaded
		int handle = ModEvent.Create("LastSeed_ApplyMeterPreset")
		if handle
			ModEvent.PushInt(handle, aiValue)
			ModEvent.Send(handle)
		endif
	endif
endFunction