package org.example.service.impl;

import org.example.dao.UserDAO;
import org.example.dao.impl.UserDAOImpl;
import org.example.model.User;
import org.example.service.UserService;

public class UserServiceImpl implements UserService {

    private final UserDAO userDAO;

    public UserServiceImpl() {
        this.userDAO = new UserDAOImpl();
    }

    @Override
    public User authenticate(String email, String pwd) {
        return userDAO.authenticate(email, pwd);
    }
    
    @Override
    public boolean register(User user) {
        // Simple validation
        if (user.getEmail() == null || user.getPassword() == null) {
            return false;
        }
        
        // Hash password before saving
        String hashedPassword = org.example.util.SecurityUtil.hashPassword(user.getPassword());
        user.setPassword(hashedPassword);
        
        // Set default role if not provided
        if (user.getRole() == null || user.getRole().isEmpty()) {
            user.setRole("CUSTOMER");
        }
        
        return userDAO.save(user);
    }
}
