## Purpose

Motor próprio de citações e referências ABNT (NBR 10520:2023 e NBR 6023), com parser BibTeX embutido (src/bibliography.typ).

## Requirements

### Requirement: Registro da bibliografia

`register-bib` SHALL receber o conteúdo BibTeX via `read()`, registrar no estado do documento e reconhecer `@chave` no texto como citação (alias para `cite`) quando a chave existir no .bib, preservando o ref nativo caso contrário.

#### Scenario: Ref para entrada existente
- **WHEN** o autor escreve `@martin2008` e a chave existe no .bib
- **THEN** o texto renderiza a citação parentética correspondente

### Requirement: Citação parentética

`cite` SHALL formatar citações indiretas no formato (AUTOR, ano), suportando múltiplas chaves na mesma chamada e `supplement` (ex.: p. 42).

#### Scenario: Múltiplas fontes
- **WHEN** `cite("a2008", "b2011")`
- **THEN** o formato é (AUTOR A, 2008; AUTOR B, 2011)

### Requirement: Citação narrativa

`prose` SHALL inserir o(s) autor(es) no fluxo do texto (ex.: "Como afirma Martin (2008)").

#### Scenario: Autor no fluxo do texto
- **WHEN** `#prose("martin2008")` inicia a oração
- **THEN** o sobrenome do autor aparece no texto com ano entre parênteses

### Requirement: Citação direta curta

`citacao-curta` SHALL envolver trecho de até 3 linhas entre aspas, combinado com `cite` (com supplement de página).

#### Scenario: Trecho curto
- **WHEN** usado com `supplement: [p. 42]`
- **THEN** o trecho aparece entre aspas seguido de (MARTIN, 2008, p. 42)

### Requirement: Citação direta longa

`citacao-longa` SHALL formatar trecho com mais de 3 linhas em bloco recuado 4cm, fonte menor, espaçamento simples, com autor/ano/página informados.

#### Scenario: Bloco longo
- **WHEN** `citacao-longa(autor: "Martin", ano: "2009", pagina: "42")[...]`
- **THEN** o bloco é recuado com terminação (MARTIN, 2009, p. 42)

### Requirement: Lista de referências

`references` SHALL gerar a seção "REFERÊRCIAS"/"REFERÊNCIAS" (título configurável) a partir das entradas efetivamente citadas, formatadas conforme NBR 6023, em espaçamento simples e alinhamento pendente.

#### Scenario: Apenas citadas
- **WHEN** o .bib contém entradas não citadas
- **THEN** apenas as entradas citadas aparecem na lista

### Requirement: Parser BibTeX

O motor SHALL interpretar internamente o subconjunto BibTeX (entradas @tipo{chave, campo = {valor}|"valor"|token}) sem dependência do bibliography nativo, ignorando linhas de comentário `%`.

#### Scenario: Campos aninhados
- **WHEN** um campo contém chaves aninhadas `{...{...}...}`
- **THEN** o parser extrai o valor completo corretamente
