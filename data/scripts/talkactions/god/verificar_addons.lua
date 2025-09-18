local verificarAddons = TalkAction("/verificaraddons")

function verificarAddons.onSay(player, words, param)
    -- Verificar permissões de administrador
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

    -- Outfits específicos para verificar (os mencionados como problemáticos)
    local outfitsParaVerificar = {
        {id = 1211, name = "Golden (Female)"},
        {id = 1210, name = "Golden (Male)"},
        {id = 1723, name = "Draccoon Herald (Female)"},
        {id = 1722, name = "Draccoon Herald (Male)"},
        {id = 1775, name = "Rootwalker (Female)"},
        {id = 1774, name = "Rootwalker (Male)"},
        {id = 845, name = "Rift Warrior (Female)"},
        {id = 846, name = "Rift Warrior (Male)"},
        {id = 1714, name = "Doom Knight (Female)"},
        {id = 1713, name = "Doom Knight (Male)"},
        {id = 1070, name = "Battle Mage (Female)"},
        {id = 1069, name = "Battle Mage (Male)"},
    }

    local outfitsSemAddons = {}
    local outfitsComAddons = {}

    -- Verificar cada outfit
    for _, outfit in pairs(outfitsParaVerificar) do
        local hasOutfit = target:hasOutfit(outfit.id, 0)
        local addon1 = target:hasOutfit(outfit.id, 1)
        local addon2 = target:hasOutfit(outfit.id, 2)

        if hasOutfit then
            local addonStatus = ""
            if addon1 and addon2 then
                addonStatus = " ✅ (Addons 1+2)"
                table.insert(outfitsComAddons, outfit.name .. addonStatus)
            elseif addon1 then
                addonStatus = " ⚠️ (Só Addon 1)"
                table.insert(outfitsSemAddons, outfit.name .. addonStatus)
            elseif addon2 then
                addonStatus = " ⚠️ (Só Addon 2)"
                table.insert(outfitsSemAddons, outfit.name .. addonStatus)
            else
                addonStatus = " ❌ (Sem addons)"
                table.insert(outfitsSemAddons, outfit.name .. addonStatus)
            end
        else
            table.insert(outfitsSemAddons, outfit.name .. " ❌ (Não possui)")
        end
    end

    -- Enviar relatório
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🔍 RELATÓRIO DE ADDONS - " .. target:getName())

    if #outfitsComAddons > 0 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "✅ OUTFITS COM ADDONS COMPLETOS:")
        for _, outfit in pairs(outfitsComAddons) do
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "  " .. outfit)
        end
    end

    if #outfitsSemAddons > 0 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "❌ OUTFITS COM PROBLEMAS:")
        for _, outfit in pairs(outfitsSemAddons) do
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "  " .. outfit)
        end
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "💡 Use /corrigiraddons " .. target:getName() .. " para corrigir!")
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "🎉 Todos os outfits verificados estão com addons completos!")
    end

    return true
end

verificarAddons:separator(" ")
verificarAddons:groupType("god")
verificarAddons:register()
