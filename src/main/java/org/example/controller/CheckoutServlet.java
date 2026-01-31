package org.example.controller;

import org.example.model.Product;
import org.example.model.User;
import org.example.service.OrderService;
import org.example.service.ProductService;
import org.example.service.impl.OrderServiceImpl;
import org.example.service.impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    private OrderService orderService;
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderServiceImpl();
        productService = new ProductServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp?error=Please login to checkout");
            return;
        }

        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect("home");
            return;
        }

        List<CartItem> cartItems = new ArrayList<>();
        double grandTotal = 0.0;

        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            int productId = entry.getKey();
            int quantity = entry.getValue();
            Product product = productService.getProductById(String.valueOf(productId));

            if (product != null) {
                double total = product.getPrice() * quantity;
                grandTotal += total;
                cartItems.add(new CartItem(product, quantity, total));
            }
        }

        req.setAttribute("cartItems", cartItems);
        req.setAttribute("grandTotal", grandTotal);
        req.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        if (user != null && cart != null && !cart.isEmpty()) {
            try {
                int orderId = orderService.createOrder(user, cart);
                session.removeAttribute("cart");
                req.setAttribute("orderId", orderId);
                req.getRequestDispatcher("/WEB-INF/views/order-confirmation.jsp").forward(req, resp);
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect("checkout?error=Order Failed");
            }
        } else {
            resp.sendRedirect("home");
        }
    }

    public static class CartItem {
        private Product product;
        private int quantity;
        private double total;

        public CartItem(Product product, int quantity, double total) {
            this.product = product;
            this.quantity = quantity;
            this.total = total;
        }

        public Product getProduct() { return product; }
        public int getQuantity() { return quantity; }
        public double getTotal() { return total; }
    }
}
