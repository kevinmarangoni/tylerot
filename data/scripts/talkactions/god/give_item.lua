local giveItemCommand = TalkAction("/giveitem")

function giveItemCommand.onSay(player, words, param)
    if not player:getGroup():hasFlag(PlayerFlag_CanAlwaysLogin) then
        player:sendCancelMessage("Você não tem permissão para usar este comando!")
        return true
    end

    local params = param:split(",")
    local targetName = params[1]:trim()
    local itemId = tonumber(params[2])
    local amount = tonumber(params[3]) or 1

    if not targetName or not itemId then
        player:sendCancelMessage("Uso: /giveitem <nome_jogador>, <itemid>, [quantidade]\n\n" ..
            "Exemplos:\n" ..
            "/giveitem Joao, 2160, 100     - 100 crystal coins para Joao\n" ..
            "/giveitem Maria, 1988, 1      - 1 magic plate armor para Maria\n" ..
            "/giveitem Pedro, 2393, 50     - 50 mana potions para Pedro")
        return true
    end

    local target = Player(targetName)
    if not target then
        player:sendCancelMessage("Jogador '" .. targetName .. "' não encontrado!")
        return true
    end

    -- Validar quantidade
    if amount < 1 or amount > 100000 then
        player:sendCancelMessage("Quantidade deve ser entre 1 e 100000!")
        return true
    end

    -- Criar e dar o item
    local item = Game.createItem(itemId, amount)
    if not item then
        player:sendCancelMessage("Item ID " .. itemId .. " inválido!")
        return true
    end

    -- Tentar colocar no inventário do jogador
    if target:addItem(item) then
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você recebeu " .. amount .. "x " .. item:getName() .. "!")
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Deu " .. amount .. "x " .. item:getName() .. " para " .. target:getName() .. "!")

        -- Efeito visual
        target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    else
        -- Se não couber no inventário, colocar no chão
        target:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Seu inventário está cheio! O item foi colocado no chão.")
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Inventário cheio! Item colocado no chão.")
    end

    -- Log do comando
    logCommand(player, words, param)

    return true
end

giveItemCommand:separator(" ")
giveItemCommand:groupType("god")
giveItemCommand:register()
