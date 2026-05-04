<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scentia | About</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/style.css">
</head>

<body>

<nav class="navbar">
  <a href="<%= contextPath %>/home" class="logo">Scent<span>ia</span></a>
  <div class="nav-links">
    <a href="<%= contextPath %>/home" class="nav-link">Home</a>
    <a href="<%= contextPath %>/perfume?view=user" class="nav-link">Perfume</a>
    <a href="<%= contextPath %>/about" class="nav-link">About</a>
    <a href="<%= contextPath %>/contact" class="nav-link">Contact</a>
    <a href="<%= contextPath %>/cart" class="nav-link">Cart</a>
  </div>
</nav>

<div class="main-container">
<main class="page-shell">

<section class="about-hero">
    <div class="glass-card hero-copy">
        <p class="page-kicker">About Scentia</p>
        <h1 class="page-title">Luxury fragrance, chosen with conscience.</h1>
        <p class="page-copy">
            Scentia is a curated perfume destination focused on elegance,
            sustainability, and meaningful fragrance discovery.
        </p>
    </div>

    <div class="glass-card hero-art"></div>
</section>

<section class="feature-grid">
    <div class="glass-card feature-card">
        <h2>Responsible Curation</h2>
        <p>We carefully select fragrances with sustainability in mind.</p>
    </div>

    <div class="glass-card feature-card">
        <h2>Ethical Focus</h2>
        <p>We highlight brands with responsible sourcing and production.</p>
    </div>

    <div class="glass-card feature-card">
        <h2>Soft Luxury</h2>
        <p>A calm and elegant shopping experience for fragrance lovers.</p>
    </div>
</section>

</main>
</div>

</body>
</html>