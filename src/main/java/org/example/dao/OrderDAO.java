package org.example.dao;

import org.example.model.Order;

public interface OrderDAO {
    int save(Order order); // Returns generated ID
    java.util.List<Order> findByUserId(int userId);
    java.util.List<Order> findAll();
    Order findById(int id);
    void updateStatus(int id, String status);
    void updateTotalAmount(int id, double totalAmount);
    // Item management
    void addOrderItem(org.example.model.OrderItem item);
    void deleteOrderItem(int itemId);
    java.util.List<org.example.model.OrderItem> findItemsByOrderId(int orderId);
}
