package org.example.dao;

import org.example.model.Product;
import java.util.List;

public interface ProductDAO {
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
