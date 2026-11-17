--- Consulta 3: Clientes que nunca compraram produtos na creche
--- Objetivo: identificar clientes sem nenhuma venda registrada, com o número de cães e o contato de cada um.

SELECT c.id_cliente,
       c.nome,
       c.telefone,
       COALESCE(c.email, 'sem e-mail cadastrado') AS email,
       COUNT(DISTINCT ca.id_cachorro) AS qtd_caes
FROM CLIENTE AS c LEFT JOIN VENDA AS v ON v.id_cliente = c.id_cliente
LEFT JOIN CACHORRO AS ca ON ca.id_cliente = c.id_cliente
WHERE v.id_venda IS NULL
GROUP BY c.id_cliente
ORDER BY c.nome;
