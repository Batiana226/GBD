-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema matos3
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `matos3` ;

-- -----------------------------------------------------
-- Schema matos3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `matos3` DEFAULT CHARACTER SET utf8 ;
USE `matos3` ;

-- -----------------------------------------------------
-- Table `matos3`.`promo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `matos3`.`promo` ;

CREATE TABLE IF NOT EXISTS `matos3`.`promo` (
  `idpromo` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `date_ouverture` DATETIME NOT NULL,
  `date_fermeture` DATETIME NOT NULL,
  PRIMARY KEY (`idpromo`),
  UNIQUE INDEX `idpromo_UNIQUE` (`idpromo` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `matos3`.`etat_personne`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `matos3`.`etat_personne` ;

CREATE TABLE IF NOT EXISTS `matos3`.`etat_personne` (
  `idetat_personne` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idetat_personne`),
  UNIQUE INDEX `idetat_personne_UNIQUE` (`idetat_personne` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `matos3`.`personne`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `matos3`.`personne` ;

CREATE TABLE IF NOT EXISTS `matos3`.`personne` (
  `idpersonne` INT NOT NULL AUTO_INCREMENT,
  `prenom` VARCHAR(45) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `numphone` VARCHAR(45) NOT NULL,
  `tag` INT NOT NULL,
  `date_naissance` DATETIME NOT NULL,
  `sexe` INT NOT NULL,
  `etat_personne_idetat_personne` INT NOT NULL,
  `promo_idpromo` INT NOT NULL,
  PRIMARY KEY (`idpersonne`),
  UNIQUE INDEX `idpersonne_UNIQUE` (`idpersonne` ASC),
  INDEX `fk_personne_etat_personne_idx` (`etat_personne_idetat_personne` ASC),
  INDEX `fk_personne_promo1_idx` (`promo_idpromo` ASC),
  CONSTRAINT `fk_personne_etat_personne`
    FOREIGN KEY (`etat_personne_idetat_personne`)
    REFERENCES `matos3`.`etat_personne` (`idetat_personne`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personne_promo1`
    FOREIGN KEY (`promo_idpromo`)
    REFERENCES `matos3`.`promo` (`idpromo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `matos3`.`groupe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `matos3`.`groupe` ;

CREATE TABLE IF NOT EXISTS `matos3`.`groupe` (
  `idgroupe` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idgroupe`),
  UNIQUE INDEX `idgroupe_UNIQUE` (`idgroupe` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `matos3`.`personne_has_groupe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `matos3`.`personne_has_groupe` ;

CREATE TABLE IF NOT EXISTS `matos3`.`personne_has_groupe` (
  `personne_idpersonne` INT NOT NULL,
  `groupe_idgroupe` INT NOT NULL,
  PRIMARY KEY (`personne_idpersonne`, `groupe_idgroupe`),
  INDEX `fk_personne_has_groupe_groupe1_idx` (`groupe_idgroupe` ASC),
  INDEX `fk_personne_has_groupe_personne1_idx` (`personne_idpersonne` ASC),
  CONSTRAINT `fk_personne_has_groupe_personne1`
    FOREIGN KEY (`personne_idpersonne`)
    REFERENCES `matos3`.`personne` (`idpersonne`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personne_has_groupe_groupe1`
    FOREIGN KEY (`groupe_idgroupe`)
    REFERENCES `matos3`.`groupe` (`idgroupe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `matos3`.`panier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `matos3`.`panier` ;

CREATE TABLE IF NOT EXISTS `matos3`.`panier` (
  `idpanier` INT NOT NULL AUTO_INCREMENT,
  `date_emprunt` DATETIME NOT NULL,
  `date_restitution` DATETIME NOT NULL,
  `personne_idpersonne` INT NOT NULL,
  PRIMARY KEY (`idpanier`),
  UNIQUE INDEX `idpanier_UNIQUE` (`idpanier` ASC),
  INDEX `fk_panier_personne1_idx` (`personne_idpersonne` ASC),
  CONSTRAINT `fk_panier_personne1`
    FOREIGN KEY (`personne_idpersonne`)
    REFERENCES `matos3`.`personne` (`idpersonne`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `matos3`.`materiel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `matos3`.`materiel` ;

CREATE TABLE IF NOT EXISTS `matos3`.`materiel` (
  `idmateriel` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idmateriel`),
  UNIQUE INDEX `idmateriel_UNIQUE` (`idmateriel` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `matos3`.`instance_materiel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `matos3`.`instance_materiel` ;

CREATE TABLE IF NOT EXISTS `matos3`.`instance_materiel` (
  `idinstance_materiel` INT NOT NULL AUTO_INCREMENT,
  `ean13` VARCHAR(45) NOT NULL,
  `poids` VARCHAR(45) NOT NULL,
  `materiel_idmateriel` INT NOT NULL,
  `instance_materiel_idinstance_materiel` INT NULL,
  `emprunte` INT NOT NULL,
  PRIMARY KEY (`idinstance_materiel`),
  UNIQUE INDEX `idinstance_materiel_UNIQUE` (`idinstance_materiel` ASC),
  INDEX `fk_instance_materiel_materiel1_idx` (`materiel_idmateriel` ASC),
  INDEX `fk_instance_materiel_instance_materiel1_idx` (`instance_materiel_idinstance_materiel` ASC),
  UNIQUE INDEX `ean13_UNIQUE` (`ean13` ASC),
  CONSTRAINT `fk_instance_materiel_materiel1`
    FOREIGN KEY (`materiel_idmateriel`)
    REFERENCES `matos3`.`materiel` (`idmateriel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_instance_materiel_instance_materiel1`
    FOREIGN KEY (`instance_materiel_idinstance_materiel`)
    REFERENCES `matos3`.`instance_materiel` (`idinstance_materiel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `matos3`.`emprunt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `matos3`.`emprunt` ;

CREATE TABLE IF NOT EXISTS `matos3`.`emprunt` (
  `idemprunt` INT NOT NULL AUTO_INCREMENT,
  `date_emprunt` DATETIME NOT NULL,
  `date_restitution` DATETIME NOT NULL,
  `etat` INT NOT NULL,
  `panier_idpanier` INT NOT NULL,
  `instance_materiel_idinstance_materiel` INT NOT NULL,
  PRIMARY KEY (`idemprunt`),
  UNIQUE INDEX `idemprunt_UNIQUE` (`idemprunt` ASC),
  INDEX `fk_emprunt_panier1_idx` (`panier_idpanier` ASC),
  INDEX `fk_emprunt_instance_materiel1_idx` (`instance_materiel_idinstance_materiel` ASC),
  CONSTRAINT `fk_emprunt_panier1`
    FOREIGN KEY (`panier_idpanier`)
    REFERENCES `matos3`.`panier` (`idpanier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emprunt_instance_materiel1`
    FOREIGN KEY (`instance_materiel_idinstance_materiel`)
    REFERENCES `matos3`.`instance_materiel` (`idinstance_materiel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `matos3`.`tm_raspberry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `matos3`.`tm_raspberry` ;

CREATE TABLE IF NOT EXISTS `matos3`.`tm_raspberry` (
  `idtm_raspberry` INT NOT NULL AUTO_INCREMENT,
  `instance_materiel_idinstance_materiel` INT NOT NULL,
  `addr_mac` VARCHAR(45) NOT NULL,
  `addr_ip` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtm_raspberry`),
  UNIQUE INDEX `idtm_raspberry_UNIQUE` (`idtm_raspberry` ASC),
  INDEX `fk_tm_raspberry_instance_materiel1_idx` (`instance_materiel_idinstance_materiel` ASC),
  CONSTRAINT `fk_tm_raspberry_instance_materiel1`
    FOREIGN KEY (`instance_materiel_idinstance_materiel`)
    REFERENCES `matos3`.`instance_materiel` (`idinstance_materiel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `matos3`.`tm_souris`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `matos3`.`tm_souris` ;

CREATE TABLE IF NOT EXISTS `matos3`.`tm_souris` (
  `idtm_souris` INT NOT NULL AUTO_INCREMENT,
  `instance_materiel_idinstance_materiel` INT NOT NULL,
  `marque` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtm_souris`),
  UNIQUE INDEX `idtm_souris_UNIQUE` (`idtm_souris` ASC),
  INDEX `fk_tm_souris_instance_materiel1_idx` (`instance_materiel_idinstance_materiel` ASC),
  CONSTRAINT `fk_tm_souris_instance_materiel1`
    FOREIGN KEY (`instance_materiel_idinstance_materiel`)
    REFERENCES `matos3`.`instance_materiel` (`idinstance_materiel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `matos3`.`tm_cable`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `matos3`.`tm_cable` ;

CREATE TABLE IF NOT EXISTS `matos3`.`tm_cable` (
  `idtm_cable` INT NOT NULL AUTO_INCREMENT,
  `instance_materiel_idinstance_materiel` INT NOT NULL,
  `longueur` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtm_cable`),
  UNIQUE INDEX `idtm_cable_UNIQUE` (`idtm_cable` ASC),
  INDEX `fk_tm_cable_instance_materiel1_idx` (`instance_materiel_idinstance_materiel` ASC),
  CONSTRAINT `fk_tm_cable_instance_materiel1`
    FOREIGN KEY (`instance_materiel_idinstance_materiel`)
    REFERENCES `matos3`.`instance_materiel` (`idinstance_materiel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
