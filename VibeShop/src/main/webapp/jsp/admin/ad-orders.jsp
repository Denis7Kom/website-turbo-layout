<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestione Ordini (Admin) - VibeShop</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css" />
</head>
<body>

<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<main class="admin-main-container">

    <header class="admin-hero">
        <div class="admin-welcome-box">
            <div class="admin-icon">📦</div>
            <div class="admin-welcome-text">
                <h1>Gestione Ordini</h1>
                <p>Monitora gli acquisti globali, filtra per data e aggiorna gli stati di spedizione dei clienti.</p>
            </div>
        </div>
        
        <div class="admin-quick-stats">
            <div class="quick-stat">
                <span class="stat-val">12</span>
                <span class="stat-lbl">Da Spedire</span>
            </div>
            <div class="quick-stat">
                <span class="stat-val">133</span>
                <span class="stat-lbl">Completati</span>
            </div>
        </div>
    </header>

    <div class="admin-content-grid">
     
        <aside class="admin-sidebar">
            <nav class="sidebar-nav">
                <a href="${pageContext.request.contextPath}/jsp/admin/dashboard.jsp">📊 Panoramica</a>
                <a href="${pageContext.request.contextPath}/jsp/admin/ad-orders.jsp" class="active">📦 Gestione Ordini</a>
                <a href="${pageContext.request.contextPath}/jsp/admin/products.jsp">🎟️ Gestione Prodotti</a>
                
                <a href="${pageContext.request.contextPath}/logout" class="logout-link">Disconnetti</a>
            </nav>
        </aside>

        <div class="admin-main-view">
            <section class="card-vibe">
                
                <div class="section-title-row">
                    <h2>Registro Ordini Ricevuti</h2>
                </div>

                <div class="admin-filters-bar">
                    <div class="filter-group-search">
                        <label for="searchOrder">Cerca Ordine o Cliente</label>
                        <input type="text" id="searchOrder" placeholder="Inserisci codice ordine o email utente..." />
                    </div>
                    <div class="filter-group-select">
                        <label for="filterDate">Visualizza per Data</label>
                        <input type="date" id="filterDate" />
                    </div>
                    <div class="filter-group-select">
                        <label for="filterStatus">Stato</label>
                        <select id="filterStatus">
                            <option value="all">Tutti gli stati</option>
                            <option value="pending">In Lavorazione</option>
                            <option value="completed">Spedito</option>
                            <option value="cancelled">Annullato</option>
                        </select>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="