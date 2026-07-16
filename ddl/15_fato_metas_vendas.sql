BEGIN;

CREATE TABLE armazem_grao.fato_metas_vendas (

    id_meta BIGSERIAL PRIMARY KEY,
    
    -- Eixo Temporal (Granularidade Mensal)
    data_referencia DATE NOT NULL,
    
    -- Chaves Estrangeiras (Integração dimensional)
    id_loja INTEGER NOT NULL,
    
    -- Métricas de Planejamento (Orçamento)
    meta_faturamento_mensal NUMERIC(15, 2) NOT NULL,
    meta_volume_quilos NUMERIC(12, 3) NOT NULL,
    
    -- Restrições de Integridade Referencial e Unicidade
    CONSTRAINT fk_metas_data FOREIGN KEY (data_referencia) REFERENCES armazem_grao.dim_calendario(data_completa) ON DELETE RESTRICT,
    CONSTRAINT fk_metas_loja FOREIGN KEY (id_loja) REFERENCES armazem_grao.dim_lojas(id_loja) ON DELETE RESTRICT,
    
    -- Impede a inserção de duas metas diferentes para a mesma loja no mesmo mês
    CONSTRAINT uq_metas_loja_mes UNIQUE (id_loja, data_referencia)
);

CREATE INDEX idx_metas_vendas_data ON armazem_grao.fato_metas_vendas(data_referencia);
CREATE INDEX idx_metas_vendas_loja ON armazem_grao.fato_metas_vendas(id_loja);

COMMENT ON TABLE armazem_grao.fato_metas_vendas IS 'Tabela fato agregada. Armazena os orçamentos mensais por loja.';
COMMENT ON COLUMN armazem_grao.fato_metas_vendas.data_referencia IS 'Padrão: deve registrar sempre o primeiro dia do mês correspondente à meta.';

COMMIT;