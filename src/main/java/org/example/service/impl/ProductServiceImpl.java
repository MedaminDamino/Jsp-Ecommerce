package org.example.service.impl;

import org.example.dao.ProductDAO;
import org.example.dao.impl.ProductDAOImpl;
import org.example.model.Product;
import org.example.service.ProductService;

import java.util.Collections;
import java.util.List;

public class ProductServiceImpl implements ProductService {

    private final ProductDAO productDAO;

    public ProductServiceImpl() {
        this.productDAO = new ProductDAOImpl();
    }

    @Override
    public long getTotalCount(String categoryId, String searchQuery) {
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            return productDAO.countSearch(searchQuery);
        } else if (categoryId != null && !categoryId.trim().isEmpty()) {
            try {
                return productDAO.countByCategory(Integer.parseInt(categoryId));
            } catch (NumberFormatException e) {
                return 0;
            }
        } else {
            return productDAO.countAll();
        }
    }

    @Override
    public List<Product> getProducts(int page, int pageSize, String sort, String categoryId, String searchQuery) {
        int offset = (page - 1) * pageSize;
        if (offset < 0) offset = 0;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            return productDAO.searchByNameSorted(searchQuery, offset, pageSize, sort);
        } else if (categoryId != null && !categoryId.trim().isEmpty()) {
             try {
                int cid = Integer.parseInt(categoryId);
                return productDAO.findByCategorySorted(cid, offset, pageSize, sort);
            } catch (NumberFormatException e) {
                return Collections.emptyList();
            }
        } else {
            return productDAO.findAll(offset, pageSize, sort);
        }
    }

    @Override
    public List<Product> getAllProducts() {
        return getAllProducts(null);
    }

    @Override
    public List<Product> getAllProducts(String sort) {
        return productDAO.findAllSorted(sort);
    }

    @Override
    public List<Product> getProductsByCategory(String categoryId) {
        return getProductsByCategory(categoryId, null);
    }

    @Override
    public List<Product> getProductsByCategory(String categoryId, String sort) {
        if (categoryId == null || categoryId.trim().isEmpty()) {
            return Collections.emptyList();
        }
        try {
            int id = Integer.parseInt(categoryId);
            return productDAO.findByCategorySorted(id, sort);
        } catch (NumberFormatException e) {
            return Collections.emptyList();
        }
    }

    @Override
    public List<Product> searchProducts(String query) {
        return searchProducts(query, null);
    }

    @Override
    public List<Product> searchProducts(String query, String sort) {
        if (query == null || query.trim().isEmpty()) {
            return Collections.emptyList();
        }
        return productDAO.searchByNameSorted(query, sort);
    }

    @Override
    public Product getProductById(String id) {
        if (id == null) return null;
        try {
            int pid = Integer.parseInt(id);
            return productDAO.findById(pid);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    @Override
    public void addProduct(String name, String description, double price, int categoryId, String imageUrl) {
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("Product name cannot be empty");
        }
        if (price < 0) {
            throw new IllegalArgumentException("Price cannot be negative");
        }
        // description is optional, so we don't validate it
        Product p = new Product(0, name, description, price, categoryId, imageUrl);
        productDAO.save(p);
    }

    @Override
    public void updateProduct(Product product) {
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Product name cannot be empty");
        }
        if (product.getPrice() < 0) {
            throw new IllegalArgumentException("Price cannot be negative");
        }
        productDAO.update(product);
    }

    @Override
    public void deleteProduct(String id) {
        if (id != null) {
            try {
                int pid = Integer.parseInt(id);
                productDAO.delete(pid);
            } catch (NumberFormatException e) {
                // ignore
            }
        }
    }
}
