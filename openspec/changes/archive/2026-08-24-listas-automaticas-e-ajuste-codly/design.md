## Context

Ver `proposal.md` para motivação e escopo. Atualmente, `src/pre-textual.typ` possui flags booleanas (`incluir-lista-figuras`, etc.) e chama manualmente `lista-abreviaturas()`. O codly em `src/code-algo.typ` precisa de ajustes finos de espaçamento de linha e alinhamento de bloco.

## Goals / Non-Goals

**Goals:**
- Automatizar a geração de todas as listas pré-textuais via `query` do Typst, exibindo-as condicionalmente apenas quando houver elementos no documento e na ordem exata da ABNT.
- Ajustar a macro `codigo` e a inicialização do `codly` para garantir blocos centralizados, texto à esquerda, numeração de linha e espaçamento vertical compacto.

**Non-Goals:**
- Alterar o comportamento da numeração de capítulos ou do sumário principal.

## Decisions

- **Lista automática baseada em query**: Substituir flags booleanas manuais no template por verificações via `query(figure.where(...))` e checagem de tamanho do `_abbrev-state.final()`.
- **Ordem das Listas ABNT**: Figuras -> Quadros -> Tabelas -> Códigos -> Algoritmos -> Equações -> Abreviaturas e Siglas -> Sumário.
- **Formatação Codly**: Configurar `codly` com fontes monoespaçadas, `display-line-numbers: true` e `leading` ajustado (ex: `0.6em`), envolvendo a figura em container com alinhamento esquerdo interno e bloco centralizado.

## Risks / Trade-offs

- [Desempenho de Query] → Typst gerencia consultas globais de forma eficiente em documentos do tamanho de um TCC; sem impacto perceptível.
