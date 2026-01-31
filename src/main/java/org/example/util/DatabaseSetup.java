package org.example.util;

import java.sql.Connection;
import java.sql.Statement;

public class DatabaseSetup {

    public static void main(String[] args) {
        System.out.println("Starting Database Reset...");

        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             Statement stmt = conn.createStatement()) {

            System.out.println("Connected to database.");

            // 1. Drop existing tables
            System.out.println("Dropping old tables...");
            stmt.addBatch("SET FOREIGN_KEY_CHECKS = 0");
            stmt.addBatch("DROP TABLE IF EXISTS order_items");
            stmt.addBatch("DROP TABLE IF EXISTS orders");
            stmt.addBatch("DROP TABLE IF EXISTS promotions");
            stmt.addBatch("DROP TABLE IF EXISTS products");
            stmt.addBatch("DROP TABLE IF EXISTS categories");
            stmt.addBatch("DROP TABLE IF EXISTS users");
            stmt.addBatch("SET FOREIGN_KEY_CHECKS = 1");

            // 2. Create Tables
            System.out.println("Creating new tables...");
            stmt.addBatch("CREATE TABLE users (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "email VARCHAR(100) NOT NULL UNIQUE," +
                    "password VARCHAR(255) NOT NULL," +
                    "role VARCHAR(20) NOT NULL DEFAULT 'CUSTOMER')");

            stmt.addBatch("CREATE TABLE categories (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "name VARCHAR(100) NOT NULL UNIQUE)");

            stmt.addBatch("CREATE TABLE products (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "name VARCHAR(200) NOT NULL," +
                    "description TEXT," +
                    "price DECIMAL(10,2) NOT NULL," +
                    "category_id INT," +
                    "image_url VARCHAR(500)," +
                    "FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL)");

            stmt.addBatch("CREATE TABLE promotions (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "title VARCHAR(200) NOT NULL," +
                    "description TEXT," +
                    "active BOOLEAN DEFAULT TRUE," +
                    "discount_type VARCHAR(20) NOT NULL," +
                    "discount_value DECIMAL(10,2) NOT NULL," +
                    "end_date DATE NOT NULL)");

            stmt.addBatch("CREATE TABLE orders (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "user_id INT NOT NULL," +
                    "total_amount DECIMAL(10,2) NOT NULL," +
                    "order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP," +
                    "status VARCHAR(50) DEFAULT 'PENDING'," +
                    "FOREIGN KEY (user_id) REFERENCES users(id))");

            stmt.addBatch("CREATE TABLE order_items (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "order_id INT NOT NULL," +
                    "product_id INT NOT NULL," +
                    "quantity INT NOT NULL," +
                    "price DECIMAL(10,2) NOT NULL," +
                    "FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE," +
                    "FOREIGN KEY (product_id) REFERENCES products(id))");

            // 3. Insert Data
            System.out.println("Inserting sample data with HASHED passwords...");
            stmt.addBatch("INSERT INTO users (email, password, role) VALUES " +
                    "('admin@test.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'ADMIN')," +
                    "('user@test.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'CUSTOMER')");

            stmt.addBatch("INSERT INTO categories (name) VALUES ('Electronics'), ('Books'), ('Fashion')");

            stmt.addBatch("INSERT INTO products (name, description, price, category_id, image_url) VALUES " +
                    "('Smartphone X', 'Latest smartphone with AI features', 999.99, 1, 'https://placehold.co/400x300')," +
                    "('Laptop Pro', 'High performance laptop', 1499.99, 1, 'https://placehold.co/400x300')," +
                    "('Java Programming', 'Master Java in 30 days', 29.99, 2, 'https://placehold.co/400x300')");

            stmt.addBatch("INSERT INTO promotions (title, description, active, discount_type, discount_value, end_date) VALUES " +
                    "('Summer Sale', 'Get 20% off on all items!', TRUE, 'PERCENTAGE', 20.00, DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY))");

            int[] results = stmt.executeBatch();
            System.out.println("------------------------------------------------");
            System.out.println("SUCCESS! Database reset complete. " + results.length + " statements executed.");
            System.out.println("You can now login with: admin@test.com / admin123");
            System.out.println("------------------------------------------------");

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("FAILED: " + e.getMessage());
        }
    }
}
