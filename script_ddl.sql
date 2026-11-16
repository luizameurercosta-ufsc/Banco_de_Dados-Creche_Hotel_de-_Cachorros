PRAGMA foreign_keys = ON;

-- ---------------------------------------------------------------------
-- Limpeza (permite rodar o script várias vezes)
-- ---------------------------------------------------------------------
DROP VIEW  IF EXISTS vw_produtos_estoque_baixo;
DROP VIEW  IF EXISTS vw_cobertura_veterinaria;
DROP TABLE IF EXISTS ROTINA_HORARIO;
DROP TABLE IF EXISTS PARAMETRO_OPERACIONAL;
DROP TABLE IF EXISTS ALIMENTACAO;
DROP TABLE IF EXISTS ITEM_VENDA;
DROP TABLE IF EXISTS VENDA;
DROP TABLE IF EXISTS ITEM_COMPRA;
DROP TABLE IF EXISTS COMPRA;
DROP TABLE IF EXISTS FORNECIMENTO;
DROP TABLE IF EXISTS FORNECEDOR;
DROP TABLE IF EXISTS PRODUTO;
DROP TABLE IF EXISTS MENSALIDADE;
DROP TABLE IF EXISTS ASSINATURA;
DROP TABLE IF EXISTS PLANO_SERVICO;
DROP TABLE IF EXISTS PLANO;
DROP TABLE IF EXISTS PENALIDADE;
DROP TABLE IF EXISTS AGENDAMENTO_SERVICO;
DROP TABLE IF EXISTS AGENDAMENTO;
DROP TABLE IF EXISTS SERVICO;
DROP TABLE IF EXISTS ESCALA;
DROP TABLE IF EXISTS ATENDIMENTO_EMERGENCIA;
DROP TABLE IF EXISTS ADMINISTRACAO_MEDICAMENTO;
DROP TABLE IF EXISTS VETERINARIO;
DROP TABLE IF EXISTS CUIDADOR;
DROP TABLE IF EXISTS RECEPCIONISTA;
DROP TABLE IF EXISTS GERENTE;
DROP TABLE IF EXISTS FUNCIONARIO;
DROP TABLE IF EXISTS MEDICACAO;
DROP TABLE IF EXISTS REGISTRO_SANITARIO;
DROP TABLE IF EXISTS PRONTUARIO;
DROP TABLE IF EXISTS CACHORRO;
DROP TABLE IF EXISTS AMBIENTE;
DROP TABLE IF EXISTS CLIENTE;

-- =====================================================================
CREATE TABLE CLIENTE (
    id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE CHECK (length(cpf) = 11 AND cpf NOT GLOB '*[^0-9]*'),
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE CHECK (email IS NULL OR email LIKE '%_@_%._%'),
    endereco VARCHAR(200),
    data_cadastro DATE NOT NULL DEFAULT (date('now', 'localtime')),
    bloqueado BOOLEAN NOT NULL DEFAULT 0 CHECK (bloqueado IN (0, 1))
);

CREATE TABLE CACHORRO (
    id_cachorro INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente INTEGER NOT NULL,
    id_ambiente INTEGER NOT NULL,
    nome VARCHAR(60) NOT NULL,
    raca VARCHAR(60),
    sexo CHAR(1) NOT NULL CHECK (sexo IN ('M', 'F')),
    data_nascimento DATE,
    porte VARCHAR(10) NOT NULL CHECK (porte IN ('PEQUENO', 'MEDIO', 'GRANDE')),
    nivel_energia VARCHAR(10) NOT NULL CHECK (nivel_energia IN ('BAIXO', 'MEDIO', 'ALTO')),
    comportamento VARCHAR(20) NOT NULL,
    castrado BOOLEAN NOT NULL DEFAULT 1 CHECK (castrado = 1),
    FOREIGN KEY (id_cliente)  REFERENCES CLIENTE (id_cliente)
        ON UPDATE CASCADE ON DELETE RESTRICT,
   FOREIGN KEY (id_ambiente) REFERENCES AMBIENTE (id_ambiente)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE AMBIENTE (
    id_ambiente INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(50) NOT NULL UNIQUE,
    tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('INTERNO', 'EXTERNO')),
    capacidade_maxima INTEGER NOT NULL CHECK (capacidade_maxima > 0),
    descricao VARCHAR(200)
    );

CREATE TABLE PRONTUARIO (
    id_prontuario INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cachorro INTEGER NOT NULL UNIQUE,
    data_abertura DATE NOT NULL DEFAULT (date('now', 'localtime')),
    alergias VARCHAR(300),
    diretrizes_emergencia VARCHAR(500) NOT NULL,
    observacoes VARCHAR(500),
    FOREIGN KEY (id_cachorro) REFERENCES CACHORRO (id_cachorro)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE REGISTRO_SANITARIO (
    id_registro INTEGER PRIMARY KEY AUTOINCREMENT,
    id_prontuario INTEGER NOT NULL,
    tipo VARCHAR(15) NOT NULL CHECK (tipo IN ('VACINA', 'VERMIFUGO', 'ANTIPULGAS')),
    nome_produto VARCHAR(80) NOT NULL,
    data_aplicacao DATE NOT NULL,
    data_validade DATE NOT NULL CHECK (data_validade >= data_aplicacao),
    FOREIGN KEY (id_prontuario) REFERENCES PRONTUARIO (id_prontuario)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE MEDICACAO (
    id_medicacao INTEGER PRIMARY KEY AUTOINCREMENT,
    id_prontuario INTEGER NOT NULL,
    nome_medicamento VARCHAR(80) NOT NULL,
    dose VARCHAR(40) NOT NULL,
    frequencia VARCHAR(40) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    FOREIGN KEY (id_prontuario) REFERENCES PRONTUARIO (id_prontuario)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE FUNCIONARIO (
    id_funcionario INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE CHECK (length(cpf) = 11 AND cpf NOT GLOB '*[^0-9]*'),
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE,
    data_admissao DATE NOT NULL,
    salario DECIMAL(10,2) NOT NULL CHECK (salario > 0),
    ativo BOOLEAN NOT NULL DEFAULT 1 CHECK (ativo IN (0, 1))
);

CREATE TABLE GERENTE (
    id_funcionario INTEGER PRIMARY KEY,
    proprietario BOOLEAN NOT NULL DEFAULT 0 CHECK (proprietario IN (0, 1)),
    FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO (id_funcionario)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE RECEPCIONISTA (
    id_funcionario INTEGER PRIMARY KEY,
    FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO (id_funcionario)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE CUIDADOR (
    id_funcionario INTEGER PRIMARY KEY,
    FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO (id_funcionario)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE VETERINARIO (
    id_funcionario INTEGER PRIMARY KEY,
    crmv VARCHAR(20) NOT NULL UNIQUE,
    FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO (id_funcionario)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ESCALA (
    id_escala INTEGER PRIMARY KEY AUTOINCREMENT,
    id_funcionario INTEGER NOT NULL,
    data DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO (id_funcionario)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- depende veterinário
CREATE TABLE ADMINISTRACAO_MEDICAMENTO (
    id_administracao INTEGER PRIMARY KEY AUTOINCREMENT,
    id_medicacao INTEGER NOT NULL,
    id_veterinario INTEGER NOT NULL,
    data_hora DATETIME NOT NULL,
    dose_administrada VARCHAR(40) NOT NULL,
    observacoes VARCHAR(300),
    FOREIGN KEY (id_medicacao) REFERENCES MEDICACAO (id_medicacao)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_veterinario) REFERENCES VETERINARIO (id_funcionario)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE ATENDIMENTO_EMERGENCIA (
    id_emergencia INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cachorro INTEGER NOT NULL,
    id_veterinario INTEGER NOT NULL,
    data_hora DATETIME NOT NULL,
    descricao VARCHAR(500) NOT NULL,
    conduta_adotada VARCHAR(500),
    FOREIGN KEY (id_cachorro) REFERENCES CACHORRO (id_cachorro)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_veterinario) REFERENCES VETERINARIO (id_funcionario)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE SERVICO (
    id_servico INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(60) NOT NULL UNIQUE,
    tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('DIARIA', 'ESTADIA')),
    descricao VARCHAR(200),
    preco DECIMAL(10,2) NOT NULL CHECK (preco >= 0),
    ativo BOOLEAN NOT NULL DEFAULT 1 CHECK (ativo IN (0, 1))
);

CREATE TABLE AGENDAMENTO (
    id_agendamento INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cachorro INTEGER NOT NULL,
    id_cliente INTEGER NOT NULL,
    id_recepcionista INTEGER NOT NULL,
    id_cuidador INTEGER NOT NULL,
    id_ambiente INTEGER NOT NULL,
    entrada_prevista DATETIME NOT NULL,
    saida_prevista DATETIME NOT NULL,
    entrada_real DATETIME,
    saida_real DATETIME,
    status VARCHAR(15) NOT NULL DEFAULT 'AGENDADO' CHECK (status IN ('AGENDADO', 'EM_ANDAMENTO', 'CONCLUIDO', 'CANCELADO')),
    cancelado_em DATETIME ,
    CHECK (
        (status = 'CANCELADO' AND cancelado_em IS NOT NULL) OR
        (status <> 'CANCELADO' AND cancelado_em IS NULL)),
    criado_em DATETIME NOT NULL DEFAULT (datetime('now', 'localtime')),
    FOREIGN KEY (id_cachorro) REFERENCES CACHORRO (id_cachorro)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente)
        ON UPDATE CASCADE ON DELETE RESTRICT,
   FOREIGN KEY (id_recepcionista) REFERENCES RECEPCIONISTA (id_funcionario)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_cuidador) REFERENCES CUIDADOR (id_funcionario)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_ambiente) REFERENCES AMBIENTE (id_ambiente)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE AGENDAMENTO_SERVICO (
    id_agendamento INTEGER NOT NULL,
    id_servico INTEGER NOT NULL,
    quantidade INTEGER NOT NULL DEFAULT 1 CHECK (quantidade > 0),
    preco_unitario DECIMAL(10,2) NOT NULL CHECK (preco_unitario >= 0),
    coberto_plano BOOLEAN NOT NULL DEFAULT 0 CHECK (coberto_plano IN (0, 1)),
    PRIMARY KEY (id_agendamento, id_servico),
    FOREIGN KEY (id_agendamento) REFERENCES AGENDAMENTO (id_agendamento)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_servico) REFERENCES SERVICO (id_servico)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE PENALIDADE (
    id_penalidade INTEGER PRIMARY KEY AUTOINCREMENT,
    id_agendamento INTEGER NOT NULL,
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('ATRASO_ENTREGA', 'ATRASO_RETIRADA')),
    minutos_atraso INTEGER NOT NULL CHECK (minutos_atraso > 0),
    valor DECIMAL(10,2) NOT NULL CHECK (valor >= 0),
    pago BOOLEAN NOT NULL DEFAULT 0 CHECK (pago IN (0, 1)),
    FOREIGN KEY (id_agendamento) REFERENCES AGENDAMENTO (id_agendamento)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE PLANO (
    id_plano INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(60) NOT NULL UNIQUE,
    descricao VARCHAR(200),
    valor_mensal DECIMAL(10,2) NOT NULL CHECK (valor_mensal > 0),
    ativo BOOLEAN NOT NULL DEFAULT 1 CHECK (ativo IN (0, 1))
);

CREATE TABLE PLANO_SERVICO (
    id_plano INTEGER NOT NULL,
    id_servico INTEGER NOT NULL,
    quantidade_mensal INTEGER NOT NULL CHECK (quantidade_mensal > 0),
    PRIMARY KEY (id_plano, id_servico),
    FOREIGN KEY (id_plano) REFERENCES PLANO (id_plano)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_servico) REFERENCES SERVICO (id_servico)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE ASSINATURA (
    id_assinatura INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente INTEGER NOT NULL,
    id_plano INTEGER NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE CHECK (data_fim IS NULL OR data_fim >= data_inicio),
    status VARCHAR(10) NOT NULL DEFAULT 'ATIVA' CHECK (status IN ('ATIVA', 'SUSPENSA', 'CANCELADA')),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_plano) REFERENCES PLANO (id_plano)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE MENSALIDADE (
    id_mensalidade INTEGER PRIMARY KEY AUTOINCREMENT,
    id_assinatura INTEGER NOT NULL,
    competencia CHAR(7) NOT NULL CHECK (competencia GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]'), -- 'AAAA-MM'
    vencimento DATE NOT NULL,
    valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),
    data_pagamento DATE,
    status VARCHAR(10) NOT NULL DEFAULT 'PENDENTE' CHECK (status IN ('PENDENTE', 'PAGA', 'ATRASADA')),
    UNIQUE (id_assinatura, competencia),
    FOREIGN KEY (id_assinatura) REFERENCES ASSINATURA (id_assinatura)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE PRODUTO (
    id_produto INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(80) NOT NULL,
    categoria VARCHAR(10) NOT NULL CHECK (categoria IN ('ACESSORIO', 'BRINQUEDO', 'RACAO')),
    descricao VARCHAR(200),
    preco_venda DECIMAL(10,2) NOT NULL CHECK (preco_venda >= 0),
    qtd_estoque INTEGER NOT NULL DEFAULT 0 CHECK (qtd_estoque >= 0),
    estoque_minimo INTEGER NOT NULL DEFAULT 0 CHECK (estoque_minimo >= 0)
);

CREATE TABLE FORNECEDOR (
    id_fornecedor INTEGER PRIMARY KEY AUTOINCREMENT,
    razao_social VARCHAR(100) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE CHECK (length(cnpj) = 14 AND cnpj NOT GLOB '*[^0-9]*'),
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    endereco VARCHAR(200)
);

CREATE TABLE FORNECIMENTO (
    id_fornecedor INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    preco_custo DECIMAL(10,2) NOT NULL CHECK (preco_custo >= 0),
    PRIMARY KEY (id_fornecedor, id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES FORNECEDOR (id_fornecedor)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES PRODUTO (id_produto)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE COMPRA (
    id_compra INTEGER PRIMARY KEY AUTOINCREMENT,
    id_fornecedor INTEGER NOT NULL,
    id_gerente INTEGER NOT NULL,
    data_compra DATE NOT NULL,
    status VARCHAR(10) NOT NULL DEFAULT 'PENDENTE' CHECK (status IN ('PENDENTE', 'RECEBIDA', 'CANCELADA')),
    valor_total DECIMAL(10,2)  NOT NULL CHECK (valor_total >= 0),
    FOREIGN KEY (id_fornecedor) REFERENCES FORNECEDOR (id_fornecedor)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_gerente) REFERENCES GERENTE (id_funcionario)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE ITEM_COMPRA (
    id_compra INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    preco_unitario DECIMAL(10,2) NOT NULL CHECK (preco_unitario >= 0),
    PRIMARY KEY (id_compra, id_produto),
    FOREIGN KEY (id_compra) REFERENCES COMPRA (id_compra)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES PRODUTO (id_produto)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE VENDA (
    id_venda INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente INTEGER NOT NULL,
    id_recepcionista INTEGER NOT NULL,
    data_hora DATETIME NOT NULL,
    forma_pagamento VARCHAR(15) NOT NULL CHECK (forma_pagamento IN ('DINHEIRO', 'PIX', 'CARTAO_CREDITO', 'CARTAO_DEBITO')),
    valor_total DECIMAL(10,2) NOT NULL CHECK (valor_total >= 0),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_recepcionista) REFERENCES RECEPCIONISTA (id_funcionario)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE ITEM_VENDA (
    id_venda INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    preco_unitario DECIMAL(10,2) NOT NULL CHECK (preco_unitario >= 0),
    PRIMARY KEY (id_venda, id_produto),
    FOREIGN KEY (id_venda) REFERENCES VENDA (id_venda)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES PRODUTO (id_produto)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE ALIMENTACAO (
    id_cachorro INTEGER NOT NULL,
    id_produto INTEGER NOT NULL, -- ração (categoria RACAO)
    quantidade_diaria_g INTEGER NOT NULL CHECK (quantidade_diaria_g > 0),
    refeicoes_dia INTEGER NOT NULL CHECK (refeicoes_dia BETWEEN 1 AND 3),
    observacoes VARCHAR(200),
    PRIMARY KEY (id_cachorro, id_produto),
    FOREIGN KEY (id_cachorro) REFERENCES CACHORRO (id_cachorro)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES PRODUTO (id_produto)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE PARAMETRO_OPERACIONAL (
    id_parametro INTEGER PRIMARY KEY AUTOINCREMENT,
    id_gerente INTEGER NOT NULL,
    capacidade_maxima INTEGER NOT NULL CHECK (capacidade_maxima > 0),
    max_caes_por_cuidador INTEGER NOT NULL CHECK (max_caes_por_cuidador > 0),
    hora_abertura TIME NOT NULL,
    hora_fechamento TIME NOT NULL CHECK (hora_fechamento > hora_abertura),
    antecedencia_cancelamento_h INTEGER NOT NULL CHECK (antecedencia_cancelamento_h >= 0),
    valor_penalidade_hora DECIMAL(10,2) NOT NULL CHECK (valor_penalidade_hora >= 0),
    vigente BOOLEAN NOT NULL DEFAULT 1 CHECK (vigente IN (0, 1)),
    FOREIGN KEY (id_gerente) REFERENCES GERENTE (id_funcionario)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Só pode existir apenas um conjunto de parâmetros ativo por vez
CREATE UNIQUE INDEX ux_parametro_vigente ON PARAMETRO_OPERACIONAL (vigente) WHERE vigente = 1;

CREATE TABLE ROTINA_HORARIO (
    id_rotina INTEGER PRIMARY KEY AUTOINCREMENT,
    id_parametro INTEGER NOT NULL,
    tipo VARCHAR(12) NOT NULL CHECK (tipo IN ('ALIMENTACAO', 'SONO')),
    horario_inicio TIME NOT NULL,
    horario_fim TIME,
    descricao VARCHAR(100),
    FOREIGN KEY (id_parametro) REFERENCES PARAMETRO_OPERACIONAL (id_parametro)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ck_rotina_tipo CHECK (tipo IN ('ALIMENTACAO', 'SONO'))
);


-- =====================================================================
-- REGRAS DE NEGÓCIO IMPLEMENTADAS
-- =====================================================================

-- VISÕES (criam consultas virtuais prontas para alertar a gestão)

-- Regra: estoque mínimo de produtos (apoia as compras com fornecedor)
CREATE VIEW vw_produtos_estoque_baixo AS
SELECT id_produto, nome, categoria, qtd_estoque, estoque_minimo,
       (estoque_minimo - qtd_estoque) AS falta
FROM PRODUTO
WHERE qtd_estoque < estoque_minimo;

-- Regra: sempre deve haver um veterinário em horário de trabalho.
-- Lista, por data, os veterinários escalados (confira se cobrem toda a abertura).
CREATE VIEW vw_cobertura_veterinaria AS
SELECT e.data, e.hora_inicio, e.hora_fim, f.nome AS veterinario, v.crmv
FROM ESCALA e
JOIN VETERINARIO v ON v.id_funcionario = e.id_funcionario
JOIN FUNCIONARIO f ON f.id_funcionario = v.id_funcionario
ORDER BY e.data, e.hora_inicio;


-- GATILHOS

-- R0b: a saída prevista deve ser posterior à entrada prevista
CREATE TRIGGER trg_agend_periodo_valido_ins
BEFORE INSERT ON AGENDAMENTO
WHEN NEW.saida_prevista <= NEW.entrada_prevista
BEGIN
    SELECT RAISE(ABORT, 'A saída prevista deve ser posterior à entrada prevista.');
END;

-- R1: o cliente do agendamento deve ser o dono do cão
CREATE TRIGGER trg_agend_cliente_dono
BEFORE INSERT ON AGENDAMENTO
WHEN (SELECT id_cliente FROM CACHORRO WHERE id_cachorro = NEW.id_cachorro) <> NEW.id_cliente
BEGIN
    SELECT RAISE(ABORT, 'O cliente informado não é o dono do cachorro.');
END;

-- R2: cliente bloqueado (mensalidade em atraso) não pode fazer novas reservas
CREATE TRIGGER trg_agend_cliente_bloqueado
BEFORE INSERT ON AGENDAMENTO
WHEN (SELECT bloqueado FROM CLIENTE WHERE id_cliente = NEW.id_cliente) = 1
BEGIN
    SELECT RAISE(ABORT, 'Cliente bloqueado por pendência financeira: novas reservas não são permitidas.');
END;

-- R3: entrada e saída previstas devem respeitar o horário de funcionamento
CREATE TRIGGER trg_agend_horario_funcionamento
BEFORE INSERT ON AGENDAMENTO
WHEN NOT EXISTS (
    SELECT 1 FROM PARAMETRO_OPERACIONAL p
    WHERE  p.vigente = 1
      AND  strftime('%H:%M', NEW.entrada_prevista) BETWEEN p.hora_abertura AND p.hora_fechamento
      AND  strftime('%H:%M', NEW.saida_prevista)   BETWEEN p.hora_abertura AND p.hora_fechamento
)
BEGIN
    SELECT RAISE(ABORT, 'Entrada e saída devem ocorrer dentro do horário de funcionamento.');
END;

-- R4: o mesmo cão não pode ter dois agendamentos ativos sobrepostos
CREATE TRIGGER trg_agend_sem_sobreposicao
BEFORE INSERT ON AGENDAMENTO
WHEN NEW.status <> 'CANCELADO' AND EXISTS (
    SELECT 1 FROM AGENDAMENTO a
    WHERE  a.id_cachorro = NEW.id_cachorro
      AND  a.status <> 'CANCELADO'
      AND  a.entrada_prevista < NEW.saida_prevista
      AND  a.saida_prevista   > NEW.entrada_prevista
)
BEGIN
    SELECT RAISE(ABORT, 'O cachorro já possui agendamento no período informado.');
END;

-- R5: capacidade máxima da creche
CREATE TRIGGER trg_agend_capacidade_creche
BEFORE INSERT ON AGENDAMENTO
WHEN NEW.status <> 'CANCELADO' AND
     (SELECT COUNT(*) FROM AGENDAMENTO a
       WHERE a.status <> 'CANCELADO'
         AND a.entrada_prevista < NEW.saida_prevista
         AND a.saida_prevista   > NEW.entrada_prevista)
     >= COALESCE((SELECT capacidade_maxima FROM PARAMETRO_OPERACIONAL WHERE vigente = 1), 0)
BEGIN
    SELECT RAISE(ABORT, 'Capacidade máxima da creche atingida no período.');
END;

-- R6: capacidade do ambiente
CREATE TRIGGER trg_agend_capacidade_ambiente
BEFORE INSERT ON AGENDAMENTO
WHEN NEW.status <> 'CANCELADO' AND
     (SELECT COUNT(*) FROM AGENDAMENTO a
       WHERE a.id_ambiente = NEW.id_ambiente
         AND a.status <> 'CANCELADO'
         AND a.entrada_prevista < NEW.saida_prevista
         AND a.saida_prevista   > NEW.entrada_prevista)
     >= (SELECT capacidade_maxima FROM AMBIENTE WHERE id_ambiente = NEW.id_ambiente)
BEGIN
    SELECT RAISE(ABORT, 'Capacidade do ambiente atingida no período.');
END;

-- R7: número máximo de cães por cuidador
CREATE TRIGGER trg_agend_max_caes_cuidador
BEFORE INSERT ON AGENDAMENTO
WHEN NEW.id_cuidador IS NOT NULL AND NEW.status <> 'CANCELADO' AND
     (SELECT COUNT(*) FROM AGENDAMENTO a
       WHERE a.id_cuidador = NEW.id_cuidador
         AND a.status <> 'CANCELADO'
         AND a.entrada_prevista < NEW.saida_prevista
         AND a.saida_prevista   > NEW.entrada_prevista)
     >= COALESCE((SELECT max_caes_por_cuidador FROM PARAMETRO_OPERACIONAL WHERE vigente = 1), 0)
BEGIN
    SELECT RAISE(ABORT, 'O cuidador já atingiu o número máximo de cães no período.');
END;

-- R8: protocolo sanitário – vacina, vermífugo e antipulgas válidos durante toda a estadia
CREATE TRIGGER trg_agend_protocolo_sanitario
BEFORE INSERT ON AGENDAMENTO
WHEN NEW.status <> 'CANCELADO' AND
     (SELECT COUNT(DISTINCT rs.tipo)
        FROM REGISTRO_SANITARIO rs
        JOIN PRONTUARIO p ON p.id_prontuario = rs.id_prontuario
       WHERE p.id_cachorro = NEW.id_cachorro
         AND rs.data_aplicacao <= date(NEW.entrada_prevista)
         AND rs.data_validade  >= date(NEW.saida_prevista)) < 3
BEGIN
    SELECT RAISE(ABORT, 'Protocolo sanitário incompleto: vacina, vermífugo e antipulgas devem estar válidos no período.');
END;

-- ---------------------------------------------------------------------
-- GATILHOS DE ATUALIZAÇÃO (BEFORE UPDATE): repetem R1–R8 para alterações em agendamentos
-- já existentes (mudar data, ambiente, cuidador, cão/cliente ou reativar um cancelado).
-- Só disparam quando algo relevante muda, para não bloquear a rotina normal
-- (ex.: registrar entrada/saída real ou concluir um agendamento de cliente bloqueado depois).
-- A própria linha é excluída das contagens (a.id_agendamento <> NEW.id_agendamento).
-- ---------------------------------------------------------------------

-- R0bu: período válido
CREATE TRIGGER trg_agend_periodo_valido_upd
BEFORE UPDATE OF entrada_prevista, saida_prevista ON AGENDAMENTO
WHEN NEW.saida_prevista <= NEW.entrada_prevista
BEGIN
    SELECT RAISE(ABORT, 'A saída prevista deve ser posterior à entrada prevista.');
END;

-- R1u: o cliente deve continuar sendo o dono do cão
CREATE TRIGGER trg_agend_cliente_dono_upd
BEFORE UPDATE OF id_cachorro, id_cliente ON AGENDAMENTO
WHEN (SELECT id_cliente FROM CACHORRO WHERE id_cachorro = NEW.id_cachorro) <> NEW.id_cliente
BEGIN
    SELECT RAISE(ABORT, 'O cliente informado não é o dono do cachorro.');
END;

-- R2u: cliente bloqueado não pode remarcar, trocar de cão/cliente nem reativar reserva cancelada
CREATE TRIGGER trg_agend_cliente_bloqueado_upd
BEFORE UPDATE OF id_cliente, entrada_prevista, saida_prevista, status ON AGENDAMENTO
WHEN (NEW.id_cliente IS NOT OLD.id_cliente OR (NEW.entrada_prevista IS NOT OLD.entrada_prevista OR NEW.saida_prevista IS NOT OLD.saida_prevista) OR (OLD.status = 'CANCELADO' AND NEW.status <> 'CANCELADO'))
     AND (SELECT bloqueado FROM CLIENTE WHERE id_cliente = NEW.id_cliente) = 1
BEGIN
    SELECT RAISE(ABORT, 'Cliente bloqueado por pendência financeira: alterações na reserva não são permitidas.');
END;

-- R3u: novo período deve respeitar o horário de funcionamento
CREATE TRIGGER trg_agend_horario_funcionamento_upd
BEFORE UPDATE OF entrada_prevista, saida_prevista, status ON AGENDAMENTO
WHEN ((NEW.entrada_prevista IS NOT OLD.entrada_prevista OR NEW.saida_prevista IS NOT OLD.saida_prevista) OR (OLD.status = 'CANCELADO' AND NEW.status <> 'CANCELADO'))
     AND NOT EXISTS (
    SELECT 1 FROM PARAMETRO_OPERACIONAL p
    WHERE  p.vigente = 1
      AND  strftime('%H:%M', NEW.entrada_prevista) BETWEEN p.hora_abertura AND p.hora_fechamento
      AND  strftime('%H:%M', NEW.saida_prevista)   BETWEEN p.hora_abertura AND p.hora_fechamento
)
BEGIN
    SELECT RAISE(ABORT, 'Entrada e saída devem ocorrer dentro do horário de funcionamento.');
END;

-- R4u: sem sobreposição para o mesmo cão
CREATE TRIGGER trg_agend_sem_sobreposicao_upd
BEFORE UPDATE OF id_cachorro, entrada_prevista, saida_prevista, status ON AGENDAMENTO
WHEN NEW.status <> 'CANCELADO'
     AND (NEW.id_cachorro IS NOT OLD.id_cachorro OR (NEW.entrada_prevista IS NOT OLD.entrada_prevista OR NEW.saida_prevista IS NOT OLD.saida_prevista) OR (OLD.status = 'CANCELADO' AND NEW.status <> 'CANCELADO'))
     AND EXISTS (
    SELECT 1 FROM AGENDAMENTO a
    WHERE  a.id_agendamento <> NEW.id_agendamento
      AND  a.id_cachorro = NEW.id_cachorro
      AND  a.status <> 'CANCELADO'
      AND  a.entrada_prevista < NEW.saida_prevista
         AND a.saida_prevista   > NEW.entrada_prevista
)
BEGIN
    SELECT RAISE(ABORT, 'O cachorro já possui agendamento no período informado.');
END;

-- R5u: capacidade máxima da creche
CREATE TRIGGER trg_agend_capacidade_creche_upd
BEFORE UPDATE OF entrada_prevista, saida_prevista, status ON AGENDAMENTO
WHEN NEW.status <> 'CANCELADO' AND ((NEW.entrada_prevista IS NOT OLD.entrada_prevista OR NEW.saida_prevista IS NOT OLD.saida_prevista) OR (OLD.status = 'CANCELADO' AND NEW.status <> 'CANCELADO')) AND
     (SELECT COUNT(*) FROM AGENDAMENTO a
       WHERE a.id_agendamento <> NEW.id_agendamento
         AND a.status <> 'CANCELADO'
         AND a.entrada_prevista < NEW.saida_prevista
         AND a.saida_prevista   > NEW.entrada_prevista)
     >= COALESCE((SELECT capacidade_maxima FROM PARAMETRO_OPERACIONAL WHERE vigente = 1), 0)
BEGIN
    SELECT RAISE(ABORT, 'Capacidade máxima da creche atingida no período.');
END;

-- R6u: capacidade do ambiente
CREATE TRIGGER trg_agend_capacidade_ambiente_upd
BEFORE UPDATE OF id_ambiente, entrada_prevista, saida_prevista, status ON AGENDAMENTO
WHEN NEW.status <> 'CANCELADO'
     AND (NEW.id_ambiente IS NOT OLD.id_ambiente OR (NEW.entrada_prevista IS NOT OLD.entrada_prevista OR NEW.saida_prevista IS NOT OLD.saida_prevista) OR (OLD.status = 'CANCELADO' AND NEW.status <> 'CANCELADO')) AND
     (SELECT COUNT(*) FROM AGENDAMENTO a
       WHERE a.id_agendamento <> NEW.id_agendamento
         AND a.id_ambiente = NEW.id_ambiente
         AND a.status <> 'CANCELADO'
         AND a.entrada_prevista < NEW.saida_prevista
         AND a.saida_prevista   > NEW.entrada_prevista)
     >= COALESCE((SELECT capacidade_maxima FROM AMBIENTE WHERE id_ambiente = NEW.id_ambiente), 0)
BEGIN
    SELECT RAISE(ABORT, 'Capacidade do ambiente atingida no período.');
END;

-- R7u: número máximo de cães por cuidador
CREATE TRIGGER trg_agend_max_caes_cuidador_upd
BEFORE UPDATE OF id_cuidador, entrada_prevista, saida_prevista, status ON AGENDAMENTO
WHEN NEW.id_cuidador IS NOT NULL AND NEW.status <> 'CANCELADO'
     AND (NEW.id_cuidador IS NOT OLD.id_cuidador OR (NEW.entrada_prevista IS NOT OLD.entrada_prevista OR NEW.saida_prevista IS NOT OLD.saida_prevista) OR (OLD.status = 'CANCELADO' AND NEW.status <> 'CANCELADO')) AND
     (SELECT COUNT(*) FROM AGENDAMENTO a
       WHERE a.id_agendamento <> NEW.id_agendamento
         AND a.id_cuidador = NEW.id_cuidador
         AND a.status <> 'CANCELADO'
         AND a.entrada_prevista < NEW.saida_prevista
         AND a.saida_prevista   > NEW.entrada_prevista)
     >= COALESCE((SELECT max_caes_por_cuidador FROM PARAMETRO_OPERACIONAL WHERE vigente = 1), 0)
BEGIN
    SELECT RAISE(ABORT, 'O cuidador já atingiu o número máximo de cães no período.');
END;

-- R8u: protocolo sanitário válido para o novo período/cão
CREATE TRIGGER trg_agend_protocolo_sanitario_upd
BEFORE UPDATE OF id_cachorro, entrada_prevista, saida_prevista, status ON AGENDAMENTO
WHEN NEW.status <> 'CANCELADO'
     AND (NEW.id_cachorro IS NOT OLD.id_cachorro OR (NEW.entrada_prevista IS NOT OLD.entrada_prevista OR NEW.saida_prevista IS NOT OLD.saida_prevista) OR (OLD.status = 'CANCELADO' AND NEW.status <> 'CANCELADO')) AND
     (SELECT COUNT(DISTINCT rs.tipo)
        FROM REGISTRO_SANITARIO rs
        JOIN PRONTUARIO p ON p.id_prontuario = rs.id_prontuario
       WHERE p.id_cachorro = NEW.id_cachorro
         AND rs.data_aplicacao <= date(NEW.entrada_prevista)
         AND rs.data_validade  >= date(NEW.saida_prevista)) < 3
BEGIN
    SELECT RAISE(ABORT, 'Protocolo sanitário incompleto: vacina, vermífugo e antipulgas devem estar válidos no período.');
END;

-- R9: a ração servida deve ser produto da categoria RACAO comprado de fornecedor
CREATE TRIGGER trg_alimentacao_racao
BEFORE INSERT ON ALIMENTACAO
WHEN NOT EXISTS (
    SELECT 1 FROM PRODUTO p
    JOIN   FORNECIMENTO f ON f.id_produto = p.id_produto
    WHERE  p.id_produto = NEW.id_produto AND p.categoria = 'RACAO'
)
BEGIN
    SELECT RAISE(ABORT, 'A alimentação deve usar uma ração (categoria RACAO) fornecida por fornecedor cadastrado.');
END;

-- R10: bloqueio automático do cliente com mensalidade em atraso (e desbloqueio ao regularizar)
CREATE TRIGGER trg_mensalidade_bloqueio_ins
AFTER INSERT ON MENSALIDADE
BEGIN
    UPDATE CLIENTE
       SET bloqueado = CASE WHEN EXISTS (
               SELECT 1 FROM MENSALIDADE m JOIN ASSINATURA s ON s.id_assinatura = m.id_assinatura
                WHERE s.id_cliente = CLIENTE.id_cliente AND m.status = 'ATRASADA') THEN 1 ELSE 0 END
     WHERE id_cliente = (SELECT id_cliente FROM ASSINATURA WHERE id_assinatura = NEW.id_assinatura);
END;

CREATE TRIGGER trg_mensalidade_bloqueio_upd
AFTER UPDATE OF status ON MENSALIDADE
BEGIN
    UPDATE CLIENTE
       SET bloqueado = CASE WHEN EXISTS (
               SELECT 1 FROM MENSALIDADE m JOIN ASSINATURA s ON s.id_assinatura = m.id_assinatura
                WHERE s.id_cliente = CLIENTE.id_cliente AND m.status = 'ATRASADA') THEN 1 ELSE 0 END
     WHERE id_cliente = (SELECT id_cliente FROM ASSINATURA WHERE id_assinatura = NEW.id_assinatura);
END;

-- ---------------------------------------------------------------------
-- Gatilhos de parâmetro vigente (quando não houver parâmetros cadastrados)
-- ---------------------------------------------------------------------

-- R0: sem parâmetros operacionais vigentes não há como validar capacidade e horário
CREATE TRIGGER trg_agend_parametro_vigente_ins
BEFORE INSERT ON AGENDAMENTO
WHEN NOT EXISTS (SELECT 1 FROM PARAMETRO_OPERACIONAL WHERE vigente = 1)
BEGIN
    SELECT RAISE(ABORT, 'Não há parâmetros operacionais vigentes: cadastre-os antes de agendar.');
END;

-- R0u: parâmetros vigentes (em alterações relevantes)
CREATE TRIGGER trg_agend_parametro_vigente_upd
BEFORE UPDATE OF entrada_prevista, saida_prevista, id_ambiente, id_cuidador, status ON AGENDAMENTO
WHEN (NEW.entrada_prevista IS NOT OLD.entrada_prevista OR NEW.saida_prevista IS NOT OLD.saida_prevista
      OR NEW.id_ambiente IS NOT OLD.id_ambiente OR NEW.id_cuidador IS NOT OLD.id_cuidador OR (OLD.status = 'CANCELADO' AND NEW.status <> 'CANCELADO'))
     AND NOT EXISTS (SELECT 1 FROM PARAMETRO_OPERACIONAL WHERE vigente = 1)
BEGIN
    SELECT RAISE(ABORT, 'Não há parâmetros operacionais vigentes: cadastre-os antes de alterar o agendamento.');
END;
