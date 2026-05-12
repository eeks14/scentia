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
 <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
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
