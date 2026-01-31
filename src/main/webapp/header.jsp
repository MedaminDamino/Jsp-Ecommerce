<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">JSP E-Commerce</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarText">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/home">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/cart">Cart</a>
                </li>
                <!-- Search Bar -->
                <li class="nav-item">
                     <form class="d-flex ms-3" action="${pageContext.request.contextPath}/home" method="get">
                        <input class="form-control me-2" type="search" placeholder="Search products..." aria-label="Search" name="search" value="${param.search}">
                        <button class="btn btn-outline-success" type="submit">Search</button>
                    </form>
                </li>
            </ul>
            <span class="navbar-text">
                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                         Welcome, ${sessionScope.user.email} 
                         <c:if test="${sessionScope.user.role == 'ADMIN'}">
                             | <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="text-warning">Admin</a>
                         </c:if>
                         | <a href="${pageContext.request.contextPath}/auth?action=logout" class="text-white">Logout</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="text-white">Login</a>
                    </c:otherwise>
                </c:choose>
            </span>
        </div>
    </div>
</nav>
