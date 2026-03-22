package com.polycoffee.entity;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import org.hibernate.annotations.CreationTimestamp;

import com.polycoffee.enums.UserRole;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Users {
    @Id
    String id;

    @Column(columnDefinition = "NVARCHAR(50)")
    String fullname;

    @Column(columnDefinition = "VARCHAR(25)")
    String email;

    String password;

    @Column(columnDefinition = "VARCHAR(10)")
    String phone;

    UserRole role;

    @Column(columnDefinition = "BIT")
    boolean is_active;

    @CreationTimestamp
    LocalDateTime create_at;
}

