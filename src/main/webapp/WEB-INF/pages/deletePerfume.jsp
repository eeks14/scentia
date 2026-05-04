<%@ page contentType="text/html;charset=UTF-8" %>

<%
String contextPath = request.getContextPath();
String id = (String) request.getAttribute("id");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Delete Perfume | Scentia</title>
     <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>

<body>

<div class="main-container">

    <div class="delete-card glass-card">

        <h2 class="delete-title">Delete Perfume?</h2>

        <p class="delete-text">
            This action cannot be undone. The perfume will be permanently removed from your collection.
        </p>

        <div class="delete-actions">

            <!-- DELETE -->
            <a class="btn-danger"
               href="<%= contextPath %>/admin/deletePerfume?id=<%= id %>">
               Yes, Delete
            </a>

            <!-- CANCEL (go back to admin via servlet) -->
            <a class="btn-secondary"
               href="<%= contextPath %>/admin">
               Cancel
            </a>

        </div>

    </div>

</div>

</body>
</html>