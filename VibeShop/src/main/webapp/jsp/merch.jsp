<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.ProductBean" %>
<%@ page import="model.Cart" %>
<%@ page import="model.CartItem" %>
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
    String searchQuery = (String) request.getAttribute("searchQuery");
    Object cartObject = session.getAttribute("cart");
    Cart cart = cartObject instanceof Cart ? (Cart) cartObject : null;
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
    <div class="merch-hero-inner"><span class="merch-hero-label">Collezioni Esclusive</span><h1>Merch<br>Ufficiale</h1><p>Indossa la tua passione. T-shirt, felpe e accessori in edizione limitata<br>dei migliori artisti della scena.</p></div>
    <div class="merch-hero-fade"></div>
</div>
<main class="main-content">
    <div class="filter-bar"><div class="categories-capsules"><a href="${pageContext.request.contextPath}/merch" class="capsule active">Tutti i prodotti</a><a href="${pageContext.request.contextPath}/concerti" class="capsule">Biglietti</a><a href="${pageContext.request.contextPath}/home#artisti" class="capsule">Artisti</a></div></div>
    <section class="section-container">
        <% if (searchQuery != null && !searchQuery.trim().isEmpty()) { %><div class="section-header"><h2>Risultati per: <%= h(searchQuery) %></h2></div><% } %>
        <% if (products.isEmpty()) { %>
            <div class="empty-catalog-message"><h2>Nessun prodotto disponibile</h2><p>Il catalogo merch è temporaneamente vuoto o non ci sono risultati per la ricerca.</p></div>
        <% } else { %>
            <div class="merch-grid">
                <% for (ProductBean product : products) { String key = CartItem.TYPE_PRODUCT + "-" + product.getIdProdotto(); int quantity = cart == null ? 0 : cart.getQuantity(key); %>
                    <div class="product-card">
                        <a class="product-detail-link" href="${pageContext.request.contextPath}/product?id=<%= product.getIdProdotto() %>">
                            <% if (hasText(product.getImmagine())) { %><div class="product-card-img-container"><img class="product-card-img" src="${pageContext.request.contextPath}/<%= h(product.getImmagine()) %>" alt="<%= h(product.getNome()) %>"></div><% } %>
                            <span class="product-artist">VibeShop</span>
                            <h3 class="product-title"><%= h(product.getNome()) %></h3>
                            <% if (hasText(product.getDescrizione())) { %><p class="product-description"><%= h(product.getDescrizione()) %></p><% } %>
                        </a>
                        <div class="product-card-body">
                            <span class="product-price"><%= product.getPrezzo() == null ? "" : money.format(product.getPrezzo()) %></span>
                            <div class="product-cart-control" data-product-id="<%= product.getIdProdotto() %>">
                                <button type="button" class="auth-primary-btn merch-add-btn <%= quantity > 0 ? "is-hidden" : "" %>">Aggiungi al carrello</button>
                                <div class="quantity-control <%= quantity > 0 ? "" : "is-hidden" %>">
                                    <button type="button" class="qty-btn qty-minus">−</button>
                                    <span class="qty-value"><%= quantity %></span>
                                    <button type="button" class="qty-btn qty-plus">+</button>
                                </div>
                            </div>
                        </div>
                    </div>
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
