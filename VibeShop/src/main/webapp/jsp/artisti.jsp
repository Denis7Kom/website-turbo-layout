<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Artisti - VibeShop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/artisti.css" />
</head>
<body>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<!-- ── HERO ── -->
<div class="artisti-hero">
    <div class="artisti-hero-inner">
        <span class="artisti-hero-label">Scopri la musica live</span>
        <h1>Gli artisti<br>di VibeShop</h1>
        <p>Concerti live, merchandising ufficiale.<br>Trova il tuo artista preferito.</p>
    </div>
    <div class="artisti-hero-fade"></div>
</div>

<main class="main-content">

    <!-- ── IN EVIDENZA ── -->
    <section class="section-container">
        <div class="section-header">
            <h2>In evidenza</h2>
        </div>
        <div class="featured-grid">

            <!-- Card grande -->
            <a href="#" class="featured-card featured-card--large">
                <div class="featured-card-img"></div>
                <div class="featured-card-overlay"></div>
                <div class="featured-card-body">
                    <span class="featured-card-label">Artista del momento</span>
                    <div class="featured-card-nome">Nome Artista</div>
                    <div class="featured-card-genere">Genere musicale</div>
                </div>
            </a>

            <!-- Colonna destra: 2 card piccole -->
            <div class="featured-col">
                <a href="#" class="featured-card featured-card--small">
                    <div class="featured-card-img"></div>
                    <div class="featured-card-overlay"></div>
                    <div class="featured-card-body">
                        <span class="featured-card-label">Prossimamente live</span>
                        <div class="featured-card-nome">Nome Artista</div>
                        <div class="featured-card-genere">Genere musicale</div>
                    </div>
                </a>
                <a href="#" class="featured-card featured-card--small">
                    <div class="featured-card-img"></div>
                    <div class="featured-card-overlay"></div>
                    <div class="featured-card-body">
                        <span class="featured-card-label">Nuovo album</span>
                        <div class="featured-card-nome">Nome Artista</div>
                        <div class="featured-card-genere">Genere musicale</div>
                    </div>
                </a>
            </div>

        </div>
    </section>

    <!-- ── TUTTI GLI ARTISTI ── -->
    <section class="section-container">
        <div class="section-header">
            <h2>Tutti gli artisti</h2>
        </div>
        <div class="artisti-grid">
            <a href="#" class="artista-card">
                <div class="artista-card-img"></div>
                <div class="artista-card-body">
                    <span class="artista-card-nome">Nome Artista</span>
                    <span class="artista-card-genere">Genere</span>
                </div>
            </a>
            <a href="#" class="artista-card">
                <div class="artista-card-img"></div>
                <div class="artista-card-body">
                    <span class="artista-card-nome">Nome Artista</span>
                    <span class="artista-card-genere">Genere</span>
                </div>
            </a>
            <a href="#" class="artista-card">
                <div class="artista-card-img"></div>
                <div class="artista-card-body">
                    <span class="artista-card-nome">Nome Artista</span>
                    <span class="artista-card-genere">Genere</span>
                </div>
            </a>
            <a href="#" class="artista-card">
                <div class="artista-card-img"></div>
                <div class="artista-card-body">
                    <span class="artista-card-nome">Nome Artista</span>
                    <span class="artista-card-genere">Genere</span>
                </div>
            </a>
            <a href="#" class="artista-card">
                <div class="artista-card-img"></div>
                <div class="artista-card-body">
                    <span class="artista-card-nome">Nome Artista</span>
                    <span class="artista-card-genere">Genere</span>
                </div>
            </a>
            <a href="#" class="artista-card">
                <div class="artista-card-img"></div>
                <div class="artista-card-body">
                    <span class="artista-card-nome">Nome Artista</span>
                    <span class="artista-card-genere">Genere</span>
                </div>
            </a>
            <a href="#" class="artista-card">
                <div class="artista-card-img"></div>
                <div class="artista-card-body">
                    <span class="artista-card-nome">Nome Artista</span>
                    <span class="artista-card-genere">Genere</span>
                </div>
            </a>
            <a href="#" class="artista-card">
                <div class="artista-card-img"></div>
                <div class="artista-card-body">
                    <span class="artista-card-nome">Nome Artista</span>
                    <span class="artista-card-genere">Genere</span>
                </div>
            </a>
            <a href="#" class="artista-card">
                <div class="artista-card-img"></div>
                <div class="artista-card-body">
                    <span class="artista-card-nome">Nome Artista</span>
                    <span class="artista-card-genere">Genere</span>
                </div>
            </a>
            <a href="#" class="artista-card">
                <div class="artista-card-img"></div>
                <div class="artista-card-body">
                    <span class="artista-card-nome">Nome Artista</span>
                    <span class="artista-card-genere">Genere</span>
                </div>
            </a>
        </div>
        <!-- ── PAGINAZIONE ── -->
        <div class="pagination">
            <a href="?page=1" class="prev"></a>
            <span class="active">1</span>
            <a href="?page=2">2</a>
            <a href="?page=3">3</a>
            <a href="?page=4">4</a>
            <a href="?page=5">5</a>
            <a href="?page=2" class="next"></a>
        </div>
    </section>

</main>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>

</body>
</html>
