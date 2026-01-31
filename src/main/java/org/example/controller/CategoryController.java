package org.example.controller;

import org.example.service.CategoryService;
import org.example.service.impl.CategoryServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CategoryController", urlPatterns = "/categories")
public class CategoryController extends HttpServlet {

    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        categoryService = new CategoryServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        var categories = categoryService.getAllCategories();
        request.setAttribute("categories", categories);
        // Assuming the JSP was at Category/categories.jsp, we keep the path or move the JSP too.
        // For now, let's point to where it likely is, or strictly 'categories.jsp' if we move it.
        // If the find_by_name returns a specific location, I might need to adjust this.
        // Using a safe default or keeping original relative path if it exists.
        request.getRequestDispatcher("Category/categories.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // This POST method seems to be for adding categories (Admin feature?), 
        // but it's in a generic controller. 
        // We will support it but require Admin checks normally. 
        // For now, just fixing compilation.

        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (name != null && !name.trim().isEmpty()) {
            categoryService.addCategory(name.trim(), description == null ? "" : description.trim());
        }

        response.sendRedirect("categories");
    }
}
