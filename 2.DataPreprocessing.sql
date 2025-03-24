USE my_database;

SELECT *
FROM layoffs
LIMIT 5
;

--- Create a new table to work on
CREATE TABLE layoffs_staging
LIKE layoffs
;

--- Insert the values of layoffs in the new table
INSERT layoffs_staging
SELECT *
FROM layoffs
;

--- Remove Duplicates by creating a new table using ROW_NUMBER window function partitioned by all the columns, if a row has a ROW_NUMBER higher than 1 it has a duplicate.
CREATE TABLE layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
	PARTITION BY
		company, location, industry,
		total_laid_off, percentage_laid_off, `date`,
		stage, country, funds_raised_millions
) AS row_num
FROM layoffs_staging
;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1
;

DELETE
FROM layoffs_staging2
WHERE row_num > 1
;

--- Standardize Data
--- Using DISTINCT we can check the columns for irregularities.
SELECT DISTINCT(industry)
FROM layoffs_staging2
ORDER BY 1
;

--- We see Crypto but written in diffent ways, since it refers to the same industry we are Going to set them all to only "Crypto"
UPDATE layoffs_staging2
SET industry = "Crypto"
WHERE industry LIKE "Crypto%"
;

SELECT DISTINCT(country)
FROM layoffs_staging2
ORDER BY 1
;

--- We remove the trailing "." where we need to, so all the data is consistent
UPDATE layoffs_staging2
SET country = TRIM(TRAILING "." FROM country)
WHERE country LIKE "United States%"
;

--- Check the columns data types
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'layoffs_staging2'
;

--- Convert the data in the columns to the expected type
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, "%m/%d/%Y")
;

--- Change the data type in the column
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE