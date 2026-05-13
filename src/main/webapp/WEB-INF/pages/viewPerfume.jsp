<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.scentia.model.Perfume" %>
<%@ page import="com.scentia.model.User" %>

<%
String contextPath = request.getContextPath();
User user = (User) session.getAttribute("user");

if (user == null) {
    response.sendRedirect(contextPath + "/login");
    return;
}

String role = user.getRole();
List<Perfume> perfumes = (List<Perfume>) request.getAttribute("perfumes");
String search = request.getParameter("search");
if (search == null) search = "";
String currentVibe = request.getParameter("vibe");
if (currentVibe == null) currentVibe = "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Browse Perfumes | Scentia</title>
  <!-- viewPerfume.jsp -->
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
.nav-links { display:flex; gap:22px; align-items:center; }
.nav-link { font-size:0.88rem; font-weight:500; color:var(--text); transition:color 0.2s; }
.nav-link:hover { color:var(--gold); }
.btn-logout {
  padding:8px 18px; border-radius:999px;
  background:linear-gradient(135deg,var(--gold),var(--gold-dark));
  color:white !important; font-weight:600; font-size:0.82rem;
}
.btn-logout:hover { transform:translateY(-2px); box-shadow:0 8px 18px rgba(184,150,78,0.3); }
/* PAGE SHELL */
.page-shell { width:min(1200px,92%); margin:100px auto 60px; }
/* HERO */
.page-hero { text-align:center; padding:40px 20px 32px; }
.page-kicker {
  font-size:0.78rem; color:var(--muted); letter-spacing:0.14em;
  text-transform:uppercase; margin-bottom:10px;
}
.page-title {
  font-family:'Cormorant Garamond',serif;
  font-size:2.4rem; color:var(--navy); font-weight:700; margin-bottom:10px;
}
.page-copy { color:var(--muted); font-size:0.95rem; max-width:600px; margin:0 auto; }
/* SEARCH PANEL */
.glass-card {
  background:rgba(255,255,255,0.72); backdrop-filter:blur(18px);
  border-radius:var(--radius); border:1px solid rgba(255,255,255,0.45); box-shadow:var(--shadow);
}
.search-panel {
  display:flex; gap:12px; padding:14px 18px; margin-bottom:20px; align-items:center;
}
.search-input {
  flex:1; padding:11px 14px; border-radius:12px;
  border:1px solid rgba(0,0,0,0.12); background:rgba(255,255,255,0.85);
  font-size:0.9rem; font-family:'DM Sans',sans-serif; outline:none; transition:0.25s;
}
.search-input:focus { border-color:var(--gold); box-shadow:0 0 0 4px rgba(184,150,78,0.15); }
/* VIBE FILTERS */
.vibe-filters { display:flex; gap:10px; margin-bottom:28px; flex-wrap:wrap; }
.vibe-btn {
  padding:8px 18px; border-radius:999px; font-size:0.82rem; font-weight:500;
  background:rgba(255,255,255,0.7); border:1px solid rgba(0,0,0,0.1);
  color:var(--text); transition:0.25s ease; backdrop-filter:blur(10px);
}
.vibe-btn:hover, .vibe-btn.active {
  background:linear-gradient(135deg,var(--gold),var(--gold-dark));
  color:white; border-color:transparent;
  box-shadow:0 6px 16px rgba(184,150,78,0.25);
}
/* PERFUME GRID */
.perfume-grid {
  display:grid; grid-template-columns:repeat(auto-fill,minmax(250px,1fr)); gap:22px;
}
.perfume-card { border-radius:18px; overflow:hidden; transition:transform 0.35s ease, box-shadow 0.35s ease; }
.perfume-card:hover { transform:translateY(-6px); box-shadow:0 20px 40px rgba(0,0,0,0.13); }
.perfume-image { width:100%; height:220px; object-fit:cover; display:block; }
.perfume-meta { padding:16px 18px; }
.perfume-name { font-family:'Cormorant Garamond',serif; font-size:1.2rem; color:var(--navy); margin-bottom:3px; }
.perfume-brand { font-size:0.82rem; color:var(--muted); margin-bottom:10px; }
.vibe-pill {
  display:inline-block; padding:3px 12px; border-radius:999px;
  font-size:0.72rem; font-weight:600; letter-spacing:0.04em;
  background:rgba(184,150,78,0.12); color:var(--gold-dark);
}
.score-pill {
  display:inline-block; padding:3px 10px; border-radius:999px; margin-top:6px;
  font-size:0.72rem; background:rgba(26,26,46,0.07); color:var(--navy); font-weight:500;
}
.card-actions { display:flex; gap:10px; padding:0 18px 18px; }
/* BUTTONS */
.btn-primary {
  flex:1; text-align:center; padding:10px 16px; border-radius:999px; border:none;
  background:linear-gradient(135deg,var(--gold),var(--gold-dark));
  color:white; font-family:'DM Sans',sans-serif; font-weight:600;
  font-size:0.84rem; cursor:pointer; transition:0.3s ease;
}
.btn-primary:hover { transform:translateY(-2px); box-shadow:0 10px 22px rgba(184,150,78,0.28); }
.btn-secondary {
  flex:1; text-align:center; padding:10px 16px; border-radius:999px;
  background:rgba(0,0,0,0.06); color:var(--text);
  font-weight:500; font-size:0.84rem; transition:0.2s;
}
.btn-secondary:hover { background:rgba(0,0,0,0.12); }
/* EMPTY STATE */
.empty-state { text-align:center; padding:60px 30px; }
.empty-state h2 { font-family:'Cormorant Garamond',serif; font-size:1.8rem; color:var(--navy); margin-bottom:8px; }
.empty-state p { color:var(--muted); }
@keyframes fadeIn { from{opacity:0;transform:translateY(10px)} to{opacity:1;transform:translateY(0)} }
@media(max-width:768px){
  .search-panel{ flex-direction:column; }
  .card-actions{ flex-direction:column; }
  .page-title{ font-size:1.8rem; }
}
</style>
</head>
<body>

<!-- ROLE-BASED NAVBAR -->
<header class="navbar">
  <a class="logo" href="<%= contextPath %>/home">Scent<span>ia</span></a>
  <nav class="nav-links">
    <% if ("admin".equals(role)) { %>
      <a href="<%= contextPath %>/admin"           class="nav-link">Dashboard</a>
      <a href="<%= contextPath %>/admin/perfumes"  class="nav-link">Manage Perfumes</a>
      <a href="<%= contextPath %>/admin/users"     class="nav-link">Manage Users</a>
    <% } else { %>
      <a href="<%= contextPath %>/home"    class="nav-link">Home</a>
      <a href="<%= contextPath %>/perfume" class="nav-link">Browse</a>
      <a href="<%= contextPath %>/cart"    class="nav-link">Cart</a>
      <a href="<%= contextPath %>/profile" class="nav-link">Profile</a>
    <% } %>
    <a href="<%= contextPath %>/logout" class="nav-link btn-logout">Logout</a>
  </nav>
</header>

<main class="page-shell">

  <!-- HERO -->
  <section class="page-hero">
    <p class="page-kicker">Conscious fragrance edit</p>
    <h1 class="page-title">Perfumes with a lighter footprint.</h1>
    <p class="page-copy">Refined scents selected for ingredient quality, responsible sourcing, and sustainability.</p>
  </section>

  <!-- SEARCH -->
  <form class="glass-card search-panel" action="<%= contextPath %>/perfume" method="get">
    <input class="search-input" type="search" name="search"
           value="<%= search %>" placeholder="Search by name, brand, notes, or category…">
    <button class="btn-primary" type="submit">Search</button>
  </form>

  <!-- VIBE FILTERS: ONLY Soft | Bold | Sweet | Fresh -->
  <div class="vibe-filters">
    <a href="<%= contextPath %>/perfume"
       class="vibe-btn vibe-btn-all <%= currentVibe.isEmpty() && search.isEmpty() ? "active" : "" %>">All</a>
    <a href="<%= contextPath %>/perfume?vibe=Soft"
       class="vibe-btn vibe-btn-Soft  <%= "Soft".equals(currentVibe)  ? "active" : "" %>">Soft</a>
    <a href="<%= contextPath %>/perfume?vibe=Bold"
       class="vibe-btn vibe-btn-Bold  <%= "Bold".equals(currentVibe)  ? "active" : "" %>">Bold</a>
    <a href="<%= contextPath %>/perfume?vibe=Sweet"
       class="vibe-btn vibe-btn-Sweet <%= "Sweet".equals(currentVibe) ? "active" : "" %>">Sweet</a>
    <a href="<%= contextPath %>/perfume?vibe=Fresh"
       class="vibe-btn vibe-btn-Fresh <%= "Fresh".equals(currentVibe) ? "active" : "" %>">Fresh</a>
  </div>

  <!-- PERFUME GRID -->
  <section class="perfume-grid">

    <% if (perfumes != null && !perfumes.isEmpty()) {
         for (Perfume p : perfumes) {
           String vibeTag = p.getVibe() != null ? p.getVibe() : "";
    %>
    <article class="glass-card perfume-card">

      <img src="<%= (p.getImageUrl() != null && !p.getImageUrl().isEmpty())
                     ? p.getImageUrl() : contextPath + "/images/default.png" %>"
           alt="<%= p.getName() %>"
           class="perfume-image"
           onerror="this.src='https://picsum.photos/seed/<%= p.getId() %>/400/300';">

      <div class="perfume-meta">
        <h2 class="perfume-name"><%= p.getName() %></h2>
        <p class="perfume-brand"><%= p.getBrand() %></p>
        <% if (!vibeTag.isEmpty()) { %>
          <span class="vibe-pill vibe-<%= vibeTag %>"><%= vibeTag %></span>
        <% } %>
        <br>
        <span class="score-pill">Sustainability: <%= p.getSustainabilityScore() %>/5</span>
      </div>

      <div class="card-actions">
        <a class="btn-secondary" href="<%= contextPath %>/perfume-details?id=<%= p.getId() %>">View Details</a>
        <a class="btn-primary"   href="<%= contextPath %>/cart?action=add&id=<%= p.getId() %>">Add to Cart</a>
      </div>

    </article>
    <%
         }
       } else {
    %>
    <div class="glass-card empty-state">
      <h2>No perfumes found</h2>
      <p>Try a different search keyword or vibe filter.</p>
      <a href="<%= contextPath %>/perfume" class="btn-primary" style="margin-top:1.25rem;">Clear Filters</a>
    </div>
    <% } %>

  </section>

</main>
</body>
</html>
