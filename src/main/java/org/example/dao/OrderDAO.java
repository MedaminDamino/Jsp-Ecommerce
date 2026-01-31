package org.example.dao;

import org.example.model.Order;

public interface OrderDAO {
    int save(Order order); // Returns generated ID
    java.util.List<Order> findByUserId(int userId);
}
