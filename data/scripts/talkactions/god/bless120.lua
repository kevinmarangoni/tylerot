local bless120Command = TalkAction("/bless120")

function bless120Command.onSay(player, words, param)
    if not player:getGroup():hasFlag(PlayerFlag_CanAlwaysLogin) then
        player:sendCancelMessage("Você não tem permissão para usar este comando!")
        return true
    end

    local targetName = param:trim()
    local target = nil

    if targetName == "" then
        target = player
    else
        target = Player(targetName)
        if not target then
            player:sendCancelMessage("Jogador '" .. targetName .. "' não encontrado!")
            return true
        end
    end

    -- Definir todas as blessings para 120
    local blessingsList = {1, 2, 3, 4, 5, 6, 7, 8}

    for _, blessingId in pairs(blessingsList) do
        target:addBlessing(blessingId, 120)
    end

    -- Mensagens de confirmação
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Todas as suas blessings foram configuradas para 120!")
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Blessings de " .. target:getName() .. " configuradas para 120!")

    -- Log do comando
    logCommand(player, words, param)

    return true
end

bless120Command:separator(" ")
bless120Command:groupType("god")
bless120Command:register()
