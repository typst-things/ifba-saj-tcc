## Context

Ver proposal.md. ABNT NBR 14724 exige caixa-alta em capa/folha; código atual aplica upper só em autor e _pre-titulo. Preâmbulo deve ser parametrizado via junção de campos.

## Goals / Non-Goals

**Goals:** upper apenas na renderização; preâmbulo via `get-curso`/`get-instituicao`/`get-cidade`.
**Non-Goals:** alterar storage/getters para retornar upper; alias inglês.

## Decisions

- Upper em `_capa` e `_folha-de-rosto` com `upper()` no ponto de `text()`/`align()`, não em `set-config`. Alternativa upper no storage descartada por poluir `get-*`.
- Campos upper: `titulo`, `autor`, `instituicao`, `local`, `ano`, `orientador`/`co-orientador`. Textos livres (`dedicatoria`, `resumo`, etc.) sem upper.
- Preâmbulo: construir string a partir de `instituicao`/`curso`/`local` (ou getters) com template fixo solicitado; se campos com default, usa default.

## Risks / Trade-offs

- Upper em conteúdo com `content` (ex: `instituicao: [texto]`) requer `upper(str(...))` vs `upper(content)` — Typst `upper` opera em str; para content, envolver em `upper()` funciona em content textual.
- Risco de esquecer algum ponto de renderização → Mitigação: auditar `_capa` e `_folha-de-rosto`.

## Migration Plan

- Editar `src/pre-textual.typ`; validar `typst compile example/main.typ`.

## Open Questions

- Nenhuma.
