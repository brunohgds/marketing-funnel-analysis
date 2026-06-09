USE bd_marketing
GO

-- 2. Cálculo das taxas de conversão
CREATE VIEW vw_funnel_conversion_rates AS
WITH FunnelSteps AS (
    SELECT
        COUNT(*) AS total_sessoes,
        SUM(CASE WHEN view_product > 0 THEN 1 ELSE 0 END) AS visualizacoes_produto,
        SUM(CASE WHEN add_to_cart > 0 THEN 1 ELSE 0 END) AS adicoes_carrinho,
        SUM(CASE WHEN checkout > 0 OR transactions > 0 THEN 1 ELSE 0 END) AS inicios_checkout,
        SUM(CASE WHEN transactions > 0 THEN 1 ELSE 0 END) AS compras_efetuadas
    FROM
        digital_funnel_clean
)
SELECT
    total_sessoes,
    visualizacoes_produto,
    ROUND((CAST(visualizacoes_produto AS DECIMAL) / NULLIF(total_sessoes, 0)) , 2) AS taxa_visita_produto, 
    adicoes_carrinho,
    ROUND((CAST(adicoes_carrinho AS DECIMAL) / NULLIF(visualizacoes_produto,0)) , 2) AS taxa_produto_carrinho,
    inicios_checkout,
    ROUND((CAST(inicios_checkout AS DECIMAL) / NULLIF(adicoes_carrinho,0)) , 2) AS taxa_carrinho_checkout,
    compras_efetuadas,
    ROUND((CAST(compras_efetuadas AS DECIMAL) / NULLIF(inicios_checkout,0)) , 2) AS taxa_checkout_compra
FROM
    FunnelSteps;

-- Todos os calculos de taxa não foram multuiplicados por *100 para não dar problema de agregação no power bi 
