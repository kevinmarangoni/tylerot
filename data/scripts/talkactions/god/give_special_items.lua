local giveSpecialItemsCommand = TalkAction("/givespecial")

function giveSpecialItemsCommand.onSay(player, words, param)
    if not player:getGroup():hasFlag(PlayerFlag_CanAlwaysLogin) then
        player:sendCancelMessage("Você não tem permissão para usar este comando!")
        return true
    end

    local params = param:split(",")
    local targetName = params[1]:trim()
    local itemType = params[2]:trim():lower()
    local amount = tonumber(params[3]) or 100

    if not targetName or not itemType then
        player:sendCancelMessage("Uso: /givespecial <nome_jogador>, <tipo_item>, [quantidade]\n\n" ..
            "Tipos Disponíveis:\n" ..
            "/givespecial Joao, runas, 100        - 100 runas de cada tipo\n" ..
            "/givespecial Maria, poções, 50      - 50 poções de cada tipo\n" ..
            "/givespecial Pedro, arrows, 1000    - 1000 arrows\n" ..
            "/givespecial Ana, bolts, 1000       - 1000 bolts\n" ..
            "/givespecial Carlos, spears, 100    - 100 spears")
        return true
    end

    local target = Player(targetName)
    if not target then
        player:sendCancelMessage("Jogador '" .. targetName .. "' não encontrado!")
        return true
    end

    -- Validar quantidade
    if amount < 1 or amount > 10000 then
        player:sendCancelMessage("Quantidade deve ser entre 1 e 10000!")
        return true
    end

    local itemsGiven = 0

    -- Definir itens por tipo
    if itemType == "runas" then
        local runas = {
            {id = 2260, name = "Sudden Death Rune"},      -- SD
            {id = 2266, name = "Great Fireball Rune"},    -- GFB
            {id = 2273, name = "Ultimate Healing Rune"},  -- UH
            {id = 2278, name = "Avalanche Rune"},         -- Avalanche
            {id = 2285, name = "Thunderstorm Rune"},      -- Thunderstorm
            {id = 2289, name = "Stone Shower Rune"},      -- Stone Shower
            {id = 2293, name = "Explosion Rune"},         -- Explosion
            {id = 2301, name = "Fireball Rune"},          -- Fireball
            {id = 2305, name = "Light Magic Missile Rune"}, -- LMM
            {id = 2313, name = "Heavy Magic Missile Rune"} -- HMM
        }

        for _, runa in pairs(runas) do
            local item = Game.createItem(runa.id, amount)
            if target:addItem(item) then
                itemsGiven = itemsGiven + 1
            end
        end

    elseif itemType == "poções" then
        local poções = {
            {id = 2393, name = "Mana Potion"},            -- Mana
            {id = 2394, name = "Health Potion"},          -- Health
            {id = 2395, name = "Strong Health Potion"},   -- Strong Health
            {id = 2396, name = "Great Health Potion"},    -- Great Health
            {id = 2397, name = "Ultimate Health Potion"}, -- Ultimate Health
            {id = 2398, name = "Great Mana Potion"},      -- Great Mana
            {id = 2399, name = "Ultimate Mana Potion"},   -- Ultimate Mana
            {id = 2400, name = "Great Spirit Potion"},    -- Great Spirit
            {id = 2401, name = "Ultimate Spirit Potion"}  -- Ultimate Spirit
        }

        for _, poção in pairs(poções) do
            local item = Game.createItem(poção.id, amount)
            if target:addItem(item) then
                itemsGiven = itemsGiven + 1
            end
        end

    elseif itemType == "arrows" then
        local arrows = {
            {id = 2544, name = "Arrow"},                  -- Arrow
            {id = 2545, name = "Poison Arrow"},           -- Poison Arrow
            {id = 2546, name = "Fire Arrow"},             -- Fire Arrow
            {id = 2547, name = "Burst Arrow"},            -- Burst Arrow
            {id = 2548, name = "Power Bolt"},             -- Power Bolt
            {id = 2549, name = "Infernal Bolt"},          -- Infernal Bolt
            {id = 2550, name = "Piercing Bolt"},          -- Piercing Bolt
            {id = 2551, name = "Sniper Arrow"},           -- Sniper Arrow
            {id = 2552, name = "Onyx Arrow"},             -- Onyx Arrow
            {id = 2553, name = "Tarsal Arrow"}            -- Tarsal Arrow
        }

        for _, arrow in pairs(arrows) do
            local item = Game.createItem(arrow.id, amount)
            if target:addItem(item) then
                itemsGiven = itemsGiven + 1
            end
        end

    elseif itemType == "bolts" then
        local bolts = {
            {id = 2545, name = "Poison Arrow"},           -- Poison Arrow
            {id = 2546, name = "Fire Arrow"},             -- Fire Arrow
            {id = 2547, name = "Burst Arrow"},            -- Burst Arrow
            {id = 2548, name = "Power Bolt"},             -- Power Bolt
            {id = 2549, name = "Infernal Bolt"},          -- Infernal Bolt
            {id = 2550, name = "Piercing Bolt"}           -- Piercing Bolt
        }

        for _, bolt in pairs(bolts) do
            local item = Game.createItem(bolt.id, amount)
            if target:addItem(item) then
                itemsGiven = itemsGiven + 1
            end
        end

    elseif itemType == "spears" then
        local spears = {
            {id = 2389, name = "Spear"},                  -- Spear
            {id = 2390, name = "Poison Spear"},           -- Poison Spear
            {id = 2391, name = "Fire Spear"},             -- Fire Spear
            {id = 2392, name = "Burst Spear"}             -- Burst Spear
        }

        for _, spear in pairs(spears) do
            local item = Game.createItem(spear.id, amount)
            if target:addItem(item) then
                itemsGiven = itemsGiven + 1
            end
        end

    else
        player:sendCancelMessage("Tipo de item '" .. itemType .. "' não reconhecido!")
        return true
    end

    -- Mensagens de confirmação
    if itemsGiven > 0 then
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você recebeu " .. amount .. "x de cada " .. itemType .. "!")
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Deu " .. amount .. "x de cada " .. itemType .. " para " .. target:getName() .. "!")
        target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    else
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Seu inventário está cheio! Os itens foram colocados no chão.")
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Inventário cheio! Itens colocados no chão.")
        target:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
    end

    -- Log do comando
    logCommand(player, words, param)

    return true
end

giveSpecialItemsCommand:separator(" ")
giveSpecialItemsCommand:groupType("god")
giveSpecialItemsCommand:register()
