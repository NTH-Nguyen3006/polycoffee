package com.polycoffee.dao;

import java.util.List;
import com.polycoffee.entity.ProductOptions;

public interface ProductOptionsDAO {
    void create(ProductOptions entity);

    void update(ProductOptions entity);

    void delete(int id);

    ProductOptions findById(int id);

    List<ProductOptions> findByProductId(int productId);
}