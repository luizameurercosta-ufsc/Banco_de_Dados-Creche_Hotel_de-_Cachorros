--- Consulta 9: Clientes com assinatura suspensa
--- Objetivo: listar os clientes que possuem assisnatura suspensa

SELECT cl.id_cliente,
       cl.nome,
       cl.telefone,
       CASE cl.bloqueado WHEN 1 THEN 'Bloqueado' ELSE 'Liberado' END AS situacao_cadastro
FROM CLIENTE AS cl INNER JOIN ASSINATURA AS a ON CL.id_cliente = a.id_cliente
WHERE a.status = 'SUSPENSA'
ORDER BY cl.nome;
