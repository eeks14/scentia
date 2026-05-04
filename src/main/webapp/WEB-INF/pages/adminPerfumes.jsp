<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.scentia.model.Perfume" %>

<%
    /*
     * FIXES:
     *  1. Added "Vibe" column (was missing entirely).
     *  2. Added proper navigation with Add Perfume button.
     *  3. Added auth guard.
     *  4. Delete now links to /confirmDelete (GET), not directly to delete servlet.
     */
    HttpSession sess = request.getSession(false);
    if (sess == null || sess.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    String contextPath = request.getContextPath();
    String msg = request.getParameter("msg");

    @SuppressWarnings("unchecked")
    ArrayList<Perfume> perfumes =
        (ArrayList<Perfume>) request.getAttribute("perfumes");
    if (perfumes == null) perfumes = new ArrayList<>();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage Perfumes | Scentia Admin</title>
  <link rel="stylesheet" href="<%= contextPath %>/css/style.css">
  <style>
    .admin-shell {
      width: min(1100px, 94%);
      margin: 0 auto;
      padding-top: 110px;
      padding-bottom: 60px;
    }
    .page-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 28px;
      flex-wrap: wrap;
      gap: 12px;
    }
    .page-header h1 {
      font-family: 'Cormorant Garamond', serif;
      font-size: 2rem;
    }
    .btn-add {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 11px 22px;
      border-radius: 999px;
      font-size: .8rem;
      font-weight: 600;
      letter-spacing: .07em;
      background: linear-gradient(135deg, var(--gold), var(--gold-dark));
      color: #fff;
      transition: .3s;
      text-decoration: none;
    }
    .btn-add:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 24px rgba(184,150,78,.3);
    }
    .table-card {
      background: var(--card);
      border: 1px solid rgba(255,255,255,.5);
      backdrop-filter: blur(16px);
      border-radius: 22px;
      box-shadow: var(--shadow);
      overflow: hidden;
    }
    .table-card table {
      width: 100%;
      border-collapse: collapse;
    }
    .table-card th {
      background: rgba(184,150,78,.07);
      text-align: left;
      padding: 14px 18px;
      font-size: .7rem;
      text-transform: uppercase;
      letter-spacing: .12em;
      color: var(--muted);
      font-weight: 600;
      border-bottom: 1px solid var(--border);
    }
    .table-card td {
      padding: 14px 18px;
      font-size: .88rem;
      border-bottom: 1px solid var(--border);
      vertical-align: middle;
    }
    .table-card tr:last-child td { border-bottom: none; }
    .table-card tr:hover td { background: rgba(184,150,78,.04); }

    .vibe-badge {
      display: inline-block;
      padding: 3px 12px;
      border-radius: 999px;
      font-size: .72rem;
      font-weight: 500;
      letter-spacing: .05em;
      background: rgba(184,150,78,.12);
      color: var(--gold-dark);
      text-transform: capitalize;
    }
    .stock-low { color: #c0392b; font-weight: 600; }
    .stock-ok  { color: #27ae60; font-weight: 600; }

    .action-group { display: flex; gap: 8px; }
    .btn-sm-edit {
      padding: 6px 14px; border-radius: 999px; font-size: .75rem;
      font-weight: 600; letter-spacing: .06em;
      background: rgba(184,150,78,.1); color: var(--gold-dark);
      border: 1px solid rgba(184,150,78,.2);
      transition: .2s; text-decoration: none;
    }
    .btn-sm-edit:hover { background: var(--gold); color: #fff; border-color: var(--gold); }
    .btn-sm-del {
      padding: 6px 14px; border-radius: 999px; font-size: .75rem;
      font-weight: 600; letter-spacing: .06em;
      background: rgba(192,57,43,.07); color: #c0392b;
      border: 1px solid rgba(192,57,43,.18);
      transition: .2s; text-decoration: none;
    }
    .btn-sm-del:hover { background: #c0392b; color: #fff; }

    .empty-state {
      text-align: center; padding: 60px 20px; color: var(--muted);
    }
    .toast {
      position: fixed; top: 88px; right: 24px;
      background: linear-gradient(135deg, var(--gold), var(--gold-dark));
      color: #fff; padding: 13px 22px; border-radius: 12px;
      font-size: .86rem; font-weight: 500;
      box-shadow: 0 8px 24px rgba(184,150,78,.35); z-index: 9999;
      animation: slideIn .35s ease, fadeOut .5s 3s forwards;
    }
    @keyframes slideIn { from{opacity:0;transform:translateX(30px)} to{opacity:1;transform:translateX(0)} }
    @keyframes fadeOut { to{opacity:0;pointer-events:none} }
  </style>
</head>
<body>

<!-- ── NAVBAR ─────────────────────────────────────────────── -->
<nav class="navbar">
  <a href="<%= contextPath %>/admin" class="logo">Scent<span>ia</span></a>
  <div class="nav-links">
    <a href="<%= contextPath %>/admin"             class="nav-link">Dashboard</a>
    <a href="<%= contextPath %>/admin/addPerfume"  class="nav-link">+ Add Perfume</a>
    <a href="<%= contextPath %>/logout"            class="nav-link">Logout</a>
  </div>
</nav>

<% if (msg != null && !msg.isEmpty()) { %>
  <div class="toast"><%= msg %></div>
<% } %>

<main class="admin-shell">

  <div class="page-header">
    <h1>Perfume Inventory</h1>
    <a href="<%= contextPath %>/admin/addPerfume" class="btn-add">＋ Add Perfume</a>
  </div>

  <div class="table-card">
    <% if (perfumes.isEmpty()) { %>
      <div class="empty-state">
        <div style="font-size:2.5rem">🌸</div>
        <p>No perfumes yet. <a href="<%= contextPath %>/admin/addPerfume"
           style="color:var(--gold)">Add your first one →</a></p>
      </div>
    <% } else { %>
    <table>
      <thead>
        <tr>
          <th>#</th>
          <th>Name</th>
          <th>Brand</th>
          <th>Price</th>
          <th>Stock</th>
          <th>Vibe</th>   <%-- ADDED --%>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
      <%
        for (Perfume p : perfumes) {
          String stockClass = (p.getStock() > 0) ? "stock-ok" : "stock-low";
          String stockLabel = (p.getStock() > 0) ? String.valueOf(p.getStock()) : "Out";
          String vibeLabel  = (p.getVibe() != null && !p.getVibe().isEmpty())
              ? p.getVibe() : "—";
      %>
        <tr>
          <td style="color:var(--muted);font-size:.8rem"><%= p.getId() %></td>
          <td style="font-weight:500"><%= p.getName() %></td>
          <td style="color:var(--muted)"><%= p.getBrand() %></td>
          <td>$<%= String.format("%.2f", p.getPrice()) %></td>
          <td class="<%= stockClass %>"><%= stockLabel %></td>
          <td><span class="vibe-badge"><%= vibeLabel %></span></td>
          <td>
            <div class="action-group">
              <a class="btn-sm-edit"
                 href="<%= contextPath %>/admin/editPerfume?id=<%= p.getId() %>">
                 Edit
              </a>
              <%-- Links to confirm page (GET), which then POSTs to delete servlet --%>
              <a class="btn-sm-del"
                 href="<%= contextPath %>/confirmDelete?id=<%= p.getId() %>">
                 Delete
              </a>
            </div>
          </td>
        </tr>
      <% } %>
      </tbody>
    </table>
    <% } %>
  </div>

</main>
</body>
</html>
