package com.polycoffee.dao;

import java.util.List;
import com.polycoffee.entity.Products;

public interface IProductsDao {
    void create(Products entity);

    void update(Products entity);

    void delete(Long id);

    Products findById(int id);

    List<Products> findAll();

    List<Products> findByCategoryId(int categoryId);
}