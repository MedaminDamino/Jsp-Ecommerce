<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <title>${product.name} - JSP Store</title>
            <%@ include file="/WEB-INF/fragments/head.jspf" %>
        </head>

        <body>

            <%@ include file="/WEB-INF/fragments/client-navbar.jspf" %>

                <div class="container main-content mt-5">

                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
                            <c:if test="${not empty category}">
                                <li class="breadcrumb-item"><a
                                        href="${pageContext.request.contextPath}/home?category=${category.id}">${category.name}</a>
                                </li>
                            </c:if>
                            <li class="breadcrumb-item active" aria-current="page">${product.name}</li>
                        </ol>
                    </nav>

                    <div class="card shadow-sm border-0 mt-4">
                        <div class="row g-0">
                            <div class="col-md-6 bg-light d-flex align-items-center justify-content-center p-4">
                                <img src="${product.imageUrl}" class="img-fluid rounded shadow-sm" alt="${product.name}"
                                    style="max-height: 400px; object-fit: contain;"
                                    onerror="this.src='https://via.placeholder.com/500x500?text=No+Image'">
                            </div>
                            <div class="col-md-6">
                                <div class="card-body p-5">
                                    <h1 class="card-title fw-bold mb-3">${product.name}</h1>
                                    <div class="mb-4">
                                        <c:choose>
                                            <c:when test="${product.hasDiscount}">
                                                <span
                                                    class="h4 text-muted text-decoration-line-through me-2">$${product.price}</span>
                                                <span
                                                    class="display-5 fw-bold text-danger">$${product.discountedPrice}</span>
                                                <span class="badge bg-danger ms-2 align-top">SALE</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="display-5 fw-bold text-dark">$${product.price}</span>
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="badge bg-success">In Stock</span>
                                    </div>

                                    <p class="card-text text-muted lead mb-4">${product.description}</p>

                                    <hr>

                                    <form action="${pageContext.request.contextPath}/cart" method="post" class="mt-4">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="productId" value="${product.id}">

                                        <div class="row g-3">
                                            <div class="col-sm-4">
                                                <label
                                                    class="form-label small text-uppercase fw-bold text-muted">Quantity</label>
                                                <input type="number" name="quantity" class="form-control" value="1"
                                                    min="1" max="10">
                                            </div>
                                            <div class="col-sm-8 d-flex align-items-end">
                                                <button type="submit" class="btn btn-primary w-100 py-2">
                                                    <i class="bi bi-cart-plus-fill me-2"></i>Add to Cart
                                                </button>
                                            </div>
                                        </div>
                                    </form>

                                    <div class="mt-4 pt-4 border-top">
                                        <div class="d-flex align-items-center text-muted small">
                                            <i class="bi bi-shield-check fs-4 me-2"></i>
                                            <span>Secure checkout provided by JSP Store.</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%@ include file="/WEB-INF/fragments/client-footer.jspf" %>

        </body>

        </html>