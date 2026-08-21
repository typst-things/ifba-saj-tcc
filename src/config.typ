// config.typ — Estado global compartilhado do documento (ano, autor, rascunho).

#let _config = state("ifba-saj-config", (year: none, author: none, draft: false))

// Atualiza a configuração do documento.
#let set-config(year: none, author: none, draft: false) = {
  _config.update(c => (
    year: if year == none { c.year } else { year },
    author: if author == none { c.author } else { author },
    draft: draft,
  ))
}

// Lê a configuração atual.
#let get-config() = _config.get()
