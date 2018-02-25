return {
    helpers = {
        switchOffAfterInactivity = function(domoticz, dimmer, pir, inactivityPeriod) 
            if (dimmer.state == 'On' and pir.state == 'Off') then
                local Time = require('Time')
                local currentTime = Time()
                local lastUpdate = pir.lastUpdate
                local timeSinceLastMovement = currentTime.compare(lastUpdate)
    
                if (timeSinceLastMovement.mins >= inactivityPeriod) then
                    dimmer.switchOff()
                    domoticz.log('Switched off ' .. dimmer.name .. ' because of long period of inactivity ( ' .. timeSinceLastMovement.mins .. ' ) on ' .. pir.name)
                end
            end
        end,
        STATIC_PIR01 = 15,          -- Hal BG
        STATIC_PIR02 = 208,         -- Woonkamer
        STATIC_PIR03 = 216,         -- Eettafel / keuken
        STATIC_PIR04 = 45,          -- Hal 1e
        STATIC_DIM01 = 1,           -- Huiskamer
        STATIC_DIM02 = 57,          -- Eettafel
        STATIC_DIM03 = 166,         -- Rails
        STATIC_DIM04 = 71,          -- Hal boven
        STATIC_DIM05 = 77,          -- Inloopkast
        STATIC_DIM06 = 168,         -- Keuken
        STATIC_DIM07 = 234,         -- Keuken (eiland)
        STATIC_DIM08 = 219,         -- Hal beneden
        STATIC_DIM09 = 283,         -- Slaapkamer
        STATIC_VIRT07 = 158        -- PIR enabled        
    },
    data = {
        pirDisabled = { initial = false },
        pirDisabledLivingRoom = { initial = false },
        pirDisabledKitchen = { initial = false },
        pirDisabledHallway = { initial = false },
        pirDisabledFirstFloor = { initial = false },
        pir01Activation = { history = true, maxItems = 2 },
        pir02Activation = { history = true, maxItems = 2 },
        pir03Activation = { history = true, maxItems = 2 },
        pir04Activation = { history = true, maxItems = 2 }
    }
}