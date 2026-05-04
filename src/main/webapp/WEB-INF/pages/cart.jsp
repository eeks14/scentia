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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>

<body>

<header class="navbar">
    <a class="brand" href="<%= contextPath %>/home">Scentia</a>
    <nav>
        <a href="<%= contextPath %>/home">Home</a>
        <a href="<%= contextPath %>/perfume?view=user">Perfume</a>
        <a href="<%= contextPath %>/about">About</a>
        <a href="<%= contextPath %>/contact">Contact</a>
        <a href="<%= contextPath %>/cart">Cart</a>
    </nav>
</header>

<main class="page-shell">

    <!-- HEADING -->
    <section class="page-heading">
        <div>
            <p class="page-kicker">Your selection</p>
            <h1 class="page-title">Shopping Cart</h1>
        </div>
        <a class="btn-primary" href="<%= contextPath %>/perfume?view=user">
            Continue Shopping
        </a>
    </section>

    <!-- CART ITEMS -->
    <section class="cart-list">

    <%
        if (cart != null && !cart.isEmpty()) {

            for (CartItem item : cart) {

                double price = item.getPrice();
                int quantity = item.getQuantity();
                double subtotal = price * quantity;

                totalAmount += subtotal;
    %>

        <article class="glass-card cart-item">

            <div>
                <h2 class="item-name"><%= item.getName() %></h2>
                <p class="item-note"><%= item.getBrand() %></p>
            </div>

            <p class="item-price">
                $<%= String.format("%.2f", price) %>
            </p>

           <div class="qty-controls">

    <a class="qty-btn"
       href="<%= contextPath %>/cart?action=decrease&id=<%= item.getId() %>">
       -
    </a>

    <span class="qty-number"><%= quantity %></span>

    <a class="qty-btn"
       href="<%= contextPath %>/cart?action=increase&id=<%= item.getId() %>">
       +
    </a>

</div>
            <p class="item-subtotal">
                $<%= String.format("%.2f", subtotal) %>
            </p>

            <a class="remove-link"
               href="<%= contextPath %>/cart?action=remove&id=<%= item.getId() %>">
                Remove
            </a>

        </article>

    <%
            }

        } else {
    %>

        <!-- EMPTY -->
        <div class="glass-card empty-state">
            <h2>Your cart is empty</h2>
            <p>Save your favorite conscious fragrances here before checkout.</p>

            <a class="btn-primary"
               href="<%= contextPath %>/perfume?view=user">
               Browse Perfumes
            </a>
        </div>

    <%
        }
    %>

    </section>

    <!-- SUMMARY -->
    <section class="glass-card cart-summary">

        <div>
            <p class="summary-label">Estimated total</p>
            <p class="summary-total">
                $<%= String.format("%.2f", totalAmount) %>
            </p>
        </div>

        <a class="btn-primary" href="<%= contextPath %>/checkout">
			    Checkout
		</a>

    </section>

</main>

</body>
</html>