<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Register | Scentia</title>
  <!-- register.jsp -->
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
  color:var(--text); line-height:1.6; min-height:100vh;
  animation:fadeIn 0.5s ease;
}
.navbar {
  position:fixed; top:0; left:0; right:0; z-index:100;
  backdrop-filter:blur(18px); background:rgba(255,255,255,0.7);
  box-shadow:0 4px 20px rgba(0,0,0,0.08);
  padding:16px 5%; display:flex; justify-content:space-between; align-items:center;
}
.logo {
  font-family:'Cormorant Garamond',serif;
  font-size:1.6rem; font-weight:700; color:var(--navy);
}
.logo span { color:var(--gold); }
.auth-wrapper {
  width:min(440px,92%); margin:100px auto 60px auto;
  display:flex; align-items:center; justify-content:center; padding-top:20px;
}
.auth-card {
  width:100%;
  background:rgba(255,255,255,0.78);
  backdrop-filter:blur(18px);
  border-radius:var(--radius);
  padding:40px 36px;
  box-shadow:0 12px 35px rgba(0,0,0,0.1);
  border:1px solid rgba(255,255,255,0.45);
}
.auth-logo {
  font-family:'Cormorant Garamond',serif;
  font-size:2rem; font-weight:700;
  color:var(--navy); text-align:center; margin-bottom:4px;
}
.auth-logo span { color:var(--gold); }
.auth-tagline {
  font-size:0.8rem; color:var(--muted);
  text-align:center; letter-spacing:0.06em;
  text-transform:uppercase; margin-bottom:22px;
}
.auth-card h2 {
  font-family:'Cormorant Garamond',serif;
  font-size:1.55rem; color:var(--navy);
  text-align:center; margin-bottom:20px;
}
.form-row { display:flex; flex-direction:column; gap:6px; margin-bottom:14px; }
.form-row label {
  font-size:0.78rem; font-weight:600;
  color:var(--text); letter-spacing:0.05em; text-transform:uppercase;
}
.form-row input {
  padding:12px 14px; border-radius:12px;
  border:1px solid rgba(0,0,0,0.12);
  background:rgba(255,255,255,0.85);
  font-size:0.9rem; font-family:'DM Sans',sans-serif;
  outline:none; transition:0.25s ease; width:100%;
}
.form-row input:focus {
  border-color:var(--gold);
  box-shadow:0 0 0 4px rgba(184,150,78,0.15);
}
.btn-submit {
  width:100%; padding:13px; border:none; border-radius:999px;
  background:linear-gradient(135deg,var(--gold),var(--gold-dark));
  color:white; font-family:'DM Sans',sans-serif;
  font-size:0.95rem; font-weight:600;
  cursor:pointer; margin-top:8px; transition:0.3s ease;
}
.btn-submit:hover { transform:translateY(-3px); box-shadow:0 14px 28px rgba(184,150,78,0.28); }
.error-box {
  background:#fdecea; color:#c0392b; border-radius:10px;
  padding:10px 14px; font-size:0.85rem; margin-bottom:16px; text-align:center;
}
.auth-switch { text-align:center; margin-top:18px; font-size:0.85rem; color:var(--muted); }
.auth-switch a { color:var(--gold-dark); font-weight:600; }
.auth-switch a:hover { text-decoration:underline; }
@keyframes fadeIn { from{opacity:0;transform:translateY(10px)} to{opacity:1;transform:translateY(0)} }
@media(max-width:480px){ .auth-card{padding:28px 18px;} }
</style>
</head>
<body>

<nav class="navbar">
  <a href="<%= request.getContextPath() %>/home" class="logo">Scent<span>ia</span></a>
</nav>

<div class="auth-wrapper">
  <div class="auth-card">

    <div class="auth-logo">Scent<span>ia</span></div>
    <p class="auth-tagline">Begin your fragrance journey</p>

    <h2>Create Account</h2>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
      <div class="error-box"><%= error %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/register" method="post">

      <div class="form-row">
        <label>Name</label>
        <input type="text" name="name" required>
      </div>

      <div class="form-row">
        <label>Email</label>
        <input type="email" name="email" required>
      </div>

      <div class="form-row">
        <label>Password</label>
        <input type="password" name="password" required>
      </div>

      <div class="form-row">
        <label>Confirm Password</label>
        <input type="password" name="confirmPassword" required>
      </div>

      <input type="hidden" name="role" value="user">

      <button type="submit" class="btn-submit">Create Account</button>

    </form>

    <div class="auth-switch">
      Already have an account?
      <a href="<%= request.getContextPath() %>/login">Sign in</a>
    </div>

  </div>
</div>

</body>
</html>
