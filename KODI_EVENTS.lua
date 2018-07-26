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

		if (nightModeSwitch.state ~= 'On') then
			domoticz.log('Exiting KODI_EVENTS script because the system is NOT in night mode.')
			return
		end

		local movieLightsScene = domoticz.scenes(9)
		local normalLightsScene = domoticz.scenes(22)
		local pauseLightsScene = domoticz.scenes(23)
		
		-- when movie is playing; switch on movie mode
		if (device.state == 'Video') then
		    movieLightsScene.switchOn()		-- start movie scene
		    domoticz.log('Switched to movie mode because its night time and theres a movie playing')
		end

		-- when movie scene is active and the movie is paused of stopped; switch scenes
		if (movieLightsScene.state == 'On') then		
			if (device.state == 'Paused') then
				movieLightsScene.switchOff()
				pauseLightsScene.switchOn()
				domoticz.log('Switched to normal lights when the movie when on Pause')
			end
			if (device.state == 'Stopped') then
				movieLightsScene.switchOff()
			    normalLightsScene.switchOn()
				domoticz.log('Switched to normal lights when the movie is Stopped')
			end
		end
		 
	end
}