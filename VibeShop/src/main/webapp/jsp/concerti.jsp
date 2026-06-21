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
    Object concertsObject = request.getAttribute("concerts");
    List<ConcertoBean> concerts;

    if (concertsObject instanceof List) {
        concerts = (List<ConcertoBean>) concertsObject;
    } else {
        concerts = new ArrayList<ConcertoBean>();
    }

    NumberFormat money = NumberFormat.getCurrencyInstance(Locale.ITALY);
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy HH:mm", Locale.ITALY);
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Concerti - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/concerti.css" />
</head>
<body>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>
<div class="concerti-hero">
    <div class="concerti-hero-inner">
        <span class="concerti-hero-label">Vivi l'atmosfera Live</span>
        <h1>I Concerti<br>più attesi</h1>
        <p>Trova gli eventi collegati al catalogo VibeShop e aggiungi i biglietti al carrello.</p>
    </div>
    <div class="concerti-hero-fade"></div>
</div>
<main class="main-content">
    <section class="section-container">
        <div class="section-header"><h2>Tutti i concerti</h2></div>
        <% if (concerts.isEmpty()) { %>
            <p>Nessun concerto disponibile al momento.</p>
        <% } else { %>
            <div class="concerti-grid">
                <% for (ConcertoBean concert : concerts) { %>
                    <div class="concerto-card">
                        <div class="concerto-card-img">
                            <span class="date-badge"><%= concert.getDataEvento() == null ? "LIVE" : new SimpleDateFormat("dd").format(concert.getDataEvento()) %><br><small><%= concert.getDataEvento() == null ? "" : new SimpleDateFormat("MMM", Locale.ITALY).format(concert.getDataEvento()).toUpperCase() %></small></span>
                        </div>
                        <div class="concerto-card-body">
                            <span class="concerto-card-artista"><%= h(concert.getNome()) %></span>
                            <span class="concerto-card-location"><%= h(concert.getLuogo()) %></span>
                            <span class="concerto-card-prezzo">Da <%= money.format(concert.getPrezzo()) %></span>
                            <% if (concert.getDataEvento() != null) { %>
                                <span class="concerto-card-location"><%= dateFormat.format(concert.getDataEvento()) %></span>
                            <% } %>
                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                <input type="hidden" name="action" value="addConcert">
                                <input type="hidden" name="idConcerto" value="<%= concert.getIdConcerto() %>">
                                <input type="hidden" name="quantity" value="1">
                                <button type="submit" class="btn-acquista">Acquista Biglietto</button>
                            </form>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </section>
</main>
<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
