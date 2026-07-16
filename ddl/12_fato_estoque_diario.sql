BEGIN;

CREATE TABLE armazem_grao.fato_estoque_diario (

    id_registro BIGSERIAL PRIMARY KEY,
    
    -- Eixo Temporal
    data_fotografia DATE NOT NULL,
    
    -- Chaves Estrangeiras (Integração dimensional)
    id_loja INTEGER NOT NULL,
    codigo_do_produto VARCHAR(13) NOT NULL,
    lote_id VARCHAR(50),
    
    -- Métricas Físicas e Financeiras Base
    saldo_unidades NUMERIC(10, 3) NOT NULL,
    custo_unitario_vigente NUMERIC(10, 2) NOT NULL,
    
    -- Otimização Matemática no Disco
    valor_financeiro_imobilizado NUMERIC(12, 2) GENERATED ALWAYS AS (saldo_unidades * custo_unitario_vigente) STORED,

    -- Restrições de Integridade Referencial
    CONSTRAINT fk_estoque_data FOREIGN KEY (data_fotografia) REFERENCES armazem_grao.dim_calendario(data_completa) ON DELETE RESTRICT,
    CONSTRAINT fk_estoque_loja FOREIGN KEY (id_loja) REFERENCES armazem_grao.dim_lojas(id_loja) ON DELETE RESTRICT,
    CONSTRAINT fk_estoque_produto FOREIGN KEY (codigo_do_produto) REFERENCES armazem_grao.dim_produtos(codigo_barras) ON DELETE RESTRICT,
    CONSTRAINT fk_estoque_lote FOREIGN KEY (lote_id) REFERENCES armazem_grao.dim_lotes_validade(lote_id) ON DELETE SET NULL
);

CREATE INDEX idx_estoque_diario_data ON armazem_grao.fato_estoque_diario(data_fotografia);
CREATE INDEX idx_estoque_diario_loja ON armazem_grao.fato_estoque_diario(id_loja);
CREATE INDEX idx_estoque_diario_produto ON armazem_grao.fato_estoque_diario(codigo_do_produto);


COMMIT; 