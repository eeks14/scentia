<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Panel | Scentia</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar">
  <a href="home" class="logo">Scent<span>ia</span></a>
  <div class="nav-links">
    <a href="home"  class="nav-link">User View</a>
    <a href="login" class="nav-link btn-logout">Logout</a>
  </div>
</nav>

<main class="main-container">
<div class="dashboard-container">

  <!-- HEADER -->
  <header class="welcome-section">
    <p class="welcome-eyebrow">Control Panel</p>
    <h1 class="welcome-title">Admin Dashboard</h1>
    <p class="welcome-subtitle">Manage your fragrance system effortlessly</p>
  </header>

  <!-- ACTION CARDS -->
  <div class="admin-grid">

    <div class="admin-card" onclick="location.href='addPerfume'">
      <div class="admin-icon-box bg-soft-pink">✨</div>
      <div class="admin-info">
        <h3>Add Perfume</h3>
        <p>Register new fragrances to the catalog.</p>
      </div>
    </div>

    <div class="admin-card" onclick="location.href='manageUsers'">
      <div class="admin-icon-box bg-soft-mint">👥</div>
      <div class="admin-info">
        <h3>Manage Users</h3>
        <p>Edit users and control access levels.</p>
      </div>
    </div>

    <div class="admin-card" onclick="location.href='analytics'">
      <div class="admin-icon-box bg-soft-cream">📊</div>
      <div class="admin-info">
        <h3>Analytics</h3>
        <p>View trends and popular perfumes.</p>
      </div>
    </div>

    <div class="admin-card" onclick="location.href='settings'">
      <div class="admin-icon-box bg-soft-gray">⚙️</div>
      <div class="admin-info">
        <h3>Settings</h3>
        <p>Customize system preferences.</p>
      </div>
    </div>

  </div>

  <!-- RECENT ACTIVITY -->
  <section class="activity-section">
    <div class="glass-card full-width">

      <h2 class="section-title">Recent Activity</h2>

      <table>
        <thead>
          <tr>
            <th>User</th>
            <th>Action</th>
            <th>Status</th>
            <th>Time</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Aasuka Pun</td>
            <td>Matched with 'Velvet Rose'</td>
            <td><span class="status-badge status-match">Match</span></td>
            <td class="time">2 mins ago</td>
          </tr>
          <tr>
            <td>Chomolung Rai</td>
            <td>Updated Profile</td>
            <td><span class="status-badge status-update">Update</span></td>
            <td class="time">15 mins ago</td>
          </tr>
          <tr>
            <td>Stuti Upadhaya</td>
            <td>New Registration</td>
            <td><span class="status-badge status-register">New</span></td>
            <td class="time">1 hour ago</td>
          </tr>
        </tbody>
      </table>

    </div>
  </section>

</div>
</main>

</body>
</html>
