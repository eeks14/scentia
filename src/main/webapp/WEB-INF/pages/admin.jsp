<%@ page contentType="text/html;charset=UTF-8" %>

<%
String contextPath = request.getContextPath();
String msg = request.getParameter("msg");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Panel | Scentia</title>

  <link rel="stylesheet" href="<%= contextPath %>/css/style.css">
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar">
  <a href="<%= contextPath %>/home" class="logo">
    Scent<span>ia</span>
  </a>

  <div class="nav-links">
    <a href="<%= contextPath %>/home" class="nav-link">User View</a>
    <a href="<%= contextPath %>/logout" class="nav-link">Logout</a>
  </div>
</nav>

<!-- MAIN -->
<main class="main-container">

<div class="dashboard-container">

  <!-- HEADER -->
  <header class="welcome-section">
    <p class="welcome-eyebrow">Control Panel</p>
    <h1 class="welcome-title">Admin Dashboard</h1>
    <p class="welcome-subtitle">
      Manage your fragrance system effortlessly
    </p>
  </header>

<% if (msg != null) { %>
  <div class="toast">
    <%= msg %>
  </div>
<% } %>

<!-- ACTION CARDS -->
<div class="admin-grid">

  <!-- MANAGE PERFUMES (FIXED LINK ONLY) -->
  <div class="admin-card"
       onclick="location.href='<%= contextPath %>/admin/perfumes'">
    <div class="admin-icon-box bg-soft-pink">✨</div>
    <div class="admin-info">
      <h3>Manage Perfumes</h3>
      <p>View, edit, and delete perfumes</p>
    </div>
  </div>

  <!-- USERS -->
  <div class="admin-card"
       onclick="location.href='<%= contextPath %>/manageUsers'">
    <div class="admin-icon-box bg-soft-mint">👥</div>
    <div class="admin-info">
      <h3>Manage Users</h3>
      <p>Edit users and control access levels</p>
    </div>
  </div>

  <!-- ANALYTICS -->
  <div class="admin-card"
       onclick="location.href='<%= contextPath %>/analytics'">
    <div class="admin-icon-box bg-soft-cream">📊</div>
    <div class="admin-info">
      <h3>Analytics</h3>
      <p>View trends and insights</p>
    </div>
  </div>

  <!-- SETTINGS -->
  <div class="admin-card"
       onclick="location.href='<%= contextPath %>/settings'">
    <div class="admin-icon-box bg-soft-gray">⚙️</div>
    <div class="admin-info">
      <h3>Settings</h3>
      <p>System configuration</p>
    </div>
  </div>

</div>

<!-- 💎 RECENT ACTIVITY (RESTORED EXACTLY) -->
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
          <td>2 mins ago</td>
        </tr>

        <tr>
          <td>Chomolung Rai</td>
          <td>Updated Profile</td>
          <td><span class="status-badge status-update">Update</span></td>
          <td>15 mins ago</td>
        </tr>

        <tr>
          <td>Stuti Upadhaya</td>
          <td>New Registration</td>
          <td><span class="status-badge status-register">New</span></td>
          <td>1 hour ago</td>
        </tr>

      </tbody>

    </table>

  </div>

</section>

</div>

</main>

</body>
</html>