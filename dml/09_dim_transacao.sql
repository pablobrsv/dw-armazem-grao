BEGIN;

INSERT INTO armazem_grao.dim_transacao (

    canal_venda, forma_pagamento, bandeira_cartao, 
    tipo_parcelamento, tipo_caixa, modalidade_entrega, 
    status_transacao, fidelidade_acionada
	
) VALUES 

-- 1. Meios de Pagamento Gerais (Loja Física)
('Loja Física', 'Dinheiro', 'N/A', 'À Vista', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Não'),
('Loja Física', 'PIX', 'N/A', 'À Vista', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Sim'),
('Loja Física', 'Cartão Débito', 'Elo', 'À Vista', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Não'),
('Loja Física', 'Voucher Alimentação', 'VR', 'À Vista', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Não'),
('Loja Física', 'Voucher Alimentação', 'Sodexo', 'À Vista', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Não'),

-- 2. Cartão de Crédito - Visa (1x a 6x)
('Loja Física', 'Cartão Crédito', 'Visa', '1x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Não'),
('Loja Física', 'Cartão Crédito', 'Visa', '2x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Sim'),
('Loja Física', 'Cartão Crédito', 'Visa', '3x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Sim'),
('Loja Física', 'Cartão Crédito', 'Visa', '4x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Não'),
('Loja Física', 'Cartão Crédito', 'Visa', '5x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Sim'),
('Loja Física', 'Cartão Crédito', 'Visa', '6x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Sim'),

-- 3. Cartão de Crédito - Mastercard (1x a 6x)
('Loja Física', 'Cartão Crédito', 'Mastercard', '1x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Não'),
('Loja Física', 'Cartão Crédito', 'Mastercard', '2x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Sim'),
('Loja Física', 'Cartão Crédito', 'Mastercard', '3x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Sim'),
('Loja Física', 'Cartão Crédito', 'Mastercard', '4x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Não'),
('Loja Física', 'Cartão Crédito', 'Mastercard', '5x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Sim'),
('Loja Física', 'Cartão Crédito', 'Mastercard', '6x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Sim'),

-- 4. Cartão de Crédito - Hipercard (1x a 6x)
('Loja Física', 'Cartão Crédito', 'Hipercard', '1x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Não'),
('Loja Física', 'Cartão Crédito', 'Hipercard', '2x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Sim'),
('Loja Física', 'Cartão Crédito', 'Hipercard', '3x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Sim'),
('Loja Física', 'Cartão Crédito', 'Hipercard', '4x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Não'),
('Loja Física', 'Cartão Crédito', 'Hipercard', '5x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Sim'),
('Loja Física', 'Cartão Crédito', 'Hipercard', '6x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Sim'),

-- 5. Cartão de Crédito - Elo (1x a 6x)
('Loja Física', 'Cartão Crédito', 'Elo', '1x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Não'),
('Loja Física', 'Cartão Crédito', 'Elo', '2x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Sim'),
('Loja Física', 'Cartão Crédito', 'Elo', '3x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Sim'),
('Loja Física', 'Cartão Crédito', 'Elo', '4x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Não'),
('Loja Física', 'Cartão Crédito', 'Elo', '5x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Sim'),
('Loja Física', 'Cartão Crédito', 'Elo', '6x', 'Caixa Convencional', 'Pronta Entrega', 'Aprovada', 'Sim'),

-- 6. Canais Alternativos (Totem e Delivery)
('Loja Física', 'PIX', 'N/A', 'À Vista', 'Totem Autoatendimento', 'Pronta Entrega', 'Aprovada', 'Sim'),
('Loja Física', 'Cartão Crédito', 'Visa', '1x', 'Totem Autoatendimento', 'Pronta Entrega', 'Aprovada', 'Não'),
('App/Delivery', 'Cartão Crédito', 'Visa', '1x', 'E-commerce', 'Delivery', 'Aprovada', 'Sim'),
('App/Delivery', 'PIX', 'N/A', 'À Vista', 'E-commerce', 'Delivery', 'Aprovada', 'Não'),

-- 7. Exceções e Ajustes (Cancelamento e Estorno)

('Loja Física', 'Cartão Crédito', 'Visa', '1x', 'Caixa Convencional', 'Pronta Entrega', 'Cancelada', 'Não'),
('Loja Física', 'Cartão Crédito', 'Visa', '1x', 'Caixa Convencional', 'Pronta Entrega', 'Estorno', 'Não'),
('Loja Física', 'Cartão Crédito', 'Mastercard', '1x', 'Caixa Convencional', 'Pronta Entrega', 'Cancelada', 'Não'),
('Loja Física', 'Cartão Crédito', 'Mastercard', '2x', 'Caixa Convencional', 'Pronta Entrega', 'Estorno', 'Sim');

COMMIT;