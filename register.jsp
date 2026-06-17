<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrati - VibeShop</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css"> </head>

<body>

    <%@ include file="/WEB-INF/fragments/header.jspf" %>

    <main class="page-wrapper">
        <section class="login-card">
            <div class="promo-panel">
                <div class="promo-overlay"></div>

                <div class="promo-content">
                    <div class="promo-logo">
                        <img
                            src="${pageContext.request.contextPath}/img/logo.svg"
                            alt="VibeShop logo"
                            class="promo-logo-img"
                        >
                    </div>

                    <h1>
                        Unisciti a <br>
                        <span>VibeShop</span>
                    </h1>

                    <div class="title-line"></div>

                    <p class="promo-subtitle">
                        Crea un account per non perdere i biglietti dei tuoi concerti preferiti e accedere al merchandising esclusivo.
                    </p>

                    <div class="benefits">
                        <div class="benefit-item">
                            <div class="benefit-icon">
                                <img
                                    src="${pageContext.request.contextPath}/img/tickets.svg"
                                    alt="Biglietti"
                                    class="benefit-img"
                                >
                            </div>
                            <div>
                                <h3>Acquisti rapidi e sicuri</h3>
                                <p>Salva i tuoi dati per completare i tuoi ordini in pochi secondi quando escono i biglietti.</p>
                            </div>
                        </div>

                        <div class="benefit-item">
                            <div class="benefit-icon">
                                <img
                                    src="${pageContext.request.contextPath}/img/like.svg"
                                    alt="Artisti preferiti"
                                    class="benefit-img"
                                >
                            </div>
                            <div>
                                <h3>Notifiche personalizzate</h3>
                                <p>Sii il primo a sapere quando i tuoi artisti preferiti annunciano nuove date nella tua zona.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-panel">
                <div class="form-container">
                    <h2>Crea il tuo account</h2>

                    <p class="form-subtitle">
                        Compila i campi sottostanti per registrarti sulla piattaforma.
                    </p>

                    <%
                        String errorReg = (String) request.getAttribute("error");
                        if (errorReg != null) {
                    %>
                        <div class="error-box"><%= errorReg %></div>
                    <%
                        }
                    %>

                    <form action="${pageContext.request.contextPath}/register" method="post" class="login-form">
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input
                                type="text"
                                id="username"
                                name="username"
                                placeholder="Scegli un username unico"
                                required
                            >
                        </div>

                        <div class="form-group">
                            <label for="email">Email</label>
                            <input
                                type="email"
                                id="email"
                                name="email"
                                placeholder="Inserisci la tua email"
                                required
                            >
                        </div>

                        <div class="form-group password-group">
                            <label for="password">Password</label>
                            <div class="password-wrapper">
                                <input
                                    type="password"
                                    id="password"
                                    name="password"
                                    placeholder="Crea una password sicura"
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

                        <div class="form-group password-group">
                            <label for="confirmPassword">Conferma Password</label>
                            <div class="password-wrapper">
                                <input
                                    type="password"
                                    id="confirmPassword"
                                    name="confirmPassword"
                                    placeholder="Ripeti la password"
                                    required
                                >
                                <button
                                    type="button"
                                    class="toggle-password"
                                    data-target="confirmPassword"
                                    aria-label="Mostra o nascondi password"
                                >👁</button>
                            </div>
                        </div>

                        <button type="submit" class="primary-btn">Registrati</button>

                        <p class="register-text">
                            Hai già un account?
                            <a href="${pageContext.request.contextPath}/jsp/login.jsp">Accedi</a>
                        </p>
                    </form>
                </div>
            </div>
        </section>
    </main>

    <%@ include file="/WEB-INF/fragments/footer.jspf" %>

    <script src="${pageContext.request.contextPath}/js/login.js"></script>
</body>
</html>
