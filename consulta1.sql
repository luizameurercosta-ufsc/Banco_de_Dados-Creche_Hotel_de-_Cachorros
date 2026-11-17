--- Consulta 1: Receita e volume por serviço
--- Objetivo: descobrir quais serviços (diária integral, meio período, estadia) geram mais receita,
--- quantas contratações tiveram e quanto desse valor foi cobrado à parte (fora do plano mensal).

SELECT s.nome AS servico,
       s.tipo AS tipo,
       COUNT(*) AS contratacoes,
       SUM(ags.quantidade) AS unidades_vendidas,
       SUM(ags.quantidade * ags.preco_unitario) AS receita_bruta,
       SUM(CASE WHEN ags.coberto_plano = 0 THEN ags.quantidade * ags.preco_unitario ELSE 0 END) AS cobrado_a_parte
FROM AGENDAMENTO_SERVICO AS ags INNER JOIN SERVICO AS s ON s.id_servico = ags.id_servico
INNER JOIN AGENDAMENTO AS ag ON ag.id_agendamento = ags.id_agendamento
WHERE  ag.status <> 'CANCELADO'
GROUP BY s.nome, s.tipo
ORDER BY receita_bruta DESC;
