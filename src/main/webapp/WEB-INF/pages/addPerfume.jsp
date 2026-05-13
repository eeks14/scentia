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

String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Perfume | Scentia</title>
  <!-- addPerfume.jsp & editPerfume.jsp (identical needs — share this block) -->
<style>
@import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=DM+Sans:wght@300;400;500;600;700&display=swap');
:root {
  --bg:#f7f4ef; --text:#1b1815; --muted:#8c857d;
  --gold:#b8964e; --gold-dark:#8d6b35; --navy:#1a1a2e;
  --shadow:0 10px 30px rgba(0,0,0,0.08); --radius:16px;
}
* { margin:0; padding:0; box-sizing:border-box; }
a { text-decoration:none; color:inherit; }
body {
  font-family:'DM Sans',sans-serif;
  background:radial-gradient(circle at top,#f7f4ef,#ede3d6);
  color:var(--text); line-height:1.6; animation:fadeIn 0.5s ease;
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
.admin-nav-links a { font-size:0.86rem; font-weight:500; color:rgba(255,255,255,0.72); transition:color 0.2s; }
.admin-nav-links a:hover, .admin-nav-links a.active { color:white; }
.btn-logout {
  padding:7px 16px; border-radius:999px; font-size:0.8rem; font-weight:600;
  background:rgba(255,255,255,0.12); color:white !important;
  border:1px solid rgba(255,255,255,0.2); transition:0.2s;
}
.btn-logout:hover { background:rgba(255,255,255,0.22); }
/* FORM WRAPPER */
.form-wrapper {
  width:min(680px,92%); margin:110px auto 60px;
  display:flex; align-items:flex-start; justify-content:center;
}
.form-card {
  width:100%; background:rgba(255,255,255,0.78);
  backdrop-filter:blur(18px); border-radius:20px;
  padding:40px 38px; box-shadow:0 14px 40px rgba(0,0,0,0.1);
  border:1px solid rgba(255,255,255,0.45);
}
.form-card h1 {
  font-family:'Cormorant Garamond',serif;
  font-size:2rem; color:var(--navy); margin-bottom:28px;
}
.form-row { display:flex; flex-direction:column; gap:6px; margin-bottom:16px; }
.form-row label {
  font-size:0.78rem; font-weight:600; color:var(--text);
  letter-spacing:0.05em; text-transform:uppercase;
}
.form-row input, .form-row select, .form-row textarea {
  padding:12px 14px; border-radius:12px;
  border:1px solid rgba(0,0,0,0.12);
  background:rgba(255,255,255,0.88);
  font-size:0.9rem; font-family:'DM Sans',sans-serif;
  outline:none; transition:0.25s ease; width:100%; color:var(--text);
}
.form-row textarea { min-height:100px; resize:vertical; }
.form-row input:focus, .form-row select:focus, .form-row textarea:focus {
  border-color:var(--gold); box-shadow:0 0 0 4px rgba(184,150,78,0.15);
}
/* TWO-COLUMN GRID */
.form-grid { display:grid; grid-template-columns:1fr 1fr; gap:16px; }
.error-msg {
  background:#fdecea; color:#c0392b; border-radius:10px;
  padding:10px 14px; font-size:0.85rem; margin-bottom:18px;
}
.btn-submit {
  width:100%; padding:14px; border:none; border-radius:999px;
  background:linear-gradient(135deg,var(--gold),var(--gold-dark));
  color:white; font-family:'DM Sans',sans-serif;
  font-size:0.95rem; font-weight:600; cursor:pointer; margin-top:10px; transition:0.3s ease;
}
.btn-submit:hover { transform:translateY(-3px); box-shadow:0 14px 28px rgba(184,150,78,0.28); }
.back-link {
  display:inline-block; margin-top:18px; font-size:0.86rem;
  color:var(--gold-dark); font-weight:500;
}
.back-link:hover { text-decoration:underline; }
@keyframes fadeIn { from{opacity:0;transform:translateY(10px)} to{opacity:1;transform:translateY(0)} }
@media(max-width:600px){
  .form-card{padding:28px 18px;}
  .form-grid{grid-template-columns:1fr;}
}
</style>
</head>
<body>

<nav class="admin-navbar">
  <a href="<%= contextPath %>/admin" class="logo">Scent<span>ia</span></a>
  <div class="admin-nav-links">
    <a href="<%= contextPath %>/admin">Dashboard</a>
    <a href="<%= contextPath %>/admin/perfumes">Manage Perfumes</a>
    <a href="<%= contextPath %>/admin/users">Manage Users</a>
    <a href="<%= contextPath %>/logout" class="btn-logout">Logout</a>
  </div>
</nav>

<div class="form-wrapper">
  <div class="form-card">

    <h1>Add New Perfume</h1>

    <% if (error != null) { %>
      <div class="error-msg">❌ <%= error %></div>
    <% } %>

    <form action="<%= contextPath %>/admin/addPerfume" method="post">

      <div class="form-row">
        <label>Perfume Name *</label>
        <input type="text" name="name" placeholder="e.g. Velvet Rose" required>
      </div>

      <div class="form-row">
        <label>Brand *</label>
        <input type="text" name="brand" placeholder="e.g. Maison Margiela" required>
      </div>

      <div class="form-row">
        <label>Category</label>
        <input type="text" name="category" placeholder="e.g. Eau de Parfum">
      </div>

      <div class="form-row">
        <label>Notes</label>
        <input type="text" name="notes" placeholder="e.g. Rose, Musk, Patchouli">
      </div>

      <div class="form-grid">
        <div class="form-row">
          <label>Price ($) *</label>
          <input type="number" name="price" step="0.01" min="0" placeholder="0.00" required>
        </div>
        <div class="form-row">
          <label>Stock *</label>
          <input type="number" name="stock" min="0" placeholder="0" required>
        </div>
      </div>

      <div class="form-grid">
        <div class="form-row">
          <label>Sustainability Score (1–5)</label>
          <input type="number" name="sustainability_score" min="1" max="5" value="5">
        </div>
        <div class="form-row">
          <label>Vibe *</label>
          <select name="vibe" required>
            <option value="">-- Select Vibe --</option>
            <option value="Soft">Soft</option>
            <option value="Bold">Bold</option>
            <option value="Sweet">Sweet</option>
            <option value="Fresh">Fresh</option>
          </select>
        </div>
      </div>

      <div class="form-row">
        <label>Image URL</label>
        <input type="url" name="image_url" placeholder="https://...">
      </div>

      <div class="form-row">
        <label>Description</label>
        <textarea name="description" placeholder="A brief description of the perfume..."></textarea>
      </div>

      <button type="submit" class="btn-submit">Add Perfume</button>
    </form>

    <a class="back-link" href="<%= contextPath %>/admin/perfumes">← Back to Inventory</a>

  </div>
</div>
</body>
</html>
