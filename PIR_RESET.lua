-- Check the wiki at
-- http://www.domoticz.com/wiki/%27dzVents%27:_next_generation_LUA_scripting
return {

	-- 'active' controls if this entire script is considered or not
	active = false, -- set to false to disable this script

	-- trigger
	-- can be a combination:
	on = {
		timer = {
			-- timer triggers.. if one matches with the current time then the script is executed
			'every minute'
		}
	},

	-- actual event code
	-- in case of a timer event or security event, device == nil
	execute = function(domoticz, device)
		--[[

		The domoticz object holds all information about your Domoticz system. E.g.:

		local myDevice = domoticz.devices('myDevice')
		local myVariable = domoticz.variables('myUserVariable')
		local myGroup = domoticz.groups('myGroup')
		local myScene = domoticz.sceneds('myScene')

		The device object is the device that was triggered due to the device in the 'on' section above.
		]] --
		-- example
		
		--domoticz.log('pir disabled = ' .. domoticz.globalData.pirDisabled)
		
		domoticz.devices('WDW01').switchOff()
		domoticz.devices('WDW02').switchOff()
		domoticz.devices('WDW03').switchOff()

		domoticz.devices('PIR01').switchOff()
		domoticz.devices('PIR02').switchOff()
		domoticz.devices('PIR03').switchOff()
		domoticz.devices('PIR04').switchOff()

	end
}