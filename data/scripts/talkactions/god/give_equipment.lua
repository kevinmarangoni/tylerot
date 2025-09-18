local giveEquipmentCommand = TalkAction("/giveequipment")

function giveEquipmentCommand.onSay(player, words, param)
    if not player:getGroup():hasFlag(PlayerFlag_CanAlwaysLogin) then
        player:sendCancelMessage("Você não tem permissão para usar este comando!")
        return true
    end

    local params = param:split(",")
    local targetName = params[1]:trim()
    local itemId = tonumber(params[2])
    local amount = tonumber(params[3]) or 1

    if not targetName or not itemId then
        player:sendCancelMessage("Uso: /giveequipment <nome_jogador>, <itemid>, [quantidade]\n\n" ..
            "Equipamentos Populares:\n" ..
            "/giveequipment Joao, 1988, 1      - Magic Plate Armor\n" ..
            "/giveequipment Maria, 1987, 1     - Golden Armor\n" ..
            "/giveequipment Pedro, 1986, 1     - Crown Armor\n" ..
            "/giveequipment Ana, 1985, 1       - Dragon Scale Mail\n" ..
            "/giveequipment Carlos, 1984, 1    - Demon Armor")
        return true
    end

    local target = Player(targetName)
    if not target then
        player:sendCancelMessage("Jogador '" .. targetName .. "' não encontrado!")
        return true
    end

    -- Validar quantidade
    if amount < 1 or amount > 100 then
        player:sendCancelMessage("Quantidade deve ser entre 1 e 100!")
        return true
    end

    -- Criar e dar o equipamento
    local item = Game.createItem(itemId, amount)
    if not item then
        player:sendCancelMessage("Item ID " .. itemId .. " inválido!")
        return true
    end

    -- Verificar se é equipável
    if not item:isContainer() and not item:isMoveable() then
        player:sendCancelMessage("Item ID " .. itemId .. " não é equipável!")
        return true
    end

    -- Tentar colocar no inventário do jogador
    if target:addItem(item) then
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você recebeu " .. amount .. "x " .. item:getName() .. "!")
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Deu " .. amount .. "x " .. item:getName() .. " para " .. target:getName() .. "!")

        -- Efeito visual especial para equipamentos
        target:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    else
        -- Se não couber no inventário, colocar no chão
        target:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Seu inventário está cheio! O equipamento foi colocado no chão.")
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Inventário cheio! Equipamento colocado no chão.")
    end

    -- Log do comando
    logCommand(player, words, param)

    return true
end

giveEquipmentCommand:separator(" ")
giveEquipmentCommand:groupType("god")
giveEquipmentCommand:register()
