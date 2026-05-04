<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.scentia.model.User" %>

<%
String contextPath = request.getContextPath();
User user = (User) session.getAttribute("user");

if (user == null) {
    response.sendRedirect(contextPath + "/login");
    return;
}
if (!"admin".equals(user.getRole())) {
    response.sendRedirect(contextPath + "/home");
    return;
}

String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Perfume | Scentia</title>
  <link rel="stylesheet" href="<%= contextPath %>/css/style.css">
</head>
<body>

<nav class="admin-navbar">
  <a href="<%= contextPath %>/admin" class="logo">Scent<span>ia</span></a>
  <div class="admin-nav-links">
    <a href="<%= contextPath %>/admin">Dashboard</a>
    <a href="<%= contextPath %>/admin/perfumes">Manage Perfumes</a>
    <a href="<%= contextPath %>/admin/users">Manage Users</a>
    <a href="<%= contextPath %>/logout" class="btn-logout">Logout</a>
  </div>
</nav>

<div class="form-wrapper">
  <div class="form-card">

    <h1>Add New Perfume</h1>

    <% if (error != null) { %>
      <div class="error-msg">❌ <%= error %></div>
    <% } %>

    <form action="<%= contextPath %>/admin/addPerfume" method="post">

      <div class="form-row">
        <label>Perfume Name *</label>
        <input type="text" name="name" placeholder="e.g. Velvet Rose" required>
      </div>

      <div class="form-row">
        <label>Brand *</label>
        <input type="text" name="brand" placeholder="e.g. Maison Margiela" required>
      </div>

      <div class="form-row">
        <label>Category</label>
        <input type="text" name="category" placeholder="e.g. Eau de Parfum">
      </div>

      <div class="form-row">
        <label>Notes</label>
        <input type="text" name="notes" placeholder="e.g. Rose, Musk, Patchouli">
      </div>

      <div class="form-grid">
        <div class="form-row">
          <label>Price ($) *</label>
          <input type="number" name="price" step="0.01" min="0" placeholder="0.00" required>
        </div>
        <div class="form-row">
          <label>Stock *</label>
          <input type="number" name="stock" min="0" placeholder="0" required>
        </div>
      </div>

      <div class="form-grid">
        <div class="form-row">
          <label>Sustainability Score (1–5)</label>
          <input type="number" name="sustainability_score" min="1" max="5" value="5">
        </div>
        <div class="form-row">
          <label>Vibe *</label>
          <select name="vibe" required>
            <option value="">-- Select Vibe --</option>
            <option value="Soft">Soft</option>
            <option value="Bold">Bold</option>
            <option value="Sweet">Sweet</option>
            <option value="Fresh">Fresh</option>
          </select>
        </div>
      </div>

      <div class="form-row">
        <label>Image URL</label>
        <input type="url" name="image_url" placeholder="https://...">
      </div>

      <div class="form-row">
        <label>Description</label>
        <textarea name="description" placeholder="A brief description of the perfume..."></textarea>
      </div>

      <button type="submit" class="btn-submit">Add Perfume</button>
    </form>

    <a class="back-link" href="<%= contextPath %>/admin/perfumes">← Back to Inventory</a>

  </div>
</div>
</body>
</html>
