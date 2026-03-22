package com.polycoffee.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "PRODUCTS")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Products {
    @Id
    int id;

    @Column(name = "category_id")
    int categoryId;

    String name;

    @Column(name = "base_price")
    double basePrice;

    String description;

    @Column(name = "thumbnail_url")
    String thumbnailUrl;

    @Column(name = "is_available")
    boolean isAvailable;

    @Column(name = "is_featured")
    boolean isFeatured;
}