USE bd_marketing
GO

-- 1. Contagem de usuários em cada etapa do funil
CREATE VIEW vw_funnel_metrics AS

SELECT
    COUNT(*) AS total_sessoes,
    SUM(CASE WHEN view_product > 0 THEN 1 ELSE 0 END) AS visualizacoes_produto,
    SUM(CASE WHEN add_to_cart > 0 THEN 1 ELSE 0 END) AS adicoes_carrinho,
    SUM(CASE WHEN checkout > 0 OR transactions > 0 THEN 1 ELSE 0 END) AS inicios_checkout,
    SUM(CASE WHEN transactions > 0 THEN 1 ELSE 0 END) AS compras_efetuadas
FROM
    digital_funnel_clean;
