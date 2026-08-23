## Purpose

Garante que o template gere automaticamente todas as listas pré-textuais exigidas pela ABNT com base nos elementos inseridos no documento, mantendo a ordem normativa correta antes do Sumário, e padronize a exibição de blocos de código com codly (centralizados, alinhados à esquerda, com numeração de linha e espaçamento adequado).

## ADDED Requirements

### Requirement: Automatic Pre-textual Lists
The template SHALL inspect the document for figures, frames, tables, code blocks, algorithms, equations, and abbreviations, and generate the corresponding pre-textual lists automatically in strict ABNT order before the Table of Contents (Sumário) only when items are present.

#### Scenario: Lists generated when elements are present
- **WHEN** the user inserts figures, tables, or abbreviations (`#abbrev`) in the document body
- **THEN** the respective lists appear automatically in the pre-textual section before the Sumário without requiring manual list calls.

### Requirement: Code Display Styling
The template SHALL format code blocks (`codigo` and `codly`) such that the container figure is centered on the page, the internal text is strictly left-aligned, mono-spaced font and line numbers are enabled, and vertical spacing (`leading`) is optimized for source code readability.

#### Scenario: Code block layout rendering
- **WHEN** a code block or algorithm is rendered in the document
- **THEN** it displays with a centered figure container, left-aligned code text, line numbers, and reduced line spacing compared to normal prose.
