-- Comando para adicionar balance e tibia coins para si mesmo
-- Uso: /addmybalancecoins

local addMyBalanceCoins = TalkAction("/addmybalancecoins")

function addMyBalanceCoins.onSay(player, words, param)
    -- Comando livre para todos os jogadores

    -- Valores a serem adicionados
    local balanceAmount = 999999999
    local coinsAmount = 999999999

    -- Adicionar balance (dinheiro no banco)
    player:setBankBalance(balanceAmount)

    -- Adicionar tibia coins
    player:addTibiaCoins(coinsAmount)

    -- Mensagem de confirmação
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você recebeu " .. balanceAmount .. " de balance e " .. coinsAmount .. " tibia coins!")

    -- Log do comando
    logCommand(player, words, param)

    return true
end

addMyBalanceCoins:separator(" ")
addMyBalanceCoins:groupType("normal")
addMyBalanceCoins:register()
