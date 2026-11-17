--- Consulta 6: Clientes com mais de um cachorro
--- Objetivo: encontrar tutores que levam mais de um cão à creche, listando os nomes dos cães,
--- os portes e as datas de nascimento.

SELECT cl.nome AS cliente,
       COUNT(ca.id_cachorro) AS qtd_caes,
       GROUP_CONCAT(ca.nome, ', ') AS caes,
       GROUP_CONCAT(ca.porte, ', ') AS portes,
       GROUP_CONCAT(ca.data_nascimento, ', ') AS datas_de_nascimento
FROM CLIENTE AS cl INNER JOIN CACHORRO AS ca ON ca.id_cliente = cl.id_cliente
GROUP BY cl.nome
HAVING COUNT(ca.id_cachorro) > 1
ORDER BY qtd_caes DESC;
