<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - VibeShop</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/login.css">
</head>

<body>
<header class="site-header">
    <div class="header-inner">
        <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
            <img
                src="${pageContext.request.contextPath}/images/logo.svg"
                alt="VibeShop logo"
                class="logo-img"
            >
            <span>VibeShop</span>
        </a>

        <nav class="main-nav">
            <a href="#">Concerti</a>
            <a href="#">Artisti</a>
            <a href="#">Merch</a>
        </nav>

        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/register.jsp">Registrati</a>

            <a href="${pageContext.request.contextPath}/cart.jsp" class="cart-link" aria-label="Carrello">
                <img
                    src="${pageContext.request.contextPath}/images/shop.svg"
                    alt="Carrello"
                    class="cart-icon"
                >
                <span class="cart-count">0</span>
            </a>
        </div>
    </div>
</header>

<main class="page-wrapper">
    <section class="login-card">
        <div class="promo-panel">
            <div class="promo-overlay"></div>

            <div class="promo-content">
                <div class="promo-logo">
                    <img
                        src="${pageContext.request.contextPath}/images/logo.svg"
                        alt="VibeShop logo"
                        class="promo-logo-img"
                    >
                </div>

                <h1>
                    Bentornato su <br>
                    <span>VibeShop</span>
                </h1>

                <div class="title-line"></div>

                <p class="promo-subtitle">
                    Accedi al tuo account per gestire biglietti,
                    artisti preferiti e merchandising ufficiale.
                </p>

                <div class="benefits">
                    <div class="benefit-item">
                        <div class="benefit-icon">
                            <img
                                src="${pageContext.request.contextPath}/images/tickets.svg"
                                alt="Biglietti"
                                class="benefit-img"
                            >
                        </div>
                        <div>
                            <h3>I tuoi biglietti sempre disponibili</h3>
                            <p>Consulta rapidamente i tuoi ordini e resta aggiornato sugli eventi acquistati.</p>
                        </div>
                    </div>

                    <div class="benefit-item">
                        <div class="benefit-icon">
                            <img
                                src="${pageContext.request.contextPath}/images/like.svg"
                                alt="Artisti preferiti"
                                class="benefit-img"
                            >
                        </div>
                        <div>
                            <h3>Segui gli artisti che ami</h3>
                            <p>Ricevi novità, annunci e informazioni sui concerti più attesi.</p>
                        </div>
                    </div>

                    <div class="benefit-item">
                        <div class="benefit-icon">
                            <img
                                src="${pageContext.request.contextPath}/images/bag.svg"
                                alt="Merch"
                                class="benefit-img"
                            >
                        </div>
                        <div>
                            <h3>Accedi al merch ufficiale</h3>
                            <p>Ritrova i tuoi prodotti preferiti e completa i tuoi acquisti in pochi clic.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-panel">
            <div class="form-container">
                <h2>Accedi al tuo account</h2>

                <p class="form-subtitle">
                    Inserisci le tue credenziali per continuare
                    a vivere l’esperienza VibeShop.
                </p>

                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                %>
                    <div class="error-box"><%= error %></div>
                <%
                    }

                    String registered = request.getParameter("registered");
                    if ("true".equals(registered)) {
                %>
                    <div class="success-box">Registrazione completata con successo. Ora puoi accedere.</div>
                <%
                    }
                %>

                <form action="${pageContext.request.contextPath}/login" method="post" class="login-form">
                    <div class="form-group">
                        <label for="login">Email o Username</label>
                        <input
                            type="text"
                            id="login"
                            name="login"
                            placeholder="Inserisci email o username"
                            required
                        >
                    </div>

                    <div class="form-group password-group">
                        <div class="label-row">
                            <label for="password">Password</label>
                            <a href="#" class="forgot-link">Password dimenticata?</a>
                        </div>

                        <div class="password-wrapper">
                            <input
                                type="password"
                                id="password"
                                name="password"
                                placeholder="Inserisci la tua password"
                                required
                            >
                            <button
                                type="button"
                                class="toggle-password"
                                data-target="password"
                                aria-label="Mostra o nascondi password"
                            >👁</button>
                        </div>
                    </div>

                    <label class="checkbox-row remember-row">
                        <input type="checkbox" name="remember">
                        <span>Ricordami su questo dispositivo</span>
                    </label>

                    <button type="submit" class="primary-btn">Accedi</button>

                    <p class="register-text">
                        Non hai ancora un account?
                        <a href="${pageContext.request.contextPath}/register.jsp">Registrati</a>
                    </p>
                </form>
            </div>
        </div>
    </section>
</main>

<footer class="site-footer">
    © 2026 VibeShop
</footer>

<script src="${pageContext.request.contextPath}/login.js"></script>
</body>
</html>
