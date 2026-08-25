## Why

A ABNT NBR 14724 exige caixa-alta em elementos de capa/folha de rosto e títulos pré-textuais, mas o código aplica `upper()` apenas parcialmente (autor e `_pre-titulo`). Além disso o preâmbulo da folha de rosto deveria ser montado dinamicamente a partir dos dados do template.

## What Changes

- Aplicar `upper()` **apenas na renderização** (não no storage) para todos os campos que a ABNT define como caixa-alta: `titulo`, `autor`, `instituicao`, `local`, `ano`, `orientador`/`co-orientador` e títulos de seções pré-textuais; getters (`get-autor`, etc.) continuam retornando valor original.
- Tornar o preâmbulo (`_preamb`) parametrizado via junção de `get-curso`/`get-instituicao`/`get-cidade` (ou diretamente `curso`/`instituicao`/`local`), gerando: "Trabalho de Conclusão de Curso apresentado ao Instituto Federal de Educação, Ciência e Tecnologia da Bahia, campus Santo Antônio de Jesus, como requisito parcial para obtenção do grau de Tecnólogo em Análise e Desenvolvimento de Sistemas." — sem param `descricao` manual.

## Capabilities

### New Capabilities
<!-- nenhuma -->

### Modified Capabilities
- `pre-textuais`: regra de caixa-alta na renderização e preâmbulo parametrizado.
- `layout-abnt`: garantir que headings/títulos sigam caixa-alta ABNT onde aplicável (se necessário).

## Impact

- `src/pre-textual.typ` (renderização com `upper()` e montagem do preâmbulo), `src/config.typ`/`src/layout.typ` se necessário, `example/main.typ` e `README.md` (documentação).
