<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <title>Homepage - VibeShop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homepage.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>

    <header>
        <div class="left">
            <a href="${pageContext.request.contextPath}/homepage.jsp" class="logo">
                <img src="${pageContext.request.contextPath}/img/logo.png" alt="VibeShop Icon" class="brand-icon"/>
            </a>
            <span class="brand-text">VibeShop</span>
        </div>

        <nav class="navbar">
            <form method="get" action="${pageContext.request.contextPath}/Ricerca" class="search-form">
                <div class="search-container">
                    <input type="text" name="ricerca" placeholder="Cerca..." required />
                    <button type="submit" class="search-btn" aria-label="Cerca">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="11" cy="11" r="8"></circle>
                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                        </svg>
                    </button>
                </div>
            </form>
        </nav>

        <div class="header-actions">
            <div class="right">
                <a href="${pageContext.request.contextPath}/jsp/register.jsp" class="login">Login</a>
                <a href="${pageContext.request.contextPath}/jsp/cart.jsp" class="cart-link">
                    <img src="${pageContext.request.contextPath}/img/shop.svg" alt="Carrello" class="cart-icon" />
                    <span class="cart-count">0</span>
                </a>
            </div>

            <button id="menu-btn" class="menu-trigger" aria-label="Menu">
    			<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        			<line x1="3" y1="10" x2="21" y2="10"></line>
        			<line x1="12" y1="16" x2="21" y2="16"></line>
    			</svg>
			</button>
        </div>

        <nav id="nav-menu" class="nav-left">
            <a href="#">Concerti</a>
            <a href="#">Artisti</a>
            <a href="#">Merch</a>
        </nav>
    </header>

    <main>
        <h2>Concerti in evidenza</h2>
        <div class="contenitore-card">
            <div class="card"><a href="#">Card concerto</a></div>
            <div class="card"><a href="#">Card concerto</a></div>
            <div class="card"><a href="#">Card concerto</a></div>
            <div class="card"><a href="#">Card concerto</a></div>
            <div class="card"><a href="#">Card concerto</a></div>
            <div class="card"><a href="#">Card concerto</a></div>
            <a class="tasto_lato" href="#">altro</a>
        </div>

        <h2>Artisti</h2>
        <div class="contenitore-card">
            <div class="card"><a href="#">Card artisti</a></div>
            <div class="card"><a href="#">Card artisti</a></div>
            <div class="card"><a href="#">Card artisti</a></div>
            <div class="card"><a href="#">Card artisti</a></div>
            <div class="card"><a href="#">Card artisti</a></div>
            <div class="card"><a href="#">Card artisti</a></div>
            <a class="tasto_lato" href="#">altro</a>
        </div>

        <h2>Merchandising</h2>
        <div class="contenitore-card">
            <div class="card"><a href="#">Card merch</a></div>
            <div class="card"><a href="#">Card merch</a></div>
            <div class="card"><a href="#">Card merch</a></div>
            <div class="card"><a href="#">Card merch</a></div>
            <div class="card"><a href="#">Card merch</a></div>
            <div class="card"><a href="#">Card merch</a></div>
            <a class="tasto_lato" href="#">altro</a>
        </div>
    </main>

    <footer class="site-footer">© 2026 VibeShop</footer>

    <script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
