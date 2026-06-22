document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".contenitore-card").forEach(container => {
        const updateFade = () => {
            const canScroll = container.scrollWidth > container.clientWidth + 1;
            const isAtStart = container.scrollLeft <= 2;

            container.classList.toggle("has-horizontal-overflow", canScroll);
            container.classList.toggle("hide-scroll-fade", !canScroll || !isAtStart);
        };

        updateFade();
        container.addEventListener("scroll", updateFade, { passive: true });
        window.addEventListener("resize", updateFade);
    });
});
