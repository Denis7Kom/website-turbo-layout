# Database

VibeShop utilizza un database MySQL per conservare utenti, artisti, prodotti, concerti, ordini e dettagli ordine.

## Tabelle principali

### `utente`

Contiene i dati degli utenti registrati.

Campi tipici:

- identificativo utente;
- nome;
- cognome;
- username;
- email;
- password hash;
- ruolo.

Il ruolo permette di distinguere utenti normali e amministratori.

### `artista`

Contiene le informazioni sugli artisti.

Campi principali:

- id artista;
- nome d'arte;
- paese;
- genere;
- biografia;
- foto.

### `prodotto`

Contiene il catalogo merchandising.

Campi principali:

- id prodotto;
- nome;
- descrizione;
- prezzo;
- IVA;
- immagine;
- id artista collegato;
- stato attivo/non attivo.

### `concerto`

Contiene gli eventi disponibili.

Campi principali:

- id concerto;
- nome evento;
- luogo;
- data evento;
- prezzo;
- IVA;
- descrizione;
- id artista collegato;
- stato attivo/non attivo.

### `ordine`

Contiene gli ordini effettuati dagli utenti.

Campi principali:

- id ordine;
- id utente;
- data ordine;
- totale;
- metodo di pagamento;
- stato ordine.

### `dettaglio_ordine`

Contiene le righe dell'ordine.

Ogni riga può riferirsi a:

- un prodotto;
- un biglietto concerto.

Campi principali:

- id dettaglio;
- id ordine;
- id prodotto;
- id concerto;
- quantità prodotto;
- quantità biglietti;
- prezzo unitario;
- tipo elemento.

## Relazioni principali

- Un utente può avere più ordini.
- Un ordine può avere più dettagli.
- Un prodotto può essere collegato a un artista.
- Un concerto può essere collegato a un artista.
- Un dettaglio ordine può rappresentare un prodotto o un biglietto.

## Note sui dati

Il progetto usa dati demo per prodotti, concerti e artisti.

Per un utilizzo reale, i dati demo dovrebbero essere sostituiti con contenuti del cliente:

- artisti reali autorizzati;
- immagini con diritti di utilizzo;
- concerti aggiornati;
- prodotti realmente disponibili;
- prezzi e IVA corretti.

## Immagini

Nel database non viene salvato il file immagine, ma solo il percorso testuale.

Esempio:

```text
img/prodotti/maglietta.jpg
```

Il file deve esistere realmente nella cartella indicata del progetto.

## Miglioramenti futuri

- gestione upload immagini da pannello admin;
- eliminazione sicura dei record tramite soft delete;
- audit log delle azioni admin;
- backup automatici;
- gestione stock prodotti;
- gestione disponibilità biglietti.
