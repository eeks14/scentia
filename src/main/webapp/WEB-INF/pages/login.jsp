<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login | Scentia</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar">
  <a href="home" class="logo">Scent<span>ia</span></a>
</nav>

<main class="main-container">
  <div class="glass-card form-card">

    <p class="form-eyebrow">Welcome back</p>
    <h1 class="form-title">Sign In</h1>
    <p class="form-subtitle">Your scent profile awaits</p>

    <form action="login" method="post">

      <% String error = (String) request.getAttribute("error"); %>
      <% if (error != null) { %>
        <div class="error-box"><%= error %></div>
      <% } %>

      <div class="form-group">
        <input type="email"    name="email"    class="form-input" placeholder="Email Address" required>
      </div>
      <div class="form-group">
        <input type="password" name="password" class="form-input" placeholder="Password"      required>
      </div>

      <button type="submit" class="btn-primary">Sign In</button>
    </form>

    <p class="form-footer">New to Scentia? <a href="register">Create an account</a></p>

  </div>
</main>

</body>
</html>
