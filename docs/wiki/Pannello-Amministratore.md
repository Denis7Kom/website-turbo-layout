# Pannello Amministratore

Il pannello amministratore permette la gestione dei contenuti principali di VibeShop.

L'accesso deve essere riservato agli utenti con ruolo `ADMIN`.

## Accesso

L'amministratore accede tramite il normale sistema di login.

Dopo l'autenticazione, se il ruolo è corretto, può raggiungere le pagine admin.

Esempio di percorso:

```text
/admin/dashboard
```

## Dashboard

La dashboard mostra una panoramica dei dati principali:

- entrate totali;
- numero ordini;
- prodotti attivi;
- concerti presenti;
- ultimi ordini ricevuti.

## Gestione prodotti

La sezione prodotti permette di:

- visualizzare i prodotti attivi;
- creare un nuovo prodotto;
- modificare un prodotto esistente;
- disattivare un prodotto;
- visualizzare messaggi dopo le azioni principali.

Ogni prodotto può avere:

- nome;
- descrizione;
- prezzo;
- IVA;
- immagine;
- artista collegato.

Prima della disattivazione viene richiesta una conferma, così da evitare azioni accidentali.

## Gestione concerti

La sezione concerti permette di:

- visualizzare eventi;
- creare nuovi concerti;
- modificare concerti esistenti;
- eliminare o disattivare eventi;
- gestire luogo, data, prezzo e artista collegato.

Ogni concerto può avere:

- titolo;
- data e ora;
- luogo;
- prezzo biglietto;
- IVA;
- descrizione o manager evento;
- artista collegato.

## Gestione ordini

La sezione ordini permette di:

- consultare gli ordini ricevuti;
- filtrare gli ordini;
- vedere totale e metodo di pagamento;
- aggiornare lo stato ordine.

Gli stati gestiti sono:

```text
CONFERMATO
IN_ELABORAZIONE
ANNULLATO
```

Nel frontend lo stato `IN_ELABORAZIONE` viene mostrato come `IN ELABORAZIONE`.

## Messaggi di sistema

Dopo operazioni come creazione, modifica o disattivazione, il pannello può mostrare messaggi di conferma.

Esempi:

- prodotto creato correttamente;
- prodotto aggiornato correttamente;
- prodotto disattivato correttamente;
- errore durante una disattivazione.

## Miglioramenti futuri

- gestione completa degli artisti;
- upload immagini;
- dashboard con grafici reali;
- esportazione ordini;
- storico azioni admin;
- gestione ruoli multipli;
- protezione CSRF sulle azioni POST.
