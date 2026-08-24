// pre-textual.typ — classic-ppgsi order, ABNT header, capa/folha correct
#import "layout.typ": default-theme, _abnt-page, _abnt-body, _abnt-headings, _backmatter, _cm-dash, _fim-de-folha, _text-color
#import "config.typ": get-config, set-config
#import "gloss.typ": glossario, lista-abreviaturas
#import "bibliography.typ": cite, references, register-bib
#import "code-algo.typ": init-codly
#import "@preview/codly-languages:0.1.1": codly-languages
#let _pre-titulo(nome) = heading(level: 1, numbering: none, outlined: false, bookmarked: true, upper(nome))
#let _logo() = {
  rect(width: 2.7cm, height: 2.7cm, stroke: (paint: luma(45%), thickness: 1pt, dash: "dashed"), radius: 4pt, align(
    center + horizon,
    stack(dir: ttb, spacing: 4pt, text(fill: luma(45%), weight: "bold", size: 10pt)[LOGOTIPO], text(
      fill: luma(45%),
      weight: "bold",
      size: 14pt,
    )[IFBA]),
  ))
}
#let _capa(logo, instituicao, autor, titulo, local, data) = {
  set align(center)
  set par(leading: 1.1em, first-line-indent: 0pt, justify: false)
  set text(size: 12pt)
  if logo != none { if type(logo) == str { image(logo, width: 2.7cm) } else { logo } }
  v(0.3cm)
  instituicao
  v(4cm)
  autor
  v(5cm)
  text(weight: "bold", titulo)
  v(1fr)
  local
  parbreak()
  data
  v(1cm)
}
#let _single(body) = {
  set par(leading: 0.65em, spacing: 0.65em)
  body
}
#let _folha-de-rosto(autor, titulo, preambulo, orientador, coorientador, local, data) = {
  set align(center)
  set par(leading: 1.1em, first-line-indent: 0pt, justify: false)
  set text(size: 12pt)
  autor
  v(1fr)
  v(1fr)
  text(weight: "bold", titulo)
  v(1fr)
  align(left, pad(left: 50%, _single({
    set par(justify: true, leading: 0.65em, spacing: 1.3em)
    preambulo
    v(2em)
    [#orientador]
    if coorientador != none {
      v(0.5em)
      [#coorientador]
    }
  })))
  v(1fr)
  local
  parbreak()
  data
  v(1cm)
}
#let _ficha(ficha) = {
  if ficha == none { return }
  page(margin: 0cm, header: none, footer: none, {
    if type(ficha) == str { image(ficha, width: 100%, height: 100%, fit: "contain") } else { ficha }
  })
}
#let template(
  titulo: none,
  autor: none,
  orientador: none,
  co-orientador: none,
  instituicao: [INSTITUTO FEDERAL DA BAHIA],
  curso: [Análise e Desenvolvimento de Sistemas],
  local: "Santo Antônio de Jesus",
  ano: none,
  descricao: none,
  logo: none,
  catalog-card: none,
  errata: none,
  approval-text: none,
  committee: (),
  dedication: none,
  acknowledgments: none,
  epigraph: none,
  resumo-conteudo: none,
  resumo-palavras: (),
  abstract-conteudo: none,
  abstract-palavras: (),
  print: false,
  codly-habilitado: false,
  bibliografia: none,
  referencias-titulo: "REFERÊNCIAS",
  cor-links: _text-color,
  body,
) = {
  set-config(
    year: ano,
    author: autor,
    titulo: titulo,
    orientador: orientador,
    curso: curso,
    cidade: local,
    print: print,
  )
  let _logo-val = if logo == none { _logo() } else if type(logo) == str { image(logo, width: 2.7cm) } else { logo }
  let _author-upper = if autor == none { none } else { upper(str(autor)) }
  let _preamb = if descricao == none {
    [Trabalho de Conclusão de Curso apresentado ao curso de #text(style: "italic")[Análise e Desenvolvimento de Sistemas] do Instituto Federal da Bahia, campus Santo Antônio de Jesus.]
  } else { descricao }
  // global styles (ponto único de estilo: layout.typ)
  show: _abnt-page.with(print: print)
  show: _abnt-body
  show: _abnt-headings
  show: init-codly.with(enabled: codly-habilitado)
  show heading: set block(above: 1.5em, below: 1.5em)
  if bibliografia != none { register-bib(bibliografia) }
  // alias @key → #cite("key") para motor custom (mantém @ nativo)
  show ref: it => {
    let k = str(it.target)
    context {
      let entries = {
        let src = state("ifba-bibsrc", "").get()
        let _strip(s) = s.split("\n").filter(l => not l.trim().starts-with("%")).join("\n")
        let has = _strip(src).contains(k)
        has
      }
      if entries { cite(k) } else { it }
    }
  }
  // PRE-TEXTUAIS em ordem classic-ppgsi
  _capa(_logo-val, instituicao, _author-upper, titulo, local, ano)
  _fim-de-folha()
  // A contagem recomeça após a capa: a folha de rosto é a folha 1.
  counter(page).update(1)
  _folha-de-rosto(_author-upper, titulo, _preamb, orientador, co-orientador, local, ano)
  if catalog-card != none {
    // Ficha catalográfica no verso da folha de rosto (NBR 14724).
    pagebreak()
    _ficha(catalog-card)
  }
  if errata != none {
    heading(level: 1, numbering: none, outlined: false, bookmarked: true, upper("Errata"))
    errata
    _fim-de-folha()
  }
  if approval-text != none {
    heading(level: 1, numbering: none, outlined: false, bookmarked: true, hide[ Folha de aprovação])
    if type(approval-text) == str {
      page(margin: 0cm, header: none, footer: none, image(approval-text, width: 100%, height: 100%, fit: "contain"))
    } else {
      _single({
        set par(justify: true)
        approval-text
        v(3cm)
        set align(center)
        for member in committee {
          v(1.2cm)
          line(length: 10cm, stroke: 0.5pt)
          member
          parbreak()
        }
      })
    }
    _fim-de-folha()
  }
  if dedication != none {
    v(1fr)
    align(center, emph(dedication))
    v(1fr)
    _fim-de-folha()
  }
  if acknowledgments != none {
    _pre-titulo[AGRADECIMENTOS]
    acknowledgments
    _fim-de-folha()
  }
  if epigraph != none {
    v(1fr)
    align(right, emph(epigraph))
    _fim-de-folha()
  }
  if resumo-conteudo != none {
    _pre-titulo[RESUMO]
    _single({
      set par(first-line-indent: 0pt, spacing: 18pt)
      resumo-conteudo
      if resumo-palavras.len() > 0 {
        parbreak()
        [Palavras-chave: #(resumo-palavras.join(". ")).]
      }
    })
    _fim-de-folha()
  }
  if abstract-conteudo != none {
    _pre-titulo[ABSTRACT]
    _single({
      set par(first-line-indent: 0pt, spacing: 18pt)
      set text(lang: "en")
      abstract-conteudo
      if abstract-palavras.len() > 0 {
        parbreak()
        [Keywords: #(abstract-palavras.join(". ")).]
      }
    })
    _fim-de-folha()
  }
  // Lista pré-textual: renderiza título + outline apenas se houver itens.
  // query() em context enxerga o documento inteiro (forward reference nativa),
  // dispensando qualquer mecanismo de estado manual.
  let _lista(nome, target) = context {
    if query(target).len() > 0 {
      _pre-titulo(nome)
      show outline.entry: it => {
        let dest = it.element.location()
        let tail = if it.fill != none { box(width: 1fr, it.fill) } else { h(1fr) }
        link(dest, it.indented(
          text(fill: _text-color, {
            it.prefix()
            _cm-dash
          }),
          text(fill: _text-color, it.body()) + [ ] + tail + [ ] + it.page(),
        ))
      }
      outline(title: none, target: target)
      _fim-de-folha()
    }
  }
  // Listas pré-textuais automáticas na ordem ABNT:
  // figuras → quadros → tabelas → códigos → algoritmos → equações → abreviaturas → Sumário
  _lista([Lista de figuras], figure.where(kind: image))
  _lista([Lista de quadros], figure.where(kind: "frame"))
  _lista([Lista de tabelas], figure.where(kind: table))
  _lista([Lista de códigos], figure.where(kind: raw))
  _lista([Lista de algoritmos], figure.where(kind: "algorithm"))
  _lista([Lista de equações], math.equation.where(block: true))
  // lista-abreviaturas guarda internamente com _abbrev-state.final(); não renderiza quando vazia
  lista-abreviaturas()
  _pre-titulo[SUMÁRIO]
  {
    show outline.entry.where(level: 1): it => context block(above: 1em, below: 0pt, {
      let dest = it.element.location()
      let modo = _backmatter.at(dest)
      if modo != none {
        let letra = numbering("A", counter(heading).at(dest).first())
        link(dest, text(fill: _text-color, weight: "bold", it.indented(
          [#if modo == "appendix" { "Apêndice" } else { "Anexo" } #letra#_cm-dash],
          it.inner(),
        )))
      } else {
        let e = it.indented(it.prefix(), it.inner())
        let body = if it.element.body == [Referências] { upper(e) } else { e }
        link(dest, text(fill: _text-color, weight: "bold", body))
      }
    })
    show outline.entry.where(level: 2): it => context if _backmatter.at(it.element.location()) != none { none } else {
      link(it.element.location(), text(fill: _text-color, style: "italic", it.indented(it.prefix(), it.inner())))
    }
    show outline.entry.where(level: 3): it => context if _backmatter.at(it.element.location()) != none { none } else {
      link(it.element.location(), text(fill: _text-color, it.indented(it.prefix(), it.inner())))
    }
    outline(title: none, depth: 3, indent: 1.2em)
    _fim-de-folha()
  }
  body
}
