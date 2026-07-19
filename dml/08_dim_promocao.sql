BEGIN;

-- Injeção do calendário cobrindo os ciclos anuais completos
INSERT INTO armazem_grao.dim_promocao (nome_campanha, tipo_promocao, data_inicio, data_termino) VALUES

('Sem Promoção', 'Padrão', '1900-01-01', '2100-12-31'),
('Festival de Verão 2025', 'Sazonal', '2025-01-05', '2025-02-15'),
('Carnaval de Ofertas 2025', 'Desconto Direto', '2025-02-20', '2025-03-05'),
('Semana do Consumidor 2025', 'Desconto Direto', '2025-03-10', '2025-03-16'),
('Especial de Páscoa 2025', 'Sazonal', '2025-04-01', '2025-04-20'),
('Mês das Mães 2025', 'Sazonal', '2025-05-01', '2025-05-11'),
('Festival de Inverno 2025', 'Combo/Leve+', '2025-06-15', '2025-07-15'),
('Dia dos Pais 2025', 'Desconto Direto', '2025-08-01', '2025-08-10'),
('Aniversário Armazém do Grão 2025', 'Aniversário', '2025-08-15', '2025-09-15'),
('Especial Churrasco 2025', 'Desconto de Categoria', '2025-10-10', '2025-10-15'),
('Black Friday 2025', 'Queima de Estoque', '2025-11-20', '2025-11-30'),
('Natal em Família 2025', 'Sazonal', '2025-12-01', '2025-12-25'),
('Saldão de Fim de Ano 25/26', 'Queima de Estoque', '2025-12-26', '2026-01-05'),
('Liquida Verão 2026', 'Queima de Estoque', '2026-01-10', '2026-01-31'),
('Carnaval de Ofertas 2026', 'Desconto Direto', '2026-02-12', '2026-02-18'),
('Semana do Consumidor 2026', 'Desconto Direto', '2026-03-09', '2026-03-15'),
('Especial de Páscoa 2026', 'Sazonal', '2026-03-20', '2026-04-05'),
('Mês das Mães 2026', 'Sazonal', '2026-05-01', '2026-05-10'),
('Festival de Inverno 2026', 'Combo/Leve+', '2026-06-15', '2026-07-15'),
('Aniversário Armazém do Grão 2026', 'Aniversário', '2026-08-15', '2026-09-15'),
('Especial Mês das Crianças 2026', 'Desconto de Categoria', '2026-10-01', '2026-10-12'),
('Esquenta Black Friday 2026', 'Desconto Direto', '2026-11-01', '2026-11-20'),
('Black Friday 2026', 'Queima de Estoque', '2026-11-21', '2026-11-30'),
('Natal em Família 2026', 'Sazonal', '2026-12-01', '2026-12-25'),
('Saldão de Fim de Ano 26/27', 'Queima de Estoque', '2026-12-26', '2027-01-05');

COMMIT;

