package com.polycoffee.dao;

import java.util.UUID;
import com.polycoffee.entity.Users;

public interface IUserDAO extends ICRUD<UUID, Users> {
    default Users findById(String id) {
        return findById(UUID.fromString(id));
    }

    default void delete(String id) {
        delete(UUID.fromString(id));
    }
}


