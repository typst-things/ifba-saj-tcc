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

// Inicializa o codly como TRANSFORMADOR (recebe body): regras `show:`
// só propagam quando aplicados diretamente via `show:` no template.
// A regra genérica do codly (show raw.where(block: true)) NÃO alcança
// raw dentro de figure — por isso reinjetamos codly() no escopo das
// figures de código. O container do codly é de largura total (grid
// width:100% no pacote); legenda e fonte da figura ficam centradas.
// Estilo: código à esquerda, mono (padrão de raw), numeração de linha
// ativa (padrão do codly) e entrelinha reduzida para legibilidade.
#let init-codly(body, enabled: true) = {
  if not enabled { return body }
  show: codly-init.with()
  codly(languages: codly-languages)
  codly(display-icon: false)
  codly(display-name: false)
  
  //codly-init já configura show rule para figure.where(kind: raw)
  //apenas ajustamos alinhamento e espaçamento
  show figure.where(kind: raw): set align(center)
  show raw.line: set align(left)
  show raw.where(block: true): set par(leading: 0.55em, first-line-indent: 0pt, justify: false)
  body
}

// 💻 Código-fonte — lê arquivo externo via read() e estiliza com codly.
// Bloco shrink-to-fit (width: auto): init-codly() centra a figura e mantém
// as linhas à esquerda dentro do bloco.
// Usa kind: raw (símbolo) para compatibilidade com codly.
#let codigo(
  lang: none,
  caption: none,
  source: auto,
  filename: none,
  body,
) = {
  let content = if lang == none {
    raw(body, block: true)
  } else {
    if filename != none{
      codly(header: [#filename])
    }
    raw(body, lang: lang, block: true)
  }
  figure(
    {
      block(width: auto, content)
      _render-source(source)
    },
    caption: caption,
    numbering: "1",
    kind: raw,
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
