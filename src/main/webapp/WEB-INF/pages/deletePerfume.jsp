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
  @import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=DM+Sans:wght@300;400;500;600;700&display=swap');
:root {
  --bg:#f7f4ef; --card:rgba(255,255,255,0.7); --text:#1b1815;
  --muted:#8c857d; --gold:#b8964e; --gold-dark:#8d6b35;
  --navy:#1a1a2e; --border:rgba(0,0,0,0.12); --shadow:0 10px 30px rgba(0,0,0,0.08);
  --shadow-lg:0 20px 50px rgba(0,0,0,0.14); --radius:16px;
}
* { margin:0; padding:0; box-sizing:border-box; }
a { text-decoration:none; color:inherit; }
body {
  font-family:'DM Sans',sans-serif;
  background:radial-gradient(circle at top,#f7f4ef,#ede3d6);
  color:var(--text); line-height:1.6; animation:fadeIn 0.5s ease;
}
.navbar {
  position:fixed; top:0; left:0; right:0; z-index:100;
  backdrop-filter:blur(18px); background:rgba(255,255,255,0.7);
  box-shadow:0 4px 20px rgba(0,0,0,0.08);
  padding:16px 5%; display:flex; justify-content:space-between; align-items:center;
}
.logo { font-family:'Cormorant Garamond',serif; font-size:1.6rem; font-weight:700; color:var(--navy); }
.logo span { color:var(--gold); }
.nav-links { display:flex; gap:22px; align-items:center; }
.nav-link { font-size:0.86rem; font-weight:500; color:var(--text); transition:color 0.2s; }
.nav-link:hover { color:var(--gold); }
@keyframes fadeIn { from{opacity:0;transform:translateY(10px)} to{opacity:1;transform:translateY(0)} }
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
