BEGIN;

CREATE TABLE armazem_grao.fato_contas_pagar (

    id_conta BIGSERIAL PRIMARY KEY,
    numero_boleto VARCHAR(50) NOT NULL,
    numero_nota_fiscal VARCHAR(50) NOT NULL,
    
    -- Chave Estrangeira (Integração com a entidade credora)
    id_fornecedor INTEGER NOT NULL,
    
    -- Eixo Temporal Financeiro
    data_emissao DATE NOT NULL,
    data_vencimento DATE NOT NULL,
    data_pagamento DATE,
    
    -- Métricas Transacionais
    valor_parcela NUMERIC(12, 2) NOT NULL,
    valor_pago NUMERIC(12, 2) DEFAULT 0.00,
    
    -- Controle de Status
    status_pagamento VARCHAR(20) NOT NULL DEFAULT 'Pendente',
    
    -- Restrições de Integridade Referencial
    CONSTRAINT fk_contas_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES armazem_grao.dim_fornecedores(id_fornecedor) ON DELETE RESTRICT,
    CONSTRAINT fk_contas_emissao FOREIGN KEY (data_emissao) REFERENCES armazem_grao.dim_calendario(data_completa) ON DELETE RESTRICT,
    CONSTRAINT fk_contas_vencimento FOREIGN KEY (data_vencimento) REFERENCES armazem_grao.dim_calendario(data_completa) ON DELETE RESTRICT,
    
    -- Restrição Lógica de Status
    CONSTRAINT chk_status_pagamento CHECK (status_pagamento IN ('Pendente', 'Pago', 'Atrasado', 'Cancelado'))
);

-- Índices B-Tree focados na varredura de datas de vencimento para relatórios diários

CREATE INDEX idx_contas_vencimento ON armazem_grao.fato_contas_pagar(data_vencimento);
CREATE INDEX idx_contas_fornecedor ON armazem_grao.fato_contas_pagar(id_fornecedor);
CREATE INDEX idx_contas_status ON armazem_grao.fato_contas_pagar(status_pagamento);
CREATE INDEX idx_contas_nf ON armazem_grao.fato_contas_pagar(numero_nota_fiscal);

COMMENT ON TABLE armazem_grao.fato_contas_pagar IS 'Tabela fato financeira. Registra o ciclo de vida das duplicatas e obrigações a pagar do armazém.';

COMMIT;