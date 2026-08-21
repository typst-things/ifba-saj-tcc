// bibliography.typ — Citações e referências no estilo autor-data ABNT.

#let citation-style = "chicago-author-date"

// Configura o motor de citações e referências.
#let set-abnt-bibliography(bib: none, title: "REFERÊNCIAS") = {
  set bibliography(
    title: title,
    style: citation-style,
    full: true,
  )
  if bib != none {
    bibliography(bib)
  }
}

// Citação indireta narrativa: "Segundo Silva (2020)".
#let cite-prose(key) = {
  cite(label(key), form: "prose")
}

// Citação indireta parentética: "(SILVA, 2020)".
#let cite-parent(key) = {
  cite(label(key))
}

// Citação direta curta (inline, entre aspas duplas).
#let citacao-curta(body) = {
  quote(block: false)[#body]
}

// Citação direta longa (recuo de 4cm, sem aspas, tamanho 10pt, espaçamento simples).
#let citacao-longa(body, autor: none, ano: none, pagina: none) = {
  quote(
    block: true,
    attribution: if autor == none {
      none
    } else if pagina == none {
      [\(#autor, #ano\)]
    } else {
      [\(#autor, #ano, p. #pagina\)]
    },
  )[#body]
}

// Referência cruzada amigável com prefixo traduzido (ex.: "Figura 1").
// O prefixo é resolvido automaticamente pelo Typst com base no suplemento do elemento.
#let citar(chave) = ref(label(chave))