<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.scentia.model.User" %>

<%
String contextPath = request.getContextPath();
User user = (User) session.getAttribute("user");

if (user == null) {
    response.sendRedirect(contextPath + "/login");
    return;
}
if (!"admin".equals(user.getRole())) {
    response.sendRedirect(contextPath + "/home");
    return;
}

String msg = request.getParameter("msg");
int totalPerfumes = request.getAttribute("totalPerfumes") != null
    ? (int) request.getAttribute("totalPerfumes") : 0;
int totalUsers = request.getAttribute("totalUsers") != null
    ? (int) request.getAttribute("totalUsers") : 0;
int lowStock = request.getAttribute("lowStock") != null
    ? (int) request.getAttribute("lowStock") : 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard | Scentia</title>
 <!-- admin.jsp -->
<style>
@import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=DM+Sans:wght@300;400;500;600;700&display=swap');
:root {
  --bg:#f7f4ef; --card:rgba(255,255,255,0.7); --text:#1b1815;
  --muted:#8c857d; --gold:#b8964e; --gold-dark:#8d6b35;
  --navy:#1a1a2e; --border:rgba(0,0,0,0.08); --shadow:0 10px 30px rgba(0,0,0,0.08); --radius:16px;
}
* { margin:0; padding:0; box-sizing:border-box; }
a { text-decoration:none; color:inherit; }
body {
  font-family:'DM Sans',sans-serif;
  background:radial-gradient(circle at top,#f7f4ef,#ede3d6);
  color:var(--text); line-height:1.6;
}
/* ADMIN NAVBAR */
.admin-navbar {
  position:fixed; top:0; left:0; right:0; z-index:100;
  backdrop-filter:blur(18px); background:rgba(26,26,46,0.96);
  box-shadow:0 4px 20px rgba(0,0,0,0.2);
  padding:16px 5%; display:flex; justify-content:space-between; align-items:center;
}
.logo { font-family:'Cormorant Garamond',serif; font-size:1.6rem; font-weight:700; color:white; }
.logo span { color:var(--gold); }
.admin-nav-links { display:flex; gap:22px; align-items:center; }
.admin-nav-links a { font-size:0.86rem; font-weight:500; color:rgba(255,255,255,0.75); transition:color 0.2s; }
.admin-nav-links a:hover, .admin-nav-links a.active { color:white; }
.btn-logout {
  padding:7px 16px; border-radius:999px; font-size:0.8rem; font-weight:600;
  background:rgba(255,255,255,0.12); color:white !important; border:1px solid rgba(255,255,255,0.2);
  transition:0.2s;
}
.btn-logout:hover { background:rgba(255,255,255,0.22); }
/* DASHBOARD WRAPPER */
.dashboard-wrapper {
  width:min(1200px,92%); margin:100px auto 60px; padding-top:20px;
}
.admin-dashboard { animation:fadeUp 0.6s ease; }
/* HEADER */
.premium-header {
  display:flex; justify-content:space-between; align-items:flex-end;
  margin-bottom:32px; gap:20px; flex-wrap:wrap;
}
.eyebrow { font-size:0.75rem; color:var(--muted); letter-spacing:0.14em; text-transform:uppercase; margin-bottom:6px; }
.dash-header h1 {
  font-family:'Cormorant Garamond',serif; font-size:2.4rem; color:var(--navy); margin-bottom:6px;
}
.dash-header p { color:var(--muted); font-size:0.92rem; }
/* TOAST */
.toast-msg {
  background:linear-gradient(135deg,var(--gold),var(--gold-dark));
  color:white; padding:12px 20px; border-radius:12px;
  font-size:0.86rem; font-weight:500; margin-bottom:24px;
  box-shadow:0 8px 24px rgba(184,150,78,0.3);
}
/* STAT GRID */
.stat-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:18px; margin-bottom:28px; }
.stat-card {
  position:relative; overflow:hidden; border-radius:18px;
  padding:24px 22px; display:flex; align-items:center; gap:16px;
  box-shadow:0 10px 28px rgba(0,0,0,0.1);
}
.stat-card::before {
  content:""; position:absolute; width:120px; height:120px;
  top:-40px; right:-40px; background:rgba(255,255,255,0.15); border-radius:50%;
}
.gradient-card.pink { background:linear-gradient(135deg,#ff9a9e,#fad0c4); color:#fff; }
.gradient-card.blue { background:linear-gradient(135deg,#4facfe,#00f2fe); color:#fff; }
.gradient-card.orange { background:linear-gradient(135deg,#f6d365,#fda085); color:#fff; }
.stat-icon { font-size:2rem; }
.stat-num { font-size:2.2rem; font-weight:700; line-height:1; }
.stat-label { font-size:0.82rem; opacity:0.88; margin-top:3px; }
/* ACTION GRID */
.action-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:16px; margin-bottom:28px; }
.action-card {
  border-radius:18px; padding:22px 20px;
  background:rgba(255,255,255,0.72); backdrop-filter:blur(16px);
  border:1px solid rgba(255,255,255,0.45);
  box-shadow:var(--shadow); transition:all 0.3s ease;
  display:block;
}
.action-card:hover { transform:translateY(-6px); box-shadow:0 18px 40px rgba(0,0,0,0.12); }
.action-card h3 { font-size:1rem; font-weight:600; color:var(--navy); margin-bottom:5px; }
.action-card p { font-size:0.83rem; color:var(--muted); }
/* ACTIVITY */
.activity-section {
  background:rgba(255,255,255,0.72); backdrop-filter:blur(16px);
  border-radius:18px; padding:26px 24px;
  border:1px solid rgba(255,255,255,0.45); box-shadow:var(--shadow);
}
.activity-section h2 {
  font-family:'Cormorant Garamond',serif;
  font-size:1.4rem; color:var(--navy); margin-bottom:18px;
}
.activity-table { width:100%; border-collapse:collapse; }
.activity-table td { padding:13px 8px; border-bottom:1px solid rgba(0,0,0,0.06); font-size:0.88rem; }
.activity-table tr:last-child td { border-bottom:none; }
.activity-table tr:hover td { background:rgba(184,150,78,0.07); }
/* BADGES */
.badge { padding:4px 12px; border-radius:999px; font-size:0.74rem; font-weight:600; }
.badge-match { background:#d0f0ff; color:#0077b6; }
.badge-update { background:#d8f3dc; color:#2d6a4f; }
.badge-register { background:#fff3b0; color:#9c6b00; }
/* BUTTONS */
.btn-primary {
  display:inline-block; padding:12px 22px; border-radius:999px; border:none;
  background:linear-gradient(135deg,var(--gold),var(--gold-dark));
  color:white; font-family:'DM Sans',sans-serif;
  font-weight:600; font-size:0.88rem; cursor:pointer; transition:0.3s ease;
}
.btn-primary:hover { transform:translateY(-3px); box-shadow:0 12px 25px rgba(184,150,78,0.3); }
@keyframes fadeUp { from{opacity:0;transform:translateY(20px)} to{opacity:1;transform:translateY(0)} }
@media(max-width:900px){
  .stat-grid{ grid-template-columns:1fr; }
  .action-grid{ grid-template-columns:1fr 1fr; }
}
@media(max-width:540px){
  .action-grid{ grid-template-columns:1fr; }
  .premium-header{ flex-direction:column; align-items:flex-start; }
}
</style>
</head>
<body>

<!-- ADMIN NAVBAR -->
<nav class="admin-navbar">
  <a href="<%= contextPath %>/admin" class="logo">Scent<span>ia</span></a>
  <div class="admin-nav-links">
    <a href="<%= contextPath %>/admin" class="active">Dashboard</a>
    <a href="<%= contextPath %>/admin/perfumes">Manage Perfumes</a>
    <a href="<%= contextPath %>/admin/users">Manage Users</a>
    <a href="<%= contextPath %>/logout" class="btn-logout">Logout</a>
  </div>
</nav>

<div class="dashboard-wrapper admin-dashboard">

  <!-- HEADER -->
  <div class="dash-header premium-header">
    <div class="header-left">
      <p class="eyebrow">Control Panel</p>
      <h1>Admin Dashboard</h1>
      <p>Manage your fragrance system — inventory, users, and activity.</p>
    </div>

    <div class="header-right">
      <a href="<%= contextPath %>/admin/addPerfume" class="btn-primary">
        + Add Perfume
      </a>
    </div>
  </div>

  <% if (msg != null && !msg.isEmpty()) { %>
    <div class="toast-msg"><%= msg %></div>
  <% } %>

  <!-- STATS -->
  <div class="stat-grid premium-stats">

    <div class="stat-card gradient-card pink">
      <div class="stat-icon">✨</div>
      <div>
        <div class="stat-num"><%= totalPerfumes %></div>
        <div class="stat-label">Total Perfumes</div>
      </div>
    </div>

    <div class="stat-card gradient-card blue">
      <div class="stat-icon">👥</div>
      <div>
        <div class="stat-num"><%= totalUsers %></div>
        <div class="stat-label">Total Users</div>
      </div>
    </div>

    <div class="stat-card gradient-card orange">
      <div class="stat-icon">⚠️</div>
      <div>
        <div class="stat-num"><%= lowStock %></div>
        <div class="stat-label">Low Stock</div>
      </div>
    </div>

  </div>

  <!-- QUICK ACTIONS -->
  <div class="action-grid premium-actions">

    <a class="action-card" href="<%= contextPath %>/admin/perfumes">
      <div>
        <h3>Manage Perfumes</h3>
        <p>Update inventory & pricing</p>
      </div>
    </a>

    <a class="action-card" href="<%= contextPath %>/admin/users">
      <div>
        <h3>Manage Users</h3>
        <p>Control accounts & access</p>
      </div>
    </a>

    <a class="action-card" href="<%= contextPath %>/perfume">
      <div>
        <h3>View Store</h3>
        <p>Preview customer experience</p>
      </div>
    </a>

  </div>

  <!-- ACTIVITY -->
  <div class="activity-section premium-activity">
    <h2>Recent Activity</h2>

    <table class="activity-table">
      <tbody>
        <tr>
          <td>Aasuka Pun</td>
          <td>Matched with Velvet Rose</td>
          <td><span class="badge badge-match">Match</span></td>
          <td>2 mins ago</td>
        </tr>

        <tr>
          <td>Chomolung Rai</td>
          <td>Updated Profile</td>
          <td><span class="badge badge-update">Update</span></td>
          <td>15 mins ago</td>
        </tr>

        <tr>
          <td>Stuti Upadhaya</td>
          <td>New Registration</td>
          <td><span class="badge badge-register">New</span></td>
          <td>1 hour ago</td>
        </tr>
      </tbody>
    </table>
  </div>

</div>
</body>
</html>
