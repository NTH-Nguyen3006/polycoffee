package com.polycoffee.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import com.polycoffee.entity.Orders;

public interface IOrdersDAO extends ICRUD<Long, Orders> {
    Orders findByCode(String code);

    List<Orders> findByUserId(UUID userId);

    default List<Orders> findByUserId(String userIdStr) {
        return findByUserId(UUID.fromString(userIdStr));
    }

    void updateStatus(Long id, String newStatus);

    void updatePaymentStatus(Long id, String paymentStatus);

    void createWithItems(Orders order, java.util.List<java.util.Map<String, Object>> items);
    // Pagination
    List<Orders> findAllPaginated(String status, int page, int pageSize);
    long countAll(String status);

    // Bài 2: Top 5 sản phẩm bán chạy
    List<Object[]> findTop5BestSelling(LocalDateTime from, LocalDateTime to);

    // Bài 3: Thống kê doanh thu
    List<Object[]> getRevenueByDay(LocalDateTime from, LocalDateTime to);
    List<Object[]> getRevenueByMonth(LocalDateTime from, LocalDateTime to);
    List<Object[]> getRevenueSummary(LocalDateTime from, LocalDateTime to);
    List<Object[]> findRevenueByCategory(LocalDateTime from, LocalDateTime to);
}