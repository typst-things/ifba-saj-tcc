# Proposal: refatorar-layout-tema

## Why

A regra de ouro do projeto é que sempre vale o que está na ABNT, mas hoje o estilo real do documento mora hardcoded em `src/pre-textual.typ` e contém infrações da NBR 14724 (entrelinha do corpo em 1.1em em vez de 1,5; margens não espelhadas no verso na impressão frente-e-verso), enquanto `src/layout.typ` — que se apresenta como o coração do layout ABNT — é código morto com valores próprios, parte deles também fora da norma (11pt, heading 14pt, número de página centralizado).

## What Changes

- **BREAKING** Refatorar `src/layout.typ` para se tornar o ponto único de estilo do pacote: o `template` de `pre-textual.typ` passa a consumi-lo em vez de definir estilos próprios.
- **BREAKING** Corrigir infrações ABNT no comportamento real: entrelinha do corpo passa de 1.1em para 1,5 (NBR 14724); margens espelhadas no verso (lombada 3cm à direita) quando `print: true`.
- **BREAKING** Corrigir quebras de página da versão impressa: folha de rosto, dedicatória e epígrafe devem iniciar no anverso (hoje caem no verso por `pagebreak()` simples); eliminar páginas em branco duplas/triplas causadas por quebras para ímpar consecutivas (`_blank-if-even` + `show heading`) que o Typst não colapsa; ficha catalográfica deve cair no verso da folha de rosto (atualmente no anverso seguinte).
- Valores fixados pela norma (corpo 12pt, entrelinha 1,5, margens 3-3-2-2, recuo 1,25cm) tornam-se **constantes internas** em layout.typ — não expostas no tema, impossibilitando documentos fora da ABNT.
- O tema público (`theme`) fica restrito ao que a ABNT é neutra: família serif, cores de link.
- Remoção do import morto de glossarium e das funções `set-abnt-*`/`apply-layout` em sua forma atual (reabsorvidas pela nova API interna).
- Specs `layout-abnt` e `pre-textuais` reescritas para codificar a norma como árbitro.

## Capabilities

### New Capabilities

(nenhuma)

### Modified Capabilities

- `layout-abnt`: requisitos de tipografia e numeração corrigidos para os valores da norma (entrelinha 1,5, página dorsal espelhada); novo requisito de "constantes internas de conformidade" (valores normativos não customizáveis) e de tema restrito; requisito "Modo impressão" fortalecido (exatamente um verso em branco por elemento, sem brancos duplos).
- `pre-textuais`: novo requisito de que cada elemento pré-textual inicia no anverso no modo impressão (folha de rosto, errata, aprovação, dedicatória, agradecimentos, epígrafe, resumo, abstract, listas, sumário), com ficha catalográfica no verso da folha de rosto.

## Impact

- **Quebra de API**: `theme` perde campos normativos (`size`, `heading-size`, `margin-*`, `line-height`, `paragraph-indent`, `quote-size`, `note-size`); `apply-layout`/`default-theme` mudam de forma. Aceitável em v0.1.0.
- **Quebra visual intencional**: documentos existentes mudam (entrelinha 1,5, verso espelhado) — é a correção da infração, alinhada à regra de ouro.
- `_chapter-mark` e a página com cabeçalho migram de `pre-textual.typ` para `layout.typ`: risco concentrado de regressão em cabeçalho corrente e sumário; mitigado por comparação visual dos PDFs do exemplo antes/depois.
- Exemplo (`example/main.typ`) recompilado nas variantes digital e impressão como verificação de regressão.
