package com.polycoffee.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Categories {
    @Id
    int id;

    @Column(columnDefinition = "NVARCHAR(50)")
    String name;

    @Column(columnDefinition = "NVARCHAR(MAX)")
    String description;
}
