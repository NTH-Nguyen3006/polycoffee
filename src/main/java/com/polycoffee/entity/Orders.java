package com.polycoffee.entity;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "Orders")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Orders {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id; // PK

    @Column(name = "user_id")
    private int userId; // FK

    @Column(name = "promotion_id")
    private Integer promotionId; // FK (Dùng Integer để có thể null nếu không áp mã)

    @Column(name = "order_code")
    private String orderCode;

    @Column(name = "total_amount")
    private BigDecimal totalAmount;

    @Column(name = "shipping_address")
    private String shippingAddress;

    private String status;

    @Column(name = "payment_status")
    private String paymentStatus;

    private String note; // Kiểu text ánh xạ thành String
}