-- 1. Remoção explícita das restrições de chave estrangeira
ALTER TABLE armazem_grao.fato_compras DROP CONSTRAINT fk_compras_fornecedor;
ALTER TABLE armazem_grao.fato_contas_pagar DROP CONSTRAINT fk_contas_fornecedor;


-- 2. Limpeza da tabela e reinício da identidade (Sem CASCADE)
TRUNCATE TABLE armazem_grao.dim_fornecedores RESTART IDENTITY;


-- 4. Recriação das restrições de chave estrangeira
ALTER TABLE armazem_grao.fato_compras ADD CONSTRAINT fk_compras_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES armazem_grao.dim_fornecedores(id_fornecedor) ON DELETE RESTRICT;
ALTER TABLE armazem_grao.fato_contas_pagar ADD CONSTRAINT fk_contas_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES armazem_grao.dim_fornecedores(id_fornecedor) ON DELETE RESTRICT;


-- 5. Ajustanto os dias de vencimento dos fornecedores para refletir a realidade do mercado.

BEGIN;

    UPDATE armazem_grao.dim_fornecedores
    SET condicao_pagamento_padrao = 

    CASE 
        -- Alto Giro / Bebidas (Prazos curtos e agressivos)
        WHEN nome_fantasia IN ('Ambev', 'Coca-Cola Andina', 'Heineken', 'Grupo Petrópolis', 'Itaipava Distribuição', 'Fruki') THEN '14/21/28 dias'
        
        -- Proteína Animal / Frigoríficos (Risco alto, prazo muito curto)
        WHEN nome_fantasia IN ('JBS Friboi', 'BRF (Sadia/Perdigão)', 'Seara', 'Aurora', 'Copacol', 'Pif Paf', 'Frigorífico Serrano', 'Aves Serrana') THEN '14/21 dias'
        
        -- Laticínios e Perecíveis Curtos (Prazo médio acompanhando a validade)
        WHEN nome_fantasia IN ('Danone', 'Vigor', 'Itambé', 'Piracanjuba', 'Tirol', 'Laticínios Nogueira', 'Verde Vale', 'Ovos Petrópolis') THEN '21/28 dias'
        
        -- Higiene e Limpeza (Estoque de segurança, prazos longos do varejo)
        WHEN categoria_fornecimento IN ('Limpeza', 'Higiene Pessoal') THEN '30/60/90 dias'
        
        -- Mercearia Seca de Grande Volume
        WHEN nome_fantasia IN ('Nestlé', 'Mondelez', 'Pepsico', 'Bunge', 'Cargill', 'M. Dias Branco S.A.') THEN '30/45/60 dias'
        WHEN categoria_fornecimento = 'Mercearia Seca' THEN '30/60 dias'
        
        -- Produtores Locais e Hortifrúti (Giro diário, pagamento por borderô semanal)
        WHEN categoria_fornecimento = 'Hortifrúti' THEN '7 dias'
        WHEN categoria_fornecimento = 'Padaria e Confeitaria' THEN '15 dias'
        
        -- Cervejarias Artesanais Locais
        WHEN nome_fantasia IN ('Bohemia', 'Império', 'Odin', 'Doutor Duranz') THEN '15/30 dias'
        
        ELSE '28 dias'
    END;

COMMIT;