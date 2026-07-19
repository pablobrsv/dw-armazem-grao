
-- Adicionando o orçamento limite para cada campanha, 
-- com base em critérios de tipo de promoção e nome da campanha.
BEGIN;

UPDATE armazem_grao.dim_promocao
SET 
    canal_veiculacao = CASE 
        WHEN nome_campanha = 'Sem Promoção' THEN 'Orgânico'
        WHEN nome_campanha LIKE '%Black Friday%' OR nome_campanha LIKE '%Aniversário%' THEN 'Marketing 360º'
        WHEN tipo_promocao = 'Sazonal' THEN 'Mídia Local'
        WHEN tipo_promocao IN ('Desconto de Categoria', 'Combo/Leve+') THEN 'Mídia Digital'
        WHEN tipo_promocao = 'Desconto Direto' THEN 'Trade Marketing'
        ELSE canal_veiculacao
    END,
    
    custo_campanha_estimado = CASE 
        WHEN nome_campanha = 'Sem Promoção' THEN 0.00
        WHEN nome_campanha LIKE '%Black Friday%' OR nome_campanha LIKE '%Aniversário%' THEN 15000.00
        WHEN tipo_promocao = 'Sazonal' THEN 5000.00
        WHEN tipo_promocao IN ('Desconto de Categoria', 'Combo/Leve+') THEN 2000.00
        WHEN tipo_promocao = 'Desconto Direto' THEN 800.00
        ELSE custo_campanha_estimado
    END;

COMMIT;


-- Atualizando campanhas de "Queima de Estoque"

BEGIN;

UPDATE armazem_grao.dim_promocao
SET 
    canal_veiculacao = 'Mídia Local',
    custo_campanha_estimado = 5000.00
WHERE 
    tipo_promocao = 'Queima de Estoque' 
    AND canal_veiculacao = 'Não Aplicável';

COMMIT;