USE `vibeshop`;

-- Extra demo seed data for international artists, concerts and merch.
-- Run this script after VIBESHOP_FINAL.sql.

UPDATE `artista`
SET
  `paese` = 'Belgio',
  `biografia` = 'Cantante e produttore belga, noto per stile elettronico e testi profondi.',
  `genere` = 'pop'
WHERE `id_artista` = 29 OR `nome_d_arte` = 'Stromae';

INSERT INTO `artista` (`id_artista`, `nome_d_arte`, `paese`, `biografia`, `genere`, `foto`) VALUES
(37, 'Joe Lynn Turner', 'USA', 'Cantante rock, noto per la collaborazione con Rainbow e Deep Purple.', 'rock', NULL),
(38, 'Taylor Swift', 'USA', 'Cantante e cantautrice molto famosa.', 'pop', NULL),
(39, 'Drake', 'USA', 'Rapper e produttore molto influente.', 'rap', NULL),
(40, 'Ariana Grande', 'USA', 'Cantante pop con grande estensione vocale.', 'pop', NULL),
(41, 'Kanye West', 'USA', 'Rapper e produttore innovativo.', 'rap', NULL),
(42, 'Bruno Mars', 'USA', 'Cantante e performer con stile funk e pop.', 'pop', NULL),
(43, 'Rammstein', 'Germania', 'Band tedesca di industrial rock famosa a livello mondiale.', 'rock', NULL),
(44, 'Ed Sheeran', 'England', 'Cantautore inglese molto popolare.', 'pop', NULL),
(45, 'David Guetta', 'Francia', 'DJ e produttore francese, tra i piu influenti nella musica dance elettronica.', 'elettronica', NULL);

INSERT INTO `concerto` (`id_concerto`, `data_ora`, `titolo_evento`, `prezzo`, `iva`, `id_artista`, `luogo_indirizzo`, `event_manager`) VALUES
(37, '2027-01-18 21:00:00', 'Joe Lynn Turner Rock Legacy Night', 59.90, 10.00, 37, 'Milano, Alcatraz', 'VibeShop Events'),
(38, '2027-01-25 21:00:00', 'Taylor Swift Pop Stadium Experience', 119.90, 10.00, 38, 'Roma, Stadio Olimpico', 'International Live'),
(39, '2027-02-02 21:30:00', 'Drake Urban Night Milano', 99.90, 10.00, 39, 'Milano, Mediolanum Forum', 'Urban Stage'),
(40, '2027-02-09 21:00:00', 'Ariana Grande Vocal Pop Show', 104.90, 10.00, 40, 'Torino, Inalpi Arena', 'International Live'),
(41, '2027-02-16 22:00:00', 'Kanye West Vision Rap Experience', 109.90, 10.00, 41, 'Bologna, Unipol Arena', 'Urban Lab'),
(42, '2027-02-23 21:00:00', 'Bruno Mars Funk Pop Night', 94.90, 10.00, 42, 'Firenze, Nelson Mandela Forum', 'VibeShop Events'),
(43, '2027-03-03 21:30:00', 'Rammstein Industrial Rock Arena', 114.90, 10.00, 43, 'Verona, Arena di Verona', 'Rock Europa'),
(44, '2027-03-10 20:45:00', 'Ed Sheeran Acoustic Pop Live', 89.90, 10.00, 44, 'Napoli, Palapartenope', 'Acoustic Road'),
(45, '2027-03-17 22:30:00', 'David Guetta Electronic Dance Arena', 84.90, 10.00, 45, 'Rimini, Beach Arena', 'Electronic Stage'),
(46, '2027-03-24 21:00:00', 'Stromae Electronic Poetry Live', 76.90, 10.00, 29, 'Torino, OGR Torino', 'European Stage');

INSERT INTO `prodotto` (`id_prodotto`, `active`, `nome`, `id_artista`, `prezzo`, `iva`, `descrizione`, `immagine`) VALUES
(37, 1, 'Joe Lynn Turner Legacy Rock Tee', 37, 34.90, 22.00, 'T-shirt nera con grafica rock legacy e stampa tour.', NULL),
(38, 1, 'Joe Lynn Turner Tour Poster Deluxe', 37, 18.90, 22.00, 'Poster deluxe formato 50x70 con finitura opaca.', NULL),
(39, 1, 'Taylor Swift Pop Era Hoodie', 38, 79.90, 22.00, 'Felpa premium con grafica pop e dettagli rosa.', NULL),
(40, 1, 'Taylor Swift Fan Bracelet Set', 38, 24.90, 22.00, 'Set di braccialetti fan edition per concerti.', NULL),
(41, 1, 'Drake Urban Night Cap', 39, 29.90, 22.00, 'Cappellino streetwear regolabile con ricamo minimal.', NULL),
(42, 1, 'Drake Certified Tour Tee', 39, 38.90, 22.00, 'T-shirt urban con stampa frontale ad alto contrasto.', NULL),
(43, 1, 'Ariana Grande Vocal Pop Vinyl', 40, 42.90, 22.00, 'Vinile limited edition con packaging chiaro e booklet.', NULL),
(44, 1, 'Ariana Grande Cloud Tote Bag', 40, 26.90, 22.00, 'Borsa tote con grafica pop minimal e colori soft.', NULL),
(45, 1, 'Kanye West Vision Hoodie', 41, 82.90, 22.00, 'Felpa oversize con design minimal e taglio streetwear.', NULL),
(46, 1, 'Kanye West Studio Notebook', 41, 17.90, 22.00, 'Notebook da collezione ispirato alla produzione musicale.', NULL),
(47, 1, 'Bruno Mars Funk Tour Shirt', 42, 36.90, 22.00, 'Camicia leggera con pattern funk-pop da live show.', NULL),
(48, 1, 'Bruno Mars Groove Sunglasses', 42, 27.90, 22.00, 'Occhiali da sole con custodia dedicata al tour.', NULL),
(49, 1, 'Rammstein Industrial Black Tee', 43, 39.90, 22.00, 'T-shirt nera con grafica industrial rock.', NULL),
(50, 1, 'Rammstein Fire Stage Hoodie', 43, 84.90, 22.00, 'Felpa pesante con design scuro e stampa palco live.', NULL),
(51, 1, 'Ed Sheeran Acoustic Guitar Pick Set', 44, 14.90, 22.00, 'Set di plettri souvenir per fan e musicisti.', NULL),
(52, 1, 'Ed Sheeran Acoustic Tour Tee', 44, 32.90, 22.00, 'T-shirt chiara con grafica acustica e date tour.', NULL),
(53, 1, 'David Guetta Dance Floor Cap', 45, 28.90, 22.00, 'Cappellino elettronico con logo ricamato.', NULL),
(54, 1, 'David Guetta Neon Club Tee', 45, 35.90, 22.00, 'T-shirt neon con grafica club e stampa frontale.', NULL),
(55, 1, 'Stromae Electronic Poetry Notebook', 29, 18.90, 22.00, 'Notebook grafico ispirato a testi profondi e stile elettronico.', NULL),
(56, 1, 'Stromae European Stage Poster', 29, 19.90, 22.00, 'Poster artistico formato 50x70 per il tour europeo.', NULL);
