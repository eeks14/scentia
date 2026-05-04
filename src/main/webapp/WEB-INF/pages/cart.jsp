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
    <link rel="stylesheet" href="<%= contextPath %>/css/style.css">
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
    <a class="btn-primary" href="<%= contextPath %>/checkout">Checkout</a>
</div>

</main>
</div>

</body>
</html>