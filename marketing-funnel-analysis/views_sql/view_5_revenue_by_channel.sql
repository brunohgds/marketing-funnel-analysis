USE bd_marketing
GO

-- 5.Receita e transações por origem e mídia
CREATE VIEW vw_revenue_by_channel AS
SELECT
    origem,
    midia,
    SUM(transactions) AS total_transacoes,
    SUM(receita) AS receita_total
FROM
    digital_funnel_clean
WHERE
    transactions > 0
GROUP BY
    origem, midia
GO