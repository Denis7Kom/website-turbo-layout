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

    private String shortText(String value, int maxLength) {
        if (value == null) {
            return "";
        }
        String clean = value.trim();
        return clean.length() <= maxLength ? clean : clean.substring(0, maxLength).trim() + "...";
    }

    private boolean hasText(String value) {
        return value != null && !value.trim().isEmpty();
    }

    private String imagePath(ArtistBean artist) {
        if (artist == null || !hasText(artist.getFoto())) {
            return "img/logo.svg";
        }

        String clean = artist.getFoto().trim();
        if (clean.startsWith("http://") || clean.startsWith("https://") || clean.startsWith("/")) {
            return clean;
        }
        return clean.startsWith("img/") ? clean : "img/" + clean;
    }

    private String artistMessage(String action) {
        if ("created".equals(action)) {
            return "Artista creato correttamente.";
        }
        if ("updated".equals(action)) {
            return "Artista aggiornato correttamente.";
        }
        if ("deleted".equals(action)) {
            return "Artista eliminato correttamente.";
        }
        if ("delete-error".equals(action)) {
            return "Impossibile eliminare l'artista selezionato.";
        }
        return null;
    }

    private boolean isErrorMessage(String action) {
        return "delete-error".equals(action);
    }
%>
<%
    Object data = request.getAttribute("artists");
    List<ArtistBean> artists = data instanceof List ? (List<ArtistBean>) data : new ArrayList<ArtistBean>();
    String artistAction = request.getParameter("artistAction");
    String artistMessage = artistMessage(artistAction);
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestione Artisti - VibeShop</title>
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
                <h1>Gestione Artisti</h1>
                <p>Gestisci profili artisti, genere, paese, biografia e immagini usate nelle pagine pubbliche.</p>
            </div>
        </div>
        <div class="admin-quick-stats">
            <div class="quick-stat"><span class="stat-val"><%= artists.size() %></span><span class="stat-lbl">Artisti</span></div>
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
            <section class="card-vibe">
                <div class="section-title-row">
                    <h2>Catalogo Artisti</h2>
                    <a href="${pageContext.request.contextPath}/admin/artist-form" class="btn-add-product">Aggiungi Artista</a>
                </div>

                <% if (artistMessage != null && isErrorMessage(artistAction)) { %>
                    <div class="admin-form-error"><%= h(artistMessage) %></div>
                <% } else if (artistMessage != null) { %>
                    <div style="padding: 14px 18px; margin-bottom: 22px; border-radius: 12px; border: 1px solid rgba(46, 125, 50, 0.18); background: var(--success-bg); color: var(--success); font-size: 14px;"><%= h(artistMessage) %></div>
                <% } %>

                <div class="admin-filters-bar">
                    <div class="filter-group-search">
                        <label for="searchArtist">Cerca artista</label>
                        <input type="text" id="searchArtist" placeholder="Cerca per nome, genere o paese" />
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="admin-table" id="adminArtistsTable">
                        <thead>
                            <tr>
                                <th>Artista</th>
                                <th>Genere</th>
                                <th>Paese</th>
                                <th>Foto</th>
                                <th>Azioni</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (artists.isEmpty()) { %>
                                <tr><td colspan="5">Nessun artista presente.</td></tr>
                            <% } else { %>
                                <% for (ArtistBean artist : artists) { %>
                                    <tr>
                                        <td>
                                            <strong><%= h(artist.getNomeArte()) %></strong><br>
                                            <span><%= h(shortText(artist.getBiografia(), 110)) %></span>
                                        </td>
                                        <td><%= hasText(artist.getGenere()) ? h(artist.getGenere()) : "-" %></td>
                                        <td><%= hasText(artist.getPaese()) ? h(artist.getPaese()) : "-" %></td>
                                        <td>
                                            <img src="${pageContext.request.contextPath}/<%= h(imagePath(artist)) %>" alt="<%= h(artist.getNomeArte()) %>" style="width: 58px; height: 58px; border-radius: 14px; object-fit: cover; background: #f1f3f6; border: 1px solid rgba(0,0,0,0.06);" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/img/logo.svg';" />
                                        </td>
                                        <td>
                                            <div class="admin-actions-cell">
                                                <a href="${pageContext.request.contextPath}/admin/artist-form?id=<%= artist.getIdArtista() %>" class="btn-table-edit">Modifica</a>
                                                <form action="${pageContext.request.contextPath}/admin/artists/delete" method="post" onsubmit="return confirm('Vuoi davvero eliminare questo artista? I concerti e i prodotti collegati resteranno senza artista.');">
                                                    <input type="hidden" name="id" value="<%= artist.getIdArtista() %>">
                                                    <button type="submit" class="btn-table-delete">Elimina</button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                <% } %>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
    </div>
</main>
<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
<script src="${pageContext.request.contextPath}/js/vibeshop-ajax.js"></script>
</body>
</html>
