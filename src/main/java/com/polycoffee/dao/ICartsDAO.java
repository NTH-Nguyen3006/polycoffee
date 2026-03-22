package com.polycoffee.dao;

import java.util.List;
import com.polycoffee.entity.Carts;

public interface ICartsDAO extends ICRUD<Integer, Carts> {
    List<Carts> findByUserId(int userId);
}