package com.polycoffee.dao;

import java.util.List;
import com.polycoffee.entity.Carts;

public interface ICartsDAO extends CRUD<Integer, Carts> {
    List<Carts> findByUserId(int userId);
}