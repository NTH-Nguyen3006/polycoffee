package com.polycoffee.entity;

import java.time.LocalDateTime;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.GenericGenerator;

import com.polycoffee.enums.UserRole;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Builder
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Users {
    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(name = "UUID", strategy = "org.hibernate.id.UUIDGenerator")
    @Column(name = "id", updatable = false, nullable = false)
    UUID id;

    @Column(columnDefinition = "NVARCHAR(20)", unique = true)
    String username;

    @Column(columnDefinition = "NVARCHAR(50)")
    String fullname;

    @Column(columnDefinition = "VARCHAR(25)", unique = true)
    String email;

    String password;

    @Column(columnDefinition = "VARCHAR(9)")
    String phone; // khử số 0

    UserRole role;

    @Column(columnDefinition = "BIT")
    boolean active;

    @CreationTimestamp
    @Column(name = "created_at")
    LocalDateTime createdAt;
}
