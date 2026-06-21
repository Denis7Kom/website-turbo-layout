<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
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
    Object value = request.getAttribute("products");
    List<ProductBean> products;

    if (value instanceof List) {
        products = (List<ProductBean>) value;
    } else {
        products = new ArrayList<ProductBean>();
    }

    NumberFormat money = NumberFormat.getCurrencyInstance(Locale.ITALY);
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Merch Ufficiale - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/merch.css" />
</head>
<body>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<div class="merch-hero">
    <div class="merch-hero-inner">
        <span class="merch-hero-label">Collezioni Esclusive</span>
        <h1>Merch<br>Ufficiale</h1>
        <p>Indossa la tua passione. T-shirt, felpe e accessori in edizione limitata<br>dei migliori artisti della scena.</p>
    </div>
    <div class="merch-hero-fade"></div>
</div>

<main class="main-content">

    <div class="filter-bar">
        <div class="categories-capsules">
            <a href="${pageContext.request.contextPath}/merch" class="capsule active">Tutti i prodotti</a>
            <a href="#" class="capsule">T-Shirt</a>
            <a href="#" class="capsule">Felpe</a>
            <a href="#" class="capsule">Accessori</a>
            <a href="#" class="capsule">Vinili & CD</a>
        </div>
        <div class="filter-select-wrapper">
            <select class="filter-select">
                <option>Ordina per: In evidenza</option>
                <option>Prezzo: dal più basso</option>
                <option>Prezzo: dal più alto</option>
                <option>Più recenti</option>
            </select>
        </div>
    </div>

    <section class="section-container">
        <% if (products.isEmpty()) { %>
            <div class="empty-catalog-message">
                <h2>Nessun prodotto disponibile</h2>
                <p>Il catalogo merch è temporaneamente vuoto.</p>
            </div>
        <% } else { %>
            <div class="merch-grid">
                <% for (ProductBean product : products) { %>
                    <div class="product-card">
                        <div class="product-card-img-container">
                            <div class="product-card-img-placeholder"></div>
                        </div>
                        <div class="product-card-body">
                            <span class="product-artist">VibeShop</span>
                            <h3 class="product-title"><%= h(product.getNome()) %></h3>
                            <span class="product-price"><%= money.format(product.getPrezzo()) %></span>
                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="idProdotto" value="<%= product.getIdProdotto() %>">
                                <input type="hidden" name="quantity" value="1">
                                <button type="submit" class="auth-primary-btn">Aggiungi al carrello</button>
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
