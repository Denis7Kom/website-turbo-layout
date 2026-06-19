<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.Map" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Il tuo Carrello - VibeShop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css" />
</head>
<body>

<%
    // 1. Recuperiamo il carrello dalla sessione
    ArrayList<Map<String, Object>> carrello = (ArrayList<Map<String, Object>>) session.getAttribute("carrello_standard");
    
    // ⚠️ ECCO IL BLOCCO CHE MANCAVA! Creiamo il carrello e i 4 prodotti finti
    if (carrello == null) {
        carrello = new ArrayList<Map<String, Object>>();
        
        // Articolo 1
        Map<String, Object> p1 = new HashMap<String, Object>();
        p1.put("code", 1);
        p1.put("name", "T-Shirt Music Of The Spheres");
        p1.put("description", "Taglia: M - Cotone Nero");
        p1.put("price", 35.00);
        p1.put("quantity", 1);
        carrello.add(p1);
        
        // Articolo 2
        Map<String, Object> p2 = new HashMap<String, Object>();
        p2.put("code", 2);
        p2.put("name", "Biglietto - Stadi 2026 (Roma)");
        p2.put("description", "Settore: Prato Posto Unico");
        p2.put("price", 46.00);
        p2.put("quantity", 1);
        carrello.add(p2);

        // Articolo 3
        Map<String, Object> p3 = new HashMap<String, Object>();
        p3.put("code", 3);
        p3.put("name", "Vinile Exclusive Color Edition");
        p3.put("description", "Doppio LP - Edizione Limitata Trasparente");
        p3.put("price", 42.00);
        p3.put("quantity", 1);
        carrello.add(p3);
        
        // Articolo 4
        Map<String, Object> p4 = new HashMap<String, Object>();
        p4.put("code", 4);
        p4.put("name", "Felpa Hoodie Logo Glow");
        p4.put("description", "Taglia: L - Cotone Felpato Nero");
        p4.put("price", 60.00);
        p4.put("quantity", 1);
        carrello.add(p4);
        
        session.setAttribute("carrello_standard", carrello);
    }
    
    // 2. Gestione dei pulsanti (Aumenta, Diminuisci, Rimuovi)
    String action = request.getParameter("action");
    if (action != null) {
        String idParam = request.getParameter("idProdotto");
        if (idParam != null) {
            int id = Integer.parseInt(idParam);
            
            if (action.equalsIgnoreCase("remove")) {
                for (int i = 0; i < carrello.size(); i++) {
                    if ((Integer) carrello.get(i).get("code") == id) {
                        carrello.remove(i);
                        break;
                    }
                }
                request.setAttribute("messaggio", "Prodotto rimosso con successo dal carrello.");
            } 
            else if (action.equalsIgnoreCase("updateQty")) {
                String mod = request.getParameter("mod");
                for (Map<String, Object> item : carrello) {
                    if ((Integer) item.get("code") == id) {
                        int q = (Integer) item.get("quantity");
                        if ("inc".equalsIgnoreCase(mod)) {
                            item.put("quantity", q + 1);
                        } else if ("dec".equalsIgnoreCase(mod) && q > 1) {
                            item.put("quantity", q - 1);
                        }
                        break;
                    }
                }
            }
        }
    }
    
    // 3. Calcolo dei totali in tempo reale
    double totaleEuro = 0.0;
    int totalePezzi = 0;
    for (Map<String, Object> item : carrello) {
        int q = (Integer) item.get("quantity");
        double p = (Double) item.get("price");
        totaleEuro += (p * q);
        totalePezzi += q;
    }
    
    // Sincronizziamo il valore con il pallino rosso presente nel file header.jspf
    session.setAttribute("cartCount", totalePezzi);
%>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<main class="main-content">
    <h1 class="cart-page-title">Il tuo Carrello</h1>

    <% String messaggio = (String) request.getAttribute("messaggio"); 
       if (messaggio != null) { %>
        <div class="cart-alert-success"><%= messaggio %></div>
    <% } %>

    <div class="cart-container">
        
        <div class="cart-items-section">
            <% 
                if (!carrello.isEmpty()) {
                    for (Map<String, Object> item : carrello) {
                        int code = (Integer) item.get("code");
                        String name = (String) item.get("name");
                        String description = (String) item.get("description");
                        double price = (Double) item.get("price");
                        int quantity = (Integer) item.get("quantity");
                        double subtotal = price * quantity;
            %>
                        <div class="cart-row">
                            <div class="cart-item-img-placeholder"></div>
                            <div class="cart-item-details">
                                <span class="cart-item-artist">Articolo Ufficiale</span>
                                <h3 class="cart-item-title"><%= name %></h3>
                                <p class="cart-item-meta"><%= description %></p>
                            </div>
                            
                            <div class="cart-item-quantity">
                                <form action="${pageContext.request.contextPath}/jsp/cart.jsp" method="post" class="qty-form">
                                    <input type="hidden" name="action" value="updateQty">
                                    <input type="hidden" name="idProdotto" value="<%= code %>">
                                    <button type="submit" name="mod" value="dec" class="qty-btn">-</button>
                                    <input type="text" name="quantity" value="<%= quantity %>" readonly class="qty-input">
                                    <button type="submit" name="mod" value="inc" class="qty-btn">+</button>
                                </form>
                            </div>
                            
                            <div class="cart-item-price-block">
                                <span class="cart-item-price">€ <%= String.format("%.2f", subtotal) %></span>
                                <form action="${pageContext.request.contextPath}/jsp/cart.jsp" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="idProdotto" value="<%= code %>">
                                    <button type="submit" class="cart-remove-btn" title="Rimuovi elemento">Rimuovi</button>
                                </form>
                            </div>
                        </div>
            <% 
                    }
                } else { 
            %>
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
                    <span>€ <%= String.format("%.2f", totaleEuro) %></span>
                </div>
                <div class="summary-row">
                    <span>Spedizione</span>
                    <span class="free-shipping">Gratis</span>
                </div>
                
                <hr class="summary-divider">
                
                <div class="summary-row total-row">
                    <span>Totale (IVA incl.)</span>
                    <span>€ <%= String.format("%.2f", totaleEuro) %></span>
                </div>

                <a href="${pageContext.request.contextPath}/jsp/checkout.jsp" class="btn-checkout-cta">Procedi al Checkout</a>
                <a href="${pageContext.request.contextPath}/homepage.jsp" class="btn-continue-shopping">Continua lo Shopping</a>
            </div>
        </div>

    </div>
</main>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>

<script src="${pageContext.request.contextPath}/js/menu.js"></script>

</body>
</html>