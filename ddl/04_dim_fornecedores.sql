BEGIN;

CREATE TABLE armazem_grao.dim_fornecedores (
    
    id_fornecedor SERIAL PRIMARY KEY,
    cnpj_cpf VARCHAR(20) NOT NULL UNIQUE,
    razao_social VARCHAR(150) NOT NULL,
    nome_fantasia VARCHAR(150),
    categoria_fornecimento VARCHAR(50) NOT NULL,
    cidade_origem VARCHAR(100),
    estado_origem CHAR(2),
    prazo_entrega_dias INTEGER,
    email_contato VARCHAR(100),
    telefone_contato VARCHAR(20),
    condicao_pagamento_padrao VARCHAR(50),
    
    status_ativo BOOLEAN DEFAULT TRUE
);

-- Índices para otimização de consultas textuais e geográficas

CREATE INDEX idx_fornecedores_cnpj ON armazem_grao.dim_fornecedores(cnpj_cpf);
CREATE INDEX idx_fornecedores_categoria ON armazem_grao.dim_fornecedores(categoria_fornecimento);
CREATE INDEX idx_fornecedores_estado ON armazem_grao.dim_fornecedores(estado_origem);

COMMENT ON TABLE armazem_grao.dim_fornecedores IS 'Dimensão de cadastro de entidades jurídicas e produtores rurais.';
COMMENT ON COLUMN armazem_grao.dim_fornecedores.condicao_pagamento_padrao IS 'Termo financeiro acordado para faturamento (ex: 30/60/90 dias, À vista).';

COMMIT;