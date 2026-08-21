// lib.typ — ifba-saj-tcc
// Modelo ABNT para TCC do IFBA, campus Santo Antônio de Jesus (ADS).
// Reexporta a API pública do pacote.

#import "src/layout.typ": default-theme, apply-layout
#import "src/pre-textual.typ": template, resumo, abstract, dedicatoria, agradecimentos, epigrafe
#import "src/pre-textual.typ": lista-figuras, lista-tabelas, lista-quadros, lista-codigos, lista-algoritmos, sumario
#import "src/elements.typ": figura, quadro, tabela, fonte, myself
#import "src/bibliography.typ": citacao-curta, citacao-longa, cite-prose, cite-parent, set-abnt-bibliography, citar
#import "src/code-algo.typ": codigo, algoritmo-passos, figura-algoritmo, init-codly
#import "src/charts.typ": pie-chart, bar-chart
#import "src/diagrams.typ": diagram, fluxograma
#import "src/gloss.typ": setup-glossary, register as gloss-register, glossario, lista-abreviaturas, lista-simbolos
#import "src/annexes.typ": apendice, anexo
#import "src/editor-tools.typ": todo, nota-revision, rascunho, equacao, nota-de-rodape

// Reexportações públicas.
#let theme = default-theme

// Publica todos os nomes acima para import com `: *`.
#let _all = ()
