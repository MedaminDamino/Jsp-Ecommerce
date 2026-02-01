package org.example.controller.admin;

import org.example.model.Category;
import org.example.service.CategoryService;
import org.example.service.impl.CategoryServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CategoryController", urlPatterns = {"/admin/categories"})
public class CategoryController extends HttpServlet {

    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        categoryService = new CategoryServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("categories", categoryService.getAllCategories());
        req.getRequestDispatcher("/WEB-INF/views/admin/category-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            String name = req.getParameter("name");
            categoryService.addCategory(name, null);
            resp.sendRedirect("categories?success=Category Added");

        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            categoryService.updateCategory(new Category(id, name));
            resp.sendRedirect("categories?success=Category Updated");

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            if (categoryService.deleteCategory(id)) {
                resp.sendRedirect("categories?success=Category Deleted");
            } else {
                resp.sendRedirect("categories?error=Cannot delete category with associated products");
            }
        }
    }
}
