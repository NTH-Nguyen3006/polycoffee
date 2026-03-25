package com.polycoffee.dao.impl;

import com.polycoffee.entity.Users;
import com.polycoffee.enums.UserRole;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;

/**
 * Unit Test cho UserDAO
 * Yêu cầu: SQL Server phải đang chạy và database PolyCoffee đã tồn tại
 */
public class UserDAOTest {

    private final UserDAO dao = new UserDAO();

    @Test
    public void testFindAll() {
        List<Users> list = dao.findAll();
        assertNotNull("findAll() không được trả về null", list);
        System.out.println("Tổng số users: " + list.size());
        for (Users u : list) {
            System.out.println(" - " + u.getId() + ": " + u.getUsername() + " (" + u.getRole() + ")");
        }
    }

    @Test
    public void testCreateAndFindById() {
        // Tạo user mới
        Users newUser = Users.builder()
                .username("testuser_junit")
                .fullname("JUnit Tester")
                .email("junit@test.com")
                .password("123456")
                .phone("123456789")
                .role(UserRole.USER)
                .active(true)
                .build();
        dao.create(newUser);
        assertNotNull("ID phải được tự động generate (UUID)", newUser.getId());
        System.out.println("Đã tạo user với UUID: " + newUser.getId());

        // Tìm lại bằng UUID
        Users found = dao.findById(newUser.getId());
        assertNotNull("findById phải tìm thấy user vừa tạo", found);
        assertEquals("testuser_junit", found.getUsername());
        assertEquals("JUnit Tester", found.getFullname());
        assertEquals(UserRole.USER, found.getRole());

        // Dọn dẹp
        dao.delete(newUser.getId());
        System.out.println("Đã xoá user test UUID: " + newUser.getId());
    }

    @Test
    public void testFindByUsername() {
        // Tạo user
        Users user = Users.builder()
                .username("findme_junit")
                .fullname("Find Me")
                .email("findme@test.com")
                .password("abcdef")
                .phone("987654321")
                .role(UserRole.EMPLOYEE)
                .active(true)
                .build();
        dao.create(user);

        // Tìm theo username
        Users found = dao.findByUsername("findme_junit");
        assertNotNull("findByUsername phải tìm thấy user", found);
        assertEquals("Find Me", found.getFullname());

        // Tìm username không tồn tại
        Users notFound = dao.findByUsername("khong_co_ai_nhu_nay");
        assertNull("Username không tồn tại phải trả về null", notFound);

        // Dọn dẹp
        dao.delete(user.getId());
    }

    @Test
    public void testUpdate() {
        // Tạo mới
        Users user = Users.builder()
                .username("update_junit")
                .fullname("Trước Update")
                .email("update@test.com")
                .password("old123")
                .phone("111111111")
                .role(UserRole.USER)
                .active(true)
                .build();
        dao.create(user);

        // Update
        user.setFullname("Sau Update");
        user.setRole(UserRole.ADMIN);
        dao.update(user);

        // Kiểm tra
        Users updated = dao.findById(user.getId());
        assertNotNull(updated);
        assertEquals("Sau Update", updated.getFullname());
        assertEquals(UserRole.ADMIN, updated.getRole());

        // Dọn dẹp
        dao.delete(user.getId());
    }

    @Test
    public void testDelete() {
        // Tạo mới
        Users user = Users.builder()
                .username("delete_junit")
                .fullname("Sẽ bị xoá")
                .email("delete@test.com")
                .password("del123")
                .phone("222222222")
                .role(UserRole.USER)
                .active(true)
                .build();
        dao.create(user);

        // Xoá
        dao.delete(user.getId());

        // Kiểm tra
        Users deleted = dao.findById(user.getId());
        assertNull("User đã xoá phải trả về null", deleted);
        System.out.println("Delete thành công");
    }
}
