-- Comando para adicionar dinheiro
-- Uso: /addmoney

local addMoney = TalkAction("/addmoney")

function addMoney.onSay(player, words, param)
    -- Valor a ser adicionado
    local moneyAmount = 9999999999

    -- Adicionar dinheiro
    player:addMoney(moneyAmount)

    -- Mensagem de confirmação
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você recebeu " .. moneyAmount .. " de dinheiro!")

    -- Log do comando
    logCommand(player, words, param)

    return true
end

addMoney:separator(" ")
addMoney:groupType("normal")
addMoney:register()

print(">> [Money] Comando /addmoney registrado!")
