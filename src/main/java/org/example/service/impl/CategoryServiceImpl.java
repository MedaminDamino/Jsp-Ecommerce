package org.example.service.impl;

import org.example.dao.CategoryDAO;
import org.example.dao.impl.CategoryDAOImpl;
import org.example.model.Category;
import org.example.service.CategoryService;

import java.util.List;

public class CategoryServiceImpl implements CategoryService {

    private final CategoryDAO categoryDAO;

    public CategoryServiceImpl() {
        this.categoryDAO = new CategoryDAOImpl();
    }

    @Override
    public List<Category> getAllCategories() {
        return categoryDAO.findAll();
    }

    @Override
    public Category getCategoryById(int id) {
        return categoryDAO.findById(id);
    }

    @Override
    public void addCategory(String name, String description) {
         if (name != null && !name.trim().isEmpty()) {
             categoryDAO.save(new Category(0, name.trim()));
         }
    }

    @Override
    public void updateCategory(Category category) {
        categoryDAO.update(category);
    }

    @Override
    public boolean deleteCategory(int id) {
        if (categoryDAO.hasProducts(id)) {
            return false;
        }
        categoryDAO.delete(id);
        return true;
    }
}
