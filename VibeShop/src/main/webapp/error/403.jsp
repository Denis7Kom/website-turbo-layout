<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>403 – Accesso negato · VibeShop</title>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --bg:        #F7F7FA;
            --surface:   #FFFFFF;
            --border:    #E5E5E5;
            --primary:   #6A5ACD;
            --primary-light: #ede9fb;
            --accent:    #FF8FBF;
            --accent-light: #fff0f6;
            --text:      #1E1E1E;
            --text-dim:  #7A7A7A;
            --radius:    14px;
        }

        body {
            min-height: 100vh;
            background: var(--bg);
            color: var(--text);
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image: radial-gradient(circle, #FF8FBF22 1px, transparent 1px);
            background-size: 28px 28px;
            pointer-events: none;
        }

        .card {
            position: relative;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 3rem 3.5rem;
            max-width: 520px;
            width: 100%;
            text-align: center;
            box-shadow: 0 4px 32px rgba(255,143,191,.12);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--accent) 0%, var(--primary) 100%);
            border-radius: var(--radius) var(--radius) 0 0;
        }

        .badge {
            display: inline-block;
            font-size: .72rem;
            font-weight: 700;
            letter-spacing: .1em;
            text-transform: uppercase;
            color: #c2185b;
            background: var(--accent-light);
            border: 1px solid #ffb8d4;
            border-radius: 999px;
            padding: .25rem .9rem;
            margin-bottom: 1.5rem;
        }

        /* CSS lock icon */
        .lock-wrap { display: flex; justify-content: center; margin-bottom: 1.2rem; }
        .lock { position: relative; width: 52px; }
        .lock-shackle {
            width: 22px; height: 16px;
            border: 2.5px solid var(--accent);
            border-bottom: none;
            border-radius: 11px 11px 0 0;
            margin: 0 auto -2px;
        }
        .lock-body {
            width: 40px; height: 32px;
            background: var(--accent-light);
            border: 2.5px solid var(--accent);
            border-radius: 6px;
            margin: 0 auto;
            display: flex; align-items: center; justify-content: center;
        }
        .lock-body::after {
            content: '';
            width: 9px; height: 9px;
            border-radius: 50%;
            background: var(--accent);
        }

        .code {
            font-size: clamp(5rem, 18vw, 7.5rem);
            font-weight: 900;
            letter-spacing: -.04em;
            line-height: 1;
            color: transparent;
            background: linear-gradient(135deg, var(--accent) 0%, var(--primary) 100%);
            -webkit-background-clip: text;
            background-clip: text;
            margin-bottom: 1rem;
        }

        h1 { font-size: 1.3rem; font-weight: 700; margin-bottom: .6rem; }

        p { font-size: .95rem; color: var(--text-dim); line-height: 1.7; margin-bottom: 1.75rem; }

        .info-box {
            background: var(--accent-light);
            border: 1px solid #ffb8d4;
            border-left: 3px solid var(--accent);
            border-radius: 8px;
            padding: .85rem 1.1rem;
            font-size: .87rem;
            color: var(--text-dim);
            text-align: left;
            margin-bottom: 2rem;
            line-height: 1.6;
        }
        .info-box strong { color: var(--text); }

        .actions { display: flex; gap: .75rem; justify-content: center; flex-wrap: wrap; }

        .btn {
            display: inline-flex; align-items: center;
            padding: .65rem 1.4rem;
            border-radius: 8px; font-size: .9rem; font-weight: 600;
            text-decoration: none;
            transition: opacity .15s, transform .15s;
        }
        .btn:hover { opacity: .85; transform: translateY(-1px); }
        .btn-primary { background: var(--primary); color: #fff; border: none; }
        .btn-ghost   { background: transparent; color: var(--text-dim); border: 1px solid var(--border); }

        .note { margin-top: 2rem; font-size: .78rem; color: #bbb; }

        @media (max-width: 480px) {
            .card { padding: 2rem 1.5rem; }
            .actions { flex-direction: column; }
            .btn { justify-content: center; }
        }
    </style>
</head>
<body>
<div class="card" role="main" aria-labelledby="title">
    <div class="badge">Errore 403</div>

    <div class="lock-wrap" aria-hidden="true">
        <div class="lock">
            <div class="lock-shackle"></div>
            <div class="lock-body"></div>
        </div>
    </div>

    <div class="code" aria-hidden="true">403</div>
    <h1 id="title">Accesso negato</h1>
    <p>Non hai i permessi per visualizzare questa pagina.<br>Effettua il login con un account autorizzato.</p>

    <div class="info-box">
        <strong>Cosa puoi fare:</strong><br>
        Accedi con il tuo account VibeShop. Se stai cercando di raggiungere l'area admin,
        assicurati di usare un account con i permessi corretti.
    </div>

    <div class="actions">
        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Accedi</a>
        <a href="${pageContext.request.contextPath}/" class="btn btn-ghost">← Home</a>
    </div>
    <p class="note">Se il problema persiste, contatta l'assistenza.</p>
</div>
</body>
</html>
