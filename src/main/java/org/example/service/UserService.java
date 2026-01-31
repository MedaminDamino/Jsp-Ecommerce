package org.example.service;

import org.example.model.User;

public interface UserService {
    User authenticate(String email, String pwd);
    boolean register(User user);
}
