package com.polycoffee.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "PRODUCT_OPTIONS")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class ProductOptions {
    @Id
    int id;

    @Column(name = "product_id")
    int productId;

    @Column(name = "option_group")
    String optionGroup;

    @Column(name = "option_name")
    String optionName;

    @Column(name = "additional_price")
    double additionalPrice;
}