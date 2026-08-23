## Purpose

Glossário e lista de abreviaturas construídos inline durante a escrita (src/gloss.typ).

## Requirements

### Requirement: Abreviatura inline

Na primeira ocorrência, `abbrev` SHALL registrar a sigla e exibir "longo (SIGLA)"; nas ocorrências seguintes, apenas "SIGLA" em maiúsculas. O `long` é obrigatório na primeira uso, sob pena de erro.

#### Scenario: Primeira e segunda ocorrência
- **WHEN** `#abbrev("ifba", long: "Instituto Federal da Bahia")[...]` e depois `#abbrev("ifba")`
- **THEN** a primeira exibe "Instituto Federal da Bahia (IFBA)" e a segunda apenas "IFBA"

### Requirement: Termo de glossário inline

`gloss` SHALL registrar o termo com sua definição na primeira ocorrência e exibir apenas o termo no texto.

#### Scenario: Definição registrada
- **WHEN** `#gloss("docker")[Plataforma de containers.]`
- **THEN** "docker" aparece no texto e a definição fica disponível para o glossário

### Requirement: Lista de abreviaturas

`lista-abreviaturas` SHALL gerar página com título centralizado e as siglas ordenadas alfabeticamente em grade (sigla em maiúsculas | longo); omitida quando não há abreviaturas.

#### Scenario: Sem abreviaturas
- **WHEN** nenhuma `abbrev` foi usada
- **THEN** nada é renderizado

### Requirement: Glossário

`glossario` SHALL gerar seção "Glossário" (heading nível 1, sem numeração, incluída no sumário/outline) com termos ordenados alfabeticamente e suas definições.

#### Scenario: Uso típico
- **WHEN** `#glossario()` após as referências
- **THEN** a seção aparece no sumário com os termos em ordem alfabética
