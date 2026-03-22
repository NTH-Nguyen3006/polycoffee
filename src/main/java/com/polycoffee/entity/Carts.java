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
@Table(name = "Carts")
@NoArgsConstructor
@AllArgsConstructor
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Carts {

    @Id
    int id;

    @Column(name = "user_id")
    String userId;

    @ManyToOne
    @JoinColumn(name = "user_id", insertable = false, updatable = false)
    Users user;

    @Column(name = "selected_options")
    String selectedOptions;

    @Column(name = "total_items")
    int totalItems;

    @Column(name = "temp_total_price")
    BigDecimal tempTotalPrice;
}