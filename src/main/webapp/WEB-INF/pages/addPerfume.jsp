<!DOCTYPE html>
<html>
<head>
    <title>Add Perfume</title>

     <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>

<body>

<main class="main-container">

<div class="glass-card form-card">

<h1 class="form-title">Add Perfume</h1>

<form action="<%= request.getContextPath() %>/admin/addPerfume" method="post">

<div class="form-group">
<input class="form-input"
       name="name"
       placeholder="Perfume Name"
       required>
</div>

<div class="form-group">
<input class="form-input"
       name="brand"
       placeholder="Brand"
       required>
</div>

<div class="form-group">
<input class="form-input"
       type="number"
       step="0.01"
       name="price"
       placeholder="Price"
       required>
</div>

<div class="form-group">
<input class="form-input"
       type="number"
       name="stock"
       placeholder="Stock"
       required>
</div>

<button class="btn-primary">
    Add Perfume
</button>

</form>

</div>

</main>

</body>
</html>