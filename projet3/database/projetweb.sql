-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 12 jan. 2024 à 20:55
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `projetweb`
--

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

CREATE TABLE `admin` (
  `emailA` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `admin`
--

INSERT INTO `admin` (`emailA`) VALUES
('admin@email.com'),
('lacy@email.com');

-- --------------------------------------------------------

--
-- Structure de la table `clubs`
--

CREATE TABLE `clubs` (
  `idTheme` int(5) NOT NULL,
  `emailA` varchar(50) NOT NULL,
  `nom` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `clubs`
--

INSERT INTO `clubs` (`idTheme`, `emailA`, `nom`) VALUES
(1, 'admin@email.com', 'Anaruz'),
(2, 'admin@email.com', 'Ensak Events'),
(3, 'admin@email.com', 'Club Mecatronique'),
(4, 'admin@email.com', 'Enactus'),
(5, 'admin@email.com', 'Ensak Informatics Club'),
(6, 'admin@email.com', 'Ensak Chess');

-- --------------------------------------------------------

--
-- Structure de la table `contributeur`
--

CREATE TABLE `contributeur` (
  `emailC` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `contributeur`
--

INSERT INTO `contributeur` (`emailC`) VALUES
('contributeur@email.com'),
('lacy@email.com');

-- --------------------------------------------------------

--
-- Structure de la table `evenement`
--

CREATE TABLE `evenement` (
  `idEven` int(5) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `adresse` varchar(50) NOT NULL,
  `latitude` varchar(50) NOT NULL,
  `longitude` varchar(50) NOT NULL,
  `nbPlaces` int(6) NOT NULL,
  `dateDeb` date NOT NULL,
  `dateFin` date NOT NULL,
  `theme` int(5) NOT NULL,
  `emailContrib` varchar(50) NOT NULL,
  `event_img` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `evenement`
--

INSERT INTO `evenement` (`idEven`, `nom`, `description`, `adresse`, `latitude`, `longitude`, `nbPlaces`, `dateDeb`, `dateFin`, `theme`, `emailContrib`, `event_img`) VALUES
(1, 'Word Cleanup Day', 'Venez avec votre énergie ,votre enthousiasme et votre désir de faire une différence dans votre communauté et votre environnement.', 'Lac sidi Boughaba', '43.6', '3.8833', 1000, '2023-10-15', '2023-10-15', 1, 'contributeur@email.com', 'anaruz1.jpg'),
(17, 'Robocad Compitition', 'Nous sommes fiers d\'annoncer la nouvelle édition de notre compitition  placée sous le théme captivant de la livraison urbaine.', 'Ecole National Des Sciences Appliquee', '', '', 30, '2023-12-07', '2023-12-11', 3, 'contributeur@email.com', 'mecatronique.jpg'),
(19, 'Soirée', 'Préparez-vous à vivre une nuit inoubliable pleine de musique entraînante, de rires contagieux et de moments mémorables! ', 'Dar Abla Kenitra', '', '', 120, '2024-05-12', '2024-05-12', 2, 'contributeur@email.com', 'ensakevents.jpg'),
(20, 'Caravane Humanitaire', 'Ce village est souvent isolé notre objectif est d\'apporter l\'aide a ces habitants.', 'Douar Al Bacha-Aglmous-Khenifra', '', '', 55, '0000-00-00', '2024-03-22', 1, 'contributeur@email.com', 'caravane.jpg'),
(21, 'Halloween Movie night', 'Enactus ENSAK devient plus fort que jamais et revient avec une soirée cinématique.', 'Amphi rouge ENSAK', '', '', 100, '2024-02-12', '2024-02-12', 4, 'contributeur@email.com', 'enactus.jpg'),
(22, 'Chess tournament', 'This is your chance to show off your skills in a fun competition against other talented players.', 'Amphi Rouge ENSAK', '', '', 30, '2024-02-12', '2024-02-16', 6, 'contributeur@email.com', 'chess.jpg');

--
-- Déclencheurs `evenement`
--
DELIMITER $$
CREATE TRIGGER `ATTENTION_NBPLACE` BEFORE INSERT ON `evenement` FOR EACH ROW BEGIN 
IF NEW.nbPlaces<=0 THEN
    INSERT INTO LOGERROR(MESSAGE) VALUES (CONCAT("ATTENTION, LE NOMBRE DE PLACES DOIT ETRE SUPERIEUR A 0"));
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LE NOMBRE DE PLACES DOIT ËTRE SUPERIEUR A 0';
END IF; 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `logerror`
--

CREATE TABLE `logerror` (
  `ID` int(11) NOT NULL,
  `MESSAGE` varchar(255) DEFAULT NULL,
  `THETIME` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `note`
--

CREATE TABLE `note` (
  `emailP` varchar(50) NOT NULL,
  `idEv` int(5) NOT NULL,
  `note` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `note`
--

INSERT INTO `note` (`emailP`, `idEv`, `note`) VALUES
('contributeur@email.com', 1, 5);

--
-- Déclencheurs `note`
--
DELIMITER $$
CREATE TRIGGER `ATTENTION_PARTICIPATION_NOTE` AFTER INSERT ON `note` FOR EACH ROW BEGIN

DECLARE c INT;

SELECT COUNT(*)
INTO c
FROM participe p
WHERE NEW.emailP = p.emailPers
AND NEW.idEv = p.idEven ;

IF c = 0 THEN
      INSERT INTO LOGERROR(MESSAGE) VALUES (CONCAT("ATTENTION, PAS DE PARTICIPATION A L EVEN"));
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ATTENTION, PAS DE PARTICIPATION A L EVEN';
      END IF ;
      END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `participe`
--

CREATE TABLE `participe` (
  `emailPers` varchar(50) NOT NULL,
  `idEven` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `participe`
--

INSERT INTO `participe` (`emailPers`, `idEven`) VALUES
('admin@email.com', 20),
('contributeur@email.com', 1),
('contributeur@email.com', 19),
('lacy@email.com', 1);

-- --------------------------------------------------------

--
-- Structure de la table `personne`
--

CREATE TABLE `personne` (
  `email` varchar(30) NOT NULL,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(30) NOT NULL,
  `pseudo` varchar(30) NOT NULL,
  `mdp` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `personne`
--

INSERT INTO `personne` (`email`, `nom`, `prenom`, `pseudo`, `mdp`) VALUES
('admin@email.com', 'admin', 'admin', 'admin', '098f6bcd4621d373cade4e832627b4f6'),
('contributeur@email.com', 'contributeur', 'contributeur', 'cont', '098f6bcd4621d373cade4e832627b4f6'),
('lacy1@email.com', 'smith', 'lacy', 'lacy', '098f6bcd4621d373cade4e832627b4f6'),
('lacy2@email.com', 'smith', 'lacy', 'lacy', '098f6bcd4621d373cade4e832627b4f6'),
('lacy3@email.com', 'smith', 'lacy', 'lacy', '098f6bcd4621d373cade4e832627b4f6'),
('lacy@email.com', 'smith', 'lacy', 'lacy', '098f6bcd4621d373cade4e832627b4f6'),
('lays@email.com', 'ch', 'lays', 'lays', '098f6bcd4621d373cade4e832627b4f6'),
('mohcineelhasnaoui@gmail.com', 'el hasnaoui', 'mouhcine', 'mouhcine', '01fc02b3f4b555a6a34af988a477c0c7'),
('none@email.com', 'none', 'none', 'nono', '098f6bcd4621d373cade4e832627b4f6'),
('popo@pepe.com', 'pepe', 'popo', 'pope', '098f6bcd4621d373cade4e832627b4f6'),
('prenom@nom.com', 'nom', 'prenom', 'pren', '098f6bcd4621d373cade4e832627b4f6');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`emailA`);

--
-- Index pour la table `clubs`
--
ALTER TABLE `clubs`
  ADD PRIMARY KEY (`idTheme`),
  ADD KEY `FK_THEME_ADMIN` (`emailA`);

--
-- Index pour la table `contributeur`
--
ALTER TABLE `contributeur`
  ADD PRIMARY KEY (`emailC`);

--
-- Index pour la table `evenement`
--
ALTER TABLE `evenement`
  ADD PRIMARY KEY (`idEven`),
  ADD KEY `FK_EVEN_THEME` (`theme`),
  ADD KEY `FK_EVEN_CONTRIB` (`emailContrib`);

--
-- Index pour la table `logerror`
--
ALTER TABLE `logerror`
  ADD PRIMARY KEY (`ID`);

--
-- Index pour la table `note`
--
ALTER TABLE `note`
  ADD PRIMARY KEY (`emailP`,`idEv`),
  ADD KEY `FK_NOTE_EVEN` (`idEv`);

--
-- Index pour la table `participe`
--
ALTER TABLE `participe`
  ADD PRIMARY KEY (`emailPers`,`idEven`),
  ADD KEY `FK_EVEN_PARTICIPE` (`idEven`);

--
-- Index pour la table `personne`
--
ALTER TABLE `personne`
  ADD PRIMARY KEY (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `clubs`
--
ALTER TABLE `clubs`
  MODIFY `idTheme` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `evenement`
--
ALTER TABLE `evenement`
  MODIFY `idEven` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT pour la table `logerror`
--
ALTER TABLE `logerror`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `FK_PERS_ADMIN` FOREIGN KEY (`emailA`) REFERENCES `personne` (`email`);

--
-- Contraintes pour la table `clubs`
--
ALTER TABLE `clubs`
  ADD CONSTRAINT `FK_THEME_ADMIN` FOREIGN KEY (`emailA`) REFERENCES `admin` (`emailA`);

--
-- Contraintes pour la table `contributeur`
--
ALTER TABLE `contributeur`
  ADD CONSTRAINT `FK_PERS_CONTRIB` FOREIGN KEY (`emailC`) REFERENCES `personne` (`email`);

--
-- Contraintes pour la table `evenement`
--
ALTER TABLE `evenement`
  ADD CONSTRAINT `FK_EVEN_CONTRIB` FOREIGN KEY (`emailContrib`) REFERENCES `contributeur` (`emailC`),
  ADD CONSTRAINT `FK_EVEN_THEME` FOREIGN KEY (`theme`) REFERENCES `clubs` (`idTheme`);

--
-- Contraintes pour la table `note`
--
ALTER TABLE `note`
  ADD CONSTRAINT `FK_NOTE_EVEN` FOREIGN KEY (`idEv`) REFERENCES `evenement` (`idEven`),
  ADD CONSTRAINT `FK_NOTE_PERSONNE` FOREIGN KEY (`emailP`) REFERENCES `personne` (`email`);

--
-- Contraintes pour la table `participe`
--
ALTER TABLE `participe`
  ADD CONSTRAINT `FK_EVEN_PARTICIPE` FOREIGN KEY (`idEven`) REFERENCES `evenement` (`idEven`),
  ADD CONSTRAINT `FK_PERS_PARTICIPE` FOREIGN KEY (`emailPers`) REFERENCES `personne` (`email`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
