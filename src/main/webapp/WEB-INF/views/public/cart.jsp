<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
            <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <title>Your Cart | JSP Store</title>
                    <%@ include file="/WEB-INF/fragments/head.jspf" %>
                </head>

                <body class="bg-light d-flex flex-column min-vh-100">

                    <%@ include file="/WEB-INF/fragments/navbar.jspf" %>

                        <div class="container py-5 reveal">
                            <div class="d-flex align-items-center mb-5">
                                <div class="bg-primary text-white p-3 rounded-4 me-3 shadow-sm">
                                    <i class="bi bi-cart3 fs-3"></i>
                                </div>
                                <div>
                                    <h2 class="fw-black text-dark mb-0">Shopping Cart</h2>
                                    <p class="text-muted mb-0 small text-uppercase fw-bold tracking-widest">Review your
                                        selected items</p>
                                </div>
                            </div>

                            <c:choose>
                                <c:when test="${empty cartItems}">
                                    <div class="text-center py-5 admin-card reveal p-5">
                                        <div class="bg-light p-4 rounded-circle d-inline-block mb-4 shadow-sm"
                                            style="width: 100px; height: 100px;">
                                            <i class="bi bi-bag-x text-muted display-4"></i>
                                        </div>
                                        <h3 class="fw-black text-dark mb-2">Your cart is empty</h3>
                                        <p class="text-muted mx-auto mb-4" style="max-width: 400px;">Looks like you
                                            haven't
                                            added anything to your cart yet. Explore our latest arrivals and find
                                            something
                                            you love!</p>
                                        <a href="${pageContext.request.contextPath}/home"
                                            class="btn btn-premium rounded-pill px-5">Start Shopping</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="row g-4">
                                        <!-- Cart Items List -->
                                        <div class="col-lg-8">
                                            <div class="admin-card p-0 overflow-hidden mb-4">
                                                <div class="p-4 border-bottom bg-white">
                                                    <h6 class="fw-bold mb-0">Cart Items (${fn:length(cartItems)})</h6>
                                                </div>
                                                <div class="table-responsive">
                                                    <table class="table table-hover align-middle mb-0">
                                                        <thead class="bg-light">
                                                            <tr>
                                                                <th
                                                                    class="ps-4 py-3 small text-uppercase text-muted fw-bold border-0">
                                                                    Product</th>
                                                                <th
                                                                    class="py-3 small text-uppercase text-muted fw-bold border-0">
                                                                    Price</th>
                                                                <th class="py-3 small text-uppercase text-muted fw-bold border-0 text-center"
                                                                    style="width: 150px;">Quantity</th>
                                                                <th
                                                                    class="py-3 small text-uppercase text-muted fw-bold border-0 text-end pe-4">
                                                                    Total</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody class="border-top-0">
                                                            <c:forEach var="item" items="${cartItems}">
                                                                <tr>
                                                                    <td class="ps-4 py-4">
                                                                        <div class="d-flex align-items-center">
                                                                            <div class="rounded-3 overflow-hidden border me-3 flex-shrink-0"
                                                                                style="width: 64px; height: 64px;">
                                                                                <img src="${item.product.imageUrl}"
                                                                                    class="w-100 h-100 object-fit-cover"
                                                                                    onerror="this.src='https://placehold.co/100x100?text=${item.product.name}'"
                                                                                    alt="${item.product.name}">
                                                                            </div>
                                                                            <div>
                                                                                <h6 class="fw-bold mb-0 text-dark">
                                                                                    ${item.product.name}</h6>
                                                                                <form
                                                                                    action="${pageContext.request.contextPath}/cart"
                                                                                    method="post" class="mt-1">
                                                                                    <input type="hidden" name="action"
                                                                                        value="remove">
                                                                                    <input type="hidden"
                                                                                        name="productId"
                                                                                        value="${item.product.id}">
                                                                                    <button type="submit"
                                                                                        class="btn p-0 text-danger x-small fw-bold border-0 bg-transparent">
                                                                                        <i
                                                                                            class="bi bi-trash3 me-1"></i>
                                                                                        Remove
                                                                                    </button>
                                                                                </form>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td class="py-4">
                                                                        <c:choose>
                                                                            <c:when test="${item.product.hasDiscount}">
                                                                                <div class="fw-bold text-dark">
                                                                                    $${item.product.discountedPrice}
                                                                                </div>
                                                                                <small
                                                                                    class="text-muted text-decoration-line-through">$${item.product.price}</small>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div class="fw-bold text-dark">
                                                                                    $${item.product.price}</div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td class="py-4 text-center">
                                                                        <form
                                                                            action="${pageContext.request.contextPath}/cart"
                                                                            method="post"
                                                                            class="d-flex align-items-center justify-content-center">
                                                                            <input type="hidden" name="action"
                                                                                value="update">
                                                                            <input type="hidden" name="productId"
                                                                                value="${item.product.id}">
                                                                            <input type="number" name="quantity"
                                                                                value="${item.quantity}" min="1"
                                                                                max="99"
                                                                                class="form-control form-control-sm text-center fw-bold shadow-none"
                                                                                style="width: 60px; border-radius: 8px;"
                                                                                onchange="this.form.submit()">
                                                                        </form>
                                                                    </td>
                                                                    <td
                                                                        class="py-4 text-end pe-4 fw-black text-primary fs-5">
                                                                        <fmt:formatNumber value="${(item.product.hasDiscount ?
                                                                        item.product.discountedPrice :
                                                                        item.product.price) *
                                                                        item.quantity}" type="currency"
                                                                            currencySymbol="$" maxFractionDigits="2"
                                                                            minFractionDigits="2" />
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <a href="${pageContext.request.contextPath}/home"
                                                class="btn btn-light rounded-pill px-4 btn-sm fw-bold">
                                                <i class="bi bi-arrow-left me-2"></i> Continue Shopping
                                            </a>
                                        </div>

                                        <!-- Summary Card -->
                                        <div class="col-lg-4">
                                            <div class="admin-card sticky-top p-4" style="top: 100px;">
                                                <h5 class="fw-black mb-4">Order Summary</h5>

                                                <div class="d-flex justify-content-between mb-3">
                                                    <span class="text-muted">Subtotal</span>
                                                    <span class="fw-bold">$
                                                        <fmt:formatNumber value="${cartTotal}" minFractionDigits="2"
                                                            maxFractionDigits="2" groupingUsed="false" />
                                                    </span>
                                                </div>
                                                <div class="d-flex justify-content-between mb-4 pb-4 border-bottom">
                                                    <span class="text-muted">Shipping</span>
                                                    <span class="text-success fw-bold">FREE</span>
                                                </div>

                                                <div
                                                    class="d-flex justify-content-between align-items-center mb-4 pt-3">
                                                    <h5 class="fw-black mb-0">Total</h5>
                                                    <h3 class="fw-black text-primary mb-0">$
                                                        <fmt:formatNumber value="${cartTotal}" minFractionDigits="2"
                                                            maxFractionDigits="2" groupingUsed="false" />
                                                    </h3>
                                                </div>

                                                <a href="${pageContext.request.contextPath}/checkout"
                                                    class="btn btn-premium w-100 py-3 rounded-pill fw-bold mb-3 shadow-lg">
                                                    <i class="bi bi-shield-check me-2"></i> Proceed to Checkout
                                                </a>

                                                <div class="text-center">
                                                    <p class="x-small text-muted mb-0">
                                                        <i class="bi bi-lock-fill me-1"></i> Secure 256-bit SSL
                                                        Encrypted
                                                        Payment
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <%@ include file="/WEB-INF/fragments/footer.jspf" %>

                </body>

                </html>