<%@ page import="org.example.util.ConnectionFactory" %>
    <%@ page import="java.sql.*" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>targeted DB Diagnostic</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            </head>

            <body class="container mt-5">
                <div class="card p-4 shadow">
                    <h2 class="mb-4 text-primary">Database Diagnostic</h2>
                    <% try (Connection conn=ConnectionFactory.getInstance().getConnection()) { out.println("<div
                        class='alert alert-info'>✅ Connection successful!
                </div>");

                DatabaseMetaData meta = conn.getMetaData();
                out.println("<strong>URL:</strong> " + meta.getURL() + "<br>");
                out.println("<strong>Current Catalog (DB):</strong> " + conn.getCatalog() + "<br>");
                out.println("<strong>User:</strong> " + meta.getUserName() + "<br>");
                out.println("<strong>Database Product:</strong> " + meta.getDatabaseProductName() + " " +
                meta.getDatabaseProductVersion() + "<br><br>");

                String[] tables = {"categories", "products", "promotions", "product_promotions"};
                for (String table : tables) {
                try (Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM " + table)) {
                if (rs.next()) {
                out.println("✅ Table <code>" + table + "</code> exists. Row count: <strong>" + rs.getInt(1) +
                    "</strong><br>");
                }
                } catch (SQLException e) {
                out.println("<div class='text-danger'>❌ Error accessing table <code>" + table + "</code>: " +
                    e.getMessage() + "</div>");
                }
                }

                out.println("
                <hr>
                <h4>Simple Product Test (SELECT * FROM products)</h4>");
                try (Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM products LIMIT 5")) {
                out.println("<table class='table table-sm'>");
                    out.println("<thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>");
                        int count = 0;
                        while (rs.next()) {
                        count++;
                        out.println("<tr>
                            <td>" + rs.getInt("id") + "</td>
                            <td>" + rs.getString("name") + "</td>
                            <td>" + rs.getDouble("price") + "</td>
                        </tr>");
                        }
                        out.println("</tbody>
                </table>");
                if (count == 0) out.println("<div class='alert alert-warning'>No products found in basic select.</div>
                ");
                } catch (SQLException e) {
                out.println("<div class='alert alert-danger'>Simple Select Failed: " + e.getMessage() + "</div>");
                }

                } catch (Exception e) {
                out.println("<div class='alert alert-danger'>Critical connection error: " + e.getMessage() + "</div>");
                e.printStackTrace();
                }
                %>
                <a href="index.jsp" class="btn btn-secondary mt-3">Back Home</a>
                </div>
            </body>

            </html>