## Purpose

Exibição de código-fonte e algoritmos estruturados (src/code-algo.typ).

## Requirements

### Requirement: Código-fonte

`codigo` SHALL renderizar código como raw (com `lang` opcional para realce), alinhado à esquerda, em figure de kind "code", supplement "Código", legenda no topo e linha de fonte abaixo (padrão: elaborado pelo próprio autor).

#### Scenario: Código de arquivo externo
- **WHEN** `codigo(lang: "javascript", caption: [...], read("server.js"))`
- **THEN** o código aparece realceado com numeração própria de código e fonte automática

### Requirement: Algoritmo em passos

`algoritmo-passos` SHALL renderizar lista numerada de passos entre duas linhas horizontais (0,8pt), em grade de duas colunas com numeração "N:" alinhada à direita.

#### Scenario: Três passos
- **WHEN** passadas três linhas posicionais
- **THEN** o bloco exibe "1:", "2:", "3:" à esquerda dos passos correspondentes

### Requirement: Algoritmo como figura

`figura-algoritmo` SHALL envolver um algoritmo em figure de kind "algorithm", supplement "Algoritmo", legenda no topo, fonte abaixo — habilitando referência cruzada e lista de algoritmos.

#### Scenario: Referência cruzada
- **WHEN** a figura tem label e é usada `@label`
- **THEN** a referência exibe "Algoritmo 1"

### Requirement: Realce via codly

O template SHALL inicializar codly + codly-languages uma única vez quando `codly-habilitado: true`.

#### Scenario: Codly desabilitado
- **WHEN** `codly-habilitado: false`
- **THEN** o código é renderizado como raw simples sem inicialização do codly
