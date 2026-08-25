## 1. Estrutura e introdução

- [x] 1.1 Criar `README.md` na raiz com título, badges/links (Typst, Tinymist) e sumário navegável e verificar preview Markdown renderiza sem quebras
- [x] 1.2 Escrever seção "O que é" (IFBA SAJ ADS, ABNT NBR 14724/10520:2023/6023, compiler 0.15.1, link para `typst.toml`) e verificar que contém todas as infos do spec

## 2. Pré-requisitos e instalação

- [x] 2.1 Documentar instalação do Typst (winget/scoop/cargo/instalador/typst.app) com verificação `typst --version` e verificar comandos copiáveis funcionam em Windows
- [x] 2.2 Documentar VS Code + Tinymist (obrigatória) e PlantUML (opcional), referenciando `.vscode/extensions.json`, e verificar extensões listadas corretamente
- [x] 2.3 Documentar alternativa sem VS Code (CLI `typst compile`/`watch`, Typst App) e verificar instrução permite compilar sem IDE

## 3. Como começar

- [x] 3.1 Documentar clonar / "Use this template", abrir `example/main.typ` e compilar (preview Tinymist + `typst compile example/main.typ`) e verificar passos levam a PDF gerado

## 4. O que preencher (template)

- [x] 4.1 Criar tabela de parâmetros de `template.with(...)` agrupada (obrigatórios, identidade, opcionais ABNT, resumos, flags) incluindo tipos de `catalog-card`/`approval-text` (str vs content) e verificar tabela cobre todos os params de `src/pre-textual.typ:template()`
- [x] 4.2 Adicionar exemplo mínimo copiável de `template.with(...)` e verificar que compila ao colar em `example/main.typ`

## 5. Guia rápido de escrita

- [x] 5.1 Documentar elementos com snippets copiáveis (figura/tabela/quadro/codigo/algoritmo/equacao/diagram) e verificar snippets referenciam `example/main.typ` e `lib.typ`
- [x] 5.2 Documentar citações ABNT (cite/prose/citacao-curta/citacao-longa + supplement) e glossário/abreviaturas/apêndices/anexos e verificar exemplos seguem NBR 10520:2023 e `src/bibliography.typ`/`src/gloss.typ`

## 6. Compilação, estrutura e troubleshooting

- [x] 6.1 Documentar `print: false/true` (digital vs impressão), estrutura de pastas (`src/`, `lib.typ`, `example/assets/`, `typst.toml`) e verificar descrição bate com árvore real
- [x] 6.2 Adicionar FAQ/troubleshooting (versão incompatível, bibliografia não aparece, preview não atualiza) e verificar cada item tem causa e solução
- [x] 6.3 Validar `openspec validate --strict` passa e revisão final do README sem links quebrados
