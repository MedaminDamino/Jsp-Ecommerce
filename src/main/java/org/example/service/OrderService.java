package org.example.service;

import org.example.model.Order;
import org.example.model.User;
import java.util.Map;

public interface OrderService {
    int createOrder(User user, Map<Integer, Integer> cartItems);
    java.util.List<Order> getUserOrders(int userId);
    
    // Admin methods
    java.util.List<Order> getAllOrders();
    Order getOrderById(int id);
    void updateOrderStatus(int id, String status);
    void addProductToOrder(int orderId, int productId, int quantity);
    void removeProductFromOrder(int orderId, int orderItemId);
}
