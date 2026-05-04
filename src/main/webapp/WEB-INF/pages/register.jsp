<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Register | Scentia</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<nav class="navbar">
  <a href="<%= request.getContextPath() %>/home" class="logo">Scent<span>ia</span></a>
</nav>

<div class="auth-wrapper">
  <div class="auth-card">

    <div class="auth-logo">Scent<span>ia</span></div>
    <p class="auth-tagline">Begin your fragrance journey</p>

    <h2>Create Account</h2>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
      <div class="error-box"><%= error %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/register" method="post">

      <div class="form-row">
        <label>Name</label>
        <input type="text" name="name" required>
      </div>

      <div class="form-row">
        <label>Email</label>
        <input type="email" name="email" required>
      </div>

      <div class="form-row">
        <label>Password</label>
        <input type="password" name="password" required>
      </div>

      <div class="form-row">
        <label>Confirm Password</label>
        <input type="password" name="confirmPassword" required>
      </div>

      <input type="hidden" name="role" value="user">

      <button type="submit" class="btn-submit">Create Account</button>

    </form>

    <div class="auth-switch">
      Already have an account?
      <a href="<%= request.getContextPath() %>/login">Sign in</a>
    </div>

  </div>
</div>

</body>
</html>
