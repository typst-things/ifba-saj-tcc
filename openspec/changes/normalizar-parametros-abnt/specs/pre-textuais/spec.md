## MODIFIED Requirements

### Requirement: Ordem dos elementos pré-textuais

O template SHALL emitir, nesta ordem: capa, folha de rosto, ficha catalográfica, errata (opcional), folha de aprovação, dedicatória (opcional), agradecimentos (opcional), epígrafe (opcional), resumo, abstract, listas de figuras/algoritmos/códigos/quadros/tabelas/equações (opcionais), sumário — seguidos do corpo. Ficha catalográfica, folha de aprovação, resumo e abstract são obrigatórios (ABNT fonte da verdade).

#### Scenario: Documento completo
- **WHEN** todos os parâmetros são fornecidos
- **THEN** os elementos aparecem na ordem acima, cada um em página própria

#### Scenario: Falta elemento obrigatório
- **WHEN** `ficha-catalografica`, `texto-aprovacao`, `resumo-conteudo`/`resumo-palavras`, `abstract-conteudo`/`abstract-palavras` ou `bibliografia` não são fornecidos
- **THEN** o sistema SHALL falhar com mensagem indicando o parâmetro obrigatório ausente

### Requirement: Folha de rosto

A folha de rosto SHALL exibir autor, título em negrito e, à direita da página em bloco justificado, o preâmbulo gerado automaticamente de forma parametrizada a partir de `instituicao`/`curso`/`local` (sem parâmetro `descricao` manual), seguido de orientador e coorientador (se houver), local e ano. O texto parametrizado SHALL ser: "Trabalho de Conclusão de Curso apresentado ao Instituto Federal de Educação, Ciência e Tecnologia da Bahia, campus Santo Antônio de Jesus, como requisito parcial para obtenção do grau de Tecnólogo em Análise e Desenvolvimento de Sistemas."

#### Scenario: Preenchimento automático do preâmbulo
- **WHEN** o preâmbulo parametrizado é gerado
- **THEN** o texto contém o nome do curso em destaque e reflete `instituicao`/`curso`/`local`

#### Scenario: Preâmbulo parametrizado
- **WHEN** o template é invocado sem `descricao`
- **THEN** o preâmbulo é gerado automaticamente com o texto parametrizado acima

### Requirement: Ficha catalográfica

Quando `ficha-catalografica` é fornecido (caminho de imagem ou conteúdo), o sistema SHALL renderizá-lo em página própria, sem margens nem cabeçalho. O parâmetro `ficha-catalografica` é obrigatório (ABNT); ausência SHALL causar falha.

#### Scenario: Ficha em PDF
- **WHEN** `ficha-catalografica` é caminho para um PDF
- **THEN** a imagem é embutida ocupando 100% da página sem cabeçalho/rodapé

#### Scenario: Ficha ausente
- **WHEN** `ficha-catalografica` é `none`
- **THEN** a compilação falha indicando obrigatoriedade ABNT

### Requirement: Folha de aprovação

O sistema SHALL renderizar `texto-aprovacao` seguido de linhas de assinatura para cada membro de `banca`; se `texto-aprovacao` for caminho de imagem/str, renderiza a imagem em página inteira. `texto-aprovacao` e `banca` são obrigatórios.

#### Scenario: Banca com 5 membros
- **WHEN** `banca` tem 5 membros
- **THEN** são exibidas 5 linhas de assinatura com os respectivos nomes/instituições

#### Scenario: Folha de aprovação ausente
- **WHEN** `texto-aprovacao` é `none`
- **THEN** a compilação falha

### Requirement: Resumo e abstract

Resumo e abstract SHALL ser renderizados com título centralizado sem numeração, texto em espaçamento simples, seguidos de "Palavras-chave:"/"Keywords:" joined por ponto. `resumo-conteudo`, `resumo-palavras`, `abstract-conteudo`, `abstract-palavras` e `bibliografia` são obrigatórios.

#### Scenario: Resumo com palavras-chave
- **WHEN** `resumo-palavras` é não vazio
- **THEN** a linha "Palavras-chave: a. b. c." aparece após o texto do resumo

#### Scenario: Resumo ausente
- **WHEN** `resumo-conteudo` é `none`
- **THEN** a compilação falha

### Requirement: Estado global de configuração

O template SHALL registrar titulo, autor, orientador, curso, cidade, ano e modo `versao-impressao` em um estado global, exposto via getters (`get-autor`, `get-titulo`, `get-ano`, etc.) reutilizáveis no texto.

#### Scenario: Uso no texto
- **WHEN** o autor escreve `#get-autor()` no corpo
- **THEN** é inserido o nome informado em `template`

### Requirement: Início de elementos no anverso no modo impressão

Quando `versao-impressao: true`, cada elemento pré-textual SHALL iniciar no anverso (página física ímpar): capa, folha de rosto, errata, folha de aprovação, dedicatória, agradecimentos, epígrafe, resumo, abstract, cada lista e o sumário. A ficha catalográfica, quando presente, SHALL ocupar o verso da folha de rosto, sem quebra ímpar entre os dois. `codly-habilitado` SHALL ter default `true`.

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

#### Scenario: Codly habilitado por padrão
- **WHEN** `codly-habilitado` não é informado
- **THEN** blocos de código são renderizados com highlight (default true)

## REMOVED Requirements

### Requirement: Parâmetros em inglês
**Reason**: Normalização para pt-BR (A1), ABNT fonte da verdade, sistema sem usuários em produção.
**Migration**: Renomear no `template.with(...)`: `catalog-card`→`ficha-catalografica`, `approval-text`→`texto-aprovacao`, `committee`→`banca`, `dedication`→`dedicatoria`, `acknowledgments`→`agradecimentos`, `epigraph`→`epigrafe`, `print`→`versao-impressao`; remover `descricao` (agora gerado).

## ADDED Requirements

### Requirement: Nomes de parâmetros em pt-BR
O sistema SHALL expor apenas nomes em pt-BR: `titulo`, `autor`, `orientador`, `co-orientador`, `instituicao`, `curso`, `local`, `ano`, `logo`, `ficha-catalografica`, `errata`, `texto-aprovacao`, `banca`, `dedicatoria`, `agradecimentos`, `epigrafe`, `resumo-conteudo`, `resumo-palavras`, `abstract-conteudo`, `abstract-palavras`, `versao-impressao`, `codly-habilitado`, `bibliografia`, `referencias-titulo`, `cor-links`.

#### Scenario: Uso com nomes antigos falha
- **WHEN** o usuário passa `catalog-card` ou `print`
- **THEN** o sistema SHALL falhar indicando parâmetro desconhecido e sugerindo o novo nome
