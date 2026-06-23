# Installazione

Questa pagina descrive i passaggi principali per eseguire VibeShop in ambiente locale.

## Requisiti

Per avviare il progetto sono necessari:

- Java JDK 8 o superiore;
- Apache Tomcat 9;
- MySQL Server;
- MySQL Connector/J;
- un IDE compatibile con progetti Java Web, ad esempio Eclipse;
- un browser moderno.

## Configurazione del database

1. Avviare MySQL.
2. Importare lo script SQL fornito nel progetto.
3. Verificare che il database e le tabelle siano stati creati correttamente.

Le tabelle principali sono:

- `utente`
- `artista`
- `prodotto`
- `concerto`
- `ordine`
- `dettaglio_ordine`

## Configurazione della connessione

La connessione al database viene gestita dal livello DAO.

Prima dell'avvio, verificare:

- host del database;
- porta;
- nome del database;
- username;
- password;
- disponibilità del driver MySQL.

Esempio logico:

```text
Database: vibeshop
Host: localhost
Porta: 3306
User: vibeshop_app
Password: ********
```

## Configurazione Tomcat

1. Importare il progetto nell'IDE.
2. Configurare Apache Tomcat 9.
3. Aggiungere il progetto al server.
4. Inserire le librerie necessarie nel classpath o nella cartella `WEB-INF/lib`.

Librerie tipiche:

- MySQL Connector/J;
- eventuale libreria per hashing password, se utilizzata.

## Avvio

Dopo aver configurato database e server:

1. Avviare Tomcat.
2. Aprire il browser.
3. Visitare l'applicazione.

Esempio:

```text
http://localhost:8080/VibeShop/
```

oppure:

```text
http://localhost:8080/VibeShop/homepage
```

## Test consigliati

Dopo l'avvio, verificare:

- registrazione utente;
- login;
- navigazione tra concerti, artisti e merch;
- aggiunta di prodotti al carrello;
- aggiunta di biglietti al carrello;
- checkout;
- cronologia ordini;
- accesso al pannello amministratore;
- creazione, modifica e disattivazione prodotti;
- gestione concerti;
- aggiornamento stato ordine.

## Problemi comuni

### Il sito non si avvia

Controllare:

- configurazione di Tomcat;
- presenza delle librerie necessarie;
- correttezza del file `web.xml`;
- connessione al database.

### Le immagini non si vedono

Controllare:

- che il percorso salvato nel database sia corretto;
- che il file esista nella cartella indicata;
- che nome ed estensione siano corretti.

### Errore di connessione al database

Controllare:

- che MySQL sia avviato;
- che il database esista;
- che username e password siano corretti;
- che il driver MySQL sia disponibile.
