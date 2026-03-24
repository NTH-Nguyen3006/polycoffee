package com.polycoffee.dao;

import java.util.List;
import java.util.UUID;
import com.polycoffee.entity.Products;

public interface IProductsDao extends ICRUD<UUID, Products> {
    List<Products> findByCategoryId(Long categoryId);

    default Products findById(String id) {
        return findById(UUID.fromString(id));
    }

    default void delete(String id) {
        delete(UUID.fromString(id));
    }
}