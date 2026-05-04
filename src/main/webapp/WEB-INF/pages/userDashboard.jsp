<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.scentia.model.User" %>

<%
String contextPath = request.getContextPath();
User user = (User) session.getAttribute("user");

if (user == null) {
    response.sendRedirect(contextPath + "/login");
    return;
}

// Admins have no profile page — send to dashboard
if ("admin".equals(user.getRole())) {
    response.sendRedirect(contextPath + "/admin");
    return;
}

String msg   = request.getParameter("msg");
String error = (String) request.getAttribute("error");
String initial = (user.getName() != null && !user.getName().isEmpty())
    ? user.getName().substring(0, 1).toUpperCase() : "U";
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Profile | Scentia</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<!-- USER NAVBAR -->
<nav class="navbar">
  <a href="<%= contextPath %>/home" class="logo">Scent<span>ia</span></a>
  <div class="nav-links">
    <a href="<%= contextPath %>/home"    class="nav-link">Home</a>
    <a href="<%= contextPath %>/perfume" class="nav-link">Browse</a>
    <a href="<%= contextPath %>/cart"    class="nav-link">Cart</a>
    <a href="<%= contextPath %>/profile" class="nav-link">Profile</a>
    <a href="<%= contextPath %>/logout"  class="nav-link btn-logout">Logout</a>
  </div>
</nav>

<div class="main-container">
<div class="profile-wrapper">
  <div class="profile-card">

    <div class="avatar"><%= initial %></div>
    <h1><%= user.getName() != null ? user.getName() : "User" %></h1>
    <p class="email-display"><%= user.getEmail() %></p>

    <% if ("updated".equals(msg)) { %>
      <div class="toast-msg"> Profile updated successfully.</div>
    <% } %>
    <% if (error != null) { %>
      <div class="error-msg">❌ <%= error %></div>
    <% } %>

    <hr class="divider">

    <form action="<%= contextPath %>/profile" method="post">

      <div class="form-row">
        <label>Name *</label>
        <input type="text" name="name"
               value="<%= user.getName() != null ? user.getName() : "" %>" required>
      </div>

      <div class="form-row">
        <label>Email *</label>
        <input type="email" name="email"
               value="<%= user.getEmail() != null ? user.getEmail() : "" %>" required>
      </div>

      <div class="form-row">
        <label>New Password</label>
        <input type="password" name="password" placeholder="Leave blank to keep current">
        <small>Minimum 6 characters</small>
      </div>

      <button type="submit" class="btn-submit">Save Changes</button>
    </form>

  </div>
</div>
</div>
</body>
</html>
