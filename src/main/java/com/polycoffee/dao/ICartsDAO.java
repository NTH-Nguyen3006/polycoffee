package com.polycoffee.dao;

import java.util.List;
import java.util.UUID;
import com.polycoffee.entity.Carts;

public interface ICartsDAO extends ICRUD<UUID, Carts> {
    List<Carts> findByUserId(UUID userId);

    default List<Carts> findByUserId(String userIdStr) {
        return findByUserId(UUID.fromString(userIdStr));
    }

    default Carts findById(String id) {
        return findById(UUID.fromString(id));
    }

    default void delete(String id) {
        delete(UUID.fromString(id));
    }
}