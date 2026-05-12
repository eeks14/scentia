<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.scentia.model.User" %>

<%
List<User> users = (List<User>) request.getAttribute("users");
String context = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Scentia | Manage Users</title>
    <style id="k9x2aa">
/* =============================================================
   SCENTIA — ADMIN USERS PAGE (INLINE CSS)
   ============================================================= */

body {
    background: linear-gradient(135deg, #f7f4ef, #efe7dc);
    font-family: 'DM Sans', sans-serif;
}

/* Container */
.container {
    width: min(1200px, 92%);
    margin: 110px auto 60px auto;
}

/* Header */
.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 22px;
}

.page-title {
    font-family: 'Cormorant Garamond', serif;
    font-size: 2rem;
    color: #1a1a2e;
}

/* Card */
.card {
    background: rgba(255,255,255,0.7);
    backdrop-filter: blur(18px);
    border-radius: 16px;
    padding: 20px;
    box-shadow: 0 12px 35px rgba(0,0,0,0.08);
}

/* Search Bar */
.search-bar {
    display: flex;
    gap: 12px;
    margin-bottom: 18px;
}

.search-bar input {
    flex: 1;
    padding: 12px 16px;
    border-radius: 12px;
    border: 1px solid rgba(0,0,0,0.12);
    background: rgba(255,255,255,0.8);
    font-size: 0.9rem;
    outline: none;
    transition: 0.25s;
}

.search-bar input:focus {
    border-color: #b8964e;
    box-shadow: 0 0 0 4px rgba(184,150,78,0.15);
}

.search-bar button {
    padding: 10px 18px;
    border: none;
    border-radius: 999px;
    background: linear-gradient(135deg, #b8964e, #8d6b35);
    color: #fff;
    font-weight: 600;
    cursor: pointer;
    transition: 0.25s;
}

.search-bar button:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 20px rgba(184,150,78,0.25);
}

/* Table */
.table {
    width: 100%;
    border-collapse: collapse;
    border-radius: 12px;
    overflow: hidden;
}

.table th {
    background: #1a1a2e;
    color: #fff;
    padding: 14px;
    font-size: 0.72rem;
    text-transform: uppercase;
    letter-spacing: 0.12em;
    text-align: center;
}

.table td {
    padding: 14px;
    text-align: center;
    border-bottom: 1px solid rgba(0,0,0,0.05);
    font-size: 0.88rem;
    color: #1b1815;
}

.table tr:hover td {
    background: rgba(184,150,78,0.08);
}

/* Action buttons */
.action-box {
    display: flex;
    justify-content: center;
    gap: 10px;
}

.btn {
    padding: 7px 14px;
    border-radius: 999px;
    font-size: 0.8rem;
    font-weight: 500;
    text-decoration: none;
    transition: 0.25s ease;
}

/* Delete */
.btn-danger {
    background: linear-gradient(135deg, #e74c3c, #c0392b);
    color: #fff;
}
.btn-danger:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 20px rgba(231,76,60,0.25);
}

/* Block */
.btn-warning {
    background: linear-gradient(135deg, #f39c12, #d68910);
    color: #fff;
}
.btn-warning:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 20px rgba(243,156,18,0.25);
}

/* Back */
.btn-secondary {
    background: rgba(0,0,0,0.06);
    color: #1b1815;
}
.btn-secondary:hover {
    background: rgba(0,0,0,0.12);
}

/* Badge */
.badge {
    padding: 4px 10px;
    border-radius: 999px;
    font-size: 0.75rem;
    font-weight: 600;
}

.badge.admin {
    background: #e8e0f7;
    color: #4527a0;
}

.badge.user {
    background: #d9f2dd;
    color: #1e7a55;
}

/* Empty */
.empty-state {
    text-align: center;
    padding: 40px;
    color: #999;
}

/* Responsive */
@media (max-width: 768px) {
    .search-bar {
        flex-direction: column;
    }

    .action-box {
        flex-direction: column;
    }
}
</style>
   
     <link rel="stylesheet" href="<%=context%>/css/style.css">
</head>

<body>

<div class="container">

    <!-- Header -->
    <div class="page-header">
        <h2 class="page-title">Manage Users</h2>

        <a href="<%=context%>/admin" class="btn btn-secondary">
            Back to Dashboard
        </a>
    </div>

    <!-- Search Bar -->
    <form action="<%=context%>/admin/users" method="get" class="search-bar">
        <input type="text"
               name="q"
               placeholder="Search users by name or email..."
               value="<%= request.getParameter("q") != null ? request.getParameter("q") : "" %>">

        <button type="submit">Search</button>
    </form>

    <!-- Table Card -->
    <div class="card">

        <table class="table">

            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>

            <%
                if (users != null && !users.isEmpty()) {
                    for (User u : users) {
            %>

            <tr>
                <td><%=u.getId()%></td>
                <td><%=u.getName()%></td>
                <td><%=u.getEmail()%></td>

                <td>
                    <span class="badge <%=u.getRole()%>">
                        <%=u.getRole()%>
                    </span>
                </td>

                <td class="action-box">

                    <a href="<%=context%>/admin/deleteUser?id=<%=u.getId()%>"
                       class="btn btn-danger"
                       onclick="return confirm('Delete this user?')">
                        Delete
                    </a>

                    <a href="<%=context%>/admin/blockUser?id=<%=u.getId()%>"
                       class="btn btn-warning">
                        Block
                    </a>

                </td>
            </tr>

            <%
                    }
                } else {
            %>

            <tr>
                <td colspan="5" class="empty-state">
                    No users found
                </td>
            </tr>

            <% } %>

        </table>

    </div>

</div>

</body>
</html>