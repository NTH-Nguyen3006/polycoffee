package com.polycoffee.entity;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Entity
@Table(name = "Cart_Items")
@NoArgsConstructor
@AllArgsConstructor
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CartItems {

    @Id
    int id;

    @Column(name = "cart_id")
    int cartId;

    @ManyToOne
    @JoinColumn(name = "cart_id", insertable = false, updatable = false)
    Carts cart;

    @Column(name = "product_id")
    int productId;

    @ManyToOne
    @JoinColumn(name = "product_id", insertable = false, updatable = false)
    Products product;

    int quantity;

    @Column(name = "selected_options")
    String selectedOptions;

    @Column(name = "sub_total")
    BigDecimal subTotal;
}