local applyPremiumCommand = TalkAction("/applypremium")

function applyPremiumCommand.onSay(player, words, param)
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
    
    -- Carregar configurações
    dofile('data/scripts/config/premium_settings.lua')
    
    local accountId = target:getAccountId()
    local premiumDays = PremiumSettings.getNumber("PREMIUM_DAYS")
    local accountType = PremiumSettings.getNumber("PREMIUM_ACCOUNT_TYPE")
    local premiumEndsAt = os.time() + (premiumDays * 24 * 60 * 60)
    
    -- Aplicar premium na conta
    db.query("UPDATE accounts SET premium_ends_at = " .. premiumEndsAt .. " WHERE id = " .. accountId)
    db.query("UPDATE accounts SET type = " .. accountType .. " WHERE id = " .. accountId)
    
    -- Mensagens de confirmação
    target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sua conta foi configurada com premium por " .. premiumDays .. " dias!")
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Premium aplicado para " .. target:getName() .. " por " .. premiumDays .. " dias!")
    
    -- Efeito visual
    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    
    -- Log do comando
    logCommand(player, words, param)
    
    return true
end

applyPremiumCommand:separator(" ")
applyPremiumCommand:groupType("god")
applyPremiumCommand:register()
