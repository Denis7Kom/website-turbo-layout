<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Merch Ufficiale - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/merch.css" />
</head>
<body>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<div class="merch-hero">
    <div class="merch-hero-inner">
        <span class="merch-hero-label">Collezioni Esclusive</span>
        <h1>Merch<br>Ufficiale</h1>
        <p>Indossa la tua passione. T-shirt, felpe e accessori in edizione limitata<br>dei migliori artisti della scena.</p>
    </div>
    <div class="merch-hero-fade"></div>
</div>

<main class="main-content">

    <div class="filter-bar">
        <div class="categories-capsules">
            <a href="#" class="capsule active">Tutti i prodotti</a>
            <a href="#" class="capsule">T-Shirt</a>
            <a href="#" class="capsule">Felpe</a>
            <a href="#" class="capsule">Accessori</a>
            <a href="#" class="capsule">Vinili & CD</a>
        </div>
        <div class="filter-select-wrapper">
            <select class="filter-select">
                <option>Ordina per: In evidenza</option>
                <option>Prezzo: dal più basso</option>
                <option>Prezzo: dal più alto</option>
                <option>Più recenti</option>
            </select>
        </div>
    </div>

    <section class="section-container">
        <div class="merch-grid">
            
            <div class="product-card">
                <div class="product-card-img-container">
                    <span class="product-badge new">Nuovo</span>
                    <div class="product-card-img-placeholder"></div>
                </div>
                <div class="product-card-body">
                    <span class="product-artist">Coldplay</span>
                    <h3 class="product-title">T-Shirt Music Of The Spheres</h3>
                    <span class="product-price">€ 35,00</span>
                </div>
            </div>

            <div class="product-card">
                <div class="product-card-img-container">
                    <span class="product-badge limited">Limited</span>
                    <div class="product-card-img-placeholder"></div>
                </div>
                <div class="product-card-body">
                    <span class="product-artist">Marracash</span>
                    <h3 class="product-title">Felpa con Cappuccio Persona</h3>
                    <span class="product-price">€ 65,00</span>
                </div>
            </div>

            <div class="product-card">
                <div class="product-card-img-container">
                    <div class="product-card-img-placeholder"></div>
                </div>
                <div class="product-card-body">
                    <span class="product-artist">Travis Scott</span>
                    <h3 class="product-title">Cappellino Vintage Utopia</h3>
                    <span class="product-price">€ 28,00</span>
                </div>
            </div>

            <div class="product-card">
                <div class="product-card-img-container">
                    <div class="product-card-img-placeholder"></div>
                </div>
                <div class="product-card-body">
                    <span class="product-artist">Pinguini Tattici Nucleari</span>
                    <h3 class="product-title">Tazza Logo Ceramica</h3>
                    <span class="product-price">€ 15,00</span>
                </div>
            </div>
        </div>

        <div class="pagination">
            <a href="?page=1" class="prev"></a>
            <span class="active">1</span>
            <a href="?page=2">2</a>
            <a href="?page=3">3</a>
            <a href="?page=2" class="next"></a>
        </div>
    </section>

</main>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>

</body>
</html>