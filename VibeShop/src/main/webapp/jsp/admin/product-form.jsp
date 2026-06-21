<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.ProductBean" %>
<%!
    private String h(String value) {
        if (value == null) return "";
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
    }
%>
<%
    Object productObject = request.getAttribute("product");
    ProductBean product = productObject instanceof ProductBean ? (ProductBean) productObject : null;
    boolean editing = product != null;
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Prodotto - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css" />
</head>
<body>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>
<main class="admin-main-container">
    <header class="admin-hero"><div class="admin-welcome-box"><div class="admin-icon">ED</div><div class="admin-welcome-text"><h1><%= editing ? "Modifica Prodotto" : "Nuovo Prodotto" %></h1><p>Gestione del catalogo tramite Servlet e DAO.</p></div></div></header>
    <div class="admin-content-grid">
        <aside class="admin-sidebar"><nav class="sidebar-nav"><a href="${pageContext.request.contextPath}/jsp/admin/dashboard.jsp">Panoramica</a><a href="${pageContext.request.contextPath}/admin/orders">Gestione Ordini</a><a href="${pageContext.request.contextPath}/admin/products" class="active">Gestione Prodotti</a><a href="${pageContext.request.contextPath}/logout" class="logout-link">Disconnetti</a></nav></aside>
        <div class="admin-main-view"><section class="card-vibe admin-form-container">
            <div class="section-title-row"><h2>Dettagli Prodotto</h2><a href="${pageContext.request.contextPath}/admin/products" class="btn-cancel-link">Annulla</a></div>
            <form action="${pageContext.request.contextPath}/admin/products/save" method="post" class="vibe-admin-form">
                <input type="hidden" name="idProdotto" value="<%= editing ? product.getIdProdotto() : 0 %>">
                <div class="form-row"><div class="form-group flex-2"><label for="nome">Nome Prodotto</label><input type="text" id="nome" name="nome" value="<%= editing ? h(product.getNome()) : "" %>" required /></div><div class="form-group flex-1"><label for="idArtista">ID Artista</label><input type="number" id="idArtista" name="idArtista" value="<%= editing && product.getIdArtista() != null ? product.getIdArtista() : "" %>" /></div></div>
                <div class="form-row"><div class="form-group flex-1"><label for="prezzo">Prezzo</label><input type="number" id="prezzo" name="prezzo" step="0.01" min="0" value="<%= editing && product.getPrezzo() != null ? product.getPrezzo() : "" %>" required /></div><div class="form-group flex-1"><label for="iva">IVA</label><input type="number" id="iva" name="iva" step="0.01" min="0" value="<%= editing && product.getIva() != null ? product.getIva() : "22.00" %>" required /></div><div class="form-group flex-1"><label for="immagine">Immagine</label><input type="text" id="immagine" name="immagine" value="<%= editing ? h(product.getImmagine()) : "" %>" /></div></div>
                <div class="form-group"><label for="descrizione">Descrizione</label><textarea id="descrizione" name="descrizione" rows="4"><%= editing ? h(product.getDescrizione()) : "" %></textarea></div>
                <div class="form-actions"><button type="submit" class="btn-save-product">Salva nel Catalogo</button></div>
            </form>
        </section></div>
    </div>
</main>
<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
