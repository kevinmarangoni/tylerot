-- Comando para adicionar balance e tibia coins
-- Uso: /addbalancecoins <nome_jogador>

local addBalanceCoins = TalkAction("/addbalancecoins")

function addBalanceCoins.onSay(player, words, param)
    -- Comando livre para todos os jogadores

    -- Verificar se foi fornecido um nome de jogador
    if param == "" then
        player:sendCancelMessage("Uso: /addbalancecoins <nome_jogador>")
        return true
    end

    local targetName = param:trim()
    local target = Player(targetName)

    if not target then
        player:sendCancelMessage("Jogador '" .. targetName .. "' não encontrado!")
        return true
    end

    -- Valores a serem adicionados
    local balanceAmount = 999999999
    local coinsAmount = 999999999

    -- Adicionar balance (dinheiro no banco)
    target:setBankBalance(balanceAmount)

    -- Adicionar tibia coins
    target:addTibiaCoins(coinsAmount)

    -- Mensagens de confirmação
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você recebeu " .. balanceAmount .. " de balance e " .. coinsAmount .. " tibia coins!")
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Adicionou " .. balanceAmount .. " de balance e " .. coinsAmount .. " tibia coins para " .. target:getName() .. "!")

    -- Log do comando
    logCommand(player, words, param)

    return true
end

addBalanceCoins:separator(" ")
addBalanceCoins:groupType("normal")
addBalanceCoins:register()
