<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.UserBean" %>
<%!
    private String h(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
    }
%>
<%
    Object userObject = session.getAttribute("user");
    UserBean user = userObject instanceof UserBean ? (UserBean) userObject : null;
    String nome = user == null ? "Utente" : user.getNome();
    String cognome = user == null ? "" : user.getCognome();
    String username = user == null ? "" : user.getUsername();
    String email = user == null ? "" : user.getEmail();
    String telefono = user == null ? "" : user.getCellulare();
    String role = user == null ? "" : user.getRole();
    String initials = nome == null || nome.isEmpty() ? "U" : nome.substring(0, 1).toUpperCase();
    boolean updated = "true".equals(request.getParameter("updated"));
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard Profilo - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css" />
</head>
<body>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<main class="profile-main-container">

    <header class="profile-hero">
        <div class="profile-avatar-box">
            <div class="avatar-circle"><%= h(initials) %></div>
            <div class="profile-welcome">
                <h1>Ciao, <%= h(nome) %></h1>
                <p>Area personale VibeShop</p>
            </div>
        </div>

        <div class="profile-stats">
            <a href="${pageContext.request.contextPath}/orders" class="stat-link">
                <div class="stat-item">
                    <span class="stat-value">→</span>
                    <span class="stat-label">Ordini</span>
                </div>
            </a>
        </div>
    </header>

    <% if (updated) { %>
        <div class="profile-alert success">Dati account aggiornati correttamente.</div>
    <% } %>

    <div class="profile-content-grid">
        <aside class="profile-sidebar">
            <nav class="sidebar-nav">
                <div class="profile-main-view active" id="info-section">
                    <section class="card-vibe">
                        <div class="section-title-row">
                            <h2>Informazioni Personali</h2>
                            <a href="${pageContext.request.contextPath}/account/edit" class="edit-link">Modifica</a>
                        </div>

                        <div class="info-grid">
                            <div class="info-field">
                                <label>Nome Completo</label>
                                <p><%= h(nome) %> <%= h(cognome) %></p>
                            </div>
                            <div class="info-field">
                                <label>Username</label>
                                <p><%= h(username) %></p>
                            </div>
                            <div class="info-field">
                                <label>Email</label>
                                <p><%= h(email) %></p>
                            </div>
                            <div class="info-field">
                                <label>Telefono</label>
                                <p><%= h(telefono) %></p>
                            </div>
                            <div class="info-field">
                                <label>Ruolo</label>
                                <p><%= h(role) %></p>
                            </div>
                            <div class="info-field">
                                <label>Metodo di Pagamento</label>
                                <p>Gestito durante il checkout</p>
                            </div>
                        </div>
                    </section>
                </div>

                <a href="${pageContext.request.contextPath}/logout" class="logout-link">Disconnetti</a>
            </nav>
        </aside>
    </div>
</main>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
