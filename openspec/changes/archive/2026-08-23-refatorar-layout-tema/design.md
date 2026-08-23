# Design: refatorar-layout-tema

## Context

Hoje o estilo do documento está duplicado: `src/pre-textual.typ` aplica estilos próprios inline (valores reais, com infrações ABNT) e `src/layout.typ` exporta um tema nunca aplicado (valores diferentes, parte também fora da norma). Ver proposta para a tabela completa de conflitos. A regra de ouro do projeto — sempre vale a ABNT — é o árbitro de todos os valores abaixo.

## Goals / Non-Goals

**Goals**
- `layout.typ` como ponto único de estilo; `pre-textual.typ` responsável apenas pela estrutura pré/pós-textual.
- Conformidade NBR 14724 no comportamento real: entrelinha 1,5 no corpo, verso espelhado em `print: true`.
- Impedir por construção documentos fora da norma: valores normativos como constantes internas.

**Non-Goals**
- Não adicionar novas opções de customização além das já existentes.
- Não mudar a estrutura/ordem dos elementos pré-textuais nem a lógica de apêndices/anexos.
- Não corrigir o texto de aprovação do exemplo (herança USP) nem remover outros códigos mortos — escopo de outra mudança.
- Não tornar a refatoração visualmente nula: as mudanças visuais são o objetivo (correção de infração).

## Decisions

### D1 — Árbitro de valores: a norma, não o código existente

Para cada conflito layout.typ × pre-textual.typ, o valor correto é o da NBR 14724/6024, não "o que já está testado":

| Aspecto | Valor novo | Origem |
|---|---|---|
| Corpo | 12pt | NBR 14724 |
| Entrelinha corpo | 1,5 | NBR 14724 (antes 1.1em — infração) |
| Fonte | New Computer Modern (serif neutra) | ABNT neutra; mantém o atual |
| Nº de página | canto superior direito | NBR 14724 (mantém o atual) |
| Heading 1 | 12pt negrito | NBR 6024 (mantém o atual) |
| Recuo 1ª linha | 1,25cm, all: true | mantém o atual |
| Citação longa/notas | 10pt, espaçamento simples | NBR 10520 (bibliography.typ já faz; a regra genérica morta não volta) |
| Margens anverso | esq 3, sup 3, dir 2, inf 2 cm | mantém |
| Margens verso (print) | **espelhadas**: dir 3 (lombada), esq 2, sup 3, inf 2 | NBR 14724 — **novo** |

Alternativa considerada: "pre-textual vence porque é o comportamento aprovado" — rejeitada; consolidaria infrações.

### D2 — Severidade: constantes internas, não validação

Valores fixados pela norma (`size`, `line-height`, margens, recuo, tamanhos de citação/nota) viram constantes privadas (`_abnt`) em `layout.typ` e **não aparecem no tema público**. O tema público fica restrito a `serif` e `link-color`.

Alternativa considerada: expor os campos e validar em runtime com erro explicativo — rejeitada; oferecer campo que só aceita um valor é API enganosa, e `panic` em template é experiência ruim. Impossibilitar por construção é mais simples e à prova de bala.

### D3 — Migração do cabeçalho e `_chapter-mark`

A página com cabeçalho corrente (`set page` + `_chapter-mark` + grid capítulo/número) e os três `show heading` migram de `pre-textual.typ` para `layout.typ`. O state `_backmatter` (usado por `_chapter-mark`, `apendice`/`anexo` e pelo sumário) passa a ser **definido em `layout.typ`** e importado por `pre-textual.typ` e `annexes.typ` — invertendo a dependência atual (`annexes.typ → pre-textual.typ`), que hoje força o arquivo estrutural a expor detalhe interno.

### D4 — Espelhamento de verso via `inside`/`outside`

Typst suporta `margin(outside: 3cm, inside: 2cm, ...)` com `page(binding: left)`. Em vez de alternar margens manualmente, a página é configurada com `inside/outside` — o Typst espelha automaticamente nas páginas pares. `print: true` ativa o binding; `print: false` usa esquerda/direita fixas (3cm sempre à esquerda).

### D5 — API do layout reabsorve as funções mortas

`set-abnt-page/text/numbering/links` e `apply-layout` são substituídos por uma API interna coesa (`_abnt-page`, `_abnt-body`, `_abnt-headings`, `_abnt-header` — nomes com `_`, privados). O export público `theme` sobrevive com apenas `serif` e `link-color`. O import morto de glossarium é removido.

### D6 — Ordem de set/show preservada

As regras extraídas são chamadas no mesmo ponto do fluxo do template em que os blocos inline estavam, garantindo que a refatoração estrutural (sem as correções D1/D4) seja visualmente nula — isolando o efeito visual nas correções de conformidade, verificáveis por comparação antes/depois.

### D7 — Quebras de página do modo impressão: um ponto de quebra por elemento

Verificação do baseline `example/main_print.pdf` (65 pp., 31 em branco) confirmou três defeitos: (a) folha de rosto, dedicatória e epígrafe caem no **verso** (`pagebreak()` simples após capa/dedicatória/epígrafe — elementos sem heading nunca recebem quebra ímpar); (b) **brancos duplos/triplos**: `_blank-if-even()` no fim de cada lista + `show heading.where(level:1)` que também faz `pagebreak(to: "odd")` — quebras consecutivas para ímpar não colapsam no Typst (a segunda, já em página ímpar vazia, avança mais duas); (c) ficha catalográfica no anverso seguinte em vez do verso da folha de rosto (consequência de (a)).

Correção: **um único ponto de quebra por elemento**, via função interna `_fim-de-folha()` (`pagebreak(to: "odd")` quando `print`, `pagebreak(weak: true)` caso contrário), chamada no fim de CADA elemento pré-textual. O `show heading` de nível 1 deixa de quebrar para ímpar nos headings não numerados (pré-textuais usam `numbering: none`) e mantém a quebra ímpar apenas para seções primárias numeradas (capítulos) e pós-textuais — que já estão corretas no baseline. `_blank-if-even` é removida. Sem quebra ímpar entre folha de rosto e ficha: com a folha de rosto em anverso, a ficha cai naturalmente no verso dela (posição correta da NBR 14724).

Resultado esperado: cada elemento em anverso com **no máximo um** verso em branco intencional antes do próximo; primeira página do texto numerada ~20 em vez de 48; sem mudança de comportamento no modo digital.

**Decisões registradas (confirmadas pelo mantenedor, 2026-08-23):**
- **Número de página NA folha de abertura dos capítulos**: exibir — apenas o número, alinhado à direita, sem o título do capítulo nem a linha do cabeçalho (comportamento atual do classic-ppgsi, mantido). A spec de baseline `layout-abnt` registrou "ocultar" por engano; o delta corrige.
- **Abstract em folha própria**: manter (não usar o verso do resumo, prática USP).

## Risks / Trade-offs

- **Cabeçalho corrente/sumário**: maior risco da migração (query de headings + state). Mitigação: compilar o exemplo antes/depois e comparar página a página; baselines commitados em `example/*.pdf`.
- **Quebra de API silenciosa**: quem personalizou `theme` compila mas perde customização. Mitigação: bump de versão menor e nota no changelog.
- **1,5 aumenta o volume de páginas** dos TCCs existentes — consequência esperada da conformidade, comunicar no changelog.

## Migration Plan

1. Congelar baseline: recompilar example nas duas variantes.
2. Mover estilos para layout.typ sem mudar valores (D3/D5/D6) — diff visual deve ser nulo.
3. Aplicar correções D1/D4 (entrelinha, verso) — diff visual deve ser exatamente essas duas mudanças.
4. Reduzir o tema público (D2) e reescrever as specs.
