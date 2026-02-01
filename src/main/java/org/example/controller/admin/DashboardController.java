package org.example.controller.admin;

import org.example.service.ProductService;
import org.example.service.impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DashboardController", urlPatterns = {"/admin/dashboard"})
public class DashboardController extends HttpServlet {

    private ProductService productService;
    private org.example.service.CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        productService = new ProductServiceImpl();
        categoryService = new org.example.service.impl.CategoryServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pageParam = req.getParameter("page");
        int page = 1;
        int pageSize = 10;
        
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        // Fetch paginated products
        // Signature: getProducts(int page, int pageSize, String sort, String categoryId, String searchQuery)
        req.setAttribute("productList", productService.getProducts(page, pageSize, "latest", null, null));
        
        // Calculate total pages
        long totalProducts = productService.getTotalCount(null, null);
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("categories", categoryService.getAllCategories());
        
        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
    }
}
