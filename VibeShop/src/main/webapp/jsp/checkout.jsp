<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Cart" %>
<%
    Object cartObject = request.getAttribute("cart");
    Cart cart;

    if (cartObject instanceof Cart) {
        cart = (Cart) cartObject;
    } else if (session.getAttribute("cart") instanceof Cart) {
        cart = (Cart) session.getAttribute("cart");
    } else {
        cart = new Cart();
    }

    boolean ordineCompletato = Boolean.TRUE.equals(request.getAttribute("orderCompleted"));
    Object orderId = request.getAttribute("orderId");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Checkout - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout.css" />
</head>
<body>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<main class="main-content">
    <h1 class="cart-page-title">Checkout</h1>

    <% if (ordineCompletato) { %>
        <div class="checkout-success">
            <h1>Grazie per l'ordine!</h1>
            <p>Codice Ordine: <strong>#<%= orderId %></strong></p>
            <a href="${pageContext.request.contextPath}/orders" class="btn-back-home">Vedi i miei ordini</a>
            <a href="${pageContext.request.contextPath}/homepage.jsp" class="btn-back-home">Torna alla Home</a>
        </div>
    <% } else if (cart == null || cart.isEmpty()) { %>
        <div class="checkout-success">
            <h1>Il carrello è vuoto</h1>
            <p>Aggiungi almeno un prodotto prima di procedere al checkout.</p>
            <a href="${pageContext.request.contextPath}/merch" class="btn-back-home">Vai al Merch</a>
        </div>
    <% } else { %>
        <div class="checkout-grid">
            <form method="post" action="${pageContext.request.contextPath}/checkout" class="checkout-form">
                <div class="checkout-card">
                    <h3>Indirizzo di Spedizione</h3>
                    <input type="text" name="nome" placeholder="Nome e Cognome" required class="input-field">
                    <input type="text" name="indirizzo" placeholder="Via e numero civico" required class="input-field">
                    <div class="row-fields">
                        <input type="text" name="citta" placeholder="Città" required class="input-field">
                        <input type="text" name="cap" placeholder="CAP" required class="input-field">
                    </div>
                </div>

                <div class="checkout-card">
                    <h3>Dati di Pagamento</h3>
                    <input type="hidden" name="tipoPagamento" value="Carta">
                    <input type="text" placeholder="Nome intestatario" required class="input-field">
                    <input type="text" placeholder="Numero Carta (16 cifre)" required maxlength="16" class="input-field">
                    <div class="row-fields">
                        <input type="text" placeholder="MM/YY" required maxlength="5" class="input-field">
                        <input type="password" placeholder="CVV" required maxlength="3" class="input-field">
                    </div>
                </div>

                <button type="submit" class="btn-confirm-pay">Conferma e Paga €<%= cart.getTotalPrice() %></button>
            </form>

            <div class="cart-summary-section">
                <div class="summary-card">
                    <h2>Riepilogo Ordine</h2>
                    <div class="summary-row"><span>Totale Articoli</span><strong>€ <%= cart.getTotalPrice() %></strong></div>
                    <a href="${pageContext.request.contextPath}/cart" class="btn-modifica">Modifica Carrello</a>
                </div>
            </div>
        </div>
    <% } %>
</main>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
