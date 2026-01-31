<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <title>Manage Orders | Admin</title>
                <%@ include file="/WEB-INF/fragments/head.jspf" %>
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
            </head>

            <body class="bg-light">

                <div class="d-flex">
                    <!-- Sidebar -->
                    <%@ include file="/WEB-INF/fragments/admin-sidebar.jspf" %>

                        <!-- Main Content -->
                        <div class="flex-grow-1" style="margin-left: 260px;">
                            <%@ include file="/WEB-INF/fragments/admin-topbar.jspf" %>

                                <div class="container-fluid p-4">

                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb small text-uppercase">
                                            <li class="breadcrumb-item"><a
                                                    href="${pageContext.request.contextPath}/admin/dashboard"
                                                    class="text-decoration-none text-muted">Admin</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">Orders</li>
                                        </ol>
                                    </nav>

                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <div>
                                            <h2 class="fw-black text-dark mb-0">Order Management</h2>
                                            <p class="text-muted mb-0">View and manage customer orders.</p>
                                        </div>
                                    </div>

                                    <div class="admin-card">
                                        <div class="table-responsive">
                                            <table class="table align-middle mb-0">
                                                <thead class="bg-light">
                                                    <tr>
                                                        <th
                                                            class="py-3 ps-4 text-uppercase small fw-bold text-muted border-0">
                                                            Order ID</th>
                                                        <th
                                                            class="py-3 text-uppercase small fw-bold text-muted border-0">
                                                            Customer ID</th>
                                                        <th
                                                            class="py-3 text-uppercase small fw-bold text-muted border-0">
                                                            Date</th>
                                                        <th
                                                            class="py-3 text-uppercase small fw-bold text-muted border-0">
                                                            Total</th>
                                                        <th
                                                            class="py-3 text-uppercase small fw-bold text-muted border-0">
                                                            Status</th>
                                                        <th
                                                            class="py-3 text-end pe-4 text-uppercase small fw-bold text-muted border-0">
                                                            Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="order" items="${orders}">
                                                        <tr>
                                                            <td class="ps-4 fw-bold">#${order.id}</td>
                                                            <td>
                                                                <div class="d-flex align-items-center">
                                                                    <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-2"
                                                                        style="width: 32px; height: 32px;">
                                                                        <i class="bi bi-person text-secondary"></i>
                                                                    </div>
                                                                    <!-- Simple User ID display, ideally would enable getting email -->
                                                                    <span>User #${order.userId}</span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <span class="text-muted small">
                                                                    <fmt:formatDate value="${order.createdAt}"
                                                                        pattern="MMM dd, yyyy HH:mm" />
                                                                </span>
                                                            </td>
                                                            <td class="fw-bold">$
                                                                <fmt:formatNumber value="${order.totalAmount}"
                                                                    minFractionDigits="2" maxFractionDigits="2"
                                                                    groupingUsed="false" />
                                                            </td>
                                                            <td>
                                                                <span
                                                                    class="badge ${order.status == 'PENDING' ? 'bg-warning' : (order.status == 'CONFIRMED' ? 'bg-success' : 'bg-secondary')} px-3 py-2">
                                                                    ${order.status}
                                                                </span>
                                                            </td>
                                                            <td class="text-end pe-4">
                                                                <a href="${pageContext.request.contextPath}/admin/orders?action=view&id=${order.id}"
                                                                    class="btn btn-sm btn-outline-primary">
                                                                    <i class="bi bi-pencil-square me-1"></i> Manage
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty orders}">
                                                        <tr>
                                                            <td colspan="6" class="text-center py-5">
                                                                <div class="text-muted">
                                                                    <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                                                    <p>No orders found.</p>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                </div>
                        </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>