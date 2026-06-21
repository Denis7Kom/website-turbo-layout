<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.OrderBean" %>
<%
    Object ordersObject = request.getAttribute("orders");
    List<OrderBean> orders = ordersObject instanceof List ? (List<OrderBean>) ordersObject : new ArrayList<OrderBean>();
%>
<!DOCTYPE html>
<html lang="it">
<head><meta charset="UTF-8" /><meta name="viewport" content="width=device-width, initial-scale=1.0" /><title>Gestione Ordini - VibeShop</title><link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" /><link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" /><link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css" /></head>
<body>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>
<main class="admin-main-container">
<header class="admin-hero"><div class="admin-welcome-box"><div class="admin-icon">OR</div><div class="admin-welcome-text"><h1>Gestione Ordini</h1><p>Ordini letti dal database.</p></div></div></header>
<div class="admin-content-grid">
<aside class="admin-sidebar"><nav class="sidebar-nav"><a href="${pageContext.request.contextPath}/jsp/admin/dashboard.jsp">Panoramica</a><a href="${pageContext.request.contextPath}/admin/orders" class="active">Gestione Ordini</a><a href="${pageContext.request.contextPath}/admin/products">Gestione Prodotti</a><a href="${pageContext.request.contextPath}/logout" class="logout-link">Disconnetti</a></nav></aside>
<div class="admin-main-view"><section class="card-vibe"><div class="section-title-row"><h2>Registro Ordini Ricevuti</h2></div><div class="table-responsive"><table class="admin-table">
<thead><tr><th>Ordine</th><th>Cliente</th><th>Data</th><th>Totale</th><th>Stato</th><th>Azioni</th></tr></thead><tbody>
<% if (orders.isEmpty()) { %><tr><td colspan="6">Nessun ordine trovato.</td></tr><% } else { %>
<% for (OrderBean order : orders) { %>
<tr><td>#<%= order.getIdOrdine() %></td><td><%= order.getIdUtente() %></td><td><%= order.getDataOrdine() %></td><td>€ <%= order.getTotalPrice() %></td><td><%= order.getStatoOrdine() %></td><td><form method="post" action="${pageContext.request.contextPath}/admin/orders"><input type="hidden" name="idOrdine" value="<%= order.getIdOrdine() %>"><select name="statoOrdine"><option>IN_LAVORAZIONE</option><option>SPEDITO</option><option>COMPLETATO</option></select><button type="submit" class="btn-table-edit">Salva</button></form></td></tr>
<% } %><% } %>
</tbody></table></div></section></div></div></main>
<%@ include file="/WEB-INF/fragments/footer.jspf" %><script src="${pageContext.request.contextPath}/js/menu.js"></script></body></html>
