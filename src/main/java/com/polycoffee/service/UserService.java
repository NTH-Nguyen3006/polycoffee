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
                .username(dto.getUsername())
                .fullname(dto.getFullname())
                .email(dto.getEmail())
                .phone(dto.getPhone())
                .role(dto.getRole())
                .active(dto.isActive())
                .password(password)
                .build();
        userDAO.create(u);
    }

    public void update(UserDTO dto) {
        Users existing = userDAO.findById(dto.getId());
        if (existing != null) {
            existing.setUsername(dto.getUsername());
            existing.setFullname(dto.getFullname());
            existing.setEmail(dto.getEmail());
            existing.setPhone(dto.getPhone());
            existing.setRole(dto.getRole());
            existing.setActive(dto.isActive());
            userDAO.update(existing);
        }
    }

    public List<UserDTO> searchAndPaginate(String name, String email, Boolean active, int page, int pageSize) {
        return userDAO.searchAndPaginate(name, email, active, page, pageSize).stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    public long countSearch(String name, String email, Boolean active) {
        return userDAO.countSearch(name, email, active);
    }

    public void resetPassword(UUID id) {
        Users u = userDAO.findById(id);
        if (u != null) {
            String newPass = Long.toHexString(Double.doubleToLongBits(Math.random())).substring(0, 8);
            u.setPassword(newPass);
            userDAO.update(u);
            
            String subject = "Mật khẩu mới đã được cấp lại - PolyCoffee";
            String body = String.format("Chào %s,\n\nMật khẩu của bạn đã được quản trị viên đặt lại.\nMật khẩu mới là: %s\n\nVui lòng đăng nhập và đổi mật khẩu ngay.", u.getFullname(), newPass);
            com.polycoffee.utils.MailerService.send(u.getEmail(), subject, body);
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
