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
    <title>Checkout | Scentia</title>
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

<!-- ✅ FIXED LAYOUT (prevents overlap) -->
<div class="main-container">
<main class="page-shell">

<div class="form-wrapper">
  <div class="form-card">

    <h1>Checkout</h1>

    <% if (error != null) { %>
        <div class="error-box"><%= error %></div>
    <% } %>

    <form action="<%= contextPath %>/checkout" method="post">

        <div class="form-row">
            <label>Full Name</label>
            <input type="text" name="name" required>
        </div>

        <div class="form-row">
            <label>Address</label>
            <input type="text" name="address" required>
        </div>

        <div class="form-row">
            <label>Phone</label>
            <input type="text" name="phone" required>
        </div>

        <button type="submit" class="btn-submit">Place Order</button>

    </form>

  </div>
</div>

</main>
</div>

</body>
</html>