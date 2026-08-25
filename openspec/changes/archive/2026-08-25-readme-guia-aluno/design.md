## Context

O repo não tem README. O template está em `src/pre-textual.typ:template()` e o exemplo canônico em `example/main.typ` (importa `../lib.typ`, `typst.toml` pinning `0.15.1`). VS Code já recomenda `myriad-dreamin.tinymist` e `jebbs.plantuml` em `.vscode/extensions.json`. Ver proposta para motivação.

## Goals / Non-Goals

**Goals:**
- README único em `README.md` (pt-BR) que permita ao aluno sair do zero até o primeiro PDF sem ajuda externa.
- Cobrir instalação cross-platform com foco Windows, sem duplicar docs externos.
- Documentar contrato de `template.with(...)` de forma tabular e copiável.

**Non-Goals:**
- Alterar código Typst (`src/`, `lib.typ`, `typst.toml`).
- Tutorial completo de Typst/ABNT — apenas guia rápido com links para docs oficiais.
- Tradução EN do README (pode vir em change futura).
- Automação de setup (scripts/installers).

## Decisions

- **README único vs docs/ separado**: README único — menor fricção; aluno encontra tudo na raiz. Alternativa `docs/` considerada e descartada por dispersar leitura inicial.
- **Foco Windows + colapsáveis Linux/macOS**: público majoritário usa labs Windows; detalhes Unix em `<details>` para não poluir.
- **Tabela de parâmetros agrupada por categoria** (obrigatórios / identidade / opcionais ABNT / resumos / flags) em vez de lista alfabética — facilita preenchimento incremental. Alternativa alfabética descartada por pior UX.
- **Snippets copiáveis mínimos**: cada elemento ABNT com 3–6 linhas, referenciando `example/main.typ` como fonte da verdade. Evita divergência.
- **Instruções de instalação via winget/scoop + fallback instalador/typst.app**: cobre máquinas gerenciadas sem privilégio de package manager.

## Risks / Trade-offs

- **Desatualização do README quando `template()` mudar** → Mitigação: referenciar `example/main.typ` como canônico e instruir validar `typst --version` vs `typst.toml:compiler`.
- **README longo assusta** → Mitigação: sumário no topo, seções colapsáveis, tabela resumida + exemplo mínimo.
- **PlantUML opcional confunde** → Mitigação: marcar claramente como opcional e só para diagramas.

## Migration Plan

- Criar `README.md` na raiz; nenhum migration/rollback de código. Validação: `openspec validate --strict` e revisão manual do preview Markdown.

## Open Questions

- Publicação futura em `@preview` mudará instrução de import (`@local` vs `@preview`) — deixar nota de que `example/main.typ` atual usa import relativo para dev local.
