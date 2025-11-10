/*
DATABASE SYMBIO - GLOBAL SOLUTION
Henrique Martins - RM563620
Henrique Teixeira - RM563088
*/

-- ======================================
--             SCRIPT DDL 
-- ======================================
CREATE TABLE T_SYM_CARGO (
    -- Atributos
    id_cargo        NUMBER(5) NOT NULL,
    nm_cargo        VARCHAR(50) NOT NULL,
    ds_cargo        VARCHAR(100),
    nivel_risco_ia  VARCHAR(10) NOT NULL,
    -- Restrições
    CONSTRAINT PK_SYM_CARGO PRIMARY KEY (id_cargo),
    CONSTRAINT UK_SYM_NM_CARGO UNIQUE (nm_cargo),
    CONSTRAINT CK_SYM_RISCO_IA CHECK (nivel_risco_ia IN ('ALTO', 'MEDIO', 'BAIXO'))
);

CREATE TABLE T_SYM_SKILL (
    -- Atributos
    id_skill    NUMBER(5) NOT NULL,
    nm_skill    VARCHAR(50) NOT NULL,
    tp_skill    VARCHAR(10) NOT NULL,
    ds_skill    VARCHAR(100),
    -- Restrições
    CONSTRAINT PK_SYM_SKILL PRIMARY KEY (id_skill),
    CONSTRAINT UK_SYM_NM_SKILL UNIQUE (nm_skill),
    CONSTRAINT CK_SYM_TP_SKILL CHECK (tp_skill IN ('SOFT', 'HARD'))
);

CREATE TABLE T_SYM_COLABORADOR (
    -- Atributos 
    id_colaborador  NUMBER(10) NOT NULL,
    nm_colaborador  VARCHAR(100) NOT NULL,
    ds_email        VARCHAR(100) NOT NULL,
    dt_admissao     DATE NOT NULL,
    salario         NUMBER(10,2) NOT NULL,
    id_cargo        NUMBER(5) NOT NULL,
    -- Restrições
    CONSTRAINT PK_SYM_COLABORADOR PRIMARY KEY (id_colaborador),
    CONSTRAINT UK_SYM_EMAIL_COLAB UNIQUE (ds_email),
    CONSTRAINT FK_SYM_COLAB_CARGO FOREIGN KEY (id_cargo) REFERENCES T_SYM_CARGO (id_cargo)
);

CREATE TABLE T_SYM_VAGA (
    -- Atributos
    id_vaga         NUMBER(5) NOT NULL,
    ds_titulo       VARCHAR(100) NOT NULL,
    dt_abertura     DATE NOT NULL,
    st_vaga         VARCHAR(10) NOT NULL,
    -- Restrições
    CONSTRAINT PK_SYM_VAGA PRIMARY KEY (id_vaga),
    CONSTRAINT CK_SYM_STATUS_VAGA CHECK (st_vaga IN ('ABERTA', 'FECHADA', 'PAUSADA'))
);

CREATE TABLE T_SYM_COLAB_SKILL (
    -- Atributos
    id_colaborador  NUMBER(10) NOT NULL,
    id_skill        NUMBER(5) NOT NULL,
    nr_nivel_proficiencia NUMBER(1) NOT NULL,
    -- Restrições
    CONSTRAINT PK_SYM_COLAB_SKILL PRIMARY KEY (id_colaborador, id_skill),
    CONSTRAINT FK_SYM_CS_COLAB FOREIGN KEY (id_colaborador) REFERENCES T_SYM_COLABORADOR (id_colaborador),
    CONSTRAINT FK_SYM_CS_SKILL FOREIGN KEY (id_skill) REFERENCES T_SYM_SKILL (id_skill),
    CONSTRAINT CK_SYM_NIVEL_SKILL CHECK (nr_nivel_proficiencia BETWEEN 1 AND 5)
);

CREATE TABLE T_SYM_VAGA_SKILL (
    -- Atributos
    id_vaga     NUMBER(5) NOT NULL,
    id_skill    NUMBER(5) NOT NULL,
    nr_peso     NUMBER(2) NOT NULL,
    -- Restrições
    CONSTRAINT PK_SYM_VAGA_SKILL PRIMARY KEY (id_vaga, id_skill),
    CONSTRAINT FK_SYM_VS_VAGA FOREIGN KEY (id_vaga) REFERENCES T_SYM_VAGA (id_vaga),
    CONSTRAINT FK_SYM_VS_SKILL FOREIGN KEY (id_skill) REFERENCES T_SYM_SKILL (id_skill),
    CONSTRAINT CK_SYM_PESO_SKILL CHECK (nr_peso BETWEEN 1 AND 10)
);

-- ======================================
--        ÍNDICES PARA CONSULTAS
-- ======================================
CREATE INDEX IX_SYM_CARGO_RISCO ON T_SYM_CARGO(nivel_risco_ia);
CREATE INDEX IX_SYM_COLAB_CARGO ON T_SYM_COLABORADOR(id_cargo);
CREATE INDEX IX_SYM_VAGA_STATUS ON T_SYM_VAGA(st_vaga);
CREATE INDEX IX_SYM_CS_SKILL ON T_SYM_COLAB_SKILL(id_skill);
CREATE INDEX IX_SYM_VS_SKILL ON T_SYM_VAGA_SKILL(id_skill);

-- ===================
--     COMENTÁRIOS
-- ===================
COMMENT ON TABLE T_SYM_CARGO IS 'Catálogo de funções da empresa e seus respectivos riscos de automação identificados pela IA.';
COMMENT ON COLUMN T_SYM_CARGO.nivel_risco_ia IS 'Classificação preditiva da IA: ALTO, MEDIO ou BAIXO risco de substituição.';
COMMENT ON TABLE T_SYM_SKILL IS 'Biblioteca de habilidades (Soft/Hard) usadas para mapeamento de perfil e requisitos de vagas.';
COMMENT ON COLUMN T_SYM_SKILL.tp_skill IS 'Define se a habilidade é técnica (HARD) ou comportamental (SOFT).';
COMMENT ON TABLE T_SYM_COLABORADOR IS 'Registro principal dos funcionários ativos elegíveis para análise de requalificação.';
COMMENT ON COLUMN T_SYM_COLABORADOR.id_cargo IS 'Referência ao cargo atual do colaborador.';
COMMENT ON TABLE T_SYM_VAGA IS 'Oportunidades internas disponíveis para mobilidade de talentos.';
COMMENT ON COLUMN T_SYM_VAGA.st_vaga IS 'Status atual da vaga: ABERTA, FECHADA ou PAUSADA.';
COMMENT ON TABLE T_SYM_COLAB_SKILL IS 'Mapeamento das competências que cada colaborador possui.';
COMMENT ON COLUMN T_SYM_COLAB_SKILL.nr_nivel_proficiencia IS 'Nível de domínio da skill pelo colaborador (Escala 1-5).';
COMMENT ON TABLE T_SYM_VAGA_SKILL IS 'Mapeamento dos requisitos necessários para cada vaga interna.';
COMMENT ON COLUMN T_SYM_VAGA_SKILL.nr_peso IS 'Peso/Importância da skill para a vaga (Escala 1-10)';

--------------------------------------------------------------------------------------------------------

-- ===========================
--        SCRIPT DML 
-- ===========================

-- TABELA CARGOS 
INSERT INTO T_SYM_CARGO VALUES (10, 'Atendente de Telemarketing', 'Atendimento receptivo', 'ALTO');
INSERT INTO T_SYM_CARGO VALUES (11, 'Caixa Operacional', 'Operações de pagamento', 'ALTO');
INSERT INTO T_SYM_CARGO VALUES (12, 'Auxiliar Administrativo', 'Rotinas de escritório', 'ALTO');
INSERT INTO T_SYM_CARGO VALUES (13, 'Digitador', 'Entrada de dados', 'ALTO');
INSERT INTO T_SYM_CARGO VALUES (20, 'Analista Financeiro Jr', 'Análise de contas', 'MEDIO');
INSERT INTO T_SYM_CARGO VALUES (21, 'Gerente de Contas', 'Relacionamento B2B', 'MEDIO');
INSERT INTO T_SYM_CARGO VALUES (22, 'Designer Gráfico', 'Criação de peças visuais', 'MEDIO');
INSERT INTO T_SYM_CARGO VALUES (30, 'Desenvolvedor Python', 'Backend e IA', 'BAIXO');
INSERT INTO T_SYM_CARGO VALUES (31, 'Cientista de Dados', 'Modelagem preditiva', 'BAIXO');
INSERT INTO T_SYM_CARGO VALUES (32, 'Especialista em CX', 'Experiência do cliente', 'BAIXO');

-- TABELA SKILL
INSERT INTO T_SYM_SKILL VALUES (100, 'Comunicação Não-Violenta', 'SOFT', 'Capacidade de diálogo');
INSERT INTO T_SYM_SKILL VALUES (101, 'Liderança Ágil', 'SOFT', 'Gestão de times ágeis');
INSERT INTO T_SYM_SKILL VALUES (102, 'Inteligência Emocional', 'SOFT', 'Gestão de emoções');
INSERT INTO T_SYM_SKILL VALUES (103, 'Pensamento Crítico', 'SOFT', 'Análise de cenários');
INSERT INTO T_SYM_SKILL VALUES (104, 'Empatia', 'SOFT', 'Entender o cliente');
INSERT INTO T_SYM_SKILL VALUES (200, 'Python Avançado', 'HARD', 'Programação');
INSERT INTO T_SYM_SKILL VALUES (201, 'SQL e Banco de Dados', 'HARD', 'Manipulação de dados');
INSERT INTO T_SYM_SKILL VALUES (202, 'Power BI', 'HARD', 'Visualização de dados');
INSERT INTO T_SYM_SKILL VALUES (203, 'UX Writing', 'HARD', 'Escrita para interfaces');
INSERT INTO T_SYM_SKILL VALUES (204, 'Gestão de Projetos (Scrum)', 'HARD', 'Metodologias ágeis');

-- TABELA COLABORADORES
INSERT INTO T_SYM_COLABORADOR VALUES (1, 'João Silva', 'joao.silva@symbio.com', TO_DATE('2020-01-15', 'YYYY-MM-DD'), 2500.00, 10);
INSERT INTO T_SYM_COLABORADOR VALUES (2, 'Maria Oliveira', 'maria.o@symbio.com', TO_DATE('2019-05-10', 'YYYY-MM-DD'), 2800.00, 11);
INSERT INTO T_SYM_COLABORADOR VALUES (3, 'Pedro Santos', 'pedro.s@symbio.com', TO_DATE('2021-08-20', 'YYYY-MM-DD'), 3000.00, 12);
INSERT INTO T_SYM_COLABORADOR VALUES (4, 'Ana Costa', 'ana.costa@symbio.com', TO_DATE('2022-02-01', 'YYYY-MM-DD'), 2200.00, 13);
INSERT INTO T_SYM_COLABORADOR VALUES (5, 'Carlos Pereira', 'carlos.p@symbio.com', TO_DATE('2018-11-30', 'YYYY-MM-DD'), 5500.00, 20);
INSERT INTO T_SYM_COLABORADOR VALUES (6, 'Fernanda Lima', 'fernanda.l@symbio.com', TO_DATE('2020-07-15', 'YYYY-MM-DD'), 7000.00, 21);
INSERT INTO T_SYM_COLABORADOR VALUES (7, 'Roberto Alves', 'roberto.a@symbio.com', TO_DATE('2023-01-10', 'YYYY-MM-DD'), 4500.00, 22);
INSERT INTO T_SYM_COLABORADOR VALUES (8, 'Lucas Mendes', 'lucas.m@symbio.com', TO_DATE('2021-04-25', 'YYYY-MM-DD'), 9000.00, 30);
INSERT INTO T_SYM_COLABORADOR VALUES (9, 'Beatriz Rocha', 'beatriz.r@symbio.com', TO_DATE('2019-09-05', 'YYYY-MM-DD'), 12000.00, 31);
INSERT INTO T_SYM_COLABORADOR VALUES (10, 'Juliana Martins', 'juliana.m@symbio.com', TO_DATE('2022-06-18', 'YYYY-MM-DD'), 8500.00, 32);

-- TABELA VAGAS
INSERT INTO T_SYM_VAGA VALUES (500, 'Analista de Dados Jr', TO_DATE('2025-10-01', 'YYYY-MM-DD'), 'ABERTA');
INSERT INTO T_SYM_VAGA VALUES (501, 'Desenvolvedor Junior', TO_DATE('2025-10-05', 'YYYY-MM-DD'), 'ABERTA');
INSERT INTO T_SYM_VAGA VALUES (502, 'Customer Success', TO_DATE('2025-10-10', 'YYYY-MM-DD'), 'ABERTA');
INSERT INTO T_SYM_VAGA VALUES (503, 'Product Owner', TO_DATE('2025-09-01', 'YYYY-MM-DD'), 'FECHADA');
INSERT INTO T_SYM_VAGA VALUES (504, 'UX Designer Pleno', TO_DATE('2025-11-01', 'YYYY-MM-DD'), 'ABERTA');
INSERT INTO T_SYM_VAGA VALUES (505, 'Analista de Suporte N2', TO_DATE('2025-10-15', 'YYYY-MM-DD'), 'PAUSADA');
INSERT INTO T_SYM_VAGA VALUES (506, 'Engenheiro de Dados', TO_DATE('2025-11-05', 'YYYY-MM-DD'), 'ABERTA');
INSERT INTO T_SYM_VAGA VALUES (507, 'Scrum Master', TO_DATE('2025-10-20', 'YYYY-MM-DD'), 'ABERTA');
INSERT INTO T_SYM_VAGA VALUES (508, 'DevOps Engineer', TO_DATE('2025-11-02', 'YYYY-MM-DD'), 'ABERTA');
INSERT INTO T_SYM_VAGA VALUES (509, 'Tech Recruiter', TO_DATE('2025-10-12', 'YYYY-MM-DD'), 'ABERTA');

-- TABELA COLAB_SKILL 
INSERT INTO T_SYM_COLAB_SKILL VALUES (1, 100, 5); 
INSERT INTO T_SYM_COLAB_SKILL VALUES (1, 104, 4); 
INSERT INTO T_SYM_COLAB_SKILL VALUES (2, 201, 2); 
INSERT INTO T_SYM_COLAB_SKILL VALUES (2, 103, 3); 
INSERT INTO T_SYM_COLAB_SKILL VALUES (8, 200, 5); 
INSERT INTO T_SYM_COLAB_SKILL VALUES (8, 201, 4);
INSERT INTO T_SYM_COLAB_SKILL VALUES (9, 200, 5);
INSERT INTO T_SYM_COLAB_SKILL VALUES (9, 201, 5);
INSERT INTO T_SYM_COLAB_SKILL VALUES (9, 202, 4);
INSERT INTO T_SYM_COLAB_SKILL VALUES (10, 104, 5);
INSERT INTO T_SYM_COLAB_SKILL VALUES (10, 102, 4);

-- TABELA VAGA_SKILL 
INSERT INTO T_SYM_VAGA_SKILL VALUES (500, 201, 10);
INSERT INTO T_SYM_VAGA_SKILL VALUES (500, 103, 7);
INSERT INTO T_SYM_VAGA_SKILL VALUES (502, 104, 10);
INSERT INTO T_SYM_VAGA_SKILL VALUES (502, 100, 9);
INSERT INTO T_SYM_VAGA_SKILL VALUES (501, 200, 10);
INSERT INTO T_SYM_VAGA_SKILL VALUES (501, 201, 8);
INSERT INTO T_SYM_VAGA_SKILL VALUES (504, 203, 10);
INSERT INTO T_SYM_VAGA_SKILL VALUES (504, 104, 8);
INSERT INTO T_SYM_VAGA_SKILL VALUES (507, 101, 10);
INSERT INTO T_SYM_VAGA_SKILL VALUES (507, 204, 10);
INSERT INTO T_SYM_VAGA_SKILL VALUES (506, 200, 9);
INSERT INTO T_SYM_VAGA_SKILL VALUES (506, 201, 10);

--------------------------------------------------------------------------------------------------------

-- ==========================
--         SCRIPT DQL 
-- ==========================
/*
CONSULTA SIMPLES 
Objetivo: Listar todos os colaboradores que foram admitidos antes de 2022, ordenados pelo nome, ]
para identificar funcionários mais antigos que podem precisar de reciclagem.
*/
SELECT nm_colaborador, ds_email, dt_admissao
FROM T_SYM_COLABORADOR
WHERE dt_admissao < TO_DATE('01/01/2022', 'DD/MM/YYYY')
ORDER BY nm_colaborador ASC;

/*
CONSULTA COM JUNÇÃO
Objetivo: Relatório para o Dashboard mostrando o nome do colaborador,seu cargo atual 
e o NÍVEL DE RISCO de automação daquele cargo.*/
SELECT C.nm_colaborador, CG.nm_cargo, CG.nivel_risco_ia
FROM T_SYM_COLABORADOR C
INNER JOIN T_SYM_CARGO CG ON C.id_cargo = CG.id_cargo
WHERE CG.nivel_risco_ia = 'ALTO'
ORDER BY C.nm_colaborador;

/*
CONSULTA COM FUNÇÃO DE GRUPO E AGRUPAMENTO 
Objetivo: Contar quantos funcionários a empresa tem em cada nível de risco de automação.
*/
SELECT CG.nivel_risco_ia, COUNT(C.id_colaborador) AS total_funcionarios
FROM T_SYM_CARGO CG
LEFT JOIN T_SYM_COLABORADOR C ON CG.id_cargo = C.id_cargo
GROUP BY CG.nivel_risco_ia
ORDER BY total_funcionarios DESC;

/*
CONSULTA COM AGRUPAMENTO E FILTRO
Objetivo: Identificar quais cargos possuem uma média salarial muito alta (acima de R$ 6.000)
e que estão em risco, para planejar o impacto financeiro de possíveis demissões vs. requalificação.*/
SELECT CG.nm_cargo, AVG(C.salario) AS media_salarial
FROM T_SYM_COLABORADOR C
JOIN T_SYM_CARGO CG ON C.id_cargo = CG.id_cargo
GROUP BY CG.nm_cargo
HAVING AVG(C.salario) > 6000
ORDER BY media_salarial DESC;