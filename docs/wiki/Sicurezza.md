# Sicurezza

Questa pagina descrive gli aspetti principali di sicurezza del progetto VibeShop e i miglioramenti consigliati per un utilizzo reale.

## Autenticazione

Il progetto prevede registrazione e login utente.

La gestione delle password deve sempre basarsi su hashing sicuro, evitando il salvataggio di password in chiaro.

Per un uso reale è consigliato utilizzare:

- hashing con bcrypt;
- validazione lato server;
- gestione sicura della sessione;
- logout con invalidazione della sessione.

## Autorizzazione

Le aree riservate devono essere protette in base al ruolo dell'utente.

Esempi:

- utenti normali: profilo, carrello, checkout, cronologia ordini;
- amministratori: dashboard, prodotti, concerti, ordini.

L'accesso all'area admin deve essere consentito solo agli utenti con ruolo `ADMIN`.

## Validazione input

Tutti i dati inseriti dagli utenti devono essere validati lato server.

Esempi:

- email;
- password;
- quantità carrello;
- prezzo prodotto;
- data concerto;
- stato ordine;
- parametri numerici come id prodotto, id concerto e id ordine.

La validazione solo lato client non è sufficiente.

## SQL Injection

L'accesso al database deve usare `PreparedStatement` e non concatenazione diretta di stringhe SQL.

Questo riduce il rischio di SQL Injection.

## XSS

I dati mostrati nelle JSP devono essere escapati prima della visualizzazione.

Campi a rischio:

- nome prodotto;
- descrizione prodotto;
- nome artista;
- biografia;
- luogo concerto;
- dati inseriti dagli utenti.

## CSRF

Le azioni POST che modificano dati dovrebbero essere protette da token CSRF.

Esempi:

- delete prodotto;
- update prodotto;
- delete concerto;
- update stato ordine;
- checkout.

Nel progetto questa protezione può essere aggiunta come miglioramento futuro.

## Gestione errori

Gli errori interni non devono esporre stack trace o dettagli sensibili all'utente finale.

È consigliabile usare pagine di errore dedicate:

- 403;
- 404;
- 500.

## Segreti e credenziali

Le credenziali del database non dovrebbero essere salvate direttamente nel codice sorgente per un uso commerciale.

Soluzioni consigliate:

- variabili d'ambiente;
- configurazione esterna;
- JNDI DataSource di Tomcat;
- file non versionati.

## Miglioramenti consigliati

Prima di usare il progetto in produzione, è consigliato implementare:

- DataSource con connection pool;
- CSRF token;
- logging delle azioni admin;
- validazione più rigorosa;
- HTTPS obbligatorio;
- cookie sicuri;
- controllo upload immagini;
- backup periodici del database.
