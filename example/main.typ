//#import "@local/ifba-saj-tcc:0.1.0": *
#import "../lib.typ": *
#import "assets/diagramas/arquitetura.typ": arquitetura
#import "assets/graficos/pizza.typ": pizza
#import "assets/graficos/barras.typ":  barras
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
  //catalog-card: [#v(1fr) Ficha catalog-card #v(1fr) ], // "assets/ficha.pdf" ou image("assets/ficha.pdf", width:100%, height:100%, fit:"contain")
  catalog-card: image("assets/ficha-exemplo.pdf", width:100%, height:100%, fit:"contain"),
  errata: [Elemento opcional para versão corrigida, depois de depositada.],
  approval-text: [
    Trabalho de Conclusão de Curso de autoria de #get-autor() , sob o título *#get-titulo()*, apresentada à Escola de Artes, Ciências e Humanidades da Universidade de São Paulo, para obtenção do título de Mestre em Ciências pelo Programa de Pós-graduação em Sistemas de Informação, na área de concentração Metodologia e Técnicas da Computação, aprovada em #h(0.3em)#box(width: 0.85cm, line(length: 100%, stroke: 0.5pt))#h(0.3em) de #h(0.3em)#box(width: 3.5cm, line(length: 100%, stroke: 0.5pt))#h(0.3em) de #h(0.3em)#box(width: 1.25cm, line(length: 100%, stroke: 0.5pt))#h(0.3em) pela comissão julgadora constituída pelos doutores:
  ],
  committee: (
    [Prof. Dr. \ Instituição \ Presidente],
    [Prof. Dr. \ Instituição],
    [Prof. Dr. \ Instituição],
    [Prof. Dr. \ Instituição],
    [Prof. Dr. \ Instituição],
  ),
  codly-habilitado: true,
  bibliografia: read("referencias.bib"),
  incluir-lista-codigos: true,
  incluir-lista-algoritmos: true,
  incluir-lista-quadros: true,
  incluir-lista-equacoes: true,
  print: true,
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

== Citações — Exemplos Nativos ABNT (NBR 10520:2023)

#lorem(30)

=== Indireta parentética (ao final da frase)

A arquitetura de microsserviços é amplamente adotada na indústria #cite("newman2021").
Várias fontes confirmam essa tendência #cite("martin2008", "sommerville2011").

=== Indireta narrativa (autor no fluxo do texto)

Como afirma #prose("martin2008"), o código limpo é essencial.
Segundo #prose("sommerville2011"), a engenharia de software é disciplina madura.

=== Com localizador (página)

A modularização é defendida #cite("martin2008", supplement: [p. 42]).
Na forma narrativa com página: #cite("sommerville2011", supplement: [p. 18]) destaca a importância.

=== Múltiplas fontes

Estudos recentes apontam convergência #cite("martin2008", "sommerville2011", "newman2021").

=== Só autor / só ano (via prose + referência)

O autor citado é #prose("newman2021"). // nativo equivalente a form:author/year seria custom

=== Direta curta (até 3 linhas, aspas + citação)

Segundo o autor, #citacao-curta[código limpo é legível e simples] #cite("martin2008", supplement: [p. 42]).

=== Direta longa (>3 linhas, recuo 4cm, 10pt)

#citacao-longa(
  autor: "Martin",
  ano: "2009",
  pagina: "42",
)[O código é limpo se for legível e simples. Ele não deve conter duplicações. Deve expressar claramente suas intenções e conter o mínimo de dependências possíveis para facilitar a manutenção e evolução do sistema ao longo do tempo.]

A arquitetura é relevante #cite("newman2021").

=== Código e Algoritmo (para referência cruzada)

A @figura-codigo mostra código real.

#codigo(lang: "javascript", caption: [Servidor Express], read("assets/codigos/server.js")) <figura-codigo>

O algoritmo é o @algoritmo-busca.

#figura-algoritmo(algoritmo-passos(..busca-linear), caption: [Busca linear]) <algoritmo-busca>


#figura(pizza, caption: [Distribuição linguagens]) <figura-grafico>

Texto com nota#footnote[Nota explicativa.].

#figura(barras, caption: [Distribuição linguagens em barras]) <figura-barras>



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
