# SQL-Projects

<code> 

```--number of vehicles stolen every year
SELECT
	EXTRACT(
		'YEAR'
		FROM
			DATE_STOLEN
	) AS YEAR,
	COUNT(VEHICLE_ID) AS NUMBER_STOLEN
FROM
	STOLEN_VEHICLES
GROUP BY
	YEAR;```

SELECT
	TO_CHAR(DATE_STOLEN, 'Month') AS MONTH,
	COUNT(VEHICLE_ID) AS NUMBER_STOLEN
FROM
	STOLEN_VEHICLES
GROUP BY
	MONTH
ORDER BY
	NUMBER_STOLEN DESC;

CREATE TABLE IF NOT EXISTS NUM_STOLEN_PER_MONTH AS (
	SELECT
		MONTH,
		CONCAT(YEAR, '-', MONTH) AS COMBINED_COL,
		NUMBER_STOLEN
	FROM
		(
			SELECT
				TO_CHAR(DATE_STOLEN, 'YYYY') AS YEAR,
				TO_CHAR(DATE_STOLEN, 'Month') AS MONTH,
				COUNT(VEHICLE_ID) AS NUMBER_STOLEN
			FROM
				STOLEN_VEHICLES
			GROUP BY
				YEAR,
				MONTH
			ORDER BY
				YEAR ASC,
				MONTH DESC
		) AS M
);

SELECT
	*
FROM
	NUM_STOLEN_PER_MONTH;`



# Analyzing Students' Mental Health

Use your data manipulation skills to perform exploratory data analysis on a dataset around student mental health.

## Project Description

Studying abroad can be both exciting and difficult. But what might be contributing to this? One Japanese international university decided to find out!

Use your data manipulation skills to explore the data from a study on the mental health of international students, and find out which factors may have the greatest impact.


Does going to university in a different country affect your mental health? A Japanese international university surveyed its students in 2018 and published a study the following year that was approved by several ethical and regulatory boards.

The study found that international students have a higher risk of mental health difficulties than the general population, and that social connectedness (belonging to a social group) and acculturative stress (stress associated with joining a new culture) are predictive of depression.

Explore the students data using PostgreSQL to find out if you would come to a similar conclusion for international students and see if the length of stay is a contributing factor.

Here is a data description of the columns you may find helpful.