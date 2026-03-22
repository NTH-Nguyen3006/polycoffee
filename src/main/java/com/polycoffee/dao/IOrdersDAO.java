package com.polycoffee.dao;

import java.util.List;
import com.polycoffee.entity.Orders;

public interface IOrdersDAO extends ICRUD<Integer, Orders> {
    Orders findByCode(String code);

    List<Orders> findByUserId(int userId);

    void updateStatus(int id, String newStatus);
}