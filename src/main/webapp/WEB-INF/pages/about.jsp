<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scentia | About</title>
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
    <section class="about-hero">
        <div class="glass-card hero-copy">
            <p class="page-kicker">About Scentia</p>
            <h1 class="page-title">Luxury fragrance, chosen with conscience.</h1>
            <p class="page-copy">
                Scentia is a curated perfume destination for people who love elegant scent
                and care about how it is made. We highlight fragrances with thoughtful
                ingredients, ethical sourcing, and transparent sustainability signals.
            </p>
        </div>
        <div class="glass-card hero-art" aria-hidden="true">
            <div class="bottle-mark"></div>
        </div>
    </section>

    <section class="feature-grid" aria-label="Scentia values">
        <article class="glass-card vibe-card feature-card">
            <h2>Responsible Curation</h2>
            <p>Every fragrance is presented with sustainability in mind, making it easier to compare beyond notes and bottle design.</p>
        </article>
        <article class="glass-card vibe-card feature-card">
            <h2>Ethical Focus</h2>
            <p>We prioritize brands that value responsible ingredient choices, mindful production, and longer-lasting quality.</p>
        </article>
        <article class="glass-card vibe-card feature-card">
            <h2>Soft Luxury</h2>
            <p>Scentia keeps the shopping experience calm, refined, and intentional so discovery feels personal rather than overwhelming.</p>
        </article>
    </section>
</main>
</body>
</html>
