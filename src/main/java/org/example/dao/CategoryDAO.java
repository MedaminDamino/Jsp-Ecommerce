package org.example.dao;

import org.example.model.Category;
import java.util.List;

public interface CategoryDAO {
    List<Category> findAll();
    Category findById(int id);
    void save(Category category);
    void update(Category category);
    void delete(int id);
    boolean hasProducts(int id);
}
