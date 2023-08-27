/* 

Data Cleaning FitBit user data tables

*/



-----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Clean Date and Time data

-- Check dailyActivity for any time values not equal to 00:00:00





SELECT 
	*
FROM 
	Bellabeat.dbo.dailyActivity
WHERE 
	CONVERT(time, ActivityDate) <> '00:00:00'  





-- Add cleaned date column 





ALTER TABLE
	dailyActivity
ADD 
	ActivityDateCleaned date;





-- Populate new date column with data





UPDATE 
	dailyActivity
SET 
	ActivityDateCleaned = CONVERT(date, ActivityDate)





-- Check dailyCalories for any time values not equal to 00:00:00





SELECT 
	*
FROM 
	Bellabeat.dbo.dailyCalories
WHERE 
	CONVERT(time, ActivityDay) <> '00:00:00' 
	




-- Add cleaned date column 





ALTER TABLE
	dailyCalories
ADD 
	ActivityDateCleaned date;





-- Populate new date column with data





UPDATE 
	dailyCalories
SET 
	ActivityDateCleaned = CONVERT(date, ActivityDay)





-- Check dailyIntensitites for any time values not equal to 00:00:00





SELECT 
	*
FROM 
	Bellabeat.dbo.dailyIntensities
WHERE 
	CONVERT(time, ActivityDay) <> '00:00:00' 





-- Add cleaned date column 





ALTER TABLE
	dailyIntensities
ADD 
	ActivityDateCleaned date;





-- Populate new date column with data





UPDATE 
	dailyIntensities
SET 
	ActivityDateCleaned = CONVERT(date, ActivityDay)
	




-- Check dailySteps for any time values not equal to 00:00:00





SELECT 
	*
FROM 
	Bellabeat.dbo.dailySteps
WHERE 
	CONVERT(time, ActivityDay) <> '00:00:00' 





-- Add cleaned date column 





ALTER TABLE
	dailySteps
ADD 
	ActivityDateCleaned date;





-- Populate new date column with data





UPDATE 
	dailySteps
SET 
	ActivityDateCleaned = CONVERT(date, ActivityDay)





-- Separate date and time into 2 separate columns, heartrateSeconds





ALTER TABLE
	heartrateSeconds
ADD 
	ActivityDateCleaned date;





ALTER TABLE
	heartrateSeconds
ADD 
	ActivityTimeCleaned time;





UPDATE 
	heartrateSeconds
SET 
	ActivityDateCleaned = CONVERT(date, Time)





UPDATE 
	heartrateSeconds
SET 
	ActivityTimeCleaned = CONVERT(time(0), Time)





-- Separate date and time into 2 separate columns, hourlyCalories

-- Add hour column to join on other tables 





ALTER TABLE
	hourlyCalories
ADD 
	ActivityDateCleaned date;





ALTER TABLE
	hourlyCalories
ADD 
	ActivityTimeCleaned time;





ALTER TABLE
	hourlyCalories
ADD
	ActivityHourCleaned int;





UPDATE 
	hourlyCalories
SET 
	ActivityHourCleaned = CONVERT(date, ActivityHour)





UPDATE 
	hourlyCalories
SET 
	ActivityTimeCleaned = CONVERT(time(0), ActivityHour)





UPDATE 
	hourlyCalories
SET 
	ActivityHourCleaned = DATEPART(hour, ActivityHour)





-- Separate date and time into 2 separate columns, hourlyIntensities

-- Add hour column to join on other tables 





ALTER TABLE
	hourlyIntensities
ADD 
	ActivityDateCleaned date;





ALTER TABLE
	hourlyIntensities
ADD 
	ActivityTimeCleaned time;





ALTER TABLE
	hourlyIntensities
ADD 
	ActivityHourCleaned int;





UPDATE 
	hourlyIntensities
SET 
	ActivityDateCleaned = CONVERT(date, ActivityHour)





UPDATE 
	hourlyIntensities
SET 
	ActivityTimeCleaned = CONVERT(time(0), ActivityHour)





UPDATE 
	hourlyIntensities
SET 
	ActivityHourCleaned = DATEPART(hour, ActivityHour)





-- Separate date and time into 2 separate columns, hourlySteps

-- Add hour column to join on other tables 





ALTER TABLE
	hourlySteps
ADD 
	ActivityDateCleaned date;





ALTER TABLE
	hourlySteps
ADD 
	ActivityTimeCleaned time;





ALTER TABLE
	hourlySteps
ADD 
	ActivityHourCleaned int;





UPDATE 
	hourlySteps
SET 
	ActivityDateCleaned = CONVERT(date, ActivityHour)





UPDATE 
	hourlySteps
SET 
	ActivityTimeCleaned = CONVERT(time(0), ActivityHour)
	




UPDATE 
	hourlySteps
SET 
	ActivityHourCleaned = DATEPART(hour, ActivityHour)





-- Separate date and time into 2 separate columns, minuteCaloriesNarrow

-- Add hour column to join on other tables 





ALTER TABLE
	minuteCaloriesNarrow
ADD 
	ActivityDateCleaned date;





ALTER TABLE
	minuteCaloriesNarrow
ADD 
	ActivityTimeCleaned time;





ALTER TABLE
	minuteCaloriesNarrow
ADD 
	ActivityHourCleaned int;





UPDATE 
	minuteCaloriesNarrow
SET 
	ActivityDateCleaned = CONVERT(date, ActivityMinute)





UPDATE 
	minuteCaloriesNarrow
SET 
	ActivityTimeCleaned = CONVERT(time(0), ActivityMinute)





UPDATE 
	minuteCaloriesNarrow
SET 
	ActivityHourCleaned = DATEPART(hour, ActivityMinute)





-- Separate date and time into 2 separate columns, minuteIntensitiesNarrow

-- Add hour column to join on other tables 





ALTER TABLE
	minuteIntensitiesNarrow
ADD 
	ActivityDateCleaned date;





ALTER TABLE
	minuteIntensitiesNarrow
ADD 
	ActivityTimeCleaned time;





ALTER TABLE
	minuteIntensitiesNarrow
ADD 
	ActivityHourCleaned int;





UPDATE 
	minuteIntensitiesNarrow
SET 
	ActivityDateCleaned = CONVERT(date, ActivityMinute)





UPDATE 
	minuteIntensitiesNarrow
SET 
	ActivityTimeCleaned = CONVERT(time(0), ActivityMinute)





UPDATE 
	minuteIntensitiesNarrow
SET 
	ActivityHourCleaned = DATEPART(hour, ActivityMinute)





-- Separate date and time into 2 separate columns, minuteMETsNarrow





ALTER TABLE
	minuteMETsNarrow
ADD 
	ActivityDateCleaned date;





ALTER TABLE
	minuteMETsNarrow
ADD 
	ActivityTimeCleaned time;





ALTER TABLE
	minuteMETsNarrow
ADD 
	ActivityHourCleaned int;





UPDATE 
	minuteMETsNarrow
SET 
	ActivityDateCleaned = CONVERT(date, ActivityMinute)





UPDATE 
	minuteMETsNarrow
SET 
	ActivityTimeCleaned = CONVERT(time(0), ActivityMinute)





UPDATE 
	minuteMETsNarrow
SET 
	ActivityHourCleaned = DATEPART(hour, ActivityMinute)





-- Separate date and time into 2 separate columns, minuteSleep

-- Add hour column to join on other tables 





ALTER TABLE
	minuteSleep
ADD 
	ActivityDateCleaned date;





ALTER TABLE
	minuteSleep
ADD 
	ActivityTimeCleaned time;





ALTER TABLE
	minuteSleep
ADD 
	ActivityHourCleaned int;





UPDATE 
	minuteSleep
SET 
	ActivityDateCleaned = CONVERT(date, date)





UPDATE 
	minuteSleep
SET 
	ActivityTimeCleaned = CONVERT(time(0), date)





UPDATE 
	minuteSleep
SET 
	ActivityHourCleaned = DATEPART(hour, date)





-- Separate date and time into 2 separate columns, minuteStepsNarrow

-- Add hour column to join on other tables 





ALTER TABLE
	minuteStepsNarrow
ADD 
	ActivityDateCleaned date;





ALTER TABLE
	minuteStepsNarrow
ADD 
	ActivityTimeCleaned time;





ALTER TABLE
	minuteStepsNarrow
ADD 
	ActivityHourCleaned int;





UPDATE 
	minuteStepsNarrow
SET 
	ActivityDateCleaned = CONVERT(date, ActivityMinute)





UPDATE 
	minuteStepsNarrow
SET 
	ActivityTimeCleaned = CONVERT(time(0), ActivityMinute)





UPDATE 
	minuteStepsNarrow
SET 
	ActivityHourCleaned = DATEPART(hour, ActivityMinute)





-- Check sleepDay for any time values not equal to 00:00:00





SELECT 
	*
FROM 
	Bellabeat.dbo.sleepDay
WHERE 
	CONVERT(time, SleepDay) <> '00:00:00' 





-- Add cleaned date column 





ALTER TABLE
	sleepDay
ADD 
	ActivityDateCleaned date;





-- Populate new date column with data





UPDATE 
	sleepDay
SET 
	ActivityDateCleaned = CONVERT(date, SleepDay)





-- Separate date and time into 2 separate columns, weightLogInfo





ALTER TABLE
	weightLogInfo
ADD 
	ActivityDateCleaned date;





ALTER TABLE
	weightLogInfo
ADD 
	ActivityTimeCleaned time;





UPDATE 
	weightLogInfo
SET 
	ActivityDateCleaned = CONVERT(date, Date)





UPDATE 
	weightLogInfo
SET 
	ActivityTimeCleaned = CONVERT(time(0), Date)





-----------------------------------------------------------------------------------------------------------------------------------------------------------------
 
--Changing data types of columns to appropiate data types across all tables





ALTER TABLE 
	heartrateSeconds
ALTER COLUMN 
	ActivityTimeCleaned time(0);





ALTER TABLE 
	heartrateSeconds
ALTER COLUMN 
	Value float;





ALTER TABLE 
	hourlyCalories
ALTER COLUMN 
	ActivityTimeCleaned time(0);





ALTER TABLE 
	hourlyIntensities
ALTER COLUMN 
	ActivityTimeCleaned time(0);





ALTER TABLE 
	hourlySteps
ALTER COLUMN 
	ActivityTimeCleaned time(0);





ALTER TABLE 
	minuteCaloriesNarrow
ALTER COLUMN 
	Calories float;





ALTER TABLE 
	minuteCaloriesNarrow
ALTER COLUMN 
	ActivityTimeCleaned time(0);





ALTER TABLE 
	minuteIntensitiesNarrow
ALTER COLUMN 
	 Id float;





ALTER TABLE 
	minuteIntensitiesNarrow
ALTER COLUMN 
	 Intensity float;





ALTER TABLE 
	minuteMETsNarrow
ALTER COLUMN 
	 Id float;





ALTER TABLE 
	minuteMETsNarrow
ALTER COLUMN 
	 METs float;





ALTER TABLE 
	minuteMETsNarrow
ALTER COLUMN 
	 ActivityTimeCleaned time(0);





ALTER TABLE 
	minuteSleep
ALTER COLUMN 
	 ActivityTimeCleaned time(0);





ALTER TABLE 
	minuteStepsNarrow
ALTER COLUMN 
	 Id float;





ALTER TABLE 
	minuteStepsNarrow
ALTER COLUMN 
	 Steps float;





ALTER TABLE 
	minuteStepsNarrow
ALTER COLUMN 
	 ActivityTimeCleaned time(0);





ALTER TABLE 
	weightLogInfo
ALTER COLUMN 
	 ActivityTimeCleaned time(0);





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Checking dailyActivity for duplicate values 





WITH duplicates AS 
	(
		SELECT 
			*,
			ROW_NUMBER() OVER (
						PARTITION BY Id,
							 ActivityDateCleaned,
							 TotalSteps,
							 TotalDistance
								ORDER BY
								Id
							) AS RowNum
		FROM 
			Bellabeat.dbo.dailyActivity
	)

SELECT
	* 
FROM 
	duplicates
WHERE 
	RowNum > 1





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Checking dailyCalories for duplicate values





WITH duplicates AS 
	(
		SELECT 
			*,
			ROW_NUMBER() OVER (
						PARTITION BY Id,
							 ActivityDateCleaned,
							 Calories
								ORDER BY
								Id
							) AS RowNum
		FROM 
			Bellabeat.dbo.dailyCalories
	)

SELECT
	* 
FROM 
	duplicates
WHERE 
	RowNum > 1





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Checking dailyIntensities for duplicate values





WITH duplicates AS 
	(
		SELECT 
			*,
			ROW_NUMBER() OVER (
						PARTITION BY Id,
							 ActivityDateCleaned,
							 SedentaryMinutes,
							 LightlyActiveMinutes,
							 FairlyActiveMinutes,
							 VeryActiveMinutes
								ORDER BY
								Id
							) AS RowNum
		FROM 
			Bellabeat.dbo.dailyIntensities
	)

SELECT
	* 
FROM 
	duplicates
WHERE 
	RowNum > 1





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Checking dailySteps for duplicate values





WITH duplicates AS 
	(
		SELECT 
			*,
			ROW_NUMBER() OVER (
						PARTITION BY Id,
							 ActivityDateCleaned,
							 StepTotal
								ORDER BY
								Id
							) AS RowNum
		FROM 
			Bellabeat.dbo.dailySteps
	)

SELECT
	* 
FROM 
	duplicates
WHERE 
	RowNum > 1





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Checking heartrateSeconds for duplicate values





WITH duplicates AS 
	(
		SELECT 
			*,
			ROW_NUMBER() OVER (
						PARTITION BY Id,
							 ActivityDateCleaned,
							 Value,
							 ActivityTimeCleaned
								ORDER BY
								Id
							) AS RowNum
		FROM 
			Bellabeat.dbo.heartrateSeconds
	)

SELECT
	* 
FROM 
	duplicates
WHERE 
	RowNum > 1





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Checking hourlyCalories for duplicate values





WITH duplicates AS 
	(
		SELECT 
			*,
			ROW_NUMBER() OVER (
						PARTITION BY Id,
							 ActivityDateCleaned,
							 Calories,
							 ActivityTimeCleaned
								ORDER BY
								Id
							) AS RowNum
		FROM 
			Bellabeat.dbo.hourlyCalories
	)

SELECT
	* 
FROM 
	duplicates
WHERE 
	RowNum > 1





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Checking hourlyIntensities for duplicate values





WITH duplicates AS 
	(
		SELECT 
			*,
			ROW_NUMBER() OVER (
						PARTITION BY Id,
							 ActivityDateCleaned,
							 TotalIntensity,
							 ActivityTimeCleaned
								ORDER BY
								Id
							) AS RowNum
		FROM 
			Bellabeat.dbo.hourlyIntensities
	)

SELECT
	* 
FROM 
	duplicates
WHERE 
	RowNum > 1





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Checking hourlySteps for duplicate values





WITH duplicates AS 
	(
		SELECT 
			*,
			ROW_NUMBER() OVER (
						PARTITION BY Id,
							 ActivityDateCleaned,
							 StepTotal,
							 ActivityTimeCleaned
								ORDER BY
								Id
							) AS RowNum
		FROM 
			Bellabeat.dbo.hourlySteps
	)

SELECT
	* 
FROM 
	duplicates
WHERE 
	RowNum > 1





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Checking minuteCaloriesNarrow for duplicate values





WITH duplicates AS 
	(
		SELECT 
			*,
			ROW_NUMBER() OVER (
						PARTITION BY Id,
							 ActivityDateCleaned,
							 Calories,
							 ActivityTimeCleaned
								ORDER BY
								Id
							) AS RowNum
		FROM 
			Bellabeat.dbo.minuteCaloriesNarrow
	)

SELECT
	* 
FROM 
	duplicates
WHERE 
	RowNum > 1





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Checking minuteIntensitesNarrow for duplicate values





WITH duplicates AS 
	(
		SELECT 
			*,
			ROW_NUMBER() OVER (
						PARTITION BY Id,
							 ActivityDateCleaned,
							 Intensity,
							 ActivityTimeCleaned
								ORDER BY
								Id
							) AS RowNum
		FROM 
			Bellabeat.dbo.minuteIntensitiesNarrow
	)

SELECT
	* 
FROM 
	duplicates
WHERE 
	RowNum > 1





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Checking minuteMETsNarrow for duplicate values





WITH duplicates AS 
	(
		SELECT 
			*,
			ROW_NUMBER() OVER (
						PARTITION BY Id,
							 ActivityDateCleaned,
							 METs,
							 ActivityTimeCleaned
								ORDER BY
								Id
							) AS RowNum
		FROM 
			Bellabeat.dbo.minuteMETsNarrow
	)

SELECT
	* 
FROM 
	duplicates
WHERE 
	RowNum > 1





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Checking minuteSleep for duplicate values

--543 duplicate records found, delete duplicates



WITH duplicates AS 
	(
		SELECT 
			*,
			ROW_NUMBER() OVER (
						PARTITION BY Id,
							 ActivityDateCleaned,
							 value,
							 logId,
							 ActivityTimeCleaned
								ORDER BY
								Id
							) AS RowNum
		FROM 
			Bellabeat.dbo.minuteSleep
	)

DELETE
	
FROM 
	duplicates
WHERE 
	RowNum > 1





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Checking minuteStepsNarrow for duplicate values





WITH duplicates AS 
	(
		SELECT 
			*,
			ROW_NUMBER() OVER (
						PARTITION BY Id,
							 ActivityDateCleaned,
							 Steps,
							 ActivityTimeCleaned
								ORDER BY
								Id
							) AS RowNum
		FROM 
			Bellabeat.dbo.minuteStepsNarrow
	)

SELECT
	* 
FROM 
	duplicates
WHERE 
	RowNum > 1





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Checking sleepDay for duplicate values

--3 duplicate records found, delete duplicates





WITH duplicates AS 
	(
		SELECT 
			*,
			ROW_NUMBER() OVER (
						PARTITION BY Id,
							 ActivityDateCleaned,
							 TotalSleepRecords,
							 TotalMinutesAsleep,
							 TotalTimeInBed
								ORDER BY
								Id
							) AS RowNum
		FROM 
			Bellabeat.dbo.sleepDay
	)

DELETE
FROM 
	duplicates
WHERE 
	RowNum > 1





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Checking weightLogInfo for duplicate values





WITH duplicates AS 
	(
		SELECT 
			*,
			ROW_NUMBER() OVER (
						PARTITION BY Id,
							 ActivityDateCleaned,
							 WeightKg,
							 WeightPounds,
							 BMI,
							 LogId,
							 ActivityTimeCleaned
								ORDER BY
								Id
							) AS RowNum
		FROM 
			Bellabeat.dbo.weightLogInfo
	)

SELECT
	* 
FROM 
	duplicates
WHERE 
	RowNum > 1





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--weightLogInfo is the only table with NULL values, in Fat column

SELECT 
	* 
FROM 
	Bellabeat.dbo.weightLogInfo
WHERE 
	Fat IS NULL





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--SELECT sleep sessions from minuteSleep and relevant data that are missing from sleepDay table

--date is defined by the day the sleep sessions starts





INSERT INTO Bellabeat.dbo.sleepDay (Id, TotalMinutesAsleep, TotalTimeInBed, ActivityDateCleaned)



SELECT 
	DISTINCT sleep.Id, 
	COUNT(CASE WHEN value = 1 THEN 1 ELSE NULL END) OVER (PARTITION BY sleep.Id, sub.logId) AS TotalMinutesAsleep,
	COUNT(CASE WHEN value = 1 THEN 1 ELSE NULL END) OVER (PARTITION BY sleep.Id, sleep.logId)
		+ COUNT(CASE WHEN value = 2 OR value = 3 THEN 1 ELSE NULL END) OVER (PARTITION BY sleep.Id, sleep.logId) AS TotalTimeInBed,
	MIN(sleep.ActivityDateCleaned) OVER (PARTITION BY sleep.Id, sleep.logId) AS ActivityDateCleaned
FROM 
	Bellabeat.dbo.minuteSleep sleep
JOIN
	(

	SELECT 
		 DISTINCT minu.Id AS Id,
		 minu.logId AS logId,
		 minu.ActivityDateCleaned,
		 sday.ActivityDateCleaned AS ActivityDateSleepDay
		 
	FROM 
		Bellabeat.dbo.minuteSleep minu
	LEFT JOIN 
		Bellabeat.dbo.sleepDay sday
	ON
		minu.ActivityDateCleaned = sday.ActivityDateCleaned
		AND minu.Id = sday.Id
	WHERE 
		sday.ActivityDateCleaned IS NULL 

	) sub
ON
	sleep.Id = sub.Id
	AND sleep.logId = sub.logId
	AND sleep.ActivityDateCleaned = sub.ActivityDateCleaned
ORDER BY
	sleep.Id





--Populate TotalSleepRecords column with previously missing records in sleepDay table





UPDATE sleepDay

SET TotalSleepRecords = sub2.TotalSleepRecords


FROM 
	Bellabeat.dbo.sleepDay sleep
JOIN

	(

		SELECT
			Id,
			ActivityDateCleaned,
			COUNT(DISTINCT sub.logId) AS TotalSleepRecords
		FROM 
			(

				SELECT 
						 DISTINCT minu.Id AS Id,
						 minu.logId AS logId,
						 minu.ActivityDateCleaned AS ActivityDateCleaned,
						 sday.ActivityDateCleaned AS ActivityDateSleepDay,
						 sday.TotalSleepRecords AS TotalSleepRecords
		 
					FROM 
						Bellabeat.dbo.minuteSleep minu
					LEFT JOIN 
						Bellabeat.dbo.sleepDay sday
					ON
						minu.ActivityDateCleaned = sday.ActivityDateCleaned
						AND minu.Id = sday.Id
					WHERE 
						sday.TotalSleepRecords IS NULL 

			) sub
		GROUP BY 
			sub.Id,
			sub.ActivityDateCleaned

	) sub2
ON 
	sleep.Id = sub2.Id 
	AND sleep.ActivityDateCleaned = sub2.ActivityDateCleaned
WHERE 
	sleep.TotalSleepRecords IS NULL 










