package com.polycoffee.dao.impl;

import com.polycoffee.entity.Promotion;
import org.junit.Test;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import static org.junit.Assert.*;

/**
 * Unit Test cho PromotionDAOImpl
 * Yêu cầu: SQL Server phải đang chạy và database PolyCoffee đã tồn tại
 */
public class PromotionDAOImplTest {

    private final PromotionDAOImpl dao = new PromotionDAOImpl();

    @Test
    public void testFindAll() {
        List<Promotion> list = dao.findAll();
        assertNotNull("findAll() không được trả về null", list);
        System.out.println("Tổng số promotions: " + list.size());
        for (Promotion p : list) {
            System.out.println(" - " + p.getId() + ": " + p.getCode() + " (" + p.getDiscountType() + ")");
        }
    }

    @Test
    public void testCreateAndFindById() {
        // Tạo promotion mới
        Promotion promo = Promotion.builder()
                .code("JUNIT_TEST_50")
                .discountType("PERCENT")
                .discountValue(new BigDecimal("50.00"))
                .minOrderValue(new BigDecimal("100000"))
                .startDate(LocalDateTime.now())
                .endDate(LocalDateTime.now().plusDays(30))
                .usageLimit(100)
                .build();
        dao.create(promo);
        assertNotNull("ID phải được tự động generate", promo.getId());
        System.out.println("Đã tạo promotion với ID: " + promo.getId());

        // Tìm lại bằng ID
        Promotion found = dao.findById(promo.getId());
        assertNotNull("findById phải tìm thấy promotion vừa tạo", found);
        assertEquals("JUNIT_TEST_50", found.getCode());
        assertEquals("PERCENT", found.getDiscountType());
        assertEquals(0, new BigDecimal("50.00").compareTo(found.getDiscountValue()));

        // Dọn dẹp
        dao.delete(promo.getId());
        System.out.println("Đã xoá promotion test ID: " + promo.getId());
    }

    @Test
    public void testUpdate() {
        // Tạo mới
        Promotion promo = Promotion.builder()
                .code("JUNIT_UPDATE")
                .discountType("FIXED")
                .discountValue(new BigDecimal("20000"))
                .minOrderValue(new BigDecimal("50000"))
                .startDate(LocalDateTime.now())
                .endDate(LocalDateTime.now().plusDays(7))
                .usageLimit(50)
                .build();
        dao.create(promo);

        // Update
        promo.setCode("JUNIT_UPDATED");
        promo.setDiscountValue(new BigDecimal("30000"));
        promo.setUsageLimit(200);
        dao.update(promo);

        // Kiểm tra
        Promotion updated = dao.findById(promo.getId());
        assertNotNull(updated);
        assertEquals("JUNIT_UPDATED", updated.getCode());
        assertEquals(0, new BigDecimal("30000").compareTo(updated.getDiscountValue()));
        assertEquals(Integer.valueOf(200), updated.getUsageLimit());

        // Dọn dẹp
        dao.delete(promo.getId());
    }

    @Test
    public void testDelete() {
        // Tạo mới
        Promotion promo = Promotion.builder()
                .code("JUNIT_DELETE")
                .discountType("PERCENT")
                .discountValue(new BigDecimal("10"))
                .startDate(LocalDateTime.now())
                .endDate(LocalDateTime.now().plusDays(1))
                .build();
        dao.create(promo);
        Long id = promo.getId();

        // Xoá
        dao.delete(id);

        // Kiểm tra
        Promotion deleted = dao.findById(id);
        assertNull("Promotion đã xoá phải trả về null", deleted);
        System.out.println("Delete thành công, ID " + id + " không còn tồn tại");
    }

    @Test
    public void testFindById_NotFound() {
        Promotion notFound = dao.findById(999999L);
        assertNull("ID không tồn tại phải trả về null", notFound);
    }
}
