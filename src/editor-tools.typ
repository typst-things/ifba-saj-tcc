// editor-tools.typ — Notas de editor (draft), equações numeradas e notas de rodapé.

#import "config.typ": get-config

// Renderiza uma nota colorida (visível apenas em modo rascunho).
#let _note(fill, label, body) = {
  context {
    if get-config().at("draft", default: false) {
      block(
        fill: fill,
        inset: 6pt,
        radius: 3pt,
        breakable: false,
        width: 100%,
        [#strong[label]: #body],
      )
    }
  }
}

// 📌 Nota TODO.
#let todo(body) = _note(rgb("#FFF3CD"), "TODO", body)

// 📌 Nota de revisão.
#let nota-revision(body) = _note(rgb("#F8D7DA"), "Revisão", body)

// 📌 Nota de rascunho.
#let rascunho(body) = _note(rgb("#D1ECF1"), "Rascunho", body)

// 🔤 Equação numerada (centralizada, número entre parênteses à direita).
#let equacao(body) = {
  math.equation(block: true, numbering: "(1)", body)
}

// 📌 Nota de rodapé (10pt, espaçamento simples) — usa o nativo.
#let nota-de-rodape(body) = footnote[#body]
