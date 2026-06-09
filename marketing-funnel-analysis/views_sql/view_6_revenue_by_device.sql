USE bd_marketing
GO

-- 6.Receita e transações por dispositivo
CREATE VIEW vw_revenue_by_device AS
SELECT
    dispositivo,
    SUM(transactions) AS total_transacoes,
    SUM(receita) AS receita_total
FROM
    digital_funnel_clean
WHERE
    transactions > 0
GROUP BY
    dispositivo
GO