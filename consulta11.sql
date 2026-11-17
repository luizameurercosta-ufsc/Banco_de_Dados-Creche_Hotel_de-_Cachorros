--- Consulta 11: Transações com COMMIT, ROLLBACK e SAVEPOINT
--- Objetivo: demonstrar o controle transacional em quatro operações do dia a dia da creche.
---   Bloco A (SAVEPOINT + ROLLBACK TO + COMMIT): registrar a retirada atrasada do agendamento 13.
---           Um checkout errado é feito e desfeito com ROLLBACK TO; depois a saída correta é gravada,
---           a penalidade é calculada (minutos/60 x valor da hora vigente em PARAMETRO_OPERACIONAL)
---           e tudo é confirmado com COMMIT.
---   Bloco B (SAVEPOINT + ROLLBACK TO + COMMIT): venda de balcão com baixa de estoque. A baixa é feita
---           com quantidade errada, desfeita com ROLLBACK TO, refeita corretamente e confirmada.
---   Bloco C (ROLLBACK total): venda cuja baixa de estoque é descartada por completo (pagamento recusado).
---   Bloco D (ROLLBACK total): cancelamento do agendamento 17 desfeito por não respeitar a antecedência
---           mínima de 24 h (antecedencia_cancelamento_h em PARAMETRO_OPERACIONAL).
--- Obs.: os Blocos A e B gravam dados de forma definitiva (COMMIT); execute em uma cópia do banco
--- ou restaure o original para repetir o teste. Os Blocos C e D não deixam alterações.
--- Técnicas: BEGIN, SAVEPOINT, ROLLBACK TO, RELEASE, COMMIT, ROLLBACK, subconsulta escalar.

-- ======================= BLOCO A (SAVEPOINT + COMMIT) =======================
BEGIN TRANSACTION;

UPDATE AGENDAMENTO
   SET entrada_real = '2026-11-16 07:40',
       status       = 'EM_ANDAMENTO'
 WHERE id_agendamento = 13;

SAVEPOINT sp_checkout;

-- saída registrada por engano (horário errado) -> será desfeita
UPDATE AGENDAMENTO
   SET saida_real = '2026-11-16 17:00',
       status     = 'CONCLUIDO'
 WHERE id_agendamento = 13;

SELECT id_agendamento, status, entrada_real, saida_real FROM AGENDAMENTO WHERE id_agendamento = 13;

ROLLBACK TO sp_checkout;   -- desfaz só o checkout errado; o check-in continua na transação

-- checkout correto (retirada às 19:30, 90 min depois do previsto)
UPDATE AGENDAMENTO
   SET saida_real = '2026-11-16 19:30',
       status     = 'CONCLUIDO'
 WHERE id_agendamento = 13;

INSERT INTO PENALIDADE (id_agendamento, tipo, minutos_atraso, valor, pago)
SELECT ag.id_agendamento,
       'ATRASO_RETIRADA',
       CAST(ROUND((julianday(ag.saida_real) - julianday(ag.saida_prevista)) * 1440) AS INTEGER),
       ROUND((julianday(ag.saida_real) - julianday(ag.saida_prevista)) * 24
             * (SELECT valor_penalidade_hora FROM PARAMETRO_OPERACIONAL WHERE vigente = 1), 2),
       0
FROM   AGENDAMENTO ag
WHERE  ag.id_agendamento = 13;

RELEASE SAVEPOINT sp_checkout;

SELECT ag.id_agendamento, ag.status, ag.saida_prevista, ag.saida_real, p.minutos_atraso, p.valor
FROM   AGENDAMENTO ag
INNER JOIN PENALIDADE p ON p.id_agendamento = ag.id_agendamento
WHERE  ag.id_agendamento = 13;

COMMIT;

-- ======================= BLOCO B (SAVEPOINT + COMMIT) =======================
BEGIN TRANSACTION;

INSERT INTO VENDA (id_cliente, id_recepcionista, data_hora, forma_pagamento, valor_total)
VALUES (4, 2, '2026-11-16 17:50', 'PIX', 79.90);

INSERT INTO ITEM_VENDA (id_venda, id_produto, quantidade, preco_unitario)
VALUES (last_insert_rowid(), 6, 1, 79.90);

SAVEPOINT sp_estoque;

-- baixa de estoque com quantidade errada (5 em vez de 1) -> será desfeita
UPDATE PRODUTO SET qtd_estoque = qtd_estoque - 5 WHERE id_produto = 6;

SELECT id_produto, nome, qtd_estoque FROM PRODUTO WHERE id_produto = 6;   -- 1 (errado)

ROLLBACK TO sp_estoque;   -- a venda continua; só a baixa errada é desfeita

UPDATE PRODUTO SET qtd_estoque = qtd_estoque - 1 WHERE id_produto = 6;

RELEASE SAVEPOINT sp_estoque;

SELECT id_produto, nome, qtd_estoque FROM PRODUTO WHERE id_produto = 6;   -- 5 (correto)

COMMIT;

-- ======================= BLOCO C (ROLLBACK total) =======================
BEGIN TRANSACTION;

SELECT id_produto, nome, qtd_estoque FROM PRODUTO WHERE id_produto = 7;   -- estoque antes

INSERT INTO VENDA (id_cliente, id_recepcionista, data_hora, forma_pagamento, valor_total)
VALUES (3, 3, '2026-11-16 18:05', 'CARTAO_CREDITO', 34.90);

INSERT INTO ITEM_VENDA (id_venda, id_produto, quantidade, preco_unitario)
VALUES (last_insert_rowid(), 7, 1, 34.90);

UPDATE PRODUTO SET qtd_estoque = qtd_estoque - 1 WHERE id_produto = 7;

SELECT id_produto, nome, qtd_estoque FROM PRODUTO WHERE id_produto = 7;   -- estoque dentro da transação

ROLLBACK;   -- pagamento recusado: nada é gravado

SELECT id_produto, nome, qtd_estoque FROM PRODUTO WHERE id_produto = 7;   -- volta ao valor original

-- ======================= BLOCO D (ROLLBACK total) =======================
BEGIN TRANSACTION;

UPDATE AGENDAMENTO
   SET status       = 'CANCELADO',
       cancelado_em = '2026-11-17 22:00'
 WHERE id_agendamento = 17;     -- reserva de 18/11 às 07:30 cancelada na véspera às 22:00: só 9,5 h de antecedência

SELECT a.id_agendamento, a.status, a.entrada_prevista,
       ROUND((julianday(a.entrada_prevista) - julianday(a.cancelado_em)) * 24, 1) AS horas_de_antecedencia,
       (SELECT antecedencia_cancelamento_h FROM PARAMETRO_OPERACIONAL WHERE vigente = 1) AS minimo_exigido_h
FROM   AGENDAMENTO a
WHERE  a.id_agendamento = 17;

ROLLBACK;   -- antecedência mínima não respeitada: cancelamento descartado

SELECT id_agendamento, status, cancelado_em FROM AGENDAMENTO WHERE id_agendamento = 17;   -- continua AGENDADO
