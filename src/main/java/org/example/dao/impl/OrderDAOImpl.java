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
}
