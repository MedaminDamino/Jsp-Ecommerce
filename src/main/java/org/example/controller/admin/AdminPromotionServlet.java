package org.example.controller.admin;

import org.example.model.Promotion;
import org.example.service.PromotionService;
import org.example.service.impl.PromotionServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "AdminPromotionServlet", urlPatterns = {"/admin/promotions"})
public class AdminPromotionServlet extends HttpServlet {

    private PromotionService promotionService;
    private org.example.service.ProductService productService;

    @Override
    public void init() throws ServletException {
        promotionService = new PromotionServiceImpl();
        productService = new org.example.service.impl.ProductServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("getProducts".equals(action)) {
            int promoId = Integer.parseInt(req.getParameter("id"));
            List<Integer> linkedProductIds = promotionService.getProductIdsForPromotion(promoId);
            resp.setContentType("application/json");
            resp.getWriter().write(linkedProductIds.toString());
            return;
        }

        req.setAttribute("promotions", promotionService.getAllPromotions());
        req.setAttribute("products", productService.getAllProducts());
        req.getRequestDispatcher("promotions.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("add".equals(action) || "update".equals(action)) {
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            boolean active = req.getParameter("active") != null;
            Promotion.DiscountType type = Promotion.DiscountType.valueOf(req.getParameter("discountType"));
            double value = Double.parseDouble(req.getParameter("discountValue"));
            LocalDate endDate = LocalDate.parse(req.getParameter("endDate"));
            String[] productIds = req.getParameterValues("productIds");

            if ("add".equals(action)) {
                promotionService.addPromotion(new Promotion(0, title, description, active, type, value, endDate), productIds);
                resp.sendRedirect("promotions?success=Promotion Added");
            } else {
                int id = Integer.parseInt(req.getParameter("id"));
                promotionService.updatePromotion(new Promotion(id, title, description, active, type, value, endDate), productIds);
                resp.sendRedirect("promotions?success=Promotion Updated");
            }

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            promotionService.deletePromotion(id);
            resp.sendRedirect("promotions?success=Promotion Deleted");
        }
    }
}
