<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <title>Products | Admin Dashboard</title>
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
                                        <h2 class="fw-bold mb-1">Product Management</h2>
                                        <p class="text-muted small mb-0">Manage your store inventory and details</p>
                                    </div>
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb mb-0">
                                            <li class="breadcrumb-item"><a href="#"
                                                    class="text-decoration-none">Admin</a></li>
                                            <li class="breadcrumb-item active">Products</li>
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
                                        <i class="bi bi-exclamation-octagon-fill me-2"></i>${param.error}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>

                                <div class="row g-4">
                                    <!-- Add Product Form -->
                                    <div class="col-lg-4">
                                        <div class="admin-card">
                                            <div class="card-header d-flex align-items-center">
                                                <i class="bi bi-plus-circle-fill text-primary me-2 fs-5"></i>
                                                <h5 class="card-title mb-0">Add New Product</h5>
                                            </div>
                                            <div class="card-body p-4">
                                                <form action="${pageContext.request.contextPath}/admin/products"
                                                    method="post" enctype="multipart/form-data">
                                                    <input type="hidden" name="action" value="add">

                                                    <div class="mb-3">
                                                        <label
                                                            class="form-label fw-semibold small text-uppercase text-muted">Product
                                                            Name</label>
                                                        <input type="text" name="name" class="form-control"
                                                            placeholder="e.g. Wireless Mouse" required>
                                                    </div>

                                                    <div class="row g-3 mb-3">
                                                        <div class="col-md-6">
                                                            <label
                                                                class="form-label fw-semibold small text-uppercase text-muted">Price
                                                                ($)</label>
                                                            <div class="input-group">
                                                                <span class="input-group-text bg-light border-end-0"><i
                                                                        class="bi bi-currency-dollar small"></i></span>
                                                                <input type="number" step="0.01" name="price"
                                                                    class="form-control border-start-0"
                                                                    placeholder="0.00" required>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label
                                                                class="form-label fw-semibold small text-uppercase text-muted">Category</label>
                                                            <select name="categoryId" class="form-select" required>
                                                                <option value="" selected disabled>Select Category
                                                                </option>
                                                                <c:forEach var="cat" items="${categories}">
                                                                    <option value="${cat.id}">${cat.name}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label
                                                            class="form-label fw-semibold small text-uppercase text-muted">Product
                                                            Image</label>
                                                        <input type="file" name="imageFile" class="form-control"
                                                            accept="image/*">
                                                        <small class="text-muted" style="font-size: 0.7rem;">Saved
                                                            locally in project assets</small>
                                                    </div>

                                                    <div class="mb-4">
                                                        <label
                                                            class="form-label fw-semibold small text-uppercase text-muted">Description
                                                            (Optional)</label>
                                                        <textarea name="description" class="form-control" rows="3"
                                                            placeholder="Brief product summary..."></textarea>
                                                    </div>

                                                    <div class="d-grid">
                                                        <button type="submit" class="btn btn-primary py-2 fw-semibold">
                                                            <i class="bi bi-cloud-upload me-2"></i>Publish Product
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Product List -->
                                    <div class="col-lg-8">
                                        <div class="admin-card h-100">
                                            <div class="card-header d-flex justify-content-between align-items-center">
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-stack text-primary me-2 fs-5"></i>
                                                    <h5 class="card-title mb-0">Catalog Inventory</h5>
                                                </div>
                                                <span
                                                    class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-2 rounded-pill small fw-bold">
                                                    <c:out value="${productList.size()}" /> Products Total
                                                </span>
                                            </div>
                                            <div class="card-body p-0">
                                                <div class="table-responsive">
                                                    <table class="table table-hover admin-table align-middle mb-0">
                                                        <thead>
                                                            <tr>
                                                                <th class="ps-4">Product</th>
                                                                <th>Category</th>
                                                                <th>Price</th>
                                                                <th class="text-end pe-4">Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="p" items="${productList}">
                                                                <tr>
                                                                    <td class="ps-4">
                                                                        <div class="d-flex align-items-center">
                                                                            <div class="bg-light rounded p-1 me-3"
                                                                                style="width: 48px; height: 48px;">
                                                                                <img src="${p.imageUrl}"
                                                                                    class="rounded w-100 h-100 object-fit-cover"
                                                                                    onerror="this.src='https://placehold.co/100x100?text=No+Img'">
                                                                            </div>
                                                                            <div>
                                                                                <div class="fw-bold text-dark mb-0">
                                                                                    ${p.name}</div>
                                                                                <small
                                                                                    class="text-muted d-block text-truncate"
                                                                                    style="max-width: 200px;">${p.description}</small>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <span
                                                                            class="badge bg-light text-dark border px-2 py-1">ID:
                                                                            ${p.categoryId}</span>
                                                                    </td>
                                                                    <td>
                                                                        <span
                                                                            class="fw-bold text-primary">$${p.price}</span>
                                                                    </td>
                                                                    <td class="text-end pe-4">
                                                                        <div class="d-flex justify-content-end gap-2">
                                                                            <button type="button"
                                                                                class="btn btn-action btn-outline-primary"
                                                                                data-bs-toggle="modal"
                                                                                data-bs-target="#editProductModal"
                                                                                onclick="populateEditModal('${p.id}', '${p.name}', '${p.price}', '${p.categoryId}', '${p.imageUrl}', `${p.description}`)">
                                                                                <i class="bi bi-pencil-square"></i>
                                                                            </button>
                                                                            <form
                                                                                action="${pageContext.request.contextPath}/admin/products"
                                                                                method="post">
                                                                                <input type="hidden" name="action"
                                                                                    value="delete">
                                                                                <input type="hidden" name="id"
                                                                                    value="${p.id}">
                                                                                <button type="submit"
                                                                                    class="btn btn-action btn-outline-danger"
                                                                                    onclick="return confirm('Delete this product permanently?');">
                                                                                    <i class="bi bi-trash3"></i>
                                                                                </button>
                                                                            </form>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                            <c:if test="${empty productList}">
                                                                <tr>
                                                                    <td colspan="4" class="text-center py-5 text-muted">
                                                                        <i
                                                                            class="bi bi-inbox fs-1 d-block mb-3 opacity-25"></i>
                                                                        No products found in inventory.
                                                                    </td>
                                                                </tr>
                                                            </c:if>
                                                        </tbody>
                                                    </table>
                                                </div>

                                                <!-- Pagination Controls -->
                                                <div class="card-footer bg-white border-0 py-3">
                                                    <nav aria-label="Product pagination">
                                                        <ul class="pagination pagination-sm justify-content-end mb-0">
                                                            <%-- Previous Page --%>
                                                                <li
                                                                    class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                                    <a class="page-link border-0 text-muted"
                                                                        href="?page=${currentPage - 1}" ${currentPage==1
                                                                        ? 'tabindex="-1" aria-disabled="true"' : '' }>
                                                                        <i class="bi bi-chevron-left"></i>
                                                                    </a>
                                                                </li>

                                                                <%-- Page Numbers --%>
                                                                    <c:if test="${totalPages > 0}">
                                                                        <c:forEach begin="1" end="${totalPages}"
                                                                            var="i">
                                                                            <c:choose>
                                                                                <c:when test="${i == currentPage}">
                                                                                    <li class="page-item active"
                                                                                        aria-current="page">
                                                                                        <span
                                                                                            class="page-link bg-primary border-primary">${i}</span>
                                                                                    </li>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <li class="page-item">
                                                                                        <a class="page-link border-0 text-dark"
                                                                                            href="?page=${i}">${i}</a>
                                                                                    </li>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </c:forEach>
                                                                    </c:if>

                                                                    <%-- Next Page --%>
                                                                        <li
                                                                            class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                                            <a class="page-link border-0 text-muted"
                                                                                href="?page=${currentPage + 1}"
                                                                                ${currentPage==totalPages
                                                                                ? 'tabindex="-1" aria-disabled="true"'
                                                                                : '' }>
                                                                                <i class="bi bi-chevron-right"></i>
                                                                            </a>
                                                                        </li>
                                                        </ul>
                                                    </nav>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Edit Product Modal -->
                            <div class="modal fade" id="editProductModal" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content border-0 shadow-lg">
                                        <div class="modal-header bg-primary text-white p-4">
                                            <h5 class="modal-title fw-bold"><i class="bi bi-pencil-square me-2"></i>Edit
                                                Product Details
                                            </h5>
                                            <button type="button" class="btn-close btn-close-white"
                                                data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body p-4">
                                            <form action="${pageContext.request.contextPath}/admin/products"
                                                method="post" enctype="multipart/form-data">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="id" id="edit-id">
                                                <input type="hidden" name="oldImageUrl" id="edit-old-image">

                                                <div class="mb-3">
                                                    <label
                                                        class="form-label fw-semibold small text-uppercase text-muted">Product
                                                        Name</label>
                                                    <input type="text" name="name" id="edit-name" class="form-control"
                                                        required>
                                                </div>

                                                <div class="row g-3 mb-3">
                                                    <div class="col-md-6">
                                                        <label
                                                            class="form-label fw-semibold small text-uppercase text-muted">Price
                                                            ($)</label>
                                                        <input type="number" step="0.01" name="price" id="edit-price"
                                                            class="form-control" required>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label
                                                            class="form-label fw-semibold small text-uppercase text-muted">Category</label>
                                                        <select name="categoryId" id="edit-category" class="form-select"
                                                            required>
                                                            <option value="" disabled>Select Category</option>
                                                            <c:forEach var="cat" items="${categories}">
                                                                <option value="${cat.id}">${cat.name}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="mb-3">
                                                    <label
                                                        class="form-label fw-semibold small text-uppercase text-muted">New
                                                        Image
                                                        (Optional)</label>
                                                    <input type="file" name="imageFile" class="form-control"
                                                        accept="image/*">
                                                    <small class="text-muted d-block mt-1">Leave empty to keep current
                                                        image</small>
                                                </div>

                                                <div class="mb-4">
                                                    <label
                                                        class="form-label fw-semibold small text-uppercase text-muted">Description
                                                        (Optional)</label>
                                                    <textarea name="description" id="edit-description"
                                                        class="form-control" rows="3"></textarea>
                                                </div>

                                                <div class="d-grid">
                                                    <button type="submit" class="btn btn-primary py-2 fw-semibold">Save
                                                        Changes</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <script
                                src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                            <script>
                                function populateEditModal(id, name, price, category, image, description) {
                                    document.getElementById('edit-id').value = id;
                                    document.getElementById('edit-name').value = name;
                                    document.getElementById('edit-price').value = price;
                                    document.getElementById('edit-category').value = category;
                                    document.getElementById('edit-old-image').value = image;
                                    document.getElementById('edit-description').value = description;
                                }
                            </script>
        </body>

        </html>