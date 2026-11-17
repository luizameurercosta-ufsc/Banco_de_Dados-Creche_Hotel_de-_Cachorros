--- Consulta 11: Transações com COMMIT, ROLLBACK e SAVEPOINT
--- Objetivo: demonstrar o controle transacional em duas operações do dia a dia da creche.
---   Bloco A (COMMIT + SAVEPOINT + ROLLBACK TO): registrar a retirada do agendamento 13 com atraso.
---           Um primeiro registro de saída é feito e desfeito parcialmente com ROLLBACK TO SAVEPOINT;
---           depois a saída correta é registrada, a penalidade é gerada (valor = minutos/60 x valor da
---           hora vigente em PARAMETRO_OPERACIONAL) e tudo é confirmado com COMMIT.
---   Bloco B (ROLLBACK total): simular uma venda (venda + item + baixa de estoque) que é cancelada
---           (ex.: pagamento recusado); ROLLBACK desfaz tudo e o estoque volta ao valor original.
--- Obs.: o Bloco A grava dados de forma definitiva; para repetir o teste, restaure o banco original.

-- ======================= BLOCO A =======================
BEGIN TRANSACTION;

-- check-in real do cachorro
UPDATE AGENDAMENTO
   SET entrada_real = '2026-11-16 07:40',
       status = 'EM_ANDAMENTO'
 WHERE id_agendamento = 13;

SAVEPOINT sp_checkout;

-- saída registrada por engano (horário errado), será desfeita
UPDATE AGENDAMENTO
   SET saida_real = '2026-11-16 17:00',
       status = 'CONCLUIDO'
 WHERE id_agendamento = 13;

-- confere o estado antes do desfazer
SELECT id_agendamento, status, entrada_real, saida_real FROM AGENDAMENTO WHERE id_agendamento = 13;

ROLLBACK TO sp_checkout;   -- desfaz só o checkout errado; o check-in continua na transação

-- checkout correto (retirada às 19:30, 90 min depois do previsto)
UPDATE AGENDAMENTO
   SET saida_real = '2026-11-16 19:30',
       status = 'CONCLUIDO'
 WHERE id_agendamento = 13;

-- penalidade por atraso na retirada
INSERT INTO PENALIDADE (id_agendamento, tipo, minutos_atraso, valor, pago)
SELECT ag.id_agendamento,
       'ATRASO_RETIRADA',
       CAST(ROUND((julianday(ag.saida_real) - julianday(ag.saida_prevista)) * 1440) AS INTEGER),
       ROUND((julianday(ag.saida_real) - julianday(ag.saida_prevista)) * 24
             * (SELECT valor_penalidade_hora FROM PARAMETRO_OPERACIONAL WHERE vigente = 1), 2),
       0
FROM AGENDAMENTO ag
WHERE ag.id_agendamento = 13;

RELEASE SAVEPOINT sp_checkout;

SELECT ag.id_agendamento, ag.status, ag.saida_prevista, ag.saida_real, p.minutos_atraso, p.valor
FROM AGENDAMENTO ag
INNER JOIN PENALIDADE p ON p.id_agendamento = ag.id_agendamento
WHERE ag.id_agendamento = 13;

COMMIT;

-- ======================= BLOCO B =======================
BEGIN TRANSACTION;

SELECT id_produto, nome, qtd_estoque FROM PRODUTO WHERE id_produto = 6;   -- estoque antes

INSERT INTO VENDA (id_cliente, id_recepcionista, data_hora, forma_pagamento, valor_total)
VALUES (4, 2, '2026-11-16 17:50', 'CARTAO_CREDITO', 79.90);

INSERT INTO ITEM_VENDA (id_venda, id_produto, quantidade, preco_unitario)
VALUES (last_insert_rowid(), 6, 1, 79.90);

UPDATE PRODUTO SET qtd_estoque = qtd_estoque - 1 WHERE id_produto = 6;

SELECT id_produto, nome, qtd_estoque FROM PRODUTO WHERE id_produto = 6;   -- estoque dentro da transação

ROLLBACK;   -- pagamento recusado: nada é gravado

SELECT id_produto, nome, qtd_estoque FROM PRODUTO WHERE id_produto = 6;   -- estoque volta ao original
SELECT COUNT(*) AS vendas_total FROM VENDA;                               -- continua 4
