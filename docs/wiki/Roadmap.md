# Roadmap

Questa pagina raccoglie le possibili evoluzioni future di VibeShop.

Il progetto è già utilizzabile come applicazione Java Web dimostrativa, ma può essere migliorato per diventare una base più professionale e commerciale.

## Priorità alta

### Stabilizzazione generale

- pulizia finale del codice;
- controllo dei link interni;
- verifica delle route nel file `web.xml`;
- controllo delle pagine di errore;
- test manuale completo su Tomcat.

### Sicurezza

- rimozione di credenziali hardcoded;
- uso di DataSource e connection pool;
- token CSRF per azioni POST;
- validazione più rigorosa lato server;
- controllo dei ruoli amministrativi.

### Immagini

- fallback stabile per immagini mancanti;
- convenzione chiara per i percorsi immagini;
- eventuale upload immagini dal pannello admin;
- validazione delle estensioni consentite.

## Priorità media

### Pannello amministratore

- completare gestione artisti;
- migliorare dashboard con statistiche reali;
- aggiungere ricerca e filtri avanzati;
- esportare ordini in formato CSV;
- storico azioni amministratore.

### Ordini

- email di conferma ordine;
- numero ordine più leggibile;
- pagina dettaglio ordine;
- gestione rimborsi o annullamenti;
- gestione disponibilità biglietti.

### Catalogo

- gestione stock prodotti;
- categorie merch;
- prodotti in evidenza;
- concerti in evidenza;
- collegamento più forte tra artista, concerto e merch.

## Priorità bassa

### Miglioramenti frontend

- animazioni più leggere;
- modalità mobile più curata;
- skeleton loading;
- miglioramento accessibilità;
- SEO base per pagine pubbliche.

### Funzioni commerciali

- pagamento reale con Stripe o PayPal;
- fatturazione o ricevuta PDF;
- gestione coupon;
- gestione newsletter;
- area cliente più completa.

## Deploy professionale

Per rendere il progetto vendibile a un cliente reale, è consigliato preparare:

- server VPS;
- Tomcat 9;
- MySQL;
- Nginx reverse proxy;
- HTTPS con Let's Encrypt;
- backup automatico database;
- documentazione di deploy;
- account admin iniziale configurabile.

## Obiettivo finale

L'obiettivo futuro è trasformare VibeShop da progetto universitario a base professionale per siti web dedicati a:

- agenzie musicali;
- organizzatori di concerti;
- artisti indipendenti;
- piccoli brand di merchandising;
- eventi locali.
