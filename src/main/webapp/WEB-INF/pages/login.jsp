<%@ page contentType="text/html;charset=UTF-8" %>
<%
String contextPath = request.getContextPath();
String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login | Scentia</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<div class="auth-wrapper">
  <div class="auth-card glass-card">

    <div class="auth-logo">Scent<span>ia</span></div>
    <p class="auth-tagline">Conscious fragrance, curated for you.</p>

    <h2>Welcome Back</h2>

    <% if (error != null) { %>
      <div class="error-box"><%= error %></div>
    <% } %>

    <form action="<%= contextPath %>/login" method="post">
      <div class="form-row">
        <label>Email</label>
        <input class="form-input" type="email" name="email" placeholder="you@example.com" required>
      </div>
      <div class="form-row">
        <label>Password</label>
        <input class="form-input" type="password" name="password" placeholder="••••••••" required>
      </div>
      <button type="submit" class="btn-primary" style="width:100%;margin-top:0.5rem;">Sign In</button>
    </form>

    <p class="auth-switch">
      Don't have an account? <a href="<%= contextPath %>/register">Register</a>
    </p>

  </div>
</div>
</body>
</html>
