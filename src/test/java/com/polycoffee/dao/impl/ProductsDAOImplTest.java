package com.polycoffee.dao.impl;

import com.polycoffee.entity.Categories;
import com.polycoffee.entity.Products;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

import static org.junit.Assert.*;

public class ProductsDAOImplTest {

    private final ProductsDAOImpl productsDAO = new ProductsDAOImpl();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private Categories testCategory;

    @Before
    public void setUp() {
        String timeSuffix = String.valueOf(System.currentTimeMillis() % 100000);
        testCategory = Categories.builder()
                .name("Cat_" + timeSuffix)
                .description("Test Description")
                .build();
        categoryDAO.create(testCategory);
    }

    @After
    public void tearDown() {
        if (testCategory != null && testCategory.getId() != null) {
            javax.persistence.EntityManager em = com.polycoffee.utils.XJPA.createEntityManager();
            try {
                em.getTransaction().begin();
                em.createQuery("DELETE FROM Products p WHERE p.category.id = :cid")
                  .setParameter("cid", testCategory.getId())
                  .executeUpdate();
                em.getTransaction().commit();
            } finally {
                em.close();
            }
            categoryDAO.delete(testCategory.getId());
        }
    }

    @Test
    public void testCreateAndFindById() {
        String timeSuffix = String.valueOf(System.currentTimeMillis() % 100000);
        Products newProduct = Products.builder()
                .name("Prod_" + timeSuffix)
                .basePrice(BigDecimal.valueOf(50000))
                .description("A sample product")
                .category(testCategory)
                .available(true)
                .featured(false)
                .build();

        productsDAO.create(newProduct);
        assertNotNull("ID của Product phải được tự động sinh ra (UUID)", newProduct.getId());

        Products foundProduct = productsDAO.findById(newProduct.getId());
        assertNotNull("Phải tìm thấy Product vừa tạo", foundProduct);
        assertEquals(newProduct.getName(), foundProduct.getName());
        assertEquals(0, newProduct.getBasePrice().compareTo(foundProduct.getBasePrice()));

        productsDAO.delete(newProduct.getId());
    }

    @Test
    public void testUpdate() {
        String timeSuffix = String.valueOf(System.currentTimeMillis() % 100000);
        Products product = Products.builder()
                .name("U_Prd_" + timeSuffix)
                .basePrice(BigDecimal.valueOf(30000))
                .category(testCategory)
                .available(false)
                .build();

        productsDAO.create(product);

        product.setName("Updated_P_" + timeSuffix);
        product.setAvailable(true);
        productsDAO.update(product);

        Products updatedProduct = productsDAO.findById(product.getId());
        assertEquals("Updated_P_" + timeSuffix, updatedProduct.getName());
        assertTrue(updatedProduct.isAvailable());

        productsDAO.delete(product.getId());
    }

    @Test
    public void testDelete() {
        String timeSuffix = String.valueOf(System.currentTimeMillis() % 100000);
        Products product = Products.builder()
                .name("D_Prd_" + timeSuffix)
                .basePrice(BigDecimal.valueOf(45000))
                .category(testCategory)
                .build();

        productsDAO.create(product);
        UUID id = product.getId();

        productsDAO.delete(id);

        Products deletedProduct = productsDAO.findById(id);
        assertNull("Product sau khi xoá phải là null", deletedProduct);
    }

    @Test
    public void testFindByCategoryId() {
        String timeSuffix = String.valueOf(System.currentTimeMillis() % 100000);
        Products p1 = Products.builder()
                .name("CatT1_" + timeSuffix)
                .basePrice(BigDecimal.valueOf(10000))
                .category(testCategory)
                .build();
        Products p2 = Products.builder()
                .name("CatT2_" + timeSuffix)
                .basePrice(BigDecimal.valueOf(20000))
                .category(testCategory)
                .build();

        productsDAO.create(p1);
        productsDAO.create(p2);

        List<Products> list = productsDAO.findByCategoryId(testCategory.getId());
        assertNotNull(list);
        assertTrue("Category phải có ít nhất 2 products", list.size() >= 2);

        productsDAO.delete(p1.getId());
        productsDAO.delete(p2.getId());
    }

    @Test
    public void testFindByName() {
        String timeSuffix = String.valueOf(System.currentTimeMillis() % 100000);
        String uniqueName = "Uniq_" + timeSuffix;
        Products product = Products.builder()
                .name(uniqueName)
                .basePrice(BigDecimal.valueOf(15000))
                .category(testCategory)
                .build();

        productsDAO.create(product);

        List<Products> foundList = productsDAO.findByName(uniqueName);
        assertNotNull(foundList);
        assertFalse("Phải tìm thấy product theo tên", foundList.isEmpty());
        assertEquals(uniqueName, foundList.get(0).getName());

        productsDAO.delete(product.getId());
    }

    @Test
    public void testSearchAndPaginate() {
        String timeSuffix = String.valueOf(System.currentTimeMillis() % 100000);
        Products p1 = Products.builder()
                .name("S_P1_" + timeSuffix)
                .category(testCategory)
                .available(true)
                .basePrice(BigDecimal.valueOf(1000))
                .build();
        Products p2 = Products.builder()
                .name("S_P2_" + timeSuffix)
                .category(testCategory)
                .available(true)
                .basePrice(BigDecimal.valueOf(2000))
                .build();

        productsDAO.create(p1);
        productsDAO.create(p2);

        List<Products> list = productsDAO.searchAndPaginate("S_P", testCategory.getId(), true, 1, 10);
        assertNotNull(list);
        assertTrue("Kết quả search phải có ít nhất 2", list.size() >= 2);

        long count = productsDAO.countSearch("S_P", testCategory.getId(), true);
        assertTrue("Count phải >= 2", count >= 2);

        productsDAO.delete(p1.getId());
        productsDAO.delete(p2.getId());
    }
}
