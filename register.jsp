<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login- Turbo Layout</title>

    <link rel="stylesheet" href="login.css" /> 
</head>

<body>
<header class="site-header">
    <div class="header-inner">
        <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
            <span class="logo-icon">
                <span></span><span></span><span></span><span></span>
            </span>
            <span>Turbo Layout</span>
        </a>

        <nav class="main-nav">
            <a href="#">Concerti</a>
            <a href="#">Artisti</a>
            <a href="#">Merch</a>
        </nav>

        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/login.jsp">Login</a>

            <a href="${pageContext.request.contextPath}/cart.jsp" class="cart-link">
                🛒
                <span class="cart-count">0</span>
            </a>
        </div>
    </div>
</header>

<main class="page-wrapper">

    <section class="register-card">

        <div class="promo-panel">
            <div class="promo-overlay"></div>

            <div class="promo-content">
                <div class="sound-icon">
                    <span></span><span></span><span></span><span></span>
                </div>

                <h1>
                    Unisciti a <br>
                    <span>Turbo Layout</span>
                </h1>

                <div class="title-line"></div>

                <p class="promo-subtitle">
                    Scopri concerti, segui i tuoi artisti preferiti
                    e acquista merchandising ufficiale.
                </p>

                <div class="benefits">

                    <div class="benefit-item">
                        <div class="benefit-icon">🎟️</div>
                        <div>
                            <h3>Acquista biglietti in anteprima</h3>
                            <p>Accedi a prevendite esclusive e offerte riservate ai membri.</p>
                        </div>
                    </div>

                    <div class="benefit-item">
                        <div class="benefit-icon">❤</div>
                        <div>
                            <h3>Segui i tuoi artisti preferiti</h3>
                            <p>Ricevi aggiornamenti, novità e date dei prossimi eventi.</p>
                        </div>
                    </div>

                    <div class="benefit-item">
                        <div class="benefit-icon">🛍️</div>
                        <div>
                            <h3>Merch ufficiale</h3>
                            <p>Scopri collezioni esclusive e porta la musica sempre con te.</p>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="form-panel">
            <div class="form-container">

                <h2>Crea il tuo account</h2>

                <p class="form-subtitle">
                    Registrati per acquistare biglietti, seguire artisti
                    e salvare i tuoi preferiti.
                </p>
          

                <form action="${pageContext.request.contextPath}/register" method="post" class="register-form">

                    <div class="form-row">
                        <div class="form-group">
                            <label for="nome">Nome</label>
                            <input type="text" id="nome" name="nome" placeholder="Inserisci il tuo nome" required>
                        </div>

                        <div class="form-group">
                            <label for="cognome">Cognome</label>
                            <input type="text" id="cognome" name="cognome" placeholder="Inserisci il tuo cognome" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" placeholder="Inserisci la tua email" required>
                    </div>

                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" placeholder="Scegli il tuo username" required>
                    </div>

                    <div class="form-group password-group">
                        <label for="password">Password</label>
                        <div class="password-wrapper">
                            <input type="password" id="password" name="password" placeholder="Crea una password" required>
                            <button type="button" class="toggle-password" data-target="password">👁</button>
                        </div>
                    </div>

                    <div class="form-group password-group">
                        <label for="confirmPassword">Conferma password</label>
                        <div class="password-wrapper">
                            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Conferma la tua password" required>
                            <button type="button" class="toggle-password" data-target="confirmPassword">👁</button>
                        </div>
                    </div>

                    <label class="checkbox-row">
                        <input type="checkbox" name="terms" required>
                        <span>Accetto i <a href="#">Termini</a> e la <a href="#">Privacy Policy</a></span>
                    </label>

                    <button type="submit" class="primary-btn">Crea account</button>

                    <p class="login-text">
                        Hai già un account?
                        <a href="${pageContext.request.contextPath}/login.jsp">Accedi</a>
                    </p>   

                </form>
            </div>
        </div>

    </section>

</main>

<footer class="site-footer">       
        © 2026 Turbo Layout
</footer>

<script src="${pageContext.request.contextPath}/js/register.js"></script>
</body>
</html>
