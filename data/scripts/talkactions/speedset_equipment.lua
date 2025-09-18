local speedsetCommand = TalkAction("/speedset")

function speedsetCommand.onSay(player, words, param)
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

    -- Carregar configurações dos speed sets
    dofile('data/scripts/config/speed_sets.lua')

    local vocation = target:getVocation():getId()
    local vocationName = target:getVocation():getName()

    -- Verificar se o jogador tem inventário livre
    if target:getFreeCapacity() < 1000 then
        player:sendCancelMessage("Jogador " .. target:getName() .. " não tem capacidade suficiente!")
        return true
    end

    -- Verificar se a vocação tem speed set
    if not SpeedSets.hasSet(vocation) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Speed Set de " .. SpeedSets.getVocationName(vocation) .. " não disponível!")
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Speed Set de " .. SpeedSets.getVocationName(vocation) .. " não disponível!")
        return true
    end

    local vocationSet = SpeedSets.getVocationSet(vocation)
    local items = SpeedSets.getItems(vocation)

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "⚡ Aplicando Speed Set de " .. vocationSet.name .. " para " .. target:getName() .. "...")

    local itemsGiven = 0
    local speedBonus = 0

    -- Dar cada item do speed set
    for _, itemData in pairs(items) do
        if itemData.id > 0 then
            local item = Game.createItem(itemData.id, 1)
            if item then
                if target:addItem(item) then
                    itemsGiven = itemsGiven + 1

                    -- Calcular bônus de velocidade aproximado
                    if itemData.id == 3079 then speedBonus = speedBonus + 20 end -- Boots of Haste
                    if itemData.id == 3053 then speedBonus = speedBonus + 10 end -- Time Ring
                    if itemData.id == 22062 then speedBonus = speedBonus + 15 end -- Werewolf Helmet
                    if itemData.id == 16110 then speedBonus = speedBonus + 15 end -- Prismatic Armor
                    if itemData.id == 14087 then speedBonus = speedBonus + 10 end -- Grasshopper Legs
                    if itemData.id == 11651 then speedBonus = speedBonus + 10 end -- Elite Draken Mail
                    if itemData.id == 10384 then speedBonus = speedBonus + 10 end -- Zaoan Armor
                    if itemData.id == 21892 then speedBonus = speedBonus + 5 end -- Crest of Deep Seas

                    print(">> [Speed Set] " .. target:getName() .. " recebeu " .. itemData.name)
                else
                    -- Se não conseguir dar, dropa no chão
                    item:moveTo(target:getPosition())
                    itemsGiven = itemsGiven + 1
                    print(">> [Speed Set] " .. itemData.name .. " dropado no chão para " .. target:getName())
                end
            end
        end
    end

    -- Mensagens de sucesso
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "⚡ Speed Set de " .. vocationSet.name .. " completo recebido!")
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🏃 " .. itemsGiven .. " itens recebidos (+~" .. speedBonus .. " speed total)")
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "💨 Agora você está MUITO mais rápido!")

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "✅ Speed Set de " .. vocationSet.name .. " aplicado para " .. target:getName() .. "!")
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "📊 " .. itemsGiven .. " itens entregues (+~" .. speedBonus .. " speed)")

    -- Efeito visual especial
    target:getPosition():sendMagicEffect(CONST_ME_YELLOW_RINGS)
    target:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

    -- Log do comando
    logCommand(player, words, param)

    return true
end

speedsetCommand:separator(" ")
speedsetCommand:groupType("normal")
speedsetCommand:register()

