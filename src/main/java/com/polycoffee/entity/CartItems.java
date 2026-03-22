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
@Table(name = "Cart_Items")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class CartItems {

    @Id
    private int id; // PK

    @Column(name = "cart_id")
    private int cartId; // FK

    @Column(name = "product_id")
    private int productId; // FK

    private int quantity;

    @Column(name = "selected_options", columnDefinition = "json")
    private String selectedOptions; 
    // Trong Java, dữ liệu JSON thường được nhận diện là String hoặc dùng thư viện Jackson/Gson để xử lý.

    @Column(name = "sub_total")
    private BigDecimal subTotal; 
    // Khớp với kiểu 'decimal' trong hình
}