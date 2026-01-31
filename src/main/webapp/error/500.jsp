<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <title>500 Internal Server Error - JSP Store</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body class="bg-light d-flex align-items-center justify-content-center vh-100">
        <div class="text-center container">
            <h1 class="display-1 fw-bold text-muted">500</h1>
            <p class="fs-3"> <span class="text-danger">Error!</span> Something went wrong.</p>
            <p class="lead">We're experiencing an internal server problem. Please try again later.</p>

            <% if (exception !=null) { %>
                <div class="accordion mt-4 text-start mx-auto" style="max-width: 600px;" id="errorDetails">
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseOne">
                                View Technical Details
                            </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#errorDetails">
                            <div class="accordion-body">
                                <pre class="small text-danger"
                                    style="max-height: 200px; overflow-y: auto;"><%= exception.getMessage() %></pre>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>

                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary mt-4">Go Home</a>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>