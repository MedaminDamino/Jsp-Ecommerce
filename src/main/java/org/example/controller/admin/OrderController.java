package org.example.controller.admin;

import org.example.model.Order;
import org.example.model.Product;
import org.example.service.OrderService;
import org.example.service.ProductService;
import org.example.service.impl.OrderServiceImpl;
import org.example.service.impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderController", urlPatterns = {"/admin/orders", "/admin/orders/*"})
public class OrderController extends HttpServlet {

    private OrderService orderService;
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderServiceImpl();
        productService = new ProductServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "view":
                viewOrder(req, resp);
                break;
            default:
                listOrders(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        
        switch (action) {
            case "update-status":
                updateStatus(req, resp);
                break;
            case "add-item":
                addItem(req, resp);
                break;
            case "remove-item":
                removeItem(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/admin/orders");
                break;
        }
    }

    private void listOrders(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Order> orders = orderService.getAllOrders();
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp").forward(req, resp);
    }

    private void viewOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Order order = orderService.getOrderById(id);
        
        // Also fetch all products for the "Add Item" dropdown
        List<Product> products = productService.getAllProducts();
        
        req.setAttribute("order", order);
        req.setAttribute("products", products);
        req.getRequestDispatcher("/WEB-INF/views/admin/order-details.jsp").forward(req, resp);
    }

    private void updateStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String status = req.getParameter("status");
        orderService.updateOrderStatus(id, status);
        resp.sendRedirect(req.getContextPath() + "/admin/orders?action=view&id=" + id);
    }

    private void addItem(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        int productId = Integer.parseInt(req.getParameter("productId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        
        orderService.addProductToOrder(orderId, productId, quantity);
        resp.sendRedirect(req.getContextPath() + "/admin/orders?action=view&id=" + orderId);
    }

    private void removeItem(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        int itemId = Integer.parseInt(req.getParameter("itemId"));
        
        orderService.removeProductFromOrder(orderId, itemId);
        resp.sendRedirect(req.getContextPath() + "/admin/orders?action=view&id=" + orderId);
    }
}
