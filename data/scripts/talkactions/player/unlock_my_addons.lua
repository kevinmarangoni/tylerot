local unlockMyAddonsCommand = TalkAction("/unlockmyaddons")

function unlockMyAddonsCommand.onSay(player, words, param)
    -- Comando disponível para todos os jogadores
    if not player or not player:isPlayer() then
        return true
    end

    -- Verificar se já foi usado recentemente (cooldown de 1 hora)
    local cooldownStorage = 50001
    local lastUse = player:getStorageValue(cooldownStorage)
    local currentTime = os.time()

    if lastUse > 0 and (currentTime - lastUse) < 3600 then -- 1 hora = 3600 segundos
        local remainingTime = 3600 - (currentTime - lastUse)
        local minutes = math.floor(remainingTime / 60)
        player:sendCancelMessage("⏰ Aguarde " .. minutes .. " minutos antes de usar novamente!")
        return true
    end

    player:sendTextMessage(MESSAGE_INFO_DESCR, "🎭 Liberando todos os seus addons...")
    player:sendTextMessage(MESSAGE_INFO_DESCR, "⏳ Processando, aguarde alguns segundos...")

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

    -- Liberar todos os addons
    for _, outfitId in pairs(allOutfits) do
        outfitsProcessed = outfitsProcessed + 1

        -- Verificar se precisa adicionar addons
        if not player:hasOutfit(outfitId, 3) then
            -- Adicionar o outfit base se não tiver
            if not player:hasOutfit(outfitId, 0) then
                player:addOutfit(outfitId)
            end

            -- Adicionar todos os addons
            player:addOutfitAddon(outfitId, 3)
            addonsUnlocked = addonsUnlocked + 1
        end
    end

    -- Definir cooldown
    player:setStorageValue(cooldownStorage, currentTime)

    -- Mensagens de sucesso
    player:sendTextMessage(MESSAGE_INFO_DESCR, "")
    player:sendTextMessage(MESSAGE_INFO_DESCR, "=== 🎉 ADDONS LIBERADOS ===")
    player:sendTextMessage(MESSAGE_INFO_DESCR, "✨ Outfits processados: " .. outfitsProcessed)
    player:sendTextMessage(MESSAGE_INFO_DESCR, "🎭 Addons liberados: " .. addonsUnlocked)

    if addonsUnlocked > 0 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🎊 TODOS OS SEUS ADDONS FORAM LIBERADOS!")
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "💡 Use Ctrl+O para ver seus novos addons!")

        -- Efeito visual
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "✅ Você já possui todos os addons disponíveis!")
    end

    player:sendTextMessage(MESSAGE_INFO_DESCR, "⏰ Próximo uso disponível em 1 hora")

    return true
end

unlockMyAddonsCommand:separator(" ")
unlockMyAddonsCommand:groupType("normal")
unlockMyAddonsCommand:register()
