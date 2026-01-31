package org.example.service;

import org.example.model.Order;
import org.example.model.User;
import java.util.Map;

public interface OrderService {
    int createOrder(User user, Map<Integer, Integer> cartItems);
    java.util.List<Order> getUserOrders(int userId);
}
