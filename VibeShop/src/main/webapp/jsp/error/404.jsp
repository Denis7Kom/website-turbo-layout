<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 – Pagina non trovata · VibeShop</title>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --bg:        #F7F7FA;
            --surface:   #FFFFFF;
            --border:    #E5E5E5;
            --primary:   #6A5ACD;
            --primary-light: #ede9fb;
            --accent:    #FF8FBF;
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
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        /* subtle dot pattern */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image: radial-gradient(circle, #6A5ACD22 1px, transparent 1px);
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
            box-shadow: 0 4px 32px rgba(106,90,205,.10);
        }

        /* top accent bar */
        .card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary) 0%, var(--accent) 100%);
            border-radius: var(--radius) var(--radius) 0 0;
        }

        .badge {
            display: inline-block;
            font-size: .72rem;
            font-weight: 700;
            letter-spacing: .1em;
            text-transform: uppercase;
            color: var(--primary);
            background: var(--primary-light);
            border: 1px solid #c4b8f5;
            border-radius: 999px;
            padding: .25rem .9rem;
            margin-bottom: 1.5rem;
        }

        .code {
            font-size: clamp(5rem, 18vw, 7.5rem);
            font-weight: 900;
            letter-spacing: -.04em;
            line-height: 1;
            color: transparent;
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            -webkit-background-clip: text;
            background-clip: text;
            margin-bottom: 1rem;
        }

        h1 {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--text);
            margin-bottom: .6rem;
        }

        p {
            font-size: .95rem;
            color: var(--text-dim);
            line-height: 1.7;
            margin-bottom: 1.75rem;
        }

        .url-box {
            background: var(--bg);
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: .6rem 1rem;
            font-family: 'Consolas', 'Courier New', monospace;
            font-size: .82rem;
            color: var(--text-dim);
            word-break: break-all;
            margin-bottom: 2rem;
            text-align: left;
        }
        .url-box span { color: var(--primary); font-weight: 600; }

        .actions {
            display: flex;
            gap: .75rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            padding: .65rem 1.4rem;
            border-radius: 8px;
            font-size: .9rem;
            font-weight: 600;
            text-decoration: none;
            transition: opacity .15s, transform .15s;
            cursor: pointer;
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
    <div class="badge">Errore 404</div>
    <div class="code" aria-hidden="true">404</div>
    <h1 id="title">Pagina non trovata</h1>
    <p>La risorsa che stai cercando non esiste o è stata spostata.<br>Controlla l'indirizzo e riprova.</p>

    <div class="actions">
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">← Torna alla home</a>
        <a href="${pageContext.request.contextPath}/catalogo" class="btn btn-ghost">Vai al catalogo</a>
    </div>
    <p class="note">Se il problema persiste, contatta l'assistenza.</p>
</div>
</body>
</html>
