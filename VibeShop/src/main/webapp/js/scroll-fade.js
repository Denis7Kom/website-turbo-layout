document.addEventListener("DOMContentLoaded", () => {
    const contenitori = document.querySelectorAll(".contenitore-card");

    contenitori.forEach(cont => {
        // Al caricamento, se c'è spazio per scrollare, mostriamo il gradiente
        // Aggiungiamo la classe base che gestisce l'opacità
        
        cont.addEventListener("scroll", () => {
            // Se scrolliamo più di 5px verso destra, togliamo il gradiente
            if (cont.scrollLeft > 5) {
                cont.classList.add("scrolled-end");
            } else {
                // Se torniamo all'inizio, riappare
                cont.classList.remove("scrolled-end");
            }
        });
    });
});