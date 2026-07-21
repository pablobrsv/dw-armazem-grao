BEGIN;

-- 1. Remove a coluna de texto legado que está gerando conflito
ALTER TABLE armazem_grao.fato_metas_vendas 
DROP COLUMN IF EXISTS codigo_do_produto;

-- 2. Adiciona a Surrogate Key padronizada caso ela ainda não exista
ALTER TABLE armazem_grao.fato_metas_vendas 
ADD COLUMN IF NOT EXISTS id_produto INTEGER;

-- 3. Garante a integridade referencial com a dimensão de produtos
ALTER TABLE armazem_grao.fato_metas_vendas 
DROP CONSTRAINT IF EXISTS fk_metas_produto;

ALTER TABLE armazem_grao.fato_metas_vendas 
ADD CONSTRAINT fk_metas_produto 
FOREIGN KEY (id_produto) REFERENCES armazem_grao.dim_produtos(id_produto) ON DELETE RESTRICT;

COMMIT;