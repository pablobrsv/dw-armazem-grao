BEGIN;

-- Criação da tabela fato_quebras com tipagem rigorosa e chaves estrangeiras

CREATE TABLE armazem_grao.fato_quebras (

    id_quebra SERIAL PRIMARY KEY,
    id_produto INTEGER NOT NULL,
    id_loja INTEGER NOT NULL,
    lote_id VARCHAR(50),
    quantidade_quebra INTEGER NOT NULL,
    valor_prejuizo_acumulado NUMERIC(10, 2) NOT NULL,
    data_ocorrencia DATE NOT NULL,
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    motivo_quebra VARCHAR(100),

    -- Definição das restrições de chave estrangeira (Integridade Referencial)
	
    CONSTRAINT fk_quebras_produtos 
        FOREIGN KEY (id_produto) 
        REFERENCES armazem_grao.dim_produtos(id_produto),
        
    CONSTRAINT fk_quebras_lojas 
        FOREIGN KEY (id_loja) 
        REFERENCES armazem_grao.dim_lojas(id_loja),
        
    CONSTRAINT fk_quebras_lotes 
        FOREIGN KEY (lote_id) 
        REFERENCES armazem_grao.dim_lotes_validade(lote_id)
);

-- Criação de índices para otimização de consultas (Performance DDL)

CREATE INDEX idx_fato_quebras_produto ON armazem_grao.fato_quebras(id_produto);
CREATE INDEX idx_fato_quebras_loja ON armazem_grao.fato_quebras(id_loja);
CREATE INDEX idx_fato_quebras_data ON armazem_grao.fato_quebras(data_ocorrencia);

-- Comentários documentais da estrutura
COMMENT ON TABLE armazem_grao.fato_quebras IS 

'Tabela fato para registro de perdas/quebras de estoque.';

COMMENT ON COLUMN armazem_grao.fato_quebras.valor_prejuizo_acumulado IS 

'Valor financeiro total do prejuízo apurado na quebra.';

COMMIT;