package org.example.service.impl;

import org.example.dao.OrderDAO;
import org.example.dao.ProductDAO;
import org.example.dao.impl.OrderDAOImpl;
import org.example.dao.impl.ProductDAOImpl;
import org.example.model.Order;
import org.example.model.OrderItem;
import org.example.model.Product;
import org.example.model.User;
import org.example.service.OrderService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class OrderServiceImpl implements OrderService {

    private final OrderDAO orderDAO;
    private final ProductDAO productDAO;

    public OrderServiceImpl() {
        this.orderDAO = new OrderDAOImpl();
        this.productDAO = new ProductDAOImpl();
    }

    @Override
    public int createOrder(User user, Map<Integer, Integer> cartItems) {
        if (user == null || cartItems == null || cartItems.isEmpty()) {
            throw new IllegalArgumentException("Cannot create order: User or Cart is empty");
        }

        Order order = new Order();
        order.setUserId(user.getId());
        
        List<OrderItem> items = new ArrayList<>();
        double totalAmount = 0.0;

        for (Map.Entry<Integer, Integer> entry : cartItems.entrySet()) {
            int productId = entry.getKey();
            int quantity = entry.getValue();

            Product product = productDAO.findById(productId);
            if (product != null) {
                OrderItem item = new OrderItem();
                item.setProductId(productId);
                item.setQuantity(quantity);
                item.setPrice(product.getPrice());
                
                items.add(item);
                totalAmount += (product.getPrice() * quantity);
            }
        }

        order.setTotalAmount(totalAmount);
        order.setItems(items);

        return orderDAO.save(order);
    }
    
    @Override
    public java.util.List<Order> getUserOrders(int userId) {
        return orderDAO.findByUserId(userId);
    }
}
