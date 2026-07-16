BEGIN;
CREATE TABLE armazem_grao.fato_compras (

    id_compra BIGSERIAL PRIMARY KEY,
    numero_nota_fiscal VARCHAR(50) NOT NULL,
    
    -- Eixo Temporal (Integração com dim_calendario)
    data_emissao DATE NOT NULL,
    data_recebimento DATE NOT NULL,
    
    -- Chaves Estrangeiras (Integração com as Dimensões)
    id_fornecedor INTEGER NOT NULL,
    id_loja INTEGER NOT NULL,
    codigo_do_produto VARCHAR(13) NOT NULL,
    lote_id VARCHAR(50) NOT NULL,
    quantidade_comprada NUMERIC(10, 3) NOT NULL,
    custo_unitario NUMERIC(10, 2) NOT NULL,
    valor_frete NUMERIC(10, 2) DEFAULT 0.00,
    valor_impostos NUMERIC(10, 2) DEFAULT 0.00,
    
    -- Coluna calculada para o custo total da linha da nota
	
    valor_total_compra NUMERIC(12, 2) GENERATED ALWAYS AS ((quantidade_comprada * custo_unitario) + valor_frete + valor_impostos) STORED,

    -- Restrições de Integridade Referencial
	
    CONSTRAINT fk_compras_data_emissao FOREIGN KEY (data_emissao) REFERENCES armazem_grao.dim_calendario(data_completa) ON DELETE RESTRICT,
    CONSTRAINT fk_compras_data_recebimento FOREIGN KEY (data_recebimento) REFERENCES armazem_grao.dim_calendario(data_completa) ON DELETE RESTRICT,
    CONSTRAINT fk_compras_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES armazem_grao.dim_fornecedores(id_fornecedor) ON DELETE RESTRICT,
    CONSTRAINT fk_compras_loja FOREIGN KEY (id_loja) REFERENCES armazem_grao.dim_lojas(id_loja) ON DELETE RESTRICT,
    CONSTRAINT fk_compras_produto FOREIGN KEY (codigo_do_produto) REFERENCES armazem_grao.dim_produtos(codigo_barras) ON DELETE RESTRICT,
    CONSTRAINT fk_compras_lote FOREIGN KEY (lote_id) REFERENCES armazem_grao.dim_lotes_validade(lote_id) ON DELETE RESTRICT

);

CREATE INDEX idx_compras_data_recebimento ON armazem_grao.fato_compras(data_recebimento);
CREATE INDEX idx_compras_fornecedor ON armazem_grao.fato_compras(id_fornecedor);
CREATE INDEX idx_compras_produto ON armazem_grao.fato_compras(codigo_do_produto);
CREATE INDEX idx_compras_lote ON armazem_grao.fato_compras(lote_id);
CREATE INDEX idx_compras_nf ON armazem_grao.fato_compras(numero_nota_fiscal);

COMMENT ON TABLE armazem_grao.fato_compras IS 

'Tabela fato transacional de entrada de mercadorias. 
Registra a aquisição financeira e o descarregamento logístico dos lotes.';

COMMIT;