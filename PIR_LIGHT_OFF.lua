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
			'every 5 minutes'
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

		-- when pirDisabled equals true, we're going to ignore the pir events
		if (domoticz.globalData.pirDisabled == true) then
			domoticz.log('Exiting PIR inactivity script because PIR is disabled.')
			return
		end

		local pir01 = domoticz.devices(domoticz.helpers.STATIC_PIR01)
		local pir02 = domoticz.devices(domoticz.helpers.STATIC_PIR02)
		local pir03 = domoticz.devices(domoticz.helpers.STATIC_PIR03)
		local pir04 = domoticz.devices(domoticz.helpers.STATIC_PIR04)
				
		local inactivityPeriod = 60		-- number of minutes a PIR is inactive before the light is switch off

		-- Dimmers in the living room react to PIR02 inactivity
		local dim01 = domoticz.devices(domoticz.helpers.STATIC_DIM01)
		domoticz.helpers.switchOffAfterInactivity(domoticz, dim01, pir02, inactivityPeriod)

		-- Dimmers in the back of the house react to PIR03 inactivity 
		local dim02 = domoticz.devices(domoticz.helpers.STATIC_DIM06)
		domoticz.helpers.switchOffAfterInactivity(domoticz, dim02, pir03, inactivityPeriod)
		local dim06 = domoticz.devices(domoticz.helpers.STATIC_DIM06)
		domoticz.helpers.switchOffAfterInactivity(domoticz, dim06, pir03, inactivityPeriod)
		local dim07 = domoticz.devices(domoticz.helpers.STATIC_DIM07)
		domoticz.helpers.switchOffAfterInactivity(domoticz, dim07, pir03, inactivityPeriod)
	end
}
