<%@ page import="org.example.util.ConnectionFactory" %>
    <%@ page import="java.sql.*" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>targeted DB Fix</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            </head>

            <body class="container mt-5">
                <div class="card p-4 shadow">
                    <h2 class="mb-4">Targeted DB Fix</h2>
                    <% try (Connection conn=ConnectionFactory.getInstance().getConnection(); Statement
                        stmt=conn.createStatement()) { out.println("Checking for <code>product_promotions</code>
                        table...<br>");

                        try {
                        // Try to create the table
                        stmt.execute("CREATE TABLE IF NOT EXISTS product_promotions (" +
                        "product_id INT," +
                        "promotion_id INT," +
                        "PRIMARY KEY (product_id, promotion_id)," +
                        "FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE," +
                        "FOREIGN KEY (promotion_id) REFERENCES promotions(id) ON DELETE CASCADE)");
                        out.println("<div class='alert alert-success'>✅ Table <code>product_promotions</code>
                            verified/created.</div>");
                        } catch (SQLException e) {
                        out.println("<div class='alert alert-danger'>❌ Error creating table: " + e.getMessage() + "
                        </div>");
                        }

                        out.println("Check complete! <a href='index.jsp' class='btn btn-primary mt-3'>Return Home</a>");

                        } catch (Exception e) {
                        out.println("<div class='alert alert-danger'>Critical connection error: " + e.getMessage() + "
                        </div>");
                        e.printStackTrace();
                        }
                        %>
                </div>
            </body>

            </html>