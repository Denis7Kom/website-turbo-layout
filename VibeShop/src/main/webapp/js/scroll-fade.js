document.addEventListener("DOMContentLoaded", () => {
    const contenitori = document.querySelectorAll(".contenitore-card");

    contenitori.forEach(cont => {
        cont.addEventListener("scroll", () => {
            if (cont.scrollLeft > 5) {
                cont.classList.add("scrolled-end");
            } else {
                cont.classList.remove("scrolled-end");
            }
        });
    });
});
