ESX = exports["es_extended"]:getSharedObject()
local openActive = false
local isMenuActive = false

Citizen.CreateThread(function()
    while true do

        if not openActive then 
            DisplayMinimap(true) -- Set Radar online
        end 

        if isMenuActive and not openActive then 
            SetPauseMenuActive(true) -- Set default pauseMenu true
        else 
            SetPauseMenuActive(false) -- Set default pauseMenu false
        end 

        if (IsControlJustPressed(1,200)) and not (openActive or IsPauseMenuActive()) then
            pauseGame()
        end

        if (IsControlJustPressed(1,199)) and not (openActive or IsPauseMenuActive()) then
            showMap()
        end

        -- Resume game if you press ESCAPE and pauseMenu is active 
        if IsControlJustPressed(1,200) and IsPauseMenuActive() then 
            resumeGame()
        end

        Wait(0)
    end
end)

-- =~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=
-- Functions
function pauseGame()
    openActive = true
    isMenuActive = false
    SetPauseMenuActive(false)
    DisplayMinimap(false)

    -- Send Datas 
    SendNUIMessage({
        action = "uiEnabled"
    })

    AsyncSendData()

    SetNuiFocus(true, true)
        
    Citizen.CreateThread(function()
        SetTimecycleModifierStrength(0)

        SetTimecycleModifier("hud_def_blur");
        for i=0,1,0.05 do
            SetTimecycleModifierStrength(i)
            Citizen.Wait(0)
        end
    end)
end

function DisplayMinimap(bool)
    DisplayRadar(bool)

    if (bool) then
        TriggerEvent("mHud:ShowHud")
    else
        TriggerEvent("mHud:HideHud")
    end
end

function resumeGame()
    openActive = false
    isMenuActive = false
    SendNUIMessage({action = "uiDisabled"})
    SetNuiFocus(false, false)
    
    ClearTimecycleModifier()
end

function showMap()
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), 0, -1)
    openActive = true
    isMenuActive = true
    
    SendNUIMessage({action = "uiDisabled"})
    SetNuiFocus(false, false)

    ClearTimecycleModifier()
end

function showSettings()
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'),0,-1)
    isMenuActive = true
    
    SendNUIMessage({action = "uiDisabled"})
    SetNuiFocus(false, false)    

    ClearTimecycleModifier()
end

function GetData()
    local xPlayer = ESX.GetPlayerData()
    local played = lib.callback.await('fan_pause_menu:getPlayerTotalPlayedTime');

    local playerCoords = GetEntityCoords(cache.ped)

    local coords = {
        x = playerCoords.x,
        y = playerCoords.y,
        z = playerCoords.z
    }

    return {
        player_count = #GetActivePlayers(),
        player       = xPlayer.firstName ..' '.. xPlayer.lastName,
        coords       = coords,
        job          = xPlayer.job.name,
        money        = xPlayer.money,
        time         = played,
        id           = GetPlayerServerId( PlayerId() ),
    }
end

function AsyncSendData(data)
    Citizen.CreateThread(function()
        SendNUIMessage({
            action = "setData",
            data = GetData()
        })
    end)
end
-- =~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=

-- =~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=
-- Callbacks

-- ResumeGame
RegisterNUICallback('resumeGame', function(data, cb)
    resumeGame()
    cb({})
end)

-- ShowMap
RegisterNUICallback('showMap', function(data, cb)
    showMap()
    cb({})
end)

-- ShowSettings
RegisterNUICallback('showSettings', function(data, cb)
    showSettings()
    cb({})
end)

-- Disconnect
RegisterNUICallback('disconnect', function(data, cb)
    lib.callback.await('fan_pause_menu:disconnect');
    cb({})
end)

-- Get Report
RegisterNUICallback('report', function(reportMessage, cb)
    resumeGame();
    ExecuteCommand('report')
    cb({})
end)

-- Get Locales
RegisterNUICallback("getLocales", function(data, cb)
    local locales = lib.callback.await('fan_pause_menu:getLangFiles')
    cb(locales)
end)

-- Get Datas
RegisterNUICallback("getData", function(data, cb)
    local data = GetData()
    cb(data)
end)

-- Get Settings|Config
RegisterNUICallback("getConfig", function(data, cb)
    cb(config)
end)
-- Get Settings|Config
RegisterNUICallback("getAnnounces", function(data, cb)
    local data = lib.callback.await('fan_pause_menu:getAnnounces')
    cb(data)
end)
-- =~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=


-- =~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=
-- Commands
RegisterCommand('pause', function(data, cb)
    pauseGame()
end, false)

RegisterCommand('unpause', function(data, cb)
    resumeGame()
end, false)
-- =~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=