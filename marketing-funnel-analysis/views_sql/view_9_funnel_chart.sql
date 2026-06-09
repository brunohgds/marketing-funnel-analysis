USE bd_marketing
GO

-- 9. View especifica para o gráfico de funil 
CREATE VIEW vw_funnel_chart AS
SELECT 'Sessões' AS etapa,
       COUNT(*)  AS total
FROM digital_funnel_clean

UNION ALL

SELECT
    'Visualização de Produto' AS etapa,
    SUM(CASE WHEN view_product > 0 THEN 1 ELSE 0 END) AS total
FROM digital_funnel_clean

UNION ALL

SELECT
    'Adição ao Carrinho',
    SUM(CASE WHEN add_to_cart > 0 THEN 1 ELSE 0 END)
FROM digital_funnel_clean

UNION ALL

SELECT
    'Checkout',
    SUM(CASE WHEN checkout > 0 OR transactions > 0 THEN 1 ELSE 0 END)
FROM digital_funnel_clean

UNION ALL

SELECT
    'Compra',
    SUM(CASE WHEN transactions > 0 THEN 1 ELSE 0 END)
FROM digital_funnel_clean
GO