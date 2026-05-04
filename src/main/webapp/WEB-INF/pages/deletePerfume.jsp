<%@ page contentType="text/html;charset=UTF-8" %>

<%
    HttpSession sess = request.getSession(false);
    if (sess == null || sess.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String contextPath = request.getContextPath();
    String id = (String) request.getAttribute("id");
    if (id == null) {
        response.sendRedirect(contextPath + "/admin");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Delete Perfume | Scentia Admin</title>
  <link rel="stylesheet" href="<%= contextPath %>/css/style.css">
  <style>
    .confirm-shell {
      width: min(480px, 94%);
      margin: 0 auto;
      padding-top: 130px;
      padding-bottom: 60px;
    }
    .confirm-card {
      background: var(--card);
      border: 1px solid rgba(255,255,255,.5);
      backdrop-filter: blur(16px);
      border-radius: 24px;
      box-shadow: var(--shadow-lg);
      padding: 48px 44px;
      text-align: center;
    }
    .confirm-icon {
      font-size: 3rem;
      margin-bottom: 20px;
    }
    .confirm-card h2 {
      font-family: 'Cormorant Garamond', serif;
      font-size: 1.9rem;
      margin-bottom: 12px;
    }
    .confirm-card p {
      color: var(--muted);
      font-size: .88rem;
      line-height: 1.6;
      margin-bottom: 36px;
    }
    .confirm-actions {
      display: flex;
      gap: 12px;
      justify-content: center;
      flex-wrap: wrap;
    }
    .btn-danger-confirm {
      padding: 13px 28px;
      border: none;
      border-radius: 999px;
      background: #c0392b;
      color: #fff;
      font-family: 'DM Sans', sans-serif;
      font-size: .88rem;
      font-weight: 600;
      cursor: pointer;
      transition: .25s;
    }
    .btn-danger-confirm:hover {
      background: #a93226;
      transform: translateY(-2px);
      box-shadow: 0 8px 20px rgba(192,57,43,.3);
    }
    .btn-cancel {
      padding: 13px 28px;
      border-radius: 999px;
      background: transparent;
      border: 1.5px solid var(--border);
      color: var(--muted);
      font-family: 'DM Sans', sans-serif;
      font-size: .88rem;
      font-weight: 500;
      cursor: pointer;
      transition: .25s;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
    }
    .btn-cancel:hover {
      border-color: var(--text);
      color: var(--text);
    }
  </style>
</head>
<body>

<!-- ── NAVBAR ─────────────────────────────────────────────── -->
<nav class="navbar">
  <a href="<%= contextPath %>/admin" class="logo">Scent<span>ia</span></a>
  <div class="nav-links">
    <a href="<%= contextPath %>/admin"  class="nav-link">Dashboard</a>
    <a href="<%= contextPath %>/logout" class="nav-link">Logout</a>
  </div>
</nav>

<main class="confirm-shell">
  <div class="confirm-card">
    <div class="confirm-icon">🗑️</div>
    <h2>Delete Perfume?</h2>
    <p>
      This action is permanent and cannot be undone.<br>
      The perfume will be removed from your catalogue immediately.
    </p>

    <div class="confirm-actions">

     
      <form action="<%= contextPath %>/admin/deletePerfume" method="post"
            style="display:inline">
        <input type="hidden" name="id" value="<%= id %>">
        <button class="btn-danger-confirm" type="submit">
          Yes, Delete
        </button>
      </form>

      <a class="btn-cancel" href="<%= contextPath %>/admin">
        Cancel
      </a>

    </div>
  </div>
</main>

</body>
</html>
