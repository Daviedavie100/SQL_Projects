SELECT name
FROM sqlite_schema
WHERE type ='table'


SELECT *
        FROM aircrafts_data 
        LIMIT 10


SELECT aircraft_code, json_extract(model, '$.en') AS aircraft_model, range
    FROM aircrafts_data
    LIMIT 10

