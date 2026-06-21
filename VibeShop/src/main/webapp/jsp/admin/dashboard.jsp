<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Pannello Amministratore - VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css" />
</head>
<body>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<main class="admin-main-container">

    <header class="admin-hero">
        <div class="admin-welcome-box">
            <div class="admin-icon">⚙️</div>
            <div class="admin-welcome-text">
                <h1>Pannello di Controllo</h1>
                <p>Accesso come: <strong>Amministratore</strong></p>
            </div>
        </div>
        
        <div class="admin-quick-stats">
            <div class="quick-stat">
                <span class="stat-val">€ 12.450.123</span>
                <span class="stat-lbl">Entrate Mese</span>
            </div>
            <div class="quick-stat">
                <span class="stat-val">145</span>
                <span class="stat-lbl">Ordini Attivi</span>
            </div>
        </div>
    </header>

    <div class="admin-content-grid">
     
        <aside class="admin-sidebar">
            <nav class="sidebar-nav">
                <a href="${pageContext.request.contextPath}/jsp/admin/dashboard.jsp" class="active">📊 Panoramica</a>
                <a href="${pageContext.request.contextPath}/jsp/admin/ad-orders.jsp">📦 Gestione Ordini</a>
                <a href="${pageContext.request.contextPath}/jsp/admin/products.jsp">🎟️ Gestione Prodotti</a>
                
                <a href="${pageContext.request.contextPath}/logout" class="logout-link">Disconnetti</a>
            </nav>
        </aside>

        <div class="admin-main-view">
            <section class="card-vibe">
                <div class="section-title-row">
                    <h2>Ultimi Ordini Ricevuti</h2>
                    <a href="${pageContext.request.contextPath}/jsp/admin/ad-orders.jsp" class="edit-link">Vedi Tutto</a>
                </div>

                <div class="table-responsive">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Codice Ordine</th>
                                <th>Cliente</th>
                                <th>Data</th>
                                <th>Totale</th>
                                <th>Stato</th>
                                <th>Azione</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><strong>#VB-99812</strong></td>
                                <td>vibe.u@vibeshop.it</td>
                                <td>20 Giu 2026</td>
                                <td>€ 155,00</td>
                                <td><span class="badge pending">In Lavorazione</span></td>
                                <td><a href="${pageContext.request.contextPath}/jsp/admin/ad-orders.jsp" class="btn-manage">Gestisci</a></td>
                            </tr>
                            <tr>
                                <td><strong>#VB-99811</strong></td>
                                <td>mario.rossi@email.it</td>
                                <td>19 Giu 2026</td>
                                <td>€ 45,00</td>
                                <td><span class="badge completed">Spedito</span></td>
                                <td><a href="${pageContext.request.contextPath}/jsp/admin/ad-orders.jsp" class="btn-manage">Gestisci</a></td>
                            </tr>
                            <tr>
                                <td><strong>#VB-99810</strong></td>
                                <td>luigi.verdi@email.it</td>
                                <td>18 Giu 2026</td>
                                <td>€ 81,00</td>
                                <td><span class="badge completed">Spedito</span></td>
                                <td><a href="${pageContext.request.contextPath}/jsp/admin/ad-orders.jsp" class="btn-manage">Gestisci</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>

    </div>
</main>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>

</body>
</html>