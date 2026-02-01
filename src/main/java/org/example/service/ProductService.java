package org.example.service;

import org.example.model.Product;
import java.util.List;

public interface ProductService {
    // Pagination
    long getTotalCount(String categoryId, String searchQuery);
    List<Product> getProducts(int page, int pageSize, String sort, String categoryId, String searchQuery);

    List<Product> getAllProducts();
    List<Product> getAllProducts(String sort);
    List<Product> getProductsByCategory(String categoryId);
    List<Product> getProductsByCategory(String categoryId, String sort);
    List<Product> searchProducts(String query);
    List<Product> searchProducts(String query, String sort);
    Product getProductById(String id);
    void addProduct(String name, String description, double price, int categoryId, String imageUrl);
    void updateProduct(Product product);
    void deleteProduct(String id);
}
