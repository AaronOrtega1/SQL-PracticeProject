USE my_database;

--- Dealing with blank or null values
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = ""
;

--- Turn blank values into NULLs
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = ""
;

--- We are going to use a self join on the company name to fill where it has a null value and another occurrence that isn't null.
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL
;

--- We can delete certain rows that have null values that we can't populate.
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

--- Drop the row_num column since it has no value anymore for our database.
ALTER TABLE layoffs_staging2
DROP COLUMN row_num
;