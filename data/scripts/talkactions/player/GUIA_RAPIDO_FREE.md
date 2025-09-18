# 🚀 GUIA RÁPIDO - REMOVER LIMITAÇÕES FREE ACCOUNTS

## 🎯 **CONFIGURAÇÕES ESSENCIAIS**

### **1️⃣ PREMIUM GRATUITO (OBRIGATÓRIO)**
```lua
-- No config.lua, linha ~445
freePremium = true  -- Muda de false para true
```

### **2️⃣ SISTEMA VIP (OBRIGATÓRIO)**
```lua
-- No config.lua, linha ~576
vipSystemEnabled = true  -- Muda de false para true
vipStayOnline = true     -- Muda de false para true
vipKeepHouse = true      -- Muda de false para true
```

## 🔧 **COMO APLICAR**

### **Passo 1: Abrir config.lua**
```bash
# Na raiz do servidor
nano config.lua
# ou
code config.lua
```

### **Passo 2: Localizar e alterar**
```lua
-- Procure por estas linhas:
freePremium = false      -- Mude para true
vipSystemEnabled = false -- Mude para true
vipStayOnline = false    -- Mude para true
vipKeepHouse = false     -- Mude para true
```

### **Passo 3: Salvar e reiniciar**
```bash
# Salve o arquivo e reinicie
./start.sh
```

## 📋 **CONFIGURAÇÕES EXTRAS (OPCIONAIS)**

### **🎮 SISTEMAS DE JOGO:**
```lua
-- Prey e Task Hunting
preyFreeThirdSlot = true           -- Terceiro slot para todos
taskHuntingFreeThirdSlot = true    -- Terceiro slot para todos

-- Viagens
toggleTravelsFree = true           -- Viagens gratuitas

-- Market
premiumToCreateMarketOffer = false -- Market para todos
```

### **🏦 DEPOSIT:**
```lua
-- Limites maiores
freeDepotLimit = 2000000           -- 2 milhões para free
premiumDepotLimit = 1000000        -- 1 milhão para premium
depotBoxes = 50                    -- 50 caixas
```

## ⚡ **COMANDO RÁPIDO**

### **Para administradores:**
```
/applyfreeconfig
```
**Mostra todas as configurações e tenta aplicá-las automaticamente**

## 🎊 **RESULTADO**

**Após aplicar:**

✅ **Todos os jogadores terão premium**
✅ **Sem limitações de deposit**
✅ **Acesso a todos os sistemas**
✅ **Prey e task hunting completos**
✅ **Viagens gratuitas**
✅ **Market acessível para todos**

## ⚠️ **IMPORTANTE**

- **Reinicie o servidor** após alterar o config.lua
- **Configurações principais** são obrigatórias
- **Configurações extras** são opcionais
- **Todos os jogadores** terão as mesmas vantagens

---

## 🎯 **RESUMO RÁPIDO:**

**1. Abra `config.lua`**
**2. Mude `freePremium = true`**
**3. Mude `vipSystemEnabled = true`**
**4. Salve e reinicie**
**5. Pronto! Todos terão premium!** 🎉

**Essas são as configurações essenciais para remover limitações de free accounts!** 🔓
