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
}
