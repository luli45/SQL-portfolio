# Change Date Column data type
SELECT str_to_date(Date, '%m/%d/%Y')
FROM lb5.daily_activity;

UPDATE lb5.daily_activity
SET Date = str_to_date(Date,'%m/%d/%Y');

# Check Data
SELECT *
FROM lb5.daily_activity;

# Add DayofWeek column
SELECT
  DATE_FORMAT(Date, '%W') AS DayofWeek
FROM lb5.daily_activity;

ALTER TABLE lb5.daily_activity
ADD DayofWeek Nvarchar(255);

UPDATE lb5.daily_activity
SET DayofWeek = DATE_FORMAT(Date, '%W');

# Add Minutes columns 
ALTER TABLE lb5.daily_activity
ADD TotalActiveMinutes integer;

UPDATE lb5.daily_activity
SET TotalActiveMinutes = (VeryActiveMinutes + LightlyActiveMinutes + FairlyActiveMinutes);

# daily_calories Clean-up
SELECT *
FROM lb5.daily_calories;

# Change Date Column data type
SELECT str_to_date(Date, '%m/%d/%Y')
FROM lb5.daily_calories;

UPDATE lb5.daily_calories
SET Date = str_to_date(Date,'%m/%d/%Y');

# Add DayofWeek column
SELECT
  DATE_FORMAT(Date, '%W') AS DayofWeek
FROM lb5.daily_calories;

ALTER TABLE lb5.daily_calories
ADD DayofWeek Nvarchar(255) AFTER Date;

UPDATE lb5.daily_calories
SET DayofWeek = DATE_FORMAT(Date, '%W');

# daily_steps Clean-up
SELECT *
FROM lb5.daily_steps;

# Change Date Column data type
SELECT str_to_date(Date, '%m/%d/%Y')
FROM lb5.daily_steps;

UPDATE lb5.daily_steps
SET Date = str_to_date(Date,'%m/%d/%Y');

# Add DayofWeek Column
SELECT
  DATE_FORMAT(Date, '%W') AS DayofWeek
FROM lb5.daily_steps;

ALTER TABLE lb5.daily_steps
ADD DayofWeek Nvarchar(255) AFTER Date;

UPDATE lb5.daily_steps
SET DayofWeek = DATE_FORMAT(Date, '%W');












