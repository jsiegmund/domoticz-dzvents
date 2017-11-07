-- Check the wiki at
-- http://www.domoticz.com/wiki/%27dzVents%27:_next_generation_LUA_scripting
return {

	-- 'active' controls if this entire script is considered or not
	active = true, -- set to false to disable this script

	-- trigger
	-- can be a combination:
	on = {
		timer = {
			-- timer triggers.. if one matches with the current time then the script is executed
			'every minute'
		},
		devices = {
		    158
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
		
		if (domoticz ~= nil and domoticz.globalData ~= nil and domoticz.globalData.pirDisabled ~= nil) then
	        domoticz.log('PIR script with pirDisabled = ' .. tostring(domoticz.globalData.pirDisabled))
	    else
	        domoticz.log('PIR script with pirDisabled nil')
		end

		local switchSleepMode = domoticz.devices(138)
        local switchNightMode = domoticz.devices(139)
        local switchDayMode = domoticz.devices(140)
		
		local eye01 = domoticz.devices(15)
		local dim02 = domoticz.devices(1)
		local dim03 = domoticz.devices(57)
		
		-- when the device has been switched; we need to correct the pirDisabled state because the user requested it
		if (device ~= nil) then
			domoticz.globalData.pirDisabled = device.state == 'Off'
			if (domoticz.globalData.pirDisabled) then
				domoticz.log('switched on pirDisabled because of PIR virtual switch toggle')
			else
				domoticz.log('switched off pirDisabled because of PIR virtual switch toggle')
			end
		end
		
		-- when pirDisabled equals true, we're going to ignore the pir events
		if (domoticz.globalData.pirDisabled == true) then
		    return
		end
		
		if (eye01.state == 'Off' and eye01.lastUpdate.minutesAgo > 15 and (dim02.state ~= 'Off' or dim03.state ~= 'Off') ) then
			dim02.switchOff()
			dim03.switchOff()
			domoticz.log('Switched off bedroom lights because of PIR inactivity')
		end
	end
}