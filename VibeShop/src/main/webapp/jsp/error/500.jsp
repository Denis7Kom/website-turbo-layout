<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 – Errore del server · VibeShop</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/img/logo.svg" />
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root { --bg:#F7F7FA; --surface:#FFFFFF; --border:#E5E5E5; --primary:#6A5ACD; --accent:#FF8FBF; --danger:#e53e3e; --danger-light:#fff5f5; --text:#1E1E1E; --text-dim:#7A7A7A; --radius:14px; }
        body { min-height:100vh; background:var(--bg); color:var(--text); font-family:'Segoe UI',system-ui,-apple-system,sans-serif; display:flex; align-items:center; justify-content:center; padding:2rem; }
        body::before { content:''; position:fixed; inset:0; background-image:radial-gradient(circle,#e53e3e18 1px,transparent 1px); background-size:28px 28px; pointer-events:none; }
        .card { position:relative; background:var(--surface); border:1px solid var(--border); border-radius:var(--radius); padding:3rem 3.5rem; max-width:560px; width:100%; text-align:center; box-shadow:0 4px 32px rgba(229,62,62,.10); }
        .card::before { content:''; position:absolute; top:0; left:0; right:0; height:4px; background:linear-gradient(90deg,var(--danger) 0%,var(--accent) 100%); border-radius:var(--radius) var(--radius) 0 0; }
        .badge { display:inline-block; font-size:.72rem; font-weight:700; letter-spacing:.1em; text-transform:uppercase; color:var(--danger); background:var(--danger-light); border:1px solid #fca5a5; border-radius:999px; padding:.25rem .9rem; margin-bottom:1.5rem; }
        .code { font-size:clamp(5rem,18vw,7.5rem); font-weight:900; letter-spacing:-.04em; line-height:1; color:transparent; background:linear-gradient(135deg,var(--danger) 0%,var(--accent) 100%); -webkit-background-clip:text; background-clip:text; margin-bottom:1rem; }
        h1 { font-size:1.3rem; font-weight:700; margin-bottom:.6rem; }
        p { font-size:.95rem; color:var(--text-dim); line-height:1.7; margin-bottom:1.75rem; }
        .trace-toggle { display:inline-flex; align-items:center; gap:.4rem; background:none; border:1px solid var(--border); color:var(--text-dim); border-radius:6px; padding:.4rem .85rem; font-size:.8rem; cursor:pointer; margin-bottom:1rem; transition:border-color .15s; }
        .trace-toggle:hover { border-color:var(--primary); }
        .trace-toggle .arrow { transition:transform .2s; }
        .trace-toggle.open .arrow { transform:rotate(90deg); }
        .trace-box { display:none; background:var(--bg); border:1px solid var(--border); border-radius:8px; padding:1rem; font-family:'Consolas','Courier New',monospace; font-size:.75rem; color:var(--text-dim); text-align:left; overflow-x:auto; white-space:pre-wrap; word-break:break-all; max-height:180px; overflow-y:auto; margin-bottom:1.5rem; }
        .trace-box.open { display:block; }
        .actions { display:flex; gap:.75rem; justify-content:center; flex-wrap:wrap; }
        .btn { display:inline-flex; align-items:center; justify-content:center; padding:.65rem 1.4rem; border-radius:8px; font-size:.9rem; font-weight:600; text-decoration:none; transition:opacity .15s, transform .15s; cursor:pointer; }
        .btn:hover { opacity:.85; transform:translateY(-1px); }
        .btn-primary { background:var(--primary); color:#fff; border:none; }
        .btn-ghost { background:transparent; color:var(--text-dim); border:1px solid var(--border); }
        .note { margin-top:2rem; font-size:.78rem; color:#bbb; }
        @media (max-width:480px) { .card { padding:2rem 1.5rem; } .actions { flex-direction:column; } }
    </style>
</head>
<body>
<div class="card" role="main" aria-labelledby="title">
    <div class="badge">Errore 500</div>
    <div class="code" aria-hidden="true">500</div>
    <h1 id="title">Errore interno del server</h1>
    <p>Qualcosa è andato storto sul server.<br>Puoi tornare alla pagina precedente, riprovare o rientrare nella home.</p>

    <% if (exception != null) { %>
    <button class="trace-toggle" onclick="toggleTrace(this)" aria-expanded="false">
        <span class="arrow">▶</span> Dettagli tecnici
    </button>
    <div class="trace-box" id="trace" role="log">
<%= exception.toString() %>
<%  for (StackTraceElement el : exception.getStackTrace()) { out.println("  at " + el.toString()); } %>
    </div>
    <% } %>

    <div class="actions">
        <button type="button" class="btn btn-primary" onclick="goBackOrHome()">← Pagina precedente</button>
        <button class="btn btn-ghost" onclick="location.reload()">Riprova</button>
        <a href="${pageContext.request.contextPath}/jsp/index.jsp" class="btn btn-ghost">Home</a>
    </div>
    <p class="note">Codice: 500 &nbsp;·&nbsp; <%= new java.util.Date() %></p>
</div>

<script>
function toggleTrace(btn) {
    const box = document.getElementById('trace');
    const open = box.classList.toggle('open');
    btn.classList.toggle('open', open);
    btn.setAttribute('aria-expanded', open);
}
function goBackOrHome() {
    if (document.referrer && document.referrer.indexOf(location.origin) === 0) {
        history.back();
    } else {
        location.href = '${pageContext.request.contextPath}/jsp/index.jsp';
    }
}
</script>
</body>
</html>
