local addCoinsCommand = TalkAction("/addcoins")

function addCoinsCommand.onSay(player, words, param)
    if not player:getGroup():hasFlag(PlayerFlag_CanAlwaysLogin) then
        player:sendCancelMessage("Você não tem permissão para usar este comando!")
        return true
    end

    local params = param:split(",")
    local targetName = params[1]:trim()
    local amount = tonumber(params[2]) or 9999999999

    if not targetName or targetName == "" then
        player:sendCancelMessage("Uso: /addcoins <nome_jogador>, [quantidade]")
        return true
    end

    local target = Player(targetName)
    if not target then
        player:sendCancelMessage("Jogador '" .. targetName .. "' não encontrado!")
        return true
    end

    -- Adicionar tibia coins
    target:addCoinsBalance(amount)
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você recebeu " .. amount .. " Tibia Coins!")
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Adicionou " .. amount .. " Tibia Coins para " .. target:getName() .. "!")

    -- Log do comando
    logCommand(player, words, param)

    return true
end

addCoinsCommand:separator(" ")
addCoinsCommand:groupType("god")
addCoinsCommand:register()
