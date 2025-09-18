local corrigirAddons = TalkAction("/corrigiraddons")

function corrigirAddons.onSay(player, words, param)
    -- Verificar permissões de administrador
    if not player:getGroup():hasFlag(PlayerFlag_CanAlwaysLogin) then
        player:sendCancelMessage("Você não tem permissão para usar este comando!")
        return true
    end

    -- Lista completa de todos os outfits que devem ter addons
    local allOutfits = {
        -- OUTFITS PROBLEMÁTICOS MENCIONADOS:
        1211, 1210, -- Golden Outfit (Female/Male)
        1723, 1722, -- Draccoon Herald (Female/Male)
        1775, 1774, -- Rootwalker (Female/Male)

        -- OUTROS OUTFITS STORE QUE PODEM ESTAR SEM ADDONS:
        155, 151,   -- Pirate
        156, 152,   -- Assassin
        157, 153,   -- Beggar
        158, 154,   -- Shaman
        252, 251,   -- Norse
        269, 268,   -- Nightmare
        270, 273,   -- Jester
        279, 278,   -- Brotherhood
        288, 289,   -- Demon Hunter
        324, 325,   -- Yalaharian
        329, 328,   -- Newly Wed
        336, 335,   -- Warmaster
        366, 367,   -- Wayfarer
        431, 430,   -- Afflicted
        433, 432,   -- Elementalist
        464, 463,   -- Deepling
        466, 465,   -- Insectoid
        471, 472,   -- Entrepreneur
        513, 512,   -- Crystal Warlord
        514, 516,   -- Soil Guardian
        542, 541,   -- Demon
        575, 574,   -- Cave Explorer
        578, 577,   -- Dream Warden
        618, 610,   -- Glooth Engineer
        632, 633,   -- Champion
        635, 634,   -- Conjurer
        636, 637,   -- Beastmaster
        664, 665,   -- Chaos Acolyte
        666, 667,   -- Death Herald
        683, 684,   -- Ranger
        694, 695,   -- Ceremonial Garb
        696, 697,   -- Puppeteer
        698, 699,   -- Spirit Caller
        724, 725,   -- Evoker
        732, 733,   -- Seaweaver
        749, 750,   -- Sea Dog
        759, 760,   -- Royal Pumpkin
        845, 846,   -- Rift Warrior
        852, 853,   -- Winter Warden
        874, 873,   -- Philosopher
        885, 884,   -- Arena Champion
        900, 899,   -- Lupine Warden
        909, 908,   -- Grove Keeper
        929, 931,   -- Festive
        956, 955,   -- Pharaoh
        958, 957,   -- Trophy Hunter
        1020, 1021, -- Herbalist
        1024, 1023, -- Sun Priest
        1043, 1042, -- Makeshift Warrior
        1050, 1051, -- Siege Master
        1057, 1056, -- Mercenary
        1070, 1069, -- Battle Mage
        1095, 1094, -- Discoverer
        1103, 1102, -- Sinister Archer
        1128, 1127, -- Pumpkin Mummy
        1147, 1146, -- Dream Warrior
        1162, 1161, -- Percht Raider
        1174, 1173, -- Owl Keeper
        1187, 1186, -- Guidon Bearer
        1203, 1202, -- Void Master
        1205, 1204, -- Veteran Paladin
        1207, 1206, -- Lion of War
        1244, 1243, -- Hand of the Inquisition
        1246, 1245, -- Breezy Garb
        1252, 1251, -- Orcsoberfest Garb
        1271, 1270, -- Poltergeist
        1280, 1279, -- Herder
        1283, 1282, -- Falconer
        1289, 1288, -- Dragon Slayer
        1293, 1292, -- Trailblazer
        1323, 1322, -- Revenant
        1332, 1331, -- Jouster
        1339, 1338, -- Moth Cape
        1372, 1371, -- Rascoohan
        1383, 1382, -- Merry Garb
        1385, 1384, -- Rune Master
        1387, 1386, -- Citizen of Issavi
        1416, 1415, -- Forest Warden
        1437, 1436, -- Royal Bounacean Advisor
        1445, 1444, -- Dragon Knight
        1450, 1449, -- Arbalester
        1456, 1457, -- Royal Costume
        1461, 1460, -- Formal Dress
        1490, 1489, -- Ghost Blade
        1501, 1500, -- Nordic Chieftain
        1569, 1568, -- Fire-Fighter
        1576, 1575, -- Fencer
        1582, 1581, -- Shadowlotus Disciple
        1598, 1597, -- Ancient Aucar
        1613, 1612, -- Frost Tracer
        1619, 1618, -- Armoured Archer
        1663, 1662, -- Decaying Defender
        1676, 1675, -- Darklight Evoker
        1681, 1680, -- Flamefury Mage
        1714, 1713, -- Doom Knight
        1726, 1725, -- Celestial Avenger
        1746, 1745, -- Blade Dancer
        1777, 1776, -- Beekeeper

        -- OUTFITS BÁSICOS (garantir que também tenham addons)
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

    local outfitsProcessed = 0
    local addonsAdded = 0

    -- Adicionar todos os outfits com addons completos
    for _, outfitId in pairs(allOutfits) do
        -- Adicionar o outfit base se não tiver
        if not target:hasOutfit(outfitId, 0) then
            target:addOutfit(outfitId, 0)
        end

        -- Adicionar todos os addons (1, 2, 3 = todos os addons)
        target:addOutfitAddon(outfitId, 1) -- First addon
        target:addOutfitAddon(outfitId, 2) -- Second addon
        target:addOutfitAddon(outfitId, 3) -- Both addons

        outfitsProcessed = outfitsProcessed + 1
        addonsAdded = addonsAdded + 3
    end

    -- Mensagens de confirmação
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "✅ Addons corrigidos com sucesso!")
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "📊 " .. outfitsProcessed .. " outfits processados")
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🎭 " .. addonsAdded .. " addons adicionados")
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🔥 Golden, Draccoon Herald, Rootwalker e outros corrigidos!")

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "✅ Addons corrigidos para " .. target:getName() .. "!")
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "📊 " .. outfitsProcessed .. " outfits / " .. addonsAdded .. " addons")

    -- Efeito visual
    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)

    -- Log no console
    print(">>> Addons corrigidos para " .. target:getName() .. " por " .. player:getName())
    print(">>> " .. outfitsProcessed .. " outfits processados com " .. addonsAdded .. " addons")

    return true
end

corrigirAddons:separator(" ")
corrigirAddons:groupType("god")
corrigirAddons:register()
