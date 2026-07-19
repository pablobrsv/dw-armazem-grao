-- Script para popular a tabela fato_vendas com dados sintéticos
DO $$
DECLARE

    v_data_atual DATE := '2025-01-05';
    v_data_fim DATE := '2027-01-05'; 
    v_loja RECORD;
    v_produto RECORD;
    v_lote RECORD;
    v_promocao_padrao INT;
    v_promocao_ativa INT;
    v_id_cupom_fiscal VARCHAR(50);
    v_data_hora_venda TIMESTAMP;
    v_id_cliente INT;
    v_id_transacao INT;
    v_id_funcionario INT;
    v_quantidade NUMERIC(10,3);
    v_valor_unitario_praticado NUMERIC(10,2);
    v_valor_desconto NUMERIC(10,2);
    v_valor_total_item NUMERIC(10,2);
    v_custo_total_item NUMERIC(10,2);
    v_qtd_cupons INT;
    v_qtd_itens INT;
	
BEGIN
	
    SELECT id_promocao INTO v_promocao_padrao 
	FROM armazem_grao.dim_promocao 
	WHERE nome_campanha = 'Sem Promoção' 
	LIMIT 1;

    WHILE v_data_atual <= v_data_fim LOOP
        FOR v_loja IN (SELECT id_loja FROM armazem_grao.dim_lojas) LOOP
            
            v_qtd_cupons := floor(random() * 16) + 30;
            
            FOR c IN 1 .. v_qtd_cupons LOOP
                v_id_cupom_fiscal := 'CF-' || to_char(v_data_atual, 'YYYYMMDD') || '-' || lpad(v_loja.id_loja::text, 3, '0') || '-' || lpad(c::text, 4, '0');
                v_data_hora_venda := v_data_atual::timestamp + interval '8 hours' + (random() * interval '14 hours');
                
                SELECT id_cliente INTO v_id_cliente 
				FROM armazem_grao.dim_clientes 
				ORDER BY random() 
				LIMIT 1;
				
                SELECT id_transacao INTO v_id_transacao 
				FROM armazem_grao.dim_transacao 
				ORDER BY random() 
				LIMIT 1;
				
                SELECT id_funcionario INTO v_id_funcionario 
				FROM armazem_grao.dim_funcionarios 
				WHERE id_loja = v_loja.id_loja 
				ORDER BY random() 
				LIMIT 1;
                
                v_qtd_itens := floor(random() * 5) + 2;
                
                FOR i IN 1 .. v_qtd_itens LOOP
                    SELECT codigo_barras INTO v_produto 
					FROM armazem_grao.dim_produtos 
					ORDER BY random() 
					LIMIT 1;
					
                    SELECT lote_id INTO v_lote 
					FROM armazem_grao.dim_lotes_validade 
					ORDER BY md5(v_produto.codigo_barras || lote_id::text) 
					LIMIT 1;
                    
                    v_valor_unitario_praticado := (mod(abs(hashtext(v_produto.codigo_barras)), 450) + 30) / 10.00; 
                    v_valor_unitario_praticado := v_valor_unitario_praticado * (1 + ((v_data_atual - '2025-01-05'::date) * 0.0001));
                    v_quantidade := floor(random() * 4) + 1;
                    
                    IF random() > 0.8 THEN
					
                        SELECT id_promocao INTO v_promocao_ativa 
						FROM armazem_grao.dim_promocao 
						WHERE id_promocao != v_promocao_padrao 
						ORDER BY random() 
						LIMIT 1;
						
                        v_valor_desconto := (v_quantidade * v_valor_unitario_praticado) * ((random() * 0.10) + 0.05);
                    ELSE
                        v_promocao_ativa := v_promocao_padrao;
                        v_valor_desconto := 0.00;
                    END IF;
                    
                    v_valor_total_item := (v_quantidade * v_valor_unitario_praticado) - v_valor_desconto;
                    v_custo_total_item := (v_quantidade * v_valor_unitario_praticado) * 0.65;
                    
                    -- A coluna data_venda e a variável v_data_atual foram restauradas aqui
                    INSERT INTO armazem_grao.fato_vendas (
                        id_cupom_fiscal, data_hora_venda, data_venda, id_loja, id_cliente,
                        codigo_do_produto, lote_id, id_transacao, id_funcionario, id_promocao,
                        quantidade_vendida, valor_unitario_praticado, valor_desconto,
                        valor_total_item, custo_total_item
                    ) VALUES (
                        v_id_cupom_fiscal, v_data_hora_venda, v_data_atual, v_loja.id_loja, v_id_cliente,
                        v_produto.codigo_barras, v_lote.lote_id, v_id_transacao, v_id_funcionario, v_promocao_ativa,
                        v_quantidade, round(v_valor_unitario_praticado, 2), round(v_valor_desconto, 2),
                        round(v_valor_total_item, 2), round(v_custo_total_item, 2)
                    );
                    
                END LOOP;
            END LOOP;
        END LOOP;
        v_data_atual := v_data_atual + interval '1 day';
    END LOOP;
END $$;