-- Switch to the 'WeatherData' database
USE WeatherData;

-- Drop the temporary table if it already exists
IF OBJECT_ID('tempdb..#MonthlyData', 'U') IS NOT NULL
    DROP TABLE #MonthlyData;

-- Create a temporary table to hold the monthly data
CREATE TABLE #MonthlyData (
    unique_location_key VARCHAR(50),
    PULocationID INT,
    DOLocationID INT,
    trip_count INT,
    total_distance FLOAT,
    total_fare FLOAT,
    avg_trip_time FLOAT,
    probability_trip FLOAT,
    HourlyDryBulbTemperature FLOAT,
    HourlyPrecipitation FLOAT,
    HourlyRelativeHumidity FLOAT,
    HourlyWindSpeed FLOAT
);

-- Common Table Expression (CTE) for all months data
WITH AllMonthsData AS (
    SELECT 
        CONCAT(a.date, ' ', RIGHT('00' + CAST(a.hour AS VARCHAR(2)), 2)) AS unique_location_key,
        a.PULocationID,
        a.DOLocationID,
        a.trip_count,
        a.total_distance,
        a.total_fare,
        a.avg_trip_time,
        a.probability_trip,
        w.HourlyDryBulbTemperature,
        w.HourlyPrecipitation,
        w.HourlyRelativeHumidity,
        w.HourlyWindSpeed
    FROM AggregatedHourlyData.dbo.aggregated_hourly_data AS a
    LEFT JOIN WeatherData.dbo.WeatherData AS w
        ON CAST(a.date AS DATE) = CAST(w.date AS DATE) AND a.hour = w.hour
)

-- Insert the combined data into the temporary table
INSERT INTO #MonthlyData
SELECT * FROM AllMonthsData;

-- Fetch the final result for all trips in May 2016
SELECT *
FROM #MonthlyData
WHERE unique_location_key LIKE '2016%'
ORDER BY unique_location_key;

-- Fetch the final result for all trips in March 2016
SELECT *
FROM #MonthlyData
WHERE unique_location_key LIKE '2016-03%'
ORDER BY unique_location_key;

-- Fetch the final result for all trips on May 30, 2016
SELECT *
FROM #MonthlyData
WHERE unique_location_key LIKE '2016-10-10%'
ORDER BY unique_location_key;

-- Fetch the final result for all trips on August 4, 2016, at 11:00 AM (hour = 11)
SELECT *
FROM #MonthlyData
WHERE unique_location_key = '2016-08-04 11'
ORDER BY unique_location_key;

