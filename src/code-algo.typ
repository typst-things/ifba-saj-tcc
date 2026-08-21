// code-algo.typ — Exibição de código-fonte (codly) e algoritmos estruturados.

#import "config.typ": get-config
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#let _render-source(src) = {
  let _self() = context {
    let cfg = get-config()
    let ano = if cfg.year == none { "ano" } else { cfg.year }
    [_Elaborado pelo próprio autor (#ano)._]
  }
  if src == none {
    _self()
  } else if src == auto {
    _self()
  } else {
    [Fonte#(" – ")#src]
  }
}

// Inicializa o codly (deve rodar uma única vez via show no template).
#let init-codly() = {
  show: codly-init.with()
  codly(languages: codly-languages)
}

// 💻 Código-fonte — lê arquivo externo via read() e estiliza com codly.
#let codigo(
  lang: none,
  caption: none,
  source: auto,
  body,
) = {
  let content = if lang == none {
    raw(body)
  } else {
    raw(body, lang: lang)
  }
  figure(
    {
      content
      _render-source(source)
    },
    caption: caption,
    numbering: "1",
    kind: "code",
    supplement: [Código],
  )
}

// ⚙️ Algoritmo — blocos numerados estilo pseudocódigo.
#let algoritmo-passos(..lines) = {
  block(width: 100%, breakable: false, {
    set text(size: 12pt)
    set par(leading: 0.7em, first-line-indent: 0pt, justify: false)
    line(length: 100%, stroke: 0.8pt)
    v(3pt)
    let ls = lines.pos()
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.8em,
      row-gutter: 0.35em,
      align: (right, left),
      ..ls.enumerate().map(((i, l)) => (text(size: 10pt)[#(i + 1):], l)).flatten(),
    )
    v(3pt)
    line(length: 100%, stroke: 0.8pt)
  })
}

#let figura-algoritmo(
  body,
  caption: none,
  source: auto,
) = {
  figure(
    {
      body
      _render-source(source)
    },
    caption: caption,
    numbering: "1",
    kind: "algorithm",
    supplement: [Algoritmo],
  )
}
