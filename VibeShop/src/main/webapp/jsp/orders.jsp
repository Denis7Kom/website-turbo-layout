<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>I miei Ordini - VibeShop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/orders.css" />
</head>
<body>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<main class="profile-main-container">

    <header class="profile-hero">
        <div class="profile-avatar-box">
            <a href="${pageContext.request.contextPath}/jsp/profile.jsp" class="avatar-link">
                <div class="avatar-circle">GP</div>
            </a>
            <div class="profile-welcome">
                <h1>Ciao, Giulio Alessandro</h1>
                <p>Membro dal 2026</p>
            </div>
        </div>
    </header>

    <div class="profile-content-grid">
     
        <aside class="profile-sidebar">
            <nav class="sidebar-nav">
                
                <div class="profile-main-view active">
                    <section class="card-vibe">
                        <div class="section-title-row">
                            <h2>Cronologia Ordini</h2>
                            <span class="orders-count-badge">12 Ordini</span>
                        </div>
            
                        <div class="orders-list">
                            
                            <div class="order-row-item">
                                <div class="order-row-header" onclick="toggleOrder(this)">
                                    <div class="order-col-left">
                                        <span class="order-id">#VB-552910</span>
                                        <span class="order-date">10 Giugno 2026</span>
                                    </div>
                                    <div class="order-col-center">
                                        <div class="order-badge-status shipping">In Consegna</div>
                                    </div>
                                    <div class="order-col-right">
                                        <span class="order-price">€ 81,00</span>
                                        <span class="accordion-arrow">▼</span>
                                    </div>
                                </div>
                                <div class="order-row-body">
                                    <div class="expanded-items-container">
                                        <div class="expanded-item-line">
                                            <span class="item-name">🎟️ Biglietto Concerto – Coldplay (Salerno)</span>
                                            <span class="item-qty">x1</span>
                                            <span class="item-subprice">€ 55,00</span>
                                        </div>
                                        <div class="expanded-item-line">
                                            <span class="item-name">👕 T-Shirt Ufficiale – VibeShop Tour</span>
                                            <span class="item-qty">x1</span>
                                            <span class="item-subprice">€ 26,00</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="order-row-item">
                                <div class="order-row-header" onclick="toggleOrder(this)">
                                    <div class="order-col-left">
                                        <span class="order-id">#VB-541029</span>
                                        <span class="order-date">24 Maggio 2026</span>
                                    </div>
                                    <div class="order-col-center">
                                        <div class="order-badge-status completed">Consegnato ✓</div>
                                    </div>
                                    <div class="order-col-right">
                                        <span class="order-price">€ 125,50</span>
                                        <span class="accordion-arrow">▼</span>
                                    </div>
                                </div>
                                <div class="order-row-body">
                                    <div class="expanded-items-container">
                                        <div class="expanded-item-line">
                                            <span class="item-name">🎵 Vinile Limited Edition – Travis Scott</span>
                                            <span class="item-qty">x1</span>
                                            <span class="item-subprice">€ 45,50</span>
                                        </div>
                                        <div class="expanded-item-line">
                                            <span class="item-name">🎟️ Biglietto Live – Indie Festival 2026</span>
                                            <span class="item-qty">x2</span>
                                            <span class="item-subprice">€ 80,00</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="order-row-item">
                                <div class="order-row-header" onclick="toggleOrder(this)">
                                    <div class="order-col-left">
                                        <span class="order-id">#VB-539811</span>
                                        <span class="order-date">12 Maggio 2026</span>
                                    </div>
                                    <div class="order-col-center">
                                        <div class="order-badge-status completed">Consegnato ✓</div>
                                    </div>
                                    <div class="order-col-right">
                                        <span class="order-price">€ 45,00</span>
                                        <span class="accordion-arrow">▼</span>
                                    </div>
                                </div>
                                <div class="order-row-body">
                                    <div class="expanded-items-container">
                                        <div class="expanded-item-line">
                                            <span class="item-name">🎟️ Biglietto Concerto – Sal Da Vinci</span>
                                            <span class="item-qty">x1</span>
                                            <span class="item-subprice">€ 45,00</span>
                                        </div>
                                    </div>
                                </div>
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

<script>
function toggleOrder(headerElement) {
    // Seleziona la riga intera dell'ordine (.order-row-item)
    const rowItem = headerElement.parentElement;
    // Attiva o disattiva la classe .active che mostra/nasconde i prodotti nel CSS
    rowItem.classList.toggle('active');
}
</script>
</body>
</html>