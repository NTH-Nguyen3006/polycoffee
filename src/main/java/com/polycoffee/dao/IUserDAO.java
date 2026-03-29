package com.polycoffee.dao;

import java.util.List;
import java.util.UUID;
import com.polycoffee.entity.Users;

public interface IUserDAO extends ICRUD<UUID, Users> {
    Users findByUsername(String username);

    Users findByEmail(String email);

    Users findByResetToken(String token);

    List<Users> searchAndPaginate(String name, String email, Boolean active, int page, int pageSize);

    long countSearch(String name, String email, Boolean active);

    default Users findById(String id) {
        return findById(UUID.fromString(id));
    }

    default void delete(String id) {
        delete(UUID.fromString(id));
    }
}