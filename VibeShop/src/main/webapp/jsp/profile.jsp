<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard Profilo - VibeShop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css" />
</head>
<body>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<main class="profile-main-container">

    <header class="profile-hero">
        <div class="profile-avatar-box">
            <div class="avatar-circle">NU</div>
            <div class="profile-welcome">
                <h1>Ciao, (nome utente)</h1>
                <p>Membro dal 2026</p>
            </div>
        </div>

        <div class="profile-stats">
            <a href="${pageContext.request.contextPath}/jsp/orders.jsp" class="stat-link">
                <div class="stat-item">
                    <span class="stat-value">12</span>
                    <span class="stat-label">Ordini</span>
                </div>
            </a>
        </div>
    </header>

    <div class="profile-content-grid">
        
        <aside class="profile-sidebar">
            <nav class="sidebar-nav">
                
                <div class="profile-main-view active" id="info-section">
                    <section class="card-vibe">
                        <div class="section-title-row">
                            <h2>Informazioni Personali</h2>
                            <a href="${pageContext.request.contextPath}/jsp/modifica-profilo.jsp" class="edit-link">Modifica</a>
                        </div>
                        
                        <div class="info-grid">
                            <div class="info-field">
                                <label>Nome Completo</label>
                                <p>Vibe User</p>
                            </div>
                            <div class="info-field">
                                <label>Email</label>
                                <p>vibe.u@vibeshop.it</p>
                            </div>
                            <div class="info-field">
                                <label>Telefono</label>
                                <p>+39 333 1234567</p>
                            </div>
                            <div class="info-field">
                                <label>Indirizzo di Spedizione</label>
                                <p>Via Esempio 12, Salerno (SA)</p>
                            </div>
                            <div class="info-field">
                                <label>Metodo di Pagamento</label>
                                <p>•••• •••• •••• 4242</p>
                            </div>
                        </div>
                    </section>
                </div>

                <div class="profile-extra-view">
                    <section class="card-vibe extra-card">
                        <div class="section-title-row">
                            <h2>Dettagli Account</h2>
                        </div>
                        
                        <div class="info-grid">
                            <div class="info-field">
                                <label>Tipo di Account</label>
                                <p>User</p>
                            </div>
                            <div class="info-field">
                                <label>Stato Sicurezza</label>
                                <p style="color: #2e7d32; font-weight: 700;">Verificato ✓</p>
                            </div>                           
                            <div class="info-field">
                                <label>Generi Preferiti</label>
                                <p>Rock, Live Music, Pop</p>
                            </div>
                            <div class="info-field">
                                <label>Dispositivi Collegati</label>
                                <p>Desktop (Linux Mint)</p>
                            </div>
                        </div>
                    </section>
                </div>

                <a href="${pageContext.request.contextPath}/logout" class="logout-link">Disconnetti</a>
            </nav>
        </aside>

    </div>
</main>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>