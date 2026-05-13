<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.scentia.model.User" %>

<%
List<User> users = (List<User>) request.getAttribute("users");
String context = request.getContextPath();
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

String msg = request.getParameter("msg");
int totalPerfumes = request.getAttribute("totalPerfumes") != null
    ? (int) request.getAttribute("totalPerfumes") : 0;
int totalUsers = request.getAttribute("totalUsers") != null
    ? (int) request.getAttribute("totalUsers") : 0;
int lowStock = request.getAttribute("lowStock") != null
    ? (int) request.getAttribute("lowStock") : 0;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Scentia | Manage Users</title>
    <style id="k9x2aa">
<!-- adminUsers.jsp -->
<style>
@import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=DM+Sans:wght@300;400;500;600;700&display=swap');
:root {
  --bg:#f7f4ef; --card:rgba(255,255,255,0.7); --text:#1b1815;
  --muted:#8c857d; --gold:#b8964e; --gold-dark:#8d6b35;
  --navy:#1a1a2e; --border:rgba(0,0,0,0.08); --shadow:0 10px 30px rgba(0,0,0,0.08); --radius:16px;
}
* { margin:0; padding:0; box-sizing:border-box; }
a { text-decoration:none; color:inherit; }
body {
  font-family:'DM Sans',sans-serif;
  background:linear-gradient(135deg,#f7f4ef,#efe7dc);
  color:var(--text); line-height:1.6; animation:fadeIn 0.5s ease;
}
.admin-navbar {
  position:fixed; top:0; left:0; right:0; z-index:100;
  backdrop-filter:blur(18px); background:rgba(26,26,46,0.96);
  box-shadow:0 4px 20px rgba(0,0,0,0.2);
  padding:16px 5%; display:flex; justify-content:space-between; align-items:center;
}
.logo { font-family:'Cormorant Garamond',serif; font-size:1.6rem; font-weight:700; color:white; }
.logo span { color:var(--gold); }
.admin-nav-links { display:flex; gap:22px; align-items:center; }
.admin-nav-links a { font-size:0.86rem; font-weight:500; color:rgba(255,255,255,0.75); transition:color 0.2s; }
.admin-nav-links a:hover, .admin-nav-links a.active { color:white; }
.btn-logout {
  padding:7px 16px; border-radius:999px; font-size:0.8rem; font-weight:600;
  background:rgba(255,255,255,0.12); color:white !important; border:1px solid rgba(255,255,255,0.2);
  transition:0.2s;
}
.btn-logout:hover { background:rgba(255,255,255,0.22); }
.container { width:min(1200px,92%); margin:110px auto 60px auto; }
.page-header { display:flex; justify-content:space-between; align-items:center; margin-bottom:22px; flex-wrap:wrap; gap:12px; }
.page-title { font-family:'Cormorant Garamond',serif; font-size:2rem; color:var(--navy); }
.card {
  background:rgba(255,255,255,0.7); backdrop-filter:blur(18px);
  border-radius:var(--radius); padding:20px;
  border:1px solid rgba(255,255,255,0.4); box-shadow:0 12px 35px rgba(0,0,0,0.08);
}
.search-bar { display:flex; gap:12px; margin-bottom:18px; }
.search-bar input {
  flex:1; padding:12px 16px; border-radius:12px;
  border:1px solid rgba(0,0,0,0.12); background:rgba(255,255,255,0.8);
  font-size:0.9rem; font-family:'DM Sans',sans-serif; outline:none; transition:0.25s;
}
.search-bar input:focus { border-color:var(--gold); box-shadow:0 0 0 4px rgba(184,150,78,0.15); }
.search-bar button {
  padding:10px 18px; border:none; border-radius:999px;
  background:linear-gradient(135deg,var(--gold),var(--gold-dark));
  color:white; font-weight:600; font-family:'DM Sans',sans-serif; cursor:pointer; transition:0.25s;
}
.search-bar button:hover { transform:translateY(-2px); box-shadow:0 10px 20px rgba(184,150,78,0.25); }
.table { width:100%; border-collapse:collapse; border-radius:12px; overflow:hidden; }
.table th {
  background:rgba(26,26,46,0.95); color:#fff;
  padding:14px; text-align:center;
  font-size:0.72rem; text-transform:uppercase; letter-spacing:0.12em;
}
.table td {
  padding:14px; text-align:center;
  font-size:0.88rem; color:var(--text);
  border-bottom:1px solid rgba(0,0,0,0.05);
}
.table tr:hover td { background:rgba(184,150,78,0.08); transition:0.2s; }
.action-box { display:flex; justify-content:center; gap:10px; }
.btn {
  padding:7px 14px; border-radius:999px;
  font-size:0.8rem; font-weight:500;
  text-decoration:none; transition:0.25s ease;
  display:inline-block;
}
.btn-danger { background:linear-gradient(135deg,#e74c3c,#c0392b); color:#fff; }
.btn-danger:hover { transform:translateY(-2px); box-shadow:0 10px 20px rgba(231,76,60,0.25); }
.btn-warning { background:linear-gradient(135deg,#f39c12,#d68910); color:#fff; }
.btn-warning:hover { transform:translateY(-2px); box-shadow:0 10px 20px rgba(243,156,18,0.25); }
.btn-secondary { background:rgba(0,0,0,0.06); color:var(--text); }
.btn-secondary:hover { background:rgba(0,0,0,0.12); transform:translateY(-2px); }
.badge { padding:4px 10px; border-radius:999px; font-size:0.75rem; font-weight:600; }
.badge.admin { background:#e8e0f7; color:#4527a0; }
.badge.user { background:#d9f2dd; color:#1e7a55; }
.empty-state { text-align:center; padding:40px; color:#999; font-size:0.9rem; }
@keyframes fadeIn { from{opacity:0;transform:translateY(10px)} to{opacity:1;transform:translateY(0)} }
@media(max-width:768px){
  .search-bar{ flex-direction:column; }
  .action-box{ flex-direction:column; gap:6px; }
  .table th,.table td{ font-size:0.75rem; padding:10px; }
}
</style>
   
     <link rel="stylesheet" href="<%=context%>/css/style.css">
</head>

<body>

<nav class="admin-navbar">
  <a href="<%= contextPath %>/admin" class="logo">Scent<span>ia</span></a>
  <div class="admin-nav-links">
    <a href="<%= contextPath %>/admin" class="active">Dashboard</a>
    <a href="<%= contextPath %>/admin/perfumes">Manage Perfumes</a>
    <a href="<%= contextPath %>/admin/users">Manage Users</a>
    <a href="<%= contextPath %>/logout" class="btn-logout">Logout</a>
  </div>
</nav>
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