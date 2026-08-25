## Why

A tabela de parâmetros do README e a assinatura de `template()` misturam inglês e português e marcam como opcionais elementos que a NBR 14724 define como obrigatórios. Como ABNT é fonte da verdade e o sistema ainda não foi usado (sem usuários em produção), é o momento de normalizar tudo para pt-BR e alinhar obrigatoriedade, sem necessidade de aliases/depreciação.

## What Changes

- **BREAKING** Renomear parâmetros de `template()` para pt-BR (corte seco, sem aliases):
  - `catalog-card` → `ficha-catalografica`
  - `approval-text` → `texto-aprovacao`
  - `committee` → `banca`
  - `dedication` → `dedicatoria`
  - `acknowledgments` → `agradecimentos`
  - `epigraph` → `epigrafe`
  - `print` → `versao-impressao`
  - Manter `codly-habilitado` como está (nome do pacote) mas com default `true`.
- **BREAKING** Tornar obrigatórios (B1) os parâmetros que a ABNT exige: `ficha-catalografica`, `texto-aprovacao` (+ `banca` quando aplicável), `resumo-conteudo`/`resumo-palavras`, `abstract-conteudo`/`abstract-palavras`, `bibliografia`/`referencias`. Falha explícita se ausentes.
- Manter com default (não obrigatórios): `logo`, `instituicao`, `curso`, `local`.
- `descricao` (preâmbulo) deixa de ser preenchido manualmente e passa a ser gerado automaticamente de forma parametrizada a partir de `instituicao`/`curso`/`local`, resultando em: "Trabalho de Conclusão de Curso apresentado ao Instituto Federal de Educação, Ciência e Tecnologia da Bahia, campus Santo Antônio de Jesus, como requisito parcial para obtenção do grau de Tecnólogo em Análise e Desenvolvimento de Sistemas."
- Atualizar `example/main.typ`, `src/pre-textual.typ`, `README.md` e specs afetadas.

## Capabilities

### New Capabilities
<!-- nenhuma capability nova -->

### Modified Capabilities
- `pre-textuais`: assinatura de `template()`, obrigatoriedade ABNT, geração automática do preâmbulo e defaults alterados.
- `repo-readme`: tabela de parâmetros e exemplos refletem novos nomes e obrigatoriedade ABNT.

## Impact

- **BREAKING** para quem já usa `template.with(...)` com nomes antigos — sem aliases. Aceitável pois sistema nunca foi usado em produção.
- Código: `src/pre-textual.typ`, `example/main.typ`, `README.md`.
- Specs: `openspec/specs/pre-textuais/spec.md` e `openspec/specs/repo-readme/spec.md` (criado na change anterior).
