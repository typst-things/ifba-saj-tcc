## Purpose

Apêndices e anexos com numeração alfabética própria (src/annexes.typ).

## Requirements

### Requirement: Apêndice

`apendice` SHALL marcar o início da seção de apêndices: reinicia o contador de headings e faz os títulos de nível 1 subsequentes serem exibidos como "Apêndice A – Título" (centrados, com continuação B, C, ...), refletindo também no cabeçalho corrente e no sumário.

#### Scenario: Dois apêndices
- **WHEN** `#apendice` é seguido de dois títulos de nível 1
- **THEN** eles são exibidos como "Apêndice A – ..." e "Apêndice B – ..."

### Requirement: Anexo

`anexo` SHALL funcionar como `apendice`, mas com rótulo "Anexo A – Título", mantendo sequência alfabética independente.

#### Scenario: Após apêndices
- **WHEN** `#anexo` é usado depois de apêndices
- **THEN** os títulos subsequentes usam "Anexo A – ..." com contadores reiniciados

### Requirement: Subseções de apêndice/anexo

Dentro de apêndices/anexos, subtítulos de níveis 2 e 3 SHALL ser numerados localmente (ex.: "1 Título") sem herdar a numeração dos capítulos, e as entradas de níveis 2-3 são omitidas do sumário.

#### Scenario: Subseção interna
- **WHEN** um apêndice contém heading de nível 2
- **THEN** ele é exibido como "1 Título" e não aparece no sumário
