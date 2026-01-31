package org.example.controller.admin;

import org.example.model.User;
import org.example.service.UserService;
import org.example.service.impl.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminUserServlet", urlPatterns = {"/admin/users"})
public class AdminUserServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            deleteUser(req, resp);
        } else {
            listUsers(req, resp);
        }
    }

    private void listUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> users = userService.getAllUsers();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, resp);
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        
        // Prevent deleting self (simple check against session user)
        User currentUser = (User) req.getSession().getAttribute("user");
        if (currentUser != null && currentUser.getId() == id) {
             // Ideally show error, but for now just redirect
             resp.sendRedirect(req.getContextPath() + "/admin/users?error=Cannot delete yourself");
             return;
        }

        userService.deleteUser(id);
        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}
