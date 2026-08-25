#import "../lib.typ": *
#import "assets/diagramas/arquitetura.typ": arquitetura
#import "assets/graficos/pizza.typ": pizza
#import "assets/graficos/barras.typ": barras
#show: template.with(
  titulo: "Desenvolvimento de um Sistema de TCC Autogerado para o IFBA SAJ",
  autor: "Sandro de Souza",
  orientador: "Prof. Dr. Orientador do IFBA",
  data-banca: datetime(year: 2026, month: 8, day: 04),
  resumo-conteudo: [Este trabalho apresenta exemplo completo do pacote ifba-saj-tcc com todas as funcionalidades ABNT.],
  resumo-palavras: ("Typst", "TCC", "ABNT", "IFBA"),
  abstract-conteudo: [This work presents a complete example of the ifba-saj-tcc package.],
  abstract-palavras: ("Typst", "Thesis", "ABNT", "IFBA"),
  dedicatoria: [Dedico à comunidade de software livre de SAJ.],
  agradecimentos: [Agradeço aos professores do IFBA.],
  epigrafe: [A simplicidade é a sofisticação máxima. \ — Leonardo da Vinci],
  ficha-catalografica: image("assets/ficha-exemplo.pdf", width: 100%, height: 100%, fit: "contain"),
  errata: [Elemento opcional para versão corrigida, depois de depositada.],
  // texto-aprovacao: none → auto-gerado (let _texto-aprovacao-pad); ou forneça content/str custom
  banca: (
    [Prof. Dr. \ Instituição \ Presidente],
    [Prof. Dr. \ Instituição],
    [Prof. Dr. \ Instituição],
    [Prof. Dr. \ Instituição],
    [Prof. Dr. \ Instituição],
  ),
  bibliografia: read("referencias.bib"),
  versao-impressao: false,
)
= Introdução

O #abbrev("ifba", long: "Instituto Federal da Bahia")[Instituição federal] campus SAJ e o curso de #abbrev("ads", long: "Análise e Desenvolvimento de Sistemas")[Curso ADS] são referência. O #abbrev("ifba", long: "Instituto Federal da Bahia")[] novamente. Como afirma #prose("martin2008"), o código limpo é essencial. O termo #gloss("microsserviços")[Estilo arquitetural com serviços independentes.] é central. O #gloss("docker")[Plataforma de containers.] também.

#lorem(60)

#figura(
  image("assets/imagens/logo.svg"),
  caption: [Logotipo IFBA],
) <figura-logo>

#lorem(60)

== Contextualização

#lorem(60)

Ver @figura-logo e @figura-arquitetura.

#lorem(60)

#figura(
  arquitetura,
  caption: [Arquitetura de microsserviços],
) <figura-arquitetura>

#lorem(60)

#tabela(
  caption: [Métricas sob carga],
  columns: (1fr, 1fr, 1fr),
  header: ([Módulo], [Tempo de Resposta (ms)], [Uso de CPU (%)]),
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

A arquitetura de microsserviços é amplamente adotada na indústria #cite("newman2021").#lorem(30)

Várias fontes confirmam essa tendência #cite("martin2008", "sommerville2011").#lorem(30)


=== Indireta narrativa (autor no fluxo do texto)

Como afirma #prose("martin2008"), o código limpo é essencial. #lorem(30)


Segundo #prose("sommerville2011"), a engenharia de software é disciplina madura.#lorem(30)


=== Com localizador (página)

A modularização é defendida #cite("martin2008", supplement: [p. 42]).#lorem(30)

Na forma narrativa com página: #cite("sommerville2011", supplement: [p. 18]) destaca a importância.#lorem(30)


=== Múltiplas fontes

Estudos recentes apontam convergência #cite("martin2008", "sommerville2011", "newman2021").#lorem(30)

=== Só autor / só ano (via prose + referência)

#lorem(30) O autor citado é #prose("newman2021"). // nativo equivalente a form:author/year seria custom

=== Direta curta (até 3 linhas, aspas + citação)

#lorem(30) Segundo o autor, #citacao-curta[código limpo é legível e simples] #cite("martin2008", supplement: [p. 42]).

=== Direta longa (>3 linhas, recuo 4cm, 10pt)

#citacao-longa(
  autor: "Martin",
  ano: "2009",
  pagina: "42",
)[O código é limpo se for legível e simples. Ele não deve conter duplicações. Deve expressar claramente suas intenções e conter o mínimo de dependências possíveis para facilitar a manutenção e evolução do sistema ao longo do tempo.]

#lorem(30) A arquitetura é relevante #cite("newman2021").

=== Código e Algoritmo (para referência cruzada)

#lorem(30) A @figura-codigo mostra código real.

#codigo(
  lang: "javascript", 
  caption: [Servidor Express], 
  filename: "server.js",
  read("assets/codigos/server.js")
) <figura-codigo>

#lorem(30) O algoritmo é o @algoritmo-busca.

#algoritmo(read("assets/algoritmos/busca.alg"), caption: [Busca linear]) <algoritmo-busca>

#lorem(30)

#figura(pizza, caption: [Distribuição linguagens]) <figura-grafico>

#lorem(30) Texto com nota#footnote[Nota explicativa.].

#figura(barras, caption: [Distribuição linguagens em barras]) <figura-barras>


#equacao[$ e^(i pi) + 1 = 0 $] <eq-euler>

#lorem(30) Ver @figura-arquitetura e @eq-euler.

#references()

#glossario()

#apendice

= Roteiro de Entrevistas

Conteúdo do apêndice A. #lorem(280)

== Seção interna apêndice

Texto.#lorem(280)

= Novo Apendice

#lorem(30)

#anexo

= Portaria de Autorização

Conteúdo do anexo A.#lorem(280)

= Novo anexo

#lorem(300)
