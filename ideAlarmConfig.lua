--[[
Edit this file suit your needs 
Place this file in the dzVents scripts folder using the name ideAlarmConfig.lua

See https://github.com/allan-gam/ideAlarm/wiki/configuration
After editing, always verify that it's valid LUA at http://codepad.org/ (Mark your paste as "Private"!!!)
--]]

local _C = {}

local SENSOR_CLASS_A = 'a' -- Sensor can be triggered in both arming modes. E.g. "Armed Home" and "Armed Away".
local SENSOR_CLASS_B = 'b' -- Sensor can be triggered in arming mode "Armed Away" only.

--[[
-------------------------------------------------------------------------------
DO NOT ALTER ANYTHING ABOVE THIS LINE
-------------------------------------------------------------------------------
--]]

_C.ALARM_TEST_MODE = false -- if ALARM_TEST_MODE is set to true it will prevent audible alarm

-- Interval for how often we shall trigger the script to check if nagging about open doors needs to be made 
_C.NAG_SCRIPT_TRIGGER_INTERVAL = {'every other minute'} -- Format as defined by dzVents timers
-- Interval for how often we shall repeat nagging.
_C.NAG_INTERVAL_MINUTES = 6 

-- Number of seconds which after the alert devices will be turned off
-- automatically even if an active alert situation still exists.
-- 0 = Disable automatic turning off alert devices.   
_C.ALARM_ALERT_MAX_SECONDS = 30

--	Uncomment 3 lines below to override the default logging level
--	_C.loggingLevel = function(domoticz)
--		return domoticz.LOG_INFO -- Select one of LOG_DEBUG, LOG_INFO, LOG_ERROR, LOG_FORCE to override system log level
--	end

--	If You named your Domoticz Security Panel different from "Security Panel", uncomment the line below to specify the name.
-- _C.SECURITY_PANEL_NAME = 'Security Panel Fancy Name'

_C.ALARM_ZONES = {
	-- Start configuration of the first alarm zone
	{
		name='Peellandhof',
		armingModeTextDevID=153,
		statusTextDevID=154,
		entryDelay=30,
		exitDelay=30,
		alertDevices={124,127},
		sensors = {
--			['PIR01'] = {['class'] = SENSOR_CLASS_A, ['nag'] = false, ['nagTimeoutMins'] = 5, ['armWarn'] = false, ['enabled'] = true},
--			['PIR02'] = {['class'] = SENSOR_CLASS_A, ['nag'] = false, ['nagTimeoutMins'] = 5, ['armWarn'] = true, ['enabled'] = true},
--			['PIR03'] = {['class'] = SENSOR_CLASS_A, ['nag'] = false, ['nagTimeoutMins'] = 5, ['armWarn'] = true, ['enabled'] = true},
--			['PIR04'] = {['class'] = SENSOR_CLASS_B, ['nag'] = false, ['nagTimeoutMins'] = 5, ['armWarn'] = true, ['enabled'] = true},
--			['WDW01'] = {['class'] = SENSOR_CLASS_A, ['nag'] = true, ['nagTimeoutMins'] = 5, ['armWarn'] = true, ['enabled'] = true},
--			['WDW02'] = {['class'] = SENSOR_CLASS_A, ['nag'] = true, ['nagTimeoutMins'] = 5, ['armWarn'] = true, ['enabled'] = true},
--			['WDW03'] = {['class'] = SENSOR_CLASS_A, ['nag'] = true, ['nagTimeoutMins'] = 5, ['armWarn'] = true, ['enabled'] = true},
			['Hal BG (PIR01)'] = {['class'] = SENSOR_CLASS_A, ['nag'] = false, ['nagTimeoutMins'] = 5, ['armWarn'] = false, ['enabled'] = true},
			['Woonkamer (PIR02)'] = {['class'] = SENSOR_CLASS_A, ['nag'] = false, ['nagTimeoutMins'] = 5, ['armWarn'] = true, ['enabled'] = true},
			['Eettafel / keuken (PIR03)'] = {['class'] = SENSOR_CLASS_A, ['nag'] = false, ['nagTimeoutMins'] = 5, ['armWarn'] = true, ['enabled'] = true},
			['Hal 1e (PIR04)'] = {['class'] = SENSOR_CLASS_B, ['nag'] = false, ['nagTimeoutMins'] = 5, ['armWarn'] = true, ['enabled'] = true},
			['Voordeur (WDW01)'] = {['class'] = SENSOR_CLASS_A, ['nag'] = true, ['nagTimeoutMins'] = 5, ['armWarn'] = true, ['enabled'] = true},
			['Tuindeuren (WDW02)'] = {['class'] = SENSOR_CLASS_A, ['nag'] = true, ['nagTimeoutMins'] = 5, ['armWarn'] = true, ['enabled'] = true},
			['Keukenraam (WDW03)'] = {['class'] = SENSOR_CLASS_A, ['nag'] = true, ['nagTimeoutMins'] = 5, ['armWarn'] = true, ['enabled'] = true}
		},
		armAwayToggleBtn='Toggle Z1 Arm Away',
		armHomeToggleBtn='Toggle Z1 Arm Home',
		mainZone = true,
		canArmWithTrippedSensors = false,
		syncWithDomoSec = true, -- Only a single zone is allowed to sync with Domoticz's built in Security Panel
	},
	-- End configuration of the first alarm zone
}

return _C
