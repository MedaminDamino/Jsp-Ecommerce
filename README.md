# JSP E-Commerce Platform

A comprehensive E-Commerce Web Application built with Java Servlets, JSP, JSTL, JDBC, and MySQL, following the Model-View-Controller (MVC) architecture and SOLID principles.

## Prerequisites

*   **Java Development Kit (JDK)**: Version 8 or higher (tested with JDK 17).
*   **Apache Tomcat**: Version 9.0 or 10.1+.
*   **MySQL Server**: Version 8.0+.
*   **IDE**: Eclipse IDE for Enterprise Java Developers or IntelliJ IDEA (Ultimate Edition recommended).

## Database Configuration

1.  **Create Database**: Run the script `schema.sql` located in the project root to create the `jsp_ecommerce` database and seed initial data.
    *   This script creates tables: `users`, `categories`, `products`, `promotions`, `orders`, `order_items`.
    *   It inserts default users, categories, and products.

2.  **Connection Settings**:
    The database configuration is located in `src/main/resources/db.properties`.
    Update the `db.user` and `db.password` if your local MySQL setup differs from `root` / (empty).

    ```properties
    db.url=jdbc:mysql://localhost:3306/jsp_ecommerce?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
    db.user=root
    db.password=
    ```

## Running on Tomcat

1.  **Build**:
    *   Import the project into your IDE as a **Maven** or **Dynamic Web Project**.
    *   Ensure all dependencies (e.g., MySQL Connector, JSTL, Servlet API) are in `WEB-INF/lib` or resolved via Maven.

2.  **Deploy**:
    *   Add the project to your Tomcat Server configuration in the IDE.
    *   Start the Tomcat Server.

3.  **Access**:
    *   Open your browser and navigate to: `http://localhost:8080/ProjetJsp` (or your configured context path).

## Default Login Credentials

**Admin User**:
*   Email: `admin@test.com`
*   Password: `admin123`

**Customer User**:
*   Email: `user@test.com`
*   Password: `user123`

## Features

*   **Customer Side**:
    *   Browse products by category.
    *   Search for products.
    *   View active promotions.
    *   Add items to Cart.
    *   Checkout and place Orders.
    *   Error Pages (404, 500).

*   **Admin Side**:
    *   Secure Dashboard (Password Hashed).
    *   Manage Products (Add, Delete).
    *   View Categories.

## Architecture

*   **Controller**: Servlets (`HomeServlet`, `CheckoutServlet`, `AdminProductServlet`, etc.) handle requests and control flow.
*   **View**: JSP files with JSTL (`index.jsp`, `checkout.jsp`) render the UI using Bootstrap 5.
*   **Model**: POJOs (`Product`, `User`, `Order`) represent data.
*   **Service**: Business logic interfaces and implementations (`ProductServiceImpl`, `UserServiceImpl`).
*   **DAO**: Data Access Object interfaces and implementations (`ProductDAOImpl`, `UserDAOImpl`) for database interactions via `ConnectionFactory`.

## Security

*   **Authentication**: Session-based login with hashed passwords (SHA-256).
*   **Authorization**: `AdminAuthFilter` protects `/admin/*` routes.
*   **Safety**: PreparedStatements used for all SQL queries to prevent Injection.
