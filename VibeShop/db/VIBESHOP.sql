-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: vibeshop
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `vibeshop`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `vibeshop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `vibeshop`;

--
-- Table structure for table `artista`
--

DROP TABLE IF EXISTS `artista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artista` (
  `id_artista` int NOT NULL AUTO_INCREMENT,
  `nome_d_arte` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paese` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `biografia` text COLLATE utf8mb4_unicode_ci,
  `genere` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_artista`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artista`
--

LOCK TABLES `artista` WRITE;
/*!40000 ALTER TABLE `artista` DISABLE KEYS */;
INSERT INTO `artista` VALUES (1,'Dua Lipa','USA','Cantante americano','pop',NULL),(2,'Enrico Inglesias','Italia','Cantante italiano','pop',NULL),(3,'Julio Peluso','Italia','Nuovo cantante','rock',NULL),(4,'Denis Komarov','Russia','Hard-rap russo','rap',NULL),(5,'Lugia Kapronova','Italia','Nata in Spagnia','opera',NULL),(6,'Albano','Italia','Molto populare cantante italiano','pop',NULL),(7,'Zucchero','Italia','Pop-rock italiano e inglese','rock',NULL),(8,'Alessandro Safina','Italia','Crossover italiano','opera',NULL),(9,'Rome','Cosovo','Cantante italiano','opera',NULL),(10,'Plasido Domingo','Spagnia','Nasce in Spagnia','opera',NULL),(11,'Adriano Celentano','Italia','Più famoso come attore e cantante','pop',NULL),(12,'Eminem','USA','Rap molto populare','rap',NULL),(13,'Rag\'n\'Bone Man','England','Cantante inglese','pop',NULL),(14,'Sfera Ebbasta','Italia','Cantante italiano','rap',NULL),(15,'Tony Effe','Italia','Cantante italiano','rap',NULL),(16,'Lazza','Italia','Cantante italiano','rap',NULL),(17,'Artie 5ive','Italia','Cantante italiano','rap',NULL),(18,'Capo Plaza','Italia','Cantante italiano','rap',NULL),(19,'Anna Pepe','Italia','Cantante italiano','rap',NULL),(20,'Shiva','Italia','Cantante italiano','rap',NULL),(21,'Guè','Italia','Cantante italiano','rap',NULL),(22,'Billie Eilish','USA','Cantante e compositrice statunitense','pop',NULL),(23,'Mot','Fed. Russia',NULL,NULL,NULL),(24,'SCIRENA','Russia','Nel 2024 ha pubblicato una collaborazione con l\'artista Vector A, \"Themes\", che ha subito riscosso successo tra gli ascoltatori','pop',NULL),(25,'Pyrokinesis','Russia','Cantante e scrittore russo','rap',NULL),(26,'Three days of rain','Russia','Rock-alternativo. Il band che è diventato molto famoso grazie alla Spotify','rock',NULL);
/*!40000 ALTER TABLE `artista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concerto`
--

DROP TABLE IF EXISTS `concerto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concerto` (
  `id_concerto` int NOT NULL AUTO_INCREMENT,
  `data_ora` datetime DEFAULT NULL,
  `titolo_evento` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prezzo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `iva` decimal(5,2) NOT NULL DEFAULT '10.00',
  `id_artista` int DEFAULT NULL,
  `luogo_indirizzo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event_manager` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_concerto`),
  KEY `idx_concerto_artista` (`id_artista`),
  KEY `idx_concerto_data` (`data_ora`),
  CONSTRAINT `fk_concerto_artista` FOREIGN KEY (`id_artista`) REFERENCES `artista` (`id_artista`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concerto`
--

LOCK TABLES `concerto` WRITE;
/*!40000 ALTER TABLE `concerto` DISABLE KEYS */;
INSERT INTO `concerto` VALUES (1,'2026-04-11 00:00:00','Festa di Pasqua',51.98,10.00,2,'Salerno, via Marconi, 72, 41320','Omer Simfson'),(2,'2026-04-17 00:00:00','Festa di Papa',46.29,10.00,8,'Napoli, via Berlusconi, 32, 56045','Michele Bianco'),(3,'2026-04-23 00:00:00','Festa per 25-anni',28.59,10.00,19,'Roma, via Vasco Da Gamma, 9, 32110','Julio Peluso'),(4,'2026-04-26 00:00:00','Festa 18+',21.99,10.00,4,'Milano, via Fasci, 14, 50023','Gulia Kosakova'),(7,'2026-04-20 00:00:00','MoscowHole',78.99,10.00,6,'Moscow, via Zapovednaya, 56, 19073','Galina Fedunkina'),(8,'2026-04-01 00:00:00','ConcertoShansonEstrada',56.00,10.00,6,'Kirov, vico Lampoo, 34, 12358','Massimo Ripeno'),(9,'2026-04-28 00:00:00','sa',55.00,10.00,5,NULL,NULL);
/*!40000 ALTER TABLE `concerto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dettaglio_ordine`
--

DROP TABLE IF EXISTS `dettaglio_ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dettaglio_ordine` (
  `id_dettaglio` int NOT NULL AUTO_INCREMENT,
  `id_ordine` int NOT NULL,
  `id_prodotto` int DEFAULT NULL,
  `id_concerto` int DEFAULT NULL,
  `quantita_prodotto` int NOT NULL DEFAULT '0',
  `quantita_biglietti` int NOT NULL DEFAULT '0',
  `prezzo_totale` decimal(10,2) NOT NULL DEFAULT '0.00',
  `item_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `item_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Elemento rimosso',
  `unit_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `iva` decimal(5,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id_dettaglio`),
  KEY `idx_dettaglio_ordine` (`id_ordine`),
  KEY `idx_dettaglio_prodotto` (`id_prodotto`),
  KEY `idx_dettaglio_concerto` (`id_concerto`),
  KEY `idx_dettaglio_item_type` (`item_type`),
  CONSTRAINT `fk_dettaglio_concerto` FOREIGN KEY (`id_concerto`) REFERENCES `concerto` (`id_concerto`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_dettaglio_ordine` FOREIGN KEY (`id_ordine`) REFERENCES `ordine` (`id_ordine`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_dettaglio_prodotto` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id_prodotto`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `chk_dettaglio_item_type` CHECK ((`item_type` in (_utf8mb4'PRODOTTO',_utf8mb4'CONCERTO',_utf8mb4'UNKNOWN')))
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dettaglio_ordine`
--

LOCK TABLES `dettaglio_ordine` WRITE;
/*!40000 ALTER TABLE `dettaglio_ordine` DISABLE KEYS */;
INSERT INTO `dettaglio_ordine` VALUES (1,1,2,NULL,1,0,56.49,'PRODOTTO','Maglia EI',56.49,22.00),(2,1,NULL,3,0,2,57.18,'CONCERTO','Festa per 25-anni',28.59,10.00),(3,2,3,NULL,3,0,17.97,'PRODOTTO','Pallone DK',5.99,22.00),(4,2,12,NULL,1,0,71.99,'PRODOTTO','Disco',71.99,22.00),(5,2,NULL,4,0,4,87.96,'CONCERTO','Festa 18+',21.99,10.00),(6,3,2,NULL,1,0,56.49,'PRODOTTO','Maglia EI',56.49,22.00),(7,3,NULL,8,0,3,168.00,'CONCERTO','ConcertoShansonEstrada',56.00,10.00),(8,3,NULL,1,0,7,363.86,'CONCERTO','Festa di Pasqua',51.98,10.00),(9,6,9,NULL,2,0,65.12,'PRODOTTO','Capellino blue AC',32.56,22.00),(10,7,7,NULL,2,0,31.98,'PRODOTTO','Pena AL',15.99,22.00),(11,7,13,NULL,2,0,68.68,'PRODOTTO','Disco',34.34,22.00),(12,7,5,NULL,1,0,64.99,'PRODOTTO','Longsliv LU',64.99,22.00),(13,7,6,NULL,1,0,79.99,'PRODOTTO','Occhiali DK',79.99,22.00),(14,8,15,NULL,1,0,39.99,'PRODOTTO','Disco2',39.99,22.00),(15,8,12,NULL,1,0,71.99,'PRODOTTO','Disco',71.99,22.00),(16,9,1,NULL,1,0,44.99,'PRODOTTO','Scarpa JP',44.99,22.00),(17,9,11,NULL,1,0,79.89,'PRODOTTO','Disco',79.89,22.00),(18,11,4,NULL,3,0,98.97,'PRODOTTO','Felpa nera JP',32.99,22.00),(19,11,NULL,NULL,1,0,87.99,'UNKNOWN','Elemento rimosso',87.99,0.00),(20,11,NULL,7,0,3,236.97,'CONCERTO','MoscowHole',78.99,10.00),(21,12,15,NULL,4,0,159.96,'PRODOTTO','Disco2',39.99,22.00);
/*!40000 ALTER TABLE `dettaglio_ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordine`
--

DROP TABLE IF EXISTS `ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordine` (
  `id_ordine` int NOT NULL AUTO_INCREMENT,
  `data_ordine` date DEFAULT NULL,
  `id_utente` int DEFAULT NULL,
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `tipo_pagamento` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stato_ordine` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CONFERMATO',
  `indirizzo_spedizione` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_ordine`),
  KEY `idx_ordine_utente` (`id_utente`),
  KEY `idx_ordine_data` (`data_ordine`),
  KEY `idx_ordine_stato` (`stato_ordine`),
  CONSTRAINT `fk_ordine_utente` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `chk_ordine_stato` CHECK ((`stato_ordine` in (_utf8mb4'CONFERMATO',_utf8mb4'ANNULLATO',_utf8mb4'IN_ELABORAZIONE')))
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordine`
--

LOCK TABLES `ordine` WRITE;
/*!40000 ALTER TABLE `ordine` DISABLE KEYS */;
INSERT INTO `ordine` VALUES (1,'2026-04-10',3,113.67,'visa','CONFERMATO','Via Pakalavra, 21, SA, 92640'),(2,'2026-04-08',1,177.92,'mastercard','CONFERMATO','Via Mariscole, 96, NA, 15032'),(3,'2026-04-09',2,588.35,'american express','CONFERMATO','Via BlaBlaBla, 13, MI, 93084'),(6,'2026-03-31',7,65.12,'visa','CONFERMATO','Via Rinaldi, 15, NA, 80123'),(7,'2026-04-23',2,245.64,'maestro','CONFERMATO','Via Domicilio, 23, NA, 80323'),(8,'2026-04-24',1,111.98,'mastercard','CONFERMATO','-prodotto digitale-'),(9,'2026-04-25',4,124.88,'visa','CONFERMATO','Via Zapovednaya, 196, MI, 16041'),(10,'2026-04-28',7,0.00,'visa','CONFERMATO',NULL),(11,'2026-04-30',8,423.93,'visa','CONFERMATO','Via Giuseppe Rendano, 23, VE, 49078'),(12,'2026-04-26',7,159.96,'visa','CONFERMATO','-prodotto digitale-'),(13,'2026-04-08',3,0.00,'maestro','CONFERMATO',NULL);
/*!40000 ALTER TABLE `ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotto`
--

DROP TABLE IF EXISTS `prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotto` (
  `id_prodotto` int NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_artista` int DEFAULT NULL,
  `prezzo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `iva` decimal(5,2) NOT NULL DEFAULT '22.00',
  `descrizione` text COLLATE utf8mb4_unicode_ci,
  `immagine` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_prodotto`),
  KEY `idx_prodotto_artista` (`id_artista`),
  KEY `idx_prodotto_active` (`active`),
  CONSTRAINT `fk_prodotto_artista` FOREIGN KEY (`id_artista`) REFERENCES `artista` (`id_artista`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotto`
--

LOCK TABLES `prodotto` WRITE;
/*!40000 ALTER TABLE `prodotto` DISABLE KEYS */;
INSERT INTO `prodotto` VALUES (1,1,'Scarpa JP',3,45.00,22.00,'Scarpa di Julio',NULL),(2,1,'Maglia EI',2,56.49,22.00,'Bianca Maglia',NULL),(3,1,'Pallone DK',4,5.00,22.00,'Pallone Volley DK',NULL),(4,1,'Felpa nera JP',3,32.99,22.00,'Hoodie nera / bianca',NULL),(5,1,'Longsliv LU',5,64.99,22.00,'Longsliv nera / bianca / blue',NULL),(6,1,'Occhiali DK',4,80.00,22.00,'Occhiali anti-sole',NULL),(7,1,'Pena AL',6,15.99,22.00,'Pena blue per regalo',NULL),(9,1,'Capellino blue AC',11,32.56,22.00,'Capellino blue con sigla di Adriano',NULL),(11,1,'Disco',14,0.00,22.00,NULL,NULL),(12,1,'Disco',9,0.00,22.00,NULL,NULL),(13,1,'Disco',16,100.00,22.00,'Sirio',NULL),(14,1,'Disco',17,0.00,22.00,NULL,NULL),(15,1,'Disco2',18,130.00,22.00,NULL,NULL),(16,1,'Disco',NULL,0.00,22.00,NULL,NULL),(17,1,'sasaasa',NULL,0.00,22.00,NULL,NULL),(18,1,'Disco',20,200.00,22.00,'Santana Money Gang',NULL),(19,1,'Disco',21,150.00,22.00,'Sinatra',NULL),(20,1,'Billiy\'s T-Shirt',22,0.00,22.00,NULL,NULL),(21,1,'TouerBlack T-Shirt',25,0.00,22.00,NULL,NULL),(22,1,'KITTEN RA T-Shirt',25,0.00,22.00,'Oversize maglia cottone',NULL),(23,1,'Justice Plat',25,0.00,22.00,NULL,NULL),(24,1,'JusticeZip Hoodie',25,124.49,22.00,'Felpa oversize con zip nera con disegnio',NULL),(25,1,'DeusMortis Longsliv',25,96.17,22.00,'Longsliv bianca oversize con disegnio oro',NULL),(26,1,'Melancholia Hoodie',26,72.38,22.00,'Felpa nera con print mani nel fuoco',NULL),(27,1,'Melancholia Umbrella',26,0.00,22.00,NULL,NULL),(28,1,'ThrousersGardenDayBlack',26,0.00,22.00,NULL,NULL),(29,1,'Melancholia Cap',26,0.00,22.00,'Cappellino',NULL),(30,1,'Melancholia Back',26,22.54,22.00,'Borsa con manici lunghi nera con print',NULL),(31,1,'DaysOFRain Hoodie',26,96.17,22.00,'Felpa nera con print da due parti e con testo di album',NULL);
/*!40000 ALTER TABLE `prodotto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utente`
--

DROP TABLE IF EXISTS `utente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utente` (
  `id_utente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cognome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CLIENTE',
  `cellulare` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` char(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_utente`),
  UNIQUE KEY `uk_utente_email` (`email`),
  KEY `idx_utente_role` (`role`),
  CONSTRAINT `chk_utente_role` CHECK ((`role` in (_utf8mb4'CLIENTE',_utf8mb4'ADMIN')))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utente`
--

LOCK TABLES `utente` WRITE;
/*!40000 ALTER TABLE `utente` DISABLE KEYS */;
INSERT INTO `utente` VALUES (1,'Dionigi','Credo','d7k@gmail.com','CLIENTE','3509237775','16e643566cf8edb89eead00c548dcd0f6de9fbebfc3f6c728b9448c5ad122740'),(2,'Julio','Peluso','juliope@gmail.com','CLIENTE','3504494857','254be3f6e54fcd27938930b0feae84082d17d49590226fb61aa964f9e35c7c29'),(3,'Mark','Haraceko','saas@gmail.com','CLIENTE','9204467777','ab9bc400a494cf0b6202e4a1dc9f82881b4adc6ce2065e5bd9c9f8672e2da9a5'),(4,'Kirill','Nahimov','kiha@gmail.com','CLIENTE','6235574438','78393b978f88f4a1454c261ead6f0e8950fd3de6d135c3a2bd2a75f0a4132717'),(6,'Denis','Komarov','dka7best@gmail.com','ADMIN','3509237775','16e643566cf8edb89eead00c548dcd0f6de9fbebfc3f6c728b9448c5ad122740'),(7,'Michelle','Klevitskaya','m.klinfo@gmail.com','CLIENTE','alina552','893f463d074ab96adb0bf64302267d0ce17494b88bc9891e2140ce23d5281655'),(8,'Uliana','Kovalkova','u.kovalchuk@gmail.com','CLIENTE','9001231142','6259111af0dbb68d57508f3f0142e51d035f6d6485ad9a8360932f5afd4c8d88');
/*!40000 ALTER TABLE `utente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'vibeshop'
--

--
-- Dumping routines for database 'vibeshop'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-19 14:39:02
