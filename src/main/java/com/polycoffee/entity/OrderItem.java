package com.polycoffee.entity;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "ORDER_ITEMS")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OrderItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @Column(name = "order_id")
    Long orderId;

    @ManyToOne
    @JoinColumn(name = "order_id", insertable = false, updatable = false)
    Orders order;

    @Column(name = "product_name")
    String productName;

    Integer quantity;

    BigDecimal price;

    @Column(name = "options_snapshot", columnDefinition = "TEXT")
    String optionsSnapshot;
}
