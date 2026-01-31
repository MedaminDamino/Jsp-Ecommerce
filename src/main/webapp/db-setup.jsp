<%@ page import="org.example.util.ConnectionFactory" %>
    <%@ page import="java.sql.Connection" %>
        <%@ page import="java.sql.Statement" %>
            <%@ page contentType="text/html;charset=UTF-8" language="java" %>
                <html>

                <head>
                    <title>Database Reset</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                </head>

                <body class="container mt-5">
                    <div class="card">
                        <div class="card-header bg-danger text-white">
                            <h3 class="mb-0">Database Factory Reset</h3>
                        </div>
                        <div class="card-body">
                            <% try (Connection conn=ConnectionFactory.getInstance().getConnection(); Statement
                                stmt=conn.createStatement()) { // 1. Drop existing tables (Reverse order for FK
                                constraints) stmt.addBatch("SET FOREIGN_KEY_CHECKS=0"); stmt.addBatch("DROP TABLE IF
                                EXISTS product_promotions"); stmt.addBatch("DROP TABLE IF EXISTS order_items");
                                stmt.addBatch("DROP TABLE IF EXISTS orders"); stmt.addBatch("DROP TABLE IF EXISTS
                                promotions"); stmt.addBatch("DROP TABLE IF EXISTS products"); stmt.addBatch("DROP TABLE
                                IF EXISTS categories"); stmt.addBatch("DROP TABLE IF EXISTS users"); stmt.addBatch("SET
                                FOREIGN_KEY_CHECKS=1"); // 2. Create Tables stmt.addBatch("CREATE TABLE users ("
                                + "id INT AUTO_INCREMENT PRIMARY KEY," + "email VARCHAR(100) NOT NULL UNIQUE,"
                                + "password VARCHAR(255) NOT NULL," + "role VARCHAR(20) NOT NULL DEFAULT 'CUSTOMER')" );
                                stmt.addBatch("CREATE TABLE categories (" + "id INT AUTO_INCREMENT PRIMARY KEY,"
                                + "name VARCHAR(100) NOT NULL UNIQUE)" ); stmt.addBatch("CREATE TABLE products ("
                                + "id INT AUTO_INCREMENT PRIMARY KEY," + "name VARCHAR(200) NOT NULL,"
                                + "description TEXT," + "price DECIMAL(10,2) NOT NULL," + "category_id INT,"
                                + "image_url VARCHAR(500),"
                                + "FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL)" );
                                stmt.execute("CREATE TABLE IF NOT EXISTS promotions ("
                                + "id INT AUTO_INCREMENT PRIMARY KEY," + "title VARCHAR(255) NOT NULL,"
                                + "description TEXT," + "active BOOLEAN DEFAULT TRUE,"
                                + "discount_type ENUM('PERCENTAGE', 'FIXED') NOT NULL,"
                                + "discount_value DECIMAL(10,2) NOT NULL," + "end_date DATE NOT NULL,"
                                + "product_ids VARCHAR(500) DEFAULT NULL)" ); stmt.addBatch("CREATE TABLE orders ("
                                + "id INT AUTO_INCREMENT PRIMARY KEY," + "user_id INT NOT NULL,"
                                + "total_amount DECIMAL(10,2) NOT NULL,"
                                + "order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"
                                + "status VARCHAR(50) DEFAULT 'PENDING',"
                                + "FOREIGN KEY (user_id) REFERENCES users(id))" ); stmt.addBatch("CREATE TABLE
                                order_items (" + "id INT AUTO_INCREMENT PRIMARY KEY," + "order_id INT NOT NULL,"
                                + "product_id INT NOT NULL," + "quantity INT NOT NULL,"
                                + "price DECIMAL(10,2) NOT NULL,"
                                + "FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,"
                                + "FOREIGN KEY (product_id) REFERENCES products(id))" ); stmt.addBatch("CREATE TABLE
                                product_promotions (" + "product_id INT," + "promotion_id INT,"
                                + "PRIMARY KEY (product_id, promotion_id),"
                                + "FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,"
                                + "FOREIGN KEY (promotion_id) REFERENCES promotions(id) ON DELETE CASCADE)" ); // 3.
                                Insert Sample Data stmt.addBatch("INSERT INTO users (email, password, role) VALUES " +
                " ('admin@test.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9' , 'ADMIN' ),"
                                + "('user@test.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'CUSTOMER')"
                                ); stmt.addBatch("INSERT INTO categories (name) VALUES ('Electronics'), ('Books'),
                                ('Fashion')"); stmt.addBatch("INSERT INTO products (name, description, price,
                                category_id, image_url) VALUES " +
                " ('Smartphone X', 'Latest smartphone with AI features' , 999.99, 1, 'https://placehold.co/400x300' ),"
                                + "('Laptop Pro', 'High performance laptop', 1499.99, 1, 'https://placehold.co/400x300'),"
                                + "('Java Programming', 'Master Java in 30 days', 29.99, 2, 'https://placehold.co/400x300')"
                                ); stmt.addBatch("INSERT INTO promotions (title, description, active, discount_type,
                                discount_value, end_date) VALUES " +
                " ('Summer Sale', 'Get 20% off on all items!' , TRUE, 'PERCENTAGE' , 20.00, DATE_ADD(CURRENT_DATE,
                                INTERVAL 30 DAY))"); stmt.addBatch("INSERT INTO product_promotions (product_id,
                                promotion_id) VALUES (1, 1)"); stmt.executeBatch(); out.println("<div
                                class='alert alert-success'>Database factory reset successful! All tables recreated and
                                seeded.
                        </div>");

                        } catch (Exception e) {
                        out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                        e.printStackTrace();
                        }
                        %>
                        <p class="mt-3">
                            <strong>Data is now fresh.</strong><br>
                            Admin: <code>admin@test.com</code> / <code>admin123</code><br>
                            User: <code>user@test.com</code> / <code>user123</code>
                        </p>
                        <a href="${pageContext.request.contextPath}/auth?action=login" class="btn btn-primary mt-3">Go
                            to Login</a>
                    </div>
                    </div>
                </body>

                </html>