-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema lab_mysql_Ernesto
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lab_mysql_Ernesto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lab_mysql_Ernesto` DEFAULT CHARACTER SET utf8mb4 ;
USE `lab_mysql_Ernesto` ;

-- -----------------------------------------------------
-- Table `lab_mysql_Ernesto`.`cars`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab_mysql_Ernesto`.`cars` (
  `car_id` INT NOT NULL,
  `VIN` VARCHAR(45) NULL,
  `Manufacturer` VARCHAR(45) NULL,
  `Model` VARCHAR(45) NULL,
  `Year` VARCHAR(45) NULL,
  `Color` VARCHAR(45) NULL,
  PRIMARY KEY (`car_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lab_mysql_Ernesto`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab_mysql_Ernesto`.`customers` (
  `customers_ID` INT NOT NULL,
  `cust_ID` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state_prov` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `zip` VARCHAR(45) NULL,
  PRIMARY KEY (`customers_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lab_mysql_Ernesto`.`salesperson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab_mysql_Ernesto`.`salesperson` (
  `salesperson_ID` INT NOT NULL,
  `staff_id` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `store` VARCHAR(45) NULL,
  PRIMARY KEY (`salesperson_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lab_mysql_Ernesto`.`invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab_mysql_Ernesto`.`invoices` (
  `invoices_ID` INT NOT NULL,
  `invoice` VARCHAR(45) NULL,
  `date` VARCHAR(45) NULL,
  `VIN` VARCHAR(45) NULL,
  `cust_ID` VARCHAR(45) NULL,
  `staff_id` VARCHAR(45) NULL,
  PRIMARY KEY (`invoices_ID`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
