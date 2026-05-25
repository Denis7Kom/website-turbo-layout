document.addEventListener('DOMContentLoaded', () => {
    const menuBtn = document.getElementById('menu-btn');
    const navMenu = document.getElementById('nav-menu');

    // Funzione per aprire/chiudere il menu
    menuBtn.addEventListener('click', (e) => {
        // Impedisce che il click si propaghi e chiuda subito il menu
        e.stopPropagation();
        navMenu.classList.toggle('active');
    });

    // Chiude il menu se clicchi in un punto qualsiasi della pagina
    document.addEventListener('click', (e) => {
        if (!navMenu.contains(e.target) && !menuBtn.contains(e.target)) {
            navMenu.classList.remove('active');
        }
    });
});