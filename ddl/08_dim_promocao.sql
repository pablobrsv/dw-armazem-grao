CREATE TABLE armazem_grao.dim_promocao (

    id_promocao SERIAL PRIMARY KEY,
    nome_campanha VARCHAR(100) NOT NULL,
    tipo_promocao VARCHAR(50) NOT NULL,
    data_inicio DATE NOT NULL,
    data_termino DATE NOT NULL
    
);

COMMENT ON TABLE armazem_grao.dim_promocao IS 'Dimensão para cálculo de ROI de ações de marketing e descontos aplicados.';

COMMIT;
