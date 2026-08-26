## Why

`#abbrev` exige `body` (`[]`) mas `src/gloss.typ` armazena como `definition` e nunca usa — `lista-abreviaturas` renderiza só `k` + `v.long`. O `body` é ruído na API e confunde o aluno (ex: `[Instituição federal]` nunca aparece).

## What Changes

- **BREAKING** Remover parâmetro posicional `body` de `abbrev(key, long: none, body)` → `abbrev(key, long: none)`.
- Simplificar storage para `(long: long)` e atualizar `example/main.typ` e `README.md` para `#abbrev("ifba", long: "...")` e usos subsequentes `#abbrev("ifba")`.
- Manter comportamento: 1º uso expande `Long (SIGLA)`, 2º+ só `SIGLA`; `lista-abreviaturas` inalterada.

## Capabilities

### New Capabilities
<!-- nenhuma -->

### Modified Capabilities
- `glossario-abreviaturas`: API de abreviaturas sem `body`.

## Impact

- `src/gloss.typ`, `example/main.typ`, `README.md`, `openspec/specs/glossario-abreviaturas/spec.md`.
