package com.polycoffee.dao.impl;

import com.polycoffee.entity.Categories;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;

/**
 * Unit Test cho CategoryDAO
 * Yêu cầu: SQL Server phải đang chạy và database PolyCoffee đã tồn tại
 */
public class CategoryDAOTest {

    private final CategoryDAO dao = new CategoryDAO();

    @Test
    public void testFindAll() {
        List<Categories> list = dao.findAll();
        assertNotNull("findAll() không được trả về null", list);
        System.out.println("Tổng số categories: " + list.size());
        for (Categories c : list) {
            System.out.println(" - " + c.getId() + ": " + c.getName());
        }
    }

    @Test
    public void testCreateAndFindById() {
        // Tạo category mới
        Categories newCat = Categories.builder()
                .name("Test Category")
                .description("Dùng cho unit test")
                .build();
        dao.create(newCat);
        assertNotNull("ID phải được tự động generate sau khi create", newCat.getId());
        System.out.println("Đã tạo category với ID: " + newCat.getId());

        // Tìm lại bằng ID
        Categories found = dao.findById(newCat.getId());
        assertNotNull("findById phải tìm thấy category vừa tạo", found);
        assertEquals("Test Category", found.getName());
        assertEquals("Dùng cho unit test", found.getDescription());

        // Dọn dẹp
        dao.delete(newCat.getId());
        System.out.println("Đã xoá category test ID: " + newCat.getId());
    }

    @Test
    public void testUpdate() {
        // Tạo mới
        Categories cat = Categories.builder()
                .name("Trước Update")
                .description("Sẽ bị update")
                .build();
        dao.create(cat);

        // Update
        cat.setName("Sau Update");
        cat.setDescription("Đã update thành công");
        dao.update(cat);

        // Kiểm tra
        Categories updated = dao.findById(cat.getId());
        assertNotNull(updated);
        assertEquals("Sau Update", updated.getName());
        assertEquals("Đã update thành công", updated.getDescription());

        // Dọn dẹp
        dao.delete(cat.getId());
    }

    @Test
    public void testDelete() {
        // Tạo mới
        Categories cat = Categories.builder()
                .name("Sẽ bị xoá")
                .description("Test delete")
                .build();
        dao.create(cat);
        Long id = cat.getId();

        // Xoá
        dao.delete(id);

        // Kiểm tra đã xoá
        Categories deleted = dao.findById(id);
        assertNull("Category đã xoá phải trả về null", deleted);
        System.out.println("Delete thành công, ID " + id + " không còn tồn tại");
    }

    @Test
    public void testFindById_NotFound() {
        Categories notFound = dao.findById(999999L);
        assertNull("ID không tồn tại phải trả về null", notFound);
    }
}
