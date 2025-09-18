-- Configurações dos Sets BiS (Best in Slot)
-- Centraliza todos os equipamentos BiS por vocação

BisSets = {
    -- Elite Knight (Vocation ID: 4)
    [4] = {
        name = "Elite Knight",
        items = {
            {id = 39148, name = "Spiritthorn Helmet", slot = "head"},
            {id = 39147, name = "Spiritthorn Armor", slot = "body"},
            {id = 43876, name = "Sanguine Legs", slot = "legs"},
            {id = 34097, name = "Pair of Soulwalkers", slot = "feet"},
            {id = 43871, name = "Grand Sanguine Razor", slot = "weapon"},
            {id = 43865, name = "Grand Sanguine Blade", slot = "weapon2"},
            {id = 39233, name = "Enchanted Turtle Amulet", slot = "necklace"},
            {id = 34099, name = "Soulbastion", slot = "shield"},
            {id = 39177, name = "Charged Spiritthorn Ring", slot = "ring"}
        }
    },

        -- Paladin (Vocation ID: 3)
    [3] = {
        name = "Paladin",
        items = {
            {id = 39149, name = "Alicorn Headguard", slot = "head"},
            {id = 34094, name = "Soulshell", slot = "body"},
            {id = 43881, name = "Sanguine Greaves", slot = "legs"},
            {id = 34098, name = "Pair of Soulstalkers", slot = "feet"},
            {id = 39150, name = "Alicorn Quiver", slot = "quiver"},
            {id = 43878, name = "Grand Sanguine Bow", slot = "weapon"},
            {id = 43880, name = "Grand Sanguine Crossbow", slot = "weapon2"},
            {id = 39180, name = "Charged Alicorn Ring", slot = "ring"},
            {id = 30344, name = "Enchanted Pendulet", slot = "necklace"},
        }
    },

    -- Sorcerer (Vocation ID: 1)
    [1] = {
        name = "Sorcerer",
        items = {
            {id = 39151, name = "Arcanomancer Regalia", slot = "body"},
            {id = 39152, name = "Arcanomancer Folio", slot = "book"},
            {id = 34095, name = "Soulmantle", slot = "legs"},
            {id = 34092, name = "Soulshanks", slot = "legs2"},
            {id = 43884, name = "Sanguine Boots", slot = "feet"},
            {id = 43883, name = "Grand Sanguine Coil", slot = "weapon"},
            {id = 39183, name = "Charged Arcanomancer Sigil", slot = "ring"},
            {id = 30403, name = "Enchanted Theurgic Amulet", slot = "necklace"},
            {id = 34090, name = "Soultainter", slot = "shield"}
        }
    },

    -- Druid (Vocation ID: 2)
    [2] = {
        name = "Druid",
        items = {
            {id = 30403, name = "Enchanted Theurgic Amulet", slot = "necklace"},
            {id = 43886, name = "Grand Sanguine Rod", slot = "weapon"},
            {id = 39186, name = "Charged Arboreal Ring", slot = "ring"},
            {id = 39153, name = "Arboreal Crown", slot = "head"},
            {id = 34096, name = "Soulshroud", slot = "body"},
            {id = 34093, name = "Soulstrider", slot = "legs"},
            {id = 43887, name = "Sanguine Galoshes", slot = "feet"},
            {id = 39154, name = "Arboreal Tome", slot = "book"},
            {id = 34091, name = "Soulhexer", slot = "shield"}
        }
    },

    -- Rook (Vocation ID: 0)
    [0] = {
        name = "Rook",
        items = {
            -- Rooks não têm set BiS
        }
    }
}

-- Funções auxiliares
function BisSets.getVocationSet(vocationId)
    return BisSets[vocationId]
end

function BisSets.getVocationName(vocationId)
    local set = BisSets[vocationId]
    return set and set.name or "Desconhecida"
end

function BisSets.getItems(vocationId)
    local set = BisSets[vocationId]
    return set and set.items or {}
end

function BisSets.hasSet(vocationId)
    local set = BisSets[vocationId]
    return set and #set.items > 0
end

-- Log das configurações
print(">> [BiS Sets] Sets BiS carregados!")
print(">> [BiS Sets] Elite Knight: " .. (#BisSets[4].items) .. " itens")
print(">> [BiS Sets] Paladin: " .. (#BisSets[3].items) .. " itens")
print(">> [BiS Sets] Sorcerer: " .. (#BisSets[1].items) .. " itens")
print(">> [BiS Sets] Druid: " .. (#BisSets[2].items) .. " itens")
