-- Configurações Globais do Servidor
-- Personalize os valores aqui

GlobalSettings = {
    -- Configurações de Dinheiro
    MONEY = {
        DEFAULT_AMOUNT = 9999999999,
        APPLY_ON_LOGIN = true,
        APPLY_ON_STARTUP = true
    },

    -- Configurações de Blessings
    BLESSINGS = {
        DEFAULT_AMOUNT = 120,
        APPLY_ON_LOGIN = true,
        APPLY_ON_STARTUP = true,
        BLESSINGS_LIST = {1, 2, 3, 4, 5, 6, 7, 8} -- IDs das blessings
    },

    -- Configurações de Tibia Coins
    TIBIA_COINS = {
        DEFAULT_AMOUNT = 9999999999,
        APPLY_ON_LOGIN = false, -- Por segurança, não aplicar automaticamente
        APPLY_ON_STARTUP = false,
        APPLY_ONLY_TO_ADMINS = true -- Apenas admins recebem automaticamente
    },

    -- Configurações Gerais
    GENERAL = {
        ENABLE_AUTO_APPLY = true,
        SHOW_MESSAGES = true,
        LOG_ACTIONS = true,
        DELAY_ON_LOGIN = 1000 -- Delay em ms para aplicar no login
    }
}

-- Função para obter configuração
function GlobalSettings.get(key)
    local keys = key:split(".")
    local value = GlobalSettings

    for _, k in pairs(keys) do
        if value[k] then
            value = value[k]
        else
            return nil
        end
    end

    return value
end

-- Função para definir configuração
function GlobalSettings.set(key, value)
    local keys = key:split(".")
    local current = GlobalSettings

    for i = 1, #keys - 1 do
        if not current[keys[i]] then
            current[keys[i]] = {}
        end
        current = current[keys[i]]
    end

    current[keys[#keys]] = value
end

-- Função para verificar se uma configuração está ativa
function GlobalSettings.isEnabled(key)
    local value = GlobalSettings.get(key)
    return value == true
end

-- Função para obter valor numérico
function GlobalSettings.getNumber(key)
    local value = GlobalSettings.get(key)
    return tonumber(value) or 0
end

-- Função para obter string
function GlobalSettings.getString(key)
    local value = GlobalSettings.get(key)
    return tostring(value) or ""
end

print(">> [Global Settings] Configurações globais carregadas!")
print(">> [Global Settings] Dinheiro padrão: " .. GlobalSettings.getNumber("MONEY.DEFAULT_AMOUNT"))
print(">> [Global Settings] Blessings padrão: " .. GlobalSettings.getNumber("BLESSINGS.DEFAULT_AMOUNT"))
print(">> [Global Settings] Tibia Coins padrão: " .. GlobalSettings.getNumber("TIBIA_COINS.DEFAULT_AMOUNT"))
