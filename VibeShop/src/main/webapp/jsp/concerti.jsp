<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.ConcertoBean" %>
<%@ page import="model.Cart" %>
<%@ page import="model.CartItem" %>
<%!
    private String h(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
    }

    private int concertImageNumber(int index) {
        return (Math.abs(index) % 13) + 1;
    }

    private String concertImage(int index) {
        return "img/concerti/" + concertImageNumber(index) + ".jpg";
    }
%>
<%
    Object concertsObject = request.getAttribute("concerts");
    if (concertsObject == null) {
        response.sendRedirect(request.getContextPath() + "/concerti");
        return;
    }

    List<ConcertoBean> concerts;
    if (concertsObject instanceof List) {
        concerts = (List<ConcertoBean>) concertsObject;
    } else {
        concerts = new ArrayList<ConcertoBean>();
    }

    Object cartObject = session.getAttribute("cart");
    Cart cart = cartObject instanceof Cart ? (Cart) cartObject : null;
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
<div class="concerti-hero"><div class="concerti-hero-inner"><span class="concerti-hero-label">Vivi l'atmosfera Live</span><h1>I Concerti<br>più attesi</h1><p>Trova gli eventi collegati al catalogo VibeShop e aggiungi i biglietti al carrello.</p></div><div class="concerti-hero-fade"></div></div>
<main class="main-content"><section class="section-container"><div class="section-header"><h2>Tutti i concerti</h2></div>
    <% if (concerts.isEmpty()) { %><p>Nessun concerto disponibile al momento.</p><% } else { %>
        <div class="concerti-grid">
            <% for (int i = 0; i < concerts.size(); i++) { ConcertoBean concert = concerts.get(i);
                String key = CartItem.TYPE_CONCERT + "-" + concert.getIdConcerto();
                int quantity = cart == null ? 0 : cart.getQuantity(key);
            %>
                <div class="concerto-card">
                    <div class="concerto-card-img"><img src="${pageContext.request.contextPath}/<%= h(concertImage(i)) %>" data-concert-image-base="${pageContext.request.contextPath}/img/concerti/<%= concertImageNumber(i) %>" data-fallback-index="0" data-logo-fallback="${pageContext.request.contextPath}/img/logo.svg" onerror="fallbackConcertImage(this)" alt="<%= h(concert.getNome()) %>"><span class="date-badge"><%= concert.getDataEvento() == null ? "LIVE" : new SimpleDateFormat("dd").format(concert.getDataEvento()) %><br><small><%= concert.getDataEvento() == null ? "" : new SimpleDateFormat("MMM", Locale.ITALY).format(concert.getDataEvento()).toUpperCase() %></small></span></div>
                    <div class="concerto-card-body">
                        <span class="concerto-card-artista"><%= h(concert.getNome()) %></span>
                        <span class="concerto-card-location"><%= h(concert.getLuogo()) %></span>
                        <span class="concerto-card-prezzo">Da <%= money.format(concert.getPrezzo()) %></span>
                        <% if (concert.getDataEvento() != null) { %><span class="concerto-card-location"><%= dateFormat.format(concert.getDataEvento()) %></span><% } %>
                        <div class="concert-cart-control" data-concert-id="<%= concert.getIdConcerto() %>" data-cart-key="<%= h(key) %>">
                            <button type="button" class="btn-acquista ticket-add-btn <%= quantity > 0 ? "is-hidden" : "" %>">Acquista Biglietto</button>
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
</section></main>
<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
<script src="${pageContext.request.contextPath}/js/vibeshop-ajax.js"></script>
<script>
    function fallbackConcertImage(img) {
        const extensions = ["png", "jpeg", "webp", "avif"];
        const index = Number(img.dataset.fallbackIndex || "0");
        const base = img.dataset.concertImageBase;

        if (base && index < extensions.length) {
            img.dataset.fallbackIndex = String(index + 1);
            img.src = base + "." + extensions[index];
            return;
        }

        img.onerror = null;
        img.src = img.dataset.logoFallback || "${pageContext.request.contextPath}/img/logo.svg";
    }
</script>
</body>
</html>
