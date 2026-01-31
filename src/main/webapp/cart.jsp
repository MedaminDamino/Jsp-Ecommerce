<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ page import="java.util.Map" %>
            <%@ page import="java.util.HashMap" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Shopping Cart - JSP Store</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                </head>

                <body>
                    <jsp:include page="header.jsp" />

                    <div class="container mt-4">
                        <h2>Your Shopping Cart</h2>

                        <c:choose>
                            <c:when test="${empty sessionScope.cart or sessionScope.cart.size() == 0}">
                                <div class="alert alert-warning mt-4">
                                    Your cart is empty. <a href="${pageContext.request.contextPath}/home"
                                        class="alert-link">Start Shopping</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive mt-4">
                                    <table class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>Product ID</th>
                                                <th>Quantity</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="entry" items="${sessionScope.cart}">
                                                <tr>
                                                    <td>${entry.key}</td>
                                                    <!-- In a real app we would resolve Product Object -->
                                                    <td>
                                                        <form action="${pageContext.request.contextPath}/cart"
                                                            method="post" class="d-flex">
                                                            <input type="hidden" name="action" value="update">
                                                            <input type="hidden" name="productId" value="${entry.key}">
                                                            <input type="number" name="quantity" value="${entry.value}"
                                                                min="1" class="form-control"
                                                                style="width: 80px; margin-right: 10px;">
                                                            <button type="submit"
                                                                class="btn btn-sm btn-primary">Update</button>
                                                        </form>
                                                    </td>
                                                    <td>
                                                        <form action="${pageContext.request.contextPath}/cart"
                                                            method="post">
                                                            <input type="hidden" name="action" value="remove">
                                                            <input type="hidden" name="productId" value="${entry.key}">
                                                            <button type="submit"
                                                                class="btn btn-sm btn-danger">Remove</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="mt-3 text-end">
                                    <!-- Calculating Total requires Product Objects, skipping for brevity as per prompt constraints -->
                                    <a href="${pageContext.request.contextPath}/checkout"
                                        class="btn btn-success btn-lg">Checkout</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <jsp:include page="footer.jsp" />