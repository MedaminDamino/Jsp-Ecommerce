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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Just display the cart page
        // We might want to enrich the cart with Product objects here if we are only storing IDs
        req.getRequestDispatcher("cart.jsp").forward(req, resp);
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
