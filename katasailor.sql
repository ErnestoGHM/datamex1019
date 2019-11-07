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
-- -----------------------------------------------------
-- Schema publications
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema publications
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `publications` DEFAULT CHARACTER SET utf8mb4 ;
-- -----------------------------------------------------
-- Schema kata_sailor
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema kata_sailor
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `kata_sailor` DEFAULT CHARACTER SET utf8mb4 ;
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


-- -----------------------------------------------------
-- Table `lab_mysql_Ernesto`.`most_profiting_authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab_mysql_Ernesto`.`most_profiting_authors` (
  `au_id` INT NOT NULL,
  `profits` VARCHAR(45) NULL,
  PRIMARY KEY (`au_id`))
ENGINE = InnoDB;

USE `publications` ;

-- -----------------------------------------------------
-- Table `publications`.`authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `publications`.`authors` (
  `au_id` VARCHAR(11) NOT NULL,
  `au_lname` VARCHAR(40) NOT NULL,
  `au_fname` VARCHAR(20) NOT NULL,
  `phone` CHAR(12) NOT NULL,
  `address` VARCHAR(40) NULL DEFAULT NULL,
  `city` VARCHAR(20) NULL DEFAULT NULL,
  `state` CHAR(2) NULL DEFAULT NULL,
  `zip` CHAR(5) NULL DEFAULT NULL,
  `contract` TINYINT(4) NOT NULL,
  PRIMARY KEY (`au_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `publications`.`stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `publications`.`stores` (
  `stor_id` CHAR(4) NOT NULL,
  `stor_name` VARCHAR(40) NULL DEFAULT NULL,
  `stor_address` VARCHAR(40) NULL DEFAULT NULL,
  `city` VARCHAR(20) NULL DEFAULT NULL,
  `state` CHAR(2) NULL DEFAULT NULL,
  `zip` CHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`stor_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `publications`.`discounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `publications`.`discounts` (
  `discounttype` VARCHAR(40) NOT NULL,
  `stor_id` CHAR(4) NULL DEFAULT NULL,
  `lowqty` SMALLINT(6) NULL DEFAULT NULL,
  `highqty` SMALLINT(6) NULL DEFAULT NULL,
  `discount` DECIMAL(4,2) NOT NULL,
  INDEX `discounts_stor_id` (`stor_id` ASC) VISIBLE,
  CONSTRAINT `discounts_ibfk_1`
    FOREIGN KEY (`stor_id`)
    REFERENCES `publications`.`stores` (`stor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `publications`.`jobs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `publications`.`jobs` (
  `job_id` SMALLINT(6) NOT NULL,
  `job_desc` VARCHAR(50) NOT NULL,
  `min_lvl` SMALLINT(6) NOT NULL,
  `max_lvl` SMALLINT(6) NOT NULL,
  PRIMARY KEY (`job_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `publications`.`publishers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `publications`.`publishers` (
  `pub_id` CHAR(4) NOT NULL,
  `pub_name` VARCHAR(40) NULL DEFAULT NULL,
  `city` VARCHAR(20) NULL DEFAULT NULL,
  `state` CHAR(2) NULL DEFAULT NULL,
  `country` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`pub_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `publications`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `publications`.`employee` (
  `emp_id` CHAR(9) NOT NULL,
  `fname` VARCHAR(20) NOT NULL,
  `minit` CHAR(1) NULL DEFAULT NULL,
  `lname` VARCHAR(30) NOT NULL,
  `job_id` SMALLINT(6) NOT NULL,
  `job_lvl` SMALLINT(6) NULL DEFAULT NULL,
  `pub_id` CHAR(4) NOT NULL,
  `hire_date` DATETIME NOT NULL,
  PRIMARY KEY (`emp_id`),
  INDEX `employee_job_id` (`job_id` ASC) VISIBLE,
  INDEX `employee_pub_id` (`pub_id` ASC) VISIBLE,
  CONSTRAINT `employee_ibfk_1`
    FOREIGN KEY (`job_id`)
    REFERENCES `publications`.`jobs` (`job_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `employee_ibfk_2`
    FOREIGN KEY (`pub_id`)
    REFERENCES `publications`.`publishers` (`pub_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `publications`.`pub_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `publications`.`pub_info` (
  `pub_id` CHAR(4) NOT NULL,
  `logo` LONGBLOB NULL DEFAULT NULL,
  `pr_info` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`pub_id`),
  CONSTRAINT `pub_info_ibfk_1`
    FOREIGN KEY (`pub_id`)
    REFERENCES `publications`.`publishers` (`pub_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `publications`.`titles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `publications`.`titles` (
  `title_id` VARCHAR(6) NOT NULL,
  `title` VARCHAR(80) NOT NULL,
  `type` CHAR(12) NOT NULL,
  `pub_id` CHAR(4) NULL DEFAULT NULL,
  `price` DECIMAL(19,4) NULL DEFAULT NULL,
  `advance` DECIMAL(19,4) NULL DEFAULT NULL,
  `royalty` INT(11) NULL DEFAULT NULL,
  `ytd_sales` INT(11) NULL DEFAULT NULL,
  `notes` VARCHAR(200) NULL DEFAULT NULL,
  `pubdate` DATETIME NOT NULL,
  PRIMARY KEY (`title_id`),
  INDEX `titles_pub_id` (`pub_id` ASC) VISIBLE,
  CONSTRAINT `titles_ibfk_1`
    FOREIGN KEY (`pub_id`)
    REFERENCES `publications`.`publishers` (`pub_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `publications`.`roysched`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `publications`.`roysched` (
  `title_id` VARCHAR(6) NOT NULL,
  `lorange` INT(11) NULL DEFAULT NULL,
  `hirange` INT(11) NULL DEFAULT NULL,
  `royalty` INT(11) NULL DEFAULT NULL,
  INDEX `roysched_title_id` (`title_id` ASC) VISIBLE,
  CONSTRAINT `roysched_ibfk_1`
    FOREIGN KEY (`title_id`)
    REFERENCES `publications`.`titles` (`title_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `publications`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `publications`.`sales` (
  `stor_id` CHAR(4) NOT NULL,
  `ord_num` VARCHAR(20) NOT NULL,
  `ord_date` DATETIME NOT NULL,
  `qty` SMALLINT(6) NOT NULL,
  `payterms` VARCHAR(12) NOT NULL,
  `title_id` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`stor_id`, `ord_num`, `title_id`),
  INDEX `sales_title_id` (`title_id` ASC) VISIBLE,
  CONSTRAINT `sales_ibfk_1`
    FOREIGN KEY (`stor_id`)
    REFERENCES `publications`.`stores` (`stor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `sales_ibfk_2`
    FOREIGN KEY (`title_id`)
    REFERENCES `publications`.`titles` (`title_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `publications`.`titleauthor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `publications`.`titleauthor` (
  `au_id` VARCHAR(11) NOT NULL,
  `title_id` VARCHAR(6) NOT NULL,
  `au_ord` TINYINT(4) NULL DEFAULT NULL,
  `royaltyper` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`au_id`, `title_id`),
  INDEX `titleauthor_title_id` (`title_id` ASC) VISIBLE,
  CONSTRAINT `titleauthor_ibfk_1`
    FOREIGN KEY (`title_id`)
    REFERENCES `publications`.`titles` (`title_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `titleauthor_ibfk_2`
    FOREIGN KEY (`au_id`)
    REFERENCES `publications`.`authors` (`au_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `kata_sailor` ;

-- -----------------------------------------------------
-- Table `kata_sailor`.`sailorsenshi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kata_sailor`.`sailorsenshi` (
  `senshi_name` VARCHAR(45) NULL,
  `real_name_jpn` VARCHAR(45) NULL,
  `school_id` VARCHAR(45) NULL,
  `sailor_id` VARCHAR(45) NOT NULL,
  `cat_id` VARCHAR(45) NULL,
  UNIQUE INDEX `sailor_id_UNIQUE` (`sailor_id` ASC) VISIBLE,
  PRIMARY KEY (`sailor_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kata_sailor`.`cats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kata_sailor`.`cats` (
  `cat_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`cat_id`),
  UNIQUE INDEX `cat_id_UNIQUE` (`cat_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kata_sailor`.`schools`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kata_sailor`.`schools` (
  `school_id` INT NOT NULL,
  `school` VARCHAR(45) NULL,
  PRIMARY KEY (`school_id`),
  UNIQUE INDEX `school_id_UNIQUE` (`school_id` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
