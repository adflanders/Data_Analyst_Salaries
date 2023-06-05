
-- ds_salaries is the orginal file downloaded from kaggle.com, which contains data related to jobs in data science

/*
	In this query I will be taking data analysis job info from
	ds_salaries and make a seperate table containing them.
	After creating and updating the new table, 'data_analytics',
	I will change some data and prepare it to be a csv to then visualize
	on Tableau.

	ds_salaries is the orginal file downloaded from kaggle.com, which contains data related to jobs in data science.
	the creator of ds_salaries pulled the data from https://ai-jobs.net/
*/

SELECT *
FROM ds_salaries

-- Create new table for jobs strictly related to data analysis

CREATE TABLE [dbo].[data_analytics](
	[work_year] [smallint] NOT NULL,
	[experience_level] [nvarchar](50) NOT NULL,
	[employment_type] [nvarchar](50) NOT NULL,
	[job_title] [nvarchar](50) NOT NULL,
	[salary] [int] NOT NULL,
	[salary_currency] [nvarchar](50) NOT NULL,
	[salary_in_usd] [int] NOT NULL,
	[employee_residence] [nvarchar](50) NOT NULL,
	[remote_ratio] [tinyint] NOT NULL,
	[company_location] [nvarchar](50) NOT NULL,
	[company_size] [nvarchar](50) NOT NULL
)

-- Add data analysis jobs from ds_salaries to data_analytics data frame

INSERT INTO data_analytics(work_year, experience_level, employment_type, job_title,
salary, salary_currency, salary_in_usd, employee_residence, remote_ratio, company_location, company_size)
SELECT work_year, experience_level, employment_type, job_title,
salary, salary_currency, salary_in_usd, employee_residence, remote_ratio, company_location, company_size
FROM ds_salaries
WHERE job_title LIKE '%data%analyst%'

-- Now working on data_analytics data frame

SELECT *
FROM data_analytics
WHERE salary_currency <> 'USD'
ORDER BY salary_currency

-- Dropped 'salary_in_usd' column due to poor/inaccurate conversion values

ALTER TABLE data_analytics
DROP COLUMN salary_in_usd

-- Find how many different currencys there are for converting values

SELECT DISTINCT(salary_currency)
FROM data_analytics
WHERE salary_currency <> 'USD'

/*
	Converting the values into usd based off what the currencies are relative to the US dollar
	
	AUD = 0.66
	BRL = 0.20
	CAD = 0.74
	EUR = 1.07
	GBP = 1.24
	HUF = 0.0029
	INR = 0.012
	PLN = 0.24
	SGD = 0.74

*/

-- Update all salary values

UPDATE data_analytics
SET salary = salary * 0.66
WHERE salary_currency = 'AUD'

UPDATE data_analytics
SET salary = salary * 0.2
WHERE salary_currency = 'BRL'

UPDATE data_analytics
SET salary = salary * 0.74
WHERE salary_currency = 'CAD'

UPDATE data_analytics
SET salary = salary * 1.07
WHERE salary_currency = 'EUR'

UPDATE data_analytics
SET salary = salary * 1.24
WHERE salary_currency = 'GBP'

UPDATE data_analytics
SET salary = salary * 0.0029
WHERE salary_currency = 'HUF'

UPDATE data_analytics
SET salary = salary * 0.012
WHERE salary_currency = 'INR'

UPDATE data_analytics
SET salary = salary * 0.24
WHERE salary_currency = 'PLN'

UPDATE data_analytics
SET salary = salary * 0.74
WHERE salary_currency = 'SGD'


/*
 Will combine senior level and executive level as senior level to have 3 varrying levels, 
 and there are only 3 Executives in the table
*/

UPDATE data_analytics
SET experience_level = 'SE'
WHERE experience_level = 'EX'


/*
	Will make all 'company_location' values whole country names instead of abbreviated
	to make it easier to visualize on Tableau
*/


SELECT DISTINCT(company_location)
FROM data_analytics

UPDATE data_analytics
SET company_location = 'Argentina'
WHERE company_location = 'AR'

UPDATE data_analytics
SET company_location = 'American Samoa'
WHERE company_location = 'AS'

UPDATE data_analytics
SET company_location = 'Australia'
WHERE company_location = 'AU'

UPDATE data_analytics
SET company_location = 'Brazil'
WHERE company_location = 'BR'

UPDATE data_analytics
SET company_location = 'Canada'
WHERE company_location = 'CA'

UPDATE data_analytics
SET company_location = 'Central African Republic'
WHERE company_location = 'CF'

UPDATE data_analytics
SET company_location = 'Germany'
WHERE company_location = 'DE'

UPDATE data_analytics
SET company_location = 'Denmark'
WHERE company_location = 'DK'

UPDATE data_analytics
SET company_location = 'Spain'
WHERE company_location = 'ES'

UPDATE data_analytics
SET company_location = 'France'
WHERE company_location = 'FR'

UPDATE data_analytics
SET company_location = 'United Kingdom'
WHERE company_location = 'GB'

UPDATE data_analytics
SET company_location = 'Greece'
WHERE company_location = 'GR'

UPDATE data_analytics
SET company_location = 'Honduras'
WHERE company_location = 'HN'

UPDATE data_analytics
SET company_location = 'Croatia'
WHERE company_location = 'HR'

UPDATE data_analytics
SET company_location = 'Indonesia'
WHERE company_location = 'ID'

UPDATE data_analytics
SET company_location = 'India'
WHERE company_location = 'IN'

UPDATE data_analytics
SET company_location = 'Kenya'
WHERE company_location = 'KE'

UPDATE data_analytics
SET company_location = 'Luxembourg'
WHERE company_location = 'LU'

UPDATE data_analytics
SET company_location = 'Nigeria'
WHERE company_location = 'NG'

UPDATE data_analytics
SET company_location = 'Philippines'
WHERE company_location = 'PH'

UPDATE data_analytics
SET company_location = 'Pakistan'
WHERE company_location = 'PK'

UPDATE data_analytics
SET company_location = 'Portugal'
WHERE company_location = 'PT'

UPDATE data_analytics
SET company_location = 'Singapore'
WHERE company_location = 'SG'

UPDATE data_analytics
SET company_location = 'United States'
WHERE company_location = 'US'



-- Export data and visualize on Tableau