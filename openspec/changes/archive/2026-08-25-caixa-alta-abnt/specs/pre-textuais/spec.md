## MODIFIED Requirements

### Requirement: Capa

A capa SHALL exibir centrado: logotipo (ou placeholder), nome da instituição em caixa-alta, autor em caixa-alta, título em negrito e caixa-alta, local e ano em caixa-alta, com espaçamentos verticais definidos. A caixa-alta SHALL ser aplicada apenas na renderização (upper na saída), preservando o valor original em storage/getters.

#### Scenario: Capa sem logo customizado
- **WHEN** `logo: none`
- **THEN** é renderizado um placeholder "LOGOTIPO IFBA" tracejado

#### Scenario: Capa com caixa-alta ABNT
- **WHEN** `titulo: "Meu TCC"`, `autor: "João Silva"`, `instituicao: [Instituto Federal da Bahia]`
- **THEN** a capa exibe "MEU TCC", "JOÃO SILVA", "INSTITUTO FEDERAL DA BAHIA" em caixa-alta

### Requirement: Folha de rosto

A folha de rosto SHALL exibir autor em caixa-alta, título em negrito e caixa-alta e, à direita da página em bloco justificado, o preâmbulo parametrizado montado a partir de `instituicao`/`curso`/`local` (via `get-instituicao`/`get-curso`/`get-cidade`), seguido de orientador e coorientador em caixa normal (sem upper, conforme NBR 14724), local e ano (derivado de `data-banca`) em caixa-alta.

#### Scenario: Preenchimento automático do preâmbulo
- **WHEN** o preâmbulo parametrizado é gerado
- **THEN** o texto resultante é "Trabalho de Conclusão de Curso apresentado ao Instituto Federal de Educação, Ciência e Tecnologia da Bahia, campus Santo Antônio de Jesus, como requisito parcial para obtenção do grau de Tecnólogo em Análise e Desenvolvimento de Sistemas." montado a partir dos valores de `instituicao`/`curso`/`local`

#### Scenario: Folha de rosto com caixa-alta
- **WHEN** `orientador: "Prof. Dr. Maria"` e `local: "Santo Antônio de Jesus"`
- **THEN** a folha exibe local em caixa-alta e orientador em caixa normal na renderização, e `get-orientador()` retorna valor original

## ADDED Requirements

### Requirement: Folha de aprovação parametrizada

Quando `texto-aprovacao: none`, o sistema SHALL gerar automaticamente a folha de aprovação a partir de `autor`/`titulo`/`banca`/`local`/`ano`/`instituicao`/`curso` no formato do PDF de referência: nome do autor em caixa-alta, título em caixa-alta, parágrafo "A banca examinadora, abaixo listada, aprova o Trabalho de Conclusão de Curso "TÍTULO" elaborado por "Nome" como requisito parcial para obtenção do grau de Tecnólogo em <curso>, pelo <instituicao>.", local e ano, "Comissão Examinadora" e linhas de assinatura para cada membro de `banca` (primeiro marcado como Orientador). Quando `texto-aprovacao` é `str`, SHALL renderizar imagem em página cheia; quando é `content`, SHALL usar o conteúdo fornecido seguido da banca.

#### Scenario: Folha de aprovação auto-gerada
- **WHEN** `texto-aprovacao: none` e `banca` tem 3 membros, `titulo: "Meu TCC"`, `autor: "João Silva"`
- **THEN** a folha exibe "JOÃO SILVA", "MEU TCC", o parágrafo com título e autor, local/ano, "Comissão Examinadora" e 3 assinaturas com o primeiro como (Orientador)

#### Scenario: Folha de aprovação custom via imagem
- **WHEN** `texto-aprovacao` é caminho str
- **THEN** a imagem é renderizada em página cheia sem cabeçalho/rodapé

#### Scenario: Banca obrigatória
- **WHEN** `banca` é vazio
- **THEN** a compilação falha indicando `banca` obrigatório

### Requirement: Estado global de configuração

O template SHALL registrar titulo, autor, orientador, curso, cidade, ano e modo print em um estado global, exposto via getters (`get-autor`, `get-titulo`, `get-ano`, etc.) reutilizáveis no texto. Getters SHALL retornar valor original (sem upper); upper é aplicado apenas na renderização de capa/folha/títulos.

#### Scenario: Uso no texto
- **WHEN** o autor escreve `#get-autor()` no corpo
- **THEN** é inserido o nome informado em `template` sem transformação de caixa
