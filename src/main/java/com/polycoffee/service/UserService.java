package com.polycoffee.service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import com.polycoffee.dao.IUserDAO;
import com.polycoffee.dao.impl.UserDAO;
import com.polycoffee.dto.UserDTO;
import com.polycoffee.entity.Users;

public class UserService {

    private final IUserDAO userDAO = new UserDAO();

    public List<UserDTO> findAll() {
        return userDAO.findAll().stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    public UserDTO findById(UUID id) {
        Users u = userDAO.findById(id);
        return u != null ? toDTO(u) : null;
    }

    public void create(UserDTO dto, String password) {
        Users u = Users.builder()
                .username(dto.username())
                .fullname(dto.fullname())
                .email(dto.email())
                .phone(dto.phone())
                .role(dto.role())
                .active(dto.active())
                .password(password)
                .build();
        userDAO.create(u);
    }

    public void update(UserDTO dto) {
        Users existing = userDAO.findById(dto.id());
        if (existing != null) {
            existing.setUsername(dto.username());
            existing.setFullname(dto.fullname());
            existing.setEmail(dto.email());
            existing.setPhone(dto.phone());
            existing.setRole(dto.role());
            existing.setActive(dto.active());
            userDAO.update(existing);
        }
    }

    public void delete(UUID id) {
        userDAO.delete(id);
    }

    private UserDTO toDTO(Users u) {
        return new UserDTO(
                u.getId(),
                u.getUsername(),
                u.getFullname(),
                u.getEmail(),
                u.getPhone(),
                u.getRole(),
                u.isActive(),
                u.getCreatedAt()
        );
    }
}
