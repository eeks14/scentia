<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
  String fullName = (String) session.getAttribute("userName");

  if (fullName == null || fullName.trim().isEmpty()) {
      fullName = "Guest";
  }

  String firstName = fullName.split(" ")[0];
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard | Scentia</title>
  <link rel="stylesheet" href="css/style.css">
</head>

<body>

<nav class="navbar">
  <a href="home" class="logo">Scent<span>ia</span></a>
  <div class="nav-links">
    <a href="admin" class="nav-link">Admin</a>
    <a href="login" class="nav-link btn-logout">Logout</a>
  </div>
</nav>

<main class="main-container">

<div class="dashboard-container">

  <!-- HEADER -->
  <header class="welcome-section">
    <p class="welcome-eyebrow">Your Profile</p>
    <h1 class="welcome-title">Hello, <%= firstName %></h1>
    <p class="welcome-subtitle">Discover your signature scent today</p>
  </header>

  <div class="dashboard-layout">

    <!-- VIBES -->
    <div>
      <p class="section-label">Browse by Vibe</p>

      <div class="vibe-grid">

        <div class="vibe-card" style="background-image:url('https://i.pinimg.com/736x/64/56/e1/6456e1536d6b1ee2006f52f220d0ff70.jpg');">
          <span class="vibe-badge">Soft</span>
          <div class="overlay">
            <h3>Soft</h3>
            <p>Rose • Powder • Floral</p>
          </div>
        </div>

        <div class="vibe-card" style="background-image:url('https://i.pinimg.com/736x/de/df/41/dedf411d00b07d9221f5056d4beaeea3.jpg');">
          <span class="vibe-badge">Bold</span>
          <div class="overlay">
            <h3>Bold</h3>
            <p>Oud • Amber • Spice</p>
          </div>
        </div>

        <div class="vibe-card" style="background-image:url('https://i.pinimg.com/1200x/aa/0b/7e/aa0b7ef85f8b85ec453ed74dcbb69734.jpg');">
          <span class="vibe-badge">Sweet</span>
          <div class="overlay">
            <h3>Sweet</h3>
            <p>Vanilla • Caramel • Fruity</p>
          </div>
        </div>

        <div class="vibe-card" style="background-image:url('https://i.pinimg.com/736x/a8/1b/ea/a81bea9a7fe9e682e6ba9a93686d4542.jpg');">
          <span class="vibe-badge">Fresh</span>
          <div class="overlay">
            <h3>Fresh</h3>
            <p>Citrus • Green • Aqua</p>
          </div>
        </div>

      </div>
    </div>

    <!-- SIDEBAR -->
    <aside class="sidebar">

      <div class="glass-card sidebar-card">

        <p class="section-label">Top Matches For You</p>

        <!-- ITEM 1 -->
        <div class="recommendation-item">
          <img src="https://i.pinimg.com/1200x/54/64/7a/54647a18714b6b5a47288333a21bceda.jpg" class="perfume-img">
          <div class="rec-info">
            <h4>Velvet Rose</h4>
            <p>Rose • Musk • Patchouli</p>
            <span class="match-pill">✦ 97% match</span>
          </div>
        </div>

        <div class="rec-divider"></div>

        <!-- ITEM 2 -->
        <div class="recommendation-item">
          <img src="https://i.pinimg.com/1200x/5a/ca/8c/5aca8c9bce085ff6fae40cfa82d83bd3.jpg" class="perfume-img">
          <div class="rec-info">
            <h4>Golden Oud</h4>
            <p>Oud • Amber • Sandalwood</p>
            <span class="match-pill">✦ 91% match</span>
          </div>
        </div>

        <div class="rec-divider"></div>

        <!-- ITEM 3 (ADDED MISSING VISUAL BALANCE) -->
        <div class="recommendation-item">
          <img src="https://i.pinimg.com/736x/ac/cf/2a/accf2a69cfa62e7d7b5d8bb61ff89fef.jpg" class="perfume-img">
          <div class="rec-info">
            <h4>Amber Noir</h4>
            <p>Amber • Vanilla • Spice</p>
            <span class="match-pill">✦ 88% match</span>
          </div>
        </div>

        <div class="rec-divider"></div>

        <button class="btn-primary">Refine My Match</button>

      </div>

    </aside>

  </div>

</div>

</main>

</body>
</html>