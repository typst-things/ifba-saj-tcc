# pre-textuais Delta — refatorar-layout-tema

## ADDED Requirements

### Requirement: Início de elementos no anverso no modo impressão

Quando `print: true`, cada elemento pré-textual SHALL iniciar no anverso (página física ímpar): capa, folha de rosto, errata, folha de aprovação, dedicatória, agradecimentos, epígrafe, resumo, abstract, cada lista e o sumário. A ficha catalográfica, quando presente, SHALL ocupar o **verso da folha de rosto**, sem quebra ímpar entre os dois.

#### Scenario: Folha de rosto em anverso
- **WHEN** `print: true`
- **THEN** a capa ocupa o anverso da primeira folha e a folha de rosto inicia no anverso da folha seguinte (com o verso da capa em branco)

#### Scenario: Ficha no verso da folha de rosto
- **WHEN** `print: true` e `catalog-card` é fornecido
- **THEN** a ficha catalográfica é impressa no verso da folha de rosto

#### Scenario: Dedicatória e epígrafe em anverso
- **WHEN** `print: true` e dedicatória/epígrafe são fornecidas
- **THEN** cada uma inicia no anverso, em folha própria

#### Scenario: Modo digital inalterado
- **WHEN** `print: false`
- **THEN** os elementos fluem em páginas consecutivas sem páginas em branco intercaladas

#### Scenario: Abstract em folha própria
- **WHEN** resumo e abstract são fornecidos
- **THEN** cada um ocupa folha própria (o abstract não usa o verso da folha do resumo)
