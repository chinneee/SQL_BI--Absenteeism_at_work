USE Absenteeism_at_work
GO

--create a join table
SELECT * FROM Absenteeism_at_work a
LEFT JOIN compensation c
ON a.ID = c.ID
LEFT JOIN Reasons r
ON a.Reason_for_absence = r.Number;

--find the healthiest
SELECT * FROM Absenteeism_at_work
WHERE Social_drinker = 0
AND Social_smoker =0
AND Body_mass_index <25 
AND Absenteeism_time_in_hours < (SELECT AVG(Absenteeism_time_in_hours) from Absenteeism_at_work)

--compensation rate increase for non-smokers/ budget $983,221 so 0.69 increase per hour / $1,414.4 per year
SELECT COUNT(*) as nonsmokers FROM Absenteeism_at_work
WHERE Social_smoker = 0

--optimize this query
SELECT a.ID, r.Reason, a.Month_of_absence, a.Body_mass_index,
CASE 
	WHEN Body_mass_index < 18.5 Then 'Underweight'
	WHEN Body_mass_index between 18.5 and 24.9 Then 'Healthy'
	WHEN Body_mass_index between 25 and 30 Then 'Overweight'
	WHEN Body_mass_index >30 Then 'Obse'
	ELSE 'Unknown' END as BMI_category,
CASE 
	WHEN Month_of_absence IN (12,1,2) THEN 'Winter'
	WHEN Month_of_absence IN (3,4,5) THEN 'Spring'
	WHEN Month_of_absence IN (6,7,8) THEN 'Summer'
	WHEN Month_of_absence IN (9,10,11) THEN 'Fall'
	ELSE 'Unknown' END as Season_name,
Month_of_absence, Day_of_the_week, Transportation_expense, Education, Son,Social_drinker, 
Social_smoker, Pet, Disciplinary_failure, Age, Work_load_Average_day, Absenteeism_time_in_hours 
FROM Absenteeism_at_work a
LEFT JOIN compensation c
ON a.ID = c.ID
LEFT JOIN Reasons r
ON a.Reason_for_absence = r.Number;