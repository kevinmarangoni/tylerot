-- Configurações de Premium Global
-- Aplica premium status para todas as contas automaticamente

PremiumSettings = {
    -- Configurações principais
    ENABLE_GLOBAL_PREMIUM = true,
    APPLY_ON_LOGIN = true,
    APPLY_ON_STARTUP = true,
    
    -- Configurações de premium
    PREMIUM_DAYS = 999999, -- Dias de premium (999999 = ~2739 anos)
    PREMIUM_ACCOUNT_TYPE = 3, -- 1=Normal, 2=Premium, 3=GOD
    
    -- Configurações de mensagens
    SHOW_MESSAGES = true,
    LOG_ACTIONS = true,
    
    -- Configurações de delay
    DELAY_ON_LOGIN = 1000, -- Delay em ms após login
    DELAY_ON_STARTUP = 5000 -- Delay em ms após startup
}

-- Funções auxiliares
function PremiumSettings.isEnabled(setting)
    return PremiumSettings[setting] == true
end

function PremiumSettings.getNumber(setting)
    return PremiumSettings[setting] or 0
end

function PremiumSettings.get(setting)
    return PremiumSettings[setting]
end

-- Log das configurações
print(">> [Premium Settings] Configurações de premium carregadas!")
print(">> [Premium Settings] Premium global: " .. (PremiumSettings.isEnabled("ENABLE_GLOBAL_PREMIUM") and "ATIVADO" or "DESATIVADO"))
print(">> [Premium Settings] Dias de premium: " .. PremiumSettings.getNumber("PREMIUM_DAYS"))
print(">> [Premium Settings] Tipo de conta: " .. PremiumSettings.getNumber("PREMIUM_ACCOUNT_TYPE"))
