# ⚔️ Sistema de Equipamentos BiS (Best in Slot) - Canary Server

## **Descrição**
Sistema inteligente que identifica automaticamente a vocação do jogador e aplica o set BiS apropriado. Atualmente implementado para Elite Knight, com estrutura preparada para outras vocações.

## **🎯 Funcionalidades**

### **✅ Identificação Automática de Vocação**
**Vocações Básicas:**
- **Sorcerer (ID: 1)**: Set BiS completo implementado
- **Druid (ID: 2)**: Set BiS completo implementado
- **Paladin (ID: 3)**: Set BiS completo implementado
- **Knight (ID: 4)**: Set BiS completo implementado

**Vocações Promovidas:**
- **Master Sorcerer (ID: 5)**: Set BiS completo implementado
- **Elder Druid (ID: 6)**: Set BiS completo implementado
- **Royal Paladin (ID: 7)**: Set BiS completo implementado
- **Elite Knight (ID: 8)**: Set BiS completo implementado

**Outras:**
- **Rook (ID: 0)**: Sem set BiS (precisa evoluir)

### **🎮 Comando Principal**
- **`/bis [nome_jogador]`** - Aplica set BiS baseado na vocação

## **📁 Arquivos Criados**

1. **`data/scripts/config/bis_sets.lua`** - Configurações centralizadas dos sets
2. **`data/scripts/talkactions/bis_equipment.lua`** - Comando principal (para todos os jogadores)

## **⚔️ Sets BiS Implementados**

### **Elite Knight (9 itens):**
- **Capacete**: Spiritthorn Helmet (ID: 39148)
- **Armadura**: Spiritthorn Armor (ID: 39147)
- **Calças**: Sanguine Legs (ID: 75876)
- **Botas**: Pair of Soulwalkers (ID: 34097)
- **Arma Principal**: Sanguine Razor (ID: 43870)
- **Arma Secundária**: Sanguine Blade (ID: 43864)
- **Amuleto**: Enchanted Turtle Amulet (ID: 39233)
- **Escudo**: Soulbastion (ID: 34099)
- **Anel**: Charged Spiritthorn Ring (ID: 39177)

### **Paladin (8 itens):**
- **Capacete**: Alicorn Headguard (ID: 39149)
- **Calças**: Sanguine Greaves (ID: 75877)
- **Botas**: Pair of Soulstalkers (ID: 34098)
- **Aljava**: Alicorn Quiver (ID: 43871)
- **Arco**: Grand Sanguine Bow (ID: 43865)
- **Besta**: Grand Sanguine Crossbow (ID: 43866)
- **Anel**: Charged Alicorn Ring (ID: 39178)
- **Amuleto**: Pendulant Amulet (ID: 39237)

### **Sorcerer (9 itens):**
- **Armadura**: Arcanomancer Regalia (ID: 39150)
- **Livro**: Arcanomancer Folio (ID: 39151)
- **Calças**: Soulmantle (ID: 75878)
- **Calças2**: Soulshanks (ID: 75879)
- **Botas**: Sanguine Boots (ID: 34100)
- **Arma**: Grand Sanguine Coil (ID: 43872)
- **Anel**: Charged Arcanomancer Sigil (ID: 39179)
- **Amuleto**: Enchanted Theurgic Amulet (ID: 39235)
- **Escudo**: Soultainter (ID: 34101)

### **Druid (9 itens):**
- **Amuleto**: Enchanted Theurgic Amulet (ID: 30403)
- **Arma**: Grand Sanguine Rod (ID: 43886)
- **Anel**: Charged Arboreal Ring (ID: 39186)
- **Coroa**: Arboreal Crown (ID: 39153)
- **Armadura**: Soulshroud (ID: 34096)
- **Calças**: Soulstrider (ID: 34093)
- **Botas**: Sanguine Galoshes (ID: 43887)
- **Livro**: Arboreal Tome (ID: 39154)
- **Escudo**: Soulhexer (ID: 34091)

## **🚀 Como Usar**

### **Comando Básico:**
```
/bis                    -- Aplica set BiS para você mesmo
/bis NomeDoJogador     -- Aplica set BiS para outro jogador
```

### **Exemplo de Uso:**
```
/bis                    -- Você recebe set BiS da sua vocação
/bis TylerOT            -- TylerOT recebe set BiS da vocação dele
```

## **⚙️ Configuração para Outras Vocações**

### **Para adicionar sets BiS de outras vocações:**

1. **Editar `data/scripts/config/bis_sets.lua`**
2. **Adicionar itens na seção da vocação desejada:**

```lua
-- Exemplo para Paladin
[3] = {
    name = "Paladin",
    items = {
        {id = 12345, name = "Helmet BiS", slot = "head"},
        {id = 12346, name = "Armor BiS", slot = "body"},
        -- ... mais itens
    }
}
```

## **🔧 Instalação**

1. **Copiar arquivos** para as pastas corretas
2. **Reiniciar servidor** para ativar o comando
3. **Testar** com `/bis` em qualquer personagem

## **📊 Benefícios**

- **✅ Identificação automática** da vocação
- **✅ Set completo** com um comando
- **✅ Estrutura flexível** para adicionar outras vocações
- **✅ Verificação de capacidade** do inventário
- **✅ Fallback para inventário cheio** (dropa no chão)
- **✅ Logs detalhados** no console

## **⚠️ Requisitos**

- **Qualquer jogador** pode usar o comando
- **Capacidade mínima** de 1000 no inventário
- **Vocação evoluída** (não funciona com Rooks)

## **🎮 Resultado Final**

Após usar `/bis`:

**Vocações Básicas:**
- **Knight**: ✅ Set completo de 9 itens BiS
- **Paladin**: ✅ Set completo de 9 itens BiS
- **Sorcerer**: ✅ Set completo de 9 itens BiS
- **Druid**: ✅ Set completo de 9 itens BiS

**Vocações Promovidas:**
- **Elite Knight**: ✅ Set completo de 9 itens BiS
- **Royal Paladin**: ✅ Set completo de 9 itens BiS
- **Master Sorcerer**: ✅ Set completo de 9 itens BiS
- **Elder Druid**: ✅ Set completo de 9 itens BiS

**Outras:**
- **Rooks**: ❌ Mensagem para evoluir primeiro

---

**⚔️ Sistema BiS COMPLETO ativado com sucesso! Todas as vocações implementadas!**
