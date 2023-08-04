# Append Taxi and Weather Data Filter using SQL

In this SQL script, we combine and filter taxi trip data along with weather data using a Common Table Expression (CTE) and a temporary table. The script is designed to work with the 'WeatherData' database.

## Step 1: Switch to the 'WeatherData' Database

We start by using the `USE` statement to switch to the 'WeatherData' database.

## Step 2: Create a Temporary Table

We create a temporary table named '#MonthlyData' to hold the combined and filtered data. This table will have columns such as 'unique_location_key', 'PULocationID', 'DOLocationID', 'trip_count', 'total_distance', 'total_fare', 'avg_trip_time', 'probability_trip', 'HourlyDryBulbTemperature', 'HourlyPrecipitation', 'HourlyRelativeHumidity', and 'HourlyWindSpeed'.

## Step 3: Combine Data Using Common Table Expression (CTE)

We use a Common Table Expression (CTE) named 'AllMonthsData' to combine data from the 'AggregatedHourlyData.dbo.aggregated_hourly_data' table (containing taxi trip data) and the 'WeatherData.dbo.WeatherData' table (containing weather data). The 'unique_location_key' is created by concatenating the date and hour of each record.

## Step 4: Insert Data into the Temporary Table

We insert the data from the 'AllMonthsData' CTE into the '#MonthlyData' temporary table.

## Step 5: Filter and Fetch Data

We provide several examples of filtering and fetching data from the '#MonthlyData' table:

1. Fetch all trips in May 2016.
2. Fetch all trips in March 2016.
3. Fetch all trips on May 30, 2016.
4. Fetch all trips on August 4, 2016, at 11:00 AM (hour = 11).

By running this SQL script, you can combine and filter taxi trip data along with weather data to perform various analyses and gain insights.

Note: Make sure to adjust the database and table names as per your specific data setup.
