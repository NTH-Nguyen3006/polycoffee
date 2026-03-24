package com.polycoffee.dao;

import java.util.List;
import java.util.UUID;
import com.polycoffee.entity.ProductOptions;

public interface IProductOptionsDAO {
    void create(ProductOptions entity);

    void update(ProductOptions entity);

    void delete(Long id);

    ProductOptions findById(Long id);

    List<ProductOptions> findByProductId(UUID productId);

    default List<ProductOptions> findByProductId(String productIdStr) {
        return findByProductId(UUID.fromString(productIdStr));
    }
}