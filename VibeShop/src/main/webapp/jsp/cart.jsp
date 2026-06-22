<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.Cart, model.CartItem" %>
<%!
    private String h(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
    }
%>
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

    NumberFormat money = NumberFormat.getCurrencyInstance(Locale.ITALY);
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart-polish.css" />
</head>
<body>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<main class="main-content">
    <h1 class="cart-page-title">Il tuo Carrello</h1>

    <% if ("true".equals(request.getParameter("added"))) { %>
        <div class="cart-alert-success">Articolo aggiunto al carrello.</div>
    <% } %>

    <div class="cart-container">
        <div class="cart-items-section" id="cart-items-section">
            <div id="cart-empty-message" class="cart-row" style="<%= cart.isEmpty() ? "" : "display:none;" %>">
                <p style="color: var(--text-dim); font-weight: 500;">Il tuo carrello è vuoto. Torna a scoprire i Concerti o il Merch!</p>
            </div>

            <% if (!cart.isEmpty()) { %>
                <% for (CartItem item : cart.getItems()) {
                    String cartKey = item.getCartKey();
                    String unitPrice = item.getUnitPrice() == null ? "0" : item.getUnitPrice().toPlainString();
                    boolean ticket = CartItem.TYPE_CONCERT.equals(item.getItemType());
                %>
                    <div class="cart-row" data-cart-key="<%= h(cartKey) %>" data-unit-price="<%= h(unitPrice) %>">
                        <div class="cart-item-img-placeholder <%= ticket ? "ticket-gradient" : "" %>"></div>
                        <div class="cart-item-details">
                            <span class="cart-item-artist"><%= ticket ? "Biglietto" : "Articolo Ufficiale" %></span>
                            <h3 class="cart-item-title"><%= h(item.getItemName()) %></h3>
                            <p class="cart-item-meta"><%= h(item.getDescription()) %></p>
                        </div>

                        <div class="cart-item-quantity">
                            <form action="${pageContext.request.contextPath}/cart" method="post" class="qty-form cart-qty-form">
                                <input type="hidden" name="cartKey" value="<%= h(cartKey) %>">
                                <button type="submit" name="action" value="decrease" class="qty-btn">-</button>
                                <input type="text" name="quantity" value="<%= item.getQuantity() %>" readonly class="qty-input">
                                <button type="submit" name="action" value="increase" class="qty-btn">+</button>
                            </form>
                        </div>

                        <div class="cart-item-price-block">
                            <span class="cart-item-price" data-cart-subtotal><%= money.format(item.getSubtotal()) %></span>
                            <form action="${pageContext.request.contextPath}/cart" method="post" class="cart-remove-form" style="display:inline;">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="cartKey" value="<%= h(cartKey) %>">
                                <button type="submit" class="cart-remove-btn" title="Rimuovi elemento">Rimuovi</button>
                            </form>
                        </div>
                    </div>
                <% } %>
            <% } %>
        </div>

        <div class="cart-summary-section">
            <div class="summary-card">
                <h2>Riepilogo Ordine</h2>

                <div class="summary-row">
                    <span>Subtotale Articoli</span>
                    <span data-cart-total><%= money.format(cart.getTotalPrice()) %></span>
                </div>
                <div class="summary-row">
                    <span>Spedizione</span>
                    <span class="free-shipping">Gratis</span>
                </div>

                <hr class="summary-divider">

                <div class="summary-row total-row">
                    <span>Totale IVA incl.</span>
                    <span data-cart-total><%= money.format(cart.getTotalPrice()) %></span>
                </div>

                <a href="${pageContext.request.contextPath}/checkout" class="btn-checkout-cta" data-checkout-link style="<%= cart.isEmpty() ? "display:none;" : "" %>">Procedi al Checkout</a>
                <form action="${pageContext.request.contextPath}/cart" method="post" class="cart-clear-form" style="<%= cart.isEmpty() ? "display:none;" : "" %>">
                    <button type="submit" name="action" value="clear" class="btn-continue-shopping">Svuota carrello</button>
                </form>
                <a href="${pageContext.request.contextPath}/merch" class="btn-continue-shopping">Continua lo Shopping</a>
            </div>
        </div>
    </div>
</main>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
<script src="${pageContext.request.contextPath}/js/vibeshop-ajax.js"></script>

</body>
</html>
