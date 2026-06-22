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
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
    }

    private String shortText(String value, int maxLength) {
        if (value == null) {
            return "";
        }
        String clean = value.trim();
        if (clean.length() <= maxLength) {
            return clean;
        }
        return clean.substring(0, maxLength - 1).trim() + "…";
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
                    <% for (int i = 0; i < concerts.size() && i < 6; i++) { ConcertoBean concert = concerts.get(i); %>
                        <div class="card">
                            <a href="${pageContext.request.contextPath}/concerti">
                                <div class="card-content">
                                    <span class="card-label">Concerto</span>
                                    <span class="card-title"><%= h(concert.getNome()) %></span>
                                    <% if (concert.getLuogo() != null && !concert.getLuogo().trim().isEmpty()) { %>
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

        <section class="section-container">
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
                    <% for (int i = 0; i < artists.size() && i < 6; i++) { ArtistBean artist = artists.get(i); %>
                        <div class="card">
                            <a href="${pageContext.request.contextPath}/artisti">
                                <div class="card-content">
                                    <span class="card-label">Artista</span>
                                    <span class="card-title"><%= h(artist.getNomeArte()) %></span>
                                    <% if (artist.getGenere() != null && !artist.getGenere().trim().isEmpty()) { %>
                                        <span class="card-meta"><%= h(artist.getGenere()) %></span>
                                    <% } %>
                                    <% if (artist.getPaese() != null && !artist.getPaese().trim().isEmpty()) { %>
                                        <span class="card-meta"><%= h(artist.getPaese()) %></span>
                                    <% } %>
                                    <% if (artist.getBiografia() != null && !artist.getBiografia().trim().isEmpty()) { %>
                                        <span class="card-meta"><%= h(shortText(artist.getBiografia(), 95)) %></span>
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
                    <% for (int i = 0; i < products.size() && i < 6; i++) { ProductBean product = products.get(i); %>
                        <div class="card">
                            <a href="${pageContext.request.contextPath}/merch">
                                <div class="card-content">
                                    <span class="card-label">Merch</span>
                                    <span class="card-title"><%= h(product.getNome()) %></span>
                                    <% if (product.getDescrizione() != null && !product.getDescrizione().trim().isEmpty()) { %>
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
</body>
</html>
