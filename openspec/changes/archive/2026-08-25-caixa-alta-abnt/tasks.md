## 1. Caixa-alta ABNT

- [x] 1.1 Aplicar `upper()` na renderização em `src/pre-textual.typ` para `titulo`, `autor`, `instituicao`, `local`, `ano`, `orientador`/`co-orientador` em `_capa` e `_folha-de-rosto` e verificar capa/folha exibem caixa-alta sem alterar `get-*`
- [x] 1.2 Parametrizar preâmbulo em `src/pre-textual.typ` via junção de `instituicao`/`curso`/`local` (getters) e verificar texto "Trabalho de Conclusão de Curso apresentado ao Instituto Federal..." reflete valores do template

## 2. Validação

- [x] 2.1 Verificar `get-autor()` e similares retornam valor original e `openspec validate --changes --strict` passa
- [x] 2.2 Compilar `typst compile example/main.typ` e conferir visualmente capa/folha em PDF
