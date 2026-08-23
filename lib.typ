// lib.typ — ifba-saj-tcc
// Modelo ABNT para TCC do IFBA, campus Santo Antônio de Jesus (ADS).
// Reexporta a API pública do pacote.

#import "src/layout.typ": default-theme, apply-layout
#import "src/pre-textual.typ": template
#import "src/elements.typ": figura, quadro, tabela, fonte, myself
#import "src/bibliography.typ": cite, prose, references, register-bib, citacao-curta, citacao-longa
#import "src/code-algo.typ": codigo, algoritmo-passos, figura-algoritmo
#import "src/diagrams.typ": diagram
#import "src/gloss.typ": abbrev, gloss, lista-abreviaturas, glossario
#import "src/annexes.typ": apendice, anexo
#import "src/editor-tools.typ": equacao, figura-equacao
#import "src/config.typ": get-autor, get-titulo, get-ano, get-orientador, get-curso, get-cidade, get-config

// Reexportações públicas.
#let theme = default-theme

// Publica todos os nomes acima para import com `: *`.
#let _all = ()
