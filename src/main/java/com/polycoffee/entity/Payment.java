package com.polycoffee.entity;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "PAYMENTS")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @Column(name = "order_id")
    Long orderId;

    @ManyToOne
    @JoinColumn(name = "order_id", insertable = false, updatable = false)
    Orders order;

    @Column(name = "payment_method")
    String paymentMethod;

    @Column(name = "transaction_id")
    String transactionId;

    BigDecimal amount;

    @Column(name = "payment_date")
    LocalDateTime paymentDate;
}
