<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.UserBean" %>
<%@ page import="model.OrderBean" %>
<%@ page import="model.OrderItemBean" %>
<%!
    private String h(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
    }

    private String statusClass(String status) {
        if (status == null) return "unknown";
        if ("ANNULLATO".equalsIgnoreCase(status)) return "cancelled";
        if ("IN_ELABORAZIONE".equalsIgnoreCase(status)) return "processing";
        if ("CONFERMATO".equalsIgnoreCase(status)) return "completed";
        return "unknown";
    }

    private String displayStatus(String status) {
        return status == null ? "" : status.replace("_", " ");
    }
%>
<%
    Object userObject = session.getAttribute("user");
    UserBean user = userObject instanceof UserBean ? (UserBean) userObject : null;

    Object ordersObject = request.getAttribute("orders");
    List<OrderBean> orders = ordersObject instanceof List ? (List<OrderBean>) ordersObject : new ArrayList<OrderBean>();

    String userName = user == null ? "Utente" : user.getNome();
    String initials = userName == null || userName.isEmpty() ? "U" : userName.substring(0, 1).toUpperCase();
    NumberFormat money = NumberFormat.getCurrencyInstance(Locale.ITALY);
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>I miei Ordini - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/orders.css" />
</head>
<body>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<main class="profile-main-container">
    <header class="profile-hero">
        <div class="profile-avatar-box">
            <a href="${pageContext.request.contextPath}/profile" class="avatar-link">
                <div class="avatar-circle"><%= h(initials) %></div>
            </a>
            <div class="profile-welcome">
                <h1>Ciao, <%= h(userName) %></h1>
                <p>Cronologia ordini VibeShop</p>
            </div>
        </div>
    </header>

    <div class="profile-content-grid">
        <aside class="profile-sidebar">
            <nav class="sidebar-nav">
                <div class="profile-main-view active">
                    <section class="card-vibe">
                        <div class="section-title-row">
                            <h2>Cronologia Ordini</h2>
                            <span class="orders-count-badge"><%= orders.size() %> Ordini</span>
                        </div>

                        <div class="orders-list">
                            <% if (orders.isEmpty()) { %>
                                <div class="order-row-item">
                                    <div class="order-row-header">
                                        <div class="order-col-left">
                                            <span class="order-id">Nessun ordine</span>
                                            <span class="order-date">Non hai ancora completato acquisti.</span>
                                        </div>
                                    </div>
                                </div>
                            <% } else { %>
                                <% for (OrderBean order : orders) { String stato = order.getStatoOrdine(); %>
                                    <div class="order-row-item active">
                                        <div class="order-row-header">
                                            <div class="order-col-left">
                                                <span class="order-id">#<%= order.getIdOrdine() %></span>
                                                <span class="order-date"><%= order.getDataOrdine() %></span>
                                            </div>
                                            <div class="order-col-center">
                                                <div class="order-badge-status <%= statusClass(stato) %>"><%= h(displayStatus(stato)) %></div>
                                            </div>
                                            <div class="order-col-right">
                                                <span class="order-price"><%= money.format(order.getTotalPrice()) %></span>
                                            </div>
                                        </div>
                                        <div class="order-row-body">
                                            <div class="expanded-items-container">
                                                <% for (OrderItemBean item : order.getItems()) { %>
                                                    <div class="expanded-item-line">
                                                        <span class="item-name"><%= h(item.getItemName()) %></span>
                                                        <span class="item-qty">x<%= item.getQuantitaProdotto() == null ? item.getQuantitaBiglietti() : item.getQuantitaProdotto() %></span>
                                                        <span class="item-subprice"><%= money.format(item.getPrezzoTotale()) %></span>
                                                    </div>
                                                <% } %>
                                            </div>
                                        </div>
                                    </div>
                                <% } %>
                            <% } %>
                        </div>
                    </section>
                </div>
            </nav>
        </aside>
    </div>
</main>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
