-- Script para popular a tabela fato_compras com dados sintéticos
DO $$

DECLARE

    v_data_atual DATE := '2026-01-01';
    v_data_fim DATE := '2026-07-19'; 
    v_data_recebimento DATE;
    v_loja RECORD;
    v_produto RECORD;
    v_fornecedor RECORD;
    v_lote RECORD;
    v_numero_nf VARCHAR(50);
    v_quantidade NUMERIC(10,3);
    v_custo NUMERIC(10,2);
    v_frete NUMERIC(10,2);
    v_impostos NUMERIC(10,2);

BEGIN

    WHILE v_data_atual <= v_data_fim LOOP
        FOR v_loja IN (SELECT id_loja FROM armazem_grao.dim_lojas) LOOP
            
            v_numero_nf := 'NF-' || to_char(v_data_atual, 'YYYYMMDD') || '-' || lpad(v_loja.id_loja::text, 3, '0') || '-' || floor(random() * 9999 + 1)::text;
            v_data_recebimento := v_data_atual + (floor(random() * 5) + 1)::integer;

            FOR i IN 1 .. (floor(random() * 6) + 3) LOOP
                
                -- 1. Eixo Principal: Sorteia o Produto aleatoriamente
                SELECT codigo_barras INTO v_produto FROM armazem_grao.dim_produtos ORDER BY random() LIMIT 1;
                
                -- 2. Ancoragem Determinística (Fornecedor): Garante que este produto sempre venha do mesmo fornecedor
                SELECT id_fornecedor INTO v_fornecedor 
                FROM armazem_grao.dim_fornecedores 
                ORDER BY md5(v_produto.codigo_barras || id_fornecedor::text) LIMIT 1;
                
                -- 3. Ancoragem Lógica (Lote): Atrela o lote à identidade exata deste produto
                SELECT lote_id INTO v_lote 
                FROM armazem_grao.dim_lotes_validade 
                ORDER BY md5(v_produto.codigo_barras || lote_id::text) LIMIT 1;
                
                v_quantidade := (random() * 150) + 10.000; 
                v_custo := (random() * 50) + 1.50; 
                v_frete := (random() * 15) + 5.00;
                v_impostos := v_quantidade * v_custo * 0.12; 
                
                INSERT INTO armazem_grao.fato_compras (
                    numero_nota_fiscal, data_emissao, data_recebimento, 
                    id_fornecedor, id_loja, codigo_do_produto, lote_id, 
                    quantidade_comprada, custo_unitario, valor_frete, valor_impostos
                
                ) VALUES (
                    v_numero_nf, v_data_atual, v_data_recebimento,
                    v_fornecedor.id_fornecedor, v_loja.id_loja, v_produto.codigo_barras, v_lote.lote_id,
                    v_quantidade, v_custo, v_frete, v_impostos
                );
            END LOOP;
        END LOOP;
        
        v_data_atual := v_data_atual + interval '4 days';
    END LOOP;
END $$;