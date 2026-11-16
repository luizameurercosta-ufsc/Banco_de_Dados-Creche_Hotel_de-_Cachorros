PRAGMA foreign_keys = ON;

-- Clientes
INSERT INTO CLIENTE (id_cliente, nome, cpf, telefone, email, endereco, data_cadastro, bloqueado) VALUES
  (1, 'Mariana Souza', '11122233344', '(48) 99911-2233', 'mariana.souza@example.com', 'Rua das Gaivotas, 120 – Lagoa da Conceição, Florianópolis/SC', '2026-07-20', 0),
  (2, 'Rafael Lima', '22233344455', '(48) 99822-3344', 'rafael.lima@example.com', 'Av. Beira-Mar Norte, 850 – Centro, Florianópolis/SC', '2026-08-02', 0),
  (3, 'Camila Ferreira', '33344455566', '(48) 99733-4455', 'camila.ferreira@example.com', 'Rua Lauro Linhares, 300 – Trindade, Florianópolis/SC', '2026-08-25', 0),
  (4, 'Bruno Oliveira', '44455566677', '(48) 99644-5566', 'bruno.oliveira@example.com', 'Rua dos Ilhéus, 45 – Centro, Florianópolis/SC', '2026-09-10', 0),
  (5, 'Juliana Martins', '55566677788', '(48) 99555-6677', 'juliana.martins@example.com', 'Rod. José Carlos Daux, 5500 – Saco Grande, Florianópolis/SC', '2026-08-28', 0),
  (6, 'Pedro Almeida', '66677788899', '(48) 99466-7788', 'pedro.almeida@example.com', 'Rua Bocaiúva, 2100 – Agronômica, Florianópolis/SC', '2026-08-10', 0);

-- Ambientes (resultado da triagem por porte e energia)
INSERT INTO AMBIENTE (id_ambiente, nome, tipo, capacidade_maxima, descricao) VALUES
  (1, 'Pátio Externo', 'EXTERNO', 8, 'Área aberta e gramada para cães grandes e de muita energia'),
  (2, 'Sala Interna Pequenos', 'INTERNO', 8, 'Sala climatizada para cães de pequeno porte'),
  (3, 'Sala Interna Calmos', 'INTERNO', 6, 'Sala climatizada e silenciosa para cães calmos e idosos');

-- Cachorros (todos castrados)
INSERT INTO CACHORRO (id_cachorro, id_cliente, id_ambiente, nome, raca, sexo, data_nascimento, porte, nivel_energia, comportamento, castrado) VALUES
  (1, 1, 1, 'Thor', 'Golden Retriever', 'M', '2021-03-12', 'GRANDE', 'ALTO', 'SOCIAVEL', 1),
  (2, 1, 2, 'Luna', 'Shih-tzu', 'F', '2020-07-05', 'PEQUENO', 'MEDIO', 'CALMO', 1),
  (3, 2, 1, 'Bob', 'Labrador', 'M', '2019-11-20', 'GRANDE', 'ALTO', 'AGITADO', 1),
  (4, 3, 2, 'Mel', 'Poodle', 'F', '2022-01-15', 'PEQUENO', 'MEDIO', 'SOCIAVEL', 1),
  (5, 4, 3, 'Fred', 'Bulldog Francês', 'M', '2021-09-30', 'MEDIO', 'BAIXO', 'CALMO', 1),
  (6, 5, 3, 'Nina', 'SRD', 'F', '2020-02-10', 'MEDIO', 'MEDIO', 'SOCIAVEL', 1),
  (7, 5, 1, 'Max', 'Border Collie', 'M', '2022-05-22', 'MEDIO', 'ALTO', 'AGITADO', 1),
  (8, 6, 2, 'Pipoca', 'Yorkshire', 'F', '2018-12-01', 'PEQUENO', 'BAIXO', 'CALMO', 1);

-- Prontuários (1 por cão)
INSERT INTO PRONTUARIO (id_prontuario, id_cachorro, data_abertura, alergias, diretrizes_emergencia, observacoes) VALUES
  (1, 1, '2026-07-20', 'Frango', 'Contatar o tutor imediatamente; em caso de engasgo ou calor excessivo, resfriar e levar à clínica Vet Ilha.', 'Muito sociável; adora água.'),
  (2, 2, '2026-07-20', NULL, 'Contatar o tutor imediatamente; clínica de referência: Vet Ilha (48) 3333-0001.', 'Evitar brincadeiras bruscas.'),
  (3, 3, '2026-08-02', NULL, 'Contatar o tutor; cão de grande porte, usar guia curta no transporte.', 'Energia alta; precisa de atividade extra.'),
  (4, 4, '2026-08-25', NULL, 'Contatar a tutora imediatamente; clínica de referência: Vet Ilha.', 'Sociável com todos.'),
  (5, 5, '2026-09-10', 'Dermatite alérgica a pulgas (DAPP)', 'Braquicefálico: em dificuldade respiratória manter em local fresco e levar imediatamente à clínica.', 'Não exercitar em horários quentes.'),
  (6, 6, '2026-08-28', NULL, 'Contatar a tutora; usa suplemento articular diário.', 'Idosa; evitar pulos.'),
  (7, 7, '2026-08-28', NULL, 'Contatar a tutora; atenção a pequenos ferimentos durante brincadeiras.', 'Muito ativo; precisa de estímulo mental.'),
  (8, 8, '2026-08-10', 'Corante artificial', 'Contatar o tutor; animal idoso, em qualquer sinal de fraqueza chamar o veterinário.', 'Sensível a barulho.');

-- Registros sanitários (protocolo: vacina, vermífugo, antipulgas)
INSERT INTO REGISTRO_SANITARIO (id_registro, id_prontuario, tipo, nome_produto, data_aplicacao, data_validade) VALUES
  (1, 1, 'VACINA', 'V10 (polivalente)', '2026-03-06', '2027-03-06'),
  (2, 1, 'VERMIFUGO', 'Drontal Plus', '2026-10-05', '2027-01-05'),
  (3, 1, 'ANTIPULGAS', 'NexGard', '2026-10-15', '2026-12-15'),
  (4, 2, 'VACINA', 'V10 (polivalente)', '2026-03-07', '2027-03-07'),
  (5, 2, 'VERMIFUGO', 'Drontal Plus', '2026-10-05', '2027-01-05'),
  (6, 2, 'ANTIPULGAS', 'NexGard', '2026-10-15', '2026-12-15'),
  (7, 3, 'VACINA', 'V10 (polivalente)', '2026-03-08', '2027-03-08'),
  (8, 3, 'VERMIFUGO', 'Drontal Plus', '2026-10-05', '2027-01-05'),
  (9, 3, 'ANTIPULGAS', 'NexGard', '2026-10-15', '2026-12-15'),
  (10, 4, 'VACINA', 'V10 (polivalente)', '2026-03-09', '2027-03-09'),
  (11, 4, 'VERMIFUGO', 'Drontal Plus', '2026-10-05', '2027-01-05'),
  (12, 4, 'ANTIPULGAS', 'NexGard', '2026-10-15', '2026-12-15'),
  (13, 5, 'VACINA', 'V10 (polivalente)', '2026-03-10', '2027-03-10'),
  (14, 5, 'VERMIFUGO', 'Drontal Plus', '2026-10-05', '2027-01-05'),
  (15, 5, 'ANTIPULGAS', 'NexGard', '2026-10-15', '2026-12-15'),
  (16, 6, 'VACINA', 'V10 (polivalente)', '2026-03-11', '2027-03-11'),
  (17, 6, 'VERMIFUGO', 'Drontal Plus', '2026-10-05', '2027-01-05'),
  (18, 6, 'ANTIPULGAS', 'NexGard', '2026-10-15', '2026-12-15'),
  (19, 7, 'VACINA', 'V10 (polivalente)', '2026-03-12', '2027-03-12'),
  (20, 7, 'VERMIFUGO', 'Drontal Plus', '2026-10-05', '2027-01-05'),
  (21, 7, 'ANTIPULGAS', 'NexGard', '2026-10-15', '2026-12-15'),
  (22, 8, 'VACINA', 'V10 (polivalente)', '2026-03-13', '2027-03-13'),
  (23, 8, 'VERMIFUGO', 'Drontal Plus', '2026-10-05', '2027-01-05'),
  (24, 8, 'ANTIPULGAS', 'NexGard', '2026-10-15', '2026-12-15'),
  (25, 1, 'VERMIFUGO', 'Drontal Plus', '2026-07-05', '2026-10-05'),
  (26, 1, 'ANTIPULGAS', 'NexGard', '2026-07-15', '2026-09-15'),
  (27, 3, 'VERMIFUGO', 'Drontal Plus', '2026-07-05', '2026-10-05'),
  (28, 3, 'ANTIPULGAS', 'NexGard', '2026-07-15', '2026-09-15'),
  (29, 5, 'VERMIFUGO', 'Drontal Plus', '2026-07-05', '2026-10-05'),
  (30, 5, 'ANTIPULGAS', 'NexGard', '2026-07-15', '2026-09-15');

-- Medicações de uso contínuo ou temporário
INSERT INTO MEDICACAO (id_medicacao, id_prontuario, nome_medicamento, dose, frequencia, data_inicio, data_fim) VALUES
  (1, 6, 'Condroitina + Glucosamina', '1 comprimido', 'Diária (manhã)', '2026-06-01', NULL),
  (2, 8, 'Prednisolona 5 mg', '1/2 comprimido', 'A cada 12 horas', '2026-11-01', '2026-11-15'),
  (3, 5, 'Colírio lubrificante', '1 gota por olho', '2 vezes ao dia', '2026-10-01', NULL);

-- Funcionários
INSERT INTO FUNCIONARIO (id_funcionario, nome, cpf, telefone, email, data_admissao, salario, ativo) VALUES
  (1, 'Carlos Eduardo Mendes', '77788899900', '(48) 99377-1001', 'carlos.mendes@creche.example.com', '2025-01-10', 9500.0, 1),
  (2, 'Ana Paula Ribeiro', '88899900011', '(48) 99377-1002', 'ana.ribeiro@creche.example.com', '2025-03-03', 2800.0, 1),
  (3, 'Lucas Barbosa', '99900011122', '(48) 99377-1003', 'lucas.barbosa@creche.example.com', '2025-06-16', 2800.0, 1),
  (4, 'Fernanda Costa', '00011122233', '(48) 99377-1004', 'fernanda.costa@creche.example.com', '2025-02-17', 2600.0, 1),
  (5, 'Rodrigo Santos', '10120230344', '(48) 99377-1005', 'rodrigo.santos@creche.example.com', '2025-04-07', 2600.0, 1),
  (6, 'Beatriz Nunes', '20230340455', '(48) 99377-1006', 'beatriz.nunes@creche.example.com', '2025-08-04', 2600.0, 1),
  (7, 'Helena Duarte', '30340450566', '(48) 99377-1007', 'helena.duarte@creche.example.com', '2025-01-20', 7200.0, 1),
  (8, 'Tiago Moreira', '40450560677', '(48) 99377-1008', 'tiago.moreira@creche.example.com', '2025-05-12', 7200.0, 1),
  (9, 'Marcos Vieira', '50560670788', '(48) 99377-1009', 'marcos.vieira@creche.example.com', '2026-02-02', 7200.0, 1);

-- Gerente (proprietário)
INSERT INTO GERENTE (id_funcionario, proprietario) VALUES
  (1, 1);

-- Recepcionistas
INSERT INTO RECEPCIONISTA (id_funcionario) VALUES
  (2),
  (3);

-- Cuidadores
INSERT INTO CUIDADOR (id_funcionario) VALUES
  (4),
  (5),
  (6);

-- Veterinários (o id 9 é o veterinário do plantão noturno do hotel, das 20:00 às 06:00)
INSERT INTO VETERINARIO (id_funcionario, crmv) VALUES
  (7, 'CRMV-SC 01234'),
  (8, 'CRMV-SC 05678'),
  (9, 'CRMV-SC 09012');

-- Parâmetros operacionais (anterior e vigente)
INSERT INTO PARAMETRO_OPERACIONAL (id_parametro, id_gerente, capacidade_maxima, max_caes_por_cuidador, hora_abertura, hora_fechamento, antecedencia_cancelamento_h, valor_penalidade_hora, vigente) VALUES
  (1, 1, 16, 4, '07:30', '18:30', 24, 25.0, 0),
  (2, 1, 20, 5, '06:00', '20:00', 24, 30.0, 1);

-- Rotinas unificadas de alimentação e sono (valem para todos os cães)
INSERT INTO ROTINA_HORARIO (id_rotina, id_parametro, tipo, horario_inicio, horario_fim, descricao) VALUES
  (1, 1, 'ALIMENTACAO', '12:00', '12:30', 'Almoço'),
  (2, 1, 'SONO', '13:00', '14:30', 'Soneca da tarde'),
  (3, 2, 'ALIMENTACAO', '08:30', '09:00', 'Café da manhã'),
  (4, 2, 'ALIMENTACAO', '12:00', '12:30', 'Almoço'),
  (5, 2, 'ALIMENTACAO', '16:30', '17:00', 'Lanche da tarde'),
  (6, 2, 'SONO', '13:00', '15:00', 'Soneca da tarde'),
  (7, 2, 'SONO', '21:00', '06:00', 'Sono noturno (hospedagem)');

-- Escalas de trabalho (veterinários de dia das 06:00 às 20:00; veterinário noturno (id 9) todas as noites das 20:00 às 06:00,
-- turno gravado em uma linha com hora_fim < hora_inicio = termina no dia seguinte)
INSERT INTO ESCALA (id_escala, id_funcionario, data, hora_inicio, hora_fim) VALUES
  (1, 9, '2026-11-01', '20:00', '06:00'),
  (2, 2, '2026-11-02', '06:00', '13:00'),
  (3, 4, '2026-11-02', '06:00', '15:00'),
  (4, 7, '2026-11-02', '06:00', '13:00'),
  (5, 1, '2026-11-02', '08:00', '17:00'),
  (6, 6, '2026-11-02', '08:00', '17:00'),
  (7, 5, '2026-11-02', '11:00', '20:00'),
  (8, 3, '2026-11-02', '13:00', '20:00'),
  (9, 8, '2026-11-02', '13:00', '20:00'),
  (10, 9, '2026-11-02', '20:00', '06:00'),
  (11, 2, '2026-11-03', '06:00', '13:00'),
  (12, 4, '2026-11-03', '06:00', '15:00'),
  (13, 8, '2026-11-03', '06:00', '13:00'),
  (14, 1, '2026-11-03', '08:00', '17:00'),
  (15, 6, '2026-11-03', '08:00', '17:00'),
  (16, 5, '2026-11-03', '11:00', '20:00'),
  (17, 3, '2026-11-03', '13:00', '20:00'),
  (18, 7, '2026-11-03', '13:00', '20:00'),
  (19, 9, '2026-11-03', '20:00', '06:00'),
  (20, 2, '2026-11-04', '06:00', '13:00'),
  (21, 4, '2026-11-04', '06:00', '15:00'),
  (22, 7, '2026-11-04', '06:00', '13:00'),
  (23, 1, '2026-11-04', '08:00', '17:00'),
  (24, 6, '2026-11-04', '08:00', '17:00'),
  (25, 5, '2026-11-04', '11:00', '20:00'),
  (26, 3, '2026-11-04', '13:00', '20:00'),
  (27, 8, '2026-11-04', '13:00', '20:00'),
  (28, 9, '2026-11-04', '20:00', '06:00'),
  (29, 2, '2026-11-05', '06:00', '13:00'),
  (30, 4, '2026-11-05', '06:00', '15:00'),
  (31, 8, '2026-11-05', '06:00', '13:00'),
  (32, 1, '2026-11-05', '08:00', '17:00'),
  (33, 6, '2026-11-05', '08:00', '17:00'),
  (34, 5, '2026-11-05', '11:00', '20:00'),
  (35, 3, '2026-11-05', '13:00', '20:00'),
  (36, 7, '2026-11-05', '13:00', '20:00'),
  (37, 9, '2026-11-05', '20:00', '06:00'),
  (38, 2, '2026-11-06', '06:00', '13:00'),
  (39, 4, '2026-11-06', '06:00', '15:00'),
  (40, 7, '2026-11-06', '06:00', '13:00'),
  (41, 1, '2026-11-06', '08:00', '17:00'),
  (42, 6, '2026-11-06', '08:00', '17:00'),
  (43, 5, '2026-11-06', '11:00', '20:00'),
  (44, 3, '2026-11-06', '13:00', '20:00'),
  (45, 8, '2026-11-06', '13:00', '20:00'),
  (46, 9, '2026-11-06', '20:00', '06:00'),
  (47, 9, '2026-11-07', '20:00', '06:00'),
  (48, 9, '2026-11-08', '20:00', '06:00'),
  (49, 2, '2026-11-09', '06:00', '13:00'),
  (50, 4, '2026-11-09', '06:00', '15:00'),
  (51, 7, '2026-11-09', '06:00', '13:00'),
  (52, 1, '2026-11-09', '08:00', '17:00'),
  (53, 6, '2026-11-09', '08:00', '17:00'),
  (54, 5, '2026-11-09', '11:00', '20:00'),
  (55, 3, '2026-11-09', '13:00', '20:00'),
  (56, 8, '2026-11-09', '13:00', '20:00'),
  (57, 9, '2026-11-09', '20:00', '06:00'),
  (58, 2, '2026-11-10', '06:00', '13:00'),
  (59, 4, '2026-11-10', '06:00', '15:00'),
  (60, 8, '2026-11-10', '06:00', '13:00'),
  (61, 1, '2026-11-10', '08:00', '17:00'),
  (62, 6, '2026-11-10', '08:00', '17:00'),
  (63, 5, '2026-11-10', '11:00', '20:00'),
  (64, 3, '2026-11-10', '13:00', '20:00'),
  (65, 7, '2026-11-10', '13:00', '20:00'),
  (66, 9, '2026-11-10', '20:00', '06:00'),
  (67, 2, '2026-11-11', '06:00', '13:00'),
  (68, 4, '2026-11-11', '06:00', '15:00'),
  (69, 7, '2026-11-11', '06:00', '13:00'),
  (70, 1, '2026-11-11', '08:00', '17:00'),
  (71, 6, '2026-11-11', '08:00', '17:00'),
  (72, 5, '2026-11-11', '11:00', '20:00'),
  (73, 3, '2026-11-11', '13:00', '20:00'),
  (74, 8, '2026-11-11', '13:00', '20:00'),
  (75, 9, '2026-11-11', '20:00', '06:00'),
  (76, 2, '2026-11-12', '06:00', '13:00'),
  (77, 4, '2026-11-12', '06:00', '15:00'),
  (78, 8, '2026-11-12', '06:00', '13:00'),
  (79, 1, '2026-11-12', '08:00', '17:00'),
  (80, 6, '2026-11-12', '08:00', '17:00'),
  (81, 5, '2026-11-12', '11:00', '20:00'),
  (82, 3, '2026-11-12', '13:00', '20:00'),
  (83, 7, '2026-11-12', '13:00', '20:00'),
  (84, 9, '2026-11-12', '20:00', '06:00'),
  (85, 2, '2026-11-13', '06:00', '13:00'),
  (86, 4, '2026-11-13', '06:00', '15:00'),
  (87, 7, '2026-11-13', '06:00', '13:00'),
  (88, 1, '2026-11-13', '08:00', '17:00'),
  (89, 6, '2026-11-13', '08:00', '17:00'),
  (90, 5, '2026-11-13', '11:00', '20:00'),
  (91, 3, '2026-11-13', '13:00', '20:00'),
  (92, 8, '2026-11-13', '13:00', '20:00'),
  (93, 9, '2026-11-13', '20:00', '06:00'),
  (94, 9, '2026-11-14', '20:00', '06:00'),
  (95, 9, '2026-11-15', '20:00', '06:00'),
  (96, 2, '2026-11-16', '06:00', '13:00'),
  (97, 4, '2026-11-16', '06:00', '15:00'),
  (98, 7, '2026-11-16', '06:00', '13:00'),
  (99, 1, '2026-11-16', '08:00', '17:00'),
  (100, 6, '2026-11-16', '08:00', '17:00'),
  (101, 5, '2026-11-16', '11:00', '20:00'),
  (102, 3, '2026-11-16', '13:00', '20:00'),
  (103, 8, '2026-11-16', '13:00', '20:00'),
  (104, 9, '2026-11-16', '20:00', '06:00'),
  (105, 2, '2026-11-17', '06:00', '13:00'),
  (106, 4, '2026-11-17', '06:00', '15:00'),
  (107, 8, '2026-11-17', '06:00', '13:00'),
  (108, 1, '2026-11-17', '08:00', '17:00'),
  (109, 6, '2026-11-17', '08:00', '17:00'),
  (110, 5, '2026-11-17', '11:00', '20:00'),
  (111, 3, '2026-11-17', '13:00', '20:00'),
  (112, 7, '2026-11-17', '13:00', '20:00'),
  (113, 9, '2026-11-17', '20:00', '06:00'),
  (114, 2, '2026-11-18', '06:00', '13:00'),
  (115, 4, '2026-11-18', '06:00', '15:00'),
  (116, 7, '2026-11-18', '06:00', '13:00'),
  (117, 1, '2026-11-18', '08:00', '17:00'),
  (118, 6, '2026-11-18', '08:00', '17:00'),
  (119, 5, '2026-11-18', '11:00', '20:00'),
  (120, 3, '2026-11-18', '13:00', '20:00'),
  (121, 8, '2026-11-18', '13:00', '20:00'),
  (122, 9, '2026-11-18', '20:00', '06:00'),
  (123, 2, '2026-11-19', '06:00', '13:00'),
  (124, 4, '2026-11-19', '06:00', '15:00'),
  (125, 8, '2026-11-19', '06:00', '13:00'),
  (126, 1, '2026-11-19', '08:00', '17:00'),
  (127, 6, '2026-11-19', '08:00', '17:00'),
  (128, 5, '2026-11-19', '11:00', '20:00'),
  (129, 3, '2026-11-19', '13:00', '20:00'),
  (130, 7, '2026-11-19', '13:00', '20:00'),
  (131, 9, '2026-11-19', '20:00', '06:00'),
  (132, 2, '2026-11-20', '06:00', '13:00'),
  (133, 4, '2026-11-20', '06:00', '15:00'),
  (134, 7, '2026-11-20', '06:00', '13:00'),
  (135, 1, '2026-11-20', '08:00', '17:00'),
  (136, 6, '2026-11-20', '08:00', '17:00'),
  (137, 5, '2026-11-20', '11:00', '20:00'),
  (138, 3, '2026-11-20', '13:00', '20:00'),
  (139, 8, '2026-11-20', '13:00', '20:00'),
  (140, 9, '2026-11-20', '20:00', '06:00');

-- Administração de medicamentos (somente veterinários)
INSERT INTO ADMINISTRACAO_MEDICAMENTO (id_administracao, id_medicacao, id_veterinario, data_hora, dose_administrada, observacoes) VALUES
  (1, 3, 7, '2026-11-04 12:00', '1 gota por olho', 'Fred em estadia; sem intercorrências.'),
  (2, 1, 7, '2026-11-09 12:00', '1 comprimido', 'Administrado após o almoço.'),
  (3, 2, 7, '2026-11-10 14:00', '1/2 comprimido', 'Pipoca aceitou bem a medicação.');

-- Atendimentos de emergência
INSERT INTO ATENDIMENTO_EMERGENCIA (id_emergencia, id_cachorro, id_veterinario, data_hora, descricao, conduta_adotada) VALUES
  (1, 7, 8, '2026-11-09 15:20', 'Pequeno corte na almofada da pata durante brincadeira no pátio.', 'Limpeza, curativo e contato imediato com a tutora; sem necessidade de encaminhamento.');

-- Serviços (diária e estadia)
INSERT INTO SERVICO (id_servico, nome, tipo, descricao, preco, ativo) VALUES
  (1, 'Diária Creche Integral', 'DIARIA', 'Permanência das 07:30 às 18:00 com alimentação e recreação', 70.0, 1),
  (2, 'Diária Meio Período', 'DIARIA', 'Permanência de até 5 horas', 45.0, 1),
  (3, 'Estadia Noturna', 'ESTADIA', 'Hospedagem com pernoite (por noite)', 110.0, 1);

-- Planos mensais
INSERT INTO PLANO (id_plano, nome, descricao, valor_mensal, ativo) VALUES
  (1, 'Plano Creche 8 Diárias', '8 diárias integrais e 4 meio período por mês', 480.0, 1),
  (2, 'Plano Creche 12 Diárias', '12 diárias integrais e 4 meio período por mês', 640.0, 1),
  (3, 'Plano Hotel e Creche', '8 diárias integrais e 4 estadias por mês', 980.0, 1);

-- Serviços inclusos em cada plano
INSERT INTO PLANO_SERVICO (id_plano, id_servico, quantidade_mensal) VALUES
  (1, 1, 8),
  (1, 2, 4),
  (2, 1, 12),
  (2, 2, 4),
  (3, 1, 8),
  (3, 3, 4);

-- Agendamentos (concluídos, futuros e um cancelado com antecedência)
INSERT INTO AGENDAMENTO (id_agendamento, id_cachorro, id_cliente, id_recepcionista, id_cuidador, id_ambiente, entrada_prevista, saida_prevista, entrada_real, saida_real, status, cancelado_em, criado_em) VALUES
  (1, 1, 1, 2, 4, 1, '2026-11-03 07:30', '2026-11-03 18:00', '2026-11-03 07:42', '2026-11-03 17:50', 'CONCLUIDO', NULL, '2026-10-28 14:00'),
  (2, 2, 1, 2, 5, 2, '2026-11-03 07:30', '2026-11-03 18:00', '2026-11-03 07:45', '2026-11-03 17:50', 'CONCLUIDO', NULL, '2026-10-28 14:05'),
  (3, 3, 2, 3, 4, 1, '2026-11-04 08:00', '2026-11-04 18:00', '2026-11-04 08:05', '2026-11-04 17:55', 'CONCLUIDO', NULL, '2026-11-02 09:10'),
  (4, 5, 4, 3, 6, 3, '2026-11-04 08:00', '2026-11-06 10:00', '2026-11-04 08:10', '2026-11-06 10:05', 'CONCLUIDO', NULL, '2026-10-30 16:20'),
  (5, 4, 3, 2, 5, 2, '2026-11-05 07:30', '2026-11-05 18:00', '2026-11-05 07:35', '2026-11-05 17:40', 'CONCLUIDO', NULL, '2026-11-01 10:00'),
  (6, 6, 5, 2, 6, 3, '2026-11-09 07:30', '2026-11-09 18:00', '2026-11-09 07:40', '2026-11-09 17:45', 'CONCLUIDO', NULL, '2026-11-04 11:00'),
  (7, 7, 5, 2, 4, 1, '2026-11-09 07:30', '2026-11-09 18:00', '2026-11-09 07:40', '2026-11-09 17:45', 'CONCLUIDO', NULL, '2026-11-04 11:02'),
  (8, 1, 1, 3, 4, 1, '2026-11-10 07:30', '2026-11-10 18:00', '2026-11-10 07:50', '2026-11-10 17:55', 'CONCLUIDO', NULL, '2026-11-05 15:00'),
  (9, 8, 6, 3, 5, 2, '2026-11-10 08:00', '2026-11-10 17:30', '2026-11-10 08:05', '2026-11-10 17:20', 'CONCLUIDO', NULL, '2026-11-05 15:30'),
  (10, 4, 3, 2, 5, 2, '2026-11-11 07:30', '2026-11-11 12:30', '2026-11-11 07:35', '2026-11-11 12:25', 'CONCLUIDO', NULL, '2026-11-06 09:00'),
  (11, 3, 2, 3, 4, 1, '2026-11-12 08:00', '2026-11-12 18:00', '2026-11-12 08:00', '2026-11-12 20:40', 'CONCLUIDO', NULL, '2026-11-09 10:20'),
  (12, 2, 1, 2, 5, 2, '2026-11-13 07:30', '2026-11-13 18:00', '2026-11-13 07:40', '2026-11-13 17:50', 'CONCLUIDO', NULL, '2026-11-09 10:25'),
  (13, 1, 1, 2, 4, 1, '2026-11-16 07:30', '2026-11-16 18:00', NULL, NULL, 'AGENDADO', NULL, '2026-11-12 11:00'),
  (14, 2, 1, 2, 5, 2, '2026-11-16 07:30', '2026-11-16 18:00', NULL, NULL, 'AGENDADO', NULL, '2026-11-12 11:02'),
  (15, 6, 5, 3, 6, 3, '2026-11-17 07:30', '2026-11-17 18:00', NULL, NULL, 'AGENDADO', NULL, '2026-11-13 15:30'),
  (16, 7, 5, 3, 4, 1, '2026-11-17 07:30', '2026-11-17 18:00', NULL, NULL, 'AGENDADO', NULL, '2026-11-13 15:32'),
  (17, 4, 3, 2, 5, 2, '2026-11-18 07:30', '2026-11-18 12:30', NULL, NULL, 'AGENDADO', NULL, '2026-11-13 17:00'),
  (18, 5, 4, 3, 6, 3, '2026-11-19 08:00', '2026-11-20 10:00', NULL, NULL, 'AGENDADO', NULL, '2026-11-10 10:00'),
  (19, 3, 2, 2, 4, 1, '2026-11-18 08:00', '2026-11-18 18:00', NULL, NULL, 'CANCELADO', '2026-11-14 15:00', '2026-11-11 09:00');

-- Serviços de cada agendamento (coberto_plano = 0 → cobrado à parte)
INSERT INTO AGENDAMENTO_SERVICO (id_agendamento, id_servico, quantidade, preco_unitario, coberto_plano) VALUES
  (1, 1, 1, 70.0, 1),
  (2, 1, 1, 70.0, 1),
  (3, 1, 1, 70.0, 0),
  (4, 3, 2, 110.0, 0),
  (5, 1, 1, 70.0, 1),
  (6, 1, 1, 70.0, 1),
  (7, 1, 1, 70.0, 1),
  (8, 1, 1, 70.0, 1),
  (9, 1, 1, 70.0, 1),
  (10, 2, 1, 45.0, 1),
  (11, 1, 1, 70.0, 0),
  (12, 1, 1, 70.0, 1),
  (13, 1, 1, 70.0, 1),
  (14, 1, 1, 70.0, 1),
  (15, 1, 1, 70.0, 1),
  (16, 1, 1, 70.0, 1),
  (17, 2, 1, 45.0, 1),
  (18, 3, 1, 110.0, 0),
  (19, 1, 1, 70.0, 0);

-- Penalidades por atraso (retirada às 20:40, 40 min após o fechamento das 20:00; R$ 30,00/h → R$ 20,00)
INSERT INTO PENALIDADE (id_penalidade, id_agendamento, tipo, minutos_atraso, valor, pago) VALUES
  (1, 11, 'ATRASO_RETIRADA', 40, 20.0, 1);

-- Produtos
INSERT INTO PRODUTO (id_produto, nome, categoria, descricao, preco_venda, qtd_estoque, estoque_minimo) VALUES
  (1, 'Ração Super Premium Adultos Porte Pequeno 10 kg', 'RACAO', 'Ração seca para cães adultos de raças pequenas', 189.9, 12, 5),
  (2, 'Ração Super Premium Adultos Médio/Grande 15 kg', 'RACAO', 'Ração seca para cães adultos de raças médias e grandes', 249.9, 7, 4),
  (3, 'Bola de Borracha Maciça', 'BRINQUEDO', 'Bola resistente para mordida', 24.9, 28, 10),
  (4, 'Corda de Algodão', 'BRINQUEDO', 'Corda trançada para cabo de guerra', 19.9, 3, 8),
  (5, 'Coleira Ajustável M', 'ACESSORIO', 'Coleira de nylon ajustável tamanho M', 39.9, 14, 5),
  (6, 'Peitoral Anti-Puxão G', 'ACESSORIO', 'Peitoral ergonômico tamanho G', 79.9, 6, 3),
  (7, 'Comedouro Inox', 'ACESSORIO', 'Comedouro de aço inoxidável 700 ml', 34.9, 9, 4);

-- Fornecedores
INSERT INTO FORNECEDOR (id_fornecedor, razao_social, cnpj, telefone, email, endereco) VALUES
  (1, 'PetFood Distribuidora Sul Ltda', '12345678000190', '(48) 3222-1000', 'vendas@petfoodsul.example.com', 'Rod. SC-401, 3000 – Florianópolis/SC'),
  (2, 'Mundo Pet Acessórios Ltda', '23456789000101', '(48) 3222-2000', 'comercial@mundopet.example.com', 'Rua Felipe Schmidt, 700 – Florianópolis/SC');

-- Fornecimento (qual fornecedor vende qual produto e a que custo)
INSERT INTO FORNECIMENTO (id_fornecedor, id_produto, preco_custo) VALUES
  (1, 1, 140.0),
  (1, 2, 190.0),
  (2, 3, 12.0),
  (2, 4, 9.0),
  (2, 5, 22.0),
  (2, 6, 45.0),
  (2, 7, 18.0);

-- Compras de reposição (gerente)
INSERT INTO COMPRA (id_compra, id_fornecedor, id_gerente, data_compra, status, valor_total) VALUES
  (1, 1, 1, '2026-10-20', 'RECEBIDA', 2920.0),
  (2, 2, 1, '2026-10-27', 'RECEBIDA', 906.0),
  (3, 2, 1, '2026-11-13', 'PENDENTE', 300.0);

-- Itens das compras
INSERT INTO ITEM_COMPRA (id_compra, id_produto, quantidade, preco_unitario) VALUES
  (1, 1, 10, 140.0),
  (1, 2, 8, 190.0),
  (2, 5, 15, 22.0),
  (2, 6, 8, 45.0),
  (2, 7, 12, 18.0),
  (3, 4, 20, 9.0),
  (3, 3, 10, 12.0);

-- Vendas de balcão (recepcionista)
INSERT INTO VENDA (id_venda, id_cliente, id_recepcionista, data_hora, forma_pagamento, valor_total) VALUES
  (1, 1, 2, '2026-11-03 17:55', 'PIX', 24.9),
  (2, 5, 3, '2026-11-09 17:50', 'CARTAO_CREDITO', 74.8),
  (3, 2, 2, '2026-11-10 08:10', 'DINHEIRO', 249.9),
  (4, 3, 3, '2026-11-13 17:35', 'PIX', 239.7);

-- Itens das vendas
INSERT INTO ITEM_VENDA (id_venda, id_produto, quantidade, preco_unitario) VALUES
  (1, 3, 1, 24.9),
  (2, 5, 1, 39.9),
  (2, 7, 1, 34.9),
  (3, 2, 1, 249.9),
  (4, 1, 1, 189.9),
  (4, 3, 2, 24.9);

-- Alimentação (ração e quantidade ideal por cão)
INSERT INTO ALIMENTACAO (id_cachorro, id_produto, quantidade_diaria_g, refeicoes_dia, observacoes) VALUES
  (1, 2, 400, 2, 'Adicionar água morna no almoço'),
  (2, 1, 80, 2, NULL),
  (3, 2, 450, 2, 'Comer devagar: usar comedouro lento'),
  (4, 1, 70, 2, NULL),
  (5, 2, 250, 2, 'Evitar excesso por tendência a ganhar peso'),
  (6, 2, 300, 2, 'Ração com suplemento articular'),
  (7, 2, 350, 2, NULL),
  (8, 1, 50, 2, 'Ração sem corante artificial (alergia)');

-- Assinaturas (mensalidades de clientes fixos)
INSERT INTO ASSINATURA (id_assinatura, id_cliente, id_plano, data_inicio, data_fim, status) VALUES
  (1, 1, 1, '2026-08-01', NULL, 'ATIVA'),
  (2, 3, 2, '2026-09-01', NULL, 'ATIVA'),
  (3, 5, 3, '2026-09-01', NULL, 'ATIVA'),
  (4, 6, 1, '2026-08-15', NULL, 'SUSPENSA');

-- Mensalidades (a atrasada bloqueia automaticamente o cliente via gatilho)
INSERT INTO MENSALIDADE (id_mensalidade, id_assinatura, competencia, vencimento, valor, data_pagamento, status) VALUES
  (1, 1, '2026-09', '2026-09-05', 480.0, '2026-09-03', 'PAGA'),
  (2, 1, '2026-10', '2026-10-05', 480.0, '2026-10-04', 'PAGA'),
  (3, 1, '2026-11', '2026-11-05', 480.0, '2026-11-03', 'PAGA'),
  (4, 2, '2026-09', '2026-09-10', 640.0, '2026-09-08', 'PAGA'),
  (5, 2, '2026-10', '2026-10-10', 640.0, '2026-10-09', 'PAGA'),
  (6, 2, '2026-11', '2026-11-10', 640.0, '2026-11-09', 'PAGA'),
  (7, 3, '2026-09', '2026-09-10', 980.0, '2026-09-10', 'PAGA'),
  (8, 3, '2026-10', '2026-10-10', 980.0, '2026-10-10', 'PAGA'),
  (9, 3, '2026-11', '2026-11-10', 980.0, '2026-11-12', 'PAGA'),
  (10, 4, '2026-08', '2026-08-20', 480.0, '2026-08-19', 'PAGA'),
  (11, 4, '2026-09', '2026-09-20', 480.0, '2026-09-20', 'PAGA'),
  (12, 4, '2026-10', '2026-10-20', 480.0, '2026-10-20', 'PAGA'),
  (13, 4, '2026-11', '2026-11-10', 480.0, NULL, 'ATRASADA');

-- Cliente com mensalidade em atraso fica bloqueado (o gatilho de MENSALIDADE já faz isso ao inserir a mensalidade
-- ATRASADA; o comando abaixo deixa o estado explícito e idêntico ao do banco). O cliente 6 não é bloqueado no INSERT
-- de CLIENTE porque suas reservas (agendamentos 9) são anteriores ao atraso e o gatilho de agendamento as barraria.
UPDATE CLIENTE SET bloqueado = 1 WHERE id_cliente = 6;
