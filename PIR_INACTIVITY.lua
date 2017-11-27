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
			domoticz.log('switched pirDisabled to ' .. tostring(domoticz.globalData.pirDisabled) .. ' because of PIR virtual switch toggle')
		end
		
		-- when pirDisabled equals true, we're going to ignore the pir events
		if (domoticz.globalData.pirDisabled == true) then
			domoticz.log('Exiting PIR inactivity script because PIR is disabled.')
		    return
		end


		local inactivityPeriod = 15
		local Time = require('Time')
		local lastActivationRaw = domoticz.globalData.eye01Activation.getLatest().data
		local lastUpdate = eye01.lastUpdate
		
		if (lastActivationRaw ~= nil) then
			local lastActivationTime = Time(lastActivationRaw)
			local currentTime = Time()
			local minutesActivated = lastActivationTime.compare(lastUpdate)
			if (minutesActivated.mins < 15) then
				inactivityPeriod = minutesActivated.mins
			end
		end

		local timeLastUpdate = lastUpdate.minutesAgo
		local tmpBool = lastUpdate.minutesAgo >= inactivityPeriod
	
		if (eye01.state == 'Off' and lastUpdate.minutesAgo >= inactivityPeriod and (dim02.state ~= 'Off' or dim03.state ~= 'Off') ) then
			dim02.switchOff()
			dim03.switchOff()
			domoticz.log('Switched off bedroom lights because of PIR inactivity')
		end
	end
}