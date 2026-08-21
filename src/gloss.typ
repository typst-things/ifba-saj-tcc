// gloss.typ — Ponte de integração com o glossarium (termos, siglas e símbolos).

#import "@preview/glossarium:0.5.10": (
  make-glossary,
  register-glossary,
  print-glossary,
)

// Deve ser aplicado como show-rule no template (obrigatório antes de usar @key).
#let setup-glossary() = {
  show: make-glossary
}

// Registra as entradas (termos/siglas/símbolos) vindas de glossary.typ.
#let register(entries) = {
  register-glossary(entries)
}

// Cabeçalho das listas do glossarium.
#let _cabecalho(titulo) = {
  pagebreak(weak: true)
  align(center, text(size: 14pt, weight: "bold")[#upper(titulo)])
  v(1em)
}

// Glossário pós-textual (apenas termos sem grupo).
#let glossario(entries, title: "Glossário") = {
  _cabecalho(title)
  set par(first-line-indent: 0pt)
  print-glossary(
    entries,
    groups: ("",),
    disable-back-references: true,
    user-print-group-heading: (g, level: none) => [],
    user-print-back-references: (e, ..args) => [],
  )
}

// Lista de abreviaturas/siglas (pré-textual) filtrada por grupo.
#let lista-abreviaturas(entries, title: "Lista de abreviaturas e siglas") = {
  _cabecalho(title)
  set par(first-line-indent: 0pt)
  print-glossary(
    entries,
    groups: ("abbreviation",),
    disable-back-references: true,
    user-print-group-heading: (g, level: none) => [],
    user-print-back-references: (e, ..args) => [],
  )
}

// Lista de símbolos filtrada por grupo.
#let lista-simbolos(entries, title: "Lista de símbolos") = {
  _cabecalho(title)
  set par(first-line-indent: 0pt)
  print-glossary(
    entries,
    groups: ("symbol",),
    disable-back-references: true,
    user-print-group-heading: (g, level: none) => [],
    user-print-back-references: (e, ..args) => [],
  )
}