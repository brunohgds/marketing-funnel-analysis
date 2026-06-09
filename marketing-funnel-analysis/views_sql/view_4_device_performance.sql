USE bd_marketing
GO

-- 4.Análise do funil por dispositivo
CREATE VIEW vw_device_performance AS
SELECT
    dispositivo,
    COUNT(*) AS total_sessoes,
    SUM(CASE WHEN view_product > 0 THEN 1 ELSE 0 END) AS visualizacoes_produto,
    SUM(CASE WHEN add_to_cart > 0 THEN 1 ELSE 0 END) AS adicoes_carrinho,
    SUM(CASE WHEN checkout > 0 OR transactions > 0 THEN 1 ELSE 0 END) AS inicios_checkout,
    SUM(CASE WHEN transactions > 0 THEN 1 ELSE 0 END) AS compras_efetuadas,
    ROUND((CAST(SUM(CASE WHEN transactions > 0 THEN 1 ELSE 0 END) AS DECIMAL) / NULLIF(COUNT(*),0)) , 2) AS taxa_conversao_geral
FROM
    digital_funnel_clean
GROUP BY
    dispositivo
GO

-- Todos os calculos de taxa não foram multuiplicados por *100 para não dar problema de agregação no power bi 