-- Comando de debug para balance e tibia coins
local debugBalance = TalkAction("/debugbalance")

function debugBalance.onSay(player, words, param)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Testando comando de debug...")

    -- Teste 1: Verificar balance atual
    local currentBalance = player:getBankBalance()
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Balance atual: " .. currentBalance)

    -- Teste 2: Tentar adicionar balance
    local success = pcall(function()
        player:setBankBalance(1000000)
    end)

    if success then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Balance alterado com sucesso!")
        local newBalance = player:getBankBalance()
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Novo balance: " .. newBalance)
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "ERRO ao alterar balance!")
    end

    -- Teste 3: Tentar adicionar tibia coins
    local success2 = pcall(function()
        player:addTibiaCoins(1000)
    end)

    if success2 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Tibia Coins adicionados com sucesso!")
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "ERRO ao adicionar Tibia Coins!")
    end

    return true
end

debugBalance:separator(" ")
debugBalance:groupType("normal")
debugBalance:register()

print(">> [Debug] Comando /debugbalance registrado!")
