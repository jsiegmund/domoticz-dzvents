-- Check the wiki at
-- http://www.domoticz.com/wiki/%27dzVents%27:_next_generation_LUA_scripting
return {

	-- 'active' controls if this entire script is considered or not
	active = true, -- set to false to disable this script

	-- trigger
	-- can be a combination:
	on = {
		timer = {
			'at sunrise'
		}
	},

	-- actual event code
	-- in case of a timer event or security event, device == nil
	execute = function(domoticz)
		--[[

		The domoticz object holds all information about your Domoticz system. E.g.:

		local myDevice = domoticz.devices('myDevice')
		local myVariable = domoticz.variables('myUserVariable')
		local myGroup = domoticz.groups('myGroup')
		local myScene = domoticz.sceneds('myScene')

		The device object is the device that was triggered due to the device in the 'on' section above.
		
		-- 138 = VIRT03 sleep mode
        -- 139 = VIRT04 night mode
        -- 140 = VIRT05 day mode
        
		]] --
		
		local switchSleepMode = domoticz.devices(138)
        local switchNightMode = domoticz.devices(139)
		local switchDayMode = domoticz.devices(140)
		local pirSwitch = domoticz.devices(158)

		domoticz.log('Rise and shine! Switching the house to day mode and disabling PIR triggering.')
		switchDayMode.switchOn()
		pirSwitch.switchOff()
	end
}