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

    @Override
    public java.util.List<Order> getAllOrders() {
        return orderDAO.findAll();
    }

    @Override
    public Order getOrderById(int id) {
        return orderDAO.findById(id);
    }

    @Override
    public void updateOrderStatus(int id, String status) {
        orderDAO.updateStatus(id, status);
    }

    @Override
    public void addProductToOrder(int orderId, int productId, int quantity) {
        if (quantity <= 0) return;
        
        Product product = productDAO.findById(productId);
        if (product != null) {
            OrderItem item = new OrderItem();
            item.setOrderId(orderId);
            item.setProductId(productId);
            item.setQuantity(quantity);
            // Use current product price
            // The user said "cannot change their price" regarding the order total being editable,
            // but when adding a new item, we must use its current price.
            item.setPrice(product.getPrice()); 
            
            orderDAO.addOrderItem(item);
            recalculateOrderTotal(orderId);
        }
    }

    @Override
    public void removeProductFromOrder(int orderId, int orderItemId) {
        orderDAO.deleteOrderItem(orderItemId);
        recalculateOrderTotal(orderId);
    }

    private void recalculateOrderTotal(int orderId) {
        List<OrderItem> items = orderDAO.findItemsByOrderId(orderId);
        double total = 0.0;
        for (OrderItem item : items) {
            total += (item.getPrice() * item.getQuantity());
        }
        orderDAO.updateTotalAmount(orderId, total);
    }
}
