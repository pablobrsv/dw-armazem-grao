BEGIN;

CREATE TABLE armazem_grao.dim_lotes_validade (
    
    lote_id VARCHAR(50) PRIMARY KEY,
    status_lote VARCHAR(50) NOT NULL,
    data_fabricacao DATE NOT NULL,
    data_vencimento DATE NOT NULL
);

COMMIT;