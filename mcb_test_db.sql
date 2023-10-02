CREATE DATABASE mcb_test
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_Kenya.1252'
    LC_CTYPE = 'English_Kenya.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
 -- Table: public.tbl_countries

-- DROP TABLE IF EXISTS public.tbl_countries;

CREATE TABLE IF NOT EXISTS public.tbl_countries
(
    country_id smallint NOT NULL DEFAULT nextval('tbl_countries_id_seq'::regclass),
    country_name character varying(100) COLLATE pg_catalog."default",
    iso_code character varying(10) COLLATE pg_catalog."default",
    region character varying(100) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tbl_countries
    OWNER to postgres;
-- Table: public.tbl_country_scoring

-- DROP TABLE IF EXISTS public.tbl_country_scoring;

CREATE TABLE IF NOT EXISTS public.tbl_country_scoring
(
    country_id smallint NOT NULL,
    cpi_year smallint NOT NULL,
    score smallint NOT NULL,
    sources_count smallint NOT NULL,
    cpi_rank smallint NOT NULL,
    standard_error real NOT NULL,
    lower_ci real NOT NULL,
    upper_ci real NOT NULL
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tbl_country_scoring
    OWNER to postgres;
   -- Table: public.tbl_country_scoring_details

-- DROP TABLE IF EXISTS public.tbl_country_scoring_details;

CREATE TABLE IF NOT EXISTS public.tbl_country_scoring_details
(
    country_id smallint NOT NULL,
    source_id smallint NOT NULL,
    score smallint NOT NULL,
    scrore_year smallint NOT NULL,
    date_created timestamp without time zone NOT NULL DEFAULT (now())::timestamp without time zone
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tbl_country_scoring_details
    OWNER to postgres;
    -- Table: public.tbl_cpi_raw_data

-- DROP TABLE IF EXISTS public.tbl_cpi_raw_data;

CREATE TABLE IF NOT EXISTS public.tbl_cpi_raw_data
(
    country character varying(500) COLLATE pg_catalog."default",
    iso3 text COLLATE pg_catalog."default",
    region text COLLATE pg_catalog."default",
    cpi_score text COLLATE pg_catalog."default",
    cpi_rank text COLLATE pg_catalog."default",
    standard_error real,
    number_of_sources smallint,
    lower_ci real,
    upper_ci real,
    source_african_development_bank_cpia smallint,
    source_bertelsmann_foundation_sustainable_governance_index smallint,
    source_bertelsmann_foundation_transformation_index smallint,
    source_economist_intelligence_unit_country_ratings smallint,
    source_freedom_house_nations_in_transit smallint,
    source_global_insight_country_risk_ratings smallint,
    source_imd_world_competitiveness_yearbook smallint,
    source_perc_asia_risk_guide smallint,
    source_prs_international_country_risk_guide smallint,
    source_varieties_of_democracy_project smallint,
    source_world_bank_cpia smallint,
    source_world_economic_forum_eos smallint,
    source_world_justice_project_rule_of_law_index smallint
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tbl_cpi_raw_data
    OWNER to postgres;
   -- Table: public.tbl_scoring_sources

-- DROP TABLE IF EXISTS public.tbl_scoring_sources;

CREATE TABLE IF NOT EXISTS public.tbl_scoring_sources
(
    score_id smallint NOT NULL DEFAULT nextval('tbl_scoring_sources_id_seq'::regclass),
    score_description character varying(500) COLLATE pg_catalog."default",
    date_created timestamp without time zone NOT NULL DEFAULT (now())::timestamp without time zone
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tbl_scoring_sources
    OWNER to postgres;
   -- Table: public.tbl_wdi_country

-- DROP TABLE IF EXISTS public.tbl_wdi_country;

CREATE TABLE IF NOT EXISTS public.tbl_wdi_country
(
    country_code text COLLATE pg_catalog."default",
    short_name text COLLATE pg_catalog."default",
    table_name text COLLATE pg_catalog."default",
    long_name text COLLATE pg_catalog."default",
    alpha_code text COLLATE pg_catalog."default",
    currency_unit text COLLATE pg_catalog."default",
    special_notes character varying(5000) COLLATE pg_catalog."default",
    region text COLLATE pg_catalog."default",
    income_group text COLLATE pg_catalog."default",
    wb_code text COLLATE pg_catalog."default",
    national_accounts_base_year text COLLATE pg_catalog."default",
    national_accounts_reference_year text COLLATE pg_catalog."default",
    sna_price_valuation character varying(1000) COLLATE pg_catalog."default",
    lending_category text COLLATE pg_catalog."default",
    other_groups text COLLATE pg_catalog."default",
    system_of_national_accounts text COLLATE pg_catalog."default",
    alternative_conversion_factor text COLLATE pg_catalog."default",
    ppp_survey_year text COLLATE pg_catalog."default",
    balance_of_payments_manual_in_use text COLLATE pg_catalog."default",
    external_debt_reporting_status text COLLATE pg_catalog."default",
    system_of_trade text COLLATE pg_catalog."default",
    government_accounting_concept text COLLATE pg_catalog."default",
    imf_data_dissemination_standard character varying(1000) COLLATE pg_catalog."default",
    latest_population_census character varying(1000) COLLATE pg_catalog."default",
    latest_household_survey character varying(1000) COLLATE pg_catalog."default",
    source_of_most_recent_income_and_expenditure_data character varying(1000) COLLATE pg_catalog."default",
    vital_registration_complete text COLLATE pg_catalog."default",
    latest_agricultural_census text COLLATE pg_catalog."default",
    latest_industrial_data text COLLATE pg_catalog."default",
    latest_trade_data text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tbl_wdi_country
    OWNER to postgres;
   -- Table: public.tbl_wdi_country_series

-- DROP TABLE IF EXISTS public.tbl_wdi_country_series;

CREATE TABLE IF NOT EXISTS public.tbl_wdi_country_series
(
    country_code character varying COLLATE pg_catalog."default",
    series_code character varying COLLATE pg_catalog."default",
    description character varying COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tbl_wdi_country_series
    OWNER to postgres;
   -- Table: public.tbl_wdi_foot_note

-- DROP TABLE IF EXISTS public.tbl_wdi_foot_note;

CREATE TABLE IF NOT EXISTS public.tbl_wdi_foot_note
(
    country_code character varying COLLATE pg_catalog."default",
    series_code character varying COLLATE pg_catalog."default",
    note_year character varying COLLATE pg_catalog."default",
    description character varying COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tbl_wdi_foot_note
    OWNER to postgres;
   -- FUNCTION: public.proc_load_corruption_perception_index()

-- DROP FUNCTION IF EXISTS public.proc_load_corruption_perception_index();

CREATE OR REPLACE FUNCTION public.proc_load_corruption_perception_index(
	)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE

BEGIN
	--clear table to avoid double entry
		TRUNCATE TABLE tbl_cpi_raw_data;
	--load data from csv into raw data table
	COPY tbl_cpi_raw_data 
	FROM 'D:\mcb_test\converted\Corruption_Perception_Index_Data_Set.CSV' WITH CSV HEADER encoding 'windows-1251';
	--load scoring sources
	INSERT INTO tbl_scoring_sources (score_description)
	SELECT column_name 
	FROM information_schema.columns 
	WHERE table_name = 'tbl_cpi_raw_data' and column_name like 'source%';
	--clean the data
	update tbl_scoring_sources set score_description=replace(score_description, '_', ' ');
	update tbl_scoring_sources set score_description=replace(score_description, 'source ', ' ');
	--load data into various tables
	INSERT INTO tbl_countries (country_name,iso_code,region)
	SELECT country,iso3,region 
	FROM tbl_cpi_raw_data;
	--select * from tbl_country_scoring
	INSERT INTO tbl_country_scoring(country_id,cpi_year,score,sources_count,cpi_rank,standard_error,lower_ci,upper_ci)
	SELECT country_id, '2020',cpi_score::smallint,number_of_sources::smallint,cpi_rank::smallint,standard_error,lower_ci,upper_ci
	FROM tbl_cpi_raw_data  
	JOIN tbl_countries ON tbl_countries.country_name=tbl_cpi_raw_data.country;

--upload wdi_country
	TRUNCATE TABLE tbl_wdi_country;
	COPY tbl_wdi_country 
	FROM 'D:\mcb_test\converted\WDICountry.CSV' WITH CSV HEADER encoding 'windows-1251';
--upload wdi_country_series
	TRUNCATE TABLE tbl_wdi_country_series;
	COPY tbl_wdi_country_series 
	FROM 'D:\mcb_test\converted\WDICountry-Series.CSV' WITH CSV HEADER encoding 'windows-1251';
--upload wdi_foot_note
	TRUNCATE TABLE tbl_wdi_foot_note;
	COPY tbl_wdi_foot_note
	FROM 'D:\mcb_test\converted\WDIFootNote.CSV' WITH CSV HEADER encoding 'windows-1251';
end;
$BODY$;

ALTER FUNCTION public.proc_load_corruption_perception_index()
    OWNER TO postgres;
