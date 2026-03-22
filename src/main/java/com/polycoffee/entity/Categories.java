package com.polycoffee.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Categories {
    @Id
    int id;

    @Column(columnDefinition = "NVARCHAR(50)")
    String name;

    @Column(columnDefinition = "NVARCHAR(MAX)")
    String description;
}
