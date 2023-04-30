SELECT * FROM portfolio.hr;

USE portfolio;

SELECT * FROM hr;

-- change emplyee id
ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20)NULL;  

-- checking the data types
DESCRIBE hr;

-- use date format function to convert it to sql date format
SELECT birthdate FROM hr;

SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;


ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SELECT birthdate FROM hr;


UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')),'0000-00-00')
WHERE true;

SELECT termdate FROM hr;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

-- adding Age column to the database
ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE()); -- calculating and getting age
-- SELECT birthdate, age FROM hr 

-- calculating minimum and maxumum age
SELECT
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;

SELECT count(*)FROM hr WHERE age<18;






