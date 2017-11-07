-- Check the wiki at
-- http://www.domoticz.com/wiki/%27dzVents%27:_next_generation_LUA_scripting
return {

	-- 'active' controls if this entire script is considered or not
	active = true, -- set to false to disable this script

	-- trigger
	-- can be a combination:
	on = {
		devices = {
			-- scripts is executed if the device that was updated matches with one of these triggers
			15 -- EYE01 (Hal)
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
		
		if (device.state == 'On' and domoticz.devices(139).state == 'On' and domoticz.devices(1).state == 'Off' and domoticz.devices(57).state == 'Off') then
		    domoticz.scenes('Licht aan').switchOn()
		    domoticz.log('Switched on "Licht aan" as EYE01 detected motion at night time.')
		end
	end
}