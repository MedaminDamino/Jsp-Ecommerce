<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Category</title>
    <link rel="stylesheet" href="../libraries/bootstrap/bootstrap.min.css">
</head>
<body>

<jsp:include page="/shared/navbar/navbar.jsp"></jsp:include>

<div class="container mt-5">
    <h2>Add Category</h2>

    <form method="post" action="add">
        <div class="mb-3">
            <label class="form-label">Category Name</label>
            <input class="form-control" name="name" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea class="form-control" name="description"></textarea>
        </div>

        <button type="submit" class="btn btn-success">Save</button>
        <a href="../categories" class="btn btn-secondary">Cancel</a>
    </form>
</div>

<script src="./libraries/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
