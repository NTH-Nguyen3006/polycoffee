package com.polycoffee.dao;

import java.util.List;
import com.polycoffee.entity.Products;

public interface ProductsDao {
    void create(Products entity);

    void update(Products entity);

    void delete(int id);

    Products findById(int id);

    List<Products> findAll();

    List<Products> findByCategoryId(int categoryId);
}