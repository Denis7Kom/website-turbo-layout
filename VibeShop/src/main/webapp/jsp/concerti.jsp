<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Concerti - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/concerti.css" />
</head>
<body>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<div class="concerti-hero">
    <div class="concerti-hero-inner">
        <span class="concerti-hero-label">Vivi l'atmosfera Live</span>
        <h1>I Concerti<br>più attesi</h1>
        <p>Trova i biglietti per i tuoi eventi preferiti.<br>Assicurati un posto in prima fila.</p>
    </div>
    <div class="concerti-hero-fade"></div>
</div>

<main class="main-content">

    <section class="section-container">
        <div class="section-header">
            <h2>In evidenza questa settimana</h2>
        </div>
        <div class="featured-concerti-grid">
            <div class="featured-card-concerti">
                <div class="featured-card-img-placeholder"></div>
                <div class="featured-card-overlay">
                    <span class="event-tag">Sold Out Presto</span>
                    <h3>Milano Summer Festival 2026</h3>
                    <p class="event-details">25 Giugno 2026 • Ippodromo Snai San Siro</p>
                    <a href="#" class="btn-ticket">Acquista Biglietti</a>
                </div>
            </div>
        </div>
    </section>

    <section class="section-container">
        <div class="section-header">
            <h2>Tutti i concerti</h2>
        </div>
        
        <div class="concerti-grid">
            <a href="#" class="concerto-card">
                <div class="concerto-card-img">
                    <span class="date-badge">12 <br><small>LUG</small></span>
                </div>
                <div class="concerto-card-body">
                    <span class="concerto-card-artista">Coldplay Live</span>
                    <span class="concerto-card-location">Stadio Diego Armando Maradona, Napoli</span>
                    <span class="concerto-card-prezzo">Da € 55,00</span>
                </div>
            </a>

            <a href="#" class="concerto-card">
                <div class="concerto-card-img">
                    <span class="date-badge">18 <br><small>LUG</small></span>
                </div>
                <div class="concerto-card-body">
                    <span class="concerto-card-artista">Marracash - Stadi 2026</span>
                    <span class="concerto-card-location">Stadio Olimpico, Roma</span>
                    <span class="concerto-card-prezzo">Da € 46,00</span>
                </div>
            </a>

            <a href="#" class="concerto-card">
                <div class="concerto-card-img">
                    <span class="date-badge">02 <br><small>AGO</small></span>
                </div>
                <div class="concerto-card-body">
                    <span class="concerto-card-artista">Travis Scott - Utopia Tour</span>
                    <span class="concerto-card-location">Arena di Verona, Verona</span>
                    <span class="concerto-card-prezzo">Da € 75,00</span>
                </div>
            </a>

            <a href="#" class="concerto-card">
                <div class="concerto-card-img">
                    <span class="date-badge">15 <br><small>SET</small></span>
                </div>
                <div class="concerto-card-body">
                    <span class="concerto-card-artista">Pinguini Tattici Nucleari</span>
                    <span class="concerto-card-location">Campovolo, Reggio Emilia</span>
                    <span class="concerto-card-prezzo">Da € 39,00</span>
                </div>
            </a>
        </div>

        <div class="pagination">
            <a href="?page=1" class="prev"></a>
            <span class="active">1</span>
            <a href="?page=2">2</a>
            <a href="?page=3">3</a>
            <a href="?page=4">4</a>
            <a href="?page=2" class="next"></a>
        </div>
    </section>

</main>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>

</body>
</html>