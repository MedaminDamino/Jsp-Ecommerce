<%@ page import="org.example.util.ConnectionFactory" %>
    <%@ page import="java.sql.Connection" %>
        <%@ page import="java.sql.Statement" %>
            <%@ page contentType="text/html;charset=UTF-8" language="java" %>
                <html>

                <head>
                    <title>Fix Database Constraints</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                </head>

                <body class="container mt-5">
                    <div class="card">
                        <div class="card-header bg-warning text-dark">
                            <h3 class="mb-0">Fix Foreign Key Constraints</h3>
                        </div>
                        <div class="card-body">
                            <% try (Connection conn=ConnectionFactory.getInstance().getConnection(); Statement
                                stmt=conn.createStatement()) { // 1. Try to drop the specific constraint mentioned in
                                the error try { stmt.execute("ALTER TABLE order_items DROP FOREIGN KEY
                                order_items_ibfk_2"); out.println("<div class='alert alert-info'>Dropped existing
                                constraint 'order_items_ibfk_2'.
                        </div>");
                        } catch (Exception e) {
                        out.println("<div class='alert alert-warning'>Could not drop 'order_items_ibfk_2' (might not
                            exist or different name). Error: " + e.getMessage() + "</div>");
                        }

                        // 2. Add the new constraint with CASCADE
                        try {
                        stmt.execute("ALTER TABLE order_items ADD CONSTRAINT order_items_product_fk FOREIGN KEY
                        (product_id) REFERENCES products(id) ON DELETE CASCADE");
                        out.println("<div class='alert alert-success'>Successfully added new constraint with ON DELETE
                            CASCADE.</div>");
                        } catch (Exception e) {
                        out.println("<div class='alert alert-danger'>Failed to add new constraint. Error: " +
                            e.getMessage() + "</div>");
                        }

                        } catch (Exception e) {
                        out.println("<div class='alert alert-danger'>General Database Error: " + e.getMessage() + "
                        </div>");
                        e.printStackTrace();
                        }
                        %>
                        <p class="mt-3">
                            If you see a success message above, try deleting the product again.<br>
                            If it failed, you might need to run the full <a href="db-setup.jsp">Database Reset</a>
                            (Warning: Deletes all data).
                        </p>
                        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp"
                            class="btn btn-primary mt-3">Back to Dashboard</a>
                    </div>
                    </div>
                </body>

                </html>