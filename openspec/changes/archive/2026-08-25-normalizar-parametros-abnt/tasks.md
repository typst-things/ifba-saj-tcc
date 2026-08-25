## 1. Template — renomeação e obrigatoriedade

- [x] 1.1 Renomear em `src/pre-textual.typ:template()` os 7 params para pt-BR (`ficha-catalografica`, `texto-aprovacao`, `banca`, `dedicatoria`, `agradecimentos`, `epigrafe`, `versao-impressao`) e verificar assinatura não contém nomes em inglês
- [x] 1.2 Tornar obrigatórios ABNT com `assert` em `template()` (`ficha-catalografica`, `texto-aprovacao`, `resumo-conteudo`/`resumo-palavras`, `abstract-conteudo`/`abstract-palavras`, `bibliografia`) e verificar compilação falha com mensagem quando ausentes
- [x] 1.3 Alterar `codly-habilitado` default para `true` e `versao-impressao` default `false` e verificar `typst compile` compila código com highlight sem flag explícita
- [x] 1.4 Remover param `descricao` e gerar preâmbulo parametrizado automaticamente ("Trabalho de Conclusão de Curso apresentado ao Instituto Federal de Educação, Ciência e Tecnologia da Bahia, campus Santo Antônio de Jesus, como requisito parcial para obtenção do grau de Tecnólogo em Análise e Desenvolvimento de Sistemas.") e verificar folha de rosto exibe texto parametrizado
- [x] 1.5 Atualizar `src/config.typ` se `print` for propagado (renomear para `versao-impressao`) e verificar getters refletem novo nome

## 2. Exemplo e documentação

- [x] 2.1 Atualizar `example/main.typ` para novos nomes e preencher obrigatórios ABNT e verificar `typst compile example/main.typ` gera PDF sem erros
- [x] 2.2 Atualizar `README.md` tabela de parâmetros (só pt-BR, coluna obrigatoriedade ABNT, `versao-impressao`, `codly-habilitado` default true, sem `descricao`) e exemplo mínimo e verificar tabela cobre todos os params de `template()`
- [x] 2.3 Atualizar `lib.typ` reexports/comentários se referenciam nomes antigos e verificar sem referências a `catalog-card`/`print`/etc.

## 3. Validação

- [x] 3.1 Validar `openspec validate --changes --strict` passa e verificar `typst compile example/main.typ` sem warnings de params desconhecidos
