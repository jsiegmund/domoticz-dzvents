-- Check the wiki at
-- http://www.domoticz.com/wiki/%27dzVents%27:_next_generation_LUA_scripting
return {

	-- 'active' controls if this entire script is considered or not
	active = true, -- set to false to disable this script

	-- trigger
	-- can be a combination:
	on = {
		devices = {
			138
		},
		timer = {
		    'at 00:00'
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
		
		local switchSleepMode = domoticz.devices(138)
		
		if (device == nil) then
        	domoticz.log('Reset PIR disabled to false at midnight.')
			domoticz.globalData.pirDisabled = false
		end
		
        if (device == nil and switchSleepMode.state == 'Off') then 
			switchSleepMode.switchOn()   
            domoticz.log('Automatically switched to sleep mode at 00:00.')
		end
	end
}