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
    String error = (String) request.getAttribute("error");
    String nome = request.getParameter("nome") != null ? request.getParameter("nome") : (user == null ? "" : user.getNome());
    String cognome = request.getParameter("cognome") != null ? request.getParameter("cognome") : (user == null ? "" : user.getCognome());
    String username = request.getParameter("username") != null ? request.getParameter("username") : (user == null ? "" : user.getUsername());
    String email = request.getParameter("email") != null ? request.getParameter("email") : (user == null ? "" : user.getEmail());
    String telefono = request.getParameter("telefono") != null ? request.getParameter("telefono") : (user == null ? "" : user.getCellulare());
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Modifica account - VibeShop</title>
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
            <div class="avatar-circle">ED</div>
            <div class="profile-welcome">
                <h1>Modifica account</h1>
                <p>Aggiorna username, email, telefono e password.</p>
            </div>
        </div>
        <div class="profile-stats">
            <a href="${pageContext.request.contextPath}/profile" class="stat-link">
                <div class="stat-item">
                    <span class="stat-value">←</span>
                    <span class="stat-label">Profilo</span>
                </div>
            </a>
        </div>
    </header>

    <section class="profile-sidebar">
        <div class="card-vibe">
            <div class="section-title-row">
                <h2>Dati account</h2>
                <a href="${pageContext.request.contextPath}/profile" class="edit-link">Annulla</a>
            </div>

            <% if (error != null && !error.trim().isEmpty()) { %>
                <div class="profile-alert error"><%= h(error) %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/account/update" method="post" class="profile-form">
                <div class="profile-form-grid">
                    <div class="profile-field">
                        <label for="nome">Nome</label>
                        <input type="text" id="nome" name="nome" value="<%= h(nome) %>" required />
                    </div>
                    <div class="profile-field">
                        <label for="cognome">Cognome</label>
                        <input type="text" id="cognome" name="cognome" value="<%= h(cognome) %>" required />
                    </div>
                </div>

                <div class="profile-form-grid">
                    <div class="profile-field">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" value="<%= h(username) %>" pattern="[A-Za-z0-9._-]{3,30}" title="3-30 caratteri: lettere, numeri, punto, trattino o underscore" required />
                    </div>
                    <div class="profile-field">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" value="<%= h(email) %>" required />
                    </div>
                </div>

                <div class="profile-field">
                    <label for="telefono">Telefono</label>
                    <input type="tel" id="telefono" name="telefono" value="<%= h(telefono) %>" pattern="\+?[0-9 .()\-]{7,20}" required />
                </div>

                <div class="profile-password-box">
                    <h3>Cambio password opzionale</h3>
                    <p>Lascia i campi vuoti se non vuoi modificare la password.</p>
                    <div class="profile-form-grid">
                        <div class="profile-field">
                            <label for="newPassword">Nuova password</label>
                            <input type="password" id="newPassword" name="newPassword" minlength="8" autocomplete="new-password" />
                        </div>
                        <div class="profile-field">
                            <label for="confirmPassword">Conferma nuova password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" minlength="8" autocomplete="new-password" />
                        </div>
                    </div>
                </div>

                <div class="profile-form-actions">
                    <button type="submit" class="edit-link profile-submit">Salva modifiche</button>
                    <a href="${pageContext.request.contextPath}/profile" class="logout-link profile-cancel">Annulla</a>
                </div>
            </form>
        </div>
    </section>
</main>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
