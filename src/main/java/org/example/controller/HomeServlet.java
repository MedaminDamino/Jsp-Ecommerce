package org.example.controller;

import org.example.model.Product;
import org.example.service.CategoryService;
import org.example.service.ProductService;
import org.example.service.PromotionService;
import org.example.service.impl.CategoryServiceImpl;
import org.example.service.impl.ProductServiceImpl;
import org.example.service.impl.PromotionServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"", "/home"})
public class HomeServlet extends HttpServlet {

    private ProductService productService;
    private CategoryService categoryService;
    private PromotionService promotionService;

    @Override
    public void init() throws ServletException {
        productService = new ProductServiceImpl();
        categoryService = new CategoryServiceImpl();
        promotionService = new PromotionServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String categoryIdParam = req.getParameter("category");
        String searchQuery = req.getParameter("search");
        String sort = req.getParameter("sort");

        List<Product> products;

        try {
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                products = productService.searchProducts(searchQuery, sort);
            } else if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
                products = productService.getProductsByCategory(categoryIdParam, sort);
            } else {
                products = productService.getAllProducts(sort);
            }
        } catch (NumberFormatException e) {
            products = productService.getAllProducts(sort);
        }

        req.setAttribute("products", products);
        req.setAttribute("categories", categoryService.getAllCategories());
        req.setAttribute("promotions", promotionService.getActivePromotions());

        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
}
