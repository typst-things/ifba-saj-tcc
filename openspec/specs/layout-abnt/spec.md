## Purpose

Página, tipografia, espaçamento, margens e cabeçalho conforme ABNT/NBR 14724 para o modelo IFBA SAJ.

## Requirements

### Requirement: Modo impressão

O template SHALL aceitar `print: false|true`. Quando true, a publicação é frente-e-verso: cada seção primária e cada elemento textual/pós-textual inicia no anverso (página ímpar), com no máximo **um** verso em branco intencional entre elementos consecutivos; quebras consecutivas para página ímpar não devem produzir páginas em branco adicionais. Quando false, não há quebras para página ímpar.

#### Scenario: Compilação digital
- **WHEN** `print: false`
- **THEN** não há quebras para página ímpar forçadas

#### Scenario: Elemento termina no anverso
- **WHEN** `print: true` e um elemento termina em página ímpar
- **THEN** o próximo elemento inicia no anverso seguinte, com exatamente um verso em branco entre eles — nunca dois ou mais

### Requirement: Numeração de páginas

O sistema SHALL numerar páginas no canto superior direito, reiniciando a contagem após a capa (a folha de rosto é a folha 1). Nas páginas internas comuns, o cabeçalho exibe o título do capítulo corrente (formato "Capítulo N. Título" ou "Apêndice/Anexo A – Título") à esquerda e o número da página à direita, acima de uma linha. Na folha de abertura de cada seção primária, o número de página **é exibido** sozinho, alinhado à direita, sem título de capítulo nem linha de cabeçalho.

#### Scenario: Página interna comum
- **WHEN** a página não abre um capítulo
- **THEN** o cabeçalho mostra o capítulo corrente à esquerda e o número da página à direita, acima de uma linha

#### Scenario: Página de abertura de capítulo
- **WHEN** a página contém um título de nível 1
- **THEN** apenas o número da página aparece, alinhado à direita, sem título de capítulo nem linha

### Requirement: Tipografia do corpo

O sistema SHALL usar New Computer Modern (ou serif do tema) 12pt, parágrafos justificados, recuo de primeira linha de 1,25cm em todos os parágrafos e **entrelinha de 1,5** no corpo do texto, com idioma pt-BR. Citações longas, notas de rodapé, legendas, referências e resumo mantêm espaçamento simples em fonte menor, conforme NBR 14724/10520.

#### Scenario: Parágrafo textual
- **WHEN** um parágrafo do corpo é renderizado
- **THEN** ele é justificado, com recuo de primeira linha de 1,25cm e entrelinha equivalente a 1,5

#### Scenario: Espaçamento simples preservado
- **WHEN** são renderizadas citações longas, referências ou legendas
- **THEN** esses elementos permanecem em espaçamento simples e fonte menor que o corpo

### Requirement: Margens e papel ABNT

O sistema SHALL configurar papel A4. No anverso e no modo digital, margens esquerda e superior de 3cm, direita e inferior de 2cm. No modo impressão (`print: true`), as margens SHALL ser espelhadas no verso: 3cm na borda da lombada (interna) e 2cm na borda externa.

#### Scenario: Página padrão
- **WHEN** o documento é compilado com o `template`
- **THEN** todas as páginas usam A4 com margens 3-3-2-2 (esq, sup, dir, inf)

#### Scenario: Verso em modo impressão
- **WHEN** `print: true` e a página é um verso (página par)
- **THEN** a margem direita (lombada) é de 3cm e a esquerda de 2cm

### Requirement: Constantes internas de conformidade

Os valores fixados pela ABNT/NBR 14724 (corpo 12pt, entrelinha 1,5, margens, recuo de 1,25cm) SHALL ser constantes internas do pacote e NÃO SHALL ser customizáveis pelo tema público. O tema público SHALL restringir-se aos aspectos em que a norma é neutra (família serif, cor de links).

#### Scenario: Tema público mínimo
- **WHEN** um usuário inspeciona ou sobrescreve o tema
- **THEN** apenas campos não normativos (serif, cor de links) estão disponíveis; não há como alterar corpo, entrelinha, margens ou recuo de 1,25cm para valores fora da norma