// pre-textual.typ — classic-ppgsi order, ABNT header, capa/folha correct
#import "layout.typ": apply-layout, default-theme
#import "config.typ": set-config
#import "gloss.typ": lista-abreviaturas, glossario
#import "bibliography.typ": register-bib, references
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#let _cm-dash = " – "
#let _blue = rgb(41,5,195)
#let _backmatter = state("ifba-backmatter", none)
#let _pre-titulo(nome) = heading(level:1, numbering:none, outlined:false, bookmarked:true, upper(nome))
#let _logo() = {
  rect(width:2.7cm, height:2.7cm, stroke:(paint:luma(45%), thickness:1pt, dash:"dashed"), radius:4pt, align(center+horizon, stack(dir:ttb, spacing:4pt, text(fill:luma(45%), weight:"bold", size:10pt)[LOGOTIPO], text(fill:luma(45%), weight:"bold", size:14pt)[IFBA])))
}
#let _capa(logo, instituicao, autor, titulo, local, data) = {
  set align(center); set par(leading:1.1em, first-line-indent:0pt, justify:false); set text(size:12pt)
  if logo != none { if type(logo)==str { image(logo, width:2.7cm) } else { logo } }
  v(0.3cm); instituicao; v(4cm); autor; v(5cm); text(weight:"bold", titulo); v(1fr); local; parbreak(); data; v(1cm)
}
#let _single(body) = { set par(leading:0.65em, spacing:0.65em); body }
#let _folha-de-rosto(autor, titulo, preambulo, orientador, coorientador, local, data) = {
  set align(center); set par(leading:1.1em, first-line-indent:0pt, justify:false); set text(size:12pt)
  autor; v(1fr); v(1fr); text(weight:"bold", titulo); v(1fr)
  align(left, pad(left:50%, _single({ set par(justify:true, leading:0.65em, spacing:1.3em); preambulo; v(2em); [#orientador]; if coorientador!=none { v(0.5em); [#coorientador] } })))
  v(1fr); local; parbreak(); data; v(1cm)
}
#let _ficha(ficha) = { if ficha==none { return }; page(margin:0cm, header:none, footer:none, { if type(ficha)==str { image(ficha, width:100%, height:100%, fit:"contain") } else { ficha } }) }
#let _chapter-mark(loc) = {
  let chaps = query(heading.where(level:1)).filter(h => h.location().page() <= loc.page() and (h.numbering != none or h.outlined==true))
  if chaps.len()==0 { return none }
  let h = chaps.last(); let modo = _backmatter.at(h.location())
  if modo != none { let letra = numbering("A", counter(heading).at(h.location()).first()); [#if modo=="appendix"{"Apêndice"}else{"Anexo"} #letra#_cm-dash#h.body] }
  else if h.numbering != none { let num = numbering("1", ..counter(heading).at(h.location())); [Capítulo #num. #h.body] } else { h.body }
}
#let template(titulo:none, autor:none, orientador:none, co-orientador:none, instituicao:[INSTITUTO FEDERAL DA BAHIA], local:"Santo Antônio de Jesus", ano:none, descricao:none, logo:none, catalog-card:none, errata:none, approval-text:none, committee:(), dedication:none, acknowledgments:none, epigraph:none, resumo-conteudo:none, resumo-palavras:(), abstract-conteudo:none, abstract-palavras:(), incluir-lista-figuras:true, incluir-lista-tabelas:true, incluir-lista-quadros:false, incluir-lista-codigos:false, incluir-lista-algoritmos:false, draft:false, codly-habilitado:false, bibliografia:none, referencias-titulo:"REFERÊNCIAS", cor-links:_blue, body) = {
  set-config(year:ano, author:autor, draft:draft)
  let _logo-val = if logo==none { _logo() } else if type(logo)==str { image(logo, width:2.7cm) } else { logo }
  let _author-upper = if autor==none { none } else { upper(str(autor)) }
  let _preamb = if descricao==none { [Trabalho de Conclusão de Curso apresentado ao curso de #text(style:"italic")[Análise e Desenvolvimento de Sistemas] do Instituto Federal da Bahia, campus Santo Antônio de Jesus.] } else { descricao }
  // global styles
  set page(paper:"a4", margin:(left:3cm, right:2cm, top:3cm, bottom:2cm), header-ascent:1cm, header: context {
    let loc = here(); let pg = loc.page(); let mark = _chapter-mark(loc); if mark==none { return }
    set text(size:10pt); let chap-here = query(heading.where(level:1)).filter(h => h.location().page()==pg)
    if chap-here.len()>0 { align(right, counter(page).display()); return }
    grid(columns:(1fr, auto), align:(left+bottom, right+bottom), mark, counter(page).display()); v(-0.4em); line(length:100%, stroke:0.4pt)
  })
  set text(font:"New Computer Modern", size:12pt, lang:"pt", region:"br", hyphenate:true)
  set par(leading:1.1em, spacing:1.1em, first-line-indent:(amount:1.25cm, all:true), justify:true)
  set heading(numbering: (..nums) => if nums.pos().len()<=3 { numbering("1.1.1", ..nums.pos()) })
  set math.equation(numbering:"(1)")
  set figure(gap:0.6em); set figure.caption(separator:_cm-dash, position:top)
  show figure.caption: it => {
    let _kinds = ("image","frame","code","algorithm")
    let ok = if type(it.kind)==str { it.kind in _kinds } else { it.kind==table }
    if not ok { return it }
    set text(size:12pt); set par(leading:0.6em, first-line-indent:0pt, spacing:0.6em)
    layout(size => context { let number = it.counter.display(it.numbering); let is-alg = it.kind=="algorithm"; let label = if is-alg { strong[#it.supplement #number] } else { [#it.supplement #number#_cm-dash] }; let full = label + it.body; if measure(full).width <= size.width { align(center, full) } else { set par(hanging-indent: measure(label).width, justify:true); full } })
  }
  show heading.where(level:1): it => context {
    pagebreak(weak:true); set text(size:12pt, weight:"bold"); set par(first-line-indent:0pt, justify:false, leading:0.93em)
    let modo = _backmatter.at(it.location())
    block(above:0pt, below:22pt, width:100%, {
      if modo != none { let letra = numbering("A", counter(heading).at(it.location()).first()); align(center, [#if modo=="appendix"{"Apêndice"}else{"Anexo"} #letra#_cm-dash#it.body]) }
      else if it.numbering==none { align(center, it.body) } else { it }
    })
  }
  show heading.where(level:2): it => context { set text(size:12pt, weight:"regular", style:"italic"); set par(first-line-indent:0pt, justify:false, leading:0.93em); let modo=_backmatter.at(it.location()); if modo!=none { let n=numbering("1", counter(heading).at(it.location()).at(1)); block(above:32pt, below:22pt, [#n #it.body]) } else { block(above:32pt, below:22pt, it) } }
  show heading.where(level:3): it => context { set text(size:12pt, weight:"regular", style:"normal"); set par(first-line-indent:0pt, justify:false, leading:0.93em); let modo=_backmatter.at(it.location()); if modo!=none { let nums=counter(heading).at(it.location()); let n=numbering("1.1", nums.at(1), nums.at(2)); block(above:32pt, below:22pt, [#n #it.body]) } else { block(above:32pt, below:22pt, it) } }
  if codly-habilitado { show: codly-init.with(); codly(languages:codly-languages) }
  show heading: set block(above:1.5em, below:1.5em)
  if bibliografia != none { register-bib(bibliografia) }
  // PRE-TEXTUAIS em ordem classic-ppgsi
  _capa(_logo-val, instituicao, _author-upper, titulo, local, ano); counter(page).update(0); pagebreak()
  _folha-de-rosto(_author-upper, titulo, _preamb, orientador, co-orientador, local, ano); pagebreak()
  _ficha(catalog-card)
  if errata != none { heading(level:1, numbering:none, outlined:false, bookmarked:true, upper("Errata")); errata; pagebreak() }
  if approval-text != none {
    heading(level:1, numbering:none, outlined:false, bookmarked:true, hide[ Folha de aprovação])
    _single({ set par(justify:true); approval-text; v(3cm); set align(center); for member in committee { v(1.2cm); line(length:10cm, stroke:0.5pt); member; parbreak() } }); pagebreak()
  }
  if dedication != none { v(1fr); align(center, emph(dedication)); v(1fr); pagebreak() }
  if acknowledgments != none { _pre-titulo[AGRADECIMENTOS]; acknowledgments; pagebreak() }
  if epigraph != none { v(1fr); align(right, emph(epigraph)); pagebreak() }
  if resumo-conteudo != none { _pre-titulo[RESUMO]; _single({ set par(first-line-indent:0pt, spacing:18pt); resumo-conteudo; if resumo-palavras.len()>0 { parbreak(); [Palavras-chave: #(resumo-palavras.join(". ")).] } }); pagebreak() }
  if abstract-conteudo != none { _pre-titulo[ABSTRACT]; _single({ set par(first-line-indent:0pt, spacing:18pt); set text(lang:"en"); abstract-conteudo; if abstract-palavras.len()>0 { parbreak(); [Keywords: #(abstract-palavras.join(". ")).] } }); pagebreak() }
  let _lista(nome, target) = { _pre-titulo(nome); show outline.entry: it => { let tail = if it.fill!=none { box(width:1fr, it.fill) } else { h(1fr) }; it.indented(text(fill:_blue, {it.prefix(); _cm-dash}), text(fill:_blue, it.body()) + [ ] + tail + [ ] + it.page()) }; outline(title:none, target:target) }
  if incluir-lista-figuras { _lista([Lista de figuras], figure.where(kind:image)) }
  if incluir-lista-algoritmos { _lista([Lista de algoritmos], figure.where(kind:"algorithm")) }
  if incluir-lista-codigos { _lista([Lista de códigos], figure.where(kind:"code")) }
  if incluir-lista-quadros { _lista([Lista de quadros], figure.where(kind:"frame")) }
  if incluir-lista-tabelas { _lista([Lista de tabelas], figure.where(kind:table)) }
  // glossário abreviaturas via novo state inline
  // (lista-abreviaturas e glossario expostos para uso manual após body se desejar; inline já é auto)
  _pre-titulo[SUMÁRIO]
  {
    show outline.entry.where(level:1): it => context block(above:1em, below:0pt, text(fill:_blue, weight:"bold", {
      let modo=_backmatter.at(it.element.location())
      if modo!=none { let letra=numbering("A", counter(heading).at(it.element.location()).first()); it.indented([#if modo=="appendix"{"Apêndice"}else{"Anexo"} #letra#_cm-dash], it.inner()) }
      else { let e=it.indented(it.prefix(), it.inner()); if it.element.body==[Referências] { upper(e) } else { e } }
    }))
    show outline.entry.where(level:2): it => context if _backmatter.at(it.element.location())!=none { none } else { text(fill:_blue, style:"italic", it.indented(it.prefix(), it.inner())) }
    show outline.entry.where(level:3): it => context if _backmatter.at(it.element.location())!=none { none } else { text(fill:_blue, it.indented(it.prefix(), it.inner())) }
    outline(title:none, depth:3, indent:1.2em)
  }
  body
}
