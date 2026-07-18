-- 1. Remoção explícita das restrições de chave estrangeira
ALTER TABLE armazem_grao.fato_compras DROP CONSTRAINT fk_compras_fornecedor;
ALTER TABLE armazem_grao.fato_contas_pagar DROP CONSTRAINT fk_contas_fornecedor;


-- 2. Limpeza da tabela e reinício da identidade (Sem CASCADE)
TRUNCATE TABLE armazem_grao.dim_fornecedores RESTART IDENTITY;


-- 4. Recriação das restrições de chave estrangeira
ALTER TABLE armazem_grao.fato_compras ADD CONSTRAINT fk_compras_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES armazem_grao.dim_fornecedores(id_fornecedor) ON DELETE RESTRICT;
ALTER TABLE armazem_grao.fato_contas_pagar ADD CONSTRAINT fk_contas_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES armazem_grao.dim_fornecedores(id_fornecedor) ON DELETE RESTRICT;