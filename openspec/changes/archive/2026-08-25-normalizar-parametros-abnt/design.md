## Context

Ver `proposal.md`. Estado atual: `src/pre-textual.typ:template()` expõe 7 params em inglês e todos com default `none`/`false` (opcionais). ABNT NBR 14724 exige ficha, folha de aprovação, resumos e referências como obrigatórios. Sistema sem usuários — corte seco é viável.

## Goals / Non-Goals

**Goals:**
- Normalizar API para pt-BR sem aliases.
- Alinhar obrigatoriedade à ABNT com falha explícita.
- Gerar preâmbulo parametrizado automaticamente.

**Non-Goals:**
- Aliases/depreciação bilíngue.
- Alterar `logo`/`instituicao`/`curso`/`local` (mantêm default).
- Mudar `codly-habilitado` de nome (manter por ser nome de pacote).

## Decisions

- **Renomeação direta sem aliases**: `catalog-card`→`ficha-catalografica`, `approval-text`→`texto-aprovacao`, `committee`→`banca`, `dedication`→`dedicatoria`, `acknowledgments`→`agradecimentos`, `epigraph`→`epigrafe`, `print`→`versao-impressao`. Alternativa com aliases descartada por sistema novo sem usuários.
- **B1 — assert/falha em `template()`**: validar obrigatórios no início de `template()` com `assert` + mensagem. Alternativa warning descartada — ABNT é fonte da verdade.
- **Remover `descricao` param**: gerar preâmbulo fixo parametrizado conforme texto fornecido pelo usuário. Se futuramente precisar variar, reintroduzir como override opcional em change separada.
- **`codly-habilitado` default `true`**: habilitar highlight por padrão; alternativa manter `false` descartada por pior DX.
- **`versao-impressao` boolean**: mantém semântica de `print`, apenas renomeia.

## Risks / Trade-offs

- **Breaking change total** → Mitigação: sistema sem uso; atualizar `example/main.typ` e README juntos.
- **Preâmbulo fixo engessa variação** → Mitigação: texto atende ADS SAJ; variação futura via nova change.
- **Validação rígida impede preview parcial** → Mitigação: mensagem de erro clara indica o que falta.

## Migration Plan

- Atualizar `src/pre-textual.typ` (assinatura + asserts + geração preâmbulo), `example/main.typ`, `README.md`, `openspec/specs/pre-textuais/spec.md`. Sem rollback — reverter commit.

## Open Questions

- Nenhuma — decisões fechadas com usuário (A1+B1, nomes, preâmbulo).
