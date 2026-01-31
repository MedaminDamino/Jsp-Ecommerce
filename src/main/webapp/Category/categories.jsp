<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Categories</title>
    <link rel="stylesheet" href="../libraries/bootstrap/bootstrap.min.css">

</head>
<body>

<jsp:include page="/shared/navbar/navbar.jsp"></jsp:include>

<h1>Categories</h1>
<a href="categories/add" class="btn btn-primary mb-3">
    + Add Category
</a>

<c:if test="${empty categories}">
    <p>No categories found.</p>
</c:if>

<c:forEach var="category" items="${categories}">
    <h2>${category.name}</h2>
    <p>${category.description}</p>

    <h4>Products</h4>
    <ul>
        <c:forEach var="product" items="${category.products}">
            <li>
                <b>${product.name}</b> — ${product.price}
                <br/>
                <small>${product.description}</small>
            </li>
        </c:forEach>
    </ul>

    <hr/>
</c:forEach>

</body>
</html>
