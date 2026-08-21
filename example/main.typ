//#import "@local/ifba-saj-tcc:0.1.0": *
#import "../lib.typ": *
#import "assets/diagramas/arquitetura.typ": arquitetura
#import "assets/graficos/pizza.typ": pizza
#import "assets/algoritmos/busca.typ": busca-linear
#show: template.with(
  titulo: "Desenvolvimento de um Sistema de TCC Autogerado para o IFBA SAJ",
  autor: "Sandro de Souza",
  orientador: "Prof. Dr. Orientador do IFBA",
  ano: "2026",
  descricao: [Trabalho de Conclusão de Curso apresentado ao curso de Análise e Desenvolvimento de Sistemas do Instituto Federal da Bahia, campus Santo Antônio de Jesus.],
  resumo-conteudo: [Este trabalho apresenta exemplo completo do pacote ifba-saj-tcc com todas as funcionalidades ABNT.],
  resumo-palavras: ("Typst", "TCC", "ABNT", "IFBA"),
  abstract-conteudo: [This work presents a complete example of the ifba-saj-tcc package.],
  abstract-palavras: ("Typst", "Thesis", "ABNT", "IFBA"),
  dedication: [Dedico à comunidade de software livre de SAJ.],
  acknowledgments: [Agradeço aos professores do IFBA.],
  epigraph: [A simplicidade é a sofisticação máxima. \ — Leonardo da Vinci],
  catalog-card: none,
  errata: none,
  approval-text: none,
  committee: (),
  codly-habilitado: true,
  bibliografia: read("referencias.bib"),
  incluir-lista-codigos: true,
  incluir-lista-algoritmos: true,
  incluir-lista-quadros: true,
  draft: true,
)
= Introdução

O #abbrev("ifba", long: "Instituto Federal da Bahia")[Instituição federal] campus SAJ e o curso de #abbrev("ads", long: "Análise e Desenvolvimento de Sistemas")[Curso ADS] são referência. O #abbrev("ifba", long: "Instituto Federal da Bahia")[] novamente. Como afirma #prose("martin2008"), o código limpo é essencial. O termo #gloss("microsserviços")[Estilo arquitetural com serviços independentes.] é central. O #gloss("docker")[Plataforma de containers.] também.

#lorem(60)

#figura(image("assets/imagens/logo.svg"), caption: [Logotipo IFBA]) <figura-logo>

#lorem(60)

== Contextualização

#lorem(60)

Ver @figura-logo e @figura-arquitetura.

#lorem(60)

#figura(arquitetura, caption: [Arquitetura de microsserviços]) <figura-arquitetura>

#lorem(60)

#tabela(
  caption: [Métricas sob carga],
  columns: (1fr, 1fr, 1fr),
  header: ([Módulo], [Tempo], [CPU]),
  ..csv("data/resultados.csv"),
) <tabela-resultados>

#lorem(60)

#quadro(
  ([Critério], [PostgreSQL], [MongoDB], [Modelo], [Relacional], [Documentos]),
  caption: [Comparativo SGBDs],
) <quadro-sgbd>


#lorem(60)

== Citações

#lorem(60)

A @figura-codigo mostra código real.

#lorem(60)

#codigo(lang: "javascript", caption: [Servidor Express], read("assets/codigos/server.js")) <figura-codigo>

#lorem(60)

#figura-algoritmo(algoritmo-passos(..busca-linear), caption: [Busca linear]) <algoritmo-busca>

#lorem(60)

O algoritmo é o @algoritmo-busca.

#lorem(60)

#figura(pizza, caption: [Distribuição linguagens]) <figura-grafico>

#lorem(60)

Segundo autor, #citacao-curta[código limpo é legível].

#lorem(60)

#citacao-longa(
  autor: "Martin",
  ano: "2009",
  pagina: "42",
)[O código é limpo se for legível e simples. Ele não deve conter duplicações.]
A arquitetura é relevante #cite("newman2021").
Texto com nota#nota-de-rodape[Nota explicativa.].
#todo[Revisar latência.]
#equacao[$ e^(i pi) + 1 = 0 $] <eq-euler>
Ver @figura-arquitetura e @eq-euler.
#references()
#glossario()
#apendice
= Roteiro de Entrevistas
Conteúdo do apêndice A.
== Seção interna apêndice
Texto.
= Novo Apendice
#lorem(30)
#anexo
= Portaria de Autorização
Conteúdo do anexo A.
= Novo anexo
#lorem(30)
