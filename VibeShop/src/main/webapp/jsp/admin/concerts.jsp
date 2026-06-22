<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.ConcertoBean" %>
<%!
    private String h(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
    }
%>
<%
    Object data = request.getAttribute("concerts");
    List<ConcertoBean> concerts = data instanceof List ? (List<ConcertoBean>) data : new ArrayList<ConcertoBean>();
    NumberFormat money = NumberFormat.getCurrencyInstance(Locale.ITALY);
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy HH:mm", Locale.ITALY);
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestione Concerti e Biglietti - VibeShop</title>
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
            <div class="admin-icon admin-icon-logo"><img src="${pageContext.request.contextPath}/img/logo.svg" alt="VibeShop" /></div>
            <div class="admin-welcome-text">
                <h1>Gestione Concerti e Biglietti</h1>
                <p>Modifica eventi, luoghi, date e prezzo dei biglietti.</p>
            </div>
        </div>
        <div class="admin-quick-stats">
            <div class="quick-stat">
                <span class="stat-val"><%= concerts.size() %></span>
                <span class="stat-lbl">Eventi</span>
            </div>
        </div>
    </header>

    <div class="admin-content-grid">
        <aside class="admin-sidebar">
            <nav class="sidebar-nav">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Panoramica</a>
                <a href="${pageContext.request.contextPath}/admin/orders">Gestione Ordini</a>
                <a href="${pageContext.request.contextPath}/admin/products">Gestione Prodotti</a>
                <a href="${pageContext.request.contextPath}/admin/concerts" class="active">Gestione Concerti e Biglietti</a>
                <a href="${pageContext.request.contextPath}/logout" class="logout-link">Disconnetti</a>
            </nav>
        </aside>

        <div class="admin-main-view">
            <section class="card-vibe">
                <div class="section-title-row">
                    <h2>Calendario Eventi</h2>
                    <a href="${pageContext.request.contextPath}/admin/concert-form" class="btn-add-product">Aggiungi Concerto</a>
                </div>
                <div class="admin-filters-bar">
                    <div class="filter-group-search">
                        <label for="searchProduct">Cerca evento</label>
                        <input type="text" id="searchProduct" placeholder="Cerca per titolo, luogo o manager" />
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="admin-table" id="adminProductsTable">
                        <thead>
                            <tr><th>Evento</th><th>Data</th><th>Luogo</th><th>Prezzo biglietto</th><th>IVA</th><th>Azioni</th></tr>
                        </thead>
                        <tbody>
                            <% if (concerts.isEmpty()) { %>
                                <tr><td colspan="6">Nessun concerto presente.</td></tr>
                            <% } else { %>
                                <% for (ConcertoBean concert : concerts) { %>
                                    <tr>
                                        <td><strong><%= h(concert.getNome()) %></strong><br><span>ID artista: <%= concert.getIdArtista() == null ? "-" : concert.getIdArtista() %> · <%= h(concert.getDescrizione()) %></span></td>
                                        <td><%= concert.getDataEvento() == null ? "-" : dateFormat.format(concert.getDataEvento()) %></td>
                                        <td><%= h(concert.getLuogo()) %></td>
                                        <td><strong><%= concert.getPrezzo() == null ? money.format(0) : money.format(concert.getPrezzo()) %></strong></td>
                                        <td><%= concert.getIva() %>%</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/concert-form?id=<%= concert.getIdConcerto() %>" class="btn-table-edit">Modifica</a>
                                            <form action="${pageContext.request.contextPath}/admin/concerts/delete" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= concert.getIdConcerto() %>">
                                                <button type="submit" class="btn-table-delete">Elimina</button>
                                            </form>
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
