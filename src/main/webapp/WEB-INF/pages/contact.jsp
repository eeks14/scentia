<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scentia | Contact</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/style.css">
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

<div class="glass-card form-card">

    <h1>Contact Us</h1>

    <form>
        <div class="form-row">
            <label>Name</label>
            <input type="text" required>
        </div>

        <div class="form-row">
            <label>Email</label>
            <input type="email" required>
        </div>

        <div class="form-row">
            <label>Message</label>
            <textarea required></textarea>
        </div>

        <button class="btn-submit">Send Message</button>
    </form>

</div>

</main>
</div>

</body>
</html>