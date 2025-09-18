local hasteEquipmentCommand = TalkAction("/haste")

function hasteEquipmentCommand.onSay(player, words, param)
    -- Comando liberado para todos os jogadores
    if not player or not player:isPlayer() then
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

    -- Carregar configurações do Haste Set
    dofile('data/scripts/config/haste_sets.lua')

    -- Verificar se o jogador tem inventário livre
    if target:getFreeCapacity() < 1000 then
        player:sendCancelMessage("Jogador " .. target:getName() .. " não tem capacidade suficiente!")
        return true
    end

    -- Verificar se o Haste Set existe
    if not HasteSets.hasSet("haste") then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Haste Set não encontrado!")
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Haste Set não encontrado!")
        return true
    end

    local hasteSet = HasteSets.getSet("haste")
    local items = HasteSets.getItems("haste")

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Aplicando Haste Set para " .. target:getName() .. "...")

    local itemsGiven = 0

    -- Dar cada item do set
    for _, itemData in pairs(items) do
        -- Pular itens placeholder (ID = 0)
        if itemData.id > 0 then
            local item = Game.createItem(itemData.id, 1)
            if item then
                if target:addItem(item) then
                    itemsGiven = itemsGiven + 1
                    print(">> [Haste Equipment] " .. target:getName() .. " recebeu " .. itemData.name)
                else
                    -- Se não conseguir dar, dropa no chão
                    item:moveTo(target:getPosition())
                    itemsGiven = itemsGiven + 1
                    print(">> [Haste Equipment] " .. itemData.name .. " dropado no chão para " .. target:getName())
                end
            end
        end
    end

    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Haste Set completo recebido! (" .. itemsGiven .. " itens)")
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Haste Set aplicado para " .. target:getName() .. "!")

    -- Efeito visual
    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)

    -- Log do comando
    logCommand(player, words, param)

    return true
end

hasteEquipmentCommand:separator(" ")
hasteEquipmentCommand:groupType("normal")
hasteEquipmentCommand:register()
