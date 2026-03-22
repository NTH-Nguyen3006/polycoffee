package com.polycoffee.dao;

import java.util.List;
import com.polycoffee.entity.CartItems;

public interface ICartItemsDAO extends ICRUD<Integer, CartItems> {
    List<CartItems> findByCartId(int cartId);

    CartItems findByCartIdAndProductId(int cartId, int productId);

    void deleteByCartId(int cartId);
}