<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.scentia.model.Perfume" %>

<%
    List<Perfume> perfumes = (List<Perfume>) request.getAttribute("perfumes");

    String search = request.getParameter("search");
    if (search == null) search = "";

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scentia | Perfumes</title>

    <link rel="stylesheet" href="<%= contextPath %>/css/style.css">
</head>

<body>

<!-- NAVBAR -->
<header class="navbar">
    <a class="brand" href="<%= contextPath %>/home">Scentia</a>

    <nav>
        <a href="<%= contextPath %>/home">Home</a>
        <a href="<%= contextPath %>/perfume">Perfume</a>
        <a href="<%= contextPath %>/about">About</a>
        <a href="<%= contextPath %>/contact">Contact</a>
        <a href="<%= contextPath %>/cart">Cart</a>
    </nav>
</header>

<!-- MAIN -->
<main class="page-shell">

    <!-- HERO -->
    <section class="page-hero">
        <div>
            <p class="page-kicker">Conscious fragrance edit</p>
            <h1 class="page-title">Perfumes with a lighter footprint.</h1>
            <p class="page-copy">
                Explore refined scents selected for ingredient quality,
                responsible sourcing, and sustainability.
            </p>
        </div>
    </section>

    <!-- SEARCH -->
    <form class="glass-card search-panel"
          action="<%= contextPath %>/perfume"
          method="get">

        <input class="search-input"
               type="search"
               name="search"
               value="<%= search %>"
               placeholder="Search by perfume or brand">

        <button class="btn-primary" type="submit">Search</button>
    </form>

    <!-- PERFUME GRID -->
    <section class="perfume-grid">

    <%
        if (perfumes != null && !perfumes.isEmpty()) {

            for (Perfume perfume : perfumes) {
    %>

        <article class="glass-card perfume-card">

            <!-- FIXED IMAGE -->
            <img src="<%= (perfume.getImageUrl() != null && !perfume.getImageUrl().isEmpty()) 
                          ? perfume.getImageUrl() 
                          : contextPath + "/images/default.png" %>"
                 alt="<%= perfume.getName() %>"
                 class="perfume-image"
                 onerror="this.src='https://picsum.photos/400/300';">

            <!-- INFO -->
            <div class="perfume-meta">
                <h2 class="perfume-name"><%= perfume.getName() %></h2>
                <p class="perfume-brand"><%= perfume.getBrand() %></p>

                <span class="score-pill">
                    Sustainability: <%= perfume.getSustainabilityScore() %>/5
                </span>
            </div>

            <!-- ACTIONS -->
            <div class="card-actions">

                <a class="btn-secondary"
                   href="<%= contextPath %>/perfume-details?id=<%= perfume.getId() %>">
                   View Details
                </a>

                <a class="btn-primary"
                   href="<%= contextPath %>/cart?action=add&id=<%= perfume.getId() %>">
                   Add to Cart
                </a>

            </div>

        </article>

    <%
            }

        } else {
    %>

        <!-- EMPTY STATE -->
        <div class="glass-card empty-state">
            <h2>No perfumes found</h2>
            <p>Try a different search keyword.</p>
        </div>

    <%
        }
    %>

    </section>

</main>

</body>
</html>