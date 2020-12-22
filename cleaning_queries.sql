INSERT INTO mydb.person(age_at_exam)
     SELECT age_months_at_exam / 12 AS age_at_exam
     FROM mydb.person;
     
 
ALTER TABLE mydb.person
  ADD age_months_at_exam INT(11) DEFAULT NULL
  AFTER id;    

ALTER TABLE mydb.person
  DROP COLUMN age_years_at_exam;

#ALTER TABLE blood_pressure RENAME COLUMN diastollic_blood_pressure TO diastolic_blood_pressure;
SELECT * FROM mydb.person;

ALTER TABLE mydb.person
  DROP COLUMN age_years_at_exam;
  


  
UPDATE person SET age_years_at_exam = FLOOR(age_months_at_exam / 12);
UPDATE person SET gender = (CASE WHEN gender = '1' THEN 'Male' ELSE 'Female' END);


#DELETE FROM person;

#ALTER TABLE person
#DROP COLUMN citizenship_id;

#ALTER TABLE person DROP FOREIGN KEY fk_person_citizenship1;


ALTER TABLE mydb.person
  DROP COLUMN age_years_at_exam;


SELECT *
FROM person;

ALTER TABLE mydb.person
  ADD age_month_at_exam INT(11) DEFAULT NULL
  AFTER id;

ALTER TABLE mydb.person
  DROP COLUMN age_months_at_exam;
  
  
UPDATE person SET age_years_at_exam = (SELECT age_months_at_exam / 12 FROM age);

UPDATE person
INNER JOIN age ON person.id = age.person_id
SET person.age_month_at_exam  = age.age_months_at_exam;

ALTER TABLE mydb.person
  ADD age_years_at_exam INT(11) DEFAULT NULL
  AFTER age_month_at_exam;
UPDATE person SET age_years_at_exam = FLOOR(age_month_at_exam / 12);

ALTER TABLE mydb.person
  DROP COLUMN age_month_at_exam;

SELECT *
FROM medical_conditions;

###### Medical Conditions Analysis
# Asthma diagnosis and type based on race
SELECT mc.asthma, r.race, COUNT(p.id) AS number_of_asthma, COUNT(p.id)/new.num_race AS asthma_rate_per_race
FROM medical_conditions mc
	INNER JOIN
		person p ON mc.person_id = p.id
	INNER JOIN 
		cancer c ON c.cancer_id = mc.cancer_id
	INNER JOIN 
        race r ON r.race_id = p.race_id
	INNER JOIN
		(SELECT r.race, COUNT(p.id) AS num_race
		 FROM person p
			INNER JOIN
				race r ON p.race_id = r.race_id
		 GROUP BY r.race) new ON new.race = r.race 
GROUP BY mc.asthma, r.race
ORDER BY mc.asthma DESC, number_of_asthma DESC;

# Asthma diagnosis and type based on age
SELECT sorted.age_range, sorted.number_of_asthma AS num_asthma, new.total AS total_people, sorted.number_of_asthma/new.total AS asthma_rate
FROM
		(SELECT mc.asthma, 
			   CONCAT(10*floor(p.age_years_at_exam/10), '-', 10*floor(p.age_years_at_exam/10) + 10) AS age_range, 
			   COUNT(p.id) AS number_of_asthma
		FROM medical_conditions mc
			INNER JOIN
				person p ON mc.person_id = p.id
		WHERE mc.asthma = 'Yes'
		GROUP BY age_range
		ORDER BY age_range) AS sorted INNER JOIN
		(SELECT 
			   CONCAT(10*floor(p.age_years_at_exam/10), '-', 10*floor(p.age_years_at_exam/10) + 10) AS age_range, 
			   COUNT(p.id) AS total
		FROM medical_conditions mc
			INNER JOIN
				person p ON mc.person_id = p.id
		#WHERE mc.asthma = 'Yes'
		GROUP BY age_range
		ORDER BY age_range) AS new ON sorted.age_range = new.age_range;

SELECT *, concat(10*floor(age_years_at_exam/10), '-', 10*floor(age_years_at_exam/10) + 10) as `range` 
FROM person;

# Asthma diagnosis and type based on physical activity
SELECT mc.asthma, pa.Vigorous_physical_activity,
 COUNT(p.id) AS number_of_asthma, COUNT(p.id)/new.num_race AS asthma_rate_per_race
FROM medical_conditions mc
	INNER JOIN
		person p ON mc.person_id = p.id
	INNER JOIN 
		cancer c ON c.cancer_id = mc.cancer_id
	INNER JOIN 
        physical_activity pa ON pa.person_id = p.id
	INNER JOIN
		(SELECT r.race, COUNT(p.id) AS num_race
		 FROM person p
			INNER JOIN
				race r ON p.race_id = r.race_id
		 GROUP BY r.race) new ON new.race = r.race 
GROUP BY mc.asthma, r.race
ORDER BY mc.asthma DESC, number_of_asthma DESC;

## Smoking lead to asthma rate
SELECT total.smoking_status AS smoking_status, asthma.num_people/total.num_people AS asthma_rate
FROM
(SELECT 
ca.now_smoking AS smoking_status, asthma, COUNT(p.id) AS num_people
FROM medical_conditions mc
	INNER JOIN
		person p ON mc.person_id = p.id
	INNER JOIN
		cigarette_and_alcohol ca ON ca.person_id = p.id
WHERE ca.now_smoking IS NOT NULL
GROUP BY ca.now_smoking) AS total INNER JOIN
(SELECT 
ca.now_smoking AS smoking_status, asthma, COUNT(p.id) AS num_people
FROM medical_conditions mc
	INNER JOIN
		person p ON mc.person_id = p.id
	INNER JOIN
		cigarette_and_alcohol ca ON ca.person_id = p.id
WHERE (ca.now_smoking IS NOT NULL) AND (asthma = 'Yes')
GROUP BY ca.now_smoking,asthma) AS asthma ON total.smoking_status = asthma.smoking_status;


##### Stroke
# Stroke diagnosis and type based on race
SELECT 
CASE 
	WHEN mc.stroke = 1 THEN 'Yes' 
    WHEN mc.stroke = 2 THEN 'No'  
    WHEN mc.stroke = 7 THEN 'Refused' 
    WHEN mc.stroke = 9 THEN 'Dont Know'
    ELSE 'NA'
END AS stroke,
r.race, COUNT(p.id) AS number_of_stroke, COUNT(p.id)/new.num_race AS stroke_rate_per_race
FROM medical_conditions mc
	INNER JOIN
		person p ON mc.person_id = p.id
	INNER JOIN 
		cancer c ON c.cancer_id = mc.cancer_id
	INNER JOIN 
        race r ON r.race_id = p.race_id
	INNER JOIN
		(SELECT r.race, COUNT(p.id) AS num_race
		 FROM person p
			INNER JOIN
				race r ON p.race_id = r.race_id
		 GROUP BY r.race) new ON new.race = r.race 
GROUP BY mc.stroke, r.race
ORDER BY mc.stroke DESC, number_of_stroke DESC;

# Stroke diagnosis based on blood pressure
# QUESTION - what's a better way to examine this?
SELECT 
CASE 
	WHEN mc.stroke = 1 THEN 'Yes' 
    WHEN mc.stroke = 2 THEN 'No'  
    WHEN mc.stroke = 7 THEN 'Refused' 
    WHEN mc.stroke = 9 THEN 'Dont Know'
    ELSE 'NA'
END AS stroke,
MAX(blood_pressure_seconds) AS max_blood_pressure,
MIN(blood_pressure_seconds) AS min_blood_pressure,
AVG(blood_pressure_seconds) AS avg_blood_pressure
#COUNT(p.id) AS number_of_stroke, 
#COUNT(p.id)/new.num_race AS stroke_rate_per_race
FROM medical_conditions mc
	INNER JOIN
		person p ON mc.person_id = p.id
	INNER JOIN
		blood_pressure bp ON bp.person_id = p.id
GROUP BY mc.stroke
ORDER BY mc.stroke DESC;

SELECT 
	CASE
    WHEN (systolic_blood_pressure <120) AND (diastolic_blood_pressure < 80) THEN 'Normal blood pressure'
    WHEN (systolic_blood_pressure BETWEEN 120 AND 129) AND diastolic_blood_pressure < 80 THEN 'Elevated blood pressure'
    WHEN (systolic_blood_pressure > 130) OR diastolic_blood_pressure >= 80 THEN 'High blood pressure'
    ELSE 'Undefined'
END AS blood_pressure_rank,
mc.stroke, COUNT(p.id) AS num_stroke
FROM medical_conditions mc
	INNER JOIN
		person p ON mc.person_id = p.id
	INNER JOIN
		blood_pressure bp ON bp.person_id = p.id
WHERE mc.stroke = '1'
GROUP BY blood_pressure_rank;


SELECT 
CASE 
	WHEN mc.stroke = 1 THEN 'Yes' 
    WHEN mc.stroke = 2 THEN 'No'  
    WHEN mc.stroke = 7 THEN 'Refused' 
    WHEN mc.stroke = 9 THEN 'Dont Know'
    ELSE 'NA'
END AS stroke,
MAX(systolic_blood_pressure) AS max_systolic,
MIN(systolic_blood_pressure) AS min_systolic,
AVG(systolic_blood_pressure) AS avg_systolic
#COUNT(p.id) AS number_of_stroke, 
#COUNT(p.id)/new.num_race AS stroke_rate_per_race
FROM medical_conditions mc
	INNER JOIN
		person p ON mc.person_id = p.id
	INNER JOIN
		blood_pressure bp ON bp.person_id = p.id
GROUP BY mc.stroke
ORDER BY mc.stroke DESC;

## Smoking rate
	SELECT total.smoke_status, stroke.num_people AS num_stroke, total.num_people AS total_people,
    stroke.num_people/total.num_people AS stroke_rate
	FROM
			(SELECT 
				 mc.stroke, ca.now_smoking AS smoke_status, COUNT(p.id) AS num_people
			FROM medical_conditions mc
				INNER JOIN
					person p ON mc.person_id = p.id
				INNER JOIN
					cigarette_and_alcohol ca ON ca.person_id = p.id
			WHERE ca.now_smoking IS NOT NULL AND mc.stroke =1
			GROUP BY ca.now_smoking) AS stroke 
	INNER JOIN
			(SELECT 
			CASE 
				WHEN mc.stroke = 1 THEN 'Yes' 
				WHEN mc.stroke = 2 THEN 'No'  
				WHEN mc.stroke = 7 THEN 'Refused' 
				WHEN mc.stroke = 9 THEN 'Dont Know'
				ELSE 'NA'
			END AS stroke, ca.now_smoking AS smoke_status, COUNT(p.id) AS num_people
			FROM medical_conditions mc
				INNER JOIN
					person p ON mc.person_id = p.id
				INNER JOIN
					cigarette_and_alcohol ca ON ca.person_id = p.id
			WHERE ca.now_smoking IS NOT NULL
			GROUP BY ca.now_smoking) AS total ON stroke.smoke_status = total.smoke_status;


SELECT sedentary_activity
FROM physical_activity
GROUP BY moderate_work_activity;
	

SELECT person_id, 'Vigorous Work Activity' AS category, Vigorous_work_activity AS value
FROM physical_activity
UNION ALL
SELECT person_id, 'Moderate Work Activity' AS category, moderate_work_activity AS value
FROM physical_activity
UNION ALL
SELECT person_id, 'Walk or Bicycle' AS category, walk_or_bicycle AS value
FROM physical_activity;










