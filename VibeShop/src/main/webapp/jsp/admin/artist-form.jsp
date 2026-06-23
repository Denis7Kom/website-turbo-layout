<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    Object artistObject = request.getAttribute("artist");
    ArtistBean artist = artistObject instanceof ArtistBean ? (ArtistBean) artistObject : null;
    boolean editing = artist != null && artist.getIdArtista() > 0;
    String formError = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%= editing ? "Modifica Artista" : "Nuovo Artista" %> - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css" />
</head>
<body>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>
<main class="admin-main-container">
    <header class="admin-hero">
        <div class="admin-welcome-box">
            <div class="admin-icon admin-icon-logo">
                <img src="${pageContext.request.contextPath}/img/logo.svg" alt="VibeShop" />
            </div>
            <div class="admin-welcome-text">
                <h1><%= editing ? "Modifica Artista" : "Nuovo Artista" %></h1>
                <p>Compila il profilo artista usato nella homepage, nella pagina artisti e nel collegamento con prodotti e concerti.</p>
            </div>
        </div>
    </header>

    <div class="admin-content-grid">
        <aside class="admin-sidebar">
            <nav class="sidebar-nav">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Panoramica</a>
                <a href="${pageContext.request.contextPath}/admin/orders">Gestione Ordini</a>
                <a href="${pageContext.request.contextPath}/admin/products">Gestione Prodotti</a>
                <a href="${pageContext.request.contextPath}/admin/artists" class="active">Gestione Artisti</a>
                <a href="${pageContext.request.contextPath}/admin/concerts">Gestione Concerti</a>
                <a href="${pageContext.request.contextPath}/logout" class="logout-link">Disconnetti</a>
            </nav>
        </aside>

        <div class="admin-main-view">
            <section class="card-vibe admin-form-container">
                <div class="section-title-row">
                    <h2>Dettagli Artista</h2>
                    <a href="${pageContext.request.contextPath}/admin/artists" class="btn-cancel-link">Annulla</a>
                </div>

                <% if (formError != null && !formError.trim().isEmpty()) { %>
                    <div class="admin-form-error"><strong>Errore:</strong> <%= h(formError) %></div>
                <% } %>

                <form action="${pageContext.request.contextPath}/admin/artists/save" method="post" class="vibe-admin-form" novalidate>
                    <input type="hidden" name="idArtista" value="<%= editing ? artist.getIdArtista() : 0 %>">

                    <div class="form-row">
                        <div class="form-group flex-2">
                            <label for="nomeArte">Nome d'arte</label>
                            <input type="text" id="nomeArte" name="nomeArte" value="<%= editing ? h(artist.getNomeArte()) : "" %>" required />
                        </div>
                        <div class="form-group flex-1">
                            <label for="genere">Genere</label>
                            <input type="text" id="genere" name="genere" value="<%= editing ? h(artist.getGenere()) : "" %>" placeholder="Pop, Rock, Rap..." />
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group flex-1">
                            <label for="paese">Paese</label>
                            <input type="text" id="paese" name="paese" value="<%= editing ? h(artist.getPaese()) : "" %>" placeholder="Italia, Francia..." />
                        </div>
                        <div class="form-group flex-2">
                            <label for="foto">Foto</label>
                            <input type="text" id="foto" name="foto" placeholder="Esempio: artisti/nome-artista.jpg oppure img/artisti/nome-artista.jpg" value="<%= editing ? h(artist.getFoto()) : "" %>" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="biografia">Biografia</label>
                        <textarea id="biografia" name="biografia" rows="5" placeholder="Breve descrizione dell'artista"><%= editing ? h(artist.getBiografia()) : "" %></textarea>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn-save-product"><%= editing ? "Aggiorna Artista" : "Crea Artista" %></button>
                    </div>
                </form>
            </section>
        </div>
    </div>
</main>
<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
