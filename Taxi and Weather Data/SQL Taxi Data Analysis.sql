-- Most Common Pickup and Drop-off Locations with Hourly Breakdown
WITH RankedTrips AS (
    SELECT 
        hour,
        PULocationID,
        DOLocationID,
        COUNT(*) AS trip_count,
        ROW_NUMBER() OVER (PARTITION BY hour ORDER BY COUNT(*) DESC) AS rn,
        SUM(COUNT(*)) OVER (PARTITION BY hour) AS total_trip_count_per_hour
    FROM TaxiData.dbo.merged_data
    GROUP BY hour, PULocationID, DOLocationID
)
SELECT TOP 1 WITH TIES 
    hour,
    PULocationID,
    DOLocationID,
    trip_count,
    100.0 * trip_count / total_trip_count_per_hour AS trip_percentage
FROM RankedTrips
ORDER BY rn;


-- Average fare amount weekdays and weekends 
SELECT 
    CASE WHEN DATEPART(dw, date) IN (1, 7) THEN 'Weekend' ELSE 'Weekday' END AS day_category,
    hour,
    AVG(total_fare) AS average_fare_per_hour
FROM TaxiData.dbo.merged_data
GROUP BY CASE WHEN DATEPART(dw, date) IN (1, 7) THEN 'Weekend' ELSE 'Weekday' END, hour
ORDER BY day_category, hour;


-- Busiest pickup locations and their average activity during different hours of the day
SELECT 
    hour,
    PULocationID,
    AVG(trip_count) AS average_trip_count,
    AVG(total_fare) AS average_total_fare
FROM TaxiData.dbo.merged_data
GROUP BY hour, PULocationID
ORDER BY hour, average_trip_count DESC;


-- Calculate the average trip count and average total fare per hour for different 
-- humidity ranges (Low, Moderate, and High) based on the HourlyRelativeHumidity

SELECT 
    hour,
    CASE 
        WHEN HourlyRelativeHumidity <= 50 THEN 'Low Humidity'
        WHEN HourlyRelativeHumidity > 50 AND HourlyRelativeHumidity <= 70 THEN 'Moderate Humidity'
        WHEN HourlyRelativeHumidity > 70 THEN 'High Humidity'
    END AS humidity_range,
    SUM(trip_count) AS total_trip_count,
    AVG(trip_count * 1.0) AS average_trip_count,
    AVG(total_fare) AS average_total_fare
FROM TaxiData.dbo.merged_data
GROUP BY hour, 
    CASE 
        WHEN HourlyRelativeHumidity <= 50 THEN 'Low Humidity'
        WHEN HourlyRelativeHumidity > 50 AND HourlyRelativeHumidity <= 70 THEN 'Moderate Humidity'
        WHEN HourlyRelativeHumidity > 70 THEN 'High Humidity'
    END
ORDER BY hour;


-- Calculate the average trip count and average total fare per hour for different 
-- temperature ranges (Low, Moderate, and High) based on the HourlyDryBulbTemperature
SELECT 
    hour,
    CASE 
        WHEN HourlyDryBulbTemperature <= 20 THEN 'Low Temperature'
        WHEN HourlyDryBulbTemperature > 20 AND HourlyDryBulbTemperature <= 25 THEN 'Moderate Temperature'
        WHEN HourlyDryBulbTemperature > 25 THEN 'High Temperature'
    END AS temperature_range,
    SUM(trip_count) AS total_trip_count,
    AVG(trip_count * 1.0) AS average_trip_count,
    AVG(total_fare) AS average_total_fare
FROM TaxiData.dbo.merged_data
GROUP BY hour, 
    CASE 
        WHEN HourlyDryBulbTemperature <= 20 THEN 'Low Temperature'
        WHEN HourlyDryBulbTemperature > 20 AND HourlyDryBulbTemperature <= 25 THEN 'Moderate Temperature'
        WHEN HourlyDryBulbTemperature > 25 THEN 'High Temperature'
    END
ORDER BY hour;
