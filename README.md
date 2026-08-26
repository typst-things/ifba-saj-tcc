# ifba-saj-tcc — Modelo ABNT para TCC do IFBA SAJ (ADS)

[![Typst](https://img.shields.io/badge/Typst-0.15.1-239DAD?logo=typst)](https://typst.app) [![Tinymist](https://img.shields.io/badge/VS%20Code-Tinymist-007ACC?logo=visualstudiocode)](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Modelo ABNT para Trabalho de Conclusão de Curso do **IFBA — campus Santo Antônio de Jesus**, curso **Análise e Desenvolvimento de Sistemas (ADS)**, implementado como pacote [Typst](https://typst.app). Atende às normas **NBR 14724**, **NBR 10520:2023** e **NBR 6023**.

> **Compiler pinado:** `0.15.1` (ver `typst.toml:compiler`). Use a mesma versão para evitar incompatibilidades.

## Sumário

- [O que é](#o-que-é)
- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Alternativa sem VS Code](#alternativa-sem-vs-code)
- [Como começar](#como-começar)
- [O que preencher — `template.with(...)`](#o-que-preencher--templatewith)
- [Escrevendo seu TCC](#escrevendo-seu-tcc)
- [Compilação — digital vs impressão](#compilação--digital-vs-impressão)
- [Estrutura de pastas](#estrutura-de-pastas)
- [FAQ / Troubleshooting](#faq--troubleshooting)

## O que é

- Pacote Typst (`lib.typ` como entrypoint) que formata automaticamente capa, folha de rosto, ficha catalográfica, errata, folha de aprovação, dedicatória, agradecimentos, epígrafe, resumos, listas automáticas (figuras, quadros, tabelas, códigos, algoritmos, equações, abreviaturas) e sumário conforme ABNT.
- Exemplo completo e compilável em `example/main.typ` (variantes digital e impressão).
- Dependências `@preview`: `codly`, `codly-languages`, `cetz`, `cetz-plot`.

## Pré-requisitos

- **Typst 0.15.1** — ver [Instalação](#instalação).
- **VS Code** (recomendado) + extensão **Tinymist** (obrigatória) — preview ao vivo, autocompletar e diagnóstico. Extensão **PlantUML** (`jebbs.plantuml`) é opcional, apenas se usar diagramas PlantUML.
- Git (para clonar).

> As extensões recomendadas já estão em `.vscode/extensions.json` — o VS Code sugere instalá-las automaticamente ao abrir o projeto.

## Instalação

### 1. Typst

Escolha uma opção:

```powershell
# Windows — winget
winget install --id Typst.Typst

# Windows — scoop
scoop install typst

# Rust toolchain (qualquer SO)
cargo install --locked typst-cli

# Ou baixe o instalador em https://github.com/typst/typst/releases
# Ou use o app web https://typst.app (sem instalação local)
```

Verifique:

```powershell
typst --version
# deve mostrar 0.15.1
```

> Se a versão divergir de `typst.toml:compiler`, atualize/downgrade o Typst para `0.15.1`.

### 2. VS Code + Tinymist

1. Instale o [VS Code](https://code.visualstudio.com/).
2. Abra a pasta do projeto — aceite instalar as extensões recomendadas, ou instale manualmente:
   - `myriad-dreamin.tinymist` (obrigatória)
   - `jebbs.plantuml` (opcional)
3. Abra `example/main.typ` — o preview do Tinymist aparece automaticamente.

<details>
<summary>Linux / macOS</summary>

```bash
# macOS — Homebrew
brew install typst

# Linux — cargo ou binário do GitHub Releases
cargo install --locked typst-cli
typst --version
```

VS Code e Tinymist funcionam da mesma forma em Linux/macOS.

</details>

## Alternativa sem VS Code

Você não precisa do VS Code para compilar:

```powershell
# Compilar uma vez
typst compile example/main.typ

# Watch — recompila a cada salvamento
typst watch example/main.typ

# Saída padrão: example/main.pdf (ou passe o destino)
typst compile example/main.typ saida.pdf
```

Também é possível editar e compilar direto no [Typst App](https://typst.app).

## Como começar

```powershell
# 1. Clonar (ou use "Use this template" no GitHub)
git clone <url-do-repo>
Set-Location ifba-saj-tcc

# 2. Abrir no VS Code
code .

# 3. Abrir example/main.typ — o PDF aparece no preview do Tinymist
# Ou compilar via CLI:
typst compile example/main.typ
```

- O arquivo para editar é `example/main.typ` — ele já contém um TCC de exemplo com todos os recursos.
- Copie a pasta `example/` para começar seu TCC ou edite `main.typ` diretamente.

> **Nota sobre imports:** `example/main.typ` usa `#import "../lib.typ": *` (desenvolvimento local). Quando o pacote for publicado em `@preview`, o import passará a ser `#import "@preview/ifba-saj-tcc:0.1.0": *`.

## O que preencher — `template.with(...)`

Todo o documento é configurado no cabeçalho de `example/main.typ`:

```typst
#show: template.with(
  titulo: "Seu título aqui",
  autor: "Seu Nome",
  orientador: "Prof. Dr. Nome do Orientador",
  data-banca: "04/08/2026",
  // ... demais campos abaixo
)
```

### Tabela de parâmetros

| Parâmetro | Obrigatório | Tipo | Padrão | Descrição |
|---|---|---|---|---|
| `titulo` | **sim** | `str` | — | Título do TCC (capa e folha de rosto). Renderizado em **CAIXA-ALTA** (NBR 14724). |
| `autor` | **sim** | `str` | — | Nome do autor. Renderizado em **CAIXA-ALTA**. |
| `orientador` | **sim** | `str` | — | Nome do orientador (caixa normal, NBR 14724). |
| `data-banca` | **sim** | `str` | — | Data da banca (ex: `"04/08/2026"`). Ano é derivado automaticamente para capa/folha; data completa vai na folha de aprovação. |
| `co-orientador` | não | `str`/`content` | `none` | Co-orientador. |
| `instituicao` | não | `content` | `Instituto Federal de Educação, Ciência e Tecnologia da Bahia` | Instituição na capa. Renderizada em **CAIXA-ALTA**. |
| `curso` | não | `content` | `Análise e Desenvolvimento de Sistemas` | Curso (usado no preâmbulo e folha de aprovação). |
| `local` | não | `str` | `Santo Antônio de Jesus` | Cidade. Renderizada em **CAIXA-ALTA**. |
| `logo` | não | `str`/`content`/`none` | Placeholder tracejado | Logo da capa (`"caminho/logo.png"` ou `image(...)`). |
| `ficha-catalografica` | **sim** | `str`/`content` | — | Ficha catalográfica — `image("assets/ficha.pdf")` ou `"assets/ficha.pdf"`. Gera página no verso da folha de rosto. |
| `errata` | não | `content`/`none` | `none` | Errata (opcional, pós-depósito). |
| `texto-aprovacao` | não | `str`/`content`/`none` | `none` (auto-gerado) | Folha de aprovação. Se `none`, é **gerada automaticamente** a partir de `titulo`/`autor`/`banca`/`local`/`data-banca` (formato ABNT); se `str`, imagem em página cheia; se `content`, usa o fornecido. |
| `banca` | **sim** | `array[content]` | — | Membros da banca. Primeiro é marcado como (Orientador) na versão auto-gerada. |
| `dedicatoria` | não | `content`/`none` | `none` | Dedicatória. |
| `agradecimentos` | não | `content`/`none` | `none` | Agradecimentos. |
| `epigrafe` | não | `content`/`none` | `none` | Epígrafe. |
| `resumo-conteudo` | **sim** | `content` | — | Texto do resumo (pt-BR). |
| `resumo-palavras` | **sim** | `array[str]` | — | Palavras-chave do resumo. |
| `abstract-conteudo` | **sim** | `content` | — | Texto do abstract (EN). |
| `abstract-palavras` | **sim** | `array[str]` | — | Keywords do abstract. |
| `versao-impressao` | não | `bool` | `false` | `false` = digital, `true` = impressão (margens ABNT). |
| `codly-habilitado` | não | `bool` | `true` | Habilita `codly` para blocos de código. |
| `bibliografia` | **sim** | `bytes` | — | `read("referencias.bib")` (BibLaTeX). |
| `referencias-titulo` | não | `str` | `REFERÊNCIAS` | Título da seção de referências. |
| `cor-links` | não | `color` | `_text-color` | Cor dos links. |

> `ficha-catalografica` aceita **caminho** (`str`) ou **conteúdo** (`image(...)`).

> **Preâmbulo e folha de aprovação são gerados automaticamente** (estratégia `let _preamb`): o preâmbulo compõe `"Trabalho de Conclusão de Curso apresentado a #instituicao, campus #local, como requisito parcial para obtenção do grau de Tecnólogo em #curso."` e a folha de aprovação monta nome/título em caixa-alta, parágrafo da banca e `local` + `data-banca` + `Comissão Examinadora` + assinaturas.

### Exemplo mínimo copiável

```typst
#import "../lib.typ": *

#show: template.with(
  titulo: "Meu TCC",
  autor: "João Silva",
  orientador: "Prof. Dr. Maria Souza",
  data-banca: "04/08/2026",
  banca: ([Prof. Me. Fulano - IFBA], [Prof. Dr. Ciclano - IFBA]),
  ficha-catalografica: image("assets/ficha.pdf", width: 100%, height: 100%, fit: "contain"),
  resumo-conteudo: [Resumo do trabalho...],
  resumo-palavras: ("Palavra1", "Palavra2"),
  abstract-conteudo: [Abstract...],
  abstract-palavras: ("Keyword1", "Keyword2"),
  bibliografia: read("referencias.bib"),
)

= Introdução

Seu texto aqui...
```

## Escrevendo seu TCC

API pública reexportada por `lib.typ` — todos os exemplos abaixo têm contrapartida em `example/main.typ`.

### Figuras, tabelas, quadros

```typst
#figura(image("assets/imagens/logo.svg"), caption: [Logotipo IFBA]) <fig-logo>
#tabela(caption: [Métricas], columns: (1fr, 1fr), header: ([A], [B]), ..csv("data/resultados.csv")) <tab-metricas>
#quadro(([Critério], [Opção A], [Modelo], [Relacional]), caption: [Comparativo]) <quad-sgbd>

// Referência cruzada:
Ver @fig-logo e @tab-metricas.
```

### Código e algoritmo

```typst
#codigo(lang: "javascript", caption: [Servidor Express], filename: "server.js", read("assets/codigos/server.js")) <fig-codigo>
#algoritmo(read("assets/algoritmos/busca.alg"), caption: [Busca linear]) <alg-busca>
```

Ativos de exemplo: `example/assets/codigos/server.js`, `example/assets/algoritmos/busca.alg`. Requer `codly-habilitado: true` para syntax highlight.

### Equações e diagramas

```typst
#equacao[$ e^(i pi) + 1 = 0 $] <eq-euler>
#diagram(caption: [Arquitetura], ...) // ver src/diagrams.typ
```

Gráficos: `example/assets/graficos/pizza.typ`, `example/assets/graficos/barras.typ` (via `cetz-plot`).

### Citações ABNT (NBR 10520:2023)

```typst
// Indireta parentética
A arquitetura é amplamente adotada #cite("newman2021").

// Indireta narrativa
Como afirma #prose("martin2008"), o código limpo é essencial.

// Com página
A modularização é defendida #cite("martin2008", supplement: [p. 42]).

// Múltiplas fontes
Estudos apontam convergência #cite("martin2008", "sommerville2011").

// Direta curta (até 3 linhas)
Segundo o autor, #citacao-curta[código limpo é legível] #cite("martin2008", supplement: [p. 42]).

// Direta longa (>3 linhas, recuo 4cm, 10pt)
#citacao-longa(autor: "Martin", ano: "2009", pagina: "42")[Texto longo...]

// Bibliografia no final do documento:
#references()
```

Fonte: `src/bibliography.typ` (`cite`, `prose`, `citacao-curta`, `citacao-longa`, `references`). Arquivo bib: `example/referencias.bib`.

### Abreviaturas, glossário, apêndices e anexos

```typst
O #abbrev("ifba", long: "Instituto Federal da Bahia") é referência.
O #abbrev("ifba") novamente dá só a sigla.
O termo #gloss("docker")[Plataforma de containers.] é central.

#glossario() // imprime glossário no local desejado

#apendice
= Roteiro de Entrevistas
Conteúdo do apêndice...

#anexo
= Portaria de Autorização
Conteúdo do anexo...
```

Fonte: `src/gloss.typ` (`abbrev`, `gloss`, `lista-abreviaturas`, `glossario`), `src/annexes.typ` (`apendice`, `anexo`).

## Compilação — digital vs impressão

```typst
#show: template.with(
  // ...
  versao-impressao: false, // digital (padrão)
  // versao-impressao: true, // impressão — margens ABNT para encadernação
)
```

- `versao-impressao: false` — margens para leitura digital.
- `versao-impressao: true` — margens ajustadas para impressão/encadernação.

Recompile após trocar: `typst compile example/main.typ` ou aguarde o preview do Tinymist.

## Estrutura de pastas

```
.
├── lib.typ                  # entrypoint público — reexporta src/*.typ
├── typst.toml               # manifesto (name, version, compiler = 0.15.1)
├── src/
│   ├── layout.typ           # página, tipografia, headings ABNT
│   ├── pre-textual.typ      # template() — capa, folha de rosto, listas, sumário
│   ├── elements.typ         # figura, quadro, tabela, fonte
│   ├── bibliography.typ     # cite, prose, references, citações
│   ├── code-algo.typ        # codigo, algoritmo (codly)
│   ├── diagrams.typ         # diagram (cetz)
│   ├── charts.typ           # gráficos (cetz-plot)
│   ├── gloss.typ            # abbrev, gloss, glossario
│   ├── annexes.typ          # apendice, anexo
│   ├── editor-tools.typ     # equacao
│   └── config.typ           # get-autor, get-titulo, ...
├── example/
│   ├── main.typ             # ← edite aqui — exemplo completo
│   ├── referencias.bib
│   ├── glossary.typ
│   ├── assets/{imagens,codigos,diagramas,graficos,anexos,apendices}
│   └── data/resultados.csv
└── .vscode/extensions.json  # recomenda Tinymist + PlantUML
```

## FAQ / Troubleshooting

| Problema | Causa | Solução |
|---|---|---|
| `error: package requires typst 0.15.1` | Versão incompatível | `typst --version` e instale `0.15.1` (`typst.toml:compiler`). |
| Preview não atualiza | Tinymist não instalado | Instale `myriad-dreamin.tinymist` e recarregue o VS Code. |
| Bibliografia não aparece | `bibliografia: none` ou `.bib` vazio | Passe `bibliografia: read("referencias.bib")` e adicione `#references()` no final. |
| Referência `@fig-...` aparece em vermelho | Label não existe ou typo | Verifique `<fig-...>` e `@fig-...` com mesmo nome. |
| Ficha catalográfica em branco | Caminho errado | Use `ficha-catalografica: image("assets/ficha.pdf", width: 100%, height: 100%, fit: "contain")` com caminho relativo a `main.typ`. |
| Erro `codly` | `codly-habilitado: false` com `#codigo` | `codly-habilitado` agora é `true` por padrão; se desabilitou, reative. |

---

Dúvidas sobre ABNT? Consulte as NBRs e os comentários em `src/*.typ` e `example/main.typ`.
