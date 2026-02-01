<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <title>Order Confirmed | JSP Store</title>
            <%@ include file="/WEB-INF/fragments/head.jspf" %>
        </head>

        <body class="bg-light d-flex flex-column min-vh-100">

            <%@ include file="/WEB-INF/fragments/navbar.jspf" %>

                <div class="container py-5 flex-grow-1 d-flex align-items-center justify-content-center reveal">
                    <div class="admin-card text-center p-5 shadow-lg border-0 bg-white" style="max-width: 600px;">
                        <div class="bg-success-subtle text-success p-4 rounded-circle d-inline-block mb-4"
                            style="width: 100px; height: 100px;">
                            <i class="bi bi-check-circle-fill display-4"></i>
                        </div>

                        <h2 class="fw-black text-dark mb-2">Order Confirmed!</h2>
                        <p class="text-muted lead mb-4">Thank you for your purchase. Your order <span
                                class="badge bg-light text-dark fw-bold">#${orderId}</span> has been successfully
                            placed.</p>

                        <div class="p-4 bg-light rounded-4 mb-5 text-start">
                            <div class="d-flex align-items-center mb-2">
                                <i class="bi bi-clock-history me-2 text-primary"></i>
                                <span class="small fw-bold text-uppercase text-muted">Estimated Delivery</span>
                            </div>
                            <h6 class="fw-bold mb-0">February 5th - February 7th, 2026</h6>
                            <p class="x-small text-muted mb-0 mt-1">A confirmation email has been sent to your inbox.
                            </p>
                        </div>

                        <div class="d-flex flex-column flex-sm-row gap-3 justify-content-center">
                            <a href="${pageContext.request.contextPath}/home"
                                class="btn btn-premium rounded-pill px-5 py-3 fw-bold">
                                <i class="bi bi-bag-plus me-2"></i> Continue Shopping
                            </a>
                            <a href="#" class="btn btn-light rounded-pill px-5 py-3 fw-bold text-dark">
                                <i class="bi bi-receipt me-2"></i> View Order Details
                            </a>
                        </div>
                    </div>
                </div>

                <%@ include file="/WEB-INF/fragments/footer.jspf" %>

        </body>

        </html>