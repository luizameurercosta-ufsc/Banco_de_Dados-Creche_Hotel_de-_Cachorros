--- Consulta 2: Estatísticas de preço e estoque por categoria de produto
--- Objetivo: para cada categoria (RACAO, BRINQUEDO, ACESSORIO), mostrar o preço médio, o menor e o maior
--- preço de venda e o estoque total.

SELECT categoria,
       COUNT(*) AS qtd_produtos,
       ROUND(AVG(preco_venda), 2) AS preco_medio,
       MIN(preco_venda) AS menor_preco,
       MAX(preco_venda) AS maior_preco,
       SUM(qtd_estoque) AS estoque_total
FROM PRODUTO
GROUP BY categoria
ORDER BY preco_medio;
