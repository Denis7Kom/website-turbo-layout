<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Aggiungi/Modifica Prodotto - VibeShop</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css" />
</head>
<body>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<main class="admin-main-container">

    <header class="admin-hero">
        <div class="admin-welcome-box">
            <div class="admin-icon">✏️</div>
            <div class="admin-welcome-text">
                <h1>Inserimento Nuovo Articolo</h1>
                <p>Compila i campi sottostanti per aggiungere un nuovo evento o prodotto al catalogo.</p>
            </div>
        </div>
    </header>

    <div class="admin-content-grid">
     
        <aside class="admin-sidebar">
            <nav class="sidebar-nav">
                <a href="${pageContext.request.contextPath}/jsp/admin/dashboard.jsp">📊 Panoramica</a>
                <a href="${pageContext.request.contextPath}/jsp/admin/orders.jsp">📦 Gestione Ordini</a>
                <a href="${pageContext.request.contextPath}/jsp/admin/products.jsp" class="active">🎟️ Gestione Prodotti</a>
                
                <a href="${pageContext.request.contextPath}/logout" class="logout-link">Disconnetti</a>
            </nav>
        </aside>

        <div class="admin-main-view">
            <section class="card-vibe admin-form-container">
                
                <div class="section-title-row">
                    <h2>Dettagli Articolo</h2>
                    <a href="${pageContext.request.contextPath}/jsp/admin/products.jsp" class="btn-cancel-link">Annulla e Torna Indietro</a>
                </div>

                <form action="${pageContext.request.contextPath}/AdminProductServlet" method="POST" class="vibe-admin-form">
                    
                    <div class="form-row">
                        <div class="form-group flex-2">
                            <label for="nomeProdotto">Nome Prodotto / Titolo Evento *</label>
                            <input type="text" id="nomeProdotto" name="nomeProdotto" placeholder="Es. Maglietta Tour o Nome Concerto..." required />
                        </div>
                        <div class="form-group flex-1">
                            <label for="categoria">Categoria *</label>
                            <select id="categoria" name="categoria" onchange="toggleConcertFields()" required>
                                <option value="merch" selected>Merchandising</option>
                                <option value="concerto">Concerto Live</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group flex-1">
                            <label for="prezzo">Prezzo di Vendita (€) *</label>
                            <input type="number" id="prezzo" name="prezzo" step="0.01" min="0" placeholder="0.00" required />
                        </div>
                        <div class="form-group flex-1">
                            <label for="quantita">Quantità in Stock *</label>
                            <input type="number" id="quantita" name="quantita" min="0" placeholder="Es. 100" required />
                        </div>
                        <div class="form-group flex-1">
                            <label for="idArtista">Artista Collegato</label>
                            <select id="idArtista" name="idArtista">
                                <option value="">Nessuno / Varie</option>
                                <option value="1">Coldplay</option>
                                <option value="2">Travis Scott</option>
                                <option value="3">Sal Da Vinci</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row dynamic-concert-fields" id="concertFields" style="display: none;">
                        <div class="form-group flex-1">
                            <label for="dataEvento">Data e Ora Evento</label>
                            <input type="datetime-local" id="dataEvento" name="dataEvento" />
                        </div>
                        <div class="form-group flex-2">
                            <label for="luogoEvento">Luogo / Stadio</label>
                            <input type="text" id="luogoEvento" name="luogoEvento" placeholder="Es. Stadio Arechi, Salerno" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="descrizione">Descrizione Dettagliata</label>
                        <textarea id="descrizione" name="descrizione" rows="4" placeholder="Inserisci i dettagli del prodotto o del concerto..."></textarea>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn-save-product">Salva nel Catalogo</button>
                    </div>

                </form>
            </section>
        </div>

    </div>
</main>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>

<script>
function toggleConcertFields() {
    const categorySelect = document.getElementById("categoria");
    const concertFields = document.getElementById("concertFields");
    
    if (categorySelect.value === "concerto") {
        concertFields.style.display = "flex";
    } else {
        concertFields.style.display = "none";
    }
}
</script>
</body>
</html>