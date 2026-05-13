<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.scentia.model.User" %>

<%
String contextPath = request.getContextPath();
User user = (User) session.getAttribute("user");

if (user == null) {
    response.sendRedirect(contextPath + "/login");
    return;
}

// Admins have no profile page — send to dashboard
if ("admin".equals(user.getRole())) {
    response.sendRedirect(contextPath + "/admin");
    return;
}

String msg   = request.getParameter("msg");
String error = (String) request.getAttribute("error");
String initial = (user.getName() != null && !user.getName().isEmpty())
    ? user.getName().substring(0, 1).toUpperCase() : "U";
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Profile | Scentia</title>
  <!-- userDashboard.jsp -->
<style>
@import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=DM+Sans:wght@300;400;500;600;700&display=swap');
:root {
  --bg:#f7f4ef; --text:#1b1815; --muted:#8c857d;
  --gold:#b8964e; --gold-dark:#8d6b35; --navy:#1a1a2e;
  --shadow:0 10px 30px rgba(0,0,0,0.08); --radius:16px;
}
* { margin:0; padding:0; box-sizing:border-box; }
a { text-decoration:none; color:inherit; }
body {
  font-family:'DM Sans',sans-serif;
  background:radial-gradient(circle at top,#f7f4ef,#ede3d6);
  color:var(--text); line-height:1.6; animation:fadeIn 0.5s ease;
}
.navbar {
  position:fixed; top:0; left:0; right:0; z-index:100;
  backdrop-filter:blur(18px); background:rgba(255,255,255,0.7);
  box-shadow:0 4px 20px rgba(0,0,0,0.08);
  padding:16px 5%; display:flex; justify-content:space-between; align-items:center;
}
.logo { font-family:'Cormorant Garamond',serif; font-size:1.7rem; font-weight:700; color:var(--navy); }
.logo span { color:var(--gold); }
.nav-links { display:flex; gap:22px; align-items:center; }
.nav-link { font-size:0.88rem; font-weight:500; color:var(--text); transition:color 0.2s; }
.nav-link:hover { color:var(--gold); }
.btn-logout {
  padding:8px 18px; border-radius:999px;
  background:linear-gradient(135deg,var(--gold),var(--gold-dark));
  color:white !important; font-weight:600; font-size:0.82rem; transition:0.25s;
}
.btn-logout:hover { transform:translateY(-2px); box-shadow:0 8px 18px rgba(184,150,78,0.3); }
.main-container { padding-top:80px; }
.profile-wrapper {
  width:min(520px,92%); margin:0 auto; padding:50px 0 60px;
  display:flex; align-items:flex-start; justify-content:center;
}
.profile-card {
  width:100%; background:rgba(255,255,255,0.78);
  backdrop-filter:blur(18px); border-radius:20px;
  padding:42px 38px; box-shadow:0 14px 40px rgba(0,0,0,0.1);
  border:1px solid rgba(255,255,255,0.45); text-align:center;
}
/* AVATAR */
.avatar {
  width:72px; height:72px; border-radius:50%;
  background:linear-gradient(135deg,var(--gold),var(--gold-dark));
  color:white; font-size:1.8rem; font-weight:700;
  display:flex; align-items:center; justify-content:center;
  margin:0 auto 16px;
  box-shadow:0 8px 22px rgba(184,150,78,0.35);
}
.profile-card h1 {
  font-family:'Cormorant Garamond',serif;
  font-size:1.8rem; color:var(--navy); margin-bottom:4px;
}
.email-display { font-size:0.88rem; color:var(--muted); margin-bottom:20px; }
.divider { border:none; border-top:1px solid rgba(0,0,0,0.08); margin:20px 0; }
/* FORM */
.form-row { display:flex; flex-direction:column; gap:6px; margin-bottom:14px; text-align:left; }
.form-row label {
  font-size:0.78rem; font-weight:600; color:var(--text);
  letter-spacing:0.05em; text-transform:uppercase;
}
.form-row input {
  padding:12px 14px; border-radius:12px;
  border:1px solid rgba(0,0,0,0.12); background:rgba(255,255,255,0.88);
  font-size:0.9rem; font-family:'DM Sans',sans-serif; outline:none; transition:0.25s; width:100%;
}
.form-row input:focus { border-color:var(--gold); box-shadow:0 0 0 4px rgba(184,150,78,0.15); }
.form-row small { font-size:0.76rem; color:var(--muted); }
.btn-submit {
  width:100%; padding:13px; border:none; border-radius:999px;
  background:linear-gradient(135deg,var(--gold),var(--gold-dark));
  color:white; font-family:'DM Sans',sans-serif;
  font-size:0.95rem; font-weight:600; cursor:pointer; margin-top:8px; transition:0.3s ease;
}
.btn-submit:hover { transform:translateY(-3px); box-shadow:0 14px 28px rgba(184,150,78,0.28); }
.toast-msg {
  background:linear-gradient(135deg,var(--gold),var(--gold-dark));
  color:white; padding:10px 16px; border-radius:10px;
  font-size:0.85rem; margin-bottom:16px; text-align:center;
}
.error-msg {
  background:#fdecea; color:#c0392b; border-radius:10px;
  padding:10px 14px; font-size:0.85rem; margin-bottom:16px; text-align:center;
}
@keyframes fadeIn { from{opacity:0;transform:translateY(10px)} to{opacity:1;transform:translateY(0)} }
@media(max-width:480px){ .profile-card{padding:28px 18px;} }
</style>
</head>
<body>

<!-- USER NAVBAR -->
<nav class="navbar">
  <a href="<%= contextPath %>/home" class="logo">Scent<span>ia</span></a>
  <div class="nav-links">
    <a href="<%= contextPath %>/home"    class="nav-link">Home</a>
    <a href="<%= contextPath %>/perfume" class="nav-link">Browse</a>
    <a href="<%= contextPath %>/cart"    class="nav-link">Cart</a>
    <a href="<%= contextPath %>/profile" class="nav-link">Profile</a>
    <a href="<%= contextPath %>/logout"  class="nav-link btn-logout">Logout</a>
  </div>
</nav>

<div class="main-container">
<div class="profile-wrapper">
  <div class="profile-card">

    <div class="avatar"><%= initial %></div>
    <h1><%= user.getName() != null ? user.getName() : "User" %></h1>
    <p class="email-display"><%= user.getEmail() %></p>

    <% if ("updated".equals(msg)) { %>
      <div class="toast-msg"> Profile updated successfully.</div>
    <% } %>
    <% if (error != null) { %>
      <div class="error-msg">❌ <%= error %></div>
    <% } %>

    <hr class="divider">

    <form action="<%= contextPath %>/profile" method="post">

      <div class="form-row">
        <label>Name *</label>
        <input type="text" name="name"
               value="<%= user.getName() != null ? user.getName() : "" %>" required>
      </div>

      <div class="form-row">
        <label>Email *</label>
        <input type="email" name="email"
               value="<%= user.getEmail() != null ? user.getEmail() : "" %>" required>
      </div>

      <div class="form-row">
        <label>New Password</label>
        <input type="password" name="password" placeholder="Leave blank to keep current">
        <small>Minimum 6 characters</small>
      </div>

      <button type="submit" class="btn-submit">Save Changes</button>
    </form>

  </div>
</div>
</div>
</body>
</html>
