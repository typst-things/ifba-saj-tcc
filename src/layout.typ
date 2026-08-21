// layout.typ — Configurações ABNT de página, fontes, espaçamento e numeração.

#import "@preview/glossarium:0.5.10": make-glossary

// Tema padrão ABNT IFBA.
#let default-theme = (
  serif: "Times New Roman",
  sans: "Arial",
  mono: "JetBrains Mono",
  math: "New Computer Modern Math",
  size: 11pt,
  heading-size: 14pt,
  quote-size: 10pt,
  note-size: 10pt,
  margin-top: 3cm,
  margin-left: 3cm,
  margin-right: 2cm,
  margin-bottom: 2cm,
  line-height: 1.5,
  paragraph-indent: 1.25cm,
  link-color: rgb("#0000EE"),
  heading-color: rgb("#000000"),
)

// Aplica o layout da página (margens ABNT).
#let set-abnt-page(theme: default-theme) = {
  set page(
    paper: "a4",
    margin: (
      top: theme.margin-top,
      bottom: theme.margin-bottom,
      left: theme.margin-left,
      right: theme.margin-right,
    ),
    numbering: none,
  )
}

// Aplica regras de texto e espaçamento do corpo ABNT.
#let set-abnt-text(theme: default-theme) = {
  set text(
    font: theme.serif,
    size: theme.size,
    fill: rgb("#000000"),
  )
  set par(
    justify: true,
    leading: theme.line-height * theme.size,
    first-line-indent: theme.paragraph-indent,
  )
  set heading(numbering: "1.1")
  show heading: it => {
    set text(size: theme.heading-size, fill: theme.heading-color)
    it
  }
  show heading.where(level: 1): it => text(
    weight: "bold",
    fill: theme.heading-color,
    it.body,
  )
  // Citações e notas em espaçamento simples e fonte menor.
  show quote: set text(size: theme.quote-size)
  show footnote: set text(size: theme.note-size)
}

// Numeração de páginas no canto superior direito, a partir do texto textual.
#let set-abnt-numbering(theme: default-theme) = {
  set page(
    numbering: "1",
    number-align: center + top,
  )
}

// Configura links com a cor definida no tema.
#let set-abnt-links(theme: default-theme) = {
  show link: set text(fill: theme.link-color)
}

// Aplica todas as regras de layout do pacote.
#let apply-layout(theme: default-theme) = {
  set-abnt-page(theme: theme)
  set-abnt-text(theme: theme)
  set-abnt-numbering(theme: theme)
  set-abnt-links(theme: theme)
}
