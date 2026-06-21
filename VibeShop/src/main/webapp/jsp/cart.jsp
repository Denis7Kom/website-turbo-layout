<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Cart, model.CartItem" %>
<%
    Object cartObject = request.getAttribute("cart");
    Cart cart;

    if (cartObject instanceof Cart) {
        cart = (Cart) cartObject;
    } else if (session.getAttribute("cart") instanceof Cart) {
        cart = (Cart) session.getAttribute("cart");
    } else {
        cart = new Cart();
        session.setAttribute("cart", cart);
    }

    session.setAttribute("cartCount", cart.getTotalQuantity());
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Il tuo Carrello - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css" />
</head>
<body>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<main class="main-content">
    <h1 class="cart-page-title">Il tuo Carrello</h1>

    <% if ("true".equals(request.getParameter("added"))) { %>
        <div class="cart-alert-success">Prodotto aggiunto al carrello.</div>
    <% } %>

    <div class="cart-container">
        <div class="cart-items-section">
            <% if (!cart.isEmpty()) { %>
                <% for (CartItem item : cart.getItems()) { %>
                    <div class="cart-row">
                        <div class="cart-item-img-placeholder"></div>
                        <div class="cart-item-details">
                            <span class="cart-item-artist">Articolo Ufficiale</span>
                            <h3 class="cart-item-title"><%= item.getItemName() %></h3>
                            <p class="cart-item-meta"><%= item.getDescription() == null ? "" : item.getDescription() %></p>
                        </div>

                        <div class="cart-item-quantity">
                            <form action="${pageContext.request.contextPath}/cart" method="post" class="qty-form">
                                <input type="hidden" name="cartKey" value="<%= item.getCartKey() %>">
                                <button type="submit" name="action" value="decrease" class="qty-btn">-</button>
                                <input type="text" name="quantity" value="<%= item.getQuantity() %>" readonly class="qty-input">
                                <button type="submit" name="action" value="increase" class="qty-btn">+</button>
                            </form>
                        </div>

                        <div class="cart-item-price-block">
                            <span class="cart-item-price">€ <%= item.getSubtotal() %></span>
                            <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="cartKey" value="<%= item.getCartKey() %>">
                                <button type="submit" class="cart-remove-btn" title="Rimuovi elemento">Rimuovi</button>
                            </form>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                <div class="cart-row">
                    <p style="color: var(--text-dim); font-weight: 500;">Il tuo carrello è vuoto. Torna a scoprire i Concerti o il Merch!</p>
                </div>
            <% } %>
        </div>

        <div class="cart-summary-section">
            <div class="summary-card">
                <h2>Riepilogo Ordine</h2>

                <div class="summary-row">
                    <span>Subtotale Articoli</span>
                    <span>€ <%= cart.getTotalPrice() %></span>
                </div>
                <div class="summary-row">
                    <span>Spedizione</span>
                    <span class="free-shipping">Gratis</span>
                </div>

                <hr class="summary-divider">

                <div class="summary-row total-row">
                    <span>Totale (IVA incl.)</span>
                    <span>€ <%= cart.getTotalPrice() %></span>
                </div>

                <% if (!cart.isEmpty()) { %>
                    <a href="${pageContext.request.contextPath}/checkout" class="btn-checkout-cta">Procedi al Checkout</a>
                    <form action="${pageContext.request.contextPath}/cart" method="post">
                        <button type="submit" name="action" value="clear" class="btn-continue-shopping">Svuota carrello</button>
                    </form>
                <% } %>
                <a href="${pageContext.request.contextPath}/merch" class="btn-continue-shopping">Continua lo Shopping</a>
            </div>
        </div>
    </div>
</main>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>

</body>
</html>
