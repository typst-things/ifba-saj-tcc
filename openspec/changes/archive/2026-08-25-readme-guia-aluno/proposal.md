## Why

O repositório `ifba-saj-tcc` não possui README. O aluno que clona o projeto não tem instruções de pré-requisitos, instalação (Typst, VS Code, plugins), nem sabe quais informações devem ser preenchidas no template. Isso gera fricção na adoção e dúvidas repetidas.

## What Changes

- Criar `README.md` na raiz do repositório, em pt-BR, cobrindo:
  - O que é o projeto (modelo ABNT IFBA SAJ ADS, NBR 14724/10520:2023/6023, Typst 0.15.1).
  - Pré-requisitos e instalação passo a passo: Typst, VS Code, extensões Tinymist (+ PlantUML opcional), alternativa CLI sem VS Code.
  - Como começar: clonar / "Use this template", abrir `example/main.typ`, compilar (preview Tinymist e `typst compile`/`watch`).
  - O que preencher: tabela de parâmetros de `template.with(...)` (obrigatórios vs opcionais) com exemplos.
  - Como escrever o TCC: elementos (`figura`, `tabela`, `quadro`, `codigo`, `algoritmo`, `equacao`), citações ABNT, glossário/abreviaturas, apêndices/anexos.
  - Compilação digital vs impressão (`print: false/true`) e estrutura de pastas.
  - Troubleshooting / FAQ curto.
- Adicionar badges/links úteis (Typst, Tinymist) quando pertinente.

## Capabilities

### New Capabilities
- `repo-readme`: Documentação de uso do repositório para o aluno (instalação, configuração do template e guia rápido de escrita ABNT).

### Modified Capabilities
<!-- Nenhuma capability existente alterada em nível de REQUIREMENTS - é documentação pura -->

## Impact

- Apenas documentação (`README.md`); nenhum código Typst (`src/*.typ`, `lib.typ`, `typst.toml`) é alterado.
- Impacto em onboarding de novos alunos e redução de suporte repetitivo.
