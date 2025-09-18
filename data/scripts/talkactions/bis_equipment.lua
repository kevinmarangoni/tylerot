local bisEquipmentCommand = TalkAction("/bis")

function bisEquipmentCommand.onSay(player, words, param)
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

    -- Carregar configurações dos sets BiS
    dofile('data/scripts/config/bis_sets.lua')

    local vocation = target:getVocation():getId()
    local vocationName = target:getVocation():getName()

    -- Verificar se o jogador tem inventário livre
    if target:getFreeCapacity() < 1000 then
        player:sendCancelMessage("Jogador " .. target:getName() .. " não tem capacidade suficiente!")
        return true
    end

    -- Verificar se a vocação tem set BiS
    if not BisSets.hasSet(vocation) then
        if vocation == 0 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Rooks não têm set BiS específico!")
            target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você é um Rook! Evolua para receber equipamentos BiS!")
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Set BiS de " .. BisSets.getVocationName(vocation) .. " será implementado em breve!")
            target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Set BiS de " .. BisSets.getVocationName(vocation) .. " será implementado em breve!")
        end
        return true
    end

    local vocationSet = BisSets.getVocationSet(vocation)
    local items = BisSets.getItems(vocation)

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Aplicando set BiS de " .. vocationSet.name .. " para " .. target:getName() .. "...")

    local itemsGiven = 0

    -- Dar cada item do set
    for _, itemData in pairs(items) do
        -- Pular itens placeholder (ID = 0)
        if itemData.id > 0 then
            local item = Game.createItem(itemData.id, 1)
            if item then
                if target:addItem(item) then
                    itemsGiven = itemsGiven + 1
                    print(">> [BiS Equipment] " .. target:getName() .. " recebeu " .. itemData.name)
                else
                    -- Se não conseguir dar, dropa no chão
                    item:moveTo(target:getPosition())
                    itemsGiven = itemsGiven + 1
                    print(">> [BiS Equipment] " .. itemData.name .. " dropado no chão para " .. target:getName())
                end
            end
        end
    end

    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Set BiS de " .. vocationSet.name .. " completo recebido! (" .. itemsGiven .. " itens)")
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Set BiS de " .. vocationSet.name .. " aplicado para " .. target:getName() .. "!")

    -- Efeito visual
    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)

    -- Log do comando
    logCommand(player, words, param)

    return true
end

bisEquipmentCommand:separator(" ")
bisEquipmentCommand:groupType("normal")
bisEquipmentCommand:register()
