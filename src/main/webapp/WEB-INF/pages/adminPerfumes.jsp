<%@ page import="java.util.ArrayList" %>
<%@ page import="com.scentia.model.Perfume" %>

<%
ArrayList<Perfume> perfumes =
(ArrayList<Perfume>) request.getAttribute("perfumes");

String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Perfumes</title>
     <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>

<body>

<nav class="navbar">
  <a href="<%= contextPath %>/admin" class="logo">Scent<span>ia</span></a>
</nav>

<main class="main-container">

<div class="glass-card full-width">

<h2 class="section-title">Perfume Inventory</h2>

<table>

<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Brand</th>
    <th>Price</th>
    <th>Stock</th>
    <th>Actions</th>
</tr>

<%
for (Perfume perfume : perfumes) {
%>

<tr>
    <td><%= perfume.getId() %></td>
    <td><%= perfume.getName() %></td>
    <td><%= perfume.getBrand() %></td>
    <td>$<%= perfume.getPrice() %></td>
    <td><%= perfume.getStock() %></td>

    <td>

        <a class="btn-edit"
           href="<%= contextPath %>/admin/editPerfume?id=<%= perfume.getId() %>">
           Edit
        </a>

      <a class="btn-danger"
	   	 href="<%= contextPath %>/confirmDelete?id=<%= perfume.getId() %>">
	   	 Delete
	 </a>

    </td>
</tr>

<%
}
%>

</table>

</div>

</main>

</body>
</html>