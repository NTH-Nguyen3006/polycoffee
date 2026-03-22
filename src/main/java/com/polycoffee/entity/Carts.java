package com.polycoffee.entity;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "Carts")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Carts {

    @Id
    private int id; // PK

    @Column(name = "user_id")
    private int userId; // FK

    @Column(name = "total_items")
    private int totalItems;

    @Column(name = "temp_total_price")
    private BigDecimal tempTotalPrice; 
    // Dùng BigDecimal cho kiểu 'decimal' trong database để tránh sai số tài chính
}