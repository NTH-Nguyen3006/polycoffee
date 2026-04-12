package com.polycoffee.utils;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;

import com.polycoffee.entity.CartItems;
import com.polycoffee.entity.Carts;
import com.polycoffee.entity.OrderItem;
import com.polycoffee.entity.Orders;
import com.polycoffee.entity.Payment;
import com.polycoffee.entity.ProductOptions;
import com.polycoffee.entity.Products;
import com.polycoffee.entity.Promotion;
import com.polycoffee.entity.Users;
import com.polycoffee.enums.UserRole;

public class DataSeeder {
    private static final Random random = new Random();

    public static void main(String[] args) {
        System.out.println("Starting DataSeeder...");
        EntityManager em = XJPA.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            System.out.println("Loading existing Products...");
            List<Products> existingProducts = em.createQuery("SELECT p FROM Products p", Products.class)
                    .getResultList();

            if (existingProducts.isEmpty()) {
                System.out.println("Warning: No products found. Skipping order, cart, and option seeding.");
            }

            // 1. Seed Users (30 Users)
            System.out.println("Seeding Users...");
            List<Users> users = new java.util.ArrayList<>();
            String[] firstNames = { "Nguyễn", "Trần", "Lê", "Phạm", "Hoàng", "Huỳnh", "Phan", "Vũ", "Võ", "Đặng" };
            String[] lastNames = { "An", "Hòa", "Bình", "Anh", "Minh", "Huy", "Lan", "Hương", "Hà", "Phong" };
            for (int i = 0; i < 30; i++) {
                Users u = new Users();
                String fn = firstNames[random.nextInt(firstNames.length)] + " "
                        + lastNames[random.nextInt(lastNames.length)];
                u.setUsername("user" + i + System.currentTimeMillis());
                u.setPassword("12345");
                u.setEmail("user" + i + "@gmail.com");
                u.setFullname(fn);
                u.setPhone("09" + (10000000 + random.nextInt(89999999)));
                u.setRole(random.nextInt(10) > 8 ? UserRole.EMPLOYEE : UserRole.USER);
                u.setActive(true);
                u.setCreatedAt(LocalDateTime.now().minusDays(random.nextInt(365)));
                em.persist(u);
                users.add(u);
            }

            // 2. Seed Promotions (20 Promotions)
            System.out.println("Seeding Promotions...");
            List<Promotion> promotions = new java.util.ArrayList<>();
            String[] promoPrefix = { "SALE", "TET", "NEW", "MEGA", "COFFEE" };
            for (int i = 0; i < 20; i++) {
                Promotion p = new Promotion();
                p.setCode(promoPrefix[random.nextInt(promoPrefix.length)] + random.nextInt(9999));
                if (random.nextBoolean()) {
                    p.setDiscountType("PERCENTAGE");
                    p.setDiscountValue(BigDecimal.valueOf(10 + random.nextInt(40))); // 10% - 50%
                } else {
                    p.setDiscountType("FIXED");
                    p.setDiscountValue(BigDecimal.valueOf((1 + random.nextInt(5)) * 10000)); // 10k - 50k
                }
                p.setMinOrderValue(BigDecimal.valueOf(random.nextInt(5) * 50000));
                p.setUsageLimit(50 + random.nextInt(100));
                p.setStartDate(LocalDateTime.now().minusDays(random.nextInt(30)));
                p.setEndDate(LocalDateTime.now().plusDays(random.nextInt(60)));
                em.persist(p);
                promotions.add(p);
            }

            if (!existingProducts.isEmpty()) {
                // 3. Seed ProductOptions (30 options)
                System.out.println("Seeding ProductOptions...");
                String[] optionNames = { "Size Lớn", "Size Vừa", "Size Nhỏ", "Thêm Trân Châu", "Thêm Sữa", "Ít Đá",
                        "Nhiều Đá", "Cà Phê Đậm" };
                for (int i = 0; i < 30; i++) {
                    ProductOptions opt = new ProductOptions();
                    opt.setProduct(existingProducts.get(random.nextInt(existingProducts.size())));
                    opt.setOptionName(optionNames[random.nextInt(optionNames.length)]);
                    opt.setAdditionalPrice(BigDecimal.valueOf(random.nextInt(5) * 5000));
                    em.persist(opt);
                }

                // 4. Seed Carts and CartItems (25 carts)
                System.out.println("Seeding Carts...");
                for (int i = 0; i < 25; i++) {
                    Carts cart = new Carts();
                    cart.setUser(users.get(random.nextInt(users.size())));
                    em.persist(cart);

                    int itemsCount = 1 + random.nextInt(4);
                    for (int j = 0; j < itemsCount; j++) {
                        CartItems ci = new CartItems();
                        ci.setCart(cart);
                        ci.setProduct(existingProducts.get(random.nextInt(existingProducts.size())));
                        ci.setQuantity(1 + random.nextInt(3));
                        ci.setSubTotal(ci.getProduct().getBasePrice());
                        em.persist(ci);
                    }
                }

                // 5. Seed Orders, OrderItem, and Payment (40 Orders)
                System.out.println("Seeding Orders, OrderItems, Payments...");
                String[] statuses = { "PENDING", "PROCESSING", "COMPLETED", "COMPLETED", "COMPLETED", "CANCELLED" };
                for (int i = 0; i < 40; i++) {
                    Orders o = new Orders();
                    o.setOrderCode("ORD-" + System.currentTimeMillis() + "-" + random.nextInt(1000));
                    o.setUser(users.get(random.nextInt(users.size())));
                    o.setStatus(statuses[random.nextInt(statuses.length)]);
                    o.setCreatedAt(LocalDateTime.now().minusMonths(random.nextInt(6)).minusDays(random.nextInt(28)));
                    if (random.nextBoolean()) {
                        o.setPromotion(promotions.get(random.nextInt(promotions.size())));
                    }
                    if (random.nextBoolean()) {
                        o.setNote("Ít đá, ít đường");
                    }

                    BigDecimal totalAmount = BigDecimal.ZERO;
                    em.persist(o); // Persist early to get ID for OrderItem (if generated strategy depends on it)

                    int itemsCount = 1 + random.nextInt(5);
                    for (int j = 0; j < itemsCount; j++) {
                        OrderItem oi = new OrderItem();
                        oi.setOrder(o);
                        oi.setProduct(existingProducts.get(random.nextInt(existingProducts.size())));
                        oi.setQuantity(1 + random.nextInt(4));
                        oi.setPrice(oi.getProduct().getBasePrice());
                        em.persist(oi);

                        totalAmount = totalAmount.add(oi.getPrice().multiply(BigDecimal.valueOf(oi.getQuantity())));
                    }

                    // Simple discount calculation simulation
                    if (o.getPromotion() != null) {
                        if ("PERCENTAGE".equals(o.getPromotion().getDiscountType())) {
                            BigDecimal discount = totalAmount.multiply(o.getPromotion().getDiscountValue())
                                    .divide(BigDecimal.valueOf(100));
                            totalAmount = totalAmount.subtract(discount);
                        } else {
                            totalAmount = totalAmount.subtract(o.getPromotion().getDiscountValue());
                        }
                    }

                    if (totalAmount.compareTo(BigDecimal.ZERO) < 0)
                        totalAmount = BigDecimal.ZERO;
                    o.setTotalAmount(totalAmount);
                    em.merge(o);

                    // Payment
                    Payment pay = new Payment();
                    pay.setOrder(o);
                    pay.setPaymentMethod(random.nextBoolean() ? "CASH" : "BANK_TRANSFER");
                    pay.setAmount(totalAmount);
                    pay.setPaymentDate(o.getCreatedAt());
                    em.persist(pay);
                }
            }
            tx.commit();
            System.out.println("Data seeding completed successfully!");
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
