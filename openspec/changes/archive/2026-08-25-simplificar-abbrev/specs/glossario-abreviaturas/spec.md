## MODIFIED Requirements

### Requirement: Abreviatura inline

Na primeira ocorrência, `abbrev` SHALL registrar a sigla e exibir "longo (SIGLA)"; nas ocorrências seguintes, apenas "SIGLA" em maiúsculas. O `long` é obrigatório no primeiro uso, sob pena de erro. A API SHALL ser `abbrev(key, long: none)` sem parâmetro posicional `body`.

#### Scenario: Primeira e segunda ocorrência
- **WHEN** `#abbrev("ifba", long: "Instituto Federal da Bahia")` e depois `#abbrev("ifba")`
- **THEN** a primeira exibe "Instituto Federal da Bahia (IFBA)" e a segunda apenas "IFBA"
