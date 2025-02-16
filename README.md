# SQL-Projects

```sql
--number of vehicles stolen every year
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
	YEAR;

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
	NUM_STOLEN_PER_MONTH;

--DROP TABLE num_stolen_per_month;
SELECT
	DATE_TRUNC('day', DATE_STOLEN)::DATE AS DAY,
	--TO_CHAR(date_stolen, 'Month') AS month, 
	COUNT(VEHICLE_ID) AS NUMBER_STOLEN
FROM
	STOLEN_VEHICLES
GROUP BY
	DAY
ORDER BY
	DAY ASC;

--vehicle make mostly stolen 
SELECT
	*
FROM
	STOLEN_VEHICLES AS S
	LEFT JOIN MAKE_DETAILS AS M ON S.MAKE_ID = M.MAKE_ID
	LEFT JOIN LOCATIONS AS L ON S.LOCATION_ID::INT = L.LOCATION_ID;

--vehicle type
WITH
	FULL_DATA AS (
		SELECT
			*
		FROM
			STOLEN_VEHICLES AS S
			LEFT JOIN MAKE_DETAILS AS M ON S.MAKE_ID = M.MAKE_ID
			LEFT JOIN LOCATIONS AS L ON S.LOCATION_ID::INT = L.LOCATION_ID
	)
SELECT
	VEHICLE_TYPE,
	COUNT(*) AS NUM_VEHICLES
FROM
	FULL_DATA
WHERE
	VEHICLE_TYPE IS NOT NULL
GROUP BY
	VEHICLE_TYPE
ORDER BY
	NUM_VEHICLES DESC;

--make type
WITH
	FULL_DATA AS (
		SELECT
			*
		FROM
			STOLEN_VEHICLES AS S
			LEFT JOIN MAKE_DETAILS AS M ON S.MAKE_ID = M.MAKE_ID
			LEFT JOIN LOCATIONS AS L ON S.LOCATION_ID::INT = L.LOCATION_ID
	)
SELECT
	MAKE_TYPE,
	COUNT(*) AS NUM_VEHICLES
FROM
	FULL_DATA
WHERE
	MAKE_TYPE IS NOT NULL
GROUP BY
	MAKE_TYPE
ORDER BY
	NUM_VEHICLES DESC;

--make name
WITH
	FULL_DATA AS (
		SELECT
			*
		FROM
			STOLEN_VEHICLES AS S
			LEFT JOIN MAKE_DETAILS AS M ON S.MAKE_ID = M.MAKE_ID
			LEFT JOIN LOCATIONS AS L ON S.LOCATION_ID::INT = L.LOCATION_ID
	)
SELECT
	MAKE_NAME,
	COUNT(*) AS NUM_VEHICLES
FROM
	FULL_DATA
WHERE
	MAKE_NAME IS NOT NULL
GROUP BY
	MAKE_NAME
ORDER BY
	NUM_VEHICLES DESC;

--vehicle description
WITH
	FULL_DATA AS (
		SELECT
			*
		FROM
			STOLEN_VEHICLES AS S
			LEFT JOIN MAKE_DETAILS AS M ON S.MAKE_ID = M.MAKE_ID
			LEFT JOIN LOCATIONS AS L ON S.LOCATION_ID::INT = L.LOCATION_ID
	)
SELECT
	VEHICLE_DESC,
	COUNT(*) AS NUM_VEHICLES
FROM
	FULL_DATA
WHERE
	VEHICLE_DESC IS NOT NULL
GROUP BY
	VEHICLE_DESC
ORDER BY
	NUM_VEHICLES DESC;

--colour
SELECT
	F.COLOR AS COLOUR_TYPE,
	COUNT(*) AS NUM_VEHICLES
FROM
	(
		SELECT
			*
		FROM
			STOLEN_VEHICLES AS S
			LEFT JOIN MAKE_DETAILS AS M ON S.MAKE_ID = M.MAKE_ID
			LEFT JOIN LOCATIONS AS L ON S.LOCATION_ID::INT = L.LOCATION_ID
		WHERE
			S.COLOR IS NOT NULL
	) AS F
GROUP BY
	COLOUR_TYPE
ORDER BY
	NUM_VEHICLES DESC;

--region and population
WITH
	FULL_DATA AS (
		SELECT
			*
		FROM
			STOLEN_VEHICLES AS S
			LEFT JOIN MAKE_DETAILS AS M ON S.MAKE_ID = M.MAKE_ID
			LEFT JOIN LOCATIONS AS L ON S.LOCATION_ID::INT = L.LOCATION_ID
	)
SELECT
	REGION,
	COUNT(*) AS NUM_VEHICLES,
	POPULATION
FROM
	FULL_DATA
WHERE
	REGION IS NOT NULL
GROUP BY
	REGION,
	POPULATION
ORDER BY
	NUM_VEHICLES DESC;

--region and density
WITH
	FULL_DATA AS (
		SELECT
			*
		FROM
			STOLEN_VEHICLES AS S
			LEFT JOIN MAKE_DETAILS AS M ON S.MAKE_ID = M.MAKE_ID
			LEFT JOIN LOCATIONS AS L ON S.LOCATION_ID::INT = L.LOCATION_ID
	)
SELECT
	REGION,
	COUNT(*) AS NUM_VEHICLES,
	DENSITY
FROM
	FULL_DATA
WHERE
	REGION IS NOT NULL
GROUP BY
	REGION,
	DENSITY
ORDER BY
	NUM_VEHICLES DESC;

--a
SELECT
	*
FROM
	STOLEN_VEHICLES AS S
	LEFT JOIN MAKE_DETAILS AS M ON S.MAKE_ID = M.MAKE_ID
	LEFT JOIN LOCATIONS AS L ON S.LOCATION_ID::INT = L.LOCATION_ID
SELECT
	*
FROM
	MAKE_DETAILS;

SELECT
	*
FROM
	LOCATIONS;

SELECT
	*
FROM
	STOLEN_VEHICLES;

SELECT
	TO_CHAR(DATE_STOLEN, 'MONTH') AS YEAR
FROM
	STOLEN_VEHICLES



# Analyzing Students' Mental Health

Use your data manipulation skills to perform exploratory data analysis on a dataset around student mental health.

## Project Description

Studying abroad can be both exciting and difficult. But what might be contributing to this? One Japanese international university decided to find out!

Use your data manipulation skills to explore the data from a study on the mental health of international students, and find out which factors may have the greatest impact.


Does going to university in a different country affect your mental health? A Japanese international university surveyed its students in 2018 and published a study the following year that was approved by several ethical and regulatory boards.

The study found that international students have a higher risk of mental health difficulties than the general population, and that social connectedness (belonging to a social group) and acculturative stress (stress associated with joining a new culture) are predictive of depression.

Explore the students data using PostgreSQL to find out if you would come to a similar conclusion for international students and see if the length of stay is a contributing factor.

Here is a data description of the columns you may find helpful.