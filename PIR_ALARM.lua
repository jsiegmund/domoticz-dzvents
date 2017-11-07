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
			15, -- EYE01 (Hal)
			35, -- EYE02 (Living room)
			40  -- EYE03 (Kitchen)
		},
		security = { domoticz.SECURITY_ARMEDAWAY }
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
		
		domoticz.log('caught event for EYE01 alarm')
        domoticz.log('device.state = ' .. device.state)
        domoticz.log('device 141.state = ' .. domoticz.devices(141).state)
        domoticz.log('domoticz.security = ' .. domoticz.security)

		if (device.state == 'On' and domoticz.devices(141).state == 'Off' and domoticz.security == SECURITY_ARMEDAWAY) then
		    domoticz.log('Motion sensor ' .. device.name .. ' triggered the alarm!')
		    
		    domoticz.devices(141).switchOn().forMin(5)
			domoticz.notify('ALARM', 'Motion sensor ' .. device.name .. ' triggered the alarm!')
		end
	end
}