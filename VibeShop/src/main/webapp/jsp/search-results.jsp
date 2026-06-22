<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.turbolayout.SearchServlet.SearchResult" %>
<%!
    private String h(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
    }
%>
<%
    Object resultsObject = request.getAttribute("results");
    List<SearchResult> results = resultsObject instanceof List ? (List<SearchResult>) resultsObject : new ArrayList<SearchResult>();
    String searchQuery = (String) request.getAttribute("searchQuery");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Risultati ricerca - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/merch.css" />
</head>
<body>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>
<main class="main-content">
    <section class="section-container">
        <div class="section-header"><h2>Risultati per: <%= h(searchQuery) %></h2></div>
        <% if (results.isEmpty()) { %>
            <div class="empty-catalog-message"><h2>Nessun risultato trovato</h2><p>Prova con il nome di un artista, un concerto o un prodotto merch.</p></div>
        <% } else { %>
            <div class="search-results-list">
                <% for (SearchResult item : results) { %>
                    <a class="search-result-card" href="${pageContext.request.contextPath}<%= h(item.getUrl()) %>">
                        <span class="search-result-type"><%= h(item.getType()) %></span>
                        <strong><%= h(item.getTitle()) %></strong>
                        <% if (item.getSubtitle() != null && !item.getSubtitle().trim().isEmpty()) { %>
                            <small><%= h(item.getSubtitle()) %></small>
                        <% } %>
                    </a>
                <% } %>
            </div>
        <% } %>
    </section>
</main>
<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
<script src="${pageContext.request.contextPath}/js/vibeshop-ajax.js"></script>
</body>
</html>
