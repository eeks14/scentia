<%@ page contentType="text/html;charset=UTF-8" %>
<%
String contextPath = request.getContextPath();
String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout | Scentia</title>
    <!-- Checkout.jsp -->
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
.main-container { padding-top:80px; }
.page-shell { width:min(560px,92%); margin:0 auto; padding:50px 0 60px; }
.form-wrapper { display:flex; align-items:center; justify-content:center; }
.form-card {
  width:100%; background:rgba(255,255,255,0.78);
  backdrop-filter:blur(18px); border-radius:20px;
  padding:42px 38px; box-shadow:0 14px 40px rgba(0,0,0,0.1);
  border:1px solid rgba(255,255,255,0.45);
}
.form-card h1 {
  font-family:'Cormorant Garamond',serif;
  font-size:2rem; color:var(--navy); margin-bottom:26px;
}
.form-row { display:flex; flex-direction:column; gap:6px; margin-bottom:16px; }
.form-row label {
  font-size:0.78rem; font-weight:600; color:var(--text);
  letter-spacing:0.05em; text-transform:uppercase;
}
.form-row input {
  padding:12px 14px; border-radius:12px;
  border:1px solid rgba(0,0,0,0.12);
  background:rgba(255,255,255,0.85);
  font-size:0.9rem; font-family:'DM Sans',sans-serif;
  outline:none; transition:0.25s ease; width:100%;
}
.form-row input:focus { border-color:var(--gold); box-shadow:0 0 0 4px rgba(184,150,78,0.15); }
.error-box {
  background:#fdecea; color:#c0392b; border-radius:10px;
  padding:10px 14px; font-size:0.85rem; margin-bottom:16px;
}
.btn-submit {
  width:100%; padding:14px; border:none; border-radius:999px;
  background:linear-gradient(135deg,var(--gold),var(--gold-dark));
  color:white; font-family:'DM Sans',sans-serif;
  font-size:0.95rem; font-weight:600; cursor:pointer; margin-top:8px; transition:0.3s ease;
}
.btn-submit:hover { transform:translateY(-3px); box-shadow:0 14px 28px rgba(184,150,78,0.28); }
@keyframes fadeIn { from{opacity:0;transform:translateY(10px)} to{opacity:1;transform:translateY(0)} }
@media(max-width:480px){ .form-card{padding:28px 18px;} }
</style>
</head>

<body>


<nav class="navbar">
  <a href="<%= contextPath %>/home" class="logo">Scent<span>ia</span></a>
  <div class="nav-links">
    <a href="<%= contextPath %>/home" class="nav-link">Home</a>
    <a href="<%= contextPath %>/perfume?view=user" class="nav-link">Perfume</a>
    <a href="<%= contextPath %>/about" class="nav-link">About</a>
    <a href="<%= contextPath %>/contact" class="nav-link">Contact</a>
    <a href="<%= contextPath %>/cart" class="nav-link">Cart</a>
  </div>
</nav>


<div class="main-container">
<main class="page-shell">

<div class="form-wrapper">
  <div class="form-card">

    <h1>Checkout</h1>

    <% if (error != null) { %>
        <div class="error-box"><%= error %></div>
    <% } %>

    <form action="<%= contextPath %>/checkout" method="post">

        <div class="form-row">
            <label>Full Name</label>
            <input type="text" name="name" required>
        </div>

        <div class="form-row">
            <label>Address</label>
            <input type="text" name="address" required>
        </div>

        <div class="form-row">
            <label>Phone</label>
            <input type="text" name="phone" required>
        </div>

        <button type="submit" class="btn-submit">Place Order</button>

    </form>

  </div>
</div>

</main>
</div>

</body>
</html>