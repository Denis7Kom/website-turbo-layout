<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestione Catalogo Prodotti - VibeShop</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css" />
</head>
<body>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<main class="admin-main-container">

    <header class="admin-hero">
        <div class="admin-welcome-box">
            <div class="admin-icon">🎟️</div>
            <div class="admin-welcome-text">
                <h1>Gestione Prodotti & Eventi</h1>
                <p>Aggiungi nuovi concerti, modifica i dettagli del merchandising e controlla la disponibilità in magazzino.</p>
            </div>
        </div>
        
        <div class="admin-quick-stats">
            <div class="quick-stat">
                <span class="stat-val">24</span>
                <span class="stat-lbl">Articoli Attivi</span>
            </div>
            <div class="quick-stat">
                <span class="stat-val">2</span>
                <span class="stat-lbl">In Esaurimento</span>
            </div>
        </div>
    </header>

    <div class="admin-content-grid">
     
        <aside class="admin-sidebar">
            <nav class="sidebar-nav">
                <a href="${pageContext.request.contextPath}/jsp/admin/dashboard.jsp">📊 Panoramica</a>
                <a href="${pageContext.request.contextPath}/jsp/admin/ad-orders.jsp">📦 Gestione Ordini</a>
                <a href="${pageContext.request.contextPath}/jsp/admin/products.jsp" class="active">🎟️ Gestione Prodotti</a>
                
                <a href="${pageContext.request.contextPath}/logout" class="logout-link">Disconnetti</a>
            </nav>
        </aside>

        <div class="admin-main-view">
            <section class="card-vibe">
                
                <div class="section-title-row">
                    <h2>Catalogo Articoli</h2>
                    <a href="${pageContext.request.contextPath}/jsp/admin/product-form.jsp" class="btn-add-product">
                        <span>＋</span> Aggiungi Prodotto
                    </a>
                </div>

                <div class="admin-filters-bar">
                    <div class="filter-group-search">
                        <label for="searchProduct">Cerca nel catalogo</label>
                        <input type="text" id="searchProduct" placeholder="Cerca per nome artista, biglietto, t-shirt..." />
                    </div>
                    <div class="filter-group-select">
                        <label for="filterCategory">Categoria</label>
                        <select id="filterCategory">
                            <option value="all">Tutte le categorie</option>
                            <option value="concerti">🎟️ Concerti Live</option>
                            <option value="merch">👕 Merchandising</option>
                        </select>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Prodotto</th>
                                <th>Categoria</th>
                                <th>Prezzo</th>
                                <th>Disponibilità (Stock)</th>
                                <th style="text-align: center;">Azioni</th>
                            </tr>
                        </thead>
                        <tbody>
                            
                            <tr>
                                <td>
                                    <div class="product-info-cell">
                                        <span class="product-emoji">🎟️</span>
                                        <div class="product-text-meta">
                                            <strong>Coldplay Live – Stadio Arechi</strong>
                                            <span class="product-subtext">Data: 12 Luglio 2026 • Salerno</span>
                                        </div>
                                    </div>
                                </td>
                                <td><span class="badge-category event">Concerto</span></td>
                                <td><strong>€ 55,00</strong></td>
                                <td><span class="stock-indicator sound-good">450 biglietti</span></td>
                                <td>
                                    <div class="admin-actions-cell">
                                        <a href="${pageContext.request.contextPath}/jsp/admin/product-form.jsp?id=1" class="btn-table-edit">Modifica</a>
                                        <button class="btn-table-delete" onclick="deleteProduct('Coldplay Live')">Elimina</button>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <div class="product-info-cell">
                                        <span class="product-emoji">👕</span>
                                        <div class="product-text-meta">
                                            <strong>T-Shirt Ufficiale VibeShop Tour</strong>
                                            <span class="product-subtext">Variante: Taglia M • Cotone 100%</span>
                                        </div>
                                    </div>
                                </td>
                                <td><span class="badge-category merch">Merchandise</span></td>
                                <td><strong>€ 26,00</strong></td>
                                <td><span class="stock-indicator sound-low">5 rimasti</span></td>
                                <td>
                                    <div class="admin-actions-cell">
                                        <a href="${pageContext.request.contextPath}/jsp/admin/product-form.jsp?id=2" class="btn-table-edit">Modifica</a>
                                        <button class="btn-table-delete" onclick="deleteProduct('T-Shirt Ufficiale')">Elimina</button>
                                    </div>
                                </td>
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

<script>
function deleteProduct(productName) {
    if(confirm("Sei sicuro di voler eliminare definitivamente '" + productName + "' dal catalogo?")) {
        alert("Richiesta di eliminazione inviata alla Servlet controllore.");
    }
}
</script>
</body>
</html>