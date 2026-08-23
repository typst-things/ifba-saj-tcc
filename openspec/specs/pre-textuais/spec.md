## Purpose

Elementos pré-textuais na ordem ABNT/NBR 14724, gerenciados pelo `template` (src/pre-textual.typ).

## Requirements

### Requirement: Ordem dos elementos pré-textuais

O template SHALL emitir, nesta ordem: capa, folha de rosto, ficha catalográfica (opcional), errata (opcional), folha de aprovação (opcional), dedicatória (opcional), agradecimentos (opcional), epígrafe (opcional), resumo (opcional), abstract (opcional), listas de figuras/algoritmos/códigos/quadros/tabelas/equações (opcionais), sumário — seguidos do corpo.

#### Scenario: Documento completo
- **WHEN** todos os parâmetros opcionais são fornecidos
- **THEN** os elementos aparecem na ordem acima, cada um em página própria

### Requirement: Capa

A capa SHALL exibir centrado: logotipo (ou placeholder), nome da instituição, autor (maiúsculas), título em negrito, local e ano, com espaçamentos verticais definidos.

#### Scenario: Capa sem logo customizado
- **WHEN** `logo: none`
- **THEN** é renderizado um placeholder "LOGOTIPO IFBA" tracejado

### Requirement: Folha de rosto

A folha de rosto SHALL exibir autor, título em negrito e, à direita da página em bloco justificado, o preâmbulo (descrição do trabalho, padrão para TCC de ADS do IFBA SAJ quando `descricao: none`), seguido de orientador e coorientador (se houver), local e ano.

#### Scenario: Preenchimento automático do preâmbulo
- **WHEN** `descricao: none`
- **THEN** o preâmbulo padrão do curso ADS/IFBA SAJ é usado, com o nome do curso em itálico

### Requirement: Ficha catalográfica

Quando `catalog-card` é fornecido (caminho de imagem ou conteúdo), o sistema SHALL renderizá-lo em página própria, sem margens nem cabeçalho; quando none, a página é omitida.

#### Scenario: Ficha em PDF
- **WHEN** `catalog-card` é caminho para um PDF
- **THEN** a imagem é embutida ocupando 100% da página sem cabeçalho/rodapé

### Requirement: Folha de aprovação

Quando `approval-text` é fornecido, o sistema SHALL renderizar o texto de aprovação seguido de linhas de assinatura para cada membro de `committee`; se for caminho de imagem/str, renderiza a imagem em página inteira.

#### Scenario: Banca com 5 membros
- **WHEN** `committee` tem 5 membros
- **THEN** são exibidas 5 linhas de assinatura com os respectivos nomes/instituições

### Requirement: Resumo e abstract

Resumo e abstract SHALL ser renderizados com título centralizado sem numeração, texto em espaçamento simples, seguidos de "Palavras-chave:"/"Keywords:" joined por ponto.

#### Scenario: Resumo com palavras-chave
- **WHEN** `resumo-palavras` é não vazio
- **THEN** a linha "Palavras-chave: a. b. c." aparece após o texto do resumo

### Requirement: Listas de ilustrações e sumário

Cada lista opcional SHALL listar os elementos do respectivo kind com prefixo "Figura/Algoritmo/Código/Quadro/Tabela/Equação – ", entrada em link, e quebra para ímpar em modo impressão. O sumário SHALL ter profundidade 3, entradas de nível 1 em negrito, "Referências" em maiúsculas, entradas de apêndice/anexo com rótulo alfabético, e níveis 2/3 de apêndices omitidos.

#### Scenario: Lista de figuras ativada
- **WHEN** `incluir-lista-figuras: true`
- **THEN** todas as figuras (kind image) aparecem numeradas com link para a página

#### Scenario: Sumário com apêndice
- **WHEN** o corpo contém `#apendice` com seções
- **THEN** o sumário mostra "Apêndice A – Título" no nível 1 e omite suas subseções

### Requirement: Estado global de configuração

O template SHALL registrar titulo, autor, orientador, curso, cidade, ano e modo print em um estado global, exposto via getters (`get-autor`, `get-titulo`, `get-ano`, etc.) reutilizáveis no texto.

#### Scenario: Uso no texto
- **WHEN** o autor escreve `#get-autor()` no corpo
- **THEN** é inserido o nome informado em `template`

### Requirement: Início de elementos no anverso no modo impressão

Quando `print: true`, cada elemento pré-textual SHALL iniciar no anverso (página física ímpar): capa, folha de rosto, errata, folha de aprovação, dedicatória, agradecimentos, epígrafe, resumo, abstract, cada lista e o sumário. A ficha catalográfica, quando presente, SHALL ocupar o **verso da folha de rosto**, sem quebra ímpar entre os dois.

#### Scenario: Folha de rosto em anverso
- **WHEN** `print: true`
- **THEN** a capa ocupa o anverso da primeira folha e a folha de rosto inicia no anverso da folha seguinte (com o verso da capa em branco)

#### Scenario: Ficha no verso da folha de rosto
- **WHEN** `print: true` e `catalog-card` é fornecido
- **THEN** a ficha catalográfica é impressa no verso da folha de rosto

#### Scenario: Dedicatória e epígrafe em anverso
- **WHEN** `print: true` e dedicatória/epígrafe são fornecidas
- **THEN** cada uma inicia no anverso, em folha própria

#### Scenario: Modo digital inalterado
- **WHEN** `print: false`
- **THEN** os elementos fluem em páginas consecutivas sem páginas em branco intercaladas

#### Scenario: Abstract em folha própria
- **WHEN** resumo e abstract são fornecidos
- **THEN** cada um ocupa folha própria (o abstract não usa o verso da folha do resumo)