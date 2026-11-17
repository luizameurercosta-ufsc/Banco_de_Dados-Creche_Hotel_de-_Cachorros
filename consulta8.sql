--- Consulta 8: Cães com vacina, vermífugo ou antipulgas vencendo nos próximos 30 dias
--- Objetivo: gerar a lista de cães cujo prontuário tem algum registro sanitário com validade
--- entre a data de referência (2026-11-16) e 30 dias depois e mostra a menor data de validade
--- encontrada na janela e seu tipo, para avisar o tutor com antecedência.

SELECT ca.nome AS cachorro,
       cl.nome AS tutor,
       cl.telefone,
       (SELECT rs.tipo
        FROM REGISTRO_SANITARIO AS rs
        WHERE rs.id_prontuario = p.id_prontuario
          AND rs.data_validade BETWEEN '2026-11-16' AND date('2026-11-16', '+30 days')
        ORDER BY rs.data_validade ASC
        LIMIT 1
       ) AS tipo_primeiro_vencimento,
       (SELECT MIN(rs.data_validade)
        FROM REGISTRO_SANITARIO AS rs
        WHERE rs.id_prontuario = p.id_prontuario
          AND rs.data_validade BETWEEN '2026-11-16' AND date('2026-11-16', '+30 days')
       ) AS primeiro_vencimento
FROM CACHORRO AS ca INNER JOIN CLIENTE AS cl ON cl.id_cliente = ca.id_cliente
INNER JOIN PRONTUARIO AS p ON p.id_cachorro = ca.id_cachorro
WHERE EXISTS (
    SELECT 1
    FROM REGISTRO_SANITARIO AS rs
    WHERE rs.id_prontuario = p.id_prontuario
      AND rs.data_validade BETWEEN '2026-11-16' AND date('2026-11-16', '+30 days')
)
ORDER BY primeiro_vencimento ASC, ca.nome ASC;
