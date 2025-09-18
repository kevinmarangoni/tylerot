local addonsCompletos = CreatureEvent("AddonsCompletos")

function addonsCompletos.onLogin(player)
    -- Verificar se já teve os addons corrigidos
    local addonStorage = 50002 -- Storage diferente do de montarias
    if player:getStorageValue(addonStorage) == 1 then
        return true -- Já foi processado
    end

    -- Lista dos outfits problemáticos mencionados + outros importantes
    local outfitsParaCorrigir = {
        -- OUTFITS MENCIONADOS COMO PROBLEMÁTICOS:
        1211, 1210, -- Golden Outfit (Female/Male)
        1723, 1722, -- Draccoon Herald (Female/Male)
        1775, 1774, -- Rootwalker (Female/Male)

        -- OUTFITS STORE MAIS POPULARES:
        155, 151,   -- Pirate
        156, 152,   -- Assassin
        269, 268,   -- Nightmare
        288, 289,   -- Demon Hunter
        336, 335,   -- Warmaster
        542, 541,   -- Demon
        618, 610,   -- Glooth Engineer
        632, 633,   -- Champion
        666, 667,   -- Death Herald
        724, 725,   -- Evoker
        845, 846,   -- Rift Warrior
        885, 884,   -- Arena Champion
        956, 955,   -- Pharaoh
        1070, 1069, -- Battle Mage
        1147, 1146, -- Dream Warrior
        1203, 1202, -- Void Master
        1207, 1206, -- Lion of War
        1289, 1288, -- Dragon Slayer
        1445, 1444, -- Dragon Knight
        1501, 1500, -- Nordic Chieftain
        1714, 1713, -- Doom Knight
        1726, 1725, -- Celestial Avenger
        1746, 1745, -- Blade Dancer

        -- OUTFITS BÁSICOS (garantir addons)
        136, 128,   -- Citizen
        137, 129,   -- Hunter
        138, 130,   -- Mage
        139, 131,   -- Knight
        140, 132,   -- Noble
        141, 133,   -- Summoner
        142, 134,   -- Warrior
        147, 143,   -- Barbarian
        148, 144,   -- Druid
        149, 145,   -- Wizard
        150, 146,   -- Oriental
    }

    local outfitsProcessed = 0
    local addonsAdded = 0

    -- Processar cada outfit
    for _, outfitId in pairs(outfitsParaCorrigir) do
        -- Adicionar o outfit se não tiver
        if not player:hasOutfit(outfitId, 0) then
            player:addOutfit(outfitId, 0)
        end

        -- Adicionar todos os addons
        player:addOutfitAddon(outfitId, 1) -- First addon
        player:addOutfitAddon(outfitId, 2) -- Second addon
        player:addOutfitAddon(outfitId, 3) -- Both addons combined

        outfitsProcessed = outfitsProcessed + 1
        addonsAdded = addonsAdded + 3
    end

    -- Marcar como processado
    player:setStorageValue(addonStorage, 1)

    -- Notificar o player se addons foram adicionados
    if addonsAdded > 0 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🎭 Addons de outfits corrigidos automaticamente!")
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "✨ " .. outfitsProcessed .. " outfits com addons completos!")
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)

        -- Log no console
        print(">>> Player " .. player:getName() .. " recebeu correção de addons: " .. outfitsProcessed .. " outfits")
    end

    return true
end

addonsCompletos:register()
