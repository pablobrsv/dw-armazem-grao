BEGIN;

CREATE TABLE armazem_grao.dim_produtos (

    id_produto SERIAL PRIMARY KEY,
    nome_produto VARCHAR(255) NOT NULL,
    codigo_barras VARCHAR(13) UNIQUE NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    subcategoria VARCHAR(100),
    marca VARCHAR(100),
    unidade_medida VARCHAR(20) NOT NULL,
    peso_liquido NUMERIC(10, 3), 
    peso_bruto NUMERIC(10, 3),
    perecivel BOOLEAN DEFAULT FALSE,
    dias_validade INTEGER,
    custo_unitario NUMERIC(10, 2),
    preco_venda NUMERIC(10, 2),
    fornecedor_principal VARCHAR(100),
    status_ativo BOOLEAN DEFAULT TRUE
);

CREATE INDEX idx_dim_produtos_codigo_barras ON armazem_grao.dim_produtos(codigo_barras);

COMMENT ON TABLE armazem_grao.dim_produtos IS 'Tabela de dimensão com o cadastro mestre e atributos imutáveis dos produtos.';
COMMENT ON COLUMN armazem_grao.dim_produtos.codigo_barras IS 'Código EAN-13 único de identificação do produto.';
COMMENT ON COLUMN armazem_grao.dim_produtos.peso_liquido IS 'Peso líquido em KG ou L. Utilizado para cálculo de preço por peso.';
COMMENT ON COLUMN armazem_grao.dim_produtos.peso_bruto IS 'Peso bruto em KG. Utilizado para dimensionamento de carga e frete.';
COMMENT ON COLUMN armazem_grao.dim_produtos.perecivel IS 'Indicador se o produto exige controle rigoroso de validade e refrigeração.';
COMMENT ON COLUMN armazem_grao.dim_produtos.dias_validade IS 'Expectativa de dias de validade a partir da fabricação para auditoria de lotes.';
COMMENT ON COLUMN armazem_grao.dim_produtos.custo_unitario IS 'Custo padrão de aquisição.';
COMMENT ON COLUMN armazem_grao.dim_produtos.preco_venda IS 'Preço de prateleira sugerido ou base.';

COMMIT;