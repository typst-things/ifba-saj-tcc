// annexes.typ — Apêndices e Anexos com rotulação por letra (A, B, C...).

// Contadores independentes para apêndices e anexos (baseados em estado).
#let _apendice-letra = state("ifba-apendice-letra", 0)
#let _anexo-letra = state("ifba-anexo-letra", 0)

// Converte um inteiro 1..26 em letra maiúscula (A, B, C...).
#let _letra(n) = {
  let letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  letras.at(calc.min(n, 26) - 1)
}

// 📎 Apêndice — elemento elaborado pelo próprio autor.
#let apendice(
  titulo,
  body,
) = {
  _apendice-letra.update(n => n + 1)
  let letra = context { _letra(_apendice-letra.get()) }
  pagebreak()
  heading(
    level: 1,
    numbering: none,
    outlined: true,
  )[#strong[APÊNDICE #letra#(" – ")#upper(titulo)]]
  body
}

// 📁 Anexo — elemento não elaborado pelo autor.
#let anexo(
  titulo,
  body,
) = {
  _anexo-letra.update(n => n + 1)
  let letra = context { _letra(_anexo-letra.get()) }
  pagebreak()
  heading(
    level: 1,
    numbering: none,
    outlined: true,
  )[#strong[ANEXO #letra#(" – ")#upper(titulo)]]
  body
}