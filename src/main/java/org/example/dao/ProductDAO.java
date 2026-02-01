package org.example.dao;

import org.example.model.Product;
import java.util.List;

public interface ProductDAO {
    // Pagination Support
    long countAll();
    long countByCategory(int categoryId);
    long countSearch(String query);
    
    List<Product> findAll(int offset, int limit, String sort);
    List<Product> findByCategorySorted(int categoryId, int offset, int limit, String sort);
    List<Product> searchByNameSorted(String query, int offset, int limit, String sort);

    // Existing methods
    List<Product> findAll();
    List<Product> findByCategorySorted(int categoryId, String sort);
    List<Product> findByCategorySafe(int categoryId);
    List<Product> findAllSorted(String sort);
    List<Product> searchByNameSorted(String query, String sort);
    List<Product> searchByName(String query);
    Product findById(int id);
    void save(Product product);
    void update(Product product);
    void delete(int id);
}
