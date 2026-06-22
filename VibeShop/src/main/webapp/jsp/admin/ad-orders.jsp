<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.OrderBean" %>
<%!
    private String h(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
    }

    private String statusBadgeClass(String status) {
        if (status == null) {
            return "unknown";
        }

        if ("IN_ELABORAZIONE".equalsIgnoreCase(status)) {
            return "processing";
        }

        if ("ANNULLATO".equalsIgnoreCase(status)) {
            return "cancelled";
        }

        if ("CONFERMATO".equalsIgnoreCase(status)) {
            return "completed";
        }

        return "unknown";
    }

    private String selectedStatus(String currentStatus, String optionStatus) {
        return optionStatus.equalsIgnoreCase(currentStatus == null ? "" : currentStatus) ? "selected" : "";
    }
%>
<%
    Object ordersObject = request.getAttribute("orders");
    List<OrderBean> orders = ordersObject instanceof List ? (List<OrderBean>) ordersObject : new ArrayList<OrderBean>();
    NumberFormat money = NumberFormat.getCurrencyInstance(Locale.ITALY);
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestione Ordini - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css" />
</head>
<body>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>
<main class="admin-main-container">
    <header class="admin-hero">
        <div class="admin-welcome-box">
            <div class="admin-icon admin-icon-logo"><img src="${pageContext.request.contextPath}/img/logo.svg" alt="VibeShop" /></div>
            <div class="admin-welcome-text">
                <h1>Gestione Ordini</h1>
                <p>Ordini letti dal database MySQL.</p>
            </div>
        </div>
        <div class="admin-quick-stats">
            <div class="quick-stat">
                <span class="stat-val"><%= orders.size() %></span>
                <span class="stat-lbl">Ordini</span>
            </div>
        </div>
    </header>
    <div class="admin-content-grid">
        <aside class="admin-sidebar">
            <nav class="sidebar-nav">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Panoramica</a>
                <a href="${pageContext.request.contextPath}/admin/orders" class="active">Gestione Ordini</a>
                <a href="${pageContext.request.contextPath}/admin/products">Gestione Prodotti</a>
                <a href="${pageContext.request.contextPath}/admin/concerts">Gestione Concerti e Biglietti</a>
                <a href="${pageContext.request.contextPath}/logout" class="logout-link">Disconnetti</a>
            </nav>
        </aside>
        <div class="admin-main-view">
            <section class="card-vibe">
                <div class="section-title-row"><h2>Registro Ordini Ricevuti</h2></div>
                <form class="admin-filters-bar" method="get" action="${pageContext.request.contextPath}/admin/orders">
                    <div class="filter-group-select"><label for="idUtente">ID Cliente</label><input type="number" id="idUtente" name="idUtente" placeholder="Es. 1" /></div>
                    <div class="filter-group-select"><label for="from">Da</label><input type="date" id="from" name="from" /></div>
                    <div class="filter-group-select"><label for="to">A</label><input type="date" id="to" name="to" /></div>
                    <button type="submit" class="btn-table-edit">Filtra</button>
                </form>
                <div class="table-responsive">
                    <table class="admin-table">
                        <thead><tr><th>Codice Ordine</th><th>ID Cliente</th><th>Data</th><th>Totale</th><th>Pagamento</th><th>Stato</th><th>Azioni</th></tr></thead>
                        <tbody>
                            <% if (orders.isEmpty()) { %>
                                <tr><td colspan="7">Nessun ordine trovato.</td></tr>
                            <% } else { %>
                                <% for (OrderBean order : orders) { String stato = order.getStatoOrdine(); %>
                                    <tr>
                                        <td><strong>#<%= order.getIdOrdine() %></strong></td>
                                        <td><%= order.getIdUtente() %></td>
                                        <td><%= order.getDataOrdine() %></td>
                                        <td><strong><%= money.format(order.getTotalPrice()) %></strong></td>
                                        <td><%= h(order.getTipoPagamento()) %></td>
                                        <td><span class="badge <%= statusBadgeClass(stato) %>"><%= h(stato) %></span></td>
                                        <td>
                                            <form method="post" action="${pageContext.request.contextPath}/admin/orders">
                                                <input type="hidden" name="idOrdine" value="<%= order.getIdOrdine() %>">
                                                <select name="statoOrdine">
                                                    <option value="CONFERMATO" <%= selectedStatus(stato, "CONFERMATO") %>>CONFERMATO</option>
                                                    <option value="IN_ELABORAZIONE" <%= selectedStatus(stato, "IN_ELABORAZIONE") %>>IN_ELABORAZIONE</option>
                                                    <option value="ANNULLATO" <%= selectedStatus(stato, "ANNULLATO") %>>ANNULLATO</option>
                                                </select>
                                                <button type="submit" class="btn-table-edit">Aggiorna</button>
                                            </form>
                                        </td>
                                    </tr>
                                <% } %>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
    </div>
</main>
<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
