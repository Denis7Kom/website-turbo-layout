document.addEventListener('DOMContentLoaded', () => {
    const menuBtn = document.getElementById('menu-btn');
    const navMenu = document.getElementById('nav-menu');

    // Esegui il codice SOLO se gli elementi esistono nella pagina corrente
    if (menuBtn && navMenu) {
        
        // Funzione per aprire/chiudere il menu al click sul bottone
        menuBtn.addEventListener('click', (e) => {
            // Impedisce che il click si propaghi al document, evitando che il menu si chiuda subito
            e.stopPropagation();
            navMenu.classList.toggle('active');
        });

        // Chiude il menu se l'utente clicca in un punto qualsiasi fuori dalla tendina
        document.addEventListener('click', (e) => {
            if (!navMenu.contains(e.target) && !menuBtn.contains(e.target)) {
                navMenu.classList.remove('active');
            }
        });
    }
});
