-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`adults_education_level`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`adults_education_level` (
  `adults_education_level_id` INT NOT NULL,
  `adults_education_level` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`adults_education_level_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`children_education_level`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`children_education_level` (
  `children_education_level_id` INT NOT NULL,
  `children_education_level` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`children_education_level_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`citizenship`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`citizenship` (
  `citizenship_id` INT NOT NULL,
  `citizenship_status` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`citizenship_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`income`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`income` (
  `income_id` INT NOT NULL,
  `annual_household_income` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`income_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`marital_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`marital_status` (
  `marital_status_id` INT NOT NULL,
  `marital_status` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`marital_status_id`),
  UNIQUE INDEX `marital_status_id_UNIQUE` (`marital_status_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`race`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`race` (
  `race_id` INT NOT NULL,
  `race` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`race_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`person` (
  `id` INT NOT NULL,
  `age_months_at_exam` INT NULL DEFAULT NULL,
  `length_time_US` INT NULL DEFAULT NULL,
  `number_people_in_household` INT NULL DEFAULT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `marital_status_id` INT NOT NULL,
  `race_id` INT NOT NULL,
  `citizenship_id` INT NOT NULL,
  `children_education_level_id` INT NOT NULL,
  `adults_education_level_id` INT NOT NULL,
  `income_income_id` INT NOT NULL,
  `weight` VARCHAR(45) NULL DEFAULT NULL,
  `standing_height` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_person_marital_status_idx` (`marital_status_id` ASC) VISIBLE,
  INDEX `fk_person_race1_idx` (`race_id` ASC) VISIBLE,
  INDEX `fk_person_citizenship1_idx` (`citizenship_id` ASC) VISIBLE,
  INDEX `fk_person_children_education_level1_idx` (`children_education_level_id` ASC) VISIBLE,
  INDEX `fk_person_adults_education_level1_idx` (`adults_education_level_id` ASC) VISIBLE,
  INDEX `fk_person_income1_idx` (`income_income_id` ASC) VISIBLE,
  CONSTRAINT `fk_person_adults_education_level1`
    FOREIGN KEY (`adults_education_level_id`)
    REFERENCES `mydb`.`adults_education_level` (`adults_education_level_id`),
  CONSTRAINT `fk_person_children_education_level1`
    FOREIGN KEY (`children_education_level_id`)
    REFERENCES `mydb`.`children_education_level` (`children_education_level_id`),
  CONSTRAINT `fk_person_citizenship1`
    FOREIGN KEY (`citizenship_id`)
    REFERENCES `mydb`.`citizenship` (`citizenship_id`),
  CONSTRAINT `fk_person_income1`
    FOREIGN KEY (`income_income_id`)
    REFERENCES `mydb`.`income` (`income_id`),
  CONSTRAINT `fk_person_marital_status`
    FOREIGN KEY (`marital_status_id`)
    REFERENCES `mydb`.`marital_status` (`marital_status_id`),
  CONSTRAINT `fk_person_race1`
    FOREIGN KEY (`race_id`)
    REFERENCES `mydb`.`race` (`race_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`pulse_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pulse_type` (
  `pulse_type_id` INT NOT NULL,
  `pulse_type` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`pulse_type_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`blood_pressure`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`blood_pressure` (
  `blood_pressure_seconds` INT NULL DEFAULT NULL,
  `sixty_sec_HR` INT NULL DEFAULT NULL,
  `sixty_pulse` INT NULL DEFAULT NULL,
  `systolic_blood_pressure` INT NULL DEFAULT NULL,
  `diastollic_blood_pressure` INT NULL DEFAULT NULL,
  `enhancement_first_reading` INT NULL DEFAULT NULL,
  `person_id` INT NOT NULL,
  `pulse_type_id` INT NOT NULL,
  PRIMARY KEY (`person_id`),
  INDEX `fk_person_idx` (`person_id` ASC) VISIBLE,
  CONSTRAINT `fk_blood_pressure_person`
    FOREIGN KEY (`person_id`)
    REFERENCES `mydb`.`person` (`id`),
  CONSTRAINT `fk_blood_pressure_pulse_type1`
    FOREIGN KEY (`pulse_type_id`)
    REFERENCES `mydb`.`pulse_type` (`pulse_type_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`cancer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cancer` (
  `cancer_id` INT NOT NULL,
  `type_of_cancer` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`cancer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`cigarette_and_alcohol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cigarette_and_alcohol` (
  `age_started_smoke` INT NULL DEFAULT NULL,
  `now_smoking` VARCHAR(45) NULL DEFAULT NULL,
  `avg_cig_smoke_30days` INT NULL DEFAULT NULL,
  `at_least_12_alcohol_12_month` VARCHAR(45) NULL DEFAULT NULL,
  `freq_alcohol_12month` INT NULL DEFAULT NULL,
  `avg_alcohol_per_day_past_12month` INT NULL DEFAULT NULL,
  `person_id` INT NOT NULL,
  PRIMARY KEY (`person_id`),
  INDEX `fk_cigarette_and_alcohol_person_idx` (`person_id` ASC) VISIBLE,
  CONSTRAINT `fk_cigarette_and_person`
    FOREIGN KEY (`person_id`)
    REFERENCES `mydb`.`person` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`medical_conditions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`medical_conditions` (
  `person_id` INT NOT NULL,
  `fasting_glucose` INT NULL DEFAULT NULL,
  `oral_glucose_tolerance` INT NULL DEFAULT NULL,
  `total_cholestrol` INT NULL DEFAULT NULL,
  `diabetes` VARCHAR(45) NULL DEFAULT NULL,
  `asthma` VARCHAR(45) NULL DEFAULT NULL,
  `medical_conditionscol` VARCHAR(45) NULL DEFAULT NULL,
  `arthritis` VARCHAR(45) NULL DEFAULT NULL,
  `stroke` VARCHAR(45) NULL DEFAULT NULL,
  `chronic_bronchitis` VARCHAR(45) NULL DEFAULT NULL,
  `had_cancer_or_malignancy` VARCHAR(45) NULL DEFAULT NULL,
  `overweight` VARCHAR(45) NULL DEFAULT NULL,
  `gout` VARCHAR(45) NULL DEFAULT NULL,
  `congestive_heart_failure` VARCHAR(45) NULL DEFAULT NULL,
  `coronary_heart_disease` VARCHAR(45) NULL DEFAULT NULL,
  `angina_pectoris` VARCHAR(45) NULL DEFAULT NULL,
  `heart_attack` VARCHAR(45) NULL DEFAULT NULL,
  `emphysema` VARCHAR(45) NULL DEFAULT NULL,
  `thyroid_problem` VARCHAR(45) NULL DEFAULT NULL,
  `liver_condition` VARCHAR(45) NULL DEFAULT NULL,
  `cancer_id` INT NOT NULL,
  `cancer_id1` INT NOT NULL,
  PRIMARY KEY (`person_id`),
  INDEX `fk_medical_conditions_person_idx` (`person_id` ASC) VISIBLE,
  INDEX `fk_medical_conditions_cancer1_idx` (`cancer_id` ASC) VISIBLE,
  INDEX `fk_medical_conditions_cancer2_idx` (`cancer_id1` ASC) VISIBLE,
  CONSTRAINT `fk_medical_conditions_cancer1`
    FOREIGN KEY (`cancer_id`)
    REFERENCES `mydb`.`cancer` (`cancer_id`),
  CONSTRAINT `fk_medical_conditions_person`
    FOREIGN KEY (`person_id`)
    REFERENCES `mydb`.`person` (`id`),
  CONSTRAINT `fk_medical_conditions_cancer2`
    FOREIGN KEY (`cancer_id1`)
    REFERENCES `mydb`.`cancer` (`cancer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



-- -----------------------------------------------------
-- Table `mydb`.`physical_activity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`physical_activity` (
  `Vigorous_work_activity` VARCHAR(45) NULL DEFAULT NULL,
  `moderate_work_activity` VARCHAR(45) NULL DEFAULT NULL,
  `walk_or_bicycle` VARCHAR(45) NULL DEFAULT NULL,
  `sedentary_activity` VARCHAR(45) NULL DEFAULT NULL,
  `person_id` INT NOT NULL,
  PRIMARY KEY (`person_id`),
  INDEX `fk_physical_activity_person_idx` (`person_id` ASC) VISIBLE,
  CONSTRAINT `fk_physical_activity_person`
    FOREIGN KEY (`person_id`)
    REFERENCES `mydb`.`person` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `mydb`.`age`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`age` (
  `person_id` INT NOT NULL,
  `age_months_at_exam` INT NULL DEFAULT NULL,
  PRIMARY KEY (`person_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
