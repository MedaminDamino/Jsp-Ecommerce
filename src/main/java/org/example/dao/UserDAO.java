package org.example.dao;

import org.example.model.User;

public interface UserDAO {
    User authenticate(String email, String password);
    User findById(int id);
    boolean save(User user);
    java.util.List<User> findAll();
    void delete(int id);
}
