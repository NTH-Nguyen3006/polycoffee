package com.polycoffee.entity;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
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
@Table(name = "Orders")
@NoArgsConstructor
@AllArgsConstructor
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Orders {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @Column(name = "user_id")
    String userId;

    @ManyToOne
    @JoinColumn(name = "user_id", insertable = false, updatable = false)
    Users user;

    @Column(name = "promotion_id")
    Long promotionId;

    @ManyToOne
    @JoinColumn(name = "promotion_id", insertable = false, updatable = false)
    Promotion promotion;

    @Column(name = "order_code")
    String orderCode;

    @Column(name = "total_amount")
    BigDecimal totalAmount;

    @Column(name = "shipping_address")
    String shippingAddress;

    String status;

    @Column(name = "payment_status")
    String paymentStatus;

    String note;
}