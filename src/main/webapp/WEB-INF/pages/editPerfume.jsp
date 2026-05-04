<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
String id = request.getParameter("id");

String name = "";
String brand = "";
double price = 0;
int stock = 0;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/scentia", "root", "");

    PreparedStatement ps = conn.prepareStatement(
        "SELECT * FROM perfumes WHERE id=?"
    );

    ps.setInt(1, Integer.parseInt(id));

    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        name = rs.getString("name");
        brand = rs.getString("brand");
        price = rs.getDouble("price");
        stock = rs.getInt("stock");
    }

    conn.close();

} catch (Exception e) {
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Perfume</title>
     <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>

<body>

<%
String contextPath = request.getContextPath();
%>

<div class="form-card glass-card">

<h2 class="form-title">Edit Perfume</h2>

<form action="<%= contextPath %>/admin/editPerfume" method="post">

<input type="hidden" name="id" value="<%= id %>">

<input class="form-input" type="text" name="name" value="<%= name %>" required>

<input class="form-input" type="text" name="brand" value="<%= brand %>" required>

<input class="form-input" type="number" step="0.01" name="price" value="<%= price %>" required>

<input class="form-input" type="number" name="stock" value="<%= stock %>" required>

<button class="btn-primary" type="submit">Update Perfume</button>

</form>

<!-- 🔙 BACK BUTTON -->
<div style="margin-top: 15px;">
    <a href="<%= contextPath %>/admin" class="btn-secondary">
        ← Back to Dashboard
    </a>
</div>

</div>

</body>
</html>