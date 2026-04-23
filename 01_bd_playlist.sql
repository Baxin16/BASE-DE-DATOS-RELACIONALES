-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.31 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para 01
CREATE DATABASE IF NOT EXISTS `01` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `01`;

-- Volcando estructura para tabla 01.t_artistas
DROP TABLE IF EXISTS `t_artistas`;
CREATE TABLE IF NOT EXISTS `t_artistas` (
  `id_artistas` int NOT NULL AUTO_INCREMENT,
  `nombre_artista` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_artistas`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla 01.t_artistas: 3 rows
/*!40000 ALTER TABLE `t_artistas` DISABLE KEYS */;
INSERT INTO `t_artistas` (`id_artistas`, `nombre_artista`) VALUES
	(1, 'Luis Fonsi'),
	(2, 'Danna Paola'),
	(3, 'Britney Spears');
/*!40000 ALTER TABLE `t_artistas` ENABLE KEYS */;

-- Volcando estructura para tabla 01.t_genero_cancion
DROP TABLE IF EXISTS `t_genero_cancion`;
CREATE TABLE IF NOT EXISTS `t_genero_cancion` (
  `id_gen` int NOT NULL AUTO_INCREMENT,
  `nombre_gen` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_gen`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla 01.t_genero_cancion: 6 rows
/*!40000 ALTER TABLE `t_genero_cancion` DISABLE KEYS */;
INSERT INTO `t_genero_cancion` (`id_gen`, `nombre_gen`) VALUES
	(1, 'Pop'),
	(2, 'Reggaeton'),
	(3, 'Electro'),
	(4, 'Metal'),
	(5, 'Baladas'),
	(6, 'K-Pop');
/*!40000 ALTER TABLE `t_genero_cancion` ENABLE KEYS */;

-- Volcando estructura para tabla 01.t_gen_artistas
DROP TABLE IF EXISTS `t_gen_artistas`;
CREATE TABLE IF NOT EXISTS `t_gen_artistas` (
  `id_gen_artistas` char(1) NOT NULL,
  `genero` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_gen_artistas`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla 01.t_gen_artistas: 3 rows
/*!40000 ALTER TABLE `t_gen_artistas` DISABLE KEYS */;
INSERT INTO `t_gen_artistas` (`id_gen_artistas`, `genero`) VALUES
	('H', 'Hombre'),
	('M', 'Mujer'),
	('B', 'Banda');
/*!40000 ALTER TABLE `t_gen_artistas` ENABLE KEYS */;

-- Volcando estructura para tabla 01.t_playlist
DROP TABLE IF EXISTS `t_playlist`;
CREATE TABLE IF NOT EXISTS `t_playlist` (
  `id_playlist` int NOT NULL AUTO_INCREMENT,
  `cancion` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `artista` int NOT NULL,
  `gen_cancion` int NOT NULL,
  `gen_artista` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_playlist`),
  KEY `FK_artista` (`artista`),
  KEY `FK_gen_cancion` (`gen_cancion`),
  KEY `FK_gen_artista` (`gen_artista`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla 01.t_playlist: 1 rows
/*!40000 ALTER TABLE `t_playlist` DISABLE KEYS */;
INSERT INTO `t_playlist` (`id_playlist`, `cancion`, `artista`, `gen_cancion`, `gen_artista`) VALUES
	(2, '', 0, 0, 'M');
/*!40000 ALTER TABLE `t_playlist` ENABLE KEYS */;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
