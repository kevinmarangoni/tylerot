local giveItemByNameCommand = TalkAction("/givebyname")

function giveItemByNameCommand.onSay(player, words, param)
    if not player:getGroup():hasFlag(PlayerFlag_CanAlwaysLogin) then
        player:sendCancelMessage("Você não tem permissão para usar este comando!")
        return true
    end

    local params = param:split(",")
    local targetName = params[1]:trim()
    local itemName = params[2]:trim()
    local amount = tonumber(params[3]) or 1

    if not targetName or not itemName then
        player:sendCancelMessage("Uso: /givebyname <nome_jogador>, <nome_item>, [quantidade]\n\n" ..
            "Exemplos:\n" ..
            "/givebyname Joao, crystal coin, 100     - 100 crystal coins\n" ..
            "/givebyname Maria, magic plate armor, 1 - 1 magic plate armor\n" ..
            "/givebyname Pedro, mana potion, 50      - 50 mana potions\n" ..
            "/givebyname Ana, gold coin, 1000        - 1000 gold coins")
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

    -- Buscar item por nome
    local itemType = ItemType(itemName)
    if not itemType then
        player:sendCancelMessage("Item '" .. itemName .. "' não encontrado!")
        return true
    end

    local itemId = itemType:getId()

    -- Criar e dar o item
    local item = Game.createItem(itemId, amount)
    if not item then
        player:sendCancelMessage("Erro ao criar item '" .. itemName .. "'!")
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

giveItemByNameCommand:separator(" ")
giveItemByNameCommand:groupType("god")
giveItemByNameCommand:register()
