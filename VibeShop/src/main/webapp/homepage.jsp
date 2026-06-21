<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.ConcertoBean" %>
<%@ page import="model.ArtistBean" %>
<%@ page import="model.ProductBean" %>
<%!
    private String h(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
    }
%>
<%
    if (request.getAttribute("featuredConcerts") == null
            && request.getAttribute("featuredArtists") == null
            && request.getAttribute("featuredProducts") == null) {
        response.sendRedirect(request.getContextPath() + "/home");
        return;
    }

    Object concertsObject = request.getAttribute("featuredConcerts");
    Object artistsObject = request.getAttribute("featuredArtists");
    Object productsObject = request.getAttribute("featuredProducts");

    List<ConcertoBean> concerts = concertsObject instanceof List ? (List<ConcertoBean>) concertsObject : new ArrayList<ConcertoBean>();
    List<ArtistBean> artists = artistsObject instanceof List ? (List<ArtistBean>) artistsObject : new ArrayList<ArtistBean>();
    List<ProductBean> products = productsObject instanceof List ? (List<ProductBean>) productsObject : new ArrayList<ProductBean>();

    NumberFormat money = NumberFormat.getCurrencyInstance(Locale.ITALY);
    SimpleDateFormat dayFormat = new SimpleDateFormat("dd MMM", Locale.ITALY);
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
        <section class="section-container"><div class="section-header"><h2>Concerti in evidenza</h2><a class="tasto_lato" href="${pageContext.request.contextPath}/concerti">Vedi tutti</a></div><div class="contenitore-card fade-right">
            <% if (concerts.isEmpty()) { %><div class="card"><a href="${pageContext.request.contextPath}/concerti"><div class="card-placeholder"></div><span class="card-title">Nessun concerto disponibile</span></a></div><% } else { %>
                <% for (int i = 0; i < concerts.size() && i < 6; i++) { ConcertoBean concert = concerts.get(i); %><div class="card"><a href="${pageContext.request.contextPath}/concerti"><div class="card-placeholder"></div><span class="card-title"><%= h(concert.getNome()) %></span><% if (concert.getDataEvento() != null) { %><span class="card-title"><%= dayFormat.format(concert.getDataEvento()) %></span><% } %></a></div><% } %>
            <% } %>
        </div></section>

        <section class="section-container"><div class="section-header"><h2>Artisti da scoprire</h2><a class="tasto_lato" href="${pageContext.request.contextPath}/artisti">Vedi tutti</a></div><div class="contenitore-card fade-right">
            <% if (artists.isEmpty()) { %><div class="card"><a href="${pageContext.request.contextPath}/artisti"><div class="card-placeholder"></div><span class="card-title">Nessun artista disponibile</span></a></div><% } else { %>
                <% for (int i = 0; i < artists.size() && i < 6; i++) { ArtistBean artist = artists.get(i); %><div class="card"><a href="${pageContext.request.contextPath}/artisti"><div class="card-placeholder"></div><span class="card-title"><%= h(artist.getNomeArte()) %></span><span class="card-title"><%= h(artist.getGenere()) %></span></a></div><% } %>
            <% } %>
        </div></section>

        <section class="section-container"><div class="section-header"><h2>Shop & Collezioni</h2><a class="tasto_lato" href="${pageContext.request.contextPath}/merch">Vedi tutti</a></div><div class="contenitore-card fade-right">
            <% if (products.isEmpty()) { %><div class="card"><a href="${pageContext.request.contextPath}/merch"><div class="card-placeholder"></div><span class="card-title">Nessun prodotto disponibile</span></a></div><% } else { %>
                <% for (int i = 0; i < products.size() && i < 6; i++) { ProductBean product = products.get(i); %><div class="card"><a href="${pageContext.request.contextPath}/merch"><div class="card-placeholder"></div><span class="card-title"><%= h(product.getNome()) %></span><span class="card-title"><%= product.getPrezzo() == null ? "" : money.format(product.getPrezzo()) %></span></a></div><% } %>
            <% } %>
        </div></section>
    </main>

    <%@ include file="/WEB-INF/fragments/footer.jspf" %>
    <script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
