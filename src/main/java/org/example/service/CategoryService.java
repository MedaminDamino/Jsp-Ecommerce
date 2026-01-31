package org.example.service;

import org.example.model.Category;
import java.util.List;

public interface CategoryService {
    List<Category> getAllCategories();
    Category getCategoryById(int id);
    void addCategory(String name, String description);
    void updateCategory(Category category);
    boolean deleteCategory(int id); // Returns true if deleted, false if failed (e.g. has products)
}
