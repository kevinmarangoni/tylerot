# 🎯 Comandos de Skills Livres para Todos os Players

## 📋 Comandos Disponíveis

### 1. `/addskill` - Adicionar Skills a Outros Players
**Uso:** `/addskill <nome_jogador>, <skill>, [quantidade]`

**Skills disponíveis:**
- `sword` - Espada
- `axe` - Machado
- `club` - Clava
- `dist` - Distância
- `shield` - Escudo
- `fish` - Pesca
- `level` ou `l` - Level
- `magic` ou `m` - Magic Level

**Exemplos:**
```
/addskill PlayerName, sword, 5    # Adiciona 5 níveis de sword
/addskill PlayerName, magic, 3    # Adiciona 3 níveis de magic
/addskill PlayerName, level, 10   # Adiciona 10 levels
/addskill PlayerName, axe         # Adiciona 1 nível de axe
```

---

### 2. `/setskill` - Definir Skills Diretamente
**Uso:** `/setskill <nome_jogador>, <skill>, <nivel>`

**Skills disponíveis:** Mesmas do comando anterior

**Exemplos:**
```
/setskill PlayerName, sword, 100    # Define sword para nível 100
/setskill PlayerName, magic, 50     # Define magic para nível 50
/setskill PlayerName, level, 200    # Define level para 200
```

---

### 3. `/autoskill` - Adicionar Skills a Si Mesmo
**Uso:** `/autoskill <skill>, [quantidade]`

**Skills disponíveis:** Mesmas dos comandos anteriores

**Exemplos:**
```
/autoskill sword, 5     # Adiciona 5 níveis de sword a si mesmo
/autoskill magic, 3     # Adiciona 3 níveis de magic a si mesmo
/autoskill level, 10    # Adiciona 10 levels a si mesmo
/autoskill axe          # Adiciona 1 nível de axe a si mesmo
```

---

## 🔧 Como Funciona

### Comando `/addskill`
- **Antes:** Apenas jogadores com grupo "god" podiam usar
- **Agora:** Todos os players podem usar livremente
- Adiciona skills incrementando o nível atual

### Comando `/setskill` (NOVO)
- Permite definir skills diretamente para um nível específico
- Útil para configurar skills exatas
- Substitui o nível atual pelo especificado

### Comando `/autoskill` (NOVO)
- Permite adicionar skills a si mesmo
- Não precisa especificar nome de jogador
- Mais rápido para auto-melhoria

---

## ⚠️ Observações Importantes

1. **Todos os comandos são livres** - Não há restrições de grupo
2. **Logs são mantidos** - Todas as ações são registradas
3. **Skills são aplicadas em tempo real** - Não precisa relogar
4. **Compatível com vocações** - Respeita as limitações da vocação

---

## 🎮 Casos de Uso

### Para Players Novos
```
/autoskill level, 50      # Começar com level 50
/autoskill magic, 20      # Magic level 20
/autoskill sword, 30      # Sword fighting 30
```

### Para Ajudar Outros Players
```
/addskill AmigoName, level, 100    # Ajudar amigo a subir de level
/addskill AmigoName, magic, 50     # Ajudar com magic level
```

### Para Configurações Específicas
```
/setskill PlayerName, sword, 100   # Definir sword exato
/setskill PlayerName, magic, 80    # Definir magic exato
```

---

## 🔄 Recarregar Comandos

Se você fizer alterações nos arquivos, use:
```
/reload talkactions
```

---

## 📁 Arquivos Modificados

- `data/scripts/talkactions/god/add_skill.lua` - Removida restrição de grupo
- `data/scripts/talkactions/player/set_skill.lua` - Novo comando (criado)
- `data/scripts/talkactions/player/auto_skill.lua` - Novo comando (criado)

---

## ✅ Status

- ✅ Comando `/addskill` liberado para todos
- ✅ Novo comando `/setskill` criado
- ✅ Novo comando `/autoskill` criado
- ✅ Todos os comandos funcionando sem restrições
- ✅ Logs mantidos para segurança

**Agora todos os players podem usar comandos de skills livremente! 🎉**
