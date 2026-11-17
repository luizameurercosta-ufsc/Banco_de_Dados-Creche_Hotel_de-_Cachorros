--- Consulta 4: Frequência de cada cliente por ambiente da creche
--- Objetivo: mostrar, para cada cliente e ambiente, quantos agendamentos foram feitos,
--- quantos cães diferentes os utilizaram e quantos já foram concluídos.

SELECT cl.nome AS cliente,
       ca.nome AS cachorro,
       a.nome AS ambiente,
       COUNT(*) AS total_agendamentos,
       SUM(CASE WHEN ag.status = 'CONCLUIDO' THEN 1 ELSE 0 END) AS concluidos
FROM CLIENTE AS cl INNER JOIN CACHORRO AS ca ON ca.id_cliente = cl.id_cliente
INNER JOIN AGENDAMENTO AS ag ON ag.id_cachorro = ca.id_cachorro
INNER JOIN AMBIENTE AS a ON a.id_ambiente = ag.id_ambiente
GROUP BY ca.nome
ORDER BY cl.nome, total_agendamentos DESC;
