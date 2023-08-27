/* 

FitBit Data Analysis

*/




-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--SELECT average percent of time spent very active, fairly active, lightly active and sedentary accross all users and days

--Users tend to spend more time in less active activies with the exception of Very Active

--states of activity, in which users are "very active" more than "fairly active"


SELECT 
	ROUND(AVG(VeryActiveMinutes)/1440 * 100, 3) AS VeryActiveMinutesPercent,
	ROUND(AVG(FairlyActiveMinutes)/1440 * 100, 3) AS FairlyActiveMinutesPercent,
	ROUND(AVG(LightlyActiveMinutes)/1440 * 100, 3) AS LightlyActiveMinutesPercent,
	ROUND(AVG(SedentaryMinutes)/1440 * 100, 3) AS SedentaryMinutesPercent
FROM 
	Bellabeat.dbo.dailyActivity





--Average time spent in different activity intensities in minutes


SELECT 
	ROUND(AVG(VeryActiveMinutes), 3) AS AvgVeryActiveMin,
	ROUND(AVG(FairlyActiveMinutes), 3) AS AvgFairlyActiveMin,
	ROUND(AVG(LightlyActiveMinutes), 3) AS AvgLightlyActiveMin,
	ROUND(AVG(SedentaryMinutes), 3) AS AvgSedentaryMin
FROM 
	Bellabeat.dbo.dailyActivity





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--SELECT number of records per fitbit user 

--not all users have the same number of records


SELECT 
	Id,
	COUNT(*) AS NumOfRecords
FROM 
	Bellabeat.dbo.dailyActivity
GROUP BY 
	Id
ORDER BY 
	Id





--SELECT all records for user 4057192912

--only 4 days of data for this user


SELECT 
	* 
FROM 
	Bellabeat.dbo.dailyActivity
WHERE 
	Id = 4057192912





--SELECT total number of minutes recorded for each user

--some users' data does not account for every minute in a day


SELECT
	Id,
	ActivityDateCleaned,
	VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes + SedentaryMinutes AS TotalMinutes
FROM
	Bellabeat.dbo.dailyActivity
WHERE
	VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes + SedentaryMinutes <> 1440
GROUP BY 
	Id,
	ActivityDateCleaned,
	VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes + SedentaryMinutes





--Compare the number of unique users and records per user for minuteCaloriesNarrow and minuteIntensitiesNarrow tables

--minuteCaloriesNarrow and minuteIntensitiesNarrow tables share the same number of unique users

--There are 33 unique users despite the dataset being described as having studied the data of only 30 users


SELECT 
	COUNT(DISTINCT Id) AS NumOfUsers
FROM 
	Bellabeat.dbo.minuteCaloriesNarrow





SELECT 
	COUNT(DISTINCT Id) AS NumOfUsers
FROM 
	Bellabeat.dbo.minuteIntensitiesNarrow





--SELECT number of records per unique user for minuteCaloriesNarrow table


SELECT 
	Id,
	COUNT(*) AS NumOfRecordsCalories
FROM 
	Bellabeat.dbo.minuteCaloriesNarrow
GROUP BY 
	Id
ORDER BY 
	Id





--SELECT number of records per unique user for minuteIntensitiesNarrow table


SELECT 
	Id,
	COUNT(*) AS NumOfRecordsIntensities
FROM 
	Bellabeat.dbo.minuteIntensitiesNarrow
GROUP BY 
	Id
ORDER BY 
	Id





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--On days where users' data does not account for the full 1440 minutes in a day, the dataset assumes the missing time is sedentary activity 


SELECT
	Id,
	ActivityDateCleaned,
	COUNT(CASE WHEN Intensity = 0 THEN 1 ELSE NULL END) AS SedentaryMinutes,
	COUNT(CASE WHEN Intensity = 1 THEN 1 ELSE NULL END) AS LightlyActiveMinutes,
	COUNT(CASE WHEN Intensity = 2 THEN 1 ELSE NULL END) AS FairlyActiveMinutes,
	COUNT(CASE WHEN Intensity = 3 THEN 1 ELSE NULL END) AS VeryActiveMinutes	  
FROM 
	Bellabeat.dbo.minuteIntensitiesNarrow
WHERE 
	Id = 1503960366
	AND ActivityDateCleaned = '2016-04-12'
	OR Id = 2026352035
	AND ActivityDateCleaned = '2016-04-29'
GROUP BY 
	Id,
	ActivityDateCleaned	





SELECT 
	*
FROM 
	Bellabeat.dbo.dailyActivity
WHERE 
	Id = 1503960366 
	AND ActivityDateCleaned = '2016-04-12'
	OR Id = 2026352035
	AND ActivityDateCleaned = '2016-04-29'






-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Are missing days substitued with data in hourly data tables?

--Missing days in hourly data tables match missing days from daily tables


SELECT 
	cal.Id,
	COUNT(DISTINCT cal.ActivityDateCleaned) AS NumOfRecordsCalories,
	COUNT(DISTINCT daily.ActivityDateCleaned) AS NumOfRecordsDaily
FROM 
	Bellabeat.dbo.hourlyCalories cal
JOIN 
	Bellabeat.dbo.dailyActivity daily
ON
	cal.Id = daily.Id
	AND cal.ActivityDateCleaned = daily.ActivityDateCleaned		
GROUP BY 
	cal.Id





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--In which levels of activity intensity do people burn more calories 

--Calories burned has a positive relationship with the amount of time spent in level of activity intensity


SELECT 
	CASE
		WHEN 
			Inte.Intensity = 0 THEN 'SedentaryActivity'
		WHEN 
			Inte.Intensity = 1 THEN 'LightlyActive'
		WHEN 
			Inte.Intensity = 2 THEN 'FairlyActive'
		WHEN 
			Inte.Intensity = 3 THEN 'VeryActive'
		END as Intensity,

	ROUND(SUM(Cal.Calories), 3) AS CaloriesBurned,
	COUNT(Inte.ActivityTimeCleaned) AS MinutesPerIntensity,
	ROUND(SUM(Cal.Calories) / COUNT(Inte.ActivityTimeCleaned), 3) AS CaloriesBurnedPerMinute
FROM 
	Bellabeat.dbo.minuteCaloriesNarrow Cal
JOIN 
	Bellabeat.dbo.minuteIntensitiesNarrow Inte
ON 
	Cal.Id = Inte.Id
	AND Cal.ActivityDateCleaned = Inte.ActivityDateCleaned
	AND Cal.ActivityTimeCleaned = Inte.ActivityTimeCleaned
GROUP BY 
	Inte.Intensity
ORDER BY 
	CaloriesBurned DESC





--SELECT the number of minutes of each level of activity intensity per hour across all fitbit users


SELECT 
	DATEPART(hour, ActivityTimeCleaned) AS ActivityHour,
	COUNT(CASE WHEN Intensity = 0 THEN 1 ELSE NULL END) AS SedentaryMinutesPerHour,
	COUNT(CASE WHEN Intensity = 1 THEN 1 ELSE NULL END) AS LightlyActiveMinutesPerHour,
	COUNT(CASE WHEN Intensity = 2 THEN 1 ELSE NULL END) AS FairlyActiveMinutesPerHour,
	COUNT(CASE WHEN Intensity = 3 THEN 1 ELSE NULL END) AS VeryActiveMinutesPerHour
FROM 
	Bellabeat.dbo.minuteIntensitiesNarrow
GROUP BY 
	DATEPART(hour, ActivityTimeCleaned)
ORDER BY 
	ActivityHour
	




--What time of day are people the most active?

--People tend to be most active between 5 - 7pm 


WITH timeOfDay
	AS 
		(
			SELECT 
				DATEPART(hour, ActivityTimeCleaned) AS ActivityHour,
				COUNT(CASE WHEN Intensity = 0 THEN 1 ELSE NULL END) AS SedentaryMinutesPerHour,
				COUNT(CASE WHEN Intensity = 1 THEN 1 ELSE NULL END) AS LightlyActiveMinutesPerHour,
				COUNT(CASE WHEN Intensity = 2 THEN 1 ELSE NULL END) AS FairlyActiveMinutesPerHour,
				COUNT(CASE WHEN Intensity = 3 THEN 1 ELSE NULL END) AS VeryActiveMinutesPerHour
			FROM 
				Bellabeat.dbo.minuteIntensitiesNarrow
			GROUP BY 
				DATEPART(hour, ActivityTimeCleaned)
		)

SELECT TOP 5
	ActivityHour,
	VeryActiveMinutesPerHour
FROM 
	timeOfDay
ORDER BY 
	VeryActiveMinutesPerHour DESC





--What times of day do people burn the most Calories?

--People burn the most Calories between 5 - 7 pm, with the most Calories burned after 6 pm


SELECT 
	DATEPART(hour, ActivityTimeCleaned) AS ActivityHour,
	ROUND(SUM(Calories), 3) AS CaloriesBurned
FROM 
	Bellabeat.dbo.minuteCaloriesNarrow
GROUP BY 
	DATEPART(hour, ActivityTimeCleaned)
ORDER BY 
	CaloriesBurned DESC





-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Only 24 unique users in sleep tables, it is assumed the missing users have FitBit devices

--that support Sleep Stages instead of the Classic sleep algorithm 


SELECT 
	COUNT(DISTINCT Id)
FROM 
	Bellabeat.dbo.sleepDay


SELECT 
	COUNT(DISTINCT Id)
FROM 
	Bellabeat.dbo.minuteSleep




--SELECT id, logid, date, time the user started sleeping, time the user stopped sleeping, and hours of sleep 

--for each fitbit user


SELECT
	Id,
	logId,
	ActivityDateCleaned,
	MIN(ActivityTimeCleaned) AS SleepStart,
	MAX(ActivityTimecleaned)AS SleepEnd,
	DATEDIFF(HOUR, MIN(ActivityTimeCleaned), MAX(ActivityTimecleaned)) AS HoursOfSleep
FROM 
	Bellabeat.dbo.minuteSleep 
GROUP BY 
	Id,
	logId,
	ActivityDateCleaned
ORDER BY 
	Id,
	ActivityDateCleaned





--What is the average amount of time people sleep in a night?


SELECT 
	DISTINCT sub.Id,
	sub.AvgHoursOfSleep,
	ROUND((AVG(sleep.TotalMinutesAsleep) OVER ())/60 , 3) AS TotalAvgHoursOfSleep
FROM
	Bellabeat.dbo.sleepDay sleep
JOIN
	(
		SELECT
			Id,
			ROUND(AVG(TotalMinutesAsleep/60), 3) AS AvgHoursOfSleep
		FROM 
			Bellabeat.dbo.sleepDay
		GROUP BY
			Id
			
	) AS sub

ON	
	sleep.Id = sub.Id
ORDER BY 
	sub.AvgHoursOfSleep DESC
	
	



-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Did users with a low average hours of sleep submit fewer records of their sleep?


SELECT
	Id,
	ROUND(AVG(TotalMinutesAsleep/60), 3) AS AvgHoursOfSleep,
	COUNT(DISTINCT ActivityDateCleaned) AS NumOfDaysRecorded
FROM 
	Bellabeat.dbo.sleepDay
GROUP BY
	Id
ORDER BY 
	ROUND(AVG(TotalMinutesAsleep/60), 3) DESC





--Time spent in bed vs time spent asleep


WITH sleepPercent
AS
(
SELECT 
	Id,
	ActivityDateCleaned,
	TotalMinutesAsleep,
	TotalTimeInBed,
	ROUND((TotalMinutesAsleep/TotalTimeInBed) * 100, 3) AS PercentTimeAsleep
FROM 
	Bellabeat.dbo.sleepDay
GROUP BY 
	Id,
	TotalMinutesAsleep,
	ActivityDateCleaned,
	TotalTimeInBed
)


SELECT 
	sleepPercent.*,
	ROUND((SUM(PercentTimeAsleep) OVER (PARTITION BY ActivityDateCleaned)) /
		(COUNT(PercentTimeAsleep) OVER (PARTITION BY ActivityDateCleaned)), 3) AS DayAvgPercentTimeAsleep,
	ROUND((SUM(PercentTimeAsleep) OVER ()) /
		(COUNT(PercentTimeAsleep) OVER ()), 3) AS TotalAvgPercentTimeAsleep
FROM 
	sleepPercent





--How restful is each users's sleep each night?

--Minutes Awake includes time spent awake and still in bed

--date is defined as the day the sleep sessions starts


SELECT 
	sub.*,
	ROUND(CAST(sub.MinutesRestful AS float) / CAST(sub.TotalMinutesInBed AS float) * 100, 3) AS PercentSleepRestful
FROM
(
	SELECT 
		DISTINCT Id, 
		MIN(ActivityDateCleaned) OVER (PARTITION BY Id, logId) AS ActivityDateCleaned,
		logId,
		COUNT(CASE WHEN value = 1 THEN 1 ELSE NULL END) OVER (PARTITION BY Id, logId) AS MinutesRestful,
		COUNT(CASE WHEN value = 2 THEN 1 ELSE NULL END) OVER (PARTITION BY Id, logId) AS MinutesRestless,
		COUNT(CASE WHEN value = 3 THEN 1 ELSE NULL END) OVER (PARTITION BY Id, logId) AS MinutesAwake,
		COUNT(CASE WHEN value = 1 THEN 1 ELSE NULL END) OVER (PARTITION BY Id, logId)
			+ COUNT(CASE WHEN value = 2 OR value = 3 THEN 1 ELSE NULL END) OVER (PARTITION BY Id, logId) AS TotalMinutesInBed
	FROM 
		Bellabeat.dbo.minuteSleep
) AS sub
ORDER BY 
	sub.Id,
	sub.ActivityDateCleaned





--How restful is each user's sleep on average?

--Minutes Awake is defined as time spent awake and in bed

--date is defined as the day the sleep sessions starts


SELECT 
	sub.Id,
	AVG(sub.MinutesRestful) AS AvgMinutesRestful,
	AVG(sub.MinutesRestless) AS AvgMinutesRestless,
	AVG(sub.MinutesAwake) AS AvgMinutesAwake,
	AVG(sub.TotalMinutesInBed) AS AvgTotalMinutesInBed,
	ROUND(CAST(AVG(sub.MinutesRestful) AS float) / CAST(AVG(sub.TotalMinutesInBed) AS float) * 100, 3) AS AvgPercentTimeRestful
FROM
(
	SELECT 
		DISTINCT Id, 
		MIN(ActivityDateCleaned) OVER (PARTITION BY Id, logId) AS ActivityDateCleaned,
		logId,
		COUNT(CASE WHEN value = 1 THEN 1 ELSE NULL END) OVER (PARTITION BY Id, logId) AS MinutesRestful,
		COUNT(CASE WHEN value = 2 THEN 1 ELSE NULL END) OVER (PARTITION BY Id, logId) AS MinutesRestless,
		COUNT(CASE WHEN value = 3 THEN 1 ELSE NULL END) OVER (PARTITION BY Id, logId) AS MinutesAwake,
		COUNT(CASE WHEN value = 1 THEN 1 ELSE NULL END) OVER (PARTITION BY Id, logId)
			+ COUNT(CASE WHEN value = 2 OR value = 3 THEN 1 ELSE NULL END) OVER (PARTITION BY Id, logId) AS TotalMinutesInBed
	FROM 
		Bellabeat.dbo.minuteSleep
) AS sub
GROUP BY 
	Id 
ORDER BY 
	sub.Id





--Steps taken and Calories burned by day of week and time of day (hour)

--Most steps taken around 5-7pm on Mond and Wed, with steps taken peaking around 12pm for Tues, Thurs and Sat


SELECT 
	DATENAME(WEEKDAY, steps.ActivityDateCleaned) AS DayOfWeek,
	DATEPART(WEEKDAY, steps.ActivityDateCleaned) AS DayOfWeekNum,
	steps.ActivityTimeCleaned,
	SUM(steps.StepTotal) AS TotalStepsPerHour,
	SUM(cal.Calories) AS TotalCaloriesPerHour
FROM 
	Bellabeat.dbo.hourlySteps steps
JOIN
	Bellabeat.dbo.hourlyCalories cal
ON
	steps.Id = cal.Id
	AND steps.ActivityDateCleaned = cal.ActivityDateCleaned
	AND steps.ActivityTimeCleaned = cal.ActivityTimeCleaned
GROUP BY
	DATENAME(WEEKDAY, steps.ActivityDateCleaned),
	DATEPART(WEEKDAY, steps.ActivityDateCleaned),
	steps.ActivityTimeCleaned
ORDER BY 
	DayOfWeekNum,
	TotalStepsPerHour DESC
	




--Steps taken and Calories burned by time of day (hour)

--Most steps taken around 5-7pm with 12pm also having a little more steps taken than 5pm


SELECT 
	steps.ActivityTimeCleaned,
	SUM(steps.StepTotal) AS TotalStepsPerHour,
	SUM(cal.Calories) AS TotalCaloriesPerHour
FROM 
	Bellabeat.dbo.hourlySteps steps
JOIN
	Bellabeat.dbo.hourlyCalories cal
ON
	steps.Id = cal.Id
	AND steps.ActivityDateCleaned = cal.ActivityDateCleaned
	AND steps.ActivityTimeCleaned = cal.ActivityTimeCleaned
GROUP BY
	steps.ActivityTimeCleaned
ORDER BY 

	TotalStepsPerHour DESC




