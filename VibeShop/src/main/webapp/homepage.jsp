<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="model.ConcertoBean" %>
<%@ page import="model.ArtistBean" %>
<%@ page import="model.ProductBean" %>
<%@ page import="model.dao.ConcertoDAO" %>
<%@ page import="model.dao.ArtistDAO" %>
<%@ page import="model.dao.ProductDAO" %>

<%!
    private String h(String value) {
        if (value == null) {
            return "";
        }

        return value
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }

    private boolean hasText(String value) {
        return value != null && !value.trim().isEmpty();
    }

    private String shortText(String value, int maxLength) {
        if (value == null) {
            return "";
        }

        String clean = value.trim();
        return clean.length() <= maxLength
                ? clean
                : clean.substring(0, maxLength).trim() + "...";
    }

    private String normalizeImagePath(String value) {
        if (!hasText(value)) {
            return "";
        }

        String clean = value.trim();

        if (clean.startsWith("http://") || clean.startsWith("https://") || clean.startsWith("/")) {
            return clean;
        }

        return clean.startsWith("img/") ? clean : "img/" + clean;
    }

    private String casualImage(int index) {
        return "img/casual/" + ((Math.abs(index) % 5) + 1) + ".avif";
    }

    private String artistImage(ArtistBean artist, int index) {
        if (artist != null && hasText(artist.getFoto())) {
            return normalizeImagePath(artist.getFoto());
        }

        return casualImage(index);
    }

    private int concertImageNumber(int index) {
        return (Math.abs(index) % 13) + 1;
    }

    private String concertImage(int index) {
        return "img/concerti/" + ((Math.abs(index) % 12) + 1) + ".jpg";
    }
%>

<%
    List<ConcertoBean> concerts = new ArrayList<ConcertoBean>();
    List<ArtistBean> artists = new ArrayList<ArtistBean>();
    List<ProductBean> products = new ArrayList<ProductBean>();
    String databaseWarning = null;

    try {
        concerts = new ConcertoDAO().findAllActive();
        artists = new ArtistDAO().findFeatured(6);
        products = new ProductDAO().findAllActive();
    } catch (SQLException e) {
        databaseWarning = "Database non disponibile: contenuti dinamici temporaneamente vuoti.";
    }

    NumberFormat money = NumberFormat.getCurrencyInstance(Locale.ITALY);
    SimpleDateFormat dayFormat = new SimpleDateFormat("dd MMM yyyy", Locale.ITALY);
%>

<!doctype html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <title>Homepage - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homepage.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>

<body>
    <%@ include file="/WEB-INF/fragments/header.jspf" %>
    <%@ include file="/WEB-INF/fragments/nav.jspf" %>

    <main class="main-content">
        <% if (databaseWarning != null) { %>
            <div class="card empty-card" style="margin-bottom: 24px; min-height: auto;">
                <div class="card-content" style="min-height: auto;">
                    <span class="card-label">Database</span>
                    <span class="card-title"><%= h(databaseWarning) %></span>
                </div>
            </div>
        <% } %>

        <section class="section-container">
            <div class="section-header">
                <h2>Concerti in evidenza</h2>
                <a class="tasto_lato" href="${pageContext.request.contextPath}/concerti">Vedi tutti</a>
            </div>

            <div class="contenitore-card fade-right">
                <% if (concerts.isEmpty()) { %>
                    <div class="card empty-card">
                        <a href="${pageContext.request.contextPath}/concerti">
                            <div class="card-content">
                                <span class="card-label">Concerti</span>
                                <span class="card-title">Nessun concerto disponibile</span>
                                <span class="card-meta">Il calendario eventi verrà aggiornato a breve.</span>
                            </div>
                        </a>
                    </div>
                <% } else { %>
                    <% for (int i = 0; i < concerts.size() && i < 6; i++) {
                        ConcertoBean concert = concerts.get(i);
                    %>
                        <div class="card">
                            <a href="${pageContext.request.contextPath}/concerti">
                                <img
                                    class="card-image"
                                    src="${pageContext.request.contextPath}/<%= h(concertImage(i)) %>"
                                    data-concert-image-base="${pageContext.request.contextPath}/img/concerti/<%= concertImageNumber(i) %>"
                                    data-fallback-index="0"
                                    data-logo-fallback="${pageContext.request.contextPath}/img/logo.svg"
                                    onerror="fallbackConcertImage(this)"
                                    alt="<%= h(concert.getNome()) %>"
                                />

                                <div class="card-content">
                                    <span class="card-label">Concerto</span>
                                    <span class="card-title"><%= h(concert.getNome()) %></span>

                                    <% if (hasText(concert.getLuogo())) { %>
                                        <span class="card-meta"><%= h(concert.getLuogo()) %></span>
                                    <% } %>

                                    <% if (concert.getDataEvento() != null) { %>
                                        <span class="card-meta"><%= dayFormat.format(concert.getDataEvento()) %></span>
                                    <% } %>

                                    <% if (concert.getPrezzo() != null) { %>
                                        <span class="card-price"><%= money.format(concert.getPrezzo()) %></span>
                                    <% } %>
                                </div>
                            </a>
                        </div>
                    <% } %>
                <% } %>
            </div>
        </section>

        <section id="artisti" class="section-container">
            <div class="section-header">
                <h2>Artisti da scoprire</h2>
                <a class="tasto_lato" href="${pageContext.request.contextPath}/artisti">Vedi tutti</a>
            </div>

            <div class="contenitore-card fade-right">
                <% if (artists.isEmpty()) { %>
                    <div class="card empty-card">
                        <a href="${pageContext.request.contextPath}/artisti">
                            <div class="card-content">
                                <span class="card-label">Artisti</span>
                                <span class="card-title">Nessun artista disponibile</span>
                                <span class="card-meta">Aggiungi artisti dal database per mostrarli qui.</span>
                            </div>
                        </a>
                    </div>
                <% } else { %>
                    <% for (int i = 0; i < artists.size() && i < 6; i++) {
                        ArtistBean artist = artists.get(i);
                    %>
                        <div class="card">
                            <a href="${pageContext.request.contextPath}/artisti">
                                <img
                                    class="card-image"
                                    src="${pageContext.request.contextPath}/<%= h(artistImage(artist, i)) %>"
                                    alt="<%= h(artist.getNomeArte()) %>"
                                    onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/<%= h(casualImage(i)) %>';"
                                />

                                <div class="card-content">
                                    <span class="card-label">Artista</span>
                                    <span class="card-title"><%= h(artist.getNomeArte()) %></span>

                                    <% if (hasText(artist.getGenere())) { %>
                                        <span class="card-meta"><%= h(artist.getGenere()) %></span>
                                    <% } %>

                                    <% if (hasText(artist.getPaese())) { %>
                                        <span class="card-meta"><%= h(artist.getPaese()) %></span>
                                    <% } %>

                                    <% if (hasText(artist.getBiografia())) { %>
                                        <span class="card-meta"><%= h(shortText(artist.getBiografia(), 90)) %></span>
                                    <% } %>
                                </div>
                            </a>
                        </div>
                    <% } %>
                <% } %>
            </div>
        </section>

        <section class="section-container">
            <div class="section-header">
                <h2>Shop & Collezioni</h2>
                <a class="tasto_lato" href="${pageContext.request.contextPath}/merch">Vedi tutti</a>
            </div>

            <div class="contenitore-card fade-right">
                <% if (products.isEmpty()) { %>
                    <div class="card empty-card">
                        <a href="${pageContext.request.contextPath}/merch">
                            <div class="card-content">
                                <span class="card-label">Merch</span>
                                <span class="card-title">Nessun prodotto disponibile</span>
                                <span class="card-meta">Il catalogo merch è temporaneamente vuoto.</span>
                            </div>
                        </a>
                    </div>
                <% } else { %>
                    <% for (int i = 0; i < products.size() && i < 6; i++) {
                        ProductBean product = products.get(i);
                    %>
                        <div class="card">
                            <a href="${pageContext.request.contextPath}/merch">
                                <div class="card-content">
                                    <span class="card-label">Merch</span>
                                    <span class="card-title"><%= h(product.getNome()) %></span>

                                    <% if (hasText(product.getDescrizione())) { %>
                                        <span class="card-meta"><%= h(product.getDescrizione()) %></span>
                                    <% } %>

                                    <% if (product.getPrezzo() != null) { %>
                                        <span class="card-price"><%= money.format(product.getPrezzo()) %></span>
                                    <% } %>
                                </div>
                            </a>
                        </div>
                    <% } %>
                <% } %>
            </div>
        </section>
    </main>

    <%@ include file="/WEB-INF/fragments/footer.jspf" %>
    <script src="${pageContext.request.contextPath}/js/menu.js"></script>
    <script src="${pageContext.request.contextPath}/js/scroll-fade.js"></script>
    <script>
        function fallbackConcertImage(img) {
            const extensions = ["png", "jpeg", "webp", "avif"];
            const index = Number(img.dataset.fallbackIndex || "0");
            const base = img.dataset.concertImageBase;

            if (base && index < extensions.length) {
                img.dataset.fallbackIndex = String(index + 1);
                img.src = base + "." + extensions[index];
                return;
            }

            img.onerror = null;
            img.src = img.dataset.logoFallback || "${pageContext.request.contextPath}/img/logo.svg";
        }
    </script>
</body>
</html>
