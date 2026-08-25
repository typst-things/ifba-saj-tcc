## Purpose

Documentação de uso do repositório para o aluno: instalação de pré-requisitos, configuração do template e guia rápido de escrita ABNT no Typst.

## ADDED Requirements

### Requirement: README cobre o que é o projeto
O README SHALL apresentar em pt-BR o que é o repositório, a que se destina (TCC ABNT IFBA SAJ ADS), normas atendidas e versão do Typst.

#### Scenario: Leitor identifica o propósito
- **WHEN** o aluno abre o README na raiz
- **THEN** encontra seção introdutória explicando que é modelo ABNT (NBR 14724, NBR 10520:2023, NBR 6023), curso/campus e compiler pinado (0.15.1).

### Requirement: README lista pré-requisitos e instalação passo a passo
O README SHALL listar pré-requisitos e instruções de instalação para Typst, VS Code e plugins recomendados, com alternativa CLI sem VS Code.

#### Scenario: Aluno instala do zero no Windows
- **WHEN** segue a seção de instalação
- **THEN** consegue instalar Typst (winget/scoop/instalador ou typst.app), instalar VS Code, instalar extensão Tinymist (obrigatória) e PlantUML (opcional), e verificar com `typst --version`.

#### Scenario: Aluno sem VS Code
- **WHEN** não quer usar VS Code
- **THEN** encontra instrução alternativa de compilação/preview via CLI (`typst compile` / `typst watch`) ou Typst App.

### Requirement: README explica como começar a partir do exemplo
O README SHALL explicar como clonar/usar como template, abrir `example/main.typ` e compilar o documento.

#### Scenario: Primeiro build
- **WHEN** o aluno clona o repo e abre `example/main.typ` no VS Code com Tinymist
- **THEN** o README indica onde clicar para preview e o comando CLI equivalente (`typst compile example/main.typ`), e onde está o PDF gerado.

### Requirement: README documenta o que preencher no template
O README SHALL documentar os parâmetros de `template.with(...)` (obrigatórios vs opcionais) com tabela e exemplos, incluindo tipos aceitos para `catalog-card` e `approval-text`.

#### Scenario: Aluno preenche dados do TCC
- **WHEN** consulta a tabela de parâmetros
- **THEN** identifica obrigatórios (`titulo`, `autor`, `orientador`, `ano`), opcionais de identidade (`instituicao`, `curso`, `local`, `logo`, `descricao`), opcionais ABNT (`catalog-card`, `errata`, `approval-text`+`committee`, `dedication`, `acknowledgments`, `epigraph`), resumos (`resumo-conteudo`/`resumo-palavras`, `abstract-conteudo`/`abstract-palavras`) e flags (`print`, `codly-habilitado`, `bibliografia`), com exemplo mínimo copiável.

### Requirement: README traz guia rápido de escrita
O README SHALL trazer guia rápido de uso dos elementos ABNT do pacote (figuras, tabelas, quadros, códigos, algoritmos, equações, citações, glossário/abreviaturas, apêndices/anexos) com snippets copiáveis.

#### Scenario: Aluno insere figura com referência cruzada
- **WHEN** segue o snippet de `#figura` + label `<...>` + `@...`
- **THEN** consegue inserir e referenciar figura corretamente.

#### Scenario: Aluno usa citações ABNT
- **WHEN** consulta a seção de citações
- **THEN** encontra exemplos de `#cite`, `#prose`, `#citacao-curta`/`#citacao-longa` e `supplement: [p. ...]` conforme NBR 10520:2023.

### Requirement: README explica compilação digital vs impressão e estrutura de pastas
O README SHALL explicar `print: false/true`, efeito nas margens/paginação, e a estrutura de pastas (`src/`, `lib.typ`, `example/`, `example/assets/`, `typst.toml`).

#### Scenario: Gerar versão para impressão
- **WHEN** o aluno troca `print: false` para `true`
- **THEN** entende a diferença e recompila para obter a variante de impressão.

### Requirement: README inclui troubleshooting curto
O README SHALL incluir seção de dúvidas frequentes / troubleshooting com problemas comuns e solução.

#### Scenario: Erro de versão do Typst
- **WHEN** a compilação falha por incompatibilidade de versão
- **THEN** o FAQ indica verificar `typst --version` vs `0.15.1` em `typst.toml` e como atualizar/downgrade.

