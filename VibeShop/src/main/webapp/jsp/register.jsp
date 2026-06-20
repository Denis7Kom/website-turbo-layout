<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Registrazione - VibeShop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css" />
</head>
<body>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<main class="main-content auth-main">
    <h1 class="cart-page-title">Crea il tuo account</h1>

    <div class="auth-layout">
        <aside class="auth-info-card">
            <span class="auth-eyebrow">Nuovo account</span>
            <h2>Entra in VibeShop e gestisci acquisti, eventi e preferenze.</h2>
            <p>
                Con un account puoi acquistare biglietti, salvare il carrello, consultare lo storico
                degli ordini e accedere più velocemente al merchandising ufficiale.
            </p>

            <div class="auth-benefits">
                <div class="auth-benefit-item">
                    <img src="${pageContext.request.contextPath}/img/bag.svg" alt="Merch" />
                    <div>
                        <h3>Checkout più rapido</h3>
                        <p>Usa i dati dell’account per completare gli ordini in meno passaggi.</p>
                    </div>
                </div>

                <div class="auth-benefit-item">
                    <img src="${pageContext.request.contextPath}/img/tickets.svg" alt="Biglietti" />
                    <div>
                        <h3>Ordini sempre tracciati</h3>
                        <p>Ritrova biglietti e prodotti acquistati nella tua area personale.</p>
                    </div>
                </div>
            </div>
        </aside>

        <section class="auth-form-card">
            <div class="auth-form-header">
                <span class="auth-eyebrow">Registrazione</span>
                <h2>Apri il tuo profilo</h2>
                <p>Compila i campi richiesti per creare un nuovo account.</p>
            </div>

            <%
                String errorReg = (String) request.getAttribute("error");
                if (errorReg != null && !errorReg.trim().isEmpty()) {
            %>
                <div class="auth-alert auth-alert-error"><%= errorReg %></div>
            <%
                }
            %>

            <form action="${pageContext.request.contextPath}/register" method="post" class="auth-form">
                <div class="auth-form-grid">
                    <div class="auth-field">
                        <label for="nome">Nome</label>
                        <input
                            type="text"
                            id="nome"
                            name="nome"
                            placeholder="Inserisci il tuo nome"
                            required
                        />
                    </div>

                    <div class="auth-field">
                        <label for="cognome">Cognome</label>
                        <input
                            type="text"
                            id="cognome"
                            name="cognome"
                            placeholder="Inserisci il tuo cognome"
                            required
                        />
                    </div>
                </div>

                <div class="auth-field">
                    <label for="username">Username</label>
                    <input
                        type="text"
                        id="username"
                        name="username"
                        placeholder="Scegli un username unico"
                        required
                    />
                </div>

                <div class="auth-field">
                    <label for="email">Email</label>
                    <input
                        type="email"
                        id="email"
                        name="email"
                        placeholder="Inserisci la tua email"
                        required
                    />
                </div>

                <div class="auth-form-grid">
                    <div class="auth-field">
                        <label for="password">Password</label>
                        <div class="auth-password-wrapper">
                            <input
                                type="password"
                                id="password"
                                name="password"
                                placeholder="Crea una password sicura"
                                required
                            />
                            <button
                                type="button"
                                class="toggle-password"
                                data-target="password"
                                aria-label="Mostra o nascondi password"
                            >👁</button>
                        </div>
                    </div>

                    <div class="auth-field">
                        <label for="confirmPassword">Conferma password</label>
                        <div class="auth-password-wrapper">
                            <input
                                type="password"
                                id="confirmPassword"
                                name="confirmPassword"
                                placeholder="Ripeti la password"
                                required
                            />
                            <button
                                type="button"
                                class="toggle-password"
                                data-target="confirmPassword"
                                aria-label="Mostra o nascondi password"
                            >👁</button>
                        </div>
                    </div>
                </div>

                <label class="auth-checkbox-row">
                    <input type="checkbox" name="terms" required />
                    <span>Accetto i Termini di servizio e la Privacy Policy.</span>
                </label>

                <button type="submit" class="auth-primary-btn">Registrati</button>
            </form>

            <div class="auth-switch-card">
                <span>Hai già un account?</span>
                <a href="${pageContext.request.contextPath}/jsp/login.jsp">Accedi</a>
            </div>
        </section>
    </div>
</main>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>

<script src="${pageContext.request.contextPath}/js/menu.js"></script>
<script src="${pageContext.request.contextPath}/js/login.js"></script>
</body>
</html>