<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.ConcertoBean" %>
<%!
    private String h(String value) {
        if (value == null) return "";
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
    }
%>
<%
    Object concertObject = request.getAttribute("concert");
    ConcertoBean concert = concertObject instanceof ConcertoBean ? (ConcertoBean) concertObject : null;
    boolean editing = concert != null && concert.getIdConcerto() > 0;
    String formError = (String) request.getAttribute("error");
    SimpleDateFormat inputDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    String dataOra = editing && concert.getDataEvento() != null ? inputDateFormat.format(concert.getDataEvento()) : "";
%>
<!DOCTYPE html><html lang="it"><head><meta charset="UTF-8" /><meta name="viewport" content="width=device-width, initial-scale=1.0" /><title>Concerto - VibeShop</title><link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" /><link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" /><link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css" /></head><body>
<%@ include file="/WEB-INF/fragments/header.jspf" %><%@ include file="/WEB-INF/fragments/nav.jspf" %>
<main class="admin-main-container"><header class="admin-hero"><div class="admin-welcome-box"><div class="admin-icon admin-icon-logo"><img src="${pageContext.request.contextPath}/img/logo.svg" alt="VibeShop" /></div><div class="admin-welcome-text"><h1><%= editing ? "Modifica Concerto" : "Nuovo Concerto" %></h1><p>Gestione dell'evento e del prezzo biglietto.</p></div></div></header>
<div class="admin-content-grid"><aside class="admin-sidebar"><nav class="sidebar-nav"><a href="${pageContext.request.contextPath}/admin/dashboard">Panoramica</a><a href="${pageContext.request.contextPath}/admin/orders">Gestione Ordini</a><a href="${pageContext.request.contextPath}/admin/products">Gestione Prodotti</a><a href="${pageContext.request.contextPath}/admin/concerts" class="active">Gestione Concerti</a><a href="${pageContext.request.contextPath}/logout" class="logout-link">Disconnetti</a></nav></aside><div class="admin-main-view"><section class="card-vibe admin-form-container"><div class="section-title-row"><h2>Dettagli Concerto</h2><a href="${pageContext.request.contextPath}/admin/concerts" class="btn-cancel-link">Annulla</a></div>
<% if (formError != null && !formError.trim().isEmpty()) { %><div class="admin-form-error"><strong>Errore:</strong> <%= h(formError) %></div><% } %>
<form action="${pageContext.request.contextPath}/admin/concerts/save" method="post" class="vibe-admin-form" novalidate><input type="hidden" name="idConcerto" value="<%= editing ? concert.getIdConcerto() : 0 %>"><div class="form-row"><div class="form-group flex-2"><label for="titoloEvento">Titolo evento</label><input type="text" id="titoloEvento" name="titoloEvento" value="<%= editing ? h(concert.getNome()) : "" %>" required /></div><div class="form-group flex-1"><label for="idArtista">ID Artista</label><input type="number" id="idArtista" name="idArtista" min="1" value="<%= editing && concert.getIdArtista() != null ? concert.getIdArtista() : "" %>" /></div></div><div class="form-row"><div class="form-group flex-1"><label for="dataOra">Data e ora</label><input type="datetime-local" id="dataOra" name="dataOra" value="<%= dataOra %>" required /></div><div class="form-group flex-2"><label for="luogoIndirizzo">Luogo / indirizzo</label><input type="text" id="luogoIndirizzo" name="luogoIndirizzo" value="<%= editing ? h(concert.getLuogo()) : "" %>" required /></div></div><div class="form-row"><div class="form-group flex-1"><label for="prezzo">Prezzo biglietto</label><input type="number" id="prezzo" name="prezzo" step="0.01" min="0" value="<%= editing && concert.getPrezzo() != null ? concert.getPrezzo() : "" %>" required /></div><div class="form-group flex-1"><label for="iva">IVA biglietto</label><input type="number" id="iva" name="iva" step="0.01" min="0" value="<%= editing && concert.getIva() != null ? concert.getIva() : "10.00" %>" required /></div><div class="form-group flex-1"><label for="eventManager">Event manager</label><input type="text" id="eventManager" name="eventManager" value="<%= editing ? h(concert.getDescrizione()) : "VibeShop Events" %>" /></div></div><div class="form-actions"><button type="submit" class="btn-save-product">Salva Concerto</button></div></form></section></div></div></main>
<%@ include file="/WEB-INF/fragments/footer.jspf" %><script src="${pageContext.request.contextPath}/js/menu.js"></script></body></html>
