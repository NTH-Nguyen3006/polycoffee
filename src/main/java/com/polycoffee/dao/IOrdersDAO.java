package com.polycoffee.dao;

import java.util.List;
import java.util.UUID;
import com.polycoffee.entity.Orders;

public interface IOrdersDAO extends ICRUD<Long, Orders> {
    Orders findByCode(String code);

    List<Orders> findByUserId(UUID userId);

    default List<Orders> findByUserId(String userIdStr) {
        return findByUserId(UUID.fromString(userIdStr));
    }

    void updateStatus(Long id, String newStatus);
}