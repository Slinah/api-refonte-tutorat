SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


DROP TABLE IF EXISTS `personne_preferences`;
CREATE TABLE IF NOT EXISTS `personne_preferences` (
  `id_personne` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `experience` int(11) NOT NULL,
  `curseur_id` int(11) NOT NULL,
  `theme_id` int(11) NOT NULL,
  KEY `Fk_PersonnePref` (`id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `personne_preferences`
    ADD CONSTRAINT `Fk_PersonnePref` FOREIGN KEY (`id_personne`) REFERENCES `personne` ON DELETE CASCADE ON UPDATE CASCADE;