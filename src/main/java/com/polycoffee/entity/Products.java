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
@Table(name = "PRODUCTS")
@NoArgsConstructor
@AllArgsConstructor
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Products {
    @Id
    int id;

    @Column(name = "category_id")
    int categoryId;

    @ManyToOne
    @JoinColumn(name = "category_id", insertable = false, updatable = false)
    Categories category;

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