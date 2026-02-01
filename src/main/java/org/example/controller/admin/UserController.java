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

@WebServlet(name = "UserController", urlPatterns = {"/admin/users"})
public class UserController extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("update-role".equals(action)) {
            updateUserRole(req, resp);
        } else {
            doGet(req, resp);
        }
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

    private void updateUserRole(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String role = req.getParameter("role");

        // Prevent changing own role (simple check against session user)
        User currentUser = (User) req.getSession().getAttribute("user");
        if (currentUser != null && currentUser.getId() == id) {
             resp.sendRedirect(req.getContextPath() + "/admin/users?error=Cannot change your own role");
             return;
        }

        userService.updateUserRole(id, role);
        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}
