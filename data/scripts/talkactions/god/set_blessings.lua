local setBlessingsCommand = TalkAction("/setblessings")

function setBlessingsCommand.onSay(player, words, param)
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
    local blessingsAmount = 120

    for _, blessingId in pairs(blessingsList) do
        target:addBlessing(blessingId, blessingsAmount)
    end

    -- Mensagens de confirmação
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Todas as suas blessings foram configuradas para " .. blessingsAmount .. "!")
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Blessings de " .. target:getName() .. " configuradas para " .. blessingsAmount .. "!")

    -- Log do comando
    logCommand(player, words, param)

    return true
end

setBlessingsCommand:separator(" ")
setBlessingsCommand:groupType("god")
setBlessingsCommand:register()
