<%@ page import="org.example.util.ConnectionFactory" %>
    <%@ page import="java.sql.*" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Database Fix Utility</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            </head>

            <body class="container mt-5">
                <div class="card p-4 shadow">
                    <h2 class="mb-4">Database Structure Fix</h2>
                    <% try (Connection conn=ConnectionFactory.getInstance().getConnection(); Statement
                        stmt=conn.createStatement()) { out.println("<p>Connected to database. Starting fixes...</p>");

                        // 1. Create product_promotions table
                        try {
                        stmt.execute("CREATE TABLE IF NOT EXISTS product_promotions (" +
                        "product_id INT," +
                        "promotion_id INT," +
                        "PRIMARY KEY (product_id, promotion_id)," +
                        "FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE," +
                        "FOREIGN KEY (promotion_id) REFERENCES promotions(id) ON DELETE CASCADE)");
                        out.println("<div class='alert alert-success'>✅ Table <code>product_promotions</code> verified.
                        </div>");
                        } catch (SQLException e) {
                        out.println("<div class='alert alert-warning'>⚠️ Note on junction table: " + e.getMessage() + "
                        </div>");
                        }

                        // 2. Add product_ids column to promotions
                        try {
                        stmt.execute("ALTER TABLE promotions ADD COLUMN product_ids VARCHAR(500) DEFAULT NULL");
                        out.println("<div class='alert alert-success'>✅ Column <code>product_ids</code> added to
                            <code>promotions</code>.</div>");
                        } catch (SQLException e) {
                        if (e.getMessage().toLowerCase().contains("duplicate column") ||
                        e.getMessage().contains("1060")) {
                        out.println("<div class='alert alert-info'>ℹ️ Column <code>product_ids</code> already exists.
                        </div>");
                        } else {
                        out.println("<div class='alert alert-danger'>❌ Error adding column: " + e.getMessage() + "</div>
                        ");
                        }
                        }

                        out.println("<div class='mt-3'><a href='index.jsp' class='btn btn-primary'>Return Home</a></div>
                        ");

                        } catch (Exception e) {
                        out.println("<div class='alert alert-danger'>
                            <h4>Critical Error</h4>" + e.getMessage() + "
                        </div>");
                        e.printStackTrace(new java.io.PrintWriter(out));
                        }
                        %>
                </div>
            </body>

            </html>