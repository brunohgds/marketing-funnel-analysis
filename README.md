# 📊 Marketing Funnel Analytics

Projeto de análise de performance de marketing digital desenvolvido com **SQL Server** e **Power BI**, utilizando dados de comportamento de usuários em um e-commerce para mapear todo o processo de conversão, desde a visita ao site até a conclusão da compra.

---

## 🎯 Objetivo do Projeto

Empresas investem continuamente em canais de aquisição como Google, Facebook, E-mail Marketing e tráfego direto para atrair visitantes.

Entretanto, nem todos os usuários concluem uma compra.

O objetivo deste projeto é analisar o desempenho do funil de conversão e responder perguntas como:

* Onde ocorre o maior abandono de usuários?
* Qual canal gera mais conversões?
* Qual dispositivo possui melhor desempenho?
* Como a receita evolui ao longo do tempo?
* Quais oportunidades de otimização podem aumentar as vendas?

---

## 📈 Fluxo do Funil

```text
Sessão
   ↓
Visualização de Produto
   ↓
Adição ao Carrinho
   ↓
Checkout
   ↓
Compra
```

Cada etapa representa um avanço do usuário dentro da jornada de compra.

---

## 🛠️ Tecnologias Utilizadas

* SQL Server
* Power BI
* DAX
* Excel / CSV
* GitHub

---

## 🗂️ Estrutura do Projeto

```text
marketing-funnel-analysis/
│
├── README.md
│
├── documentacao/
│   └── documentacao_tecnica.md
│
├── views_sql/
│   ├── view_1_funnel_metrics.sql
│   ├── view_2_funnel_conversion_rates.sql
│   └── ...
│
├── powerbi/
│   └── Marketing_Funnel.pbix
│
├── imagens/
│   ├── dashboard_overview.png
│   ├── funnel_analysis.png
│   └── channel_performance.png
│
└── data/
    └── digital_funnel_clean.csv
```

---

## 📊 Dashboard

### Executive Overview

Visão executiva contendo os principais indicadores de negócio:

* Total de Sessões
* Receita Total
* Total de Transações
* Taxa de Conversão Geral
* Evolução da Receita
* Evolução da Conversão

  <img width="1154" height="642" alt="dashboard_overview" src="https://github.com/user-attachments/assets/ccd2b07d-b1ba-4479-a740-8dd44eb4e948" />


---

### Funnel Analysis

Análise completa do funil de conversão:

* Sessões
* Visualizações de Produto
* Adições ao Carrinho
* Inícios de Checkout
* Compras Efetuadas

Além das taxas de conversão entre cada etapa da jornada.

<img width="1155" height="643" alt="funnel_analysis" src="https://github.com/user-attachments/assets/ebb15407-212f-42a1-9ccc-2b9566a40126" />


---

### Channel & Device Performance

Comparação de desempenho por:

* Canal de aquisição
* Origem de tráfego
* Mídia
* Tipo de dispositivo

Incluindo análises de receita e conversão.

<img width="1152" height="642" alt="channel_performance" src="https://github.com/user-attachments/assets/04a8262a-1158-42a6-88a5-70439f2189c3" />


---

## 📌 KPIs Monitorados

| KPI                      |
| ------------------------ |
| Total de Sessões         |
| Visualizações de Produto |
| Adições ao Carrinho      |
| Inícios de Checkout      |
| Compras Efetuadas        |
| Receita Total            |
| Total de Transações      |
| Taxa de Conversão Geral  |

---

## 🧠 Principais Conceitos Aplicados

Durante o desenvolvimento do projeto foram aplicados conceitos de:

* Modelagem de dados para BI
* Criação de Views SQL para consumo analítico
* Construção de KPIs
* Análise de Funil de Conversão
* Análise de Receita
* Segmentação por Canal e Dispositivo
* Criação de Métricas DAX
* Storytelling com Dados
* Desenvolvimento de Dashboards Executivos

---

## ⚙️ Arquitetura da Solução

```text
Arquivo CSV
      │
      ▼
digital_funnel_clean
      │
      ├── vw_funnel_metrics
      ├── vw_funnel_conversion_rates
      ├── vw_funnel_chart
      ├── vw_channel_performance
      ├── vw_device_performance
      ├── vw_revenue_by_channel
      ├── vw_revenue_by_device
      ├── vw_temporal_performance
      └── vw_temporal_conversion_rate
                 │
                 ▼
              Power BI
```

As transformações e agregações foram realizadas no SQL Server através de Views especializadas, reduzindo processamento no Power BI e facilitando a manutenção do projeto.

---

## 📂 Fonte dos Dados

Os dados utilizados neste projeto foram obtidos através da plataforma Kaggle e representam um cenário de análise de marketing digital e comportamento de usuários em ambiente de e-commerce.

O arquivo utilizado encontra-se disponível na pasta:

```text
/data/sample_dataset.csv
```

---

## 📖 Documentação Técnica

A documentação completa contendo:

* Regras de negócio
* Estrutura das Views
* Descrição das colunas
* Granularidade dos dados
* Dependências da solução
* Métricas e cálculos

está disponível em:

```text
/docs/documentacao_tecnica.md
```

---

## 🚀 Aprendizados do Projeto

Este projeto foi desenvolvido com o objetivo de praticar e consolidar conhecimentos em:

* SQL para análise de dados
* Desenvolvimento de Views analíticas
* Power BI
* DAX
* Construção de dashboards executivos
* Estruturação de projetos para portfólio
* Documentação técnica de soluções de BI

---

## 👨‍💻 Autor

Bruno Silva

Projeto desenvolvido como parte da construção do portfólio em Análise de Dados, utilizando SQL Server e Power BI para transformar dados em informações estratégicas para tomada de decisão.
