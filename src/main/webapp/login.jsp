<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Login - JSP Store</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <style>
                .login-container {
                    max-width: 400px;
                    margin: 100px auto;
                }
            </style>
        </head>

        <body class="bg-light">

            <div class="container login-container">
                <div class="card shadow">
                    <div class="card-body p-4">
                        <h3 class="text-center mb-4">Login</h3>

                        <c:if test="${not empty param.error}">
                            <div class="alert alert-danger" role="alert">
                                ${param.error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/auth" method="post">
                            <input type="hidden" name="action" value="login">
                            <div class="mb-3">
                                <label for="email" class="form-label">Email address</label>
                                <input type="email" class="form-control" id="email" name="email" required
                                    placeholder="admin@test.com">
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required
                                    placeholder="admin123">
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">Sign In</button>
                            </div>
                        </form>
                        <div class="mt-3 text-center">
                            <small>Default Admin: admin@test.com / admin123</small><br>
                            <small>Default User: user@test.com / user123</small>
                        </div>
                        <div class="mt-3 text-center">
                            <a href="${pageContext.request.contextPath}/home">Back to Home</a>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>