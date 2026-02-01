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

        // Pagination
        int page = 1;
        int limit = 9;
        try {
            String pageParam = req.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            // ignore
        }
        if (page < 1) page = 1;

        // Fetch Data
        long totalItems = productService.getTotalCount(categoryIdParam, searchQuery);
        List<Product> products = productService.getProducts(page, limit, sort, categoryIdParam, searchQuery);
        int totalPages = (int) Math.ceil((double) totalItems / limit);

        req.setAttribute("products", products);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalItems", totalItems);
        req.setAttribute("categories", categoryService.getAllCategories());
        req.setAttribute("promotions", promotionService.getActivePromotions());

        req.getRequestDispatcher("/WEB-INF/views/public/index.jsp").forward(req, resp);
    }
}
