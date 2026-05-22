<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Artista</title>
	<link rel="stylesheet" href="artista.css">
</head>
<body>
	   <header>
            <div class="left">
                <a href="${pageContext.request.contextPath}/homepage.jsp" class="logo">
                    <img src="${pageContext.request.contextPath}/img/logo2.png" alt="Site Logo" />
                </a>
                <h1>VibeShop</h1>
            </div>

            <nav class="navbar">
                <!-- Action dinamica verso la Servlet -->
                <form method="get" action="${pageContext.request.contextPath}/Ricerca" class="search-form">
                    <div class="search-container">
                        <input type="text" name="ricerca" placeholder="Cerca..." required />
                        <button type="submit" class="search-btn" aria-label="Cerca">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <circle cx="11" cy="11" r="8"></circle>
                                <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                            </svg>
                        </button>
                    </div>
                </form>

                <div class="right">
                    <a href="${pageContext.request.contextPath}/jsp/register.jsp" class="login">Login</a>
                    <a href="${pageContext.request.contextPath}/jsp/cart.jsp" class="cart-link">
                        <img src="${pageContext.request.contextPath}/img/shop.svg" alt="Carrello" class="cart-icon" />
                        <span class="cart-count">0</span>
                    </a>
                </div>
                
                <input type="checkbox" id="menu-toggle" class="menu-toggle">
            	<label for="menu-toggle" class="hamburger-label" aria-label="Apri menu">
                	<span class="hamburger-line"></span>
                	<span class="hamburger-line"></span>
                	<span class="hamburger-line"></span>
            	</label>

            	<div class="nav-left">
                	<a href="#">Concerti</a>
                	<a href="#">Artisti</a>
                	<a href="#">Merch</a>
            	</div>
            </nav>
        </header>
	
	<main>
		<div class="contenitore">
			<img src="#"height="600"width="600" alt="artista">
			<p>Nome d'arte<br>Genere musicale<br>Breve biografia</p>
		</div>
		
		<div class="testo_1"><h2>Concerti dell' artista</h2></div>
		<div class="contenitore_1">
			<a href="#"><img src="#"height="50"width="100" alt="concerto"></a>
			<a href="#"><img src="#"height="50"width="100" alt="concerto"></a>
		</div>
		
		<div class="testo_2"><h2>Merch dell' artista</h2></div>
		<div class="contenitore_2">
			<a href="#"><img src="#"height="50"width="100" alt="prodotto"></a>
			<a href="#"><img src="#"height="50"width="100" alt="prodotto"></a>
			<a href="#"><img src="#"height="50"width="100" alt="prodotto"></a>
		</div>
		
		<div class="testo_3"><h2>Artisti correlati/suggeriti</h2></div>
		<div class="contenitore_3">
			<a href="#"><img src="#"height="50"width="100" alt="Card"></a>
			<a href="#"><img src="#"height="50"width="100" alt="Card"></a>
			<a href="#"><img src="#"height="50"width="100" alt="Card"></a>
		</div>
	</main>
	  <footer class="site-footer">© 2026 VibeShop</footer>
</body>
</html>