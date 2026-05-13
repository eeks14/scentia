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
    <!-- about.jsp -->
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
.main-container { padding-top:80px; }
.page-shell { width:min(1100px,92%); margin:0 auto; padding:50px 0 60px; }
.glass-card {
  background:rgba(255,255,255,0.72); backdrop-filter:blur(18px);
  border-radius:var(--radius); border:1px solid rgba(255,255,255,0.45); box-shadow:var(--shadow);
}
/* ABOUT HERO */
.about-hero {
  display:grid; grid-template-columns:1fr 1fr; gap:24px;
  margin-bottom:32px; align-items:stretch;
}
.hero-copy { padding:40px 36px; }
.page-kicker {
  font-size:0.75rem; color:var(--muted); letter-spacing:0.14em;
  text-transform:uppercase; margin-bottom:12px;
}
.page-title {
  font-family:'Cormorant Garamond',serif;
  font-size:2.2rem; color:var(--navy); font-weight:700; margin-bottom:14px;
}
.page-copy { color:var(--muted); font-size:0.95rem; line-height:1.7; }
.hero-art {
  min-height:260px; border-radius:var(--radius);
  background:linear-gradient(135deg,rgba(184,150,78,0.18),rgba(26,26,46,0.08));
}
/* FEATURE GRID */
.feature-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:20px; }
.feature-card { padding:30px 26px; }
.feature-card h2 {
  font-family:'Cormorant Garamond',serif;
  font-size:1.35rem; color:var(--navy); margin-bottom:10px;
}
.feature-card p { color:var(--muted); font-size:0.9rem; line-height:1.65; }
@keyframes fadeIn { from{opacity:0;transform:translateY(10px)} to{opacity:1;transform:translateY(0)} }
@media(max-width:768px){
  .about-hero{ grid-template-columns:1fr; }
  .feature-grid{ grid-template-columns:1fr; }
  .hero-art{ min-height:160px; }
}
</style>
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