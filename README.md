[Template_System_Architecture.pdf](https://github.com/user-attachments/files/27531038/Template_System_Architecture.pdf)

# VibeShop — Turbo Layout

**VibeShop** è un progetto web sviluppato dal gruppo **Turbo Layout** per il corso di **Tecnologie Software per il Web** presso l'Università degli Studi di Salerno.

Il sito è una piattaforma e-commerce dedicata alla musica live. L'applicazione permette di consultare concerti, artisti e merchandising musicale, gestire un carrello, completare un ordine e amministrare catalogo e ordini tramite un pannello riservato.

## Componenti del gruppo

- Denis Komarov
- Ivan Perruolo
- Giulio Alessandro Peluso

## Obiettivo del progetto

L'obiettivo di VibeShop è simulare un negozio online specializzato nel settore musicale, con un flusso chiaro per l'utente e una separazione ordinata tra presentazione JSP, servlet di controllo, DAO e database relazionale.

Il progetto combina funzionalità tipiche di un e-commerce con un'identità visiva ispirata all'atmosfera dei concerti: cataloghi dinamici, ricerca, carrello, checkout, area personale e gestione amministrativa.

## Funzionalità implementate

### Utente non registrato

L'utente guest può:

- visualizzare la homepage con concerti, artisti e merchandising in evidenza;
- consultare la pagina concerti;
- consultare la pagina artisti;
- esplorare il catalogo merchandising;
- usare la ricerca globale per prodotti, artisti e concerti;
- accedere alle pagine di registrazione e login.

La registrazione è richiesta per completare un ordine e visualizzare la propria area personale.

### Utente registrato

L'utente registrato può:

- effettuare il login tramite username o email;
- aggiungere merchandising e biglietti al carrello;
- modificare quantità e contenuto del carrello;
- completare il checkout;
- visualizzare gli ordini effettuati;
- accedere al profilo personale;
- aggiornare i propri dati account.

### Amministratore

L'amministratore può:

- accedere al pannello di controllo;
- gestire i prodotti merchandising;
- gestire concerti e biglietti;
- visualizzare e filtrare gli ordini;
- aggiornare lo stato degli ordini tra `CONFERMATO`, `IN_ELABORAZIONE` e `ANNULLATO`.

## Struttura principale del sito

Il sito include:

- homepage (`/jsp/index.jsp` e route compatibili `/home`, `/homepage`);
- pagina concerti (`/concerti`);
- pagina artisti (`/artisti`);
- catalogo merchandising (`/merch`);
- dettaglio prodotto (`/product?id=...`);
- ricerca globale (`/search`);
- carrello (`/cart`);
- checkout (`/checkout`);
- login e registrazione;
- profilo utente;
- storico ordini;
- pannello amministratore.

Il flusso principale porta l'utente dalla consultazione dei cataloghi all'aggiunta degli articoli nel carrello e alla conferma dell'ordine.

## Base di dati

Il progetto utilizza un database MySQL con entità principali:

- Utente;
- Ordine;
- Dettaglio_Ordine;
- Prodotto;
- Artista;
- Concerto.

Le relazioni collegano utenti e ordini, ordini e dettagli, prodotti e artisti, concerti e artisti. Lo schema include chiavi esterne, vincoli di integrità e campi per gestire ruoli utente, stato degli ordini e tipologia degli articoli acquistati.

## Architettura applicativa

L'applicazione segue una struttura classica per progetto Servlet/JSP:

- le JSP gestiscono la presentazione;
- le servlet gestiscono richieste, sessione e flusso applicativo;
- i DAO centralizzano l'accesso al database;
- i bean rappresentano le entità principali;
- il database MySQL mantiene catalogo, utenti, ordini e dettagli.

Per la gestione delle password viene utilizzato bcrypt tramite jBCrypt. L'hash viene salvato nel database, mentre la password in chiaro non viene mai memorizzata.

## Layout

Il layout è stato progettato per essere moderno, pulito e coerente con il tema musicale. Le pagine principali mantengono una navigazione comune, card di catalogo, pannelli amministrativi e messaggi di stato per rendere l'interazione più chiara.

## Palette colori

| Ruolo | Colore | HEX |
|---|---:|---:|
| Colore primario | Viola tenue | `#6A5ACD` |
| Colore secondario | Rosa | `#FF8FBF` |
| Sfondo principale | Grigio chiarissimo | `#F7F7FA` |
| Sfondo alternativo | Bianco | `#FFFFFF` |
| Testo principale | Grigio molto scuro | `#1E1E1E` |
| Testo secondario | Grigio medio | `#7A7A7A` |
| Bordi / Divider | Grigio chiaro | `#E5E5E5` |

## Tecnologie utilizzate

- Java
- Servlet
- JSP
- HTML
- CSS
- JavaScript
- MySQL
- DAO pattern
- bcrypt per password hashing

## Avvio del progetto

Per eseguire il progetto è necessario:

1. importare lo schema `VibeShop/db/VIBESHOP_FINAL.sql` in MySQL;
2. configurare l'utente database usato dall'applicazione;
3. aggiungere MySQL Connector/J al progetto o al server Tomcat;
4. aggiungere `jbcrypt-0.4.jar` per la gestione delle password;
5. eseguire il progetto su Tomcat 9.

## Stato del progetto

Il progetto implementa il flusso principale di consultazione catalogo, registrazione, login, carrello, checkout, storico ordini e amministrazione. Alcune aree possono essere estese in futuro, ma la struttura attuale copre il funzionamento essenziale richiesto per un e-commerce didattico basato su Servlet, JSP e database relazionale.

## Licenza

Progetto realizzato a scopo didattico.
