# 🎯 GUIA COMPLETO - SISTEMA DE QUESTS MASTER (PARA TODOS!)

## 🚀 COMANDOS PRINCIPAIS

### 📋 Sistema Geral (Todas as Quests)
```
/questmaster unlock                    # ✅ Libera TODAS as quests
/questmaster complete                 # 🏆 Completa TODAS as quests
/questmaster reset                    # 🔄 Reseta TODAS as quests
/questmaster status                   # 📊 Status de TODAS as quests
/questmaster help                     # ❓ Ajuda do sistema
```

### 🎭 Sistema por Categorias
```
/questcategory outfits unlock         # 👕 Libera quests de outfits
/questcategory arena complete         # ⚔️ Completa quests de arena
/questcategory inquisition unlock     # 🔥 Libera quests da inquisição
/questcategory yalahar complete       # 🏛️ Completa quests de Yalahar
/questcategory emperor unlock         # 👑 Libera quests do imperador
/questcategory ferumbras complete     # 💎 Completa quests de Ferumbras
/questcategory cults unlock           # 🕯️ Libera quests de cultos
/questcategory help                   # ❓ Ajuda das categorias
```

### 🎯 Comandos com Alvo (Outros Jogadores)
```
/questmaster unlock target Joao      # ✅ Libera TODAS as quests para Joao
/questmaster complete target Maria   # 🏆 Completa TODAS as quests para Maria
/questcategory target Pedro outfits unlock    # 👕 Libera outfits para Pedro
/questcategory target Ana emperor complete   # 👑 Completa imperador para Ana
```

## 🎮 COMO USAR

### 1️⃣ Para Você Mesmo
```
/questmaster unlock                   # Libera todas as quests
/questmaster complete                # Completa todas as quests
/questmaster status                  # Ver status atual
```

### 2️⃣ Para Outros Jogadores
```
/questmaster unlock target Nome      # Libera para outro jogador
/questmaster complete target Nome    # Completa para outro jogador
```

### 3️⃣ Para Categorias Específicas
```
/questcategory outfits unlock        # Só outfits
/questcategory arena complete        # Só arena
/questcategory emperor unlock        # Só imperador
```

## 🏆 QUESTS INCLUÍDAS

### 👕 **OUTFITS** (5 quests)
- Beggar, Hunter, Mage, Nobleman, Warrior

### ⚔️ **ARENA** (3 quests)
- Greenhorn, Scrapper, Warlord

### 🔥 **INQUISIÇÃO** (10 missões)
- Missões 01 a 10 da Inquisição

### 🏛️ **YALAHAR** (10 missões)
- Missões 01 a 10 de Yalahar

### 👑 **IMPERADOR** (12 missões)
- Missões 01 a 12 do Imperador

### 💎 **FERUMBRAS** (10 quests)
- 8 cristais + All Crystals + Essência

### 🕯️ **CULTOS** (13 acessos)
- Minotaurs, MotA, Barkless, Life, Misguided, Final Boss

### 🌟 **OUTRAS QUESTS**
- Queen of the Banshees (22 etapas)
- Bigfoot's Burden (30 etapas)
- Ancient Tombs, Ape City, Secret Service
- New Frontier, Oramond, Secret Library

## 📝 EXEMPLOS PRÁTICOS

### 🎯 Cenário 1: Jogador quer todas as quests
```
/questmaster unlock target NomeJogador
```

### 🎯 Cenário 2: Jogador quer só outfits
```
/questcategory target NomeJogador outfits unlock
```

### 🎯 Cenário 3: Jogador quer completar arena
```
/questcategory target NomeJogador arena complete
```

### 🎯 Cenário 4: Verificar status
```
/questmaster status target NomeJogador
```

## ⚠️ IMPORTANTE

- **Todos os jogadores** podem usar estes comandos
- **Não é necessário ser administrador**
- **Todas as operações são instantâneas**
- **Questlog é atualizado automaticamente**
- **Sistema funciona para qualquer jogador online**

## 🧪 TESTE DO SISTEMA

```
/testquest                           # Testa se o sistema está funcionando
```

## 📚 ARQUIVOS DO SISTEMA

- `quest_master.lua` - Sistema principal
- `quest_categories.lua` - Sistema de categorias
- `test_quest_system.lua` - Sistema de teste
- `README_QUEST_MASTER.md` - Documentação completa
- `QUESTS_COMPLETE_GUIDE.md` - Este guia resumido

---

## 🎉 RESUMO RÁPIDO

**Para liberar TODAS as quests:** `/questmaster unlock`
**Para completar TODAS as quests:** `/questmaster complete`
**Para liberar só outfits:** `/questcategory outfits unlock`
**Para outro jogador:** Adicione `target Nome` no comando

**Exemplo:** `/questmaster unlock target Joao` libera todas as quests para Joao!
