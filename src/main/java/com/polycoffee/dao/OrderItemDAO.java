package com.polycoffee.dao;

import com.polycoffee.entity.OrderItem;
import java.util.List;

public interface OrderItemDAO {
    void insert(OrderItem entity);
    void update(OrderItem entity);
    void delete(Long id);
    OrderItem findById(Long id);
    List<OrderItem> findAll();
}
