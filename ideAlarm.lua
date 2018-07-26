--[[
ideAlarm.lua

Please read: https://github.com/allan-gam/ideAlarm/wiki

Do not change anything in this file.
--]]

local alarm = require "ideAlarmModule"

local triggerDevices = alarm.triggerDevices()

local data = {}
data['nagEvent'] = {history = true, maxItems = 1}
for i = 1, alarm.qtyAlarmZones() do
	data['nagZ'..tostring(i)] = {initial=0}
end

return {
	active = true,
	logging = {
		level = alarm.loggingLevel(domoticz), -- Can be set in the configuration file
		marker = alarm.version()
	},
	on = {
		devices = triggerDevices,
		security = {domoticz.SECURITY_ARMEDAWAY, domoticz.SECURITY_ARMEDHOME, domoticz.SECURITY_DISARMED},
		timer = alarm.timerTriggers()
	},
	data = data,
	execute = function(domoticz, device, triggerInfo)
		if device == nil then
			domoticz.log('Triggered with device = nil, not executing.')
		else
			--domoticz.log('Triggered by '..((device) and 'device: '..device.name..', device state is: '..device.state or 'Domoticz Security'), domoticz.LOG_DEBUG)
		end

		domoticz.log('Alarm triggered. Trigger type = ' .. triggerInfo.type)
		alarm.execute(domoticz, device, triggerInfo)
	end
}
