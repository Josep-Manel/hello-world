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
-- Table `mydb`.`Custumers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Custumers` (
  `custumer_id` INT NOT NULL AUTO_INCREMENT,
  `name_first` VARCHAR(45) NULL,
  `name_last` VARCHAR(45) NULL,
  `mail_address` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `phone` VARCHAR(14) NULL,
  PRIMARY KEY (`custumer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Shops`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Shops` (
  `shop_id` INT NOT NULL AUTO_INCREMENT,
  `shop_address` VARCHAR(45) NULL,
  `mail_address` VARCHAR(45) NULL,
  `phone` VARCHAR(14) NULL,
  `floor` INT NULL,
  PRIMARY KEY (`shop_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employees` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `name_first` VARCHAR(45) NOT NULL,
  `name_last` VARCHAR(45) NOT NULL,
  `shop_id` INT NOT NULL,
  `Shops_shop_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`, `Shops_shop_id`),
  INDEX `fk_Employees_Shops1_idx` (`Shops_shop_id` ASC) VISIBLE,
  CONSTRAINT `fk_Employees_Shops1`
    FOREIGN KEY (`Shops_shop_id`)
    REFERENCES `mydb`.`Shops` (`shop_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` VARCHAR(45) NOT NULL,
  `order_date` DATETIME NOT NULL,
  `employee_id` INT NOT NULL,
  `Custumers_custumer_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_Orders_Custumers_idx` (`Custumers_custumer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Custumers`
    FOREIGN KEY (`Custumers_custumer_id`)
    REFERENCES `mydb`.`Custumers` (`custumer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProductsTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ProductsTypes` (
  `type_id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NOT NULL,
  `product_stock` INT NOT NULL,
  `product_price` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `product_description` LONGTEXT NOT NULL,
  `ProductsTypes_type_id` INT NOT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_Products_ProductsTypes1_idx` (`ProductsTypes_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_Products_ProductsTypes1`
    FOREIGN KEY (`ProductsTypes_type_id`)
    REFERENCES `mydb`.`ProductsTypes` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrdersProducts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OrdersProducts` (
  `order_product_id` INT NOT NULL,
  `product_quantity` INT NOT NULL,
  `Orders_order_id` INT NOT NULL,
  `Products_product_id` INT NOT NULL,
  PRIMARY KEY (`order_product_id`, `Orders_order_id`),
  INDEX `fk_OrdersProducts_Orders1_idx` (`Orders_order_id` ASC) VISIBLE,
  INDEX `fk_OrdersProducts_Products1_idx` (`Products_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_OrdersProducts_Orders1`
    FOREIGN KEY (`Orders_order_id`)
    REFERENCES `mydb`.`Orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrdersProducts_Products1`
    FOREIGN KEY (`Products_product_id`)
    REFERENCES `mydb`.`Products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
