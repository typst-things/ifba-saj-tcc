// main.typ — Exemplo de uso completo do pacote ifba-saj-tcc (25 funcionalidades).

#import "@local/ifba-saj-tcc:0.1.0": *
#import "glossary.typ": entries
#import "assets/diagramas/arquitetura.typ": arquitetura
#import "assets/graficos/pizza.typ": pizza
#import "assets/algoritmos/busca.typ": busca-linear

// 🎨 Customização Visual (funcionalidade 25)
#show: template.with(
  titulo: "Desenvolvimento de um Sistema de TCC Autogerado para o IFBA SAJ",
  autor: "Sandro de Souza",
  orientador: "Prof. Dr. Orientador do IFBA",
  instituicao: "Instituto Federal da Bahia",
  campus: "Santo Antônio de Jesus",
  curso: "Análise e Desenvolvimento de Sistemas",
  local: "Santo Antônio de Jesus",
  ano: "2026",
  descricao: [
    Trabalho de Conclusão de Curso apresentado ao curso de Análise e Desenvolvimento de Sistemas do Instituto Federal da Bahia, campus Santo Antônio de Jesus, como requisito parcial para obtenção do título de Tecnólogo.
    Orientador: Prof. Dr. Orientador do IFBA.
  ],
  resumo-conteudo: [
    Este trabalho apresenta um exemplo completo de uso do pacote Typst *ifba-saj-tcc*, demonstrando todas as funcionalidades para a escrita de um Trabalho de Conclusão de Curso em conformidade com as normas ABNT. São ilustrados elementos pré-textuais, textuais e pós-textuais, incluindo figuras, quadros, tabelas, citações, código-fonte, algoritmos, gráficos, diagramas, glossário, siglas, símbolos, anexos e apêndices.
  ],
  resumo-palavras: ("Typst", "TCC", "ABNT", "IFBA"),
  abstract-conteudo: [
    This work presents a complete usage example of the *ifba-saj-tcc* Typst package, demonstrating all the features for writing a Course Conclusion Paper in compliance with ABNT standards. Pre-textual, textual and post-textual elements are illustrated, including figures, frames, tables, citations, source code, algorithms, charts, diagrams, glossary, acronyms, symbols, annexes and appendices.
  ],
  abstract-palavras: ("Typst", "Thesis", "ABNT", "IFBA"),
  dedicatoria-conteudo: [Dedico este trabalho à comunidade de software livre de Santo Antônio de Jesus.],
  agradecimentos-conteudo: [
    Agradeço aos professores do IFBA pelo suporte constante ao longo da graduação.
    Agradeço também aos colegas de turma pelo companheirismo.
  ],
  epigrafe-conteudo: [A simplicidade é a sofisticação máxima.],
  epigrafe-autor: [Leonardo da Vinci],
  glossary-entries: entries,
  incluir-lista-figuras: true,
  incluir-lista-tabelas: true,
  incluir-lista-quadros: true,
  incluir-lista-codigos: true,
  incluir-lista-algoritmos: true,
  draft: true,          // 📌 Notas de editor visíveis
codly-habilitado: true, // 💻 Realce de código
  bibliografia: read("referencias.bib", encoding: none),
)

= Introdução

O @ifba, campus Santo Antônio de Jesus, forma profissionais de tecnologia para a região. O curso de @ads deste campus é referência na área. Este documento demonstra o uso do pacote *ifba-saj-tcc*.

Como afirma #cite-prose("martin2008"), o código limpo é essencial para a manutenibilidade de sistemas. Essa perspectiva é fundamental no desenvolvimento de @microservices e @sgbd.

// 📸 Figura (funcionalidade 1) com imagem externa.
#figura(
  image("assets/imagens/logo.svg"),
  caption: [Logotipo do IFBA, campus Santo Antônio de Jesus],
) <figura-logo>

== Contextualização

Para ilustrar a arquitetura de um sistema distribuído, apresentamos a @figura-arquitetura.

// 📐 Diagrama (funcionalidade 10) via arquivo separado.
#figura(
  arquitetura,
  caption: [Arquitetura de microsserviços proposta para o sistema],
) <figura-arquitetura>

Os dados coletados nos testes de carga estão na @tabela-resultados.

// 📊 Tabela (funcionalidade 3) com dados importados de CSV.
#tabela(
  caption: [Métricas de desempenho dos microsserviços sob carga],
  columns: (1fr, 1fr, 1fr),
  header: ([Módulo], [Tempo (ms)], [CPU (%)]),
  ..csv("data/resultados.csv"),
) <tabela-resultados>

Para a comparação qualitativa das plataformas, veja o @quadro-sgbd.

// 🖼 Quadro (funcionalidade 2).
#quadro(
  (
    [Critério], [PostgreSQL], [MongoDB],
    [Modelo], [Relacional], [Documentos],
    [Transações], [ACID], [BASE],
  ),
  caption: [Comparativo qualitativo de SGBDs],
) <quadro-sgbd>

== Citações

A @figura-codigo apresenta um trecho do código-fonte real do servidor.

// 💻 Exibição de Código (funcionalidade 7) lido de arquivo externo.
#codigo(
  lang: "javascript",
  caption: [Servidor Express de autenticação],
  read("assets/codigos/server.js"),
) <figura-codigo>

O algoritmo de busca linear é descrito no @algoritmo-busca.

// ⚙️ Algoritmo (funcionalidade 8) via arquivo separado.
#figura-algoritmo(
  algoritmo-passos(..busca-linear),
  caption: [Algoritmo de busca linear para varredura de dados],
) <algoritmo-busca>

// 📈 Gráfico (funcionalidade 9) via arquivo separado.
#figura(
  pizza,
  caption: [Distribuição das linguagens utilizadas pelos estudantes],
) <figura-grafico>

// 📝 Citação direta curta (funcionalidade 4)
Segundo o autor, #citacao-curta[o código limpo é legível e simples].

// 📝 Citação direta longa (funcionalidade 5)
#citacao-longa(
  autor: "Martin",
  ano: "2009",
  pagina: "42",
)[
  O código é limpo se for legível e simples. Ele não deve conter duplicações, deve expressar claramente suas intenções e conter o mínimo de dependências possíveis para facilitar a manutenção e evolução do sistema ao longo do tempo.
]

// 📝 Citação indireta parentética (funcionalidade 6)
A arquitetura de microsserviços ganhou forte adoção na indústria #cite-parent("newman2021").

// 📌 Notas de rodapé (funcionalidade 22)
Este é um exemplo de texto com uma nota de rodapé.#nota-de-rodape[Nota explicativa de rodapé, em tamanho 10pt.]

// 📌 Notas de editor (funcionalidade 23) — visíveis apenas em modo draft.
#todo[Revisar os dados reais de latência da tabela.]
#nota-revision[Conferir se a citação longa precisa de mais contexto.]
#rascunho[Incluir discussão sobre escalabilidade.]

== Equações

A equação abaixo ilustra o uso de fórmulas matemáticas.

// 🔤 Equações / Fórmulas (funcionalidade 21)
#equacao[$ e^(i pi) + 1 = 0 $] <eq-euler>

// 🔗 Referência cruzada (funcionalidade 24) — ver @figura-arquitetura, @tabela-resultados e @eq-euler.

// 📎 Apêndice (funcionalidade 15)
#apendice("Roteiro de Entrevistas")[
  #include "assets/apendices/roteiro.typ"
]

// 📁 Anexo (funcionalidade 14)
#anexo("Portaria de Autorização")[
  #include "assets/anexos/portaria.typ"
]