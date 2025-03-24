USE my_database;

DROP TABLE IF EXISTS layoffs;
DROP TABLE IF EXISTS layoffs_staging;
DROP TABLE IF EXISTS layoffs_staging2;

CREATE TABLE IF NOT EXISTS layoffs (
	company VARCHAR(255),
	location VARCHAR(255),
	industry VARCHAR(255),
	total_laid_off INT,
	percentage_laid_off DECIMAL(5, 2),
	date VARCHAR(255),
	stage VARCHAR(255),
	country VARCHAR(255),
	funds_raised_millions DECIMAL(10, 2)
)
;
