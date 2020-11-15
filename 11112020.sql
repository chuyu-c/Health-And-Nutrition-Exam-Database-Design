INSERT INTO mydb.person(age_at_exam)
     SELECT age_months_at_exam / 12 AS age_at_exam
     FROM mydb.person;
     
 
ALTER TABLE mydb.person
  ADD age_months_at_exam INT(11) DEFAULT NULL
  AFTER id;    

ALTER TABLE mydb.person
  DROP COLUMN age_years_at_exam;


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
