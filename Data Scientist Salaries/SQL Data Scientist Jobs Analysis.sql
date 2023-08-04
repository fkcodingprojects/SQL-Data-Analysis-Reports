-- Average Salary per experience level

SELECT experience_level, AVG(salary) AS average_salary
FROM dbo.salaries
GROUP BY experience_level;

-- Average salary per experience level and per company location

SELECT experience_level, company_location, AVG(salary) AS average_salary
FROM dbo.salaries
GROUP BY experience_level, company_location;


-- Employment type probability per company location

SELECT
    experience_level,
    company_location,
    employment_type,
    COUNT(employment_type) AS employment_type_count,
    COUNT(employment_type) * 1.0 / SUM(COUNT(employment_type)) OVER (PARTITION BY experience_level, company_location) AS probability
FROM dbo.salaries
GROUP BY experience_level, company_location, employment_type;

-- Count Company Size Per Company Location

SELECT
    company_location,
    company_size,
    COUNT(*) AS company_size_count
FROM dbo.salaries
GROUP BY company_location, company_size;


-- Count Employment Type Per Company Location

SELECT
    company_location,
    employment_type,
    COUNT(*) AS employment_type_count
FROM dbo.salaries
GROUP BY company_location, employment_type;
