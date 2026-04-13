package com.polycoffee.dao.impl;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.math.BigDecimal;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.polycoffee.entity.Orders;
import com.polycoffee.entity.Users;
import com.polycoffee.enums.UserRole;

public class OrdersDAOTest {
    private final OrdersDAO ordersDAO = new OrdersDAO();
    private final UserDAO userDAO = new UserDAO();
    private Users testUser;

    @Before
    public void setUp() {
        String timeSuffix = String.valueOf(System.currentTimeMillis() % 100000);
        testUser = Users.builder()
                .username("ord_u_" + timeSuffix)
                .fullname("Test Order User")
                .email("ord_" + timeSuffix + "@t.com")
                .password("123456")
                .role(UserRole.USER)
                .active(true)
                .build();
        userDAO.create(testUser);
    }

    @After
    public void tearDown() {
        // Cleanup sau mỗi test case
        if (testUser != null && testUser.getId() != null) {
            userDAO.delete(testUser.getId());
        }
    }

    @Test
    public void testCreateAndFindById() {
        String timeSuffix = String.valueOf(System.currentTimeMillis() % 100000);
        Orders order = Orders.builder()
                .user(testUser)
                .orderCode("O_T_" + timeSuffix)
                .totalAmount(BigDecimal.valueOf(150000))
                .shippingAddress("123 Test Street")
                .status("PENDING")
                .paymentStatus("UNPAID")
                .build();

        ordersDAO.create(order);
        assertNotNull("ID của Order phải được tự động tạo", order.getId());

        Orders foundOrder = ordersDAO.findById(order.getId());
        assertNotNull("Phải tìm thấy Order vừa tạo", foundOrder);
        assertEquals(order.getOrderCode(), foundOrder.getOrderCode());
        assertEquals("PENDING", foundOrder.getStatus());

        // Dọn dẹp
        ordersDAO.delete(order.getId());
    }

    @Test
    public void testUpdate() {
        String timeSuffix = String.valueOf(System.currentTimeMillis() % 100000);
        Orders order = Orders.builder()
                .user(testUser)
                .orderCode("O_UPD_" + timeSuffix)
                .totalAmount(BigDecimal.valueOf(100000))
                .status("PENDING")
                .build();

        ordersDAO.create(order);

        // Update trạng thái
        order.setStatus("PROCESSING");
        ordersDAO.update(order);

        Orders updatedOrder = ordersDAO.findById(order.getId());
        assertEquals("PROCESSING", updatedOrder.getStatus());

        // Dọn dẹp
        ordersDAO.delete(order.getId());
    }

    @Test
    public void testDelete() {
        String timeSuffix = String.valueOf(System.currentTimeMillis() % 100000);
        Orders order = Orders.builder()
                .user(testUser)
                .orderCode("O_DEL_" + timeSuffix)
                .totalAmount(BigDecimal.valueOf(50000))
                .status("PENDING")
                .build();

        ordersDAO.create(order);
        Long orderId = order.getId();

        ordersDAO.delete(orderId);

        Orders deletedOrder = ordersDAO.findById(orderId);
        assertNull("Order sau khi xoá phải là null", deletedOrder);
    }

    @Test
    public void testFindByCode() {
        String timeSuffix = String.valueOf(System.currentTimeMillis() % 100000);
        String code = "O_F_" + timeSuffix;
        Orders order = Orders.builder()
                .user(testUser)
                .orderCode(code)
                .totalAmount(BigDecimal.valueOf(200000))
                .status("DELIVERED")
                .build();

        ordersDAO.create(order);

        Orders found = ordersDAO.findByCode(code);
        assertNotNull("Phải tìm thấy Order theo Code", found);
        assertEquals(code, found.getOrderCode());

        // Dọn dẹp
        ordersDAO.delete(order.getId());
    }

    @Test
    public void testFindByUserId() {
        String timeSuffix = String.valueOf(System.currentTimeMillis() % 100000);
        Orders order1 = Orders.builder()
                .user(testUser)
                .orderCode("O_U1_" + timeSuffix)
                .totalAmount(BigDecimal.valueOf(100000))
                .status("PENDING")
                .build();

        Orders order2 = Orders.builder()
                .user(testUser)
                .orderCode("O_U2_" + timeSuffix)
                .totalAmount(BigDecimal.valueOf(200000))
                .status("COMPLETED")
                .build();

        ordersDAO.create(order1);
        ordersDAO.create(order2);

        List<Orders> userOrders = ordersDAO.findByUserId(testUser.getId());
        assertNotNull(userOrders);
        assertTrue("User phải có ít nhất 2 order", userOrders.size() >= 2);

        // Dọn dẹp
        ordersDAO.delete(order1.getId());
        ordersDAO.delete(order2.getId());
    }

    @Test
    public void testUpdateStatus() {
        String timeSuffix = String.valueOf(System.currentTimeMillis() % 100000);
        Orders order = Orders.builder()
                .user(testUser)
                .orderCode("O_STT_" + timeSuffix)
                .totalAmount(BigDecimal.valueOf(150000))
                .status("PENDING")
                .build();

        ordersDAO.create(order);

        ordersDAO.updateStatus(order.getId(), "CANCELLED");

        Orders updatedOrder = ordersDAO.findById(order.getId());
        assertEquals("CANCELLED", updatedOrder.getStatus());

        // Dọn dẹp
        ordersDAO.delete(order.getId());
    }
}
