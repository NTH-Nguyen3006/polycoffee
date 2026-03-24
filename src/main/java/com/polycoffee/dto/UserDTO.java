package com.polycoffee.dto;

import java.time.LocalDateTime;
import java.util.UUID;

import com.polycoffee.enums.UserRole;

public record UserDTO(
    UUID id,
    String username,
    String fullname,
    String email,
    String phone,
    UserRole role,
    boolean active,
    LocalDateTime createdAt
) {}
