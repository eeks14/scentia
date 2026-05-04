<%@ page contentType="text/html;charset=UTF-8" %>
<%
String contextPath = request.getContextPath();
String name = (String) request.getAttribute("name");
%>

<html>
<head>
    <title>Order Successful</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>

<body>

<main class="page-shell">

<h1>Order Confirmed 🎉</h1>

<p>Thank you, <%= name %>! Your order has been placed successfully.</p>

<a href="<%= contextPath %>/perfume?view=user">
    Continue Shopping
</a>

</main>

</body>
</html>