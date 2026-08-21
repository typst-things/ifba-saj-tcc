// pre-textual.typ — Estrutura do documento: capa, folha de rosto, resumos, listas, sumário.

#import "layout.typ": apply-layout, default-theme
#import "config.typ": set-config, get-config
#import "gloss.typ": setup-glossary, register as gloss-register, lista-abreviaturas, lista-simbolos, glossario
#import "@preview/glossarium:0.5.10": make-glossary
#import "bibliography.typ": set-abnt-bibliography
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#let _cm-dash = " – "

// Título pré-textual (não numerado, caixa alta, centralizado).
#let _pre-titulo(titulo) = {
  pagebreak(weak: true)
  align(center, text(size: 14pt, weight: "bold")[#upper(titulo)])
  v(1em)
}

// Capa.
#let _capa(cfg) = {
  align(center, text(size: 12pt)[#cfg.instituicao])
  v(1em)
  align(center, text(size: 12pt)[#cfg.curso])
  v(8em)
  align(center, text(size: 14pt, weight: "bold")[#cfg.titulo])
  v(8em)
  align(center, text(size: 12pt)[#cfg.autor])
  v(6em)
  align(center, text(size: 12pt)[#cfg.local])
  align(center, text(size: 12pt)[#cfg.ano])
  pagebreak()
}

// Folha de rosto.
#let _folha-rosto(cfg) = {
  v(6em)
  block(width: 8cm, align(center, text(size: 12pt)[#cfg.autor]))
  v(2em)
  block(width: 10cm, align(center, text(size: 12pt)[#cfg.titulo]))
  v(3em)
  block(width: 8cm, align(center, text(size: 12pt, style: "italic")[
    #cfg.descricao
  ]))
  v(2em)
  if cfg.orientador != none {
    block(width: 8cm, align(center, text(size: 12pt)[#cfg.orientador]))
    v(1em)
  }
  pagebreak()
}

// 📋 Lista genérica de ilustrações.
#let _lista(nome, target) = {
  _pre-titulo(nome)
  outline(title: none, target: target)
  v(1em)
}

#let lista-figuras() = _lista([Lista de figuras], figure.where(kind: "image"))
#let lista-tabelas() = _lista([Lista de tabelas], figure.where(kind: table))
#let lista-quadros() = _lista([Lista de quadros], figure.where(kind: "frame"))
#let lista-codigos() = _lista([Lista de códigos], figure.where(kind: "code"))
#let lista-algoritmos() = _lista([Lista de algoritmos], figure.where(kind: "algorithm"))

// 📋 Sumário.
#let sumario() = {
  _pre-titulo[Sumário]
  outline(title: none, indent: 1.5em)
  v(1em)
}

// #resumo — resumo com palavras-chave.
#let resumo(body, palavras: ()) = {
  _pre-titulo[Resumo]
  set par(first-line-indent: 0pt, justify: true)
  body
  if palavras.len() > 0 {
    parbreak()
    [*Palavras-chave:* #(palavras.join(", ")).]
  }
  pagebreak()
}

// #abstract — resumo em língua estrangeira.
#let abstract(body, palavras: ()) = {
  _pre-titulo[Abstract]
  set text(lang: "en")
  set par(first-line-indent: 0pt, justify: true)
  body
  if palavras.len() > 0 {
    parbreak()
    [*Keywords:* #(palavras.join(", ")).]
  }
  pagebreak()
}

// #dedicatoria
#let dedicatoria(body) = {
  _pre-titulo[Dedicatória]
  v(6em)
  align(center, body)
  pagebreak()
}

// #agradecimentos
#let agradecimentos(body) = {
  _pre-titulo[Agradecimentos]
  set par(first-line-indent: 1.25cm, justify: true)
  body
  pagebreak()
}

// #epigrafe
#let epigrafe(body, autor: none) = {
  _pre-titulo[Epígrafe]
  v(8em)
  align(right, block(width: 8cm, body))
  if autor != none {
    v(1em)
    align(right, autor)
  }
  pagebreak()
}

// ── Template principal ──────────────────────────────────────────────────────
#let template(
  titulo: none,
  subtitulo: none,
  autor: none,
  orientador: none,
  co-orientador: none,
  instituicao: "Instituto Federal da Bahia",
  campus: "Santo Antônio de Jesus",
  curso: "Análise e Desenvolvimento de Sistemas",
  tipo: "Trabalho de Conclusão de Curso",
  local: "Santo Antônio de Jesus",
  ano: none,
  descricao: none,
  resumo-conteudo: none,
  resumo-palavras: (),
  abstract-conteudo: none,
  abstract-palavras: (),
  dedicatoria-conteudo: none,
  agradecimentos-conteudo: none,
  epigrafe-conteudo: none,
  epigrafe-autor: none,
  glossary-entries: (),
  incluir-lista-figuras: true,
  incluir-lista-tabelas: true,
  incluir-lista-quadros: false,
  incluir-lista-codigos: false,
  incluir-lista-algoritmos: false,
  draft: false,
  codly-habilitado: false,
  bibliografia: none,
  referencias-titulo: "REFERÊNCIAS",
  cor-links: default-theme.link-color,
  body,
) = {
  set-config(year: ano, author: autor, draft: draft)
  apply-layout(theme: (default-theme + (link-color: cor-links)))

  // Codly: realce de código (show-rule global aplicada ao corpo).
  if codly-habilitado {
    show: codly-init.with()
    codly(languages: codly-languages)
  }

  // Legenda ABNT: suplemento + número + travessão + título, acima do elemento.
  // Escopada aos tipos de figura do pacote (ignora as entradas do glossarium).
  let _kinds = ("image", "frame", "code", "algorithm")
  show figure.caption: it => {
    let ok = if type(it.kind) == str {
      it.kind in _kinds
    } else {
      it.kind == table
    }
    if not ok {
      return it
    }
    set text(size: 12pt)
    set par(leading: 0.6em, first-line-indent: 0pt)
    layout(size => context {
      let number = it.counter.display(it.numbering)
      let is-alg = it.kind == "algorithm"
      let label = if is-alg { strong[#it.supplement #number] } else { [#it.supplement #number#_cm-dash] }
      let full = label + it.body
      if measure(full).width <= size.width {
        align(center, full)
      } else {
        set par(hanging-indent: measure(label).width, justify: true)
        full
      }
    })
  }

  // Equações numeradas.
  set math.equation(numbering: "(1)")

  // Cabeçalhos: capítulo inicia página e ativa numeração.
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set page(numbering: "1", number-align: center + top)
    set text(size: 14pt, weight: "bold")
    set par(first-line-indent: 0pt, justify: false)
    block(above: 0pt, below: 22pt, width: 100%, align(center, it.body))
  }
  show heading.where(level: 2): it => block(above: 32pt, below: 22pt, it)
  show heading.where(level: 3): it => block(above: 24pt, below: 18pt, it)

  // Configura glossarium: aplica o show-rule diretamente ao corpo (obrigatório
  // para que as referências @key funcionem como termos, não como figuras).
  show: make-glossary
  if glossary-entries.len() > 0 {
    gloss-register(glossary-entries)
  }

  // Capa e folha de rosto.
  _capa((instituicao: instituicao, curso: curso, titulo: titulo, autor: autor, local: local, ano: ano))
  _folha-rosto((
    autor: autor,
    titulo: titulo,
    descricao: if descricao == none {
      [#tipo apresentado ao #curso do #instituicao, campus #campus.]
    } else { descricao },
    orientador: if orientador != none { [#orientador] } else { none },
  ))

  // Elementos pré-textuais opcionais.
  if dedicatoria-conteudo != none { dedicatoria(dedicatoria-conteudo) }
  if agradecimentos-conteudo != none { agradecimentos(agradecimentos-conteudo) }
  if epigrafe-conteudo != none { epigrafe(epigrafe-conteudo, autor: epigrafe-autor) }
  if resumo-conteudo != none { resumo(resumo-conteudo, palavras: resumo-palavras) }
  if abstract-conteudo != none { abstract(abstract-conteudo, palavras: abstract-palavras) }

  // Listas de ilustrações.
  if incluir-lista-figuras { lista-figuras() }
  if incluir-lista-tabelas { lista-tabelas() }
  if incluir-lista-quadros { lista-quadros() }
  if incluir-lista-codigos { lista-codigos() }
  if incluir-lista-algoritmos { lista-algoritmos() }

  // Listas de abreviaturas e símbolos (automáticas a partir do glossarium).
  if glossary-entries.any(e => e.at("group", default: "") == "abbreviation") {
    lista-abreviaturas(glossary-entries)
  }
  if glossary-entries.any(e => e.at("group", default: "") == "symbol") {
    lista-simbolos(glossary-entries)
  }

  // Sumário.
  sumario()

  // Corpo do documento.
  body

  // Pós-textual: referências e glossário.
  if bibliografia != none {
    pagebreak(weak: true)
    set-abnt-bibliography(bib: bibliografia, title: referencias-titulo)
  }
  if glossary-entries.any(e => e.at("group", default: "") == "") {
    glossario(glossary-entries)
  }
}
