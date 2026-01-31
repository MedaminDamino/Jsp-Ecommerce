package org.example.service;

import org.example.model.User;

public interface UserService {
    User authenticate(String email, String pwd);
    boolean register(User user);
    java.util.List<User> getAllUsers();
    void deleteUser(int id);
    void updateUserRole(int id, String role);
}
