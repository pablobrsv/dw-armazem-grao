BEGIN;

CREATE TABLE armazem_grao.fato_vendas (

    id_venda_item BIGSERIAL PRIMARY KEY,
    id_cupom_fiscal VARCHAR(50) NOT NULL,
    data_hora_venda TIMESTAMP NOT NULL,
    
    -- Chaves Estrangeiras
    id_loja INTEGER NOT NULL,
    id_cliente INTEGER,
    id_funcionario INTEGER,
    id_promocao INTEGER,
    codigo_do_produto VARCHAR(13) NOT NULL,
    lote_id VARCHAR(50),
    id_transacao INTEGER NOT NULL,
    
    -- Métricas
    quantidade_vendida NUMERIC(10, 3) NOT NULL,
    valor_unitario_praticado NUMERIC(10, 2) NOT NULL,
    valor_desconto NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    valor_total_item NUMERIC(10, 2) NOT NULL,
    custo_total_item NUMERIC(10, 2) NOT NULL,
    
    -- Restrições de Integridade
    CONSTRAINT fk_vendas_loja FOREIGN KEY (id_loja) REFERENCES armazem_grao.dim_lojas(id_loja) ON DELETE RESTRICT,
    CONSTRAINT fk_vendas_cliente FOREIGN KEY (id_cliente) REFERENCES armazem_grao.dim_clientes(id_cliente) ON DELETE SET NULL,
    CONSTRAINT fk_vendas_funcionario FOREIGN KEY (id_funcionario) REFERENCES armazem_grao.dim_funcionario(id_funcionario) ON DELETE RESTRICT,
    CONSTRAINT fk_vendas_promocao FOREIGN KEY (id_promocao) REFERENCES armazem_grao.dim_promocao(id_promocao) ON DELETE SET NULL,
    CONSTRAINT fk_vendas_produto FOREIGN KEY (codigo_do_produto) REFERENCES armazem_grao.dim_produtos(codigo_barras) ON DELETE RESTRICT,
    CONSTRAINT fk_vendas_lote FOREIGN KEY (lote_id) REFERENCES armazem_grao.dim_lotes_validade(lote_id) ON DELETE SET NULL,
    CONSTRAINT fk_vendas_transacao FOREIGN KEY (id_transacao) REFERENCES armazem_grao.dim_transacao(id_transacao) ON DELETE RESTRICT
);

-- Índices
CREATE INDEX idx_fato_vendas_data ON armazem_grao.fato_vendas(data_hora_venda);
CREATE INDEX idx_fato_vendas_loja ON armazem_grao.fato_vendas(id_loja);
CREATE INDEX idx_fato_vendas_produto ON armazem_grao.fato_vendas(codigo_do_produto);
CREATE INDEX idx_fato_vendas_cupom ON armazem_grao.fato_vendas(id_cupom_fiscal);
CREATE INDEX idx_fato_vendas_transacao ON armazem_grao.fato_vendas(id_transacao);
CREATE INDEX idx_fato_vendas_funcionario ON armazem_grao.fato_vendas(id_funcionario);
CREATE INDEX idx_fato_vendas_promocao ON armazem_grao.fato_vendas(id_promocao);

COMMIT;