-- Check the wiki at
-- http://www.domoticz.com/wiki/%27dzVents%27:_next_generation_LUA_scripting
return {

	-- 'active' controls if this entire script is considered or not
	active = true, -- set to false to disable this script

	-- trigger
	-- can be a combination:
	on = {
		timer = {
			'60 minutes before sunset',
			'60 minutes after sunrise'
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

		local wateringSwitch = 411
		local sprinklers = 409
		local duration = 45	
		
		if (domoticz.devices(wateringSwitch).state == 'On') then
			domoticz.log('Switching on sprinkler installation in backyard for ' .. duration .. ' minutes')
			domoticz.devices(sprinklers).switchOn()
			domoticz.devices(sprinklers).switchOff().afterMin(duration)
		end
	end
}