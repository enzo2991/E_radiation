function DamagePlayer(playerped)
    local prevHealth = GetEntityHealth(playerped)
    local health = prevHealth - 5
    if health < 0 then
        health = 0
    end
    SetEntityHealth(playerped,health)
end

function TeleportPlayer(playerped,coords)
    SetEntityCoords(playerped,coords.x,coords.y,Coords.z) 
end