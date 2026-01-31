CREATE DATABASE IF NOT EXISTS jsp_ecommerce;
USE jsp_ecommerce;

-- Users Table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'CUSTOMER'
);

-- Categories Table
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Products Table
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    category_id INT,
    image_url VARCHAR(500),
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- Promotions Table
CREATE TABLE IF NOT EXISTS promotions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    active BOOLEAN DEFAULT TRUE,
    discount_type VARCHAR(20) NOT NULL, -- 'PERCENTAGE' or 'FIXED'
    discount_value DECIMAL(10,2) NOT NULL,
    end_date DATE NOT NULL
);

-- Orders Table
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'PENDING',
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Order Items Table
CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Sample Data
-- admin123 -> 240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9
-- user123 -> a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3
INSERT INTO users (email, password, role) VALUES 
('admin@test.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'ADMIN'), 
('user@test.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'CUSTOMER');

INSERT INTO categories (name) VALUES ('Electronics'), ('Books'), ('Fashion');

INSERT INTO products (name, description, price, category_id, image_url) VALUES 
('Smartphone X', 'Latest smartphone with AI features', 999.99, 1, 'https://via.placeholder.com/150'),
('Laptop Pro', 'High performance laptop', 1499.99, 1, 'https://via.placeholder.com/150'),
('Java Programming', 'Master Java in 30 days', 29.99, 2, 'https://via.placeholder.com/150');

INSERT INTO promotions (title, description, active, discount_type, discount_value, end_date) VALUES 
('Summer Sale', 'Get 20% off on all items!', TRUE, 'PERCENTAGE', 20.00, DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY));
