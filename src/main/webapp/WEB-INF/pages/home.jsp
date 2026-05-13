<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.scentia.model.User" %>

<%
String contextPath = request.getContextPath();
User user = (User) session.getAttribute("user");

if (user == null) {
    response.sendRedirect(contextPath + "/login");
    return;
}

String fullName  = user.getName();
if (fullName == null || fullName.trim().isEmpty()) fullName = "Guest";
String firstName = fullName.split(" ")[0];
String role      = user.getRole();
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Home | Scentia</title>
  <!-- home.jsp -->
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
  color:var(--text); line-height:1.6; animation:fadeIn 0.5s ease;
}
/* NAVBAR */
.navbar {
  position:fixed; top:0; left:0; right:0; z-index:100;
  backdrop-filter:blur(18px); background:rgba(255,255,255,0.7);
  box-shadow:0 4px 20px rgba(0,0,0,0.08);
  padding:16px 5%; display:flex; justify-content:space-between; align-items:center;
}
.logo { font-family:'Cormorant Garamond',serif; font-size:1.7rem; font-weight:700; color:var(--navy); }
.logo span { color:var(--gold); }
.nav-links { display:flex; gap:22px; align-items:center; list-style:none; }
.nav-link { font-size:0.88rem; font-weight:500; color:var(--text); transition:color 0.2s; }
.nav-link:hover { color:var(--gold); }
.btn-logout {
  padding:8px 18px; border-radius:999px;
  background:linear-gradient(135deg,var(--gold),var(--gold-dark));
  color:white !important; font-weight:600; font-size:0.82rem; transition:0.25s;
}
.btn-logout:hover { transform:translateY(-2px); box-shadow:0 8px 18px rgba(184,150,78,0.3); }
/* LAYOUT */
.main-container { padding-top:80px; }
.dashboard-container { width:min(1200px,92%); margin:0 auto; padding:40px 0 60px; }
/* WELCOME */
.welcome-section {
  text-align:center; padding:60px 20px 50px; animation:fadeUp 0.7s ease;
}
.welcome-eyebrow {
  font-size:0.78rem; color:var(--muted); letter-spacing:0.14em;
  text-transform:uppercase; margin-bottom:10px;
}
.welcome-title {
  font-family:'Cormorant Garamond',serif;
  font-size:3rem; color:var(--navy); font-weight:700; margin-bottom:10px;
}
.welcome-subtitle { color:var(--muted); font-size:1rem; margin-bottom:26px; }
/* DASHBOARD LAYOUT */
.dashboard-layout {
  display:grid; grid-template-columns:1fr 320px; gap:28px; align-items:start;
}
/* SECTION LABEL */
.section-label {
  font-size:0.75rem; font-weight:600; color:var(--muted);
  letter-spacing:0.12em; text-transform:uppercase; margin-bottom:14px;
}
/* VIBE GRID */
.vibe-grid { display:grid; grid-template-columns:1fr 1fr; gap:14px; }
.vibe-card {
  position:relative; height:200px; border-radius:18px;
  background-size:cover; background-position:center;
  cursor:pointer; overflow:hidden;
  box-shadow:0 8px 24px rgba(0,0,0,0.14);
  transition:transform 0.35s ease, box-shadow 0.35s ease;
}
.vibe-card:hover { transform:translateY(-5px); box-shadow:0 18px 36px rgba(0,0,0,0.2); }
.vibe-card .overlay {
  position:absolute; inset:0;
  background:linear-gradient(to top,rgba(0,0,0,0.65),transparent);
  display:flex; flex-direction:column; justify-content:flex-end;
  padding:18px; color:white; opacity:0; transition:opacity 0.3s;
}
.vibe-card:hover .overlay { opacity:1; }
.vibe-card .overlay h3 { font-family:'Cormorant Garamond',serif; font-size:1.3rem; }
.vibe-card .overlay p { font-size:0.8rem; opacity:0.85; }
.vibe-badge {
  position:absolute; top:12px; left:12px;
  background:rgba(255,255,255,0.88); color:var(--navy);
  padding:4px 12px; border-radius:999px; font-size:0.75rem; font-weight:600;
}
/* SIDEBAR */
.glass-card {
  background:rgba(255,255,255,0.72); backdrop-filter:blur(18px);
  border-radius:var(--radius); border:1px solid rgba(255,255,255,0.45);
  box-shadow:var(--shadow);
}
.sidebar-card { padding:22px; }
.recommendation-item { display:flex; gap:14px; align-items:center; padding:12px 0; }
.perfume-img { width:56px; height:56px; border-radius:12px; object-fit:cover; }
.rec-info h4 { font-size:0.95rem; font-weight:600; color:var(--navy); margin-bottom:2px; }
.rec-info p { font-size:0.78rem; color:var(--muted); }
.match-pill {
  display:inline-block; margin-top:4px;
  font-size:0.72rem; font-weight:600;
  background:rgba(184,150,78,0.12); color:var(--gold-dark);
  padding:3px 10px; border-radius:999px;
}
.rec-divider { height:1px; background:rgba(0,0,0,0.06); margin:0; }
/* BUTTONS */
.btn-primary {
  display:inline-block; padding:12px 24px; border-radius:999px; border:none;
  background:linear-gradient(135deg,var(--gold),var(--gold-dark));
  color:white; font-family:'DM Sans',sans-serif; font-weight:600;
  font-size:0.9rem; cursor:pointer; transition:0.3s ease; text-align:center;
}
.btn-primary:hover { transform:translateY(-3px); box-shadow:0 12px 25px rgba(184,150,78,0.3); }
@keyframes fadeIn { from{opacity:0;transform:translateY(10px)} to{opacity:1;transform:translateY(0)} }
@keyframes fadeUp { from{opacity:0;transform:translateY(22px)} to{opacity:1;transform:translateY(0)} }
@media(max-width:900px){
  .dashboard-layout{ grid-template-columns:1fr; }
  .vibe-grid{ grid-template-columns:1fr 1fr; }
  .welcome-title{ font-size:2.2rem; }
}
@media(max-width:540px){
  .vibe-grid{ grid-template-columns:1fr; }
  .navbar{ padding:14px 4%; }
}
</style>
</head>
<body>

<!-- ROLE-BASED NAVBAR -->
<nav class="navbar">
  <a href="<%= contextPath %>/home" class="logo">Scent<span>ia</span></a>
  <div class="nav-links">
    <% if ("admin".equals(role)) { %>
      <a href="<%= contextPath %>/admin"          class="nav-link">Dashboard</a>
      <a href="<%= contextPath %>/admin/perfumes" class="nav-link">Manage Perfumes</a>
      <a href="<%= contextPath %>/admin/users"    class="nav-link">Manage Users</a>
    <% } else { %>
      <a href="<%= contextPath %>/home"    class="nav-link">Home</a>
      <a href="<%= contextPath %>/perfume" class="nav-link">Browse</a>
      <a href="<%= contextPath %>/cart"    class="nav-link">Cart</a>
      <a href="<%= contextPath %>/profile" class="nav-link">Profile</a>
    <% } %>
    <a href="<%= contextPath %>/logout" class="nav-link btn-logout">Logout</a>
  </div>
</nav>

<main class="main-container">
<div class="dashboard-container">

  <!-- WELCOME HEADER -->
  <header class="welcome-section">
    <p class="welcome-eyebrow">Welcome Back</p>
    <h1 class="welcome-title">Hello, <%= firstName %></h1>
    <p class="welcome-subtitle">Discover your signature scent today.</p>
    <a href="<%= contextPath %>/perfume" class="btn-primary">Explore Perfumes</a>
  </header>

  <div class="dashboard-layout">

    <!-- VIBE CARDS -->
    <div>
      <p class="section-label">Browse by Vibe</p>
      <div class="vibe-grid">

        <div class="vibe-card"
             onclick="location.href='<%= contextPath %>/perfume?vibe=Soft'"
             style="background-image:url('https://i.pinimg.com/736x/64/56/e1/6456e1536d6b1ee2006f52f220d0ff70.jpg');">
          <span class="vibe-badge">Soft</span>
          <div class="overlay"><h3>Soft</h3><p>Rose · Powder · Floral</p></div>
        </div>

        <div class="vibe-card"
             onclick="location.href='<%= contextPath %>/perfume?vibe=Bold'"
             style="background-image:url('https://i.pinimg.com/736x/de/df/41/dedf411d00b07d9221f5056d4beaeea3.jpg');">
          <span class="vibe-badge">Bold</span>
          <div class="overlay"><h3>Bold</h3><p>Oud · Amber · Spice</p></div>
        </div>

        <div class="vibe-card"
             onclick="location.href='<%= contextPath %>/perfume?vibe=Sweet'"
             style="background-image:url('https://i.pinimg.com/1200x/aa/0b/7e/aa0b7ef85f8b85ec453ed74dcbb69734.jpg');">
          <span class="vibe-badge">Sweet</span>
          <div class="overlay"><h3>Sweet</h3><p>Vanilla · Caramel · Fruity</p></div>
        </div>

        <div class="vibe-card"
             onclick="location.href='<%= contextPath %>/perfume?vibe=Fresh'"
             style="background-image:url('https://i.pinimg.com/736x/a8/1b/ea/a81bea9a7fe9e682e6ba9a93686d4542.jpg');">
          <span class="vibe-badge">Fresh</span>
          <div class="overlay"><h3>Fresh</h3><p>Citrus · Green · Aqua</p></div>
        </div>

      </div>
    </div>

    <!-- SIDEBAR: top matches -->
    <aside>
      <div class="glass-card sidebar-card">
        <p class="section-label">Top Matches For You</p>

        <div class="recommendation-item">
          <img src="https://i.pinimg.com/1200x/54/64/7a/54647a18714b6b5a47288333a21bceda.jpg" class="perfume-img" alt="Velvet Rose">
          <div class="rec-info">
            <h4>Velvet Rose</h4>
            <p>Rose · Musk · Patchouli</p>
            <span class="match-pill">✦ 97% match</span>
          </div>
        </div>

        <div class="rec-divider"></div>

        <div class="recommendation-item">
          <img src="https://i.pinimg.com/1200x/5a/ca/8c/5aca8c9bce085ff6fae40cfa82d83bd3.jpg" class="perfume-img" alt="Golden Oud">
          <div class="rec-info">
            <h4>Golden Oud</h4>
            <p>Oud · Amber · Sandalwood</p>
            <span class="match-pill">✦ 91% match</span>
          </div>
        </div>

        <div class="rec-divider"></div>

        <div class="recommendation-item">
          <img src="https://i.pinimg.com/736x/ac/cf/2a/accf2a69cfa62e7d7b5d8bb61ff89fef.jpg" class="perfume-img" alt="Amber Noir">
          <div class="rec-info">
            <h4>Amber Noir</h4>
            <p>Amber · Vanilla · Spice</p>
            <span class="match-pill">✦ 88% match</span>
          </div>
        </div>

        <div class="rec-divider"></div>
        <a href="<%= contextPath %>/perfume" class="btn-primary" style="width:100%;text-align:center;">Browse All</a>
      </div>
    </aside>

  </div>
</div>
</main>
</body>
</html>
