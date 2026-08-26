## Context

Ver proposal.md. `definition` nunca lido.

## Goals / Non-Goals

**Goals:** API enxuta `abbrev(key, long: none)`.
**Non-Goals:** Mudar `gloss` ou `lista-abreviaturas`.

## Decisions

- Remover `body` em vez de usá-lo: menos ruído; `body` não tem uso ABNT definido. Alternativa usar `body` na lista descartada.
- Manter `long` named param.

## Risks / Trade-offs

- Breaking para quem usa `[]` — busca/replace simples.

## Migration Plan

- Editar `src/gloss.typ`, `example/main.typ`, `README.md`.

## Open Questions

- Nenhuma.
