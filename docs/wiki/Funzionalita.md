# Funzionalità

Questa pagina riassume le principali funzionalità disponibili in VibeShop.

## Area pubblica

L'area pubblica è accessibile agli utenti e permette di navigare tra i contenuti principali del sito.

### Homepage

La homepage presenta una panoramica dei contenuti principali:

- concerti in evidenza;
- artisti da scoprire;
- prodotti merchandising;
- collegamenti rapidi alle sezioni principali.

### Concerti

La pagina concerti mostra gli eventi disponibili.

Per ogni concerto vengono visualizzati:

- nome evento;
- luogo;
- data e ora;
- prezzo;
- immagine associata;
- pulsante per aggiungere il biglietto al carrello.

### Artisti

La pagina artisti mostra i profili degli artisti presenti nel database.

Ogni artista può avere:

- nome d'arte;
- genere;
- paese;
- biografia;
- foto.

### Merchandising

La pagina merch mostra i prodotti disponibili.

Per ogni prodotto vengono visualizzati:

- nome;
- descrizione;
- prezzo;
- immagine;
- pulsante per aggiungere il prodotto al carrello.

### Carrello

Il carrello permette di gestire prodotti e biglietti prima del checkout.

Funzioni principali:

- aggiunta prodotto;
- aggiunta biglietto concerto;
- modifica quantità;
- rimozione elemento;
- svuotamento carrello;
- calcolo totale.

### Checkout

La pagina checkout permette di completare un ordine.

Il sistema valida i dati principali e crea l'ordine nel database.

### Profilo e ordini

L'utente può visualizzare:

- dati personali;
- cronologia ordini;
- dettagli degli ordini effettuati;
- stato degli ordini.

## Area amministratore

L'area amministratore permette la gestione interna del sito.

### Gestione prodotti

L'amministratore può:

- visualizzare prodotti attivi;
- creare un nuovo prodotto;
- modificare un prodotto esistente;
- disattivare un prodotto;
- ricevere messaggi dopo create/update/delete.

### Gestione concerti

L'amministratore può:

- visualizzare concerti;
- creare un nuovo concerto;
- modificare un concerto esistente;
- eliminare o disattivare un concerto;
- impostare prezzo, data, luogo e artista collegato.

### Gestione ordini

L'amministratore può:

- visualizzare gli ordini;
- filtrare per utente o data;
- vedere totale e metodo di pagamento;
- aggiornare lo stato dell'ordine.

Gli stati principali sono:

- `CONFERMATO`
- `IN_ELABORAZIONE`
- `ANNULLATO`

## Funzioni dinamiche

Il progetto include anche alcune funzioni dinamiche lato client:

- menu responsive;
- carrello AJAX;
- suggerimenti di ricerca;
- controlli quantità;
- conferme prima di azioni distruttive;
- fallback grafici per immagini mancanti.
