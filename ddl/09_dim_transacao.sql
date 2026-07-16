BEGIN;

CREATE TABLE armazem_grao.dim_transacao (
    id_transacao SERIAL PRIMARY KEY,
    canal_venda VARCHAR(50) NOT NULL,
    forma_pagamento VARCHAR(50) NOT NULL,
    bandeira_cartao VARCHAR(50) DEFAULT 'N/A',
    tipo_parcelamento VARCHAR(50) DEFAULT 'À Vista',
    tipo_caixa VARCHAR(50) DEFAULT 'Caixa Convencional',
    modalidade_entrega VARCHAR(50) DEFAULT 'Pronta Entrega',
    status_transacao VARCHAR(50) DEFAULT 'Aprovada',
    fidelidade_acionada VARCHAR(3) DEFAULT 'Não'
);

COMMENT ON TABLE armazem_grao.dim_transacao IS 'Dimensão lixo (Junk Dimension) para agrupar atributos categóricos do momento do pagamento e da operação no PDV.';

COMMIT;