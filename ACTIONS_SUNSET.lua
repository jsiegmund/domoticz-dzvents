-- Check the wiki at
-- http://www.domoticz.com/wiki/%27dzVents%27:_next_generation_LUA_scripting
return {

	-- 'active' controls if this entire script is considered or not
	active = true, -- set to false to disable this script

	-- trigger
	-- can be a combination:
	on = {
		timer = {
			'at sunset'
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

		domoticz.log('The sun is setting, executing all sunrise actions.')

		local rel06 = domoticz.devices(83)
		rel06.switchOn() 						-- turn off the entrance light
	end
}