USE bd_marketing
GO

-- 7. Evolução temporal de visitantes, transações e receita
CREATE VIEW vw_temporal_performance AS
SELECT
    date,
    COUNT(*) AS total_sessoes,
    SUM(transactions) AS total_transacoes,
    SUM(receita) AS receita_total
FROM 
    digital_funnel_clean
GROUP BY 
    date
GO