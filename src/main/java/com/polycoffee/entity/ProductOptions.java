package com.polycoffee.entity;

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
@Table(name = "PRODUCT_OPTIONS")
@NoArgsConstructor
@AllArgsConstructor
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductOptions {
    @Id
    int id;

    @Column(name = "product_id")
    int productId;

    @ManyToOne
    @JoinColumn(name = "product_id", insertable = false, updatable = false)
    Products product;

    @Column(name = "option_group")
    String optionGroup;

    @Column(name = "option_name")
    String optionName;

    @Column(name = "additional_price")
    double additionalPrice;
}