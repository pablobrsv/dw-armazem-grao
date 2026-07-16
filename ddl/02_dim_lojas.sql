BEGIN;

CREATE TABLE armazem_grao.dim_lojas (
    id_loja INTEGER PRIMARY KEY,
    nome_filial VARCHAR(100) NOT NULL,
    endereco VARCHAR(200) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    data_inauguracao DATE NOT NULL,
    status_ativo BOOLEAN NOT NULL
);

COMMIT;