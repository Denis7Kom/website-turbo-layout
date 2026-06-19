<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, java.util.Map" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Checkout - VibeShop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout.css" />
</head>
<body>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<%
    // Recupero carrello dalla sessione
    ArrayList<Map<String, Object>> carrello = (ArrayList<Map<String, Object>>) session.getAttribute("carrello_standard");
    double totale = 0.0;
    
    if (carrello != null) {
        for (Map<String, Object> item : carrello) {
            totale += ((Double) item.get("price")) * ((Integer) item.get("quantity"));
        }
    }

    // Logica di conferma ordine
    boolean ordineCompletato = "POST".equalsIgnoreCase(request.getMethod()) && "placeOrder".equals(request.getParameter("action"));
    String numeroOrdine = "";
    if (ordineCompletato) {
        numeroOrdine = "VB-" + (int)(Math.random() * 899999 + 100000);
        session.removeAttribute("carrello_standard");
        session.setAttribute("cartCount", 0);
    }
%>

<main class="main-content">
    <h1 class="cart-page-title">Checkout</h1>

    <% if (!ordineCompletato) { %>
        <div class="checkout-grid">
            <form method="post" action="checkout.jsp" class="checkout-form">
                <input type="hidden" name="action" value="placeOrder">
                
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
                    <input type="text" placeholder="Nome intestatario" required class="input-field">
                    <input type="text" placeholder="Numero Carta (16 cifre)" required maxlength="16" class="input-field">
                    <div class="row-fields">
                        <input type="text" placeholder="MM/YY" required maxlength="5" class="input-field">
                        <input type="password" placeholder="CVV" required maxlength="3" class="input-field">
                    </div>
                </div>
                
                <button type="submit" class="btn-confirm-pay">Conferma e Paga €<%= String.format("%.2f", totale) %></button>
            </form>

            <div class="cart-summary-section">
                <div class="summary-card">
                    <h2>Riepilogo Ordine</h2>
                    <div class="summary-row"><span>Totale Articoli</span><strong>€ <%= String.format("%.2f", totale) %></strong></div>
                    <a href="${pageContext.request.contextPath}/jsp/cart.jsp" class="btn-modifica">Modifica Carrello</a>
                </div>
            </div>
        </div>
    <% } else { %>
        <div class="checkout-success">
            <h1>Grazie per l'ordine!</h1>
            <p>Codice Ordine: <strong><%= numeroOrdine %></strong></p>
            <a href="${pageContext.request.contextPath}/homepage.jsp" class="btn-back-home">Torna alla Home</a>
        </div>
    <% } %>
</main>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>

<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>