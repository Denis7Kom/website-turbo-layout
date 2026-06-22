<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css" />
</head>
<body>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>
<main class="main-content auth-main">
    <h1 class="cart-page-title">Accedi al tuo account</h1>
    <div class="auth-layout">
        <aside class="auth-info-card">
            <span class="auth-eyebrow">Area personale</span>
            <h2>Ritrova biglietti, ordini e merchandising in un unico spazio.</h2>
            <p>Accedi per gestire gli acquisti, consultare il carrello e seguire gli aggiornamenti sugli eventi e sugli artisti che ti interessano.</p>
            <div class="auth-benefits">
                <div class="auth-benefit-item"><img src="${pageContext.request.contextPath}/img/tickets.svg" alt="Biglietti" /><div><h3>Biglietti sempre disponibili</h3><p>Consulta rapidamente gli ordini associati al tuo account.</p></div></div>
                <div class="auth-benefit-item"><img src="${pageContext.request.contextPath}/img/like.svg" alt="Artisti" /><div><h3>Artisti e novità</h3><p>Resta aggiornato su concerti, date e prodotti ufficiali.</p></div></div>
            </div>
        </aside>
        <section class="auth-form-card">
            <div class="auth-form-header"><span class="auth-eyebrow">Login</span><h2>Bentornato su VibeShop</h2><p>Inserisci le tue credenziali per continuare.</p></div>
            <%
                String error = (String) request.getAttribute("error");
                if (error != null && !error.trim().isEmpty()) {
            %>
                <div class="auth-alert auth-alert-error"><%= error %></div>
            <%
                }
                String registered = request.getParameter("registered");
                if ("true".equals(registered)) {
            %>
                <div class="auth-alert auth-alert-success">Registrazione completata con successo. Ora puoi accedere.</div>
            <%
                }
            %>
            <form action="${pageContext.request.contextPath}/login" method="post" class="auth-form">
                <div class="auth-field"><label for="login">Email o username</label><input type="text" id="login" name="login" placeholder="Inserisci email o username" required /></div>
                <div class="auth-field">
                    <label for="password">Password</label>
                    <div class="auth-password-wrapper"><input type="password" id="password" name="password" placeholder="Inserisci la tua password" required /><button type="button" class="toggle-password" data-target="password" aria-label="Mostra o nascondi password">👁</button></div>
                </div>
                <label class="auth-checkbox-row"><input type="checkbox" name="remember" /><span>Ricordami su questo dispositivo</span></label>
                <button type="submit" class="auth-primary-btn">Accedi</button>
            </form>
            <div class="auth-switch-card"><span>Non hai ancora un account?</span><a href="${pageContext.request.contextPath}/jsp/register.jsp">Registrati</a></div>
        </section>
    </div>
</main>
<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
<script src="${pageContext.request.contextPath}/js/login.js"></script>
</body>
</html>
