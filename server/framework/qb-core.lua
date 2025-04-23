local QBCore = exports['qb-core']:GetCoreObject()

function GetPlayer(playerId)
    local player = { source = playerId }
    return player
end

function GetCharacterId(player)
    return QBCore.Functions.GetPlayer(player.source).PlayerData.citizenid
end

function IsPlayerInGroup(player, filter)
    local qbPlayer = QBCore.Functions.GetPlayer(player.source).PlayerData
    local type = type(filter)

    if type == 'string' then
        if qbPlayer.job.name == filter then
            return qbPlayer.job.name, qbPlayer.job.grade.level
        end
    else
        local tabletype = table.type(filter)

        if tabletype == 'hash' then
            local grade = filter[qbPlayer.job.name]

            if grade and grade <= qbPlayer.job.grade.level then
                return qbPlayer.job.name, qbPlayer.job.grade.level
            end
        elseif tabletype == 'array' then
            for i = 1, #filter do
                if qbPlayer.job.name == filter[i] then
                    return qbPlayer.job.name, qbPlayer.job.grade.level
                end
            end
        end
    end
end
