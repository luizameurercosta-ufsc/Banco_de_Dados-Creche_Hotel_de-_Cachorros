--- Consulta 10: Consumo total por cliente (serviços + compras de produtos)
--- Objetivo: consolidar quanto cada cliente consumiu em serviços da creche e em compras de produtos,
--- calcular o total e indicar quem está acima da média geral dos clientes.

WITH servicos_cliente AS (
    SELECT ag.id_cliente,
           SUM(ags.quantidade * ags.preco_unitario) AS total_servicos
    FROM AGENDAMENTO AS ag INNER JOIN AGENDAMENTO_SERVICO ags ON ags.id_agendamento = ag.id_agendamento
    WHERE ag.status <> 'CANCELADO'
    GROUP BY ag.id_cliente
),
compras_cliente AS (
    SELECT id_cliente,
           SUM(valor_total) AS total_compras
    FROM VENDA
    GROUP BY id_cliente
),
consolidado AS (
    SELECT cl.id_cliente,
           cl.nome,
           COALESCE(s.total_servicos, 0) AS total_servicos,
           COALESCE(c.total_compras, 0) AS total_compras,
           COALESCE(s.total_servicos, 0) + COALESCE(c.total_compras, 0) AS total_geral
    FROM CLIENTE AS cl LEFT JOIN servicos_cliente AS s ON s.id_cliente = cl.id_cliente
    LEFT JOIN compras_cliente AS c ON c.id_cliente = cl.id_cliente
)
SELECT nome,
       total_servicos,
       total_compras,
       total_geral,
       CASE WHEN total_geral > (SELECT AVG(total_geral) FROM consolidado)
            THEN 'Acima da média' ELSE 'Na média ou abaixo' END AS classificacao
FROM consolidado
ORDER BY total_geral DESC;
