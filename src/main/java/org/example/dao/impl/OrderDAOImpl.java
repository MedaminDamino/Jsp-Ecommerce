package org.example.dao.impl;

import org.example.dao.OrderDAO;
import org.example.model.Order;
import org.example.model.OrderItem;
import org.example.util.ConnectionFactory;

import java.sql.*;

public class OrderDAOImpl implements OrderDAO {

    @Override
    public int save(Order order) {
        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psItem = null;
        ResultSet rs = null;
        int generatedId = -1;

        try {
            conn = ConnectionFactory.getInstance().getConnection();
            conn.setAutoCommit(false); // Start Transaction

            // 1. Save Order
            String sqlOrder = "INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, ?)";
            psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, order.getUserId());
            psOrder.setDouble(2, order.getTotalAmount());
            psOrder.setString(3, "PENDING");
            psOrder.executeUpdate();

            rs = psOrder.getGeneratedKeys();
            if (rs.next()) {
                generatedId = rs.getInt(1);
                order.setId(generatedId);
            }

            // 2. Save Order Items
            if (order.getItems() != null && !order.getItems().isEmpty()) {
                String sqlItem = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
                psItem = conn.prepareStatement(sqlItem);
                
                for (OrderItem item : order.getItems()) {
                    psItem.setInt(1, generatedId);
                    psItem.setInt(2, item.getProductId());
                    psItem.setInt(3, item.getQuantity());
                    psItem.setDouble(4, item.getPrice());
                    psItem.addBatch();
                }
                psItem.executeBatch();
            }

            conn.commit(); // Commit Transaction

        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw new RuntimeException("Failed to save order", e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (psOrder != null) psOrder.close();
                if (psItem != null) psItem.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return generatedId;
    }

    @Override
    public java.util.List<Order> findByUserId(int userId) {
        java.util.List<Order> orders = new java.util.ArrayList<>();
        String sql = "SELECT o.id, o.user_id, o.total_amount, o.status, o.order_date, " +
                     "oi.id as item_id, oi.product_id, oi.quantity, oi.price, " +
                     "p.name as product_name, p.image_url " +
                     "FROM orders o " +
                     "LEFT JOIN order_items oi ON o.id = oi.order_id " +
                     "LEFT JOIN products p ON oi.product_id = p.id " +
                     "WHERE o.user_id = ? " +
                     "ORDER BY o.order_date DESC";
        
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            java.util.Map<Integer, Order> orderMap = new java.util.LinkedHashMap<>();
            
            while (rs.next()) {
                int orderId = rs.getInt("id");
                Order order = orderMap.get(orderId);
                
                if (order == null) {
                    order = new Order();
                    order.setId(orderId);
                    order.setUserId(rs.getInt("user_id"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    order.setCreatedAt(rs.getTimestamp("order_date"));
                    order.setItems(new java.util.ArrayList<>());
                    orderMap.put(orderId, order);
                }
                
                // Add order item if exists
                if (rs.getInt("item_id") > 0) {
                    OrderItem item = new OrderItem();
                    item.setId(rs.getInt("item_id"));
                    item.setOrderId(orderId);
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getDouble("price"));
                    item.setProductName(rs.getString("product_name"));
                    item.setProductImageUrl(rs.getString("image_url"));
                    order.getItems().add(item);
                }
            }
            
            orders.addAll(orderMap.values());
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return orders;
    }

    @Override
    public java.util.List<Order> findAll() {
        java.util.List<Order> orders = new java.util.ArrayList<>();
        String sql = "SELECT o.id, o.user_id, o.total_amount, o.status, o.order_date, " +
                     "u.email as user_email " +
                     "FROM orders o " +
                     "LEFT JOIN users u ON o.user_id = u.id " +
                     "ORDER BY o.order_date DESC";
        
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setCreatedAt(rs.getTimestamp("order_date"));
                // We could add user email to the order object if we extended it, 
                // but for now let's just get the basic order info.
                // Or better, relying on Service to fetch User details if needed?
                // Actually, let's keep it simple.
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public Order findById(int id) {
        Order order = null;
        String sql = "SELECT * FROM orders WHERE id = ?";
        
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    order.setCreatedAt(rs.getTimestamp("order_date"));
                    // Load items
                    order.setItems(findItemsByOrderId(id));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    @Override
    public void updateStatus(int id, String status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateTotalAmount(int id, double totalAmount) {
        String sql = "UPDATE orders SET total_amount = ? WHERE id = ?";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, totalAmount);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void addOrderItem(OrderItem item) {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, item.getOrderId());
            ps.setInt(2, item.getProductId());
            ps.setInt(3, item.getQuantity());
            ps.setDouble(4, item.getPrice());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrderItem(int itemId) {
        String sql = "DELETE FROM order_items WHERE id = ?";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, itemId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public java.util.List<OrderItem> findItemsByOrderId(int orderId) {
        java.util.List<OrderItem> items = new java.util.ArrayList<>();
        String sql = "SELECT oi.*, p.name as product_name, p.image_url " +
                     "FROM order_items oi " +
                     "JOIN products p ON oi.product_id = p.id " +
                     "WHERE oi.order_id = ?";
        
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setId(rs.getInt("id"));
                    item.setOrderId(rs.getInt("order_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getDouble("price"));
                    item.setProductName(rs.getString("product_name"));
                    item.setProductImageUrl(rs.getString("image_url"));
                    items.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }
}
