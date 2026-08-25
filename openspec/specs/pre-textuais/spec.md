## Purpose

Elementos pré-textuais na ordem ABNT/NBR 14724, gerenciados pelo `template` (src/pre-textual.typ).

## Requirements

### Requirement: Ordem dos elementos pré-textuais

O template SHALL emitir, nesta ordem: capa, folha de rosto, ficha catalográfica, errata (opcional), folha de aprovação, dedicatória (opcional), agradecimentos (opcional), epígrafe (opcional), resumo, abstract, listas de figuras/algoritmos/códigos/quadros/tabelas/equações (opcionais), sumário — seguidos do corpo. Ficha catalográfica, folha de aprovação, resumo e abstract são obrigatórios.

#### Scenario: Documento completo
- **WHEN** todos os parâmetros são fornecidos
- **THEN** os elementos aparecem na ordem acima, cada um em página própria

#### Scenario: Falta elemento obrigatório
- **WHEN** `ficha-catalografica`, `banca`, `resumo-conteudo`/`resumo-palavras`, `abstract-conteudo`/`abstract-palavras` ou `bibliografia` não são fornecidos
- **THEN** o sistema SHALL falhar com mensagem indicando o parâmetro obrigatório ausente

### Requirement: Capa

A capa SHALL exibir centrado: logotipo (ou placeholder), nome da instituição em caixa-alta, autor em caixa-alta, título em negrito e caixa-alta, local e ano (derivado de `data-banca`) em caixa-alta, com espaçamentos verticais definidos. A caixa-alta SHALL ser aplicada apenas na renderização, preservando valor original em getters.

#### Scenario: Capa sem logo customizado
- **WHEN** `logo: none`
- **THEN** é renderizado um placeholder "LOGOTIPO IFBA" tracejado

#### Scenario: Capa com caixa-alta ABNT
- **WHEN** `titulo: "Meu TCC"`, `autor: "João Silva"`, `instituicao: [Instituto Federal da Bahia]`
- **THEN** a capa exibe "MEU TCC", "JOÃO SILVA", "INSTITUTO FEDERAL DA BAHIA" em caixa-alta

### Requirement: Folha de rosto

A folha de rosto SHALL exibir autor em caixa-alta, título em negrito e caixa-alta e, à direita da página em bloco justificado, o preâmbulo parametrizado montado a partir de `instituicao`/`curso`/`local`, seguido de orientador e coorientador em caixa normal (sem upper, conforme NBR 14724), local e ano (derivado de `data-banca`) em caixa-alta.

#### Scenario: Preenchimento automático do preâmbulo
- **WHEN** o preâmbulo parametrizado é gerado
- **THEN** o texto resultante é "Trabalho de Conclusão de Curso apresentado ao Instituto Federal de Educação, Ciência e Tecnologia da Bahia, campus Santo Antônio de Jesus, como requisito parcial para obtenção do grau de Tecnólogo em Análise e Desenvolvimento de Sistemas." montado a partir de `instituicao`/`curso`/`local`

#### Scenario: Folha de rosto com caixa-alta
- **WHEN** `orientador: "Prof. Dr. Maria"` e `local: "Santo Antônio de Jesus"`
- **THEN** a folha exibe local em caixa-alta e orientador em caixa normal, e `get-orientador()` retorna valor original

### Requirement: Ficha catalográfica

Quando `ficha-catalografica` é fornecido (caminho de imagem ou conteúdo), o sistema SHALL renderizá-lo em página própria, sem margens nem cabeçalho. O parâmetro `ficha-catalografica` é obrigatório.

#### Scenario: Ficha em PDF
- **WHEN** `ficha-catalografica` é caminho para um PDF
- **THEN** a imagem é embutida ocupando 100% da página sem cabeçalho/rodapé

#### Scenario: Ficha ausente
- **WHEN** `ficha-catalografica` é `none`
- **THEN** a compilação falha

### Requirement: Folha de aprovação parametrizada

Quando `texto-aprovacao: none`, o sistema SHALL gerar automaticamente a folha de aprovação a partir de `autor`/`titulo`/`banca`/`local`/`data-banca`/`instituicao`/`curso` no formato do PDF de referência: nome do autor em caixa-alta, título em caixa-alta, parágrafo "A banca examinadora, abaixo listada, aprova o Trabalho de Conclusão de Curso "TÍTULO" elaborado por "Nome" como requisito parcial para obtenção do grau de Tecnólogo em <curso>, pelo <instituicao>.", local e data-banca, "Comissão Examinadora" e linhas de assinatura para cada membro de `banca` (primeiro marcado como Orientador). Quando `texto-aprovacao` é `str`, SHALL renderizar imagem em página cheia; quando é `content`, SHALL usar o conteúdo fornecido.

#### Scenario: Folha de aprovação auto-gerada
- **WHEN** `texto-aprovacao: none` e `banca` tem 3 membros, `titulo: "Meu TCC"`, `autor: "João Silva"`
- **THEN** a folha exibe "JOÃO SILVA", "MEU TCC", o parágrafo com título e autor, local/data-banca, "Comissão Examinadora" e 3 assinaturas com o primeiro como (Orientador)

#### Scenario: Banca obrigatória
- **WHEN** `banca` é vazio
- **THEN** a compilação falha indicando `banca` obrigatório

### Requirement: Resumo e abstract

Resumo e abstract SHALL ser renderizados com título centralizado sem numeração, texto em espaçamento simples, seguidos de "Palavras-chave:"/"Keywords:" joined por ponto. `resumo-conteudo`, `resumo-palavras`, `abstract-conteudo`, `abstract-palavras` e `bibliografia` são obrigatórios.

#### Scenario: Resumo com palavras-chave
- **WHEN** `resumo-palavras` é não vazio
- **THEN** a linha "Palavras-chave: a. b. c." aparece após o texto do resumo

#### Scenario: Resumo ausente
- **WHEN** `resumo-conteudo` é `none`
- **THEN** a compilação falha

### Requirement: Listas de ilustrações e sumário

Cada lista opcional SHALL listar os elementos do respectivo kind com prefixo "Figura/Algoritmo/Código/Quadro/Tabela/Equação – ", entrada em link, e quebra para ímpar em modo impressão. O sumário SHALL ter profundidade 3, entradas de nível 1 em negrito, "Referências" em maiúsculas, entradas de apêndice/anexo com rótulo alfabético, e níveis 2/3 de apêndices omitidos.

#### Scenario: Lista de figuras ativada
- **WHEN** `incluir-lista-figuras: true`
- **THEN** todas as figuras (kind image) aparecem numeradas com link para a página

#### Scenario: Sumário com apêndice
- **WHEN** o corpo contém `#apendice` com seções
- **THEN** o sumário mostra "Apêndice A – Título" no nível 1 e omite suas subseções

### Requirement: Estado global de configuração

O template SHALL registrar titulo, autor, orientador, curso, cidade, ano (derivado de `data-banca`) e modo `versao-impressao` em um estado global, exposto via getters (`get-autor`, `get-titulo`, `get-ano`, etc.) reutilizáveis no texto. Getters SHALL retornar valor original (sem upper); upper é aplicado apenas na renderização.

#### Scenario: Uso no texto
- **WHEN** o autor escreve `#get-autor()` no corpo
- **THEN** é inserido o nome informado em `template` sem transformação de caixa

### Requirement: Início de elementos no anverso no modo impressão

Quando `versao-impressao: true`, cada elemento pré-textual SHALL iniciar no anverso (página física ímpar): capa, folha de rosto, errata, folha de aprovação, dedicatória, agradecimentos, epígrafe, resumo, abstract, cada lista e o sumário. A ficha catalográfica SHALL ocupar o verso da folha de rosto, sem quebra ímpar entre os dois.

#### Scenario: Folha de rosto em anverso
- **WHEN** `versao-impressao: true`
- **THEN** a capa ocupa o anverso da primeira folha e a folha de rosto inicia no anverso da folha seguinte (com o verso da capa em branco)

#### Scenario: Ficha no verso da folha de rosto
- **WHEN** `versao-impressao: true` e `ficha-catalografica` é fornecido
- **THEN** a ficha catalográfica é impressa no verso da folha de rosto

#### Scenario: Dedicatória e epígrafe em anverso
- **WHEN** `versao-impressao: true` e dedicatória/epígrafe são fornecidas
- **THEN** cada uma inicia no anverso, em folha própria

#### Scenario: Modo digital inalterado
- **WHEN** `versao-impressao: false`
- **THEN** os elementos fluem em páginas consecutivas sem páginas em branco intercaladas

#### Scenario: Abstract em folha própria
- **WHEN** resumo e abstract são fornecidos
- **THEN** cada um ocupa folha própria (o abstract não usa o verso da folha do resumo)

### Requirement: Nomes de parâmetros em pt-BR

O sistema SHALL expor apenas nomes em pt-BR: `titulo`, `autor`, `orientador`, `co-orientador`, `instituicao`, `curso`, `local`, `data-banca`, `logo`, `ficha-catalografica`, `errata`, `texto-aprovacao`, `banca`, `dedicatoria`, `agradecimentos`, `epigrafe`, `resumo-conteudo`, `resumo-palavras`, `abstract-conteudo`, `abstract-palavras`, `versao-impressao`, `codly-habilitado`, `bibliografia`, `referencias-titulo`, `cor-links`.

#### Scenario: Uso com nomes antigos falha
- **WHEN** o usuário passa `catalog-card` ou `print` ou `ano`
- **THEN** o sistema SHALL falhar indicando parâmetro desconhecido
