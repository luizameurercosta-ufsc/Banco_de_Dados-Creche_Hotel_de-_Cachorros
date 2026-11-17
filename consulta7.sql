--- Consulta 7: Ocupação diária dos ambientes
--- Objetivo: calcular, para cada ambiente e dia, quantos cães estão agendados e qual o percentual
--- da capacidade máxima do ambiente que isso representa.

SELECT a.nome AS ambiente,
       a.capacidade_maxima,
       date(ag.entrada_prevista) AS dia,
       COUNT(*) AS caes_agendados,
       ROUND(100.0 * COUNT(*) / a.capacidade_maxima, 1) AS ocupacao_pct
FROM AGENDAMENTO AS ag INNER JOIN AMBIENTE AS a ON a.id_ambiente = ag.id_ambiente
WHERE ag.status <> 'CANCELADO'
GROUP BY a.id_ambiente, ag.entrada_prevista
ORDER BY ag.entrada_prevista;
