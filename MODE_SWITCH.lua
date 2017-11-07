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
			138,
			139,
			140
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
		
		-- 138 = VIRT03 sleep mode
        -- 139 = VIRT04 night mode
        -- 140 = VIRT05 day mode
        
		]] --
		
        local switchSleepMode = domoticz.devices(138)
        local switchNightMode = domoticz.devices(139)
        local switchDayMode = domoticz.devices(140)
		
		if (device.idx == switchSleepMode.idx and device.state == 'On') then
		    switchNightMode.switchOff()
		    switchDayMode.switchOff()
			domoticz.log('Switched to Sleep Mode triggered by switch')
		elseif (device.idx == switchNightMode.idx and device.state == 'On') then
		    switchSleepMode.switchOff()
		    switchDayMode.switchOff()
			domoticz.log('Switched to Night Mode triggered by switch')
        elseif (device.idx == switchDayMode.idx and device.state == 'On') then
	        switchSleepMode.switchOff()
		    switchNightMode.switchOff()
			domoticz.log('Switched to Day Mode triggerd by switch ')
		end
	end
}