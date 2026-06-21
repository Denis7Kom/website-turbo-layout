<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <title>Homepage - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homepage.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>

    <%@ include file="/WEB-INF/fragments/header.jspf" %>
    <%@ include file="/WEB-INF/fragments/nav.jspf" %>

    <main class="main-content">
        <section class="section-container">
            <div class="section-header">
                <h2>Concerti in evidenza</h2>
                <a class="tasto_lato" href="${pageContext.request.contextPath}/concerti">Vedi tutti</a>
            </div>
            <div class="contenitore-card fade-right">
                <div class="card"><a href="${pageContext.request.contextPath}/concerti"><div class="card-placeholder"></div><span class="card-title">Eventi live</span></a></div>
                <div class="card"><a href="${pageContext.request.contextPath}/concerti"><div class="card-placeholder"></div><span class="card-title">Biglietti disponibili</span></a></div>
                <div class="card"><a href="${pageContext.request.contextPath}/concerti"><div class="card-placeholder"></div><span class="card-title">Prossimi concerti</span></a></div>
                <div class="card"><a href="${pageContext.request.contextPath}/concerti"><div class="card-placeholder"></div><span class="card-title">Tour ufficiali</span></a></div>
                <div class="card"><a href="${pageContext.request.contextPath}/concerti"><div class="card-placeholder"></div><span class="card-title">Live experience</span></a></div>
                <div class="card"><a href="${pageContext.request.contextPath}/concerti"><div class="card-placeholder"></div><span class="card-title">Calendario eventi</span></a></div>
            </div>
        </section>

        <section class="section-container">
            <div class="section-header">
                <h2>Artisti da scoprire</h2>
                <a class="tasto_lato" href="${pageContext.request.contextPath}/jsp/artisti.jsp">Vedi tutti</a>
            </div>
            <div class="contenitore-card fade-right">
                <div class="card"><a href="${pageContext.request.contextPath}/jsp/artisti.jsp"><div class="card-placeholder"></div><span class="card-title">Artisti pop</span></a></div>
                <div class="card"><a href="${pageContext.request.contextPath}/jsp/artisti.jsp"><div class="card-placeholder"></div><span class="card-title">Artisti rap</span></a></div>
                <div class="card"><a href="${pageContext.request.contextPath}/jsp/artisti.jsp"><div class="card-placeholder"></div><span class="card-title">Rock & alternative</span></a></div>
                <div class="card"><a href="${pageContext.request.contextPath}/jsp/artisti.jsp"><div class="card-placeholder"></div><span class="card-title">Artisti italiani</span></a></div>
                <div class="card"><a href="${pageContext.request.contextPath}/jsp/artisti.jsp"><div class="card-placeholder"></div><span class="card-title">Nuove uscite</span></a></div>
                <div class="card"><a href="${pageContext.request.contextPath}/jsp/artisti.jsp"><div class="card-placeholder"></div><span class="card-title">In evidenza</span></a></div>
            </div>
        </section>

        <section class="section-container">
            <div class="section-header">
                <h2>Shop & Collezioni</h2>
                <a class="tasto_lato" href="${pageContext.request.contextPath}/merch">Vedi tutti</a>
            </div>
            <div class="contenitore-card fade-right">
                <div class="card"><a href="${pageContext.request.contextPath}/merch"><div class="card-placeholder"></div><span class="card-title">Merch ufficiale</span></a></div>
                <div class="card"><a href="${pageContext.request.contextPath}/merch"><div class="card-placeholder"></div><span class="card-title">T-shirt</span></a></div>
                <div class="card"><a href="${pageContext.request.contextPath}/merch"><div class="card-placeholder"></div><span class="card-title">Felpe</span></a></div>
                <div class="card"><a href="${pageContext.request.contextPath}/merch"><div class="card-placeholder"></div><span class="card-title">Vinili & CD</span></a></div>
                <div class="card"><a href="${pageContext.request.contextPath}/merch"><div class="card-placeholder"></div><span class="card-title">Accessori</span></a></div>
                <div class="card"><a href="${pageContext.request.contextPath}/merch"><div class="card-placeholder"></div><span class="card-title">Collezioni</span></a></div>
            </div>
        </section>
    </main>

    <%@ include file="/WEB-INF/fragments/footer.jspf" %>
    <script src="${pageContext.request.contextPath}/js/menu.js"></script>

</body>
</html>
