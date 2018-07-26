-- Check the wiki at
-- http://www.domoticz.com/wiki/%27dzVents%27:_next_generation_LUA_scripting
return {

	-- 'active' controls if this entire script is considered or not
	active = true, -- set to false to disable this script

	-- trigger
	-- can be a combination:
	on = {
		timer = {
			'60 minutes after sunrise',
			'120 minutes before sunset'
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
		local myScene = domoticz.scenes('myScene')

		The device object is the device that was triggered due to the device in the 'on' section above.
		]] --
		-- example

		local wateringSwitch = 411
		local vegetableGarden = 408
		local sprinklers = 409
		local sprinklerDuration = 25
		local gardenDuration = 10
		local expectedRain = 413

		local rainIsComing = domoticz.devices(expectedRain).state == 'On'
		if (rainIsComing) then
			domoticz.log('Skipping automated watering of the garden, rain is underway!')
		elseif (domoticz.devices(wateringSwitch).state == 'On') then
			domoticz.log('Switching on sprinkler installation in backyard for ' .. sprinklerDuration .. ' minutes.')
			domoticz.devices(sprinklers).switchOn().forMin(sprinklerDuration)
	
			domoticz.log('After sprinklers, the vegetable garden will get water for an additional ' .. gardenDuration .. ' minutes.')
			domoticz.devices(vegetableGarden).switchOn().afterMin(sprinklerDuration).forMin(gardenDuration)
		end
	end
}