<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <title>Login | JSP Store</title>
            <%@ include file="/WEB-INF/fragments/head.jspf" %>
        </head>

        <body class="bg-light d-flex flex-column min-vh-100">

            <%@ include file="/WEB-INF/fragments/navbar.jspf" %>

                <div class="container py-5 flex-grow-1 d-flex align-items-center justify-content-center">
                    <div class="login-card admin-card reveal p-0 overflow-hidden shadow-lg border-0"
                        style="max-width: 450px; width: 100%;">
                        <div class="p-5">
                            <div class="text-center mb-4">
                                <div class="bg-primary text-white p-3 rounded-4 d-inline-block mb-3 shadow-sm">
                                    <i class="bi bi-person-lock fs-2"></i>
                                </div>
                                <h3 class="fw-black text-dark mb-1">Welcome Back</h3>
                                <p class="text-muted small text-uppercase fw-bold tracking-widest">Sign in to your
                                    account</p>
                            </div>

                            <c:if test="${not empty param.error}">
                                <div class="alert alert-danger border-0 shadow-sm rounded-4 mb-4 d-flex align-items-center"
                                    role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                                    <div>${param.error}</div>
                                </div>
                            </c:if>

                            <form action="${pageContext.request.contextPath}/auth" method="post">
                                <input type="hidden" name="action" value="login">
                                <div class="mb-4">
                                    <label for="email"
                                        class="form-label x-small fw-bold text-uppercase text-muted">Email
                                        Address</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-0"><i
                                                class="bi bi-envelope text-muted"></i></span>
                                        <input type="email" class="form-control bg-light border-0 shadow-none py-2"
                                            id="email" name="email" required placeholder="name@example.com">
                                    </div>
                                </div>
                                <div class="mb-5">
                                    <div class="d-flex justify-content-between">
                                        <label for="password"
                                            class="form-label x-small fw-bold text-uppercase text-muted">Password</label>
                                        <a href="#"
                                            class="x-small fw-bold text-primary text-decoration-none">Forgot?</a>
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-0"><i
                                                class="bi bi-key text-muted"></i></span>
                                        <input type="password" class="form-control bg-light border-0 shadow-none py-2"
                                            id="password" name="password" required placeholder="Enter password">
                                    </div>
                                </div>

                                <button type="submit"
                                    class="btn btn-premium w-100 py-3 rounded-pill fw-bold mb-4 shadow-lg">
                                    Sign In Now <i class="bi bi-arrow-right ms-2"></i>
                                </button>

                                <div class="text-center">
                                    <p class="small text-muted mb-0">Don't have an account? <a
                                            href="${pageContext.request.contextPath}/auth?action=register"
                                            class="fw-bold text-primary text-decoration-none">Sign Up</a></p>
                                </div>
                            </form>
                        </div>
                        <div class="bg-light p-4 text-center border-top">
                            <div class="d-flex justify-content-center gap-3">
                                <div class="text-start">
                                    <p class="x-small text-muted mb-0 fw-bold text-uppercase">Admin</p>
                                    <code class="small">admin@test.com / admin123</code>
                                </div>
                                <div class="vr"></div>
                                <div class="text-start">
                                    <p class="x-small text-muted mb-0 fw-bold text-uppercase">User</p>
                                    <code class="small">user@test.com / user123</code>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%@ include file="/WEB-INF/fragments/footer.jspf" %>

        </body>

        </html>