# ⚡ Sistema de Speed Sets - Canary Server

## **Descrição**
Sistema completo que identifica automaticamente a vocação do jogador e aplica o speed set apropriado com itens que aumentam velocidade de movimento. Implementado para todas as vocações.

## **🎯 Funcionalidades**

### **✅ Identificação Automática de Vocação**
**Vocações Básicas:**
- **Sorcerer (ID: 1)**: Speed Set completo implementado
- **Druid (ID: 2)**: Speed Set completo implementado
- **Paladin (ID: 3)**: Speed Set completo implementado
- **Knight (ID: 4)**: Speed Set completo implementado

**Vocações Promovidas:**
- **Master Sorcerer (ID: 5)**: Speed Set completo implementado
- **Elder Druid (ID: 6)**: Speed Set completo implementado
- **Royal Paladin (ID: 7)**: Speed Set completo implementado
- **Elite Knight (ID: 8)**: Speed Set completo implementado

**Outras:**
- **Rook (ID: 0)**: Speed Set básico (2 itens)

### **🎮 Comando Principal**
- **`/speedset [nome_jogador]`** - Aplica speed set baseado na vocação

## **📁 Arquivos Criados**

1. **`data/scripts/config/speed_sets.lua`** - Configurações centralizadas dos speed sets
2. **`data/scripts/talkactions/speedset_equipment.lua`** - Comando principal (para todos os jogadores)

## **⚡ Speed Sets Implementados**

### **Todas as Vocações (13 itens):**
- **Tiara of Power** (ID: 23475) - Capacete mágico
- **Depth Galea** (ID: 13995) - Capacete subaquático
- **Grasshopper Legs** (ID: 14087) - Calças +10 speed
- **Crest of the Deep Seas** (ID: 21892) - Armadura +5 speed
- **Werewolf Helmet** (ID: 22062) - Capacete +15 speed
- **Elite Draken Mail** (ID: 11651) - Armadura +10 speed
- **Prismatic Armor** (ID: 16110) - Armadura +15 speed
- **Swan Feather Cloak** (ID: 25779) - Capa especial
- **Zaoan Armor** (ID: 10384) - Armadura +10 speed
- **Sparking Rainbow Shield** (ID: 8080) - Escudo com speed
- **Boots of Haste** (ID: 3079) - Botas +20 speed (PRINCIPAL)
- **Void Boots** (ID: 23476) - Botas especiais
- **Time Ring** (ID: 3053) - Anel +10 speed (PRINCIPAL)

### **Rooks (2 itens):**
- **Boots of Haste** (ID: 3079) - Botas +20 speed
- **Time Ring** (ID: 3053) - Anel +10 speed

## **🚀 Como Usar**

### **Comando Básico:**
```
/speedset                    -- Aplica speed set para você mesmo
/speedset NomeDoJogador     -- Aplica speed set para outro jogador
```

### **Exemplo de Uso:**
```
/speedset                    -- Você recebe speed set da sua vocação
/speedset TylerOT            -- TylerOT recebe speed set da vocação dele
```

## **📊 Benefícios de Velocidade**

### **🏃 Bônus de Speed Aproximado:**
- **Boots of Haste**: +20 speed
- **Time Ring**: +10 speed
- **Werewolf Helmet**: +15 speed
- **Prismatic Armor**: +15 speed
- **Grasshopper Legs**: +10 speed
- **Elite Draken Mail**: +10 speed
- **Zaoan Armor**: +10 speed
- **Crest of Deep Seas**: +5 speed

**Total Aproximado: +95 speed** 🚀

## **⚙️ Configuração para Outras Vocações**

### **Para adicionar speed sets de outras vocações:**

1. **Editar `data/scripts/config/speed_sets.lua`**
2. **Adicionar itens na seção da vocação desejada:**

```lua
-- Exemplo para nova vocação
[9] = {
    name = "Nova Vocação",
    items = {
        {id = 3079, name = "Boots of Haste", slot = "feet"},
        {id = 3053, name = "Time Ring", slot = "ring"},
        -- ... mais itens
    }
}
```

## **🔧 Instalação**

1. **Copiar arquivos** para as pastas corretas
2. **Reiniciar servidor** para ativar o comando
3. **Testar** com `/speedset` em qualquer personagem

## **📊 Benefícios**

- **✅ Identificação automática** da vocação
- **✅ Speed set completo** com um comando
- **✅ Funciona para todas as vocações** (incluindo Rooks)
- **✅ Verificação de capacidade** do inventário
- **✅ Fallback para inventário cheio** (dropa no chão)
- **✅ Logs detalhados** no console
- **✅ Cálculo de bônus de speed** em tempo real
- **✅ Efeitos visuais especiais** (anéis amarelos + teleporte)

## **⚠️ Requisitos**

- **Qualquer jogador** pode usar o comando
- **Capacidade mínima** de 1000 no inventário
- **Funciona com todas as vocações** (incluindo Rooks)

## **🎮 Resultado Final**

Após usar `/speedset`:

**Vocações Básicas e Promovidas:**
- **Todas**: ✅ Speed set completo de 13 itens (+~95 speed)

**Rooks:**
- **Rook**: ✅ Speed set básico de 2 itens (+30 speed)

## **🏃 Comparação de Velocidade**

**❌ ANTES:**
- Velocidade normal do personagem

**✅ APÓS `/speedset`:**
- **+95 speed** para vocações normais
- **+30 speed** para Rooks
- **Movimento MUITO mais rápido**
- **Ideal para PVP e hunts**

---

**⚡ Sistema Speed Set COMPLETO ativado! Todas as vocações podem correr como o vento! 🏃💨**

