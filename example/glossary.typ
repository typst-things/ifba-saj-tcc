// glossary.typ — Cadastro central de termos, siglas e símbolos (glossarium).

#let entries = (
  // Siglas/abreviaturas
  (
    key: "ifba",
    short: "IFBA",
    long: "Instituto Federal de Educação, Ciência e Tecnologia da Bahia",
    description: "Instituição de ensino superior pública federal brasileira.",
    group: "abbreviation",
  ),
  (
    key: "ads",
    short: "ADS",
    long: "Análise e Desenvolvimento de Sistemas",
    description: "Curso superior de tecnologia na área de computação.",
    group: "abbreviation",
  ),
  (
    key: "api",
    short: "API",
    long: "Application Programming Interface",
    description: "Conjunto de rotinas e padrões para acesso a aplicativos de software.",
    group: "abbreviation",
  ),
  (
    key: "sgbd",
    short: "SGBD",
    long: "Sistema Gerenciador de Banco de Dados",
    description: "Software responsável por gerenciar bancos de dados.",
    group: "abbreviation",
  ),
  // Símbolos
  (
    key: "gamma",
    short: $Gamma$,
    long: "Letra grega Gama",
    description: "Representa a função gama na matemática.",
    group: "symbol",
  ),
  (
    key: "lambda",
    short: $lambda$,
    long: "Letra grega Lambda",
    description: "Usada em cálculos lambda e programação funcional.",
    group: "symbol",
  ),
  // Termos do glossário
  (
    key: "docker",
    short: "Docker",
    long: "Plataforma de Containers",
    description: "Conjunto de produtos que usam virtualização em nível de sistema operacional para entregar software em contêineres.",
  ),
  (
    key: "microservices",
    short: "Microsserviços",
    long: "Arquitetura de Microsserviços",
    description: "Estilo arquitetural que estrutura uma aplicação como uma coleção de serviços pequenos e independentes.",
  ),
)
