<%@ page contentType="text/html;charset=UTF-8" %>
<%
String contextPath = request.getContextPath();
String name = (String) request.getAttribute("name");
%>

<html>
<head>
    <title>Order Successful</title>
    <!-- Success.jsp -->
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
  display:flex; align-items:center; justify-content:center;
  animation:fadeIn 0.5s ease;
}
.page-shell {
  width:min(520px,92%); margin:auto; text-align:center;
  background:rgba(255,255,255,0.78); backdrop-filter:blur(18px);
  border-radius:24px; padding:60px 44px;
  box-shadow:0 14px 40px rgba(0,0,0,0.1);
  border:1px solid rgba(255,255,255,0.45);
}
.page-shell h1 {
  font-family:'Cormorant Garamond',serif;
  font-size:2.4rem; color:var(--navy); margin-bottom:14px;
}
.page-shell p { color:var(--muted); font-size:0.95rem; margin-bottom:30px; line-height:1.65; }
.page-shell a {
  display:inline-block; padding:13px 28px; border-radius:999px;
  background:linear-gradient(135deg,var(--gold),var(--gold-dark));
  color:white; font-weight:600; font-size:0.9rem; transition:0.3s ease;
}
.page-shell a:hover { transform:translateY(-3px); box-shadow:0 14px 28px rgba(184,150,78,0.28); }
@keyframes fadeIn { from{opacity:0;transform:translateY(10px)} to{opacity:1;transform:translateY(0)} }
</style>
</head>

<body>

<main class="page-shell">

<h1>Order Confirmed 🎉</h1>

<p>Thank you, <%= name %>! Your order has been placed successfully.</p>

<a href="<%= contextPath %>/perfume?view=user">
    Continue Shopping
</a>

</main>

</body>
</html>