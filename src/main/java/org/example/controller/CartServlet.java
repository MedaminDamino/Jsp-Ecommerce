package org.example.controller;


import org.example.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    private org.example.service.ProductService productService;

    @Override
    public void init() throws jakarta.servlet.ServletException {
        productService = new org.example.service.impl.ProductServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        
        java.util.List<CartItem> cartItems = new java.util.ArrayList<>();
        double total = 0;

        if (cart != null) {
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                Product product = productService.getProductById(String.valueOf(entry.getKey()));
                if (product != null) {
                    cartItems.add(new CartItem(product, entry.getValue()));
                    total += (product.isHasDiscount() ? product.getDiscountedPrice() : product.getPrice()) * entry.getValue();
                }
            }
        }

        req.setAttribute("cartItems", cartItems);
        req.setAttribute("cartTotal", total);
        req.getRequestDispatcher("/WEB-INF/views/public/cart.jsp").forward(req, resp);
    }

    public static class CartItem {
        private Product product;
        private int quantity;
        public CartItem(Product product, int quantity) { this.product = product; this.quantity = quantity; }
        public Product getProduct() { return product; }
        public int getQuantity() { return quantity; }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        int productId = 0;
        try {
            productId = Integer.parseInt(req.getParameter("productId"));
        } catch (NumberFormatException e) {
            // Error handling
        }

        HttpSession session = req.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }

        if ("add".equals(action)) {
            int quantity = 1;
            try {
                String quantityParam = req.getParameter("quantity");
                if (quantityParam != null && !quantityParam.isEmpty()) {
                    quantity = Integer.parseInt(quantityParam);
                    if (quantity < 1) quantity = 1;
                }
            } catch (NumberFormatException e) {
                // Ignore, default to 1
            }
            
            cart.put(productId, cart.getOrDefault(productId, 0) + quantity);
            resp.sendRedirect(req.getContextPath() + "/cart");
        } else if ("remove".equals(action)) {
            cart.remove(productId);
            resp.sendRedirect(req.getContextPath() + "/cart");
        } else if ("update".equals(action)) {
            int qty = Integer.parseInt(req.getParameter("quantity"));
            if (qty > 0) {
                cart.put(productId, qty);
            } else {
                cart.remove(productId);
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }
}
