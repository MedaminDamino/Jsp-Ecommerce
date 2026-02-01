<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <title>Promotions | Admin Dashboard</title>
            <%@ include file="/WEB-INF/fragments/head.jspf" %>
                <!-- TomSelect for better dropdowns -->
                <link href="https://cdn.jsdelivr.net/npm/tom-select@2.2.2/dist/css/tom-select.bootstrap5.min.css"
                    rel="stylesheet">
                <script src="https://cdn.jsdelivr.net/npm/tom-select@2.2.2/dist/js/tom-select.complete.min.js"></script>
                <style>
                    .ts-control {
                        border-radius: 0.5rem !important;
                        border-color: #dee2e6 !important;
                        padding: 0.6rem 0.75rem !important;
                    }

                    .ts-dropdown {
                        border-radius: 0.5rem !important;
                        margin-top: 5px !important;
                        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1) !important;
                        border: 0 !important;
                    }
                </style>
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
                                        <h2 class="fw-bold mb-1">Promotion Campaigns</h2>
                                        <p class="text-muted small mb-0">Boost sales with discounts and offers</p>
                                    </div>
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb mb-0">
                                            <li class="breadcrumb-item"><a href="#"
                                                    class="text-decoration-none">Admin</a></li>
                                            <li class="breadcrumb-item active">Promotions</li>
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

                                <div class="row g-4">
                                    <!-- Create Promotion Card -->
                                    <div class="col-lg-4">
                                        <div class="admin-card">
                                            <div class="card-header d-flex align-items-center">
                                                <i class="bi bi-lightning-charge-fill text-warning me-2 fs-5"></i>
                                                <h5 class="card-title mb-0">Launch Campaign</h5>
                                            </div>
                                            <div class="card-body p-4">
                                                <form action="${pageContext.request.contextPath}/admin/promotions"
                                                    method="post">
                                                    <input type="hidden" name="action" value="add">
                                                    <div class="mb-3">
                                                        <label
                                                            class="form-label fw-semibold small text-uppercase text-muted">Campaign
                                                            Title</label>
                                                        <input type="text" name="title" class="form-control"
                                                            placeholder="e.g. Winter Clearance" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label
                                                            class="form-label fw-semibold small text-uppercase text-muted">Brief
                                                            Description</label>
                                                        <textarea name="description" class="form-control" rows="2"
                                                            placeholder="Details about the offer..."
                                                            required></textarea>
                                                    </div>
                                                    <div class="row g-3">
                                                        <div class="col-md-6 mb-3">
                                                            <label
                                                                class="form-label fw-semibold small text-uppercase text-muted">Type</label>
                                                            <select name="discountType" class="form-select">
                                                                <option value="PERCENTAGE">Percentage (%)</option>
                                                                <option value="FIXED">Fixed ($)</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-6 mb-3">
                                                            <label
                                                                class="form-label fw-semibold small text-uppercase text-muted">Value</label>
                                                            <input type="number" step="0.1" name="discountValue"
                                                                class="form-control" required>
                                                        </div>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label
                                                            class="form-label fw-semibold small text-uppercase text-muted">Applicable
                                                            Products</label>
                                                        <select name="productIds" class="tom-select-products" multiple
                                                            placeholder="Search products...">
                                                            <c:forEach var="prod" items="${products}">
                                                                <option value="${prod.id}">${prod.name} ($${prod.price})
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label
                                                            class="form-label fw-semibold small text-uppercase text-muted">Expires
                                                            On</label>
                                                        <input type="date" name="endDate" class="form-control" required>
                                                    </div>
                                                    <div class="form-check form-switch mb-4">
                                                        <input class="form-check-input" type="checkbox" name="active"
                                                            checked id="activeSwitch">
                                                        <label
                                                            class="form-check-label fw-semibold small text-muted text-uppercase ms-2"
                                                            for="activeSwitch">Active immediately</label>
                                                    </div>
                                                    <div class="d-grid">
                                                        <button type="submit" class="btn btn-primary py-2 fw-semibold">
                                                            <i class="bi bi-send-fill me-2"></i>Apply Promotion
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Promotions Display -->
                                    <div class="col-lg-8">
                                        <div class="row g-3">
                                            <c:forEach var="promo" items="${promotions}">
                                                <div class="col-md-6">
                                                    <div class="admin-card h-100 overflow-hidden">
                                                        <div class="card-body p-4">
                                                            <div
                                                                class="d-flex justify-content-between align-items-start mb-3">
                                                                <div>
                                                                    <h5 class="fw-bold text-dark mb-1">${promo.title}
                                                                    </h5>
                                                                    <span
                                                                        class="badge ${promo.active ? 'bg-success-subtle text-success' : 'bg-secondary-subtle text-secondary'} px-2 py-1 rounded-pill x-small fw-bold">
                                                                        ${promo.active ? 'CAMPAIGN ACTIVE' : 'CAMPAIGN
                                                                        INACTIVE'}
                                                                    </span>
                                                                </div>
                                                                <div class="bg-primary-subtle text-primary p-2 rounded shadow-sm text-center"
                                                                    style="min-width: 60px;">
                                                                    <div class="fw-bold fs-5 lh-1">
                                                                        ${promo.discountValue}${promo.discountType ==
                                                                        'PERCENTAGE' ? '%' : '$'}</div>
                                                                    <small
                                                                        class="x-small fw-bold text-uppercase">OFF</small>
                                                                </div>
                                                            </div>
                                                            <p class="text-muted small mb-3">${promo.description}</p>
                                                            <div class="mb-4">
                                                                <label
                                                                    class="x-small fw-bold text-uppercase text-muted d-block mb-2">Target
                                                                    Products</label>
                                                                <div class="d-flex flex-wrap gap-1">
                                                                    <c:forEach var="prodName"
                                                                        items="${promo.productNames}">
                                                                        <span
                                                                            class="badge bg-light text-primary border border-primary-subtle px-2 py-1 x-small">${prodName}</span>
                                                                    </c:forEach>
                                                                    <c:if test="${empty promo.productNames}">
                                                                        <span class="text-muted x-small italic">No
                                                                            products selected</span>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                            <div
                                                                class="d-flex justify-content-between align-items-center mt-auto">
                                                                <div class="d-flex align-items-center text-muted">
                                                                    <i class="bi bi-clock-history me-2"></i>
                                                                    <small class="fw-semibold">Exp:
                                                                        ${promo.endDate}</small>
                                                                </div>
                                                                <div class="d-flex gap-2">
                                                                    <button type="button"
                                                                        class="btn btn-light-primary btn-sm rounded-pill px-3 fw-bold edit-promo-btn"
                                                                        data-id="${promo.id}"
                                                                        data-title="${promo.title}"
                                                                        data-description="${promo.description}"
                                                                        data-type="${promo.discountType}"
                                                                        data-value="${promo.discountValue}"
                                                                        data-end="${promo.endDate}"
                                                                        data-active="${promo.active}">
                                                                        EDIT
                                                                    </button>
                                                                    <form
                                                                        action="${pageContext.request.contextPath}/admin/promotions"
                                                                        method="post">
                                                                        <input type="hidden" name="action"
                                                                            value="delete">
                                                                        <input type="hidden" name="id"
                                                                            value="${promo.id}">
                                                                        <button type="submit"
                                                                            class="btn btn-link link-danger p-0 fw-bold text-decoration-none x-small"
                                                                            onclick="return confirm('End this campaign?');">
                                                                            TERMINATE
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                            <c:if test="${empty promotions}">
                                                <div class="col-12 text-center py-5 admin-card">
                                                    <i class="bi bi-megaphone fs-1 d-block mb-3 opacity-25"></i>
                                                    <span class="text-muted">No active promotion campaigns found.</span>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </div>
            </div>

            <!-- Edit Modal -->
            <div class="modal fade" id="editModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content border-0 shadow-lg">
                        <div class="modal-header bg-primary text-white border-0">
                            <h5 class="modal-title fw-bold">Edit Promotion Campaign</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body p-4">
                            <form action="${pageContext.request.contextPath}/admin/promotions" method="post"
                                id="editForm">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" id="editId">
                                <div class="mb-3">
                                    <label class="form-label fw-bold small text-muted">CAMPAIGN TITLE</label>
                                    <input type="text" name="title" id="editTitle" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold small text-muted">DESCRIPTION</label>
                                    <textarea name="description" id="editDescription" class="form-control" rows="2"
                                        required></textarea>
                                </div>
                                <div class="row g-3">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label fw-bold small text-muted">TYPE</label>
                                        <select name="discountType" id="editType" class="form-select">
                                            <option value="PERCENTAGE">Percentage (%)</option>
                                            <option value="FIXED">Fixed ($)</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label fw-bold small text-muted">VALUE</label>
                                        <input type="number" step="0.1" name="discountValue" id="editValue"
                                            class="form-control" required>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold small text-muted">APPLICABLE PRODUCTS</label>
                                    <select name="productIds" id="editProductIds" class="tom-select-products" multiple
                                        placeholder="Search products...">
                                        <c:forEach var="prod" items="${products}">
                                            <option value="${prod.id}">${prod.name} ($${prod.price})</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold small text-muted">EXPIRATION DATE</label>
                                    <input type="date" name="endDate" id="editEndDate" class="form-control" required>
                                </div>
                                <div class="form-check form-switch mb-4">
                                    <input class="form-check-input" type="checkbox" name="active" id="editActive">
                                    <label class="form-check-label fw-bold small text-muted ms-2"
                                        for="editActive">ACTIVE</label>
                                </div>
                                <div class="d-grid mt-4">
                                    <button type="submit" class="btn btn-primary py-2 fw-bold">SAVE CHANGES</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                // Initialize TomSelect
                const tsConfigs = {
                    plugins: ['remove_button'],
                    maxItems: null,
                    render: {
                        item: function (data, escape) {
                            return '<div class="badge bg-primary-subtle text-primary border border-primary-subtle me-1 px-2 py-1">' + escape(data.text) + '</div>';
                        }
                    }
                };

                document.querySelectorAll('.tom-select-products').forEach(el => {
                    new TomSelect(el, tsConfigs);
                });

                document.querySelectorAll('.edit-promo-btn').forEach(btn => {
                    btn.addEventListener('click', function () {
                        const id = this.getAttribute('data-id');
                        document.getElementById('editId').value = id;
                        document.getElementById('editTitle').value = this.getAttribute('data-title');
                        document.getElementById('editDescription').value = this.getAttribute('data-description');
                        document.getElementById('editType').value = this.getAttribute('data-type');
                        document.getElementById('editValue').value = this.getAttribute('data-value');
                        document.getElementById('editEndDate').value = this.getAttribute('data-end');
                        document.getElementById('editActive').checked = this.getAttribute('data-active') === 'true';

                        // Fetch linked products
                        fetch('${pageContext.request.contextPath}/admin/promotions?action=getProducts&id=' + id)
                            .then(response => response.json())
                            .then(data => {
                                const select = document.getElementById('editProductIds').tomselect;
                                select.clear();
                                data.forEach(pid => select.addItem(pid));
                            });

                        new bootstrap.Modal(document.getElementById('editModal')).show();
                    });
                });
            </script>
        </body>

        </html>