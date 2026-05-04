<%@ page contentType="text/html;charset=UTF-8" %>
<%
String contextPath = request.getContextPath();
String error = (String) request.getAttribute("error");
%>

<html>
<head>
    <title>Checkout | Scentia</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>

<body>

<header class="navbar">
    <a href="<%= contextPath %>/home">Scentia</a>
</header>

<main class="page-shell">

<h1>Checkout</h1>

<% if (error != null) { %>
    <p style="color:red;"><%= error %></p>
<% } %>

<form action="<%= contextPath %>/checkout" method="post">

    <label>Full Name</label><br>
    <input name="name" required><br><br>

    <label>Address</label><br>
    <input name="address" required><br><br>

    <label>Phone</label><br>
    <input name="phone" required><br><br>

    <button type="submit">Place Order</button>

</form>

</main>

</body>
</html>