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

    private String productMessage(String action) {
        if ("created".equals(action)) {
            return "Prodotto creato correttamente.";
        }
        if ("updated".equals(action)) {
            return "Prodotto aggiornato correttamente.";
        }
        if ("deleted".equals(action)) {
            return "Prodotto disattivato correttamente.";
        }
        if ("delete-error".equals(action)) {
            return "Impossibile disattivare il prodotto selezionato.";
        }
        return null;
    }

    private boolean isErrorMessage(String action) {
        return "delete-error".equals(action);
    }
%>
<%
    Object data = request.getAttribute("products");
    List<ProductBean> products = data instanceof List ? (List<ProductBean>) data : new ArrayList<ProductBean>();
    NumberFormat money = NumberFormat.getCurrencyInstance(Locale.ITALY);
    String productAction = request.getParameter("productAction");
    String productMessage = productMessage(productAction);
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestione Prodotti - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css" />
</head>
<body>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>
<main class="admin-main-container">
    <header class="admin-hero">
        <div class="admin-welcome-box"><div class="admin-icon admin-icon-logo"><img src="${pageContext.request.contextPath}/img/logo.svg" alt="VibeShop" /></div><div class="admin-welcome-text"><h1>Gestione Prodotti</h1><p>Catalogo prodotti collegato al database.</p></div></div>
        <div class="admin-quick-stats"><div class="quick-stat"><span class="stat-val"><%= products.size() %></span><span class="stat-lbl">Articoli attivi</span></div></div>
    </header>
    <div class="admin-content-grid">
        <aside class="admin-sidebar"><nav class="sidebar-nav"><a href="${pageContext.request.contextPath}/admin/dashboard">Panoramica</a><a href="${pageContext.request.contextPath}/admin/orders">Gestione Ordini</a><a href="${pageContext.request.contextPath}/admin/products" class="active">Gestione Prodotti</a><a href="${pageContext.request.contextPath}/admin/concerts">Gestione Concerti</a><a href="${pageContext.request.contextPath}/logout" class="logout-link">Disconnetti</a></nav></aside>
        <div class="admin-main-view"><section class="card-vibe"><div class="section-title-row"><h2>Catalogo Articoli</h2><a href="${pageContext.request.contextPath}/admin/product-form" class="btn-add-product">Aggiungi Prodotto</a></div>
            <% if (productMessage != null && isErrorMessage(productAction)) { %>
                <div class="admin-form-error"><%= h(productMessage) %></div>
            <% } else if (productMessage != null) { %>
                <div style="padding: 14px 18px; margin-bottom: 22px; border-radius: 12px; border: 1px solid rgba(46, 125, 50, 0.18); background: var(--success-bg); color: var(--success); font-size: 14px;"><%= h(productMessage) %></div>
            <% } %>
            <div class="admin-filters-bar"><div class="filter-group-search"><label for="searchProduct">Cerca nel catalogo</label><input type="text" id="searchProduct" placeholder="Cerca per nome prodotto" /></div></div>
            <div class="table-responsive"><table class="admin-table" id="adminProductsTable"><thead><tr><th>Prodotto</th><th>Prezzo</th><th>IVA</th><th>Azioni</th></tr></thead><tbody>
                <% if (products.isEmpty()) { %>
                    <tr><td colspan="4">Nessun prodotto attivo.</td></tr>
                <% } else { %>
                    <% for (ProductBean product : products) { %>
                        <tr><td><strong><%= h(product.getNome()) %></strong><br><span><%= h(product.getDescrizione()) %></span></td><td><%= money.format(product.getPrezzo()) %></td><td><%= product.getIva() %>%</td><td><div class="admin-actions-cell"><a href="${pageContext.request.contextPath}/admin/product-form?id=<%= product.getIdProdotto() %>" class="btn-table-edit">Modifica</a><form action="${pageContext.request.contextPath}/admin/products/delete" method="post" onsubmit="return confirm('Vuoi davvero disattivare questo prodotto?');"><input type="hidden" name="id" value="<%= product.getIdProdotto() %>"><button type="submit" class="btn-table-delete">Disattiva</button></form></div></td></tr>
                    <% } %>
                <% } %>
            </tbody></table></div>
        </section></div>
    </div>
</main>
<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script><script src="${pageContext.request.contextPath}/js/vibeshop-ajax.js"></script>
</body>
</html>
