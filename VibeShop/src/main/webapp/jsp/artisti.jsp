<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.ArtistBean" %>
<%!
    private String h(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
    }
%>
<%
    Object artistsObject = request.getAttribute("artists");
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
    <div class="featured-grid">
        <a href="${pageContext.request.contextPath}/concerti" class="featured-card featured-card--large">
            <div class="featured-card-img"></div><div class="featured-card-overlay"></div>
            <div class="featured-card-body">
                <span class="featured-card-label">Artista del momento</span>
                <div class="featured-card-nome"><%= featuredArtist == null ? "Artisti VibeShop" : h(featuredArtist.getNomeArte()) %></div>
                <div class="featured-card-genere"><%= featuredArtist == null ? "Live" : h(featuredArtist.getGenere()) %></div>
            </div>
        </a>
    </div>
</section>
<section class="section-container">
    <div class="section-header"><h2>Tutti gli artisti</h2></div>
    <div class="artisti-grid">
        <% if (artists.isEmpty()) { %>
            <a href="${pageContext.request.contextPath}/concerti" class="artista-card"><div class="artista-card-img"></div><div class="artista-card-body"><span class="artista-card-nome">Nessun artista disponibile</span><span class="artista-card-genere">Catalogo vuoto</span></div></a>
        <% } else { %>
            <% for (ArtistBean artist : artists) { %>
                <a href="${pageContext.request.contextPath}/concerti" class="artista-card">
                    <div class="artista-card-img"></div>
                    <div class="artista-card-body">
                        <span class="artista-card-nome"><%= h(artist.getNomeArte()) %></span>
                        <span class="artista-card-genere"><%= h(artist.getGenere()) %><%= artist.getPaese() == null ? "" : " · " + h(artist.getPaese()) %></span>
                    </div>
                </a>
            <% } %>
        <% } %>
    </div>
</section>
</main>
<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
