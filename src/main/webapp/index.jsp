<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <title>JSP Store | Premium Electronics & More</title>
        <%@ include file="/WEB-INF/fragments/head.jspf" %>
      </head>

      <body>

        <%@ include file="/WEB-INF/fragments/client-navbar.jspf" %>



          <div class="container mt-4 reveal">
            <!-- Promotional Hero - Refined -->
            <c:if test="${not empty promotions}">
              <div id="promoCarousel" class="carousel slide mb-5 rounded-4 overflow-hidden shadow-lg border"
                data-bs-ride="carousel">
                <div class="carousel-inner">
                  <c:forEach var="promo" items="${promotions}" varStatus="status">
                    <div class="carousel-item ${status.first ? 'active' : ''}">
                      <div class="promo-banner p-5 d-flex align-items-center justify-content-center text-center"
                        style="background: linear-gradient(135deg, #1e293b 0%, #334155 100%); min-height: 280px;">
                        <div>
                          <h4 class="text-primary text-uppercase tracking-widest fw-bold mb-2"
                            style="font-size: 0.8rem;">Feature Campaign</h4>
                          <h1 class="display-4 fw-black text-white mb-3" style="letter-spacing: -2px;">${promo.title}
                          </h1>
                          <p class="lead text-light opacity-75 mx-auto" style="max-width: 600px;">${promo.description}
                          </p>
                          <div class="mt-4 d-flex align-items-center justify-content-center gap-3">
                            <div class="bg-primary text-white rounded-pill px-4 py-2 fw-bold shadow-lg">
                              <c:choose>
                                <c:when test="${promo.discountType == 'PERCENTAGE'}">-${promo.discountValue}% OFF
                                </c:when>
                                <c:otherwise>-$${promo.discountValue} FLAT OFF</c:otherwise>
                              </c:choose>
                            </div>
                            <small class="text-light opacity-50">Ends ${promo.endDate}</small>
                          </div>
                        </div>
                      </div>
                    </div>
                  </c:forEach>
                </div>
              </div>
            </c:if>

            <div class="row">
              <!-- Sidebar Filters -->
              <aside class="col-lg-3 mb-4">
                <div class="category-sidebar">
                  <div class="d-flex align-items-center justify-content-between mb-4">
                    <h5 class="fw-bold mb-0 text-dark">Filters</h5>
                    <a href="${pageContext.request.contextPath}/home"
                      class="text-primary x-small fw-bold text-decoration-none">Reset</a>
                  </div>

                  <div class="mb-5">
                    <p class="text-muted fw-bold text-uppercase x-small mb-3" style="font-size: 0.7rem;">Categories
                    </p>
                    <div class="list-group p-0 border-0">
                      <a href="${pageContext.request.contextPath}/home"
                        class="category-link ${empty param.category ? 'active' : ''}">
                        <i class="bi bi-grid me-2"></i> All Collections
                      </a>
                      <c:forEach var="cat" items="${categories}">
                        <a href="${pageContext.request.contextPath}/home?category=${cat.id}&sort=${param.sort}"
                          class="category-link ${param.category != null && param.category == String.valueOf(cat.id) ? 'active' : ''}">
                          <i class="bi bi-circle small me-2" style="font-size: 0.5rem;"></i> ${cat.name}
                        </a>
                      </c:forEach>
                    </div>
                  </div>

                  <div class="p-3 bg-light rounded-3 border border-dashed text-center">
                    <i class="bi bi-patch-check-fill text-primary fs-3 d-block mb-2"></i>
                    <p class="small text-dark fw-bold mb-1">Authentic Products</p>
                    <p class="x-small text-muted mb-0">Official manufacturer warranty included</p>
                  </div>
                </div>
              </aside>

              <!-- Product Grid -->
              <main class="col-lg-9">
                <div class="shop-header mb-4">
                  <div class="d-flex align-items-center">
                    <div class="bg-light p-2 rounded-circle me-3"><i class="bi bi-sort-down fs-5"></i></div>
                    <div>
                      <p class="small text-muted mb-0">Displaying</p>
                      <h6 class="fw-bold mb-0">${fn:length(products)} Items Found</h6>
                    </div>
                  </div>

                  <form id="sortForm" action="${pageContext.request.contextPath}/home" method="get"
                    class="d-flex gap-2 align-items-center">
                    <input type="hidden" name="category" value="${param.category}">
                    <input type="hidden" name="search" value="${param.search}">
                    <label class="small text-muted fw-bold text-uppercase" style="font-size: 0.65rem;">Sort By</label>
                    <select name="sort" class="form-select form-select-sm border-0 bg-light shadow-none fw-bold px-3"
                      style="border-radius: 0.75rem; min-width: 160px;" onchange="this.form.submit()">
                      <option value="default" ${param.sort=='default' ? 'selected' : '' }>Latest Arrivals</option>
                      <option value="price_asc" ${param.sort=='price_asc' ? 'selected' : '' }>Price: Low to High
                      </option>
                      <option value="price_desc" ${param.sort=='price_desc' ? 'selected' : '' }>Price: High to Low
                      </option>
                      <option value="name_asc" ${param.sort=='name_asc' ? 'selected' : '' }>Product: A to Z</option>
                    </select>
                  </form>
                </div>

                <div class="row g-4">
                  <c:forEach var="p" items="${products}">
                    <div class="col-md-6 col-xl-4">
                      <div class="shop-card h-100 d-flex flex-column">
                        <div class="img-container">
                          <span class="price-tag">$${p.price}</span>
                          <img src="${p.imageUrl}" onerror="this.src='https://placehold.co/400x300?text=${p.name}'"
                            alt="${p.name}">
                        </div>
                        <div class="p-4 flex-grow-1">
                          <div class="d-flex justify-content-between align-items-start mb-2">
                            <h6 class="fw-bold text-dark mb-0 text-truncate" style="max-width: 160px;">${p.name}</h6>
                            <span class="x-small fw-bold text-primary bg-primary-subtle px-2 py-1 rounded">NEW</span>
                          </div>
                          <div class="d-flex justify-content-between align-items-center">
                            <div>
                              <c:choose>
                                <c:when test="${p.hasDiscount}">
                                  <span class="text-muted text-decoration-line-through small me-1">$${p.price}</span>
                                  <span class="fs-5 fw-bold text-danger">$${p.discountedPrice}</span>
                                </c:when>
                                <c:otherwise>
                                  <span class="fs-5 fw-bold text-dark">$${p.price}</span>
                                </c:otherwise>
                              </c:choose>
                            </div>
                            <form action="${pageContext.request.contextPath}/cart" method="post"
                              class="d-flex align-items-center">
                              <input type="hidden" name="action" value="add">
                              <input type="hidden" name="productId" value="${p.id}">
                              <button type="submit" class="btn btn-premium w-100 btn-sm p-2">
                                <i class="bi bi-bag-plus me-2"></i> Add to Cart
                              </button>
                            </form>
                          </div>
                          <p class="x-small text-muted mb-4 text-truncate-2" style="height: 32px;">${p.description}
                          </p>

                          <div class="d-flex gap-2 mt-auto">
                            <a href="${pageContext.request.contextPath}/product?id=${p.id}"
                              class="btn bg-light btn-sm text-dark p-2 rounded-3">
                              <i class="bi bi-eye"></i>
                            </a>
                          </div>
                        </div>
                      </div>
                    </div>
                  </c:forEach>
                </div>

                <c:if test="${empty products}">
                  <div class="text-center py-5 admin-card reveal mt-4 p-5">
                    <div class="bg-light p-4 rounded-circle d-inline-block mb-4 shadow-sm"
                      style="width: 100px; height: 100px;">
                      <i class="bi bi-search text-muted display-4"></i>
                    </div>
                    <h3 class="fw-black text-dark mb-2">No Matching Products</h3>
                    <p class="text-muted mx-auto mb-4" style="max-width: 400px;">We couldn't find what you're looking
                      for. Try adjusting your search query or switching categories.</p>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-premium rounded-pill px-5">Refresh
                      Catalog</a>
                  </div>
                </c:if>
              </main>
            </div>
          </div>

          <footer class="mt-5 py-5 border-top bg-white">
            <div class="container text-center">
              <div class="d-flex justify-content-center gap-4 mb-4 fs-4 text-primary">
                <div class="d-flex justify-content-center gap-4 mb-4 fs-4 text-primary">
                  <a href="#" class="text-primary text-decoration-none"><i class="bi bi-facebook"></i></a>
                  <a href="#" class="text-primary text-decoration-none"><i class="bi bi-twitter-x"></i></a>
                  <a href="#" class="text-primary text-decoration-none"><i class="bi bi-instagram"></i></a>
                </div>
                <p class="text-muted small">© 2026 JSP Premium Store. All rights reserved.</p>
              </div>
          </footer>

          <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
      </body>

      </html>