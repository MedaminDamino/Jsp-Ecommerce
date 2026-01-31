package org.example.controller;

import org.example.model.Order;
import org.example.model.User;
import org.example.service.OrderService;
import org.example.service.impl.OrderServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderHistoryServlet", urlPatterns = {"/orders"})
public class OrderHistoryServlet extends HttpServlet {

    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp?error=Please login to view orders");
            return;
        }

        List<Order> orders = orderService.getUserOrders(user.getId());
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/WEB-INF/views/order-history.jsp").forward(req, resp);
    }
}
