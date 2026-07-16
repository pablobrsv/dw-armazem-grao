BEGIN;

CREATE TABLE armazem_grao.dim_funcionarios (
    id_funcionario SERIAL PRIMARY KEY,
    matricula VARCHAR(20) UNIQUE NOT NULL,
    nome_completo VARCHAR(150) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    turno_trabalho VARCHAR(20) NOT NULL,
    id_loja INTEGER NOT NULL,
    data_admissao DATE NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,

    -- Chave Estrangeira para garantir integridade com dim_lojas
    CONSTRAINT fk_funcionario_loja 
        FOREIGN KEY (id_loja) 
        REFERENCES armazem_grao.dim_lojas(id_loja)
);

COMMENT ON TABLE armazem_grao.dim_funcionario IS 'Dimensão de funcionários. Contém dados cadastrais e alocação por loja.';

COMMIT;