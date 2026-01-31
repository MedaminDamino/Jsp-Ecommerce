<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <title>Checkout | JSP Store</title>
            <%@ include file="/WEB-INF/fragments/head.jspf" %>
        </head>

        <body class="bg-light d-flex flex-column min-vh-100">

            <%@ include file="/WEB-INF/fragments/navbar.jspf" %>

                <div class="container py-5 reveal">
                    <div class="d-flex align-items-center mb-5">
                        <div class="bg-primary text-white p-3 rounded-4 me-3 shadow-sm">
                            <i class="bi bi-credit-card-2-front fs-3"></i>
                        </div>
                        <div>
                            <h2 class="fw-black text-dark mb-0">Checkout</h2>
                            <p class="text-muted mb-0 small text-uppercase fw-bold tracking-widest">Complete your order
                            </p>
                        </div>
                    </div>

                    <div class="row g-4">
                        <div class="col-lg-8">
                            <!-- Order Details Card -->
                            <div class="admin-card p-0 overflow-hidden mb-4 border-0 shadow-sm">
                                <div
                                    class="p-4 border-bottom bg-white d-flex align-items-center justify-content-between">
                                    <h6 class="fw-bold mb-0">Review Your Items</h6>
                                    <a href="${pageContext.request.contextPath}/cart"
                                        class="btn btn-link btn-sm text-primary fw-bold text-decoration-none p-0">Edit
                                        Cart</a>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="bg-light">
                                            <tr>
                                                <th class="ps-4 py-3 small text-uppercase text-muted fw-bold border-0">
                                                    Product</th>
                                                <th class="py-3 small text-uppercase text-muted fw-bold border-0">Price
                                                </th>
                                                <th
                                                    class="py-3 small text-uppercase text-muted fw-bold border-0 text-center">
                                                    Qty</th>
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
                                                                style="width: 48px; height: 48px;">
                                                                <img src="${item.product.imageUrl}"
                                                                    class="w-100 h-100 object-fit-cover"
                                                                    onerror="this.src='https://placehold.co/100x100?text=${item.product.name}'"
                                                                    alt="${item.product.name}">
                                                            </div>
                                                            <div>
                                                                <h6 class="fw-bold mb-0 text-dark small">
                                                                    ${item.product.name}</h6>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="py-3 small">
                                                        $${item.product.hasDiscount ? item.product.discountedPrice :
                                                        item.product.price}
                                                    </td>
                                                    <td class="py-3 text-center small fw-bold">${item.quantity}</td>
                                                    <td class="py-3 text-end pe-4 fw-bold text-dark">$${item.total}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Shipping Mockup -->
                            <div class="admin-card p-4 border-0 shadow-sm mb-4">
                                <h6 class="fw-bold mb-3">Shipping Information</h6>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="x-small fw-bold text-uppercase text-muted mb-1">Full Name</label>
                                        <input type="text" class="form-control bg-light border-0 py-2 shadow-none"
                                            value="${sessionScope.user.email.split('@')[0]}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="x-small fw-bold text-uppercase text-muted mb-1">Shipping
                                            Method</label>
                                        <select class="form-select bg-light border-0 py-2 shadow-none">
                                            <option>Standard Shipping (FREE) - 3-5 Days</option>
                                            <option>Express Shipping ($9.99) - 1-2 Days</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="admin-card sticky-top border-0 shadow-sm" style="top: 100px;">
                                <h5 class="fw-black mb-4">Total Amount</h5>

                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Subtotal</span>
                                    <span class="fw-bold">$${grandTotal}</span>
                                </div>
                                <div class="d-flex justify-content-between mb-4 pb-4 border-bottom">
                                    <span class="text-muted">Shipping</span>
                                    <span class="text-success fw-bold">FREE</span>
                                </div>

                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h5 class="fw-black mb-0">Order Total</h5>
                                    <h3 class="fw-black text-primary mb-0">$${grandTotal}</h3>
                                </div>

                                <form action="checkout" method="post">
                                    <button type="submit"
                                        class="btn btn-premium w-100 py-3 rounded-pill fw-bold mb-3 shadow-lg">
                                        <i class="bi bi-shield-check-fill me-2"></i> Place Your Order
                                    </button>
                                </form>

                                <p class="x-small text-muted text-center mb-0">
                                    By placing your order, you agree to our <a href="#"
                                        class="text-primary text-decoration-none">Terms of Service</a>.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <%@ include file="/WEB-INF/fragments/footer.jspf" %>

        </body>

        </html>