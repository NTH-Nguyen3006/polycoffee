package com.polycoffee.dao;

import com.polycoffee.entity.Promotion;
import java.util.List;

public interface PromotionDAO {
    void insert(Promotion entity);
    void update(Promotion entity);
    void delete(Long id);
    Promotion findById(Long id);
    List<Promotion> findAll();
}
