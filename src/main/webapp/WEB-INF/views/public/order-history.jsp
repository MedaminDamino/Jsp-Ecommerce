<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <title>My Orders | JSP Store</title>
                <%@ include file="/WEB-INF/fragments/head.jspf" %>
            </head>

            <body class="bg-light d-flex flex-column min-vh-100">

                <%@ include file="/WEB-INF/fragments/navbar.jspf" %>

                    <div class="container py-5 reveal">
                        <div class="d-flex align-items-center mb-5">
                            <div class="bg-primary text-white p-3 rounded-4 me-3 shadow-sm">
                                <i class="bi bi-box-seam fs-3"></i>
                            </div>
                            <div>
                                <h2 class="fw-black text-dark mb-0">My Orders</h2>
                                <p class="text-muted mb-0 small text-uppercase fw-bold tracking-widest">Order History
                                </p>
                            </div>
                        </div>

                        <c:choose>
                            <c:when test="${empty orders}">
                                <div class="text-center py-5 admin-card reveal p-5">
                                    <div class="bg-light p-4 rounded-circle d-inline-block mb-4 shadow-sm"
                                        style="width: 100px; height: 100px;">
                                        <i class="bi bi-bag-x text-muted display-4"></i>
                                    </div>
                                    <h3 class="fw-black text-dark mb-2">No orders yet</h3>
                                    <p class="text-muted mx-auto mb-4" style="max-width: 400px;">You haven't placed any
                                        orders yet. Start shopping and discover amazing products!</p>
                                    <a href="${pageContext.request.contextPath}/home"
                                        class="btn btn-premium rounded-pill px-5">Start Shopping</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="order" items="${orders}">
                                    <div class="admin-card mb-4 p-4">
                                        <!-- Order Header -->
                                        <div
                                            class="d-flex justify-content-between align-items-start mb-3 pb-3 border-bottom">
                                            <div>
                                                <h5 class="fw-bold mb-1">Order #${order.id}</h5>
                                                <p class="text-muted small mb-0">
                                                    <i class="bi bi-calendar me-1"></i>
                                                    <fmt:formatDate value="${order.createdAt}"
                                                        pattern="MMM dd, yyyy 'at' hh:mm a" />
                                                </p>
                                            </div>
                                            <div class="text-end">
                                                <span
                                                    class="badge ${order.status == 'PENDING' ? 'bg-warning' : 'bg-success'} px-3 py-2">
                                                    ${order.status}
                                                </span>
                                                <h5 class="fw-black text-primary mb-0 mt-2">
                                                    $
                                                    <fmt:formatNumber value="${order.totalAmount}" minFractionDigits="2"
                                                        maxFractionDigits="2" groupingUsed="false" />
                                                </h5>
                                            </div>
                                        </div>

                                        <!-- Order Items -->
                                        <div class="table-responsive">
                                            <table class="table table-borderless align-middle mb-0">
                                                <thead class="bg-light">
                                                    <tr>
                                                        <th
                                                            class="ps-3 py-2 small text-uppercase text-muted fw-bold border-0">
                                                            Product</th>
                                                        <th
                                                            class="py-2 small text-uppercase text-muted fw-bold border-0">
                                                            Price</th>
                                                        <th
                                                            class="py-2 small text-uppercase text-muted fw-bold border-0 text-center">
                                                            Quantity</th>
                                                        <th
                                                            class="py-2 small text-uppercase text-muted fw-bold border-0 text-end pe-3">
                                                            Subtotal</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="item" items="${order.items}">
                                                        <tr>
                                                            <td class="ps-3 py-3">
                                                                <div class="d-flex align-items-center">
                                                                    <div class="rounded-3 overflow-hidden border me-3 flex-shrink-0"
                                                                        style="width: 50px; height: 50px;">
                                                                        <img src="${item.productImageUrl}"
                                                                            class="w-100 h-100 object-fit-cover"
                                                                            onerror="this.src='https://placehold.co/50x50?text=${item.productName}'"
                                                                            alt="${item.productName}">
                                                                    </div>
                                                                    <span class="fw-semibold">${item.productName}</span>
                                                                </div>
                                                            </td>
                                                            <td class="py-3">
                                                                <span class="fw-bold">$
                                                                    <fmt:formatNumber value="${item.price}"
                                                                        minFractionDigits="2" maxFractionDigits="2"
                                                                        groupingUsed="false" />
                                                                </span>
                                                            </td>
                                                            <td class="py-3 text-center">
                                                                <span
                                                                    class="badge bg-light text-dark px-3 py-2">${item.quantity}</span>
                                                            </td>
                                                            <td class="py-3 text-end pe-3">
                                                                <span class="fw-bold text-primary">$
                                                                    <fmt:formatNumber
                                                                        value="${item.price * item.quantity}"
                                                                        minFractionDigits="2" maxFractionDigits="2"
                                                                        groupingUsed="false" />
                                                                </span>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <%@ include file="/WEB-INF/fragments/footer.jspf" %>

            </body>

            </html>