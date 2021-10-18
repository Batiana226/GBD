-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 18 oct. 2021 à 17:50
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `matos2`
--

-- --------------------------------------------------------

--
-- Structure de la table `emprunt`
--

DROP TABLE IF EXISTS `emprunt`;
CREATE TABLE IF NOT EXISTS `emprunt` (
  `idemprunt` int(11) NOT NULL AUTO_INCREMENT,
  `date_emprunt` datetime NOT NULL,
  `date_restitution` datetime NOT NULL,
  `etat` int(11) NOT NULL,
  `panier_idpanier` int(11) NOT NULL,
  `instance_materiel_idinstance_materiel` int(11) NOT NULL,
  PRIMARY KEY (`idemprunt`),
  UNIQUE KEY `idemprunt_UNIQUE` (`idemprunt`),
  KEY `fk_emprunt_panier1_idx` (`panier_idpanier`),
  KEY `fk_emprunt_instance_materiel1_idx` (`instance_materiel_idinstance_materiel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `etat_personne`
--

DROP TABLE IF EXISTS `etat_personne`;
CREATE TABLE IF NOT EXISTS `etat_personne` (
  `idetat_personne` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  PRIMARY KEY (`idetat_personne`),
  UNIQUE KEY `idetat_personne_UNIQUE` (`idetat_personne`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `etat_personne`
--

INSERT INTO `etat_personne` (`idetat_personne`, `nom`) VALUES
(1, 'eleve'),
(2, 'professeur'),
(3, 'technicien'),
(4, 'superviseur'),
(5, 'eleve'),
(6, 'professeur'),
(7, 'technicien'),
(8, 'superviseur');

-- --------------------------------------------------------

--
-- Structure de la table `groupe`
--

DROP TABLE IF EXISTS `groupe`;
CREATE TABLE IF NOT EXISTS `groupe` (
  `idgroupe` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  PRIMARY KEY (`idgroupe`),
  UNIQUE KEY `idgroupe_UNIQUE` (`idgroupe`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `groupe`
--

INSERT INTO `groupe` (`idgroupe`, `nom`) VALUES
(26, 'groupe_A'),
(27, 'groupe_B'),
(28, 'goupe_1'),
(29, 'groupe_2'),
(30, 'groupe_3'),
(31, 'groupe_4'),
(32, 'groupe_5'),
(33, 'groupe_6');

-- --------------------------------------------------------

--
-- Structure de la table `instance_materiel`
--

DROP TABLE IF EXISTS `instance_materiel`;
CREATE TABLE IF NOT EXISTS `instance_materiel` (
  `idinstance_materiel` int(11) NOT NULL AUTO_INCREMENT,
  `ean13` varchar(45) NOT NULL,
  `poids` varchar(45) NOT NULL,
  `materiel_idmateriel` int(11) NOT NULL,
  `instance_materiel_idinstance_materiel` int(11) DEFAULT NULL,
  PRIMARY KEY (`idinstance_materiel`),
  UNIQUE KEY `idinstance_materiel_UNIQUE` (`idinstance_materiel`),
  UNIQUE KEY `ean13_UNIQUE` (`ean13`),
  KEY `fk_instance_materiel_materiel1_idx` (`materiel_idmateriel`),
  KEY `fk_instance_materiel_instance_materiel1_idx` (`instance_materiel_idinstance_materiel`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `instance_materiel`
--

INSERT INTO `instance_materiel` (`idinstance_materiel`, `ean13`, `poids`, `materiel_idmateriel`, `instance_materiel_idinstance_materiel`) VALUES
(1, 'raspberry #01', '100', 1, NULL),
(2, 'raspberry #02', '100', 1, NULL),
(3, 'raspberry #03', '100', 1, NULL),
(4, 'raspberry #04', '100', 1, NULL),
(5, 'raspberry #05', '100', 1, NULL),
(6, 'raspberry #06', '100', 1, NULL),
(7, 'raspberry #07', '100', 1, NULL),
(8, 'raspberry #08', '100', 1, NULL),
(9, 'souris #01', '200', 2, NULL),
(10, 'souris #02', '200', 2, NULL),
(11, 'souris #03', '200', 2, NULL),
(12, 'souris #04', '200', 2, NULL),
(13, 'souris #05', '200', 2, NULL),
(14, 'souris #06', '200', 2, NULL),
(15, 'souris #07', '200', 2, NULL),
(16, 'souris #08', '200', 2, NULL),
(17, 'cable #01', '240', 3, NULL),
(18, 'cable #02', '240', 3, NULL),
(19, 'cable #03', '240', 3, NULL),
(20, 'cable #04', '240', 3, NULL),
(21, 'cable #05', '240', 3, NULL),
(22, 'cable #06', '240', 3, NULL),
(23, 'cable #07', '240', 3, NULL),
(24, 'cable #08', '240', 3, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `materiel`
--

DROP TABLE IF EXISTS `materiel`;
CREATE TABLE IF NOT EXISTS `materiel` (
  `idmateriel` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  PRIMARY KEY (`idmateriel`),
  UNIQUE KEY `idmateriel_UNIQUE` (`idmateriel`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `materiel`
--

INSERT INTO `materiel` (`idmateriel`, `nom`) VALUES
(1, 'raspberry'),
(2, 'souris'),
(3, 'cable');

-- --------------------------------------------------------

--
-- Structure de la table `panier`
--

DROP TABLE IF EXISTS `panier`;
CREATE TABLE IF NOT EXISTS `panier` (
  `idpanier` int(11) NOT NULL AUTO_INCREMENT,
  `date_emprunt` datetime NOT NULL,
  `date_restitution` datetime NOT NULL,
  `personne_idpersonne` int(11) NOT NULL,
  PRIMARY KEY (`idpanier`),
  UNIQUE KEY `idpanier_UNIQUE` (`idpanier`),
  KEY `fk_panier_personne1_idx` (`personne_idpersonne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `personne`
--

DROP TABLE IF EXISTS `personne`;
CREATE TABLE IF NOT EXISTS `personne` (
  `idpersonne` int(11) NOT NULL AUTO_INCREMENT,
  `prenom` varchar(45) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `numphone` varchar(45) NOT NULL,
  `tag` int(11) NOT NULL,
  `date_naissance` datetime NOT NULL,
  `sexe` int(11) NOT NULL,
  `etat_personne_idetat_personne` int(11) NOT NULL,
  `promo_idpromo` int(11) NOT NULL,
  PRIMARY KEY (`idpersonne`),
  UNIQUE KEY `idpersonne_UNIQUE` (`idpersonne`),
  KEY `fk_personne_etat_personne_idx` (`etat_personne_idetat_personne`),
  KEY `fk_personne_promo1_idx` (`promo_idpromo`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `personne`
--

INSERT INTO `personne` (`idpersonne`, `prenom`, `nom`, `email`, `numphone`, `tag`, `date_naissance`, `sexe`, `etat_personne_idetat_personne`, `promo_idpromo`) VALUES
(1, 'JULIAN', 'BARKOUDEH', 'julian.barkoudeh@etu.sorbonne-universite.fr', '0102030405', 3800363, '2000-09-01 00:00:00', 1, 1, 1),
(2, 'MAMADOU BOYE', 'BARRY', 'Mamadou_Boye.Barry@etu.sorbonne-universite.fr', '0102030405', 28712682, '2000-09-01 00:00:00', 1, 1, 1),
(3, 'LOUIS', 'BELHOMME', 'Louis.Belhomme@etu.sorbonne-universite.fr', '0102030405', 28717029, '2000-09-01 00:00:00', 1, 1, 1),
(4, 'GHAIS', 'BEN MOHAMED', 'Ghais.Garwig-Ben_Mohamed@etu.sorbonne-univers', '0102030405', 28713872, '2000-09-01 00:00:00', 1, 1, 1),
(5, 'YOUSSEF', 'BENALI', 'youssef.benali@etu.sorbonne-universite.fr', '0102030405', 3800414, '2000-09-01 00:00:00', 1, 1, 1),
(6, 'Jeremy', 'COLZY', 'jeremy.colzy@etu.sorbonne-universite.fr', '0102030405', 28611833, '2000-09-01 00:00:00', 1, 1, 1),
(7, 'LEO', 'DELAS', 'leo.delas@etu.sorbonne-universite.fr', '0102030405', 3801795, '2000-09-01 00:00:00', 1, 1, 1),
(8, 'DAMIEN', 'DOS SANTOS', 'damien.dos_santos.1@etu.sorbonne-universite.f', '0102030405', 3803378, '2000-09-01 00:00:00', 1, 1, 1),
(9, 'CAMILLE', 'DOUZET', 'Camille.Douzet@etu.sorbonne-universite.fr', '0102030405', 28712132, '2000-09-01 00:00:00', 2, 1, 1),
(10, 'BASILE', 'DURAND DE GEVIGNEY', 'basile.durand_de_gevigney@etu.sorbonne-univer', '0102030405', 3804755, '2000-09-01 00:00:00', 1, 1, 1),
(11, 'KEITA', 'EFFOUDOU MEZI', 'keita.effoudou_mezi@etu.sorbonne-universite.f', '0102030405', 3803960, '2000-09-01 00:00:00', 1, 1, 1),
(12, 'OUMAIMA', 'ESSAID', 'oumaima.essaid@etu.sorbonne-universite.fr', '0102030405', 28616589, '2000-09-01 00:00:00', 2, 1, 1),
(13, 'MATTHIEU', 'GRESSET', 'Matthieu.Gresset@etu.sorbonne-universite.fr', '0102030405', 28712144, '2000-09-01 00:00:00', 1, 1, 1),
(14, 'LUCAS', 'GUEDON', 'lucas.guedon@etu.sorbonne-universite.fr', '0102030405', 3802021, '2000-09-01 00:00:00', 1, 1, 1),
(15, 'HANI', 'IZEM', 'hani.izem@etu.sorbonne-universite.fr', '0102030405', 3803584, '2000-09-01 00:00:00', 1, 1, 1),
(16, 'PASCOAL', 'KIANGANGU', 'pascoal.kiangangu@etu.sorbonne-universite.fr', '0102030405', 3804143, '2000-09-01 00:00:00', 1, 1, 1),
(17, 'BATIANA MOHAMED', 'NACRO', 'Batiana_Mohamed.Nacro@etu.sorbonne-universite', '0102030405', 28718390, '2000-09-01 00:00:00', 1, 1, 1),
(18, 'HUGO', 'ROUYER', 'Hugo.Rouyer@etu.sorbonne-universite.fr', '0102030405', 28712758, '2000-09-01 00:00:00', 1, 1, 1),
(19, 'ABILASH', 'SIVANESWARAN', 'abilash.sivaneswaran@etu.sorbonne-universite.', '0102030405', 3801823, '2000-09-01 00:00:00', 1, 1, 1),
(20, 'HICHAM', 'TALSI', 'Hicham.Talsi@etu.sorbonne-universite.fr', '0102030405', 28713341, '2000-09-01 00:00:00', 1, 1, 1),
(21, 'Caroline', 'TAN', 'caroline.tan@etu.sorbonne-universite.fr', '0102030405', 28609011, '2000-09-01 00:00:00', 2, 1, 1),
(22, 'REINE', 'TOHOTCHEU WAKO', 'reine.tohotcheu_wako@etu.sorbonne-universite.', '0102030405', 3801669, '2000-09-01 00:00:00', 2, 1, 1),
(23, 'Valentine', 'YAO', 'valentine.yao@etu.sorbonne-universite.fr', '0102030405', 28609061, '2000-09-01 00:00:00', 2, 1, 1),
(24, 'OZKAN', 'CAVDAR', 'ozkan.cavdar@etu.sorbonne-universite.fr', '0102030405', 3802115, '2000-09-01 00:00:00', 1, 1, 2),
(25, 'SEBASTIEN', 'CLUCHIER', 'Sebastien.Cluchier@etu.sorbonne-universite.fr', '0102030405', 28712208, '2000-09-01 00:00:00', 1, 1, 2),
(26, 'DAVID', 'MARQUES', 'David.Marques@etu.sorbonne-universite.fr', '0102030405', 28711944, '2000-09-01 00:00:00', 1, 1, 2),
(27, 'Martin Evrard', 'NGUEMO MOMO', 'martin.nguemo_momo@etu.sorbonne-universite.fr', '0102030405', 28612557, '2000-09-01 00:00:00', 1, 1, 2),
(28, 'ALEJANDRO IVAN', 'RANGEL ALDANA', 'Alejandro_Ivan.Rangel_Aldana@etu.sorbonne-uni', '0102030405', 28712780, '2000-09-01 00:00:00', 1, 1, 2),
(29, 'RAPHAEL', 'ROUSSIN', 'Raphael.Roussin@etu.sorbonne-universite.fr', '0102030405', 28712022, '2000-09-01 00:00:00', 1, 1, 2),
(30, 'MOHAMED-ZAKARIA', 'ZEROUALI', 'mohamed-zakaria.zerouali@etu.sorbonne-univers', '0102030405', 3802522, '2000-09-01 00:00:00', 1, 1, 2),
(31, 'MELISSA', 'AMIRAT', 'melissa.amirat@etu.sorbonne-universite.fr', '0102030405', 3700251, '2000-09-01 00:00:00', 2, 1, 2),
(32, 'WALID', 'BEN AOUN', 'Walid.Ben_Aoun@etu.sorbonne-universite.fr', '0102030405', 28712445, '2000-09-01 00:00:00', 1, 1, 2),
(33, 'MARY', 'TALL', 'Mary.Tall@etu.sorbonne-universite.fr', '0102030405', 28716861, '2000-09-01 00:00:00', 2, 1, 2),
(34, 'SOFIANE', 'KHARROUGA', 'sofiane.kharrouga@etu.sorbonne-universite.fr', '0102030405', 3802256, '2000-09-01 00:00:00', 1, 1, 2),
(35, 'KEVIN', 'LEONARDO ALVES', 'Kevin.Leonardo_Alves@etu.sorbonne-universite.', '0102030405', 28713573, '2000-09-01 00:00:00', 1, 1, 2),
(36, 'MARK-LEWIS', 'SOPPO LOVET', 'mark-lewis.soppo_lovet@etu.sorbonne-universit', '0102030405', 3802216, '2000-09-01 00:00:00', 1, 1, 2),
(37, 'OUSSAMA', 'TEGOUANA', 'Oussama.Tegouana@etu.sorbonne-universite.fr', '0102030405', 28712265, '2000-09-01 00:00:00', 1, 1, 2),
(38, 'AMEL', 'ZALIF', 'amel.zalif@etu.sorbonne-universite.fr', '0102030405', 3801863, '2000-09-01 00:00:00', 2, 1, 2);

-- --------------------------------------------------------

--
-- Structure de la table `personne_has_groupe`
--

DROP TABLE IF EXISTS `personne_has_groupe`;
CREATE TABLE IF NOT EXISTS `personne_has_groupe` (
  `personne_idpersonne` int(11) NOT NULL,
  `groupe_idgroupe` int(11) NOT NULL,
  PRIMARY KEY (`personne_idpersonne`,`groupe_idgroupe`),
  KEY `fk_personne_has_groupe_groupe1_idx` (`groupe_idgroupe`),
  KEY `fk_personne_has_groupe_personne1_idx` (`personne_idpersonne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `personne_has_groupe`
--

INSERT INTO `personne_has_groupe` (`personne_idpersonne`, `groupe_idgroupe`) VALUES
(4, 26),
(5, 26),
(7, 26),
(8, 26),
(9, 26),
(10, 26),
(11, 26),
(12, 26),
(18, 26),
(19, 26),
(21, 26),
(12, 27),
(13, 27),
(14, 27),
(15, 27),
(16, 27),
(17, 27),
(20, 27),
(22, 27),
(23, 27);

-- --------------------------------------------------------

--
-- Structure de la table `promo`
--

DROP TABLE IF EXISTS `promo`;
CREATE TABLE IF NOT EXISTS `promo` (
  `idpromo` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `date_ouverture` datetime NOT NULL,
  `date_fermeture` datetime NOT NULL,
  PRIMARY KEY (`idpromo`),
  UNIQUE KEY `idpromo_UNIQUE` (`idpromo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `promo`
--

INSERT INTO `promo` (`idpromo`, `nom`, `date_ouverture`, `date_fermeture`) VALUES
(1, 'PROMOINGE_II_SEPT_2021', '2021-09-01 00:00:00', '2022-09-30 00:00:00'),
(2, 'PROMOINGE_HF_SEPT_2021', '2021-09-01 00:00:00', '2022-09-30 00:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `tm_cable`
--

DROP TABLE IF EXISTS `tm_cable`;
CREATE TABLE IF NOT EXISTS `tm_cable` (
  `idtm_cable` int(11) NOT NULL AUTO_INCREMENT,
  `instance_materiel_idinstance_materiel` int(11) NOT NULL,
  `longueur` varchar(45) NOT NULL,
  PRIMARY KEY (`idtm_cable`),
  UNIQUE KEY `idtm_cable_UNIQUE` (`idtm_cable`),
  KEY `fk_tm_cable_instance_materiel1_idx` (`instance_materiel_idinstance_materiel`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `tm_cable`
--

INSERT INTO `tm_cable` (`idtm_cable`, `instance_materiel_idinstance_materiel`, `longueur`) VALUES
(2, 17, '150 cm'),
(3, 18, '250 cm'),
(4, 19, '250 cm'),
(5, 20, '150 cm'),
(6, 21, '250 cm'),
(7, 22, '150 cm'),
(8, 23, '250 cm'),
(9, 24, '150 cm'),
(10, 17, '150 cm'),
(11, 18, '250 cm'),
(12, 19, '250 cm'),
(13, 20, '150 cm'),
(14, 21, '250 cm'),
(15, 22, '150 cm'),
(16, 23, '250 cm'),
(17, 24, '150 cm');

-- --------------------------------------------------------

--
-- Structure de la table `tm_raspberry`
--

DROP TABLE IF EXISTS `tm_raspberry`;
CREATE TABLE IF NOT EXISTS `tm_raspberry` (
  `idtm_raspberry` int(11) NOT NULL AUTO_INCREMENT,
  `instance_materiel_idinstance_materiel` int(11) NOT NULL,
  `addr_mac` varchar(45) NOT NULL,
  `addr_ip` varchar(45) NOT NULL,
  PRIMARY KEY (`idtm_raspberry`),
  UNIQUE KEY `idtm_raspberry_UNIQUE` (`idtm_raspberry`),
  KEY `fk_tm_raspberry_instance_materiel1_idx` (`instance_materiel_idinstance_materiel`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `tm_raspberry`
--

INSERT INTO `tm_raspberry` (`idtm_raspberry`, `instance_materiel_idinstance_materiel`, `addr_mac`, `addr_ip`) VALUES
(1, 1, 'aa:bb:cc:dd:ee:01', '132.154.0.1'),
(2, 2, 'aa:bb:cc:dd:ee:02', '132.154.0.2'),
(3, 3, 'aa:bb:cc:dd:ee:03', '132.154.0.3'),
(4, 4, 'aa:bb:cc:dd:ee:04', '132.154.0.4'),
(5, 5, 'aa:bb:cc:dd:ee:05', '132.154.0.5'),
(6, 6, 'aa:bb:cc:dd:ee:06', '132.154.0.6'),
(7, 7, 'aa:bb:cc:dd:ee:07', '132.154.0.7'),
(8, 8, 'aa:bb:cc:dd:ee:08', '132.154.0.8');

-- --------------------------------------------------------

--
-- Structure de la table `tm_souris`
--

DROP TABLE IF EXISTS `tm_souris`;
CREATE TABLE IF NOT EXISTS `tm_souris` (
  `idtm_souris` int(11) NOT NULL AUTO_INCREMENT,
  `instance_materiel_idinstance_materiel` int(11) NOT NULL,
  `marque` varchar(45) NOT NULL,
  PRIMARY KEY (`idtm_souris`),
  UNIQUE KEY `idtm_souris_UNIQUE` (`idtm_souris`),
  KEY `fk_tm_souris_instance_materiel1_idx` (`instance_materiel_idinstance_materiel`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `tm_souris`
--

INSERT INTO `tm_souris` (`idtm_souris`, `instance_materiel_idinstance_materiel`, `marque`) VALUES
(1, 9, 'microsoft'),
(2, 10, 'microsoft'),
(3, 11, 'microsoft'),
(4, 12, 'microsoft'),
(5, 13, 'logitech'),
(6, 14, 'dell'),
(7, 15, 'logitech'),
(8, 16, 'dell');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `emprunt`
--
ALTER TABLE `emprunt`
  ADD CONSTRAINT `fk_emprunt_instance_materiel1` FOREIGN KEY (`instance_materiel_idinstance_materiel`) REFERENCES `instance_materiel` (`idinstance_materiel`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_emprunt_panier1` FOREIGN KEY (`panier_idpanier`) REFERENCES `panier` (`idpanier`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `instance_materiel`
--
ALTER TABLE `instance_materiel`
  ADD CONSTRAINT `fk_instance_materiel_instance_materiel1` FOREIGN KEY (`instance_materiel_idinstance_materiel`) REFERENCES `instance_materiel` (`idinstance_materiel`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_instance_materiel_materiel1` FOREIGN KEY (`materiel_idmateriel`) REFERENCES `materiel` (`idmateriel`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `panier`
--
ALTER TABLE `panier`
  ADD CONSTRAINT `fk_panier_personne1` FOREIGN KEY (`personne_idpersonne`) REFERENCES `personne` (`idpersonne`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `personne`
--
ALTER TABLE `personne`
  ADD CONSTRAINT `fk_personne_etat_personne` FOREIGN KEY (`etat_personne_idetat_personne`) REFERENCES `etat_personne` (`idetat_personne`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_personne_promo1` FOREIGN KEY (`promo_idpromo`) REFERENCES `promo` (`idpromo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `personne_has_groupe`
--
ALTER TABLE `personne_has_groupe`
  ADD CONSTRAINT `fk_personne_has_groupe_groupe1` FOREIGN KEY (`groupe_idgroupe`) REFERENCES `groupe` (`idgroupe`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_personne_has_groupe_personne1` FOREIGN KEY (`personne_idpersonne`) REFERENCES `personne` (`idpersonne`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `tm_cable`
--
ALTER TABLE `tm_cable`
  ADD CONSTRAINT `fk_tm_cable_instance_materiel1` FOREIGN KEY (`instance_materiel_idinstance_materiel`) REFERENCES `instance_materiel` (`idinstance_materiel`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `tm_raspberry`
--
ALTER TABLE `tm_raspberry`
  ADD CONSTRAINT `fk_tm_raspberry_instance_materiel1` FOREIGN KEY (`instance_materiel_idinstance_materiel`) REFERENCES `instance_materiel` (`idinstance_materiel`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `tm_souris`
--
ALTER TABLE `tm_souris`
  ADD CONSTRAINT `fk_tm_souris_instance_materiel1` FOREIGN KEY (`instance_materiel_idinstance_materiel`) REFERENCES `instance_materiel` (`idinstance_materiel`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
