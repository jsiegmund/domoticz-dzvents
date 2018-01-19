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
		    45
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
		
		local pir04 = domoticz.devices(45)
		local pirEnabled = domoticz.devices(158)
		local dim04 = domoticz.devices(71)
		
		if (domoticz.globalData.pirDisabled) then
			return
		end

		-- when the script was triggered by the pir sensor, we need to check whether the light should be activated
		if (device ~= nil and device.id == pir04.id) then

			local level = 0

			if (switchSleepMode.state == "On") then
				level = 20
			elseif (switchNightMode.state == "On") then
				level = 50
			elseif (switchDayMode.state == "On") then
				return
			end

			dim04.dimTo(level)
		    domoticz.log('Switched on lights in downstairs hallway as EYE01 detected motion at night time.')

			-- this should go INSIDE the if loop
			local Time = require('Time')
			local currentTime = Time().raw
			domoticz.log('storing the activation time in global: ' .. tostring(currentTime))
			domoticz.globalData.pir04Activation.add(currentTime)

			return
		end
		
		-- when pirDisabled equals true, we're going to ignore the pir events
		if (domoticz.globalData.pirDisabled == true) then
			domoticz.log('Exiting PIR inactivity script because PIR is disabled.')
		    return
		end

		local inactivityPeriod = 15
		local Time = require('Time')
		local lastActivationRaw = domoticz.globalData.pir04Activation.getLatest().data
		local lastUpdate = pir04.lastUpdate
		
		if (lastActivationRaw ~= nil) then
			local lastActivationTime = Time(lastActivationRaw)
			local currentTime = Time()
			local minutesActivated = lastActivationTime.compare(lastUpdate)
			if (minutesActivated.mins < 10) then
				inactivityPeriod = minutesActivated.mins
			else 
				inactivityPeriod = 10
			end
		end

		local timeLastUpdate = lastUpdate.minutesAgo
		local tmpBool = lastUpdate.minutesAgo >= inactivityPeriod
	
		if (pir04.state == 'Off' and lastUpdate.minutesAgo >= inactivityPeriod and dim04.state ~= 'Off') then
			dim04.switchOff()
			domoticz.log('Switched off hallway light first floor because of PIR inactivity')
		end
	end
}
