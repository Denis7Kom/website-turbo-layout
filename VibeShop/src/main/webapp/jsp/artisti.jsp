<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.ArtistBean" %>
<%!
    private String h(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
    }

    private boolean hasText(String value) {
        return value != null && !value.trim().isEmpty();
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

    private String slug(String value) {
        if (value == null) {
            return "artist";
        }

        String s = value.toLowerCase(Locale.ROOT)
                .replace("å", "a")
                .replace("à", "a")
                .replace("è", "e")
                .replace("é", "e")
                .replace("ì", "i")
                .replace("ò", "o")
                .replace("ù", "u")
                .replaceAll("[^a-z0-9]+", "-")
                .replaceAll("^-+", "")
                .replaceAll("-+$", "");

        return s.isEmpty() ? "artist" : s;
    }

    private String casualImage(int index) {
        return "img/casual/" + ((Math.abs(index) % 5) + 1) + ".avif";
    }

    private String artistImage(ArtistBean artist, int index) {
        if (artist != null && hasText(artist.getFoto())) {
            return normalizeImagePath(artist.getFoto());
        }

        if (artist != null && hasText(artist.getNomeArte())) {
            return "img/artisti/" + slug(artist.getNomeArte()) + ".jpg";
        }

        return casualImage(index);
    }

    private String fallbackOnError(int index) {
        return "if(!this.dataset.fallback){this.dataset.fallback='casual';this.src=this.dataset.casual;}else{this.onerror=null;this.src=this.dataset.logo;}";
    }
%>
<%
    Object artistsObject = request.getAttribute("artists");
    if (artistsObject == null) {
        response.sendRedirect(request.getContextPath() + "/artisti");
        return;
    }

    List<ArtistBean> artists = artistsObject instanceof List ? (List<ArtistBean>) artistsObject : new ArrayList<ArtistBean>();
    ArtistBean featuredArtist = artists.isEmpty() ? null : artists.get(0);
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Artisti - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/artisti.css" />
</head>
<body>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>
<div class="artisti-hero"><div class="artisti-hero-inner"><span class="artisti-hero-label">Scopri la musica live</span><h1>Gli artisti<br>di VibeShop</h1><p>Catalogo artisti caricato dal database MySQL.</p></div><div class="artisti-hero-fade"></div></div>
<main class="main-content">
<section class="section-container">
    <div class="section-header"><h2>In evidenza</h2></div>
    <div class="featured-grid"><a href="${pageContext.request.contextPath}/artisti" class="featured-card featured-card--large"><img class="featured-card-img" src="${pageContext.request.contextPath}/<%= h(featuredArtist == null ? casualImage(0) : artistImage(featuredArtist, 0)) %>" data-casual="${pageContext.request.contextPath}/<%= h(casualImage(0)) %>" data-logo="${pageContext.request.contextPath}/img/logo.svg" alt="<%= featuredArtist == null ? "Artisti VibeShop" : h(featuredArtist.getNomeArte()) %>" onerror="<%= fallbackOnError(0) %>"><div class="featured-card-overlay"></div><div class="featured-card-body"><span class="featured-card-label">Artista del momento</span><div class="featured-card-nome"><%= featuredArtist == null ? "Artisti VibeShop" : h(featuredArtist.getNomeArte()) %></div><div class="featured-card-genere"><%= featuredArtist == null ? "Live" : h(featuredArtist.getGenere()) %></div></div></a></div>
</section>
<section class="section-container">
    <div class="section-header"><h2>Tutti gli artisti</h2></div>
    <div class="artisti-grid">
        <% if (artists.isEmpty()) { %>
            <a href="${pageContext.request.contextPath}/artisti" class="artista-card"><img class="artista-card-img" src="${pageContext.request.contextPath}/img/logo.svg" alt="Artisti VibeShop"><div class="artista-card-body"><span class="artista-card-nome">Nessun artista disponibile</span><span class="artista-card-genere">Catalogo vuoto</span></div></a>
        <% } else { %>
            <% for (int i = 0; i < artists.size(); i++) { ArtistBean artist = artists.get(i); %>
                <a href="${pageContext.request.contextPath}/artisti" class="artista-card"><img class="artista-card-img" src="${pageContext.request.contextPath}/<%= h(artistImage(artist, i)) %>" data-casual="${pageContext.request.contextPath}/<%= h(casualImage(i)) %>" data-logo="${pageContext.request.contextPath}/img/logo.svg" alt="<%= h(artist.getNomeArte()) %>" onerror="<%= fallbackOnError(i) %>"/><div class="artista-card-body"><span class="artista-card-nome"><%= h(artist.getNomeArte()) %></span><span class="artista-card-genere"><%= h(artist.getGenere()) %><%= artist.getPaese() == null ? "" : " · " + h(artist.getPaese()) %></span></div></a>
            <% } %>
        <% } %>
    </div>
</section>
</main>
<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
