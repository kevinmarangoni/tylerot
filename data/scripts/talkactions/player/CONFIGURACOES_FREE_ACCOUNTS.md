# 🔓 CONFIGURAÇÕES PARA REMOVER LIMITAÇÕES DE FREE ACCOUNTS

## 📋 **Descrição**
Este guia mostra todas as configurações no `config.lua` que podem ser alteradas para remover as limitações de free accounts e dar acesso premium a todos os jogadores.

## 🎯 **CONFIGURAÇÕES PRINCIPAIS**

### **1️⃣ FREE PREMIUM (MAIS IMPORTANTE)**
```lua
-- Linha 445: Ativa premium gratuito para todos
freePremium = true  -- Muda de false para true
```
**O que faz:** Dá status premium a todos os jogadores automaticamente

### **2️⃣ ACESSO APENAS PARA PREMIUM**
```lua
-- Linha 257: Remove restrições de acesso premium
onlyPremiumAccount = false  -- Já está false (bom!)
```
**O que faz:** Permite que free accounts acessem áreas restritas

### **3️⃣ SISTEMA VIP (ALTERNATIVA AO PREMIUM)**
```lua
-- Linha 576: Ativa sistema VIP que sobrescreve verificações premium
vipSystemEnabled = true  -- Muda de false para true
vipBonusExp = 0         -- Bônus de experiência (0-100%)
vipBonusLoot = 0        -- Bônus de loot (0-100%)
vipBonusSkill = 0       -- Bônus de skill (0-100%)
vipAutoLootVipOnly = false  -- Auto loot para todos
vipStayOnline = true    -- Não kicka por inatividade
vipKeepHouse = true     -- Mantém casa mesmo offline
```

## 🏦 **CONFIGURAÇÕES DE DEPOSIT**

### **4️⃣ LIMITE DE DEPOSIT**
```lua
-- Linha 80-81: Aumenta limite de deposit para free accounts
freeDepotLimit = 2000000    -- Aumenta de 200000 para 2000000
premiumDepotLimit = 1000000 -- Aumenta de 10000 para 1000000
```

### **5️⃣ CAIXAS DE DEPOSIT**
```lua
-- Linha 82: Aumenta número de caixas
depotBoxes = 50  -- Aumenta de 20 para 50
```

## 🎮 **SISTEMAS DE JOGO**

### **6️⃣ PREY SYSTEM**
```lua
-- Linha 121: Ativa terceiro slot de prey para todos
preyFreeThirdSlot = true  -- Muda de false para true

-- Linha 126: Reduz tempo de espera para reroll gratuito
preyFreeRerollTime = 5 * 60 * 60  -- Reduz de 20 horas para 5 horas
```

### **7️⃣ TASK HUNTING**
```lua
-- Linha 133: Ativa terceiro slot de task hunting para todos
taskHuntingFreeThirdSlot = true  -- Muda de false para true

-- Linha 138: Reduz tempo de espera para reroll gratuito
taskHuntingFreeRerollTime = 5 * 60 * 60  -- Reduz de 20 horas para 5 horas
```

### **8️⃣ VIAGENS GRATUITAS**
```lua
-- Linha 286: Ativa viagens gratuitas de barco
toggleTravelsFree = true  -- Muda de false para true
```

### **9️⃣ QUEST GRATUITAS**
```lua
-- Linha 342: Sistema de quests gratuitas (já está ativo)
toggleFreeQuest = true  -- Já está true (bom!)
```

## 🛡️ **PROTEÇÕES E RESTRIÇÕES**

### **🔓 REMOVER RESTRIÇÕES DE PREMIUM**
```lua
-- Linha 411: Permite free accounts criarem ofertas no market
premiumToCreateMarketOffer = false  -- Muda de true para false
```

### **🔓 REMOVER VERIFICAÇÕES DE PREMIUM**
```lua
-- Linha 214-215: Sistema de loyalty points
loyaltyPointsPerPremiumDaySpent = 0      -- Já está 0 (bom!)
loyaltyPointsPerPremiumDayPurchased = 0  -- Já está 0 (bom!)
```

## 📊 **CONFIGURAÇÕES RECOMENDADAS**

### **🎯 CONFIGURAÇÃO MÍNIMA (ESSENCIAL):**
```lua
-- ESSENCIAL: Ativa premium gratuito para todos
freePremium = true

-- ESSENCIAL: Ativa sistema VIP
vipSystemEnabled = true
vipStayOnline = true
vipKeepHouse = true
```

### **🎯 CONFIGURAÇÃO COMPLETA (RECOMENDADA):**
```lua
-- PREMIUM GRATUITO
freePremium = true

-- SISTEMA VIP
vipSystemEnabled = true
vipBonusExp = 0
vipBonusLoot = 0
vipBonusSkill = 0
vipAutoLootVipOnly = false
vipStayOnline = true
vipKeepHouse = true

-- DEPOSIT
freeDepotLimit = 2000000
premiumDepotLimit = 1000000
depotBoxes = 50

-- PREY E TASK HUNTING
preyFreeThirdSlot = true
preyFreeRerollTime = 5 * 60 * 60
taskHuntingFreeThirdSlot = true
taskHuntingFreeRerollTime = 5 * 60 * 60

-- VIAGENS
toggleTravelsFree = true

-- MARKET
premiumToCreateMarketOffer = false
```

## 🔧 **COMO APLICAR**

### **1. Edite o arquivo `config.lua`:**
```bash
# Abra o arquivo config.lua na raiz do servidor
nano config.lua
# ou
code config.lua
```

### **2. Localize e altere as linhas:**
```lua
-- Procure por estas linhas e altere os valores:
freePremium = true                    -- Linha ~445
vipSystemEnabled = true              -- Linha ~576
vipStayOnline = true                 -- Linha ~582
vipKeepHouse = true                  -- Linha ~583
```

### **3. Salve e reinicie o servidor:**
```bash
# Reinicie o servidor para aplicar as mudanças
./start.sh
```

## ⚠️ **IMPORTANTE**

### **✅ VANTAGENS:**
- **Todos os jogadores** terão acesso premium
- **Sem limitações** de deposit, prey, task hunting
- **Sistema VIP** ativo para funcionalidades extras
- **Viagens gratuitas** de barco
- **Market acessível** para todos

### **⚠️ CONSIDERAÇÕES:**
- **Perda de receita** se o servidor era pago
- **Todos os jogadores** terão as mesmas vantagens
- **Sistema de premium** tradicional não terá valor
- **Recomendado** para servidores gratuitos ou de teste

## 🎊 **RESULTADO FINAL**

**Após aplicar estas configurações:**

✅ **Todos os jogadores terão status premium**
✅ **Sem limitações de deposit**
✅ **Acesso a todos os sistemas**
✅ **Prey e task hunting completos**
✅ **Viagens gratuitas**
✅ **Market acessível para todos**

---

## 🚀 **COMEÇANDO AGORA:**

**1. Abra o `config.lua`**
**2. Mude `freePremium = true`**
**3. Mude `vipSystemEnabled = true`**
**4. Salve e reinicie o servidor**
**5. Todos os jogadores terão premium!** 🎉

**Essas são as principais configurações para remover limitações de free accounts!** 🔓
