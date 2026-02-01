<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <title>Categories | Admin Dashboard</title>
            <%@ include file="/WEB-INF/fragments/head.jspf" %>
        </head>

        <body>

            <div class="d-flex">
                <!-- Sidebar -->
                <%@ include file="/WEB-INF/fragments/admin-sidebar.jspf" %>

                    <!-- Main Content -->
                    <div class="main-wrapper">
                        <%@ include file="/WEB-INF/fragments/admin-topbar.jspf" %>

                            <div class="container-fluid p-4 fade-in">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <div>
                                        <h2 class="fw-bold mb-1">Category Management</h2>
                                        <p class="text-muted small mb-0">Organize your product catalog into groups</p>
                                    </div>
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb mb-0">
                                            <li class="breadcrumb-item"><a href="#"
                                                    class="text-decoration-none">Admin</a></li>
                                            <li class="breadcrumb-item active">Categories</li>
                                        </ol>
                                    </nav>
                                </div>

                                <c:if test="${not empty param.success}">
                                    <div class="alert alert-success border-0 shadow-sm alert-dismissible fade show"
                                        role="alert">
                                        <i class="bi bi-check-circle-fill me-2"></i>${param.success}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>
                                <c:if test="${not empty param.error}">
                                    <div class="alert alert-danger border-0 shadow-sm alert-dismissible fade show"
                                        role="alert">
                                        <i class="bi bi-exclamation-triangle-fill me-2"></i>${param.error}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>

                                <div class="row g-4">
                                    <!-- Add Category Card -->
                                    <div class="col-lg-4">
                                        <div class="admin-card">
                                            <div class="card-header d-flex align-items-center">
                                                <i class="bi bi-plus-square-fill text-primary me-2 fs-5"></i>
                                                <h5 class="card-title mb-0">Quick Add</h5>
                                            </div>
                                            <div class="card-body p-4">
                                                <form action="${pageContext.request.contextPath}/admin/categories"
                                                    method="post">
                                                    <input type="hidden" name="action" value="add">
                                                    <div class="mb-4">
                                                        <label
                                                            class="form-label fw-semibold small text-uppercase text-muted">Category
                                                            Name</label>
                                                        <input type="text" name="name"
                                                            class="form-control form-control-lg"
                                                            placeholder="e.g. Home Decor" required>
                                                    </div>
                                                    <div class="d-grid">
                                                        <button class="btn btn-primary py-2 fw-semibold" type="submit">
                                                            <i class="bi bi-save me-2"></i>Create Category
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Category List Table -->
                                    <div class="col-lg-8">
                                        <div class="admin-card">
                                            <div class="card-header d-flex align-items-center">
                                                <i class="bi bi-tags-fill text-primary me-2 fs-5"></i>
                                                <h5 class="card-title mb-0">Existing Categories</h5>
                                            </div>
                                            <div class="card-body p-0">
                                                <div class="table-responsive">
                                                    <table class="table table-hover admin-table align-middle mb-0">
                                                        <thead>
                                                            <tr>
                                                                <th class="ps-4" style="width: 100px;">ID</th>
                                                                <th>Category Detail</th>
                                                                <th class="text-end pe-4">Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="cat" items="${categories}">
                                                                <tr>
                                                                    <td class="ps-4">
                                                                        <span
                                                                            class="badge bg-light text-dark border">#${cat.id}</span>
                                                                    </td>
                                                                    <td>
                                                                        <form
                                                                            action="${pageContext.request.contextPath}/admin/categories"
                                                                            method="post" class="d-flex gap-2">
                                                                            <input type="hidden" name="action"
                                                                                value="update">
                                                                            <input type="hidden" name="id"
                                                                                value="${cat.id}">
                                                                            <input type="text" name="name"
                                                                                value="${cat.name}"
                                                                                class="form-control form-control-sm border-0 bg-light-subtle px-3"
                                                                                required>
                                                                            <button type="submit"
                                                                                class="btn btn-sm btn-link text-decoration-none fw-bold p-0">Update</button>
                                                                        </form>
                                                                    </td>
                                                                    <td class="text-end pe-4">
                                                                        <form
                                                                            action="${pageContext.request.contextPath}/admin/categories"
                                                                            method="post">
                                                                            <input type="hidden" name="action"
                                                                                value="delete">
                                                                            <input type="hidden" name="id"
                                                                                value="${cat.id}">
                                                                            <button type="submit"
                                                                                class="btn btn-action btn-outline-danger"
                                                                                onclick="return confirm('Delete this category? This might affect products.');">
                                                                                <i class="bi bi-trash-fill"></i>
                                                                            </button>
                                                                        </form>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                            <c:if test="${empty categories}">
                                                                <tr>
                                                                    <td colspan="3" class="text-center py-5 text-muted">
                                                                        No categories created yet.</td>
                                                                </tr>
                                                            </c:if>
                                                        </tbody>
                                                    </table>
                                                </div>
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