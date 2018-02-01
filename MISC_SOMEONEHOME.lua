-- Check the wiki at
-- http://www.domoticz.com/wiki/%27dzVents%27:_next_generation_LUA_scripting
return {

	-- 'active' controls if this entire script is considered or not
	active = true, -- set to false to disable this script

	-- trigger
	-- can be a combination:
	on = {
		devices = {
			96,
			97
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

		local phone1 = domoticz.devices(96)     -- phone 1 signal
		local phone2 = domoticz.devices(97)     -- phone 2 signal
		local switch = domoticz.devices(98)		-- virtual switch for presence
		
		-- when the switch is off and any of the phones is on; toggle the switch
		if (switch.state == 'Off' and (phone1.state == 'On' or phone2.state == 'On')) then
			domoticz.log('Toggling the "someone home" switch to ON due to status toggle of device ' .. device.id)
			switch.switchOn()
		-- when the switch is on but there's no phone on; toggle the switch
		elseif (switch.state == 'On' and (phone1.state == 'Off' and phone2.state == 'Off')) then
			domoticz.log('Toggling the "someone home" switch to OFF due to status toggle of device ' .. device.id)
			switch.switchOff()
		end

	end
}