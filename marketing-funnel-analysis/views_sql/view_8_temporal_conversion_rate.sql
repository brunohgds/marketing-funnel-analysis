USE bd_marketing
GO

-- 8.Evolução da taxa de conversão ao longo do tempo
CREATE VIEW vw_temporal_conversion_rate AS
SELECT
    date,
    COUNT(*) AS total_sessoes,
    SUM(CASE WHEN transactions > 0 THEN 1 ELSE 0 END) AS compras_efetuadas,
    ROUND((CAST(SUM(CASE WHEN transactions > 0 THEN 1 ELSE 0 END) AS DECIMAL) / NULLIF(COUNT(*), 0)) , 2) AS taxa_conversao
FROM 
    digital_funnel_clean
GROUP BY 
    date
GO

-- Todos os calculos de taxa não foram multuiplicados por *100 para não dar problema de agregação no power bi 