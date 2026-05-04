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
  <link rel="stylesheet" href="<%= contextPath %>/css/style.css">
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
