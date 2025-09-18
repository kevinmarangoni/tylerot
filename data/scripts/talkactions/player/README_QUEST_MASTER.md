# Sistema Quest Master - Comandos para Todos os Jogadores

## Descrição
O sistema Quest Master permite que qualquer jogador libere, complete, resete e verifique o status de todas as quests do servidor para si mesmo ou para outros jogadores.

## Comandos Disponíveis

### Comandos Básicos
- `/questmaster unlock` - Libera todas as quests para o jogador atual
- `/questmaster complete` - Completa todas as quests para o jogador atual
- `/questmaster reset` - Reseta todas as quests para o jogador atual
- `/questmaster status` - Mostra o status de todas as quests do jogador atual
- `/questmaster help` - Mostra todos os comandos disponíveis

### Comandos com Alvo
- `/questmaster unlock target <nome>` - Libera todas as quests para outro jogador
- `/questmaster complete target <nome>` - Completa todas as quests para outro jogador
- `/questmaster reset target <nome>` - Reseta todas as quests para outro jogador
- `/questmaster status target <nome>` - Mostra o status das quests de outro jogador

## Sistema de Categorias

### Comando Principal
- `/questcategory <categoria> <acao>` - Aplica ação em uma categoria específica

### Categorias Disponíveis
- **outfits** - Quests de outfits (Beggar, Hunter, Mage, Nobleman, Warrior)
- **arena** - Quests de arena (Greenhorn, Scrapper, Warlord)
- **inquisition** - Quests da Inquisição (10 missões)
- **yalahar** - Quests de Yalahar (10 missões)
- **emperor** - Quests do Imperador (12 missões)
- **ferumbras** - Quests de Ferumbras (8 cristais + essência)
- **cults** - Quests de cultos (13 acessos diferentes)

### Ações Disponíveis
- **unlock** - Libera todas as quests da categoria
- **complete** - Completa todas as quests da categoria

### Exemplos de Uso por Categoria
```
/questcategory outfits unlock          # Libera todas as quests de outfits
/questcategory arena complete          # Completa todas as quests de arena
/questcategory inquisition unlock      # Libera todas as quests da inquisição
/questcategory yalahar complete        # Completa todas as quests de Yalahar
/questcategory emperor unlock          # Libera todas as quests do imperador
/questcategory ferumbras complete      # Completa todas as quests de Ferumbras
/questcategory cults unlock            # Libera todas as quests de cultos
```

### Comandos com Alvo para Categorias
- `/questcategory target <nome> <categoria> <acao>` - Aplica em outro jogador

### Exemplos com Alvo
```
/questcategory target Joao outfits unlock      # Libera outfits para Joao
/questcategory target Maria arena complete     # Completa arena para Maria
/questcategory target Pedro emperor unlock     # Libera imperador para Pedro
```

## Quests Incluídas no Sistema

### U7_2 - The Queen of the Banshees
- Quest Line (22 etapas)
- First Seal, Second Seal, Third Seal, Fourth Seal, Fifth Seal, Sixth Seal, Last Seal
- Final Battle

### U7_4 - The Ancient Tombs
- Ashmunrah Tomb, Diprath Tomb, Thalas Tomb

### U7_6 - The Ape City
- Chor Quest, Fibula Quest, Casks Quest, Dworc Quest

### U7_8 - Outfits
- Beggar Outfits, Hunter Outfits, Mage and Summoner Outfits
- Nobleman Outfits, Warrior Outfits

### U8_0 - Barbarian Arena
- Greenhorn Arena, Scrapper Arena, Warlord Arena

### U8_1 - Secret Service
- 10 missões diferentes (CGB, TBI, AVIN)

### U8_2 - The Inquisition
- 10 missões da Inquisição

### U8_4 - In Service of Yalahar
- 10 missões de Yalahar

### U8_5 - Killing in the Name of
- 10 missões de Killing

### U8_6 - Wrath of the Emperor
- 12 missões do Imperador

### U8_54 - The New Frontier
- 10 missões da Nova Fronteira

### U9_60 - Bigfoot's Burden
- Quest Line (30 etapas)
- Rank (máximo)

### U10_20 - Spike Task Quest
- Spike Fame Points (máximo)

### U10_50 - Oramond Quest
- To Take Roots, The Ancient Sewers

### U10_90 - Ferumbras Ascension
- 8 cristais + All Crystals + Ferumbras Essence

### U11_40 - Cults of Tibia
- 13 acessos diferentes para cultos

### U11_80 - The Secret Library
- Small Islands Turtle

## Como Usar

### Para Todos os Jogadores
1. Use `/questmaster help` para ver todos os comandos
2. Use `/questcategory help` para ver comandos de categoria
3. Use `/questmaster unlock` para liberar todas as quests para você mesmo
4. Use `/questmaster complete` para completar todas as quests para você mesmo
5. Use `/questmaster status` para ver o status atual das suas quests

### Para Ajudar Outros Jogadores
1. Use `/questmaster unlock target <nome>` para liberar quests para outro jogador
2. Use `/questmaster complete target <nome>` para completar quests para outro jogador
3. Use `/questmaster status target <nome>` para ver o status das quests de outro jogador

### Para Trabalhar com Categorias Específicas
1. Use `/questcategory <categoria> unlock` para liberar quests de uma categoria
2. Use `/questcategory <categoria> complete` para completar quests de uma categoria
3. Use `/questcategory target <nome> <categoria> <acao>` para aplicar em outro jogador

## Exemplos de Uso

```
/questmaster unlock                    # Libera todas as quests para você
/questmaster complete target Joao     # Completa todas as quests para o jogador "Joao"
/questmaster status target Maria      # Mostra o status das quests da "Maria"
/questmaster reset                    # Reseta todas as suas quests

/questcategory outfits unlock         # Libera todas as quests de outfits
/questcategory arena complete         # Completa todas as quests de arena
/questcategory target Pedro emperor unlock  # Libera quests do imperador para Pedro
```

## Permissões
- **Todos os jogadores** podem usar estes comandos
- Não é necessário ser administrador
- Sistema funciona para qualquer jogador online

## Notas Importantes
- O sistema atualiza automaticamente o questlog após cada operação
- Todas as operações são aplicadas instantaneamente
- O sistema inclui as principais quests de todas as versões do servidor
- Algumas quests podem ter valores específicos para serem consideradas completas
- O sistema de categorias permite trabalhar com grupos específicos de quests

## Arquivos do Sistema
- `quest_master.lua` - Sistema principal para todas as quests
- `quest_categories.lua` - Sistema de categorias para quests específicas
- `README_QUEST_MASTER.md` - Este arquivo de documentação

## Suporte
Se encontrar algum problema ou quiser adicionar mais quests ao sistema:
1. Edite o arquivo `quest_master.lua` para adicionar novas storages na lista de `questStorages`
2. Edite o arquivo `quest_categories.lua` para adicionar novas categorias
3. Atualize este README com as novas informações
