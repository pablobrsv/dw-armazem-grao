BEGIN;

CREATE TABLE armazem_grao.dim_clientes (
    id_cliente SERIAL PRIMARY KEY,
    cep VARCHAR(10),
    cidade VARCHAR(100),
    estado CHAR(2),
    nome_cliente VARCHAR(200),
    cpf VARCHAR(11),
    data_nascimento DATE,
    bairro VARCHAR(100),
    telefone VARCHAR(50),
    email VARCHAR(150),
    data_cadastro DATE
);

COMMIT;