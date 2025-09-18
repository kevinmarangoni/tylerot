local forceUnlockAddonsCommand = TalkAction("/forceunlockaddons")

function forceUnlockAddonsCommand.onSay(player, words, param)
    if not player:getGroup():hasFlag(PlayerFlag_CanAlwaysLogin) then
        player:sendCancelMessage("Você não tem permissão para usar este comando!")
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

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🔧 Forçando liberação de addons para " .. target:getName() .. "...")

    -- Lista completa de todos os outfits
    local allOutfits = {
        -- Female outfits
        136, 137, 138, 139, 140, 141, 142, 147, 148, 149, 150, 155, 156, 157, 158,
        252, 269, 270, 279, 288, 324, 329, 336, 366, 431, 433, 464, 466, 471, 513,
        514, 542, 575, 578, 618, 620, 632, 635, 636, 664, 666, 683, 694, 696, 698,
        724, 732, 745, 749, 759, 845, 852, 874, 885, 900, 909, 929, 956, 958, 962,
        963, 964, 965, 966, 967, 968, 969, 970, 971, 972, 973, 974, 975, 1020, 1024,
        1043, 1050, 1057, 1070, 1095, 1103, 1128, 1147, 1162, 1174, 1187, 1203, 1205,
        1207, 1244, 1246, 1252, 1271, 1280, 1289, 1322, 1331, 1339, 1372, 1383, 1385,
        1387, 1416, 1437, 1445, 1456, 1465, 1489, 1502, 1514, 1536, 1545, 1565, 1569,
        1576, 1582, 1598, 1613, 1662, 1676, 1684, 1694, 1698,

        -- Male outfits
        128, 129, 130, 131, 132, 133, 134, 143, 144, 145, 146, 151, 152, 153, 154,
        251, 268, 273, 278, 289, 325, 328, 335, 367, 430, 432, 463, 465, 472, 512,
        516, 541, 574, 577, 619, 621, 633, 634, 637, 665, 667, 684, 695, 697, 699,
        725, 733, 746, 750, 760, 846, 853, 873, 884, 899, 908, 928, 955, 957, 1021,
        1025, 1042, 1051, 1056, 1069, 1094, 1102, 1127, 1146, 1161, 1173, 1186, 1202,
        1204, 1206, 1243, 1245, 1251, 1270, 1279, 1288, 1321, 1330, 1338, 1371, 1382,
        1384, 1386, 1415, 1436, 1444, 1457, 1464, 1488, 1501, 1513, 1535, 1544, 1564,
        1568, 1575, 1581, 1597, 1612, 1663, 1675, 1683, 1693, 1697
    }

    local addonsUnlocked = 0
    local outfitsProcessed = 0

    -- Forçar liberação de todos os addons
    for _, outfitId in pairs(allOutfits) do
        outfitsProcessed = outfitsProcessed + 1

        -- Adicionar o outfit base se não tiver
        if not target:hasOutfit(outfitId, 0) then
            target:addOutfit(outfitId)
        end

        -- Sempre adicionar todos os addons (força mesmo se já tiver)
        target:addOutfitAddon(outfitId, 3)
        addonsUnlocked = addonsUnlocked + 1
    end

    -- Resetar o storage para permitir reprocessamento automático
    local addonStorage = 50000
    target:setStorageValue(addonStorage, -1)

    -- Mensagens de confirmação
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "")
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "=== 🎭 ADDONS FORÇADOS ===")
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "👤 Jogador: " .. target:getName())
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "✨ Outfits processados: " .. outfitsProcessed)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🎊 Addons aplicados: " .. addonsUnlocked)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🔄 Storage resetado para reprocessamento")

    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🎭 TODOS OS SEUS ADDONS FORAM FORÇADOS!")
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "✨ " .. addonsUnlocked .. " addons aplicados!")
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "💡 Use Ctrl+O para ver seus addons!")

    -- Efeitos visuais
    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    target:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)

    -- Log do comando
    logCommand(player, words, param)

    return true
end

forceUnlockAddonsCommand:separator(" ")
forceUnlockAddonsCommand:groupType("god")
forceUnlockAddonsCommand:register()
