package com.polycoffee.entity;

import java.time.LocalDateTime;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

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
@Table(name = "Users") // Khớp với tên bảng trong SQL
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

    @Column(nullable = false)
    String password;

    @Column(columnDefinition = "VARCHAR(10)") // SQL bạn để 10, Entity cũ để 9, tôi chỉnh lại 10
    String phone;

    @Enumerated(EnumType.ORDINAL) // QUAN TRỌNG: Lưu số 0, 1, 2 vào DB để phân quyền
    @Column(name = "role")
    UserRole role;

    @Column(name = "is_active", columnDefinition = "BIT DEFAULT 1")
    boolean active;

    @CreationTimestamp
    @Column(name = "create_at", updatable = false) // Khớp với create_at trong SQL
    LocalDateTime createdAt;
}