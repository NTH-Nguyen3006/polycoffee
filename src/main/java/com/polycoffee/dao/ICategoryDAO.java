package com.polycoffee.dao;

import com.polycoffee.entity.Categories;

public interface ICategoryDAO extends ICRUD<Long, Categories> {

    default Categories findById(String id) {
        return findById(Long.valueOf(id));
    }

    default void delete(String id) {
        delete(Long.valueOf(id));
    }
}
