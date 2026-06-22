<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="model.OrderBean" %>
<%!
    private String h(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
    }

    private String statusBadgeClass(String status) {
        if (status == null) return "unknown";
        if ("IN_ELABORAZIONE".equalsIgnoreCase(status)) return "processing";
        if ("ANNULLATO".equalsIgnoreCase(status)) return "cancelled";
        if ("CONFERMATO".equalsIgnoreCase(status)) return "completed";
        return "unknown";
    }

    private String displayStatus(String status) {
        return status == null ? "" : status.replace("_", " ");
    }
%>
<%
    Object ordersObject = request.getAttribute("orders");
    if (ordersObject == null) {
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        return;
    }

    List<OrderBean> orders = ordersObject instanceof List ? (List<OrderBean>) ordersObject : new ArrayList<OrderBean>();
    NumberFormat money = NumberFormat.getCurrencyInstance(Locale.ITALY);
    Object revenueObject = request.getAttribute("revenue");
    BigDecimal revenue = revenueObject instanceof BigDecimal ? (BigDecimal) revenueObject : BigDecimal.ZERO;
    Object orderCountObject = request.getAttribute("orderCount");
    Object productCountObject = request.getAttribute("productCount");
    Object concertCountObject = request.getAttribute("concertCount");
    int orderCount = orderCountObject instanceof Integer ? (Integer) orderCountObject : orders.size();
    int productCount = productCountObject instanceof Integer ? (Integer) productCountObject : 0;
    int concertCount = concertCountObject instanceof Integer ? (Integer) concertCountObject : 0;
%>
<!DOCTYPE html>
<html lang="it"><head><meta charset="UTF-8" /><meta name="viewport" content="width=device-width, initial-scale=1.0" /><title>Pannello Amministratore - VibeShop</title><link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" /><link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" /><link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css" /></head><body>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>
<main class="admin-main-container"><header class="admin-hero"><div class="admin-welcome-box"><div class="admin-icon admin-icon-logo"><img src="${pageContext.request.contextPath}/img/logo.svg" alt="VibeShop" /></div><div class="admin-welcome-text"><h1>Pannello di Controllo</h1><p>Dati caricati dinamicamente dal database MySQL.</p></div></div><div class="admin-quick-stats"><div class="quick-stat"><span class="stat-val"><%= money.format(revenue) %></span><span class="stat-lbl">Entrate totali</span></div><div class="quick-stat"><span class="stat-val"><%= orderCount %></span><span class="stat-lbl">Ordini</span></div><div class="quick-stat"><span class="stat-val"><%= productCount %></span><span class="stat-lbl">Prodotti attivi</span></div><div class="quick-stat"><span class="stat-val"><%= concertCount %></span><span class="stat-lbl">Concerti</span></div></div></header>
<div class="admin-content-grid"><aside class="admin-sidebar"><nav class="sidebar-nav"><a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Panoramica</a><a href="${pageContext.request.contextPath}/admin/orders">Gestione Ordini</a><a href="${pageContext.request.contextPath}/admin/products">Gestione Prodotti, Concerti e Biglietti</a><a href="${pageContext.request.contextPath}/logout" class="logout-link">Disconnetti</a></nav></aside><div class="admin-main-view"><section class="card-vibe"><div class="section-title-row"><h2>Ultimi Ordini Ricevuti</h2><a href="${pageContext.request.contextPath}/admin/orders" class="edit-link">Vedi Tutto</a></div><div class="table-responsive"><table class="admin-table"><thead><tr><th>Codice Ordine</th><th>Cliente</th><th>Data</th><th>Totale</th><th>Stato</th><th>Azione</th></tr></thead><tbody>
<% if (orders.isEmpty()) { %><tr><td colspan="6">Nessun ordine trovato.</td></tr><% } else { %><% for (int i = 0; i < orders.size() && i < 5; i++) { OrderBean order = orders.get(i); String stato = order.getStatoOrdine(); %><tr><td><strong>#<%= order.getIdOrdine() %></strong></td><td>ID <%= order.getIdUtente() %></td><td><%= order.getDataOrdine() %></td><td><%= order.getTotalPrice() == null ? money.format(BigDecimal.ZERO) : money.format(order.getTotalPrice()) %></td><td><span class="badge <%= statusBadgeClass(stato) %>"><%= h(displayStatus(stato)) %></span></td><td><a href="${pageContext.request.contextPath}/admin/orders" class="btn-manage">Gestisci</a></td></tr><% } %><% } %>
</tbody></table></div></section></div></div></main>
<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script></body></html>
