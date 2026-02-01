package org.example.controller.admin;

import org.example.model.Product;
import org.example.service.ProductService;
import org.example.service.impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

@WebServlet(name = "ProductController", urlPatterns = {"/admin/products"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class ProductController extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductServiceImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            if ("add".equals(action) || "update".equals(action)) {
                String name = req.getParameter("name");
                String description = req.getParameter("description");
                double price = Double.parseDouble(req.getParameter("price"));
                int categoryId = Integer.parseInt(req.getParameter("categoryId"));
                
                String imageUrl = req.getParameter("oldImageUrl"); // Keep old one if no new file is uploaded
                
                Part filePart = req.getPart("imageFile");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = UUID.randomUUID().toString() + "_" + getFileName(filePart);
                    String uploadPath = getServletContext().getRealPath("/assets/uploads/products");
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs();
                    
                    filePart.write(uploadPath + File.separator + fileName);
                    imageUrl = req.getContextPath() + "/assets/uploads/products/" + fileName;
                }

                if ("add".equals(action)) {
                    productService.addProduct(name, description, price, categoryId, imageUrl);
                    resp.sendRedirect("dashboard?success=Product Added");
                } else {
                    int id = Integer.parseInt(req.getParameter("id"));
                    productService.updateProduct(new Product(id, name, description, price, categoryId, imageUrl));
                    resp.sendRedirect("dashboard?success=Product Updated");
                }

            } else if ("delete".equals(action)) {
                String id = req.getParameter("id");
                productService.deleteProduct(id);
                resp.sendRedirect("dashboard?success=Product Deleted");
            }
        } catch (IllegalArgumentException e) {
            resp.sendRedirect("dashboard?error=" + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("dashboard?error=An unexpected error occurred");
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}
