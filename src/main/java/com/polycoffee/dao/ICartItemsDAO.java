package com.polycoffee.dao;

import java.util.List;
import java.util.UUID;
import com.polycoffee.entity.CartItems;

public interface ICartItemsDAO extends ICRUD<Long, CartItems> {
    List<CartItems> findByCartId(UUID cartId);

    default List<CartItems> findByCartId(String cartIdStr) {
        return findByCartId(UUID.fromString(cartIdStr));
    }

    CartItems findByCartIdAndProductId(UUID cartId, UUID productId);

    default CartItems findByCartIdAndProductId(String cartIdStr, String productIdStr) {
        return findByCartIdAndProductId(UUID.fromString(cartIdStr), UUID.fromString(productIdStr));
    }

    void deleteByCartId(UUID cartId);

    default void deleteByCartId(String cartIdStr) {
        deleteByCartId(UUID.fromString(cartIdStr));
    }
}