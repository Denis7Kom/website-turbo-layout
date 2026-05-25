<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="it">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Registrazione - VibeShop</title>

        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800&display=swap" rel="stylesheet" />

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css" />
    </head>

    <body>
        <header>
            <div class="left">
                <a href="${pageContext.request.contextPath}/homepage.jsp" class="logo">
                    <img src="${pageContext.request.contextPath}/img/logo.png" alt="Site Logo" />
                </a>
                <h1>VibeShop</h1>
            </div>

            <nav class="navbar">
                <!-- Action dinamica verso la Servlet -->
                <div class="right">
                    <a href="${pageContext.request.contextPath}/jsp/register.jsp" class="login">Login</a>
                    <a href="${pageContext.request.contextPath}/jsp/cart.jsp" class="cart-link">
                        <img src="${pageContext.request.contextPath}/img/shop.svg" alt="Carrello" class="cart-icon" />
                        <span class="cart-count">0</span>
                    </a>
                </div>                            
            </nav>
        </header>

        <main class="page-wrapper">
            <section class="register-card">
                <div class="promo-panel">
                    <div class="promo-content">
                        <h1>Unisciti a <br /><span>VibeShop</span></h1>
                        <div class="title-line"></div>
                        <p class="promo-subtitle">Scopri concerti, segui i tuoi artisti preferiti e acquista merchandising ufficiale.</p>
                        
                        <div class="benefits">
                            <div class="benefit-item">
                                <div class="benefit-icon"><img src="${pageContext.request.contextPath}/img/tickets.svg" alt="Biglietti" class="benefit-img" /></div>
                                <div><h3>Acquista biglietti in anteprima</h3></div>
                            </div>
                            <div class="benefit-item">
                                <div class="benefit-icon"><img src="${pageContext.request.contextPath}/img/like.svg" alt="Artisti" class="benefit-img" /></div>
                                <div><h3>Segui i tuoi artisti preferiti</h3></div>
                            </div>
                            <div class="benefit-item">
                                <div class="benefit-icon"><img src="${pageContext.request.contextPath}/img/bag.svg" alt="Merch" class="benefit-img" /></div>
                                <div><h3>Merch ufficiale</h3></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-panel">
                    <div class="form-container">
                        <h2>Crea il tuo account</h2>
                        <form action="${pageContext.request.contextPath}/register" method="post" class="register-form">
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="nome">Nome</label>
                                    <input type="text" id="nome" name="nome" placeholder="Nome" required />
                                </div>
                                <div class="form-group">
                                    <label for="cognome">Cognome</label>
                                    <input type="text" id="cognome" name="cognome" placeholder="Cognome" required />
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" placeholder="Email" required />
                            </div>
                            <div class="form-group">
                                <label for="username">Username</label>
                                <input type="text" id="username" name="username" placeholder="Username" required />
                            </div>
                            <div class="form-group password-group">
                                <label for="password">Password</label>
                                <div class="password-wrapper">
                                    <input type="password" id="password" name="password" placeholder="Password" required />
                                    <button type="button" class="toggle-password" data-target="password">👁</button>
                                </div>
                            </div>
                            <div class="form-group password-group">
                                <label for="confirmPassword">Conferma password</label>
                                <div class="password-wrapper">
                                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Conferma password" required />
                                    <button type="button" class="toggle-password" data-target="confirmPassword">👁</button>
                                </div>
                            </div>
                            <label class="checkbox-row">
                                <input type="checkbox" name="terms" required />
                                <span>Accetto i <a href="#">Termini</a> e la <a href="#">Privacy Policy</a></span>
                            </label>
                            <button type="submit" class="primary-btn">Crea account</button>
                        </form>
                    </div>
                </div>
            </section>
        </main>

        <footer class="site-footer">© 2026 VibeShop</footer>
    </body>
</html>