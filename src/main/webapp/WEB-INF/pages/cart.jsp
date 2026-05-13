<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.scentia.model.CartItem" %>

<%
    String contextPath = request.getContextPath();
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    double totalAmount = 0.0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scentia | Cart</title>
    <!-- cart.jsp -->
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
  background:radial-gradient(circle at top,#f7f4ef,#ede3d6);
  color:var(--text); line-height:1.6; animation:fadeIn 0.5s ease;
}

/* NAVBAR */
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

/* PAGE SHELL */
.main-container { padding-top:80px; }
.page-shell { width:min(1100px,92%); margin:0 auto; padding:40px 0 60px; }

/* CART HEADER */
.cart-header {
  display:flex; justify-content:space-between; align-items:center; margin-bottom:28px;
}
.page-kicker {
  font-size:0.78rem; color:var(--muted);
  letter-spacing:0.14em; text-transform:uppercase; margin-bottom:4px;
}
.page-title {
  font-family:'Cormorant Garamond',serif; font-size:2.2rem; color:var(--navy);
}

/* CART LIST */
.cart-list { display:flex; flex-direction:column; gap:18px; }

/* CART CARD */
.cart-card {
  position:relative; display:flex; align-items:center;
  justify-content:space-between; gap:20px; padding:22px 24px;
  background:rgba(255,255,255,0.78); backdrop-filter:blur(18px);
  border-radius:18px; border:1px solid rgba(255,255,255,0.4);
  box-shadow:0 10px 30px rgba(0,0,0,0.06);
  transition:transform 0.35s ease, box-shadow 0.35s ease, opacity 0.35s ease;
  animation:cartFade 0.5s ease;
}
.cart-card:hover { transform:translateY(-4px); box-shadow:0 20px 40px rgba(0,0,0,0.12); }
.cart-card.removing {
  opacity:0; transform:translateX(40px) scale(0.96); transition:all 0.35s ease;
}

/* PRODUCT INFO */
.cart-info { flex:3; }
.item-name { font-size:1.15rem; font-weight:600; color:var(--navy); margin-bottom:4px; }
.item-note { font-size:0.85rem; color:var(--muted); letter-spacing:0.04em; }

/* PRICE */
.cart-price { flex:1; text-align:center; font-weight:600; color:var(--text); font-size:0.95rem; }

/* QUANTITY */
.cart-qty { flex:1; display:flex; justify-content:center; align-items:center; gap:12px; }
.cart-qty a {
  width:34px; height:34px; display:flex; align-items:center; justify-content:center;
  border-radius:50%; background:rgba(0,0,0,0.05);
  font-size:1rem; font-weight:600; transition:all 0.25s ease;
}
.cart-qty a:hover { background:var(--navy); color:white; transform:scale(1.08); }
.cart-qty span { min-width:20px; text-align:center; font-weight:600; }
.cart-qty span.bump { animation:qtyPulse 0.25s ease; }

/* SUBTOTAL */
.cart-subtotal { flex:1; text-align:center; font-weight:700; color:var(--navy); font-size:1rem; }

/* REMOVE */
.cart-remove { flex:1; text-align:center; }
.cart-remove a {
  position:relative; color:#d64545; font-size:0.88rem; font-weight:500; transition:all 0.25s ease;
}
.cart-remove a::after {
  content:""; position:absolute; left:0; bottom:-4px;
  width:0%; height:1px; background:#d64545; transition:width 0.3s ease;
}
.cart-remove a:hover::after { width:100%; }

/* EMPTY STATE */
.glass-card {
  background:rgba(255,255,255,0.72); backdrop-filter:blur(18px);
  border-radius:var(--radius); border:1px solid rgba(255,255,255,0.45); box-shadow:var(--shadow);
}
.empty-state { padding:70px 30px; text-align:center; border-radius:20px; animation:fadeIn 0.4s ease; }
.empty-state h2 {
  font-family:'Cormorant Garamond',serif; font-size:2rem;
  color:var(--navy); margin-bottom:8px;
}
.empty-state p { color:var(--muted); font-size:0.95rem; }

/* SUMMARY BOX */
.cart-summary-box {
  margin-top:28px; display:flex; justify-content:space-between; align-items:center;
  padding:24px; background:rgba(255,255,255,0.82); backdrop-filter:blur(18px);
  border-radius:20px; box-shadow:0 12px 35px rgba(0,0,0,0.08);
  border:1px solid rgba(255,255,255,0.4);
}
.cart-summary-box p { color:var(--muted); font-size:0.88rem; margin-bottom:4px; }
.cart-summary-box h2 {
  font-family:'Cormorant Garamond',serif; font-size:2rem; color:var(--navy);
}

/* BUTTONS */
.btn-primary {
  display:inline-block; padding:13px 26px; border-radius:999px; border:none;
  background:linear-gradient(135deg,var(--gold),var(--gold-dark));
  color:white; font-family:'DM Sans',sans-serif; font-weight:600;
  font-size:0.92rem; cursor:pointer; transition:all 0.3s ease; text-align:center;
}
.btn-primary:hover { transform:translateY(-3px); box-shadow:0 14px 28px rgba(184,150,78,0.28); }

/* ANIMATIONS */
@keyframes fadeIn { from{opacity:0;transform:translateY(10px)} to{opacity:1;transform:translateY(0)} }
@keyframes cartFade {
  from{opacity:0;transform:translateY(14px) scale(0.98)}
  to{opacity:1;transform:translateY(0) scale(1)}
}
@keyframes qtyPulse {
  0%{transform:scale(1)} 50%{transform:scale(1.28)} 100%{transform:scale(1)}
}

/* RESPONSIVE */
@media(max-width:768px){
  .cart-card{ flex-direction:column; align-items:flex-start; gap:16px; }
  .cart-price,.cart-qty,.cart-subtotal,.cart-remove{ width:100%; text-align:left; }
  .cart-qty{ justify-content:flex-start; }
  .cart-summary-box{ flex-direction:column; align-items:flex-start; gap:18px; }
  .btn-primary{ width:100%; text-align:center; }
  .cart-header{ flex-direction:column; align-items:flex-start; gap:14px; }
}
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

<section class="cart-header">
    <div>
        <p class="page-kicker">Your selection</p>
        <h1 class="page-title">Shopping Cart</h1>
    </div>
    <a class="btn-primary" href="<%= contextPath %>/perfume?view=user">
        Continue Shopping
    </a>
</section>

<section class="cart-list">

<%
if (cart != null && !cart.isEmpty()) {
    for (CartItem item : cart) {

        double price = item.getPrice();
        int quantity = item.getQuantity();
        double subtotal = price * quantity;

        totalAmount += subtotal;
%>

<div class="cart-card">

    <!-- LEFT -->
    <div class="cart-info">
        <h2 class="item-name"><%= item.getName() %></h2>
        <p class="item-note"><%= item.getBrand() %></p>
    </div>

    <!-- PRICE -->
    <div class="cart-price">
        $<%= String.format("%.2f", price) %>
    </div>

    <!-- QUANTITY -->
    <div class="cart-qty">
        <a href="<%= contextPath %>/cart?action=decrease&id=<%= item.getId() %>">−</a>
        <span><%= quantity %></span>
        <a href="<%= contextPath %>/cart?action=increase&id=<%= item.getId() %>">+</a>
    </div>

    <!-- SUBTOTAL -->
    <div class="cart-subtotal">
        $<%= String.format("%.2f", subtotal) %>
    </div>

    <!-- REMOVE -->
    <div class="cart-remove">
        <a href="<%= contextPath %>/cart?action=remove&id=<%= item.getId() %>">
            Remove
        </a>
    </div>

</div>

<%
    }
} else {
%>

<div class="glass-card empty-state">
    <h2>Your cart is empty</h2>
    <p>Start adding perfumes to your collection ✨</p>
</div>

<%
}
%>

</section>

<!-- SUMMARY -->
<div class="cart-summary-box">
    <div>
        <p>Total</p>
        <h2>$<%= String.format("%.2f", totalAmount) %></h2>
    </div>
    <button class="btn-primary" onclick="handleCheckout()">Checkout</button>

<script>
  function handleCheckout() {
    const items = document.querySelectorAll(".cart-card");
    if (items.length === 0) {
      alert("Your cart is empty. Please add items before checking out.");
      return;
    }
    window.location.href = "<%= contextPath %>/checkout";
  }
</script>
</div>
 
</main>
</div>
<script>

document.addEventListener("DOMContentLoaded", () => {

    /* REMOVE ANIMATION */
    document.querySelectorAll(".cart-remove a").forEach(btn => {

        btn.addEventListener("click", function(e) {

            e.preventDefault();

            const card = this.closest(".cart-card");

            card.classList.add("removing");

            setTimeout(() => {
                window.location.href = this.href;
            }, 300);

        });

    });

    /* QUANTITY ANIMATION */
    document.querySelectorAll(".cart-qty a").forEach(btn => {

        btn.addEventListener("click", function() {

            const qty =
                this.parentElement.querySelector("span");

            qty.classList.add("bump");

            setTimeout(() => {
                qty.classList.remove("bump");
            }, 250);

        });

    });

});

</script>
</body>
</html>
