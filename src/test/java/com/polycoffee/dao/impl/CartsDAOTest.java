package com.polycoffee.dao.impl;

import com.polycoffee.entity.Carts;
import com.polycoffee.entity.Users;
import com.polycoffee.enums.UserRole;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

import static org.junit.Assert.*;

public class CartsDAOTest {

    private final CartsDAO cartsDAO = new CartsDAO();
    private final UserDAO userDAO = new UserDAO();

    private Users testUser;

    @Before
    public void setUp() {
        String timeSuffix = String.valueOf(System.currentTimeMillis() % 100000);
        testUser = Users.builder()
                .username("cart_u_" + timeSuffix)
                .fullname("Cart Test User")
                .email("cart_" + timeSuffix + "@t.com")
                .password("123456")
                .role(UserRole.USER)
                .active(true)
                .build();
        userDAO.create(testUser);
    }

    @After
    public void tearDown() {
        if (testUser != null && testUser.getId() != null) {
            userDAO.delete(testUser.getId());
        }
    }

    @Test
    public void testCreateAndFindById() {
        Carts cart = Carts.builder()
                .user(testUser)
                .totalItems(2)
                .tempTotalPrice(BigDecimal.valueOf(150000))
                .build();

        cartsDAO.create(cart);
        assertNotNull("ID của Cart phải được tự động sinh (UUID)", cart.getId());

        Carts foundCart = cartsDAO.findById(cart.getId());
        assertNotNull("Phải tìm thấy Cart vừa tạo", foundCart);
        assertEquals(2, foundCart.getTotalItems());
        assertEquals(0, cart.getTempTotalPrice().compareTo(foundCart.getTempTotalPrice()));

        // Dọn dẹp
        cartsDAO.delete(cart.getId());
    }

    @Test
    public void testUpdate() {
        Carts cart = Carts.builder()
                .user(testUser)
                .totalItems(1)
                .tempTotalPrice(BigDecimal.valueOf(50000))
                .build();

        cartsDAO.create(cart);

        // Update
        cart.setTotalItems(3);
        cart.setTempTotalPrice(BigDecimal.valueOf(150000));
        cartsDAO.update(cart);

        Carts updatedCart = cartsDAO.findById(cart.getId());
        assertEquals(3, updatedCart.getTotalItems());
        assertEquals(0, BigDecimal.valueOf(150000).compareTo(updatedCart.getTempTotalPrice()));

        // Dọn dẹp
        cartsDAO.delete(cart.getId());
    }

    @Test
    public void testDelete() {
        Carts cart = Carts.builder()
                .user(testUser)
                .totalItems(5)
                .tempTotalPrice(BigDecimal.valueOf(250000))
                .build();

        cartsDAO.create(cart);
        UUID id = cart.getId();

        cartsDAO.delete(id);

        Carts deletedCart = cartsDAO.findById(id);
        assertNull("Cart sau khi xoá phải trả về null", deletedCart);
    }

    @Test
    public void testFindByUserId() {
        Carts c1 = Carts.builder()
                .user(testUser)
                .totalItems(1)
                .tempTotalPrice(BigDecimal.valueOf(10000))
                .build();
        Carts c2 = Carts.builder()
                .user(testUser)
                .totalItems(2)
                .tempTotalPrice(BigDecimal.valueOf(20000))
                .build();

        cartsDAO.create(c1);
        cartsDAO.create(c2);

        List<Carts> userCarts = cartsDAO.findByUserId(testUser.getId());
        assertNotNull(userCarts);
        assertTrue("User phải có ít nhất 2 carts", userCarts.size() >= 2);

        // Dọn dẹp
        cartsDAO.delete(c1.getId());
        cartsDAO.delete(c2.getId());
    }
}
