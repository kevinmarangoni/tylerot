-- Configurações do Haste Set
-- Centraliza todos os equipamentos de Haste

HasteSets = {
    -- Haste Set (para todas as vocações)
    ["haste"] = {
        name = "Haste Set",
        items = {
            {id = 9042, name = "magical torch", slot = "light"},
            {id = 3079, name = "boots of haste", slot = "feet"},
            {id = 11651, name = "elite draken mail", slot = "body"},
            {id = 22062, name = "werewolf helmet", slot = "head"},
            {id = 21892, name = "crest of the deep seas", slot = "shield"},
            {id = 21168, name = "alloy legs", slot = "legs"},
            {id = 16110, name = "prismatic armor", slot = "body"},
            {id = 23475, name = "tiara of power", slot = "head"},
            {id = 23476, name = "void boots", slot = "feet"},
            {id = 19357, name = "shrunken head necklace", slot = "necklace"},
            {id = 25779, name = "swan feather cloak", slot = "body"},
            {id = 3053, name = "time ring", slot = "ring"},
            {id = 14087, name = "grasshopper legs", slot = "legs"}
        }
    }
}

-- Funções auxiliares
function HasteSets.getSet(setName)
    return HasteSets[setName]
end

function HasteSets.getSetName(setName)
    local set = HasteSets[setName]
    return set and set.name or "Desconhecido"
end

function HasteSets.getItems(setName)
    local set = HasteSets[setName]
    return set and set.items or {}
end

function HasteSets.hasSet(setName)
    local set = HasteSets[setName]
    return set and #set.items > 0
end

-- Log das configurações
print(">> [Haste Sets] Haste Set carregado!")
print(">> [Haste Sets] Haste Set: " .. (#HasteSets["haste"].items) .. " itens")
