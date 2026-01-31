<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <title>Order #${order.id} | Admin</title>
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
                                            <li class="breadcrumb-item"><a
                                                    href="${pageContext.request.contextPath}/admin/orders"
                                                    class="text-decoration-none text-muted">Orders</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">Order #${order.id}
                                            </li>
                                        </ol>
                                    </nav>

                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <div>
                                            <h2 class="fw-black text-dark mb-0">Order Details: #${order.id}</h2>
                                            <p class="text-muted mb-0">Manage items and confirm order.</p>
                                        </div>
                                        <div>
                                            <c:if test="${order.status == 'PENDING'}">
                                                <form action="${pageContext.request.contextPath}/admin/orders"
                                                    method="post" class="d-inline">
                                                    <input type="hidden" name="action" value="update-status">
                                                    <input type="hidden" name="id" value="${order.id}">
                                                    <input type="hidden" name="status" value="CONFIRMED">
                                                    <button type="submit"
                                                        class="btn btn-success fw-bold px-4 rounded-pill">
                                                        <i class="bi bi-check-lg me-2"></i> Confirm Order
                                                    </button>
                                                </form>
                                            </c:if>
                                            <c:if test="${order.status == 'CONFIRMED'}">
                                                <button class="btn btn-secondary fw-bold px-4 rounded-pill" disabled>
                                                    <i class="bi bi-check-all me-2"></i> Order Confirmed
                                                </button>
                                            </c:if>
                                        </div>
                                    </div>

                                    <!-- Order Info Card -->
                                    <div class="row g-4 mb-4">
                                        <div class="col-md-8">
                                            <div class="admin-card h-100">
                                                <h5 class="fw-bold mb-4 border-bottom pb-3">Items Ordered</h5>
                                                <div class="table-responsive">
                                                    <table class="table align-middle mb-0">
                                                        <thead class="bg-light">
                                                            <tr>
                                                                <th class="ps-3 py-2 small fw-bold text-muted border-0">
                                                                    Product</th>
                                                                <th class="py-2 small fw-bold text-muted border-0">Price
                                                                </th>
                                                                <th
                                                                    class="py-2 small fw-bold text-muted border-0 text-center">
                                                                    Qty</th>
                                                                <th
                                                                    class="py-2 small fw-bold text-muted border-0 text-end">
                                                                    Subtotal</th>
                                                                <th
                                                                    class="py-2 small fw-bold text-muted border-0 text-end pe-3">
                                                                    Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="item" items="${order.items}">
                                                                <tr>
                                                                    <td class="ps-3">
                                                                        <div class="d-flex align-items-center">
                                                                            <div class="rounded bg-light border me-3 flex-shrink-0"
                                                                                style="width: 48px; height: 48px; overflow: hidden;">
                                                                                <img src="${item.productImageUrl}"
                                                                                    alt="${item.productName}"
                                                                                    class="w-100 h-100 object-fit-cover">
                                                                            </div>
                                                                            <span
                                                                                class="fw-semibold">${item.productName}</span>
                                                                        </div>
                                                                    </td>
                                                                    <td>$
                                                                        <fmt:formatNumber value="${item.price}"
                                                                            minFractionDigits="2" maxFractionDigits="2"
                                                                            groupingUsed="false" />
                                                                    </td>
                                                                    <td class="text-center">
                                                                        <span
                                                                            class="badge bg-light text-dark border px-3">${item.quantity}</span>
                                                                    </td>
                                                                    <td class="text-end fw-bold text-primary">
                                                                        $
                                                                        <fmt:formatNumber
                                                                            value="${item.price * item.quantity}"
                                                                            minFractionDigits="2" maxFractionDigits="2"
                                                                            groupingUsed="false" />
                                                                    </td>
                                                                    <td class="text-end pe-3">
                                                                        <form
                                                                            action="${pageContext.request.contextPath}/admin/orders"
                                                                            method="post"
                                                                            onsubmit="return confirm('Remove this item?');">
                                                                            <input type="hidden" name="action"
                                                                                value="remove-item">
                                                                            <input type="hidden" name="orderId"
                                                                                value="${order.id}">
                                                                            <input type="hidden" name="itemId"
                                                                                value="${item.id}">
                                                                            <button type="submit"
                                                                                class="btn btn-sm btn-outline-danger border-0 p-1 px-2"
                                                                                data-bs-toggle="tooltip"
                                                                                title="Remove Item">
                                                                                <i class="bi bi-trash"></i>
                                                                            </button>
                                                                        </form>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>

                                                <!-- Add Item Section -->
                                                <div class="mt-4 pt-4 border-top">
                                                    <h6 class="fw-bold mb-3"><i class="bi bi-plus-circle me-2"></i>Add
                                                        Product to Order</h6>
                                                    <form action="${pageContext.request.contextPath}/admin/orders"
                                                        method="post" class="row g-3 align-items-end">
                                                        <input type="hidden" name="action" value="add-item">
                                                        <input type="hidden" name="orderId" value="${order.id}">

                                                        <div class="col-md-6">
                                                            <label
                                                                class="form-label small text-muted text-uppercase fw-bold">Select
                                                                Product</label>
                                                            <select name="productId"
                                                                class="form-select bg-light border-0" required>
                                                                <option value="" selected disabled>Choose a product...
                                                                </option>
                                                                <c:forEach var="prod" items="${products}">
                                                                    <option value="${prod.id}">
                                                                        ${prod.name} ($
                                                                        <fmt:formatNumber value="${prod.price}"
                                                                            minFractionDigits="2" maxFractionDigits="2"
                                                                            groupingUsed="false" />)
                                                                    </option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <label
                                                                class="form-label small text-muted text-uppercase fw-bold">Quantity</label>
                                                            <input type="number" name="quantity"
                                                                class="form-control bg-light border-0" min="1" value="1"
                                                                required>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <button type="submit"
                                                                class="btn btn-primary w-100 fw-bold">Add Item</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Summary Sidebar -->
                                        <div class="col-md-4">
                                            <div class="admin-card mb-4">
                                                <h5 class="fw-bold mb-4 border-bottom pb-3">Order Info</h5>

                                                <div class="mb-3">
                                                    <label class="small text-muted text-uppercase fw-bold">Order
                                                        Status</label>
                                                    <div class="mt-1">
                                                        <span
                                                            class="badge ${order.status == 'PENDING' ? 'bg-warning' : (order.status == 'CONFIRMED' ? 'bg-success' : 'bg-secondary')} px-3 py-2 fs-6">
                                                            ${order.status}
                                                        </span>
                                                    </div>
                                                </div>

                                                <div class="mb-3">
                                                    <label class="small text-muted text-uppercase fw-bold">Date
                                                        Placed</label>
                                                    <p class="fw-semibold mb-0">
                                                        <fmt:formatDate value="${order.createdAt}"
                                                            pattern="MMM dd, yyyy HH:mm:ss" />
                                                    </p>
                                                </div>

                                                <div class="mb-3">
                                                    <label class="small text-muted text-uppercase fw-bold">User
                                                        ID</label>
                                                    <p class="fw-semibold mb-0">Customer #${order.userId}</p>
                                                </div>
                                            </div>

                                            <div class="admin-card bg-primary text-white">
                                                <h5 class="fw-bold mb-4 border-bottom border-white pb-3 opacity-75">
                                                    Payment Summary</h5>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <span class="fs-5 opacity-75">Total Amount</span>
                                                    <span class="display-6 fw-bold">$
                                                        <fmt:formatNumber value="${order.totalAmount}"
                                                            minFractionDigits="2" maxFractionDigits="2"
                                                            groupingUsed="false" />
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                        </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>