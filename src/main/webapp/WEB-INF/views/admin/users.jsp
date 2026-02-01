<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <title>Manage Users | Admin</title>
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
                                            <li class="breadcrumb-item active" aria-current="page">Users</li>
                                        </ol>
                                    </nav>

                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <div>
                                            <h2 class="fw-black text-dark mb-0">User Management</h2>
                                            <p class="text-muted mb-0">Manage customer accounts and roles.</p>
                                        </div>
                                    </div>

                                    <c:if test="${not empty param.error}">
                                        <div class="alert alert-danger border-0 shadow-sm rounded-3 mb-4 d-flex align-items-center"
                                            role="alert">
                                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                            <div>${param.error}</div>
                                        </div>
                                    </c:if>

                                    <div class="admin-card">
                                        <div class="table-responsive">
                                            <table class="table align-middle mb-0">
                                                <thead class="bg-light">
                                                    <tr>
                                                        <th
                                                            class="py-3 ps-4 text-uppercase small fw-bold text-muted border-0">
                                                            User ID</th>
                                                        <th
                                                            class="py-3 text-uppercase small fw-bold text-muted border-0">
                                                            Email</th>
                                                        <th
                                                            class="py-3 text-uppercase small fw-bold text-muted border-0">
                                                            Role</th>
                                                        <th
                                                            class="py-3 text-end pe-4 text-uppercase small fw-bold text-muted border-0">
                                                            Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="user" items="${users}">
                                                        <tr>
                                                            <td class="ps-4 fw-bold">#${user.id}</td>
                                                            <td>
                                                                <div class="d-flex align-items-center">
                                                                    <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-3"
                                                                        style="width: 40px; height: 40px;">
                                                                        <i class="bi bi-person text-secondary"></i>
                                                                    </div>
                                                                    <span
                                                                        class="fw-semibold text-dark">${user.email}</span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <form
                                                                    action="${pageContext.request.contextPath}/admin/users"
                                                                    method="post"
                                                                    class="d-flex align-items-center gap-2">
                                                                    <input type="hidden" name="action"
                                                                        value="update-role">
                                                                    <input type="hidden" name="id" value="${user.id}">
                                                                    <select name="role"
                                                                        class="form-select form-select-sm py-1 border-0 bg-light fw-bold text-secondary shadow-none"
                                                                        style="width: 130px; font-size: 0.8rem;"
                                                                        ${user.id==sessionScope.user.id ? 'disabled'
                                                                        : '' }>
                                                                        <option value="CUSTOMER" ${user.role=='CUSTOMER'
                                                                            ? 'selected' : '' }>CUSTOMER</option>
                                                                        <option value="ADMIN" ${user.role=='ADMIN'
                                                                            ? 'selected' : '' }>ADMIN</option>
                                                                    </select>
                                                                    <button type="submit"
                                                                        class="btn btn-sm btn-light border p-1 px-2 text-primary"
                                                                        data-bs-toggle="tooltip" title="Update Role"
                                                                        ${user.id==sessionScope.user.id ? 'disabled'
                                                                        : '' }>
                                                                        <i class="bi bi-check-lg"></i>
                                                                    </button>
                                                                </form>
                                                            </td>
                                                            <td class="text-end pe-4">
                                                                <a href="${pageContext.request.contextPath}/admin/users?action=delete&id=${user.id}"
                                                                    class="btn btn-sm btn-outline-danger border-0 p-2"
                                                                    onclick="return confirm('Are you sure you want to delete this user?');"
                                                                    data-bs-toggle="tooltip" title="Delete User">
                                                                    <i class="bi bi-trash fs-6"></i>
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty users}">
                                                        <tr>
                                                            <td colspan="4" class="text-center py-5">
                                                                <div class="text-muted">
                                                                    <i class="bi bi-people fs-1 d-block mb-2"></i>
                                                                    <p>No users found.</p>
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