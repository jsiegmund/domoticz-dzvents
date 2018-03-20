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
			143, -- 143 = mediapi
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
		
		domoticz.log('handling kodi event' .. device.state )
		
		local nightModeSwitch = domoticz.devices(139)
		
		-- when at night and movie is playing; switch on movie mode
		if (nightModeSwitch.state == 'On' and device.state == 'Video') then
		    domoticz.scenes(9).switchOn()		-- start movie scene
		    domoticz.log('Switched to movie mode because its night time and theres a movie playing')
		end
		
		if (domoticz.scenes(9).state == 'On' and (device.state == 'Paused' or device.state == 'Stopped')) then
		    domoticz.scenes(1).switchOn()       -- normal lights scene
		    domoticz.log('Switched to normal lights when the movie when on Pause')
		end
		 
	end
}