<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.scentia.model.Perfume" %>
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

Perfume p = (Perfume) request.getAttribute("perfume");
if (p == null) {
    response.sendRedirect(contextPath + "/admin/perfumes");
    return;
}

String vibeVal = p.getVibe() != null ? p.getVibe() : "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Perfume | Scentia</title>
  <link rel="stylesheet" href="<%= contextPath %>/css/style.css">
</head>
<body>

<nav class="admin-navbar">
  <a href="<%= contextPath %>/admin" class="logo">Scent<span>ia</span></a>
  <div class="admin-nav-links">
    <a href="<%= contextPath %>/admin">Dashboard</a>
    <a href="<%= contextPath %>/admin/perfumes" class="active">Manage Perfumes</a>
    <a href="<%= contextPath %>/admin/users">Manage Users</a>
    <a href="<%= contextPath %>/logout" class="btn-logout">Logout</a>
  </div>
</nav>

<div class="form-wrapper">
  <div class="form-card">

    <h1>Edit Perfume</h1>

    <form action="<%= contextPath %>/admin/editPerfume" method="post">

      <input type="hidden" name="id" value="<%= p.getId() %>">

      <div class="form-row">
        <label>Perfume Name *</label>
        <input type="text" name="name"
               value="<%= p.getName() != null ? p.getName() : "" %>" required>
      </div>

      <div class="form-row">
        <label>Brand *</label>
        <input type="text" name="brand"
               value="<%= p.getBrand() != null ? p.getBrand() : "" %>" required>
      </div>

      <div class="form-row">
        <label>Category</label>
        <input type="text" name="category"
               value="<%= p.getCategory() != null ? p.getCategory() : "" %>">
      </div>

      <div class="form-row">
        <label>Notes</label>
        <input type="text" name="notes"
               value="<%= p.getNotes() != null ? p.getNotes() : "" %>">
      </div>

      <div class="form-grid">
        <div class="form-row">
          <label>Price ($) *</label>
          <input type="number" name="price" step="0.01" min="0"
                 value="<%= p.getPrice() %>" required>
        </div>
        <div class="form-row">
          <label>Stock *</label>
          <input type="number" name="stock" min="0"
                 value="<%= p.getStock() %>" required>
        </div>
      </div>

      <div class="form-grid">
        <div class="form-row">
          <label>Sustainability Score (1–5)</label>
          <input type="number" name="sustainability_score" min="1" max="5"
                 value="<%= p.getSustainabilityScore() %>">
        </div>
        <div class="form-row">
          <label>Vibe *</label>
          <select name="vibe" required>
            <option value="Soft"  <%= "Soft".equals(vibeVal)  ? "selected" : "" %>>Soft</option>
            <option value="Bold"  <%= "Bold".equals(vibeVal)  ? "selected" : "" %>>Bold</option>
            <option value="Sweet" <%= "Sweet".equals(vibeVal) ? "selected" : "" %>>Sweet</option>
            <option value="Fresh" <%= "Fresh".equals(vibeVal) ? "selected" : "" %>>Fresh</option>
          </select>
        </div>
      </div>

      <div class="form-row">
        <label>Image URL</label>
        <input type="url" name="image_url"
               value="<%= p.getImageUrl() != null ? p.getImageUrl() : "" %>">
      </div>

      <div class="form-row">
        <label>Description</label>
        <textarea name="description"><%= p.getDescription() != null ? p.getDescription() : "" %></textarea>
      </div>

      <button type="submit" class="btn-submit">Update Perfume</button>
    </form>

    <a class="back-link" href="<%= contextPath %>/admin/perfumes">← Back to Inventory</a>

  </div>
</div>
</body>
</html>
