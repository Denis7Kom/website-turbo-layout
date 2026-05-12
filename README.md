[Template_System_Architecture.pdf](https://github.com/user-attachments/files/27531038/Template_System_Architecture.pdf)

# VibeShop — Turbo Layout

**VibeShop** è un progetto web sviluppato dal gruppo **Turbo Layout** per il corso di **Tecnologie Software per il Web** presso l'Università degli Studi di Salerno.

Il sito nasce come piattaforma e-commerce dedicata al mondo della musica live. L'obiettivo principale è offrire agli utenti un ambiente semplice, moderno e intuitivo dove poter scoprire concerti, artisti e merchandising musicale.

## Componenti del gruppo

- Denis Komarov
- Ivan Perruolo
- Giulio Alessandro Peluso

## Obiettivo del progetto

VibeShop vuole diventare un punto di riferimento per gli utenti interessati alla musica dal vivo.  
La piattaforma permette di esplorare concerti disponibili, consultare le informazioni sugli artisti, cercare prodotti musicali e acquistare merchandising o biglietti attraverso un flusso di navigazione chiaro.

Il progetto combina funzionalità tipiche di un e-commerce con un'identità visiva ispirata all'atmosfera dei concerti: energia, luci, movimento e contenuti musicali.

## Funzionalità principali

### Utente non registrato

L'utente guest può:

- visualizzare i concerti disponibili;
- consultare i dettagli degli artisti;
- ricercare concerti, artisti e merchandising;
- accedere alle pagine di registrazione e login;
- esplorare il catalogo senza finalizzare acquisti.

La registrazione è richiesta per completare un ordine e per contattare l'assistenza.

### Utente registrato

L'utente registrato può:

- aggiungere prodotti al carrello;
- completare l'acquisto;
- visualizzare gli ordini effettuati;
- consultare la cronologia degli acquisti;
- modificare i propri dati personali, tra cui nome, cognome, email, indirizzo di spedizione e metodo di pagamento.

### Amministratore

L'amministratore può:

- aggiungere, modificare ed eliminare concerti;
- gestire il merchandising presente sul sito;
- visualizzare gli ordini per data;
- gestire le richieste di assistenza degli utenti.

## Struttura del sito

Il sito prevede una struttura di navigazione composta da:

- Homepage;
- pagina concerti;
- dettaglio concerto;
- pagina artisti;
- dettaglio artista;
- merchandising;
- dettaglio prodotto;
- ricerca globale;
- carrello;
- checkout;
- login;
- registrazione;
- area personale;
- storico ordini;
- dettaglio ordine;
- area amministratore;
- assistenza.

Il flusso principale porta l'utente dalla homepage alla consultazione di concerti, artisti e prodotti, fino all'aggiunta al carrello e alla finalizzazione dell'acquisto.

## Base di dati

Il progetto prevede una base di dati strutturata tramite schema Entità-Relazione.  
Le entità principali sono:

- Utente;
- Ordine;
- Dettaglio_Ordine;
- Prodotto;
- Artista;
- Concerto.

Le relazioni principali permettono di collegare utenti e ordini, ordini e dettagli d'ordine, prodotti e artisti, concerti e artisti. Questa struttura consente di gestire sia la parte e-commerce sia la parte informativa legata agli eventi musicali.

## Layout

Il layout del sito è stato progettato tramite wireframe delle pagine principali:

- Homepage;
- pagina artista;
- pagina prodotto o concerto;
- carrello e checkout.

La homepage include una hero section con messaggio principale e call to action.  
Le pagine prodotto e concerto contengono informazioni dettagliate, prezzo, descrizione, disponibilità e azioni per l'acquisto.  
Il carrello e il checkout guidano l'utente verso la conferma dell'ordine.

## Tema grafico

Lo stile grafico scelto è moderno, pulito e orientato alla musica live.  
L'interfaccia deve trasmettere energia senza diventare troppo pesante o confusa.

Il design si ispira a siti moderni con uno stile chiaro e ordinato, mantenendo un tono comunicativo diretto, informale e adatto a un pubblico giovane, ma allo stesso tempo professionale per un contesto e-commerce.

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

La combinazione di viola e rosa richiama le luci dei concerti, mentre gli sfondi chiari mantengono l'interfaccia leggibile e ordinata.

## Tecnologie utilizzate

- HTML
- CSS
- Java
- JSP
- Servlet
- Database relazionale

## Stato del progetto

Il progetto è in fase di sviluppo come elaborato universitario.  
Le funzionalità principali sono definite a livello di architettura, navigazione, layout e modello dati.

## Licenza

Progetto realizzato a scopo didattico.
