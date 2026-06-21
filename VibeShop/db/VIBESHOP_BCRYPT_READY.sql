-- VibeShop bcrypt-ready schema and clean demo seed data.
-- Use this file for a fresh final demo import instead of the legacy dump.

CREATE DATABASE IF NOT EXISTS `vibeshop`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `vibeshop`;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `dettaglio_ordine`;
DROP TABLE IF EXISTS `ordine`;
DROP TABLE IF EXISTS `prodotto`;
DROP TABLE IF EXISTS `concerto`;
DROP TABLE IF EXISTS `artista`;
DROP TABLE IF EXISTS `utente`;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `artista` (
  `id_artista` int NOT NULL AUTO_INCREMENT,
  `nome_d_arte` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paese` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `biografia` text COLLATE utf8mb4_unicode_ci,
  `genere` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_artista`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `utente` (
  `id_utente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cognome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CLIENTE',
  `cellulare` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_utente`),
  UNIQUE KEY `uk_utente_email` (`email`),
  KEY `idx_utente_role` (`role`),
  CONSTRAINT `chk_utente_role` CHECK (`role` IN ('CLIENTE','ADMIN'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  CONSTRAINT `chk_ordine_stato` CHECK (`stato_ordine` IN ('CONFERMATO','ANNULLATO','IN_ELABORAZIONE'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `dettaglio_ordine` (
  `id_dettaglio` int NOT NULL AUTO_INCREMENT,
  `id_ordine` int NOT NULL,
  `id_prodotto` int DEFAULT NULL,
  `id_concerto` int DEFAULT NULL,
  `quantita_prodotto` int DEFAULT NULL,
  `quantita_biglietti` int DEFAULT NULL,
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
  CONSTRAINT `fk_dettaglio_ordine` FOREIGN KEY (`id_ordine`) REFERENCES `ordine` (`id_ordine`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_dettaglio_prodotto` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id_prodotto`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_dettaglio_concerto` FOREIGN KEY (`id_concerto`) REFERENCES `concerto` (`id_concerto`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `chk_dettaglio_item_type` CHECK (`item_type` IN ('PRODOTTO','CONCERTO','UNKNOWN'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `artista` (`id_artista`, `nome_d_arte`, `paese`, `biografia`, `genere`, `foto`) VALUES
(1,'Dua Lipa','Regno Unito','Artista pop internazionale.', 'pop', NULL),
(2,'Zucchero','Italia','Cantautore italiano pop-rock.', 'rock', NULL),
(3,'Eminem','USA','Rapper e produttore statunitense.', 'rap', NULL),
(4,'Billie Eilish','USA','Cantante e compositrice statunitense.', 'pop', NULL),
(5,'Lazza','Italia','Artista rap italiano.', 'rap', NULL),
(6,'Three Days of Rain','Russia','Band rock-alternativa.', 'rock', NULL);

INSERT INTO `concerto` (`id_concerto`, `data_ora`, `titolo_evento`, `prezzo`, `iva`, `id_artista`, `luogo_indirizzo`, `event_manager`) VALUES
(1,'2026-07-12 21:00:00','Dua Lipa Live Experience',69.90,10.00,1,'Milano, Mediolanum Forum','VibeShop Events'),
(2,'2026-08-03 20:30:00','Zucchero Summer Tour',54.90,10.00,2,'Napoli, Arena Flegrea','VibeShop Events'),
(3,'2026-09-15 21:00:00','Rap Night con Lazza',49.90,10.00,5,'Roma, Palazzo dello Sport','VibeShop Events'),
(4,'2026-10-05 20:00:00','Alternative Rock Session',39.90,10.00,6,'Salerno, Teatro Augusteo','VibeShop Events');

INSERT INTO `prodotto` (`id_prodotto`, `active`, `nome`, `id_artista`, `prezzo`, `iva`, `descrizione`, `immagine`) VALUES
(1,1,'T-shirt Tour Ufficiale',1,29.90,22.00,'T-shirt ufficiale in cotone.',NULL),
(2,1,'Felpa Logo VibeShop',NULL,59.90,22.00,'Felpa nera con logo VibeShop.',NULL),
(3,1,'Vinile Limited Edition',2,34.90,22.00,'Vinile da collezione in edizione limitata.',NULL),
(4,1,'Cappellino Artist Edition',5,24.90,22.00,'Cappellino regolabile con ricamo frontale.',NULL),
(5,1,'Poster Concerto',6,14.90,22.00,'Poster stampato su carta premium.',NULL),
(6,1,'Shopper VibeShop',NULL,12.90,22.00,'Borsa in tela per concerti e uso quotidiano.',NULL);

-- After import, create users through the registration page so password_hash is generated by bcrypt.
-- To make a registered account admin: UPDATE utente SET role = 'ADMIN' WHERE email = 'your-email@example.com';
