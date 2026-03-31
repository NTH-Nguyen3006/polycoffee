package com.polycoffee.dao.impl;

import com.polycoffee.entity.Orders;
import com.polycoffee.entity.Payment;
import com.polycoffee.entity.Users;
import com.polycoffee.enums.UserRole;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import static org.junit.Assert.*;

public class PaymentDAOImplTest {

    private final PaymentDAOImpl paymentDAO = new PaymentDAOImpl();
    private final OrdersDAO ordersDAO = new OrdersDAO();
    private final UserDAO userDAO = new UserDAO();

    private Users testUser;
    private Orders testOrder;

    @Before
    public void setUp() {
        String timeSuffix = String.valueOf(System.currentTimeMillis() % 100000);
        testUser = Users.builder()
                .username("pay_u_" + timeSuffix)
                .fullname("Payment Test User")
                .email("pay_" + timeSuffix + "@t.com")
                .password("123456")
                .role(UserRole.USER)
                .active(true)
                .build();
        userDAO.create(testUser);

        testOrder = Orders.builder()
                .user(testUser)
                .orderCode("P_O_" + timeSuffix)
                .totalAmount(BigDecimal.valueOf(250000))
                .status("PENDING")
                .build();
        ordersDAO.create(testOrder);
    }

    @After
    public void tearDown() {
        if (testOrder != null && testOrder.getId() != null) {
            ordersDAO.delete(testOrder.getId());
        }
        if (testUser != null && testUser.getId() != null) {
            userDAO.delete(testUser.getId());
        }
    }

    @Test
    public void testCreateAndFindById() {
        Payment payment = Payment.builder()
                .order(testOrder)
                .paymentMethod("VNPAY")
                .transactionId("VN_" + System.currentTimeMillis())
                .amount(BigDecimal.valueOf(250000))
                .paymentDate(LocalDateTime.now())
                .build();

        paymentDAO.create(payment);
        assertNotNull("ID của Payment phải được tự động sinh", payment.getId());

        Payment foundPayment = paymentDAO.findById(payment.getId());
        assertNotNull("Phải tìm thấy Payment vừa tạo", foundPayment);
        assertEquals("VNPAY", foundPayment.getPaymentMethod());
        assertEquals(0, payment.getAmount().compareTo(foundPayment.getAmount()));

        // Dọn dẹp
        paymentDAO.delete(payment.getId());
    }

    @Test
    public void testUpdate() {
        Payment payment = Payment.builder()
                .order(testOrder)
                .paymentMethod("COD")
                .amount(BigDecimal.valueOf(100000))
                .build();

        paymentDAO.create(payment);

        payment.setPaymentMethod("MOMO");
        paymentDAO.update(payment);

        Payment updatedPayment = paymentDAO.findById(payment.getId());
        assertEquals("MOMO", updatedPayment.getPaymentMethod());

        // Dọn dẹp
        paymentDAO.delete(payment.getId());
    }

    @Test
    public void testDelete() {
        Payment payment = Payment.builder()
                .order(testOrder)
                .paymentMethod("BANK_TRANSFER")
                .amount(BigDecimal.valueOf(50000))
                .build();

        paymentDAO.create(payment);
        Long id = payment.getId();

        paymentDAO.delete(id);

        Payment deletedPayment = paymentDAO.findById(id);
        assertNull("Payment sau khi xoá phải là null", deletedPayment);
    }
}
