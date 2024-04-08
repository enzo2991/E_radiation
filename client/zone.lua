local radiationzone = {}
if Config.zone == "north" then
    radiationzone = PolyZone:Create({
        vector2(x,y),
        vector2(x,y),
        vector2(x,y),
        vector2(x,y),
        vector2(x,y)
    },{
        name="radiation_cage",
        minZ=14.0,
        maxZ=62.0,
        debugGrid=Config.debug
    })
elseif Config.zone == "south" then
    radiationzone = PolyZone:Create({
        vector2(x,y),
        vector2(x,y),
        vector2(x,y),
        vector2(x,y)
    },{
        name="radiation_cage",
        minZ=14.0,
        maxZ=62.0,
        debugGrid=Config.debug
    })
end

local function inSideZone()
    Citizen.CreateThread(function()
        DebugPrint("Creation de la thread")
        InZone = true
        Citizen.Wait(Config.cooldown.beforeFirstDamage * 1000)
        while InZone do
            local playerPed = PlayerPedId()
            if IsPedDeadOrDying(playerPed) then
                ESX.ShowNotification("Vous etes tombé coma dans la zone de radiation, vous devez etre obligatoirement amener par l'unité X")
                SendNUIMessage({action = "Sound", value=false})
                InZone = false
                DebugPrint("Kill")
            else
                if Config.teleportPlayer then
                    DebugPrint("Teleport")
                    TeleportPlayer(playerPed,Config.teleportcoords)
                else
                    SendNUIMessage({action = "Sound",value = true})
                    DamagePlayer(playerPed)
                end
                DebugPrint("Damage")
            end
            DebugPrint("while")
            Citizen.Wait(Config.cooldown.interval * 1000)
        end
    end)
end

Citizen.CreateThread(function()
        radiationzone:onPointInOut(PolyZone.getPlayerPosition,function (isPointInside,point)
            if isPointInside then
                ESX.ShowNotification("Attention: tu es rentré dans la zone de radiation , tu as 1 minutes avant d'etre malade")
                inSideZone()
            else
                if InZone then
                    InZone = false
                    SendNUIMessage({action = "Sound", value=false})
                    ESX.ShowNotification("Tu es sortis de la zone de radiation")
                end
                
            end
        end)
end)

function DebugPrint(text)
    if Config.debug then
        print(text)
    end
end


