## Purpose

Documentação de uso do repositório para o aluno: instalação, configuração do template e guia rápido ABNT, com parâmetros normalizados para pt-BR e obrigatoriedade alinhada à ABNT.

## ADDED Requirements

### Requirement: README reflete parâmetros em pt-BR e obrigatoriedade ABNT
O README SHALL listar a tabela de `template.with(...)` apenas com nomes em pt-BR e coluna de obrigatoriedade alinhada à ABNT (fonte da verdade), sem manter nomes em inglês.

#### Scenario: Leitor consulta tabela
- **WHEN** abre a seção "O que preencher"
- **THEN** vê apenas `ficha-catalografica`, `texto-aprovacao`, `banca`, `dedicatoria`, `agradecimentos`, `epigrafe`, `versao-impressao`, `codly-habilitado` (default true), e obrigatórios ABNT marcados como **sim** (`ficha-catalografica`, `texto-aprovacao`/`banca`, `resumo-*`, `abstract-*`, `bibliografia`).

#### Scenario: Exemplo mínimo usa novos nomes
- **WHEN** copia o exemplo mínimo
- **THEN** o snippet usa `versao-impressao` e `ficha-catalografica`/`texto-aprovacao` e compila sem parâmetros em inglês.

### Requirement: README documenta preâmbulo parametrizado
O README SHALL explicar que `descricao` não é mais parâmetro manual e que o preâmbulo é gerado automaticamente, exibindo o texto parametrizado final.

#### Scenario: Aluno procura como preencher preâmbulo
- **WHEN** lê a documentação do preâmbulo
- **THEN** encontra o texto "Trabalho de Conclusão de Curso apresentado ao Instituto Federal de Educação, Ciência e Tecnologia da Bahia, campus Santo Antônio de Jesus, como requisito parcial para obtenção do grau de Tecnólogo em Análise e Desenvolvimento de Sistemas." e entende que não precisa preencher `descricao`.

