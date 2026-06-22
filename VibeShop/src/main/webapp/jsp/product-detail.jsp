<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    ProductBean product = (ProductBean) request.getAttribute("product");
    NumberFormat money = NumberFormat.getCurrencyInstance(Locale.ITALY);
    Object cartObject = session.getAttribute("cart");
    Cart cart = cartObject instanceof Cart ? (Cart) cartObject : null;
    String key = product == null ? "" : CartItem.TYPE_PRODUCT + "-" + product.getIdProdotto();
    int quantity = cart == null ? 0 : cart.getQuantity(key);
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%= product == null ? "Prodotto" : h(product.getNome()) %> - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/merch.css" />
</head>
<body>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<main class="main-content product-detail-main">
    <% if (product != null) { %>
        <a href="${pageContext.request.contextPath}/merch" class="product-back-link">← Torna al merch</a>
        <section class="product-detail-card">
            <div class="product-detail-media">
                <% if (hasText(product.getImmagine())) { %>
                    <img src="${pageContext.request.contextPath}/<%= h(product.getImmagine()) %>" alt="<%= h(product.getNome()) %>" />
                <% } else { %>
                    <div class="product-detail-placeholder">VS</div>
                <% } %>
            </div>
            <div class="product-detail-info">
                <span class="product-artist">Merch ufficiale</span>
                <h1><%= h(product.getNome()) %></h1>
                <% if (hasText(product.getDescrizione())) { %>
                    <p class="product-detail-description"><%= h(product.getDescrizione()) %></p>
                <% } %>
                <div class="product-detail-meta">
                    <span>IVA <%= product.getIva() == null ? "22.00" : product.getIva() %>% inclusa</span>
                    <strong><%= product.getPrezzo() == null ? "" : money.format(product.getPrezzo()) %></strong>
                </div>
                <div class="product-cart-control product-detail-cart" data-product-id="<%= product.getIdProdotto() %>">
                    <button type="button" class="auth-primary-btn merch-add-btn <%= quantity > 0 ? "is-hidden" : "" %>">Aggiungi al carrello</button>
                    <div class="quantity-control <%= quantity > 0 ? "" : "is-hidden" %>">
                        <button type="button" class="qty-btn qty-minus">−</button>
                        <span class="qty-value"><%= quantity %></span>
                        <button type="button" class="qty-btn qty-plus">+</button>
                    </div>
                </div>
            </div>
        </section>
    <% } %>
</main>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
<script src="${pageContext.request.contextPath}/js/vibeshop-ajax.js"></script>
</body>
</html>
