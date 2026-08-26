## 1. Simplificar abbrev

- [x] 1.1 Remover `body` de `src/gloss.typ:abbrev` (assinatura e storage) e verificar `lista-abreviaturas` ainda funciona
- [x] 1.2 Atualizar `example/main.typ` para `#abbrev("ifba", long: "...")` sem `[]` e verificar `typst compile` OK
- [x] 1.3 Atualizar `README.md` exemplos de abreviatura e verificar sem `[]`

## 2. Validação

- [x] 2.1 Validar `openspec validate --strict` e `typst compile example/main.typ`
