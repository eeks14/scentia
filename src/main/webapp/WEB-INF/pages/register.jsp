<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Register | Scentia</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar">
  <a href="home" class="logo">Scent<span>ia</span></a>
</nav>

<main class="main-container">
  <div class="glass-card form-card">

    <p class="form-eyebrow">Join Scentia</p>
    <h1 class="form-title">Create Account</h1>
    <p class="form-subtitle">Begin your fragrance journey</p>

    <form action="register" method="post">

      <% String error = (String) request.getAttribute("error"); %>
      <% if (error != null) { %>
        <div class="error-box"><%= error %></div>
      <% } %>

      <div class="form-group">
        <input type="text"     name="name"            class="form-input" placeholder="Full Name"       required>
      </div>
      <div class="form-group">
        <input type="email"    name="email"           class="form-input" placeholder="Email Address"   required>
      </div>
      <div class="form-group">
        <input type="password" name="password"        class="form-input" placeholder="Password"        required>
      </div>
      <div class="form-group">
        <input type="password" name="confirmPassword" class="form-input" placeholder="Confirm Password" required>
      </div>

      <input type="hidden" name="role" value="user">

      <button type="submit" class="btn-primary">Create Account</button>
    </form>

    <p class="form-footer">Already have an account? <a href="login">Sign in</a></p>

  </div>
</main>

</body>
</html>
