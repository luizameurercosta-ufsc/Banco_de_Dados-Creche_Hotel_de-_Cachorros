--- Consulta 5: Agendamentos e cuidador responsável
--- Objetivo: listar os agendamentos agendados com o cão, o ambiente e o cuidador designado.

SELECT ag.id_agendamento,
       ag.entrada_prevista,
       ca.nome AS cachorro,
       a.nome AS ambiente,
       AG.status AS agendamentos,
       f.nome AS cuidador
FROM AGENDAMENTO AS ag INNER JOIN CACHORRO AS ca ON ca.id_cachorro = ag.id_cachorro
INNER JOIN AMBIENTE AS a ON a.id_ambiente = ag.id_ambiente
LEFT JOIN CUIDADOR AS cu ON cu.id_funcionario = ag.id_cuidador
LEFT JOIN FUNCIONARIO AS f ON f.id_funcionario = cu.id_funcionario
WHERE ag.status LIKE 'AGENDADO'
ORDER BY ag.entrada_prevista;
