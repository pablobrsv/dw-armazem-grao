BEGIN;

CREATE TABLE armazem_grao.dim_calendario (

    data_completa DATE PRIMARY KEY,
    ano SMALLINT NOT NULL,
    mes SMALLINT NOT NULL,
    dia SMALLINT NOT NULL,
    trimestre SMALLINT NOT NULL,
    semestre SMALLINT NOT NULL,
    dia_semana SMALLINT NOT NULL,
    nome_mes VARCHAR(20) NOT NULL,
    nome_dia_semana VARCHAR(20) NOT NULL,
    fim_de_semana BOOLEAN NOT NULL,
    feriado_nacional BOOLEAN NOT NULL DEFAULT FALSE,
    descricao_feriado VARCHAR(100),
    dia_util BOOLEAN NOT NULL
);

INSERT INTO armazem_grao.dim_calendario (
    data_completa, ano, mes, dia, trimestre, semestre, 
    dia_semana, nome_mes, nome_dia_semana, fim_de_semana, 
    feriado_nacional, descricao_feriado, dia_util
)
WITH datas AS (
    SELECT datum::DATE AS data_completa
    FROM generate_series('2024-01-01'::TIMESTAMP, '2030-12-31'::TIMESTAMP, '1 day'::INTERVAL) AS datum
)

SELECT
    data_completa,
	
    EXTRACT(YEAR FROM data_completa)::SMALLINT AS ano,
    EXTRACT(MONTH FROM data_completa)::SMALLINT AS mes,
    EXTRACT(DAY FROM data_completa)::SMALLINT AS dia,
    EXTRACT(QUARTER FROM data_completa)::SMALLINT AS trimestre,
    CASE WHEN EXTRACT(MONTH FROM data_completa) <= 6 THEN 1 ELSE 2 END::SMALLINT AS semestre,
    EXTRACT(ISODOW FROM data_completa)::SMALLINT AS dia_semana,
    
    CASE EXTRACT(MONTH FROM data_completa)
        WHEN 1 THEN 'Janeiro' WHEN 2 THEN 'Fevereiro' WHEN 3 THEN 'Março'
        WHEN 4 THEN 'Abril' WHEN 5 THEN 'Maio' WHEN 6 THEN 'Junho'
        WHEN 7 THEN 'Julho' WHEN 8 THEN 'Agosto' WHEN 9 THEN 'Setembro'
        WHEN 10 THEN 'Outubro' WHEN 11 THEN 'Novembro' WHEN 12 THEN 'Dezembro'
    END::VARCHAR(20) AS nome_mes,
    
    CASE EXTRACT(ISODOW FROM data_completa)
        WHEN 1 THEN 'Segunda-feira' WHEN 2 THEN 'Terça-feira' WHEN 3 THEN 'Quarta-feira'
        WHEN 4 THEN 'Quinta-feira' WHEN 5 THEN 'Sexta-feira' WHEN 6 THEN 'Sábado' WHEN 7 THEN 'Domingo'
    END::VARCHAR(20) AS nome_dia_semana,
    
    CASE WHEN EXTRACT(ISODOW FROM data_completa) IN (6, 7) THEN TRUE ELSE FALSE END AS fim_de_semana,
    
    CASE 
        WHEN EXTRACT(MONTH FROM data_completa) = 1 AND EXTRACT(DAY FROM data_completa) = 1 THEN TRUE
        WHEN EXTRACT(MONTH FROM data_completa) = 4 AND EXTRACT(DAY FROM data_completa) = 21 THEN TRUE
        WHEN EXTRACT(MONTH FROM data_completa) = 5 AND EXTRACT(DAY FROM data_completa) = 1 THEN TRUE
        WHEN EXTRACT(MONTH FROM data_completa) = 9 AND EXTRACT(DAY FROM data_completa) = 7 THEN TRUE
        WHEN EXTRACT(MONTH FROM data_completa) = 10 AND EXTRACT(DAY FROM data_completa) = 12 THEN TRUE
        WHEN EXTRACT(MONTH FROM data_completa) = 11 AND EXTRACT(DAY FROM data_completa) = 2 THEN TRUE
        WHEN EXTRACT(MONTH FROM data_completa) = 11 AND EXTRACT(DAY FROM data_completa) = 15 THEN TRUE
        WHEN EXTRACT(MONTH FROM data_completa) = 12 AND EXTRACT(DAY FROM data_completa) = 25 THEN TRUE
        ELSE FALSE
    END AS feriado_nacional,
    
    CASE 
        WHEN EXTRACT(MONTH FROM data_completa) = 1 AND EXTRACT(DAY FROM data_completa) = 1 THEN 'Confraternização Universal'
        WHEN EXTRACT(MONTH FROM data_completa) = 4 AND EXTRACT(DAY FROM data_completa) = 21 THEN 'Tiradentes'
        WHEN EXTRACT(MONTH FROM data_completa) = 5 AND EXTRACT(DAY FROM data_completa) = 1 THEN 'Dia do Trabalhador'
        WHEN EXTRACT(MONTH FROM data_completa) = 9 AND EXTRACT(DAY FROM data_completa) = 7 THEN 'Independência do Brasil'
        WHEN EXTRACT(MONTH FROM data_completa) = 10 AND EXTRACT(DAY FROM data_completa) = 12 THEN 'Nossa Senhora Aparecida'
        WHEN EXTRACT(MONTH FROM data_completa) = 11 AND EXTRACT(DAY FROM data_completa) = 2 THEN 'Finados'
        WHEN EXTRACT(MONTH FROM data_completa) = 11 AND EXTRACT(DAY FROM data_completa) = 15 THEN 'Proclamação da República'
        WHEN EXTRACT(MONTH FROM data_completa) = 12 AND EXTRACT(DAY FROM data_completa) = 25 THEN 'Natal'
        ELSE NULL
    END::VARCHAR(100) AS descricao_feriado,

    CASE 
        WHEN EXTRACT(ISODOW FROM data_completa) IN (6, 7) THEN FALSE
        WHEN (
            (EXTRACT(MONTH FROM data_completa) = 1 AND EXTRACT(DAY FROM data_completa) = 1) OR
            (EXTRACT(MONTH FROM data_completa) = 4 AND EXTRACT(DAY FROM data_completa) = 21) OR
            (EXTRACT(MONTH FROM data_completa) = 5 AND EXTRACT(DAY FROM data_completa) = 1) OR
            (EXTRACT(MONTH FROM data_completa) = 9 AND EXTRACT(DAY FROM data_completa) = 7) OR
            (EXTRACT(MONTH FROM data_completa) = 10 AND EXTRACT(DAY FROM data_completa) = 12) OR
            (EXTRACT(MONTH FROM data_completa) = 11 AND EXTRACT(DAY FROM data_completa) = 2) OR
            (EXTRACT(MONTH FROM data_completa) = 11 AND EXTRACT(DAY FROM data_completa) = 15) OR
            (EXTRACT(MONTH FROM data_completa) = 12 AND EXTRACT(DAY FROM data_completa) = 25)
        ) THEN FALSE
        ELSE TRUE
    END AS dia_util

FROM datas;

CREATE INDEX idx_dim_calendario_ano_mes ON armazem_grao.dim_calendario(ano, mes);
CREATE INDEX idx_dim_calendario_dia_util ON armazem_grao.dim_calendario(dia_util);

COMMENT ON TABLE armazem_grao.dim_calendario IS 'Dimensão de tempo de 2024 a 2030, incluindo mapeamento de feriados nacionais fixos e cálculo preciso de dias úteis.';


 COMMIT;