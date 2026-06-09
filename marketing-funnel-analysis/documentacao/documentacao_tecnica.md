# Documentação — Views SQL | Projeto: KPI Marketing Funnel
**Banco:** `bd_marketing` | **Tabela base:** `digital_funnel_clean`

---

## Visão geral do projeto

Este projeto modela um **funil de conversão digital** — da sessão do usuário até a compra — e expõe os dados em 9 views otimizadas para consumo no Power BI. A separação em views garante que cada visual do dashboard consulte apenas o que precisa, sem joins desnecessários.

**Fluxo do funil modelado:**
```
Sessão → Visualização de Produto → Adição ao Carrinho → Checkout → Compra
```

---

## view_1 — vw_funnel_metrics

**Arquivo:** `view_1_funnel_metrics.sql`  
**Propósito:** Contagem absoluta de usuários em cada etapa do funil (visão macro).  
**Granularidade:** 1 linha única — totais globais do período completo.  
**Usado em:** Cards KPI de Total de Sessões (Executive overview).

| Coluna | Tipo | Descrição |
|---|---|---|
| `total_sessoes` | INT | Total de sessões registradas na tabela base |
| `visualizacoes_produto` | INT | Sessões com ao menos 1 visualização de produto (`view_product > 0`) |
| `adicoes_carrinho` | INT | Sessões com ao menos 1 adição ao carrinho (`add_to_cart > 0`) |
| `inicios_checkout` | INT | Sessões que chegaram ao checkout ou finalizaram compra |
| `compras_efetuadas` | INT | Sessões com ao menos 1 transação concluída |

**Nota de design:** Retorna exatamente 1 linha — seguro usar qualquer agregação no Power BI.

---

## view_2 — vw_funnel_conversion_rates

**Arquivo:** `view_2_funnel_conversion_rates.sql`  
**Propósito:** Taxas de conversão entre cada etapa consecutiva do funil.  
**Granularidade:** 1 linha única — taxas calculadas sobre o período completo.  
**Usado em:** 4 cards de taxa na página Funnel Analysis (via medidas DAX no Power BI).

| Coluna | Tipo | Descrição |
|---|---|---|
| `total_sessoes` | INT | Total de sessões (base do funil) |
| `visualizacoes_produto` | INT | Sessões com visualização de produto |
| `taxa_visita_produto` | DECIMAL(0,2) | Sessões → Produto: `visualizacoes / total_sessoes` |
| `adicoes_carrinho` | INT | Sessões com adição ao carrinho |
| `taxa_produto_carrinho` | DECIMAL(0,2) | Produto → Carrinho: `adicoes / visualizacoes` |
| `inicios_checkout` | INT | Sessões que iniciaram checkout |
| `taxa_carrinho_checkout` | DECIMAL(0,2) | Carrinho → Checkout: `checkouts / adicoes` |
| `compras_efetuadas` | INT | Sessões com compra finalizada |
| `taxa_checkout_compra` | DECIMAL(0,2) | Checkout → Compra: `compras / checkouts` |

**Nota de design:** Taxas em decimal (ex: 0.13 = 13%) — não multiplicadas por 100 para evitar dupla conversão ao formatar como % no Power BI. `NULLIF(denominador, 0)` protege contra divisão por zero em todos os cálculos.

---

## view_3 — vw_channel_performance

**Arquivo:** `view_3_channel_performance.sql`  
**Propósito:** Desempenho do funil segmentado por canal de aquisição (origem + mídia).  
**Granularidade:** 1 linha por combinação `(origem, midia)`.  
**Usado em:** Gráfico de barras "Conversão por Origem" (Channel & Device Performance).

| Coluna | Tipo | Descrição |
|---|---|---|
| `origem` | VARCHAR | Origem do tráfego (ex: google, facebook, direct) |
| `midia` | VARCHAR | Mídia do canal (ex: cpc, organic, email) |
| `total_sessoes` | INT | Total de sessões do canal |
| `visualizacoes_produto` | INT | Sessões com visualização de produto |
| `adicoes_carrinho` | INT | Sessões com adição ao carrinho |
| `inicios_checkout` | INT | Sessões que chegaram ao checkout |
| `compras_efetuadas` | INT | Compras finalizadas no canal |
| `taxa_conversao_geral` | DECIMAL(0,2) | Sessão → Compra: `compras / total_sessoes` |

---

## view_4 — vw_device_performance

**Arquivo:** `view_4_device_performance.sql`  
**Propósito:** Desempenho do funil segmentado por tipo de dispositivo.  
**Granularidade:** 1 linha por `dispositivo`.  
**Usado em:** Gráfico de colunas "Conversão por Dispositivo" (Channel & Device Performance).

| Coluna | Tipo | Descrição |
|---|---|---|
| `dispositivo` | VARCHAR | Tipo de dispositivo (ex: desktop, mobile, tablet) |
| `total_sessoes` | INT | Total de sessões no dispositivo |
| `visualizacoes_produto` | INT | Sessões com visualização de produto |
| `adicoes_carrinho` | INT | Sessões com adição ao carrinho |
| `inicios_checkout` | INT | Sessões que chegaram ao checkout |
| `compras_efetuadas` | INT | Compras finalizadas no dispositivo |
| `taxa_conversao_geral` | DECIMAL(0,2) | Sessão → Compra: `compras / total_sessoes` |

---

## view_5 — vw_revenue_by_channel

**Arquivo:** `view_5_revenue_by_channel.sql`  
**Propósito:** Receita e volume de transações por canal de aquisição.  
**Granularidade:** 1 linha por combinação `(origem, midia)` — apenas sessões com compra (`transactions > 0`).  
**Usado em:** Gráfico de barras "Receita por Origem" (Channel & Device Performance).

| Coluna | Tipo | Descrição |
|---|---|---|
| `origem` | VARCHAR | Origem do tráfego |
| `midia` | VARCHAR | Mídia do canal |
| `total_transacoes` | INT | Quantidade de transações concluídas (`SUM(transactions)`) |
| `receita_total` | DECIMAL | Receita total gerada pelo canal (`SUM(receita)`) |

**Nota:** Filtro `WHERE transactions > 0` garante que apenas sessões com compra entrem no cálculo de receita.

---

## view_6 — vw_revenue_by_device

**Arquivo:** `view_6_revenue_by_device.sql`  
**Propósito:** Receita e volume de transações por dispositivo.  
**Granularidade:** 1 linha por `dispositivo` — apenas sessões com compra.  
**Usado em:** Gráfico de pizza "Receita por Dispositivo" (Channel & Device Performance).

| Coluna | Tipo | Descrição |
|---|---|---|
| `dispositivo` | VARCHAR | Tipo de dispositivo |
| `total_transacoes` | INT | Quantidade de transações no dispositivo |
| `receita_total` | DECIMAL | Receita total gerada no dispositivo |

---

## view_7 — vw_temporal_performance

**Arquivo:** `view_7_temporal_performance.sql`  
**Propósito:** Série temporal de sessões, transações e receita — base dos gráficos de linha.  
**Granularidade:** 1 linha por dia (`date`).  
**Usado em:** Line chart "Evolução Receita no Tempo" + cards de Receita Total e Transações (Executive overview).

| Coluna | Tipo | Descrição |
|---|---|---|
| `date` | DATE | Data da sessão |
| `total_sessoes` | INT | Total de sessões no dia |
| `total_transacoes` | INT | Total de transações no dia (`SUM(transactions)`) |
| `receita_total` | DECIMAL | Receita total do dia (`SUM(receita)`) |

---

## view_8 — vw_temporal_conversion_rate

**Arquivo:** `view_8_temporal_conversion_rate.sql`  
**Propósito:** Série temporal da taxa de conversão diária — base do line chart de conversão e da medida DAX global.  
**Granularidade:** 1 linha por dia (`date`).  
**Usado em:** Line chart "Evolução Taxa de Conversão" + medida DAX "Taxa de Conversão Geral" (Executive overview).

| Coluna | Tipo | Descrição |
|---|---|---|
| `date` | DATE | Data da sessão |
| `total_sessoes` | INT | Total de sessões no dia |
| `compras_efetuadas` | INT | Sessões com compra no dia |
| `taxa_conversao` | DECIMAL(0,2) | Taxa diária: `compras / total_sessoes` |

**Nota importante:** Esta view retorna múltiplas linhas (uma por dia). A medida DAX `Taxa de Conversão Geral = DIVIDE(SUM(compras_efetuadas), SUM(total_sessoes))` recalcula a taxa correta somando numerador e denominador antes de dividir, evitando a média de médias.

---

## view_9 — vw_funnel_chart

**Arquivo:** `view_9_funnel_chart.sql`  
**Propósito:** Estrutura de dados específica para o visual de funil do Power BI (formato longo com etapa + total).  
**Granularidade:** 5 linhas fixas — uma por etapa do funil.  
**Usado em:** Visual "Funil de Conversão" (Funnel Analysis).

| Coluna | Tipo | Descrição |
|---|---|---|
| `etapa` | VARCHAR | Nome da etapa do funil |
| `total` | INT | Volume absoluto na etapa |

**Etapas retornadas (em ordem do funil):**

| # | etapa | Lógica |
|---|---|---|
| 1 | Sessões | `COUNT(*)` total |
| 2 | Visualização de Produto | `view_product > 0` |
| 3 | Adição ao Carrinho | `add_to_cart > 0` |
| 4 | Checkout | `checkout > 0 OR transactions > 0` |
| 5 | Compra | `transactions > 0` |

**Recomendação:** Adicionar coluna `ordem INT` à view e usar como campo de ordenação no Power BI para garantir sequência correta independente do plano de execução SQL.

---

## Dependências entre views

```
digital_funnel_clean (tabela base)
├── vw_funnel_metrics          → Executive overview (card: Total Sessões)
├── vw_funnel_conversion_rates → Funnel Analysis (4 cards de taxa via DAX)
├── vw_funnel_chart            → Funnel Analysis (visual funil)
├── vw_channel_performance     → Channel & Device (conversão por origem)
├── vw_device_performance      → Channel & Device (conversão por dispositivo)
├── vw_revenue_by_channel      → Channel & Device (receita por origem)
├── vw_revenue_by_device       → Channel & Device (receita por dispositivo)
├── vw_temporal_performance    → Executive overview (receita/tempo + cards receita/transações)
└── vw_temporal_conversion_rate→ Executive overview (taxa/tempo + medida DAX global)
```
