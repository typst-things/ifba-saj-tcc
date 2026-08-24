## Why

Atualmente, o template de TCC do IFBA/ADS em Typst exige que o autor adicione manualmente chamadas de listas pré-textuais e não aplica formatação otimizada para blocos de código (codly) em relação a espaçamento entre linhas e alinhamento esquerdo do conteúdo. Tornar as listas automáticas (conforme a presença de elementos no texto e estritamente na ordem ABNT) e padronizar a exibição de códigos melhora a conformidade normativa e a experiência visual do documento final.

## What Changes

- **Listas Pré-Textuais Automáticas**: Inspecionar via query do Typst a existência de figuras, quadros, tabelas, códigos, algoritmos, equações e abreviaturas (`#abbrev`), gerando automaticamente as respectivas listas apenas quando houver itens, seguindo rigorosamente a ordem da ABNT antes do Sumário.
- **Ajuste de Exibição de Código (Codly)**: Configurar o bloco de código centralizado com texto alinhado à esquerda, fonte monoespaçada legível, numeração de linha e espaçamento vertical reduzido (`leading` ajustado).

## Capabilities

### New Capabilities
- `tcc-lists-and-codly`: Automação das listas pré-textuais e padronização visual de códigos-fonte com codly.

### Modified Capabilities
- (Nenhuma)

## Impact

- Afeta `src/pre-textual.typ`, `src/code-algo.typ` e `src/layout.typ`.
- Nenhuma dependência externa nova necessária (utiliza codly já existente).
- Documentos existentes passam a exibir listas de forma automática sem alterar a sintaxe dos capítulos do usuário.
