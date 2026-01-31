<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <title>Checkout - JSP Store</title>
            <%@ include file="/WEB-INF/fragments/head.jspf" %>
        </head>

        <body>

            <%@ include file="/WEB-INF/fragments/client-navbar.jspf" %>

                <div class="container main-content mt-5">
                    <h2 class="mb-4">Checkout</h2>

                    <div class="row">
                        <div class="col-md-8">
                            <div class="card shadow-sm mb-4">
                                <div class="card-header bg-white">
                                    <h5 class="mb-0">Order Summary</h5>
                                </div>
                                <div class="card-body">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Product</th>
                                                <th>Price</th>
                                                <th>Qty</th>
                                                <th class="text-end">Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${cartItems}">
                                                <tr>
                                                    <td>${item.product.name}</td>
                                                    <td>$${item.product.price}</td>
                                                    <td>${item.quantity}</td>
                                                    <td class="text-end fw-bold">$${item.total}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                        <tfoot class="table-light">
                                            <tr>
                                                <td colspan="3" class="text-end fw-bold">Grand Total</td>
                                                <td class="text-end fw-bold text-primary fs-5">$${grandTotal}</td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="card shadow-sm">
                                <div class="card-header bg-white">
                                    <h5 class="mb-0">Payment</h5>
                                </div>
                                <div class="card-body">
                                    <p class="text-muted small">This is a simpler checkout demo. Clicking "Place Order"
                                        will create the order immediately.</p>

                                    <form action="checkout" method="post">
                                        <div class="d-grid">
                                            <button type="submit" class="btn btn-success btn-lg">
                                                <i class="bi bi-check-circle me-2"></i>Place Order
                                            </button>
                                        </div>
                                    </form>

                                    <div class="mt-3 text-center">
                                        <a href="cart.jsp" class="text-decoration-none small text-muted">Back to
                                            Cart</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%@ include file="/WEB-INF/fragments/client-footer.jspf" %>

        </body>

        </html>