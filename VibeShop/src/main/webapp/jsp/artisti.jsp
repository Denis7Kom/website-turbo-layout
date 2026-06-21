<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Artisti - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/artisti.css" />
</head>
<body>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>
<div class="artisti-hero"><div class="artisti-hero-inner"><span class="artisti-hero-label">Scopri la musica live</span><h1>Gli artisti<br>di VibeShop</h1><p>Concerti live e merchandising ufficiale.</p></div><div class="artisti-hero-fade"></div></div>
<main class="main-content">
<section class="section-container"><div class="section-header"><h2>In evidenza</h2></div><div class="featured-grid"><a href="${pageContext.request.contextPath}/jsp/concerti.jsp" class="featured-card featured-card--large"><div class="featured-card-img"></div><div class="featured-card-overlay"></div><div class="featured-card-body"><span class="featured-card-label">Artista del momento</span><div class="featured-card-nome">Coldplay</div><div class="featured-card-genere">Pop Rock</div></div></a></div></section>
<section class="section-container"><div class="section-header"><h2>Tutti gli artisti</h2></div><div class="artisti-grid">
<a href="${pageContext.request.contextPath}/jsp/concerti.jsp" class="artista-card"><div class="artista-card-img"></div><div class="artista-card-body"><span class="artista-card-nome">Coldplay</span><span class="artista-card-genere">Pop Rock</span></div></a>
<a href="${pageContext.request.contextPath}/jsp/concerti.jsp" class="artista-card"><div class="artista-card-img"></div><div class="artista-card-body"><span class="artista-card-nome">Marracash</span><span class="artista-card-genere">Rap</span></div></a>
<a href="${pageContext.request.contextPath}/merch" class="artista-card"><div class="artista-card-img"></div><div class="artista-card-body"><span class="artista-card-nome">Travis Scott</span><span class="artista-card-genere">Hip Hop</span></div></a>
<a href="${pageContext.request.contextPath}/jsp/concerti.jsp" class="artista-card"><div class="artista-card-img"></div><div class="artista-card-body"><span class="artista-card-nome">Pinguini Tattici Nucleari</span><span class="artista-card-genere">Pop</span></div></a>
</div></section>
</main>
<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
