BEGIN;

CREATE VIEW armazem_grao.vw_curva_abc_estoque AS

WITH calculo_total_produto AS (
    -- Soma o valor financeiro imobilizado por produto na última fotografia (data mais recente)
    SELECT 
        f.codigo_do_produto,
        p.nome_produto,
        SUM(f.valor_financeiro_imobilizado) AS capital_imobilizado
    FROM armazem_grao.fato_estoque_diario f
    JOIN armazem_grao.dim_produtos p ON f.codigo_do_produto = p.codigo_barras
    WHERE f.data_fotografia = (SELECT MAX(data_fotografia) FROM armazem_grao.fato_estoque_diario)
    GROUP BY f.codigo_do_produto, p.nome_produto
),

calculo_percentual AS (
    -- Calcula a soma acumulada para identificar o peso de cada item no total do armazém
    SELECT 
        codigo_do_produto,
        nome_produto,
        capital_imobilizado,
        SUM(capital_imobilizado) OVER (ORDER BY capital_imobilizado DESC) AS capital_acumulado,
        SUM(capital_imobilizado) OVER () AS capital_total_armazem
    FROM calculo_total_produto
    WHERE capital_imobilizado > 0
)

-- Aplica o Princípio de Pareto para classificar as classes A, B e C
SELECT 
    codigo_do_produto,
    nome_produto,
    capital_imobilizado,
    ROUND((capital_imobilizado / capital_total_armazem) * 100, 2) AS percentual_individual,
    ROUND((capital_acumulado / capital_total_armazem) * 100, 2) AS percentual_acumulado,
    CASE 
        WHEN (capital_acumulado / capital_total_armazem) <= 0.80 THEN 'A' -- Representa 80% do capital
        WHEN (capital_acumulado / capital_total_armazem) <= 0.95 THEN 'B' -- Representa os próximos 15% do capital
        ELSE 'C' -- Representa os 5% restantes
    END AS classificacao_abc
FROM calculo_percentual
ORDER BY capital_imobilizado DESC;


COMMIT;