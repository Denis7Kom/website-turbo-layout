# Architettura

VibeShop segue una struttura tipica delle applicazioni Java Web basate su JSP, Servlet, DAO e database relazionale.

L'architettura separa la presentazione, il controllo delle richieste e l'accesso ai dati.

## Struttura generale

```text
View        → JSP, HTML, CSS, JavaScript
Controller  → Servlet
Model       → Bean, DAO, Database MySQL
```

## View

Il livello View è composto da pagine JSP e file statici.

Le JSP costruiscono l'interfaccia utente e visualizzano i dati ricevuti dalle Servlet.

Esempi:

- `homepage.jsp`
- `concerti.jsp`
- `artisti.jsp`
- `merch.jsp`
- `cart.jsp`
- `checkout.jsp`
- `orders.jsp`
- pagine admin in `jsp/admin/`

I file CSS definiscono lo stile delle sezioni principali, mentre JavaScript gestisce interazioni come menu, carrello AJAX e comportamenti dinamici lato client.

## Controller

Il livello Controller è formato dalle Servlet.

Le Servlet ricevono le richieste HTTP, leggono parametri e sessione, comunicano con i DAO e inoltrano la risposta alle JSP.

Esempi:

- `LoginServlet`
- `RegisterServlet`
- `LogoutServlet`
- `ProductServlet`
- `ConcertiServlet`
- `ArtistiServlet`
- `CartServlet`
- `CheckoutServlet`
- `OrdersServlet`
- `AdminProductServlet`
- `AdminConcertServlet`
- `AdminOrderServlet`

## Model

Il Model contiene Bean e DAO.

I Bean rappresentano le entità principali:

- `UserBean`
- `ProductBean`
- `ArtistBean`
- `ConcertoBean`
- `OrderBean`
- `OrderItemBean`
- `Cart`
- `CartItem`

I DAO isolano la logica SQL dal resto dell'applicazione:

- `UserDAO`
- `ProductDAO`
- `ArtistDAO`
- `ConcertoDAO`
- `OrderDAO`

## Flusso di una richiesta

Esempio per la pagina concerti:

```text
Browser → /concerti → ConcertiServlet → ConcertoDAO → MySQL → concerti.jsp → Browser
```

La Servlet recupera i dati tramite DAO, li inserisce nella request e passa il controllo alla JSP.

## Carrello

Il carrello viene mantenuto in sessione e contiene elementi di tipo diverso:

- prodotto merchandising;
- biglietto concerto.

Ogni elemento viene identificato da tipo e id.

## Checkout e ordini

Durante il checkout, il sistema:

1. legge gli elementi del carrello;
2. valida i dati inseriti;
3. crea un ordine;
4. crea i dettagli dell'ordine;
5. svuota il carrello;
6. mostra la conferma all'utente.

## Area amministratore

L'area amministratore permette la gestione dei dati principali:

- prodotti;
- concerti;
- ordini;
- stati ordine.

L'accesso deve essere limitato agli utenti con ruolo `ADMIN`.

## Possibili miglioramenti

- uso completo di DataSource e Connection Pool;
- riduzione della logica Java dentro le JSP;
- validazione centralizzata;
- protezione CSRF sulle azioni POST;
- upload immagini;
- logging amministrativo;
- deploy professionale.
