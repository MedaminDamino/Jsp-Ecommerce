<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <title>Order Confirmed - JSP Store</title>
        <%@ include file="/WEB-INF/fragments/head.jspf" %>
    </head>

    <body>

        <%@ include file="/WEB-INF/fragments/client-navbar.jspf" %>

            <div class="container main-content mt-5 text-center">
                <div class="card shadow-sm border-0 p-5 mx-auto" style="max-width: 600px;">
                    <div class="mb-4 text-success">
                        <i class="bi bi-check-circle-fill" style="font-size: 4rem;"></i>
                    </div>
                    <h1 class="display-5 fw-bold mb-3">Order Confirmed!</h1>
                    <p class="lead text-muted mb-4">Thank you for your purchase. Your order <strong>#${orderId}</strong>
                        has been successfully placed.</p>

                    <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-primary px-4 gap-3">Continue
                            Shopping</a>
                    </div>
                </div>
            </div>

            <%@ include file="/WEB-INF/fragments/client-footer.jspf" %>

    </body>

    </html>