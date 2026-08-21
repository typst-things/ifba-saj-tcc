// diagrams.typ — Diagramas vetoriais (cetz), importáveis de arquivos separados.

#import "@preview/cetz:0.4.2"

// Função auxiliar para construir um canvas a partir de código de desenho.
#let diagram(body) = {
  import cetz.draw: *
  canvas(body)
}

// Exemplo de diagrama de blocos (fluxograma simples).
#let fluxograma(
  title: none,
  nodes: (:),
  edges: (),
) = {
  canvas({
    import cetz.draw: *
    for (name, spec) in nodes {
      rect(
        spec.at("pos", default: (0, 0)),
        spec.at("size", default: (2, 1)),
        name: name,
        label: spec.at("label", default: text(name)),
        fill: spec.at("fill", default: none),
      )
    }
    for e in edges {
      line(e.at(0), e.at(1), mark: (end: ">"))
    }
  })
}
