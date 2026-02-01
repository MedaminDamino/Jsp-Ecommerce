package org.example.dao.impl;

import org.example.dao.ProductDAO;
import org.example.model.Product;
import org.example.util.ConnectionFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductDAOImpl implements ProductDAO {

    // --- Pagination Implementations ---

    @Override
    public long countAll() {
        String sql = "SELECT COUNT(*) FROM products";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getLong(1);
        } catch (SQLException e) {
            System.err.println("Error in countAll: " + e.getMessage());
        }
        return 0;
    }

    @Override
    public long countByCategory(int categoryId) {
        String sql = "SELECT COUNT(*) FROM products WHERE category_id = ?";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getLong(1);
            }
        } catch (SQLException e) {
            System.err.println("Error in countByCategory: " + e.getMessage());
        }
        return 0;
    }

    @Override
    public long countSearch(String query) {
        String sql = "SELECT COUNT(*) FROM products WHERE name LIKE ?";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + query + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getLong(1);
            }
        } catch (SQLException e) {
            System.err.println("Error in countSearch: " + e.getMessage());
        }
        return 0;
    }

    @Override
    public List<Product> findAll(int offset, int limit, String sort) {
        List<Product> products = new ArrayList<>();
        String orderBy = getOrderBy(sort);
        String sql = "SELECT * FROM products" + orderBy + " LIMIT ? OFFSET ?";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) products.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error in findAll paginated: " + e.getMessage());
        }
        enrichWithPromotions(products);
        return products;
    }

    @Override
    public List<Product> findByCategorySorted(int categoryId, int offset, int limit, String sort) {
        List<Product> products = new ArrayList<>();
        String orderBy = getOrderBy(sort);
        String sql = "SELECT * FROM products WHERE category_id = ?" + orderBy + " LIMIT ? OFFSET ?";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            stmt.setInt(2, limit);
            stmt.setInt(3, offset);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) products.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error in findByCategorySorted paginated: " + e.getMessage());
        }
        enrichWithPromotions(products);
        return products;
    }

    @Override
    public List<Product> searchByNameSorted(String query, int offset, int limit, String sort) {
        List<Product> products = new ArrayList<>();
        String orderBy = getOrderBy(sort);
        String sql = "SELECT * FROM products WHERE name LIKE ?" + orderBy + " LIMIT ? OFFSET ?";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + query + "%");
            stmt.setInt(2, limit);
            stmt.setInt(3, offset);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) products.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error in searchByNameSorted paginated: " + e.getMessage());
        }
        enrichWithPromotions(products);
        return products;
    }

    @Override
    public List<Product> findAll() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                products.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error in findAll: " + e.getMessage());
        }
        enrichWithPromotions(products);
        return products;
    }

    @Override
    public List<Product> findByCategorySorted(int categoryId, String sort) {
        List<Product> products = new ArrayList<>();
        String orderBy = getOrderBy(sort);
        String sql = (categoryId == 0) ? 
                     "SELECT * FROM products" + orderBy :
                     "SELECT * FROM products WHERE category_id = ?" + orderBy;
                     
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            if (categoryId != 0) {
                stmt.setInt(1, categoryId);
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in findByCategorySorted: " + e.getMessage());
        }
        enrichWithPromotions(products);
        return products;
    }

    @Override
    public List<Product> findAllSorted(String sort) {
        List<Product> products = new ArrayList<>();
        String orderBy = getOrderBy(sort);
        String sql = "SELECT * FROM products" + orderBy;
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                products.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error in findAllSorted: " + e.getMessage());
        }
        enrichWithPromotions(products);
        return products;
    }

    @Override
    public List<Product> searchByNameSorted(String query, String sort) {
        List<Product> products = new ArrayList<>();
        String orderBy = getOrderBy(sort);
        String sql = "SELECT * FROM products WHERE name LIKE ?" + orderBy;
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + query + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in searchByNameSorted: " + e.getMessage());
        }
        enrichWithPromotions(products);
        return products;
    }

    private String getOrderBy(String sort) {
        if (sort == null) return " ORDER BY id DESC";
        switch (sort) {
            case "price_asc": return " ORDER BY price ASC";
            case "price_desc": return " ORDER BY price DESC";
            case "name_asc": return " ORDER BY name ASC";
            case "latest": return " ORDER BY id DESC";
            default: return " ORDER BY id DESC";
        }
    }

    @Override
    public List<Product> findByCategorySafe(int categoryId) {
        return findByCategorySorted(categoryId, null);
    }

    @Override
    public List<Product> searchByName(String query) {
        return searchByNameSorted(query, null);
    }

    @Override
    public Product findById(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Product p = mapRow(rs);
                    List<Product> list = new ArrayList<>();
                    list.add(p);
                    enrichWithPromotions(list);
                    return p;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in findById: " + e.getMessage());
        }
        return null;
    }

    @Override
    public void save(Product product) {
        String sql = "INSERT INTO products (name, description, price, category_id, image_url) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setInt(4, product.getCategoryId());
            stmt.setString(5, product.getImageUrl());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error in save: " + e.getMessage());
        }
    }

    @Override
    public void update(Product product) {
        String sql = "UPDATE products SET name = ?, description = ?, price = ?, category_id = ?, image_url = ? WHERE id = ?";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setInt(4, product.getCategoryId());
            stmt.setString(5, product.getImageUrl());
            stmt.setInt(6, product.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error in update: " + e.getMessage());
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM products WHERE id = ?";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error in delete: " + e.getMessage());
        }
    }

    private Product mapRow(ResultSet rs) throws SQLException {
        return new Product(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getDouble("price"),
                rs.getInt("category_id"),
                rs.getString("image_url")
        );
    }

    private void enrichWithPromotions(List<Product> products) {
        if (products == null || products.isEmpty()) return;
        
        // Map to quickly find products by ID
        Map<Integer, Product> productMap = new HashMap<>();
        for (Product p : products) {
            productMap.put(p.getId(), p);
        }

        // Fetch active promotions linked to products
        String sql = "SELECT pp.product_id, pr.discount_type, pr.discount_value " +
                     "FROM product_promotions pp " +
                     "JOIN promotions pr ON pp.promotion_id = pr.id " +
                     "WHERE pr.active = TRUE AND pr.end_date >= CURRENT_DATE";
        
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            int count = 0;
            while (rs.next()) {
                int productId = rs.getInt("product_id");
                Product p = productMap.get(productId);
                if (p != null) {
                    p.applyDiscount(rs.getString("discount_type"), rs.getDouble("discount_value"));
                    count++;
                }
            }
            if (count > 0) {
                System.out.println("Enriched " + count + " products with promotions.");
            }
        } catch (SQLException e) {
            // Log the error but don't crash. This happens if table is missing or SQL error.
            System.err.println("Promotion enrichment skipped: " + e.getMessage());
        }
    }
}
