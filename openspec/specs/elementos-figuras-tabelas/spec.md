## Purpose

Figuras, quadros, tabelas e equações com atribuição de fonte automática (src/elements.typ, src/editor-tools.typ).

## Requirements

### Requirement: Figura

`figura` SHALL envolver o conteúdo em um figure de kind image com numeração contínua "1", supplement "Figura", legenda no topo (separador " – ") e linha "Fonte" abaixo, centralizada em 10pt.

#### Scenario: Fonte automática
- **WHEN** `source: auto` ou omitido
- **THEN** a fonte exibida é "Elaborado pelo próprio autor (ano)" usando o ano do template

#### Scenario: Fonte customizada
- **WHEN** `source: [Dados do IBGE]`
- **THEN** a fonte exibida é "Fonte – Dados do IBGE"

### Requirement: Quadro

`quadro` SHALL renderizar tabela com todas as bordas fechadas (0,5pt), numeração independente de kind "frame", supplement "Quadro", legenda no topo e fonte abaixo.

#### Scenario: Quadro comparativo
- **WHEN** células são passadas posicionais
- **THEN** a tabela fecha todas as bordas com numeração própria de quadro

### Requirement: Tabela IBGE/ABNT

`tabela` SHALL renderizar tabela sem linhas verticais, com linhas horizontais no topo, sob o header (se houver) e na base, aceitando `columns`, `align`, `header` e linhas posicionais (incluindo saída de `csv`), numeração de kind table, supplement "Tabela", fonte abaixo.

#### Scenario: Tabela com header e CSV
- **WHEN** `header: ([A],[B])` e `..csv("dados.csv")`
- **THEN** o header é delimitado por linha horizontal e não há bordas laterais

### Requirement: Equação

`equacao` SHALL renderizar equação em bloco numerada "(1)", e `figura-equacao` a envolve em figure com supplement "Equação" para inclusão na lista de equações e referência cruzada.

#### Scenario: Equação referenciada
- **WHEN** a equação recebe label e é usada `@label`
- **THEN** a referência exibe "Equação 1"

### Requirement: Legenda de ilustrações

O template SHALL formatar legendas de figures dos kinds image/frame/code/algorithm em 12pt centralizada quando couber na linha, ou com alinhamento pendente justificado quando exceder a largura.

#### Scenario: Legenda longa
- **WHEN** a legenda excede a largura da página
- **THEN** o texto flui com hanging-indent alinhado após o rótulo
