# Tasks: refatorar-layout-tema

## 1. Baseline de regressão

- [x] 1.1 Recompilar `example/main.typ` nas variantes digital e impressão (`print: false|true`) e salvar os PDFs como baseline de comparação

## 2. Migração estrutural (diff visual nulo)

- [x] 2.1 Mover o state `_backmatter` para `src/layout.typ`; atualizar imports de `pre-textual.typ` e `annexes.typ` (dependência invertida)
- [x] 2.2 Extrair de `pre-textual.typ` para `layout.typ` (privados, sem mudar valores): configuração de página com cabeçalho corrente (`_chapter-mark` + grid), `set text/par` do corpo, os três `show heading`, `show figure.caption`, numeração de seções e equações
- [x] 2.3 Substituir no `template` os blocos inline pelas chamadas às novas funções, no mesmo ponto do fluxo
- [x] 2.4 Remover o import morto de glossarium em `layout.typ` e as funções `set-abnt-*`/`apply-layout` reabsorvidas
- [x] 2.5 Compilar o exemplo e confirmar diff visual nulo vs baseline

## 3. Conformidade ABNT (diff visual esperado)

- [x] 3.1 Corrigir entrelinha do corpo de 1.1em para 1,5 (mantendo espaçamento simples em citações longas, notas, legendas, referências e resumo)
- [x] 3.2 Espelhar margens no verso com `print: true` via `margin(inside/outside)` com binding
- [ ] 3.3 Quebras do modo impressão (verificação do baseline: 31/65 páginas em branco; folha de rosto, dedicatória e epígrafe no verso):
  - [x] 3.3.1 Criar `_fim-de-folha()` (quebra ímpar quando print, fraca quando digital) e usá-la no fim de CADA elemento pré-textual, substituindo os `pagebreak()` simples e removendo `_blank-if-even`
  - [x] 3.3.2 Fazer o `show heading` de nível 1 quebrar para ímpar apenas em headings numerados (capítulos/pós-textuais), não nos pré-textuais (`numbering: none`) — elimina a quebra dupla
  - [x] 3.3.3 Garantir ficha no verso da folha de rosto (sem quebra ímpar entre os dois)
  - [x] 3.3.4 Recompilar `print: true` e verificar mapa de páginas: todo elemento em anverso, ≤1 verso em branco por elemento, primeira página do texto numerada ≈20
- [x] 3.4 Compilar as duas variantes e confirmar que o diff visual é exatamente entrelinha + verso espelhado + mapa de quebras corrigido

## 4. Tema restrito

- [x] 4.1 Reduzir `default-theme`/`theme` público a `serif` e `link-color`; valores normativos como constantes internas `_abnt`
- [x] 4.2 Atualizar `lib.typ` (export `theme`, remoção de `#let _all = ()`) sem quebrar os imports do exemplo

## 5. Specs e verificação final

- [x] 5.1 Aplicar o delta da spec `layout-abnt` (entrelinha 1,5, verso espelhado, constantes internas)
- [x] 5.2 Validar `openspec validate` e revisão final dos PDFs das duas variantes
